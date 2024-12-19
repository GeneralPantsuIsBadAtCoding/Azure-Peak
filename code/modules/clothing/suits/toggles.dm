//Hoods for winter coats and chaplain hoodie etc


/obj/item/clothing
	var/obj/item/clothing/head/hooded/hood
	var/hoodtype
	var/hoodtoggled = FALSE
	var/adjustable = CANT_CADJUST

/obj/item/clothing/Initialize()
	. = ..()
	if(hoodtype)
		MakeHood()

/obj/item/clothing/Destroy()
	. = ..()
	if(hoodtype)
		qdel(hood)
		hood = null

/obj/item/clothing/proc/MakeHood()
	if(!hood)
		var/obj/item/clothing/head/hooded/W = new hoodtype(src)
		W.moveToNullspace()
		W.color = color
		W.connectedc = src
		hood = W

/obj/item/clothing/attack_right(mob/user)
	if(hoodtype)
		ToggleHood()
	if(adjustable > 0)
		if(loc == user)
			AdjustClothes(user)

/obj/item/clothing/proc/AdjustClothes(mob/user)
	return //override this in the clothing item itself so we can update the right inv

/obj/item/clothing/proc/ResetAdjust(mob/user)
	adjustable = initial(adjustable)
	icon_state = "[initial(icon_state)]"
	slowdown = initial(slowdown)
	body_parts_covered = initial(body_parts_covered)
	flags_inv = initial(flags_inv)
	flags_cover = initial(flags_cover)
	block2add = initial(block2add)

/*
/obj/item/clothing/ui_action_click()
	. = ..()
	if(hoodtype)
		ToggleHood()

/obj/item/clothing/item_action_slot_check(slot, mob/user)
	if(slot == SLOT_ARMOR|SLOT_CLOAK)
		return 1
*/
/obj/item/clothing/equipped(mob/user, slot)
	if(hoodtype && slot != SLOT_ARMOR|SLOT_CLOAK)
		RemoveHood()
	if(adjustable > 0)
		ResetAdjust(user)
	..()

/obj/item/clothing/proc/RemoveHood()
	if(!hood)
		return
	src.icon_state = "[initial(icon_state)]"
	hoodtoggled = FALSE
	if(ishuman(hood.loc))
		var/mob/living/carbon/H = hood.loc
		H.transferItemToLoc(hood, src, TRUE)
		hood.moveToNullspace()
		H.update_inv_wear_suit()
		H.update_inv_cloak()
		H.update_inv_neck()
		H.update_inv_pants()
		H.update_fov_angles()
	else
//		hood.forceMove(src)
		hood.moveToNullspace()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/dropped()
	..()
	if(hoodtype)
		RemoveHood()
	if(adjustable > 0)
		ResetAdjust()

/obj/item/clothing/proc/ToggleHood()
	if(!hoodtoggled)
		if(ishuman(src.loc))
			var/mob/living/carbon/human/H = src.loc
			if(hood.color != color)
				hood.color = color
			if(slot_flags == ITEM_SLOT_ARMOR)
				if(H.wear_armor != src)
					to_chat(H, span_warning("I should put that on first."))
					return
			if(slot_flags == ITEM_SLOT_CLOAK)
				if(H.cloak != src)
					to_chat(H, span_warning("I should put that on first."))
					return
			if(H.head)
				to_chat(H, span_warning("I'm already wearing something on my head."))
				return
			else if(H.equip_to_slot_if_possible(hood,SLOT_HEAD,0,0,1))
				testing("begintog")
				hoodtoggled = TRUE
				if(toggle_icon_state)
					src.icon_state = "[initial(icon_state)]_t"
				H.update_inv_wear_suit()
				H.update_inv_cloak()
				H.update_inv_neck()
				H.update_inv_pants()
				H.update_fov_angles()
//				for(var/X in actions)
//					var/datum/action/A = X
//					A.UpdateButtonIcon()
	else
		RemoveHood()
	testing("endtoggle")


/obj/item/clothing/head/hooded
	var/obj/item/clothing/connectedc
	dynamic_hair_suffix = ""
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi'

/obj/item/clothing/head/hooded/Destroy()
	connectedc = null
	return ..()

/obj/item/clothing/head/hooded/attack_right(mob/user)
	if(connectedc)
		connectedc.ToggleHood()

/obj/item/clothing/head/hooded/dropped()
	..()
	if(connectedc)
		connectedc.RemoveHood()

/obj/item/clothing/head/hooded/equipped(mob/user, slot)
	..()
	if(slot != SLOT_HEAD)
		if(connectedc)
			connectedc.RemoveHood()
		else
			qdel(src)

//Toggle exosuits for different aesthetic styles (hoodies, suit jacket buttons, etc)

/obj/item/clothing/suit/toggle/AltClick(mob/user)
	..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	else
		suit_toggle(user)

/obj/item/clothing/suit/toggle/ui_action_click()
	suit_toggle()

/obj/item/clothing/suit/toggle/proc/suit_toggle()
	set src in usr

	if(!can_use(usr))
		return 0

	to_chat(usr, span_notice("I toggle [src]'s [togglename]."))
	if(src.hoodtoggled)
		src.icon_state = "[initial(icon_state)]"
		src.hoodtoggled = FALSE
	else if(!src.hoodtoggled)
		if(toggle_icon_state)
			src.icon_state = "[initial(icon_state)]_t"
		src.hoodtoggled = TRUE
	usr.update_inv_wear_suit()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/suit/toggle/examine(mob/user)
	. = ..()
	. += "Alt-click on [src] to toggle the [togglename]."
