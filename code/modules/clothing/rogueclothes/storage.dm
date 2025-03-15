/obj/item/storage/belt/rogue
	name = ""
	desc = ""
	icon = 'icons/roguetown/clothing/belts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/belts.dmi'
	icon_state = ""
	item_state = ""
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("whips", "lashes")
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	content_overlays = FALSE
	bloody_icon_state = "bodyblood"
	experimental_inhand = FALSE
	component_type = /datum/component/storage/concrete/roguetown/belt
	grid_width = 64
	grid_height = 64

/obj/item/storage/belt/rogue/attack_right(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		CP.rmb_show(user)
		return TRUE
	..()

/obj/item/storage/belt/rogue/leather
	name = "belt"
	desc = ""
	icon_state = "leather"
	item_state = "leather"
	equip_sound = 'sound/blank.ogg'
	sewrepair = TRUE
	resistance_flags = FIRE_PROOF

/obj/item/storage/belt/rogue/leather/plaquegold
	name = "plaque belt"
	icon_state = "goldplaque"
	sellprice = 50
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/storage/belt/rogue/leather/shalal
	name = "shalal belt"
	icon_state = "shalal"
	sellprice = 5

/obj/item/storage/belt/rogue/leather/black
	name = "black belt"
	icon_state = "blackbelt"
	sellprice = 10

/obj/item/storage/belt/rogue/leather/plaquesilver
	name = "plaque belt"
	icon_state = "silverplaque"
	sellprice = 30
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/storage/belt/rogue/leather/steel
	name = "steel belt"
	icon_state = "steelplaque"
	sellprice = 30
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/storage/belt/rogue/leather/rope
	name = "rope belt"
	desc = ""
	icon_state = "rope"
	item_state = "rope"
	color = "#b9a286"

/obj/item/storage/belt/rogue/leather/cloth
	name = "cloth sash"
	desc = ""
	icon_state = "cloth"

/obj/item/storage/belt/rogue/leather/cloth/lady
	color = "#575160"

/obj/item/storage/belt/rogue/leather/cloth/bandit
	color = "#ff0000"

/obj/item/storage/belt/rogue/pouch
	name = "pouch"
	desc = ""
	icon = 'icons/roguetown/clothing/storage.dmi'
	mob_overlay_icon = null
	icon_state = "pouch"
	item_state = "pouch"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("whips", "lashes")
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	content_overlays = FALSE
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE
	resistance_flags = FIRE_PROOF
	grid_height = 64
	grid_width = 32
	component_type = /datum/component/storage/concrete/roguetown/coin_pouch

/obj/item/storage/belt/rogue/pouch/coins

/obj/item/storage/belt/rogue/pouch/coins/mid/Initialize()
	. = ..()
	var/obj/item/roguecoin/silver/pile/H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	var/obj/item/roguecoin/copper/pile/C = new(loc)
	if(istype(C))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, C, null, TRUE, TRUE))
			qdel(C)

/obj/item/storage/belt/rogue/pouch/coins/poor/Initialize()
	. = ..()
	var/obj/item/roguecoin/copper/pile/H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	if(prob(50))
		H = new(loc)
		if(istype(H))
			if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
				qdel(H)

/obj/item/storage/belt/rogue/pouch/coins/rich/Initialize()
	. = ..()
	var/obj/item/roguecoin/silver/pile/H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	if(prob(50))
		H = new(loc)
		if(istype(H))
			if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
				qdel(H)

/obj/item/storage/belt/rogue/pouch/coins/virtuepouch/Initialize()
	. = ..()
	var/obj/item/roguecoin/gold/virtuepile/H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)

/obj/item/storage/belt/rogue/pouch/food/PopulateContents()
	new /obj/item/reagent_containers/food/snacks/rogue/crackerscooked(src)

/obj/item/storage/backpack/rogue/satchel
	name = "satchel"
	desc = ""
	icon_state = "satchel"
	item_state = "satchel"
	icon = 'icons/roguetown/clothing/storage.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FIRE_PROOF
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	alternate_worn_layer = UNDER_CLOAK_LAYER
	sewrepair = TRUE
	component_type = /datum/component/storage/concrete/roguetown/satchel

/obj/item/storage/backpack/rogue/satchel/heartfelt
	populate_contents = list(
		/obj/item/natural/feather,
		/obj/item/paper,
	)

/obj/item/storage/backpack/rogue/satchel/mule/PopulateContents()
	for(var/i in 1 to 3)
		switch(rand(1,4))
			if(1)
				new /obj/item/reagent_containers/powder/moondust_purest(src)
			if(2)
				new /obj/item/reagent_containers/powder/moondust_purest(src)
			if(3)
				new /obj/item/reagent_containers/powder/ozium(src)
			if(4)
				new /obj/item/reagent_containers/powder/spice(src)

/obj/item/storage/backpack/rogue/satchel/black
	color = CLOTHING_BLACK

/obj/item/storage/backpack/rogue/attack_right(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		CP.rmb_show(user)
		return TRUE


/obj/item/storage/backpack/rogue/backpack
	name = "backpack"
	desc = ""
	icon_state = "backpack"
	item_state = "backpack"
	icon = 'icons/roguetown/clothing/storage.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK_L
	resistance_flags = FIRE_PROOF
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE
	component_type = /datum/component/storage/concrete/roguetown/backpack

/obj/item/storage/backpack/rogue/artibackpack
	name = "Cooling backpack"
	desc = "A leather backpack with complex pipework coursing through it. It hums and vibrates constantly."
	icon_state = "artibackpack"
	item_state = "artibackpack" 
	icon = 'icons/roguetown/clothing/storage.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK_L
	resistance_flags = FIRE_PROOF
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	sewrepair = FALSE
	component_type = /datum/component/storage/concrete/roguetown/backpack

/obj/item/storage/belt/rogue/leather/plaquegold/steward
	name = "fancy gold belt"
	desc = "A dark belt with real gold making up the buckle and highlights. How bougie."
	icon_state = "stewardbelt"
	item_state = "stewardbelt"

//Knifeblade belts, act as quivers mixed with belts. Lower storage size of a belt, but holds knives without taking space.
/obj/item/storage/belt/rogue/leather/knifebelt
	name = "tossblade belt"
	desc = "A five-slotted belt meant for tossblades. Little room left over."
	icon_state = "knife"
	item_state = "knife"
	strip_delay = 20
	var/max_storage = 5			//Javelin bag is 4 and they can't hold items. So, more fair having it like this since these are pretty decent weapons.
	var/list/knives = list()
	sewrepair = TRUE
	component_type = /datum/component/storage/concrete/roguetown/belt/knife_belt

/obj/item/storage/belt/rogue/leather/knifebelt/attack_turf(turf/T, mob/living/user)
	if(knives.len >= max_storage)
		to_chat(user, span_warning("Your [src.name] is full!"))
		return
	to_chat(user, span_notice("You begin to gather the ammunition..."))
	for(var/obj/item/rogueweapon/huntingknife/throwingknife/K in T.contents)
		if(do_after(user, 5))
			if(!eatknife(K))
				break

/obj/item/storage/belt/rogue/leather/knifebelt/proc/eatknife(obj/A)
	if(A.type in subtypesof(/obj/item/rogueweapon/huntingknife/throwingknife))
		if(knives.len < max_storage)
			A.forceMove(src)
			knives += A
			update_icon()
			return TRUE
		else
			return FALSE

/obj/item/storage/belt/rogue/leather/knifebelt/attackby(obj/A, loc, params)
	if(A.type in subtypesof(/obj/item/rogueweapon/huntingknife/throwingknife))
		if(knives.len < max_storage)
			if(ismob(loc))
				var/mob/M = loc
				M.doUnEquip(A, TRUE, src, TRUE, silent = TRUE)
			else
				A.forceMove(src)
			knives += A
			update_icon()
			to_chat(usr, span_notice("I discreetly slip [A] into [src]."))
		else
			to_chat(loc, span_warning("Full!"))
		return
	..()

/obj/item/storage/belt/rogue/leather/knifebelt/attack_right(mob/user)
	if(knives.len)
		var/obj/O = knives[knives.len]
		knives -= O
		O.forceMove(user.loc)
		user.put_in_hands(O)
		update_icon()
		return TRUE

/obj/item/storage/belt/rogue/leather/knifebelt/examine(mob/user)
	. = ..()
	if(knives.len)
		. += span_notice("[knives.len] inside.")

/obj/item/storage/belt/rogue/leather/knifebelt/iron/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/iron/K = new()
		knives += K
	update_icon()

/obj/item/storage/belt/rogue/leather/knifebelt/black
	icon_state = "blackknife"
	item_state = "blackknife"

/obj/item/storage/belt/rogue/leather/knifebelt/black/iron/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/iron/K = new()
		knives += K
	update_icon()

/obj/item/storage/belt/rogue/leather/knifebelt/black/steel/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/steel/K = new()
		knives += K
	update_icon()

/obj/item/storage/belt/rogue/leather/knifebelt/black/psydon/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/psydon/K = new()
		knives += K
	update_icon()

/obj/item/storage/belt/rogue/leather/exoticsilkbelt
	name = "exotic silk belt"
	desc = "A gold adorned belt with the softest of silks barely concealing one's bits."
	icon_state = "exoticsilkbelt"
	var/max_storage = 5
	sewrepair = TRUE
