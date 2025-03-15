/obj/item/dwarvenpen
	name = "dwarven pen"
	desc = "A masterfully crafted dwarven pen that can capture images from another realm and transfer them onto canvas. The dwarves claim it's powered by ancient runes, but it's probably just advanced technology."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "dwarvenpen"
	gripped_intents = list(INTENT_GENERIC)
	w_class = WEIGHT_CLASS_NORMAL
	force = 5
	throwforce = 5
	throw_range = 5
	var/lastimagechange = 0
	var/loaded = TRUE
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/dwarvenpen/Initialize()
	. = ..()
	update_icon()

/obj/item/dwarvenpen/update_icon()
	icon_state = "dwarvenpen[loaded ? "" : "0"]"

/obj/item/dwarvenpen/attackby(obj/item/P, mob/user, params)
	if(!loaded)
		if(istype(P, /obj/item/roguecoin/copper))
			loaded = TRUE
			qdel(P)
			update_icon()
			playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("You insert a copper coin into the pen. It's ready to use again."))
			return
	. = ..()

/obj/item/dwarvenpen/attack_self(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	
	if(lastimagechange)
		if(world.time < lastimagechange + 3 MINUTES)
			say("NOT YET! The pen needs time to recharge its magic.")
			return
	
	if(!loaded)
		say("ONE COIN, A COPPER COIN FOR A MASTERPIECE!")
		return
	
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	var/infile = input(user, "CHOOSE AN IMAGE", src) as null|file
	
	if(!infile)
		return
	
	if(!loaded)
		return
	
	var/filename = "[infile]"
	var/file_ext = lowertext(copytext(filename, -4))
	var/file_size = length(infile)
	
	if(file_ext != ".png" && file_ext != ".jpg" && file_ext != "jpeg")
		to_chat(user, span_warning("IMAGE MUST BE PNG OR JPG FORMAT."))
		return
	
	if(file_size > 2097152) // 2MB limit
		to_chat(user, span_warning("TOO BIG. 2 MEGS OR LESS."))
		return
	
	lastimagechange = world.time
	
	// Create the canvas painting with the uploaded image
	var/obj/item/rogue/painting/custom/P = new(get_turf(user))
	P.custom_creator = user.ckey
	P.name = "dwarven painting"
	P.image_file = infile
	P.process_image()
	
	// Set the painting's description
	var/painting_name = input(user, "Name your masterpiece:", "Painting Name") as text|null
	if(painting_name)
		P.name = painting_name
	
	var/painting_desc = input(user, "Describe your masterpiece:", "Painting Description") as text|null
	if(painting_desc)
		P.desc = painting_desc
	else
		P.desc = "A beautiful painting created with a dwarven pen. The artistry is exquisite."
	
	// Put the painting in the user's hands
	user.put_in_hands(P)
	to_chat(user, span_notice("The dwarven pen hums with energy as it transfers your image onto a canvas."))
	
	loaded = FALSE
	update_icon()
	playsound(loc, 'sound/misc/beep.ogg', 50, TRUE)

// Custom painting object that can display uploaded images
/obj/item/rogue/painting/custom
	name = "custom painting"
	desc = "A beautiful painting created with a dwarven pen."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "painting"
	var/custom_creator = null
	var/image_file = null
	deployed_structure = /obj/structure/fluff/walldeco/painting/custom

/obj/item/rogue/painting/custom/Initialize()
	. = ..()
	if(image_file)
		process_image()

/obj/item/rogue/painting/custom/proc/process_image()
	if(image_file)
		var/icon/I = new(image_file)
		// Scale the image to fit the painting dimensions
		I.Scale(32, 32)
		// Add a canvas-like border
		var/icon/border = new('icons/roguetown/items/misc.dmi', "painting_border")
		I.Blend(border, ICON_OVERLAY)
		// Set the icon to the blended image
		icon = I

/obj/structure/fluff/walldeco/painting/custom
	name = "custom painting"
	desc = "A beautiful painting created with a dwarven pen."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "painting_deployed"
	stolen_painting = /obj/item/rogue/painting/custom
	var/custom_creator = null
	var/image_file = null

/obj/structure/fluff/walldeco/painting/custom/Initialize()
	. = ..()
	if(image_file)
		process_image()

/obj/structure/fluff/walldeco/painting/custom/proc/process_image()
	if(image_file)
		var/icon/I = new(image_file)
		// Scale the image to fit the wall painting dimensions
		I.Scale(32, 32)
		// Add a canvas-like border for the wall version
		var/icon/border = new('icons/roguetown/items/misc.dmi', "painting_deployed_border")
		I.Blend(border, ICON_OVERLAY)
		// Set the icon to the blended image
		icon = I

/obj/item/rogue/painting/custom/attack_turf(turf/T, mob/living/user)
	if(isclosedturf(T))
		if(get_dir(T,user) in GLOB.cardinals)
			to_chat(user, span_warning("You place [src] on the wall."))
			var/obj/structure/fluff/walldeco/painting/custom/S = new deployed_structure(user.loc)
			S.custom_creator = custom_creator
			S.name = name
			S.desc = desc
			S.image_file = image_file
			S.process_image()
			switch(get_dir(T,user))
				if(NORTH)
					S.pixel_y = -32
				if(SOUTH)
					S.pixel_y = 32
				if(WEST)
					S.pixel_x = 32
				if(EAST)
					S.pixel_x = -32
			qdel(src)
			return
	..() 
