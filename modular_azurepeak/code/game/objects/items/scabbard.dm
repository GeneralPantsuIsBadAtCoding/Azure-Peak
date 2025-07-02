/obj/item/scabbard
	name = "scabbard"
	desc = ""

	icon = 'modular_azurepeak/icons/obj/items/scabbard.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	icon_state = "simplescabbard"
	item_state = "simplescabbard"

	parrysound = "parrywood"
	attacked_sound = "parrywood"

	anvilrepair = /datum/skill/craft/blacksmithing
	force = 7
	max_integrity = 100
	sellprice = 3

	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK
	possible_item_intents = list(SHIELD_BASH)
	sharpness = IS_BLUNT
	wlength = WLENGTH_SHORT
	resistance_flags = FLAMMABLE
	blade_dulling = DULLING_BASHCHOP
	w_class = WEIGHT_CLASS_BULKY
	alternate_worn_layer = UNDER_CLOAK_LAYER
	equip_delay_self = 2 SECONDS
	unequip_delay_self = 2 SECONDS
	experimental_onhip = TRUE
	experimental_onback = TRUE

	COOLDOWN_DECLARE(shield_bang)

	var/obj/item/rogueweapon/sword/valid_sword = /obj/item/rogueweapon/sword
	var/obj/item/rogueweapon/sword/sheathed
	var/sheathe_time = 0.1 SECONDS


/obj/item/scabbard/Initialize()
	..()
	update_icon()

/obj/item/scabbard/attack_turf(turf/T, mob/living/user)
	to_chat(user, span_notice("I search for my sword..."))
	for(var/obj/item/rogueweapon/sword/sword in T.contents)
		if(eatsword(user, sword))
			break
	
	..()


/obj/item/scabbard/proc/eatsword(mob/living/user, obj/A)
	if(obj_broken)
		user.visible_message(
			span_warning("[user] begins to force [A] into [src]!"),
			span_warningbig("I begin to force [A] into [src].")
		)
		if(!do_after(user, 2 SECONDS))
			return FALSE
	if(!istype(A, valid_sword))
		to_chat(user, span_warning("[A] won't fit in there.."))
		return FALSE
	if(sheathed)
		to_chat(user, span_warning("The sheath is occupied!"))
		return FALSE
	if(!do_after(user, sheathe_time))
		return FALSE

	A.forceMove(src)
	sheathed = A
	update_icon()

	user.visible_message(
		span_notice("[user] sheathes [A] into [src]."),
		span_notice("I sheathe [A] into [src].")
	)
	return TRUE


/obj/item/scabbard/proc/pukesword(mob/living/user)
	if(!sheathed)
		return FALSE

	if(obj_broken)
		user.visible_message(
			span_warning("[user] begins to force [sheathed] out of [src]!"),
			span_warningbig("I begin to force [sheathed] out of [src].")
		)
		if(!do_after(user, 2 SECONDS))
			return FALSE
	if(!do_after(user, sheathe_time))
		return FALSE
	
	sheathed.forceMove(user.loc)
	user.put_in_hands(sheathed)
	sheathed = null
	update_icon()

	user.visible_message(
		span_warning("[user] draws out of [src]!"),
		span_notice("I draw out of [src].")
	)
	return TRUE


/obj/item/scabbard/attack_right(mob/user)
	..()

	if(sheathed)
		pukesword(user)

/obj/item/scabbard/attackby(obj/item/I, mob/user, params)
	..()

	if(istype(I, valid_sword))
		eatsword(user, I)

/obj/item/scabbard/examine(mob/user)
	..()

	if(sheathed)
		. += span_notice("The sheath is occupied by [sheathed].")


/obj/item/scabbard/update_icon()
	if(sheathed)
		icon_state = "[initial(icon_state)]1"
	else
		icon_state = "[initial(icon_state)]0"
	
	getonmobprop(tag)


/obj/item/scabbard/getonmobprop(tag)
	..()

	if(tag)
		switch(tag)
			if("gen")
				return list(
					"shrink" = 0.6,
					"sx" = -6,
					"sy" = -1,
					"nx" = 6,
					"ny" = -1,
					"wx" = 0,
					"wy" = -2,
					"ex" = 0,
					"ey" = -2,
					"northabove" = 0,
					"southabove" = 1,
					"eastabove" = 1,
					"westabove" = 0,
					"nturn" = 0,
					"sturn" = 0,
					"wturn" = 0,
					"eturn" = 0,
					"nflip" = 1,
					"sflip" = 0,
					"wflip" = 1,
					"eflip" = 0
				)
			if("onback")
				return list(
					"shrink" = 0.5,
					"sx" = 1,
					"sy" = 4,
					"nx" = 1,
					"ny" = 2,
					"wx" = 3,
					"wy" = 3,
					"ex" = 0,
					"ey" = 2,
					"nturn" = 0,
					"sturn" = 0,
					"wturn" = 0,
					"eturn" = 0,
					"nflip" = 8,
					"sflip" = 0,
					"wflip" = 0,
					"eflip" = 0,
					"northabove" = 1,
					"southabove" = 0,
					"eastabove" = 0,
					"westabove" = 0
				)
			if("onbelt") 
				return list(
					"shrink" = 0.5,
					"sx" = -2,
					"sy" = -5,
					"nx" = 4,
					"ny" = -5,
					"wx" = 0,
					"wy" = -5,
					"ex" = 2,
					"ey" = -5,
					"nturn" = 0,
					"sturn" = 0,
					"wturn" = 0,
					"eturn" = 0,
					"nflip" = 0,
					"sflip" = 0,
					"wflip" = 0,
					"eflip" = 0,
					"northabove" = 0,
					"southabove" = 1,
					"eastabove" = 1,
					"westabove" = 1
				)


/*
	DAGGER SHEATHS
*/


/obj/item/scabbard/sheath
	name = "dagger sheath"
	desc = "A slingable sheath made of leather, meant to host surprises in smaller sizes."
	sewrepair = TRUE

	icon_state = "sheath"
	item_state = "sheath"

	valid_sword = /obj/item/rogueweapon/huntingknife
	w_class = WEIGHT_CLASS_NORMAL

	grid_width = 32
	grid_height = 96


/obj/item/scabbard/sheath/getonmobprop(tag)
	..()

	if(tag)
		switch(tag)
			if("gen")
				return list(
					"shrink" = 0.5,
					"sx" = -6,
					"sy" = -1,
					"nx" = 6,
					"ny" = -1,
					"wx" = 0,
					"wy" = -2,
					"ex" = 0,
					"ey" = -2,
					"northabove" = 0,
					"southabove" = 1,
					"eastabove" = 1,
					"westabove" = 0,
					"nturn" = 0,
					"sturn" = 0,
					"wturn" = 0,
					"eturn" = 0,
					"nflip" = 1,
					"sflip" = 1,
					"wflip" = 1,
					"eflip" = 0
				)
			if("onback")
				return list(
					"shrink" = 0.4,
					"sx" = -3,
					"sy" = -1,
					"nx" = 0,
					"ny" = 0,
					"wx" = -4,
					"wy" = 0,
					"ex" = 2,
					"ey" = 1,
					"northabove" = 0,
					"southabove" = 1,
					"eastabove" = 1,
					"westabove" = 0,
					"nturn" = 0,
					"sturn" = 10,
					"wturn" = 32,
					"eturn" = -23,
					"nflip" = 0,
					"sflip" = 8,
					"wflip" = 8,
					"eflip" = 0
				)
			if("onbelt") 
				return list(
					"shrink" = 0.5,
					"sx" = -2,
					"sy" = -5,
					"nx" = 4,
					"ny" = -5,
					"wx" = 0,
					"wy" = -5,
					"ex" = 2,
					"ey" = -5,
					"nturn" = 0,
					"sturn" = 0,
					"wturn" = 0,
					"eturn" = 0,
					"nflip" = 0,
					"sflip" = 0,
					"wflip" = 0,
					"eflip" = 0,
					"northabove" = 0,
					"southabove" = 1,
					"eastabove" = 1,
					"westabove" = 1
				)


/*
	GENERIC SCABBARDS
*/


/obj/item/scabbard/sword
	name = "simple scabbard"
	desc = "The natural evolution to the advent of longblades."

	icon_state = "scabbard"
	item_state = "scabbard"

	sewrepair = TRUE

/obj/item/scabbard/sword/update_icon()
	..()

	if(istype(sheathed, /obj/item/rogueweapon/sword/short) || istype(sheathed,/obj/item/rogueweapon/sword/iron/short))
		icon_state += "_ssword"
	if(istype(sheathed, /obj/item/rogueweapon/sword/rapier))
		icon_state += "_rapier"
	if(istype(sheathed, /obj/item/rogueweapon/sword/decorated))
		icon_state += "_dsword"
	if(istype(sheathed, /obj/item/rogueweapon/sword/rapier/dec))
		icon_state += "_drapier"


/*
	KAZENGUN
*/


/obj/item/scabbard/mulyeog //Empty scabbard.
	name = "simple kazengun scabbard"
	desc = "A piece of steel lined with wood. Great for batting away blows."
	icon_state = "simplescab"
	item_state = "simplescab"
	valid_sword = /obj/item/rogueweapon/sword/sabre/mulyeog

	associated_skill = /datum/skill/combat/shields
	possible_item_intents = list(SHIELD_BASH, SHIELD_BLOCK)
	can_parry = TRUE
	wdefense = 10


/obj/item/scabbard/rumahench
	name = "lenticular scabbard"
	desc = "A cloud-patterned scabbard with a cloth sash. Used for blocking."
	icon_state = "steelscab"
	item_state = "steelscab"
	valid_sword = /obj/item/rogueweapon/sword/sabre/mulyeog/rumahench

	associated_skill = /datum/skill/combat/shields
	possible_item_intents = list(SHIELD_BASH, SHIELD_BLOCK)
	can_parry = TRUE
	wdefense = 10


/obj/item/scabbard/rumacaptain
	name = "gold-stained scabbard"
	desc = "An ornate, wooden scabbard with a sash. Great for parrying."
	icon_state = "goldscab"
	item_state = "goldscab"
	valid_sword = /obj/item/rogueweapon/sword/sabre/mulyeog/rumacaptain

	associated_skill = /datum/skill/combat/shields
	possible_item_intents = list(SHIELD_BASH, SHIELD_BLOCK)
	can_parry = TRUE
	wdefense = 10
	sellprice = 10
