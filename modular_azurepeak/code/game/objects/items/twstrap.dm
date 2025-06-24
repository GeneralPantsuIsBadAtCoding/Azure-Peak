/obj/item/twstrap
	name = "bandolier"
	desc = ""
	icon_state = "twstrap0"
	item_state = "twstrap"
	icon = 'modular_azurepeak/icons/obj/items/twstrap.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FIRE_PROOF
	equip_delay_self = 5 SECONDS
	unequip_delay_self = 5 SECONDS
	max_integrity = 0
	sellprice = 15
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	alternate_worn_layer = UNDER_CLOAK_LAYER
	strip_delay = 20
	var/max_storage = 5
	var/list/tweps = list()
	sewrepair = TRUE

/obj/item/twstrap/attackby(obj/A, mob/living/carbon/user, params)
	if(istype(A, /obj/item/throwing_star) || istype(A, /obj/item/rogueweapon/huntingknife))
		if(tweps.len < max_storage)
			user.transferItemToLoc(A, tweps)
			tweps += A
			update_icon()
		else
			to_chat(loc, span_warning("Full!"))
		return
	..()

/obj/item/twstrap/attack_right(mob/user)
	if(tweps.len)
		if(user.get_skill_level(/datum/skill/combat/knives)<2)
			if(do_after(user, 20, target = user)) //Limits those not skilled in knives from using it properly
				to_chat(user, span_notice("You fumble to draw a throwing weapon..."))
				var/obj/O = tweps[tweps.len]
				tweps -= O
				user.put_in_active_hand(O, user.active_hand_index)
				update_icon()
		else
			var/obj/O = tweps[tweps.len]
			tweps -= O
			user.put_in_active_hand(O, user.active_hand_index)
			update_icon()
		return TRUE

/obj/item/twstrap/examine(mob/user)
	. = ..()
	if(tweps.len)
		. += span_notice("[tweps.len] inside.")

/obj/item/twstrap/update_icon()
	switch(tweps.len)
		if(1)
			icon_state = "twstrap1"
		if(2)
			icon_state = "twstrap2"
		if(3)
			icon_state = "twstrap3"
		if(4)
			icon_state = "twstrap4"
		if(5)
			icon_state = "twstrap5"
		else
			icon_state = "twstrap0"

/obj/item/twstrap/Initialize()
	. = ..()
