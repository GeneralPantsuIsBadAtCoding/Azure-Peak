/obj/machinery/gear_painter
	name = "Dye Station"
	desc = "A station to give your apparel a fresh new color! Recommended to use with white items for best results."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "dyestation"
	density = TRUE
	anchored = TRUE
	var/atom/movable/inserted
	var/activecolor = "#FFFFFF"
	/// Allow holder'd mobs
	var/allow_mobs = TRUE

	var/list/allowed_types = list(
			/obj/item/clothing,
			/obj/item/storage,
			/obj/item/bedroll
			)

	var/static/list/selectable_colors = list(
		"White" = "#ffffff",
		"Black" = "#414143",
		"Light Grey" = "#999999",
		"Dark Grey" = "#505050",
		"Mage Grey" = "#6c6c6c",
		"Mage Red" = "#b8252c",
		"Mage Blue" = "#4756d8",
		"Mage Yellow" = "#c1b144",
		"Mage Green" = "#759259",
		"Chalk White" = "#f4ecde",
		"Dunked in Water" = "#bbbbbb",
		"Cream" = "#fffdd0",
		"Orange" = "#bd6606",
		"Gold" = "#f9a602",
		"Yarrow" = "#f0cb76",
		"Yellow Weld" = "#f4c430",
		"Yellow Ochre" = "#cb9d06",
		"Baby Puke" = "#b5b004",
		"Olive" = "#98bf64",
		"Green" = "#428138",
		"Dark Green" = "#264d26",
		"Teal" = "#249589",
		"Periwinkle Blue" = "#8f99fb",
		"Woad Blue" = "#597fb9",
		"Royal Purple" = "#8747b1",
		"Magenta" = "#962e5c",
		"Orchil" = "#66023C",
		"Red Ochre" = "#913831",
		"Red" = "#a32121",
		"Maroon" = "#550000",
		"Peasant Brown" = "#685542",
		"Dirt" = "#7c6d5c",
		"Chestnut" = "#613613",
		"Russet" = "#7f461b"
		)
		
/obj/machinery/gear_painter/Destroy()
	inserted.forceMove(drop_location())
	return ..()

/obj/machinery/gear_painter/attackby(obj/item/I, mob/living/user)
	if(allow_mobs && istype(I, /obj/item/clothing/head/mob_holder))
		var/obj/item/clothing/head/mob_holder/H = I
		if(inserted)
			to_chat(user, span_warning("Something is already inside!"))
			return
		if(!user.transferItemToLoc(I, src))
			to_chat(user, span_warning("[I] is stuck to your hand!"))
			return
		if(!QDELETED(H))
			H.release()

	if(is_type_in_list(I, allowed_types) && is_operational())
		if(inserted)
			to_chat(user, span_warning("Something is already inside!"))
			return
		if(!user.transferItemToLoc(I, src))
			to_chat(user, span_warning("[I] is stuck to your hand!"))
			return
		user.visible_message("<span class='notice'>[user] inserts [I] into [src]'s receptable.</span>")

		inserted = I
		ui_interact(user)
	else
		return ..()

/obj/machinery/gear_painter/AllowDrop()
	return FALSE

/obj/machinery/gear_painter/attack_hand(mob/living/user)
	ui_interact(user)

/obj/machinery/gear_painter/ui_interact(mob/user)
	if(!is_operational())
		return ..()
	user.set_machine(src)
	var/list/dat = list("<TITLE>Dye Bin</TITLE><BR>")
	if(!inserted)
		dat += "No item inserted."
	else
		dat += "Item inserted: [inserted]<HR>"
		dat += "<A href='?src=\ref[src];select=1'>Select new color.</A><BR>"
		dat += "Color: <font color='[activecolor]'>&#9899;</font>"
		dat += "<A href='?src=\ref[src];paint=1'>Apply new color.</A><BR><BR>"
		dat += "<A href='?src=\ref[src];clear=1'>Remove paintjob.</A><BR><BR>"
		dat += "<A href='?src=\ref[src];eject=1'>Eject item.</A><BR><BR>"

	var/datum/browser/menu = new(user, "colormate","Dye Station", 400, 400, src)
	menu.set_content(dat.Join(""))
	menu.open()

/obj/machinery/gear_painter/Topic(href, href_list)
	if(!(. = ..()))
		return

	add_fingerprint(usr)

	if(href_list["close"])
		usr << browse(null, "window=colormate")
		return

	if(href_list["select"])
		var/choice = input(usr,"Choose your dye:","Dyes",null) as null|anything in selectable_colors
		if(!choice)
			return
		activecolor = selectable_colors[choice]
		updateUsrDialog()

	if(href_list["paint"])
		if(!inserted)
			return
		inserted.add_atom_colour(activecolor, FIXED_COLOUR_PRIORITY)
		playsound(src, "bubbles", 50, 1)
		updateUsrDialog()

	if(href_list["clear"])
		if(!inserted)
			return
		inserted.remove_atom_colour(FIXED_COLOUR_PRIORITY)
		playsound(src, "bubbles", 50, 1)
		updateUsrDialog()

	if(href_list["eject"])
		if(!inserted)
			return
		inserted.forceMove(drop_location())
		inserted = null
		updateUsrDialog()
