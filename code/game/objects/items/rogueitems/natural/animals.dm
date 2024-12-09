

/obj/item/natural/hide
	name = "hide"
	icon_state = "hide"
	desc = "Hide from one of Dendor's creachers."
	dropshrink = 0.50
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sellprice = 8

/obj/item/natural/fur
	name = "fur"
	icon_state = "wool1"
	desc = "Fur from one of Dendor's creachers."
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	color = "#5c5243"
	sellprice = 18

//RTD make this a storage item and make clickign on animals with things put it in storage
/obj/item/natural/saddle
	name = "saddle"
	icon_state = "saddle"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK_L
	resistance_flags = FIRE_PROOF
	gripped_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	sellprice = 10
	var/storage_type = /datum/component/storage/concrete

/obj/item/natural/saddle/ComponentInitialize()
	. = ..()
	AddComponent(storage_type)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 16
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_items = 12

/obj/item/natural/saddle/attack(mob/living/target, mob/living/carbon/human/user)
	if(istype(target, /mob/living/simple_animal))
		testing("yea1")
		var/mob/living/simple_animal/S = target
		if(S.can_saddle && !S.ssaddle)
			testing("yea2")
			if(!target.has_buckled_mobs())
				user.visible_message(span_warning("[user] tries to saddle [target]..."))
				if(do_after(user, 40, target = target))
					playsound(loc, 'sound/foley/saddledismount.ogg', 100, FALSE)
					user.dropItemToGround(src)
					S.ssaddle = src
					src.forceMove(S)
					S.update_icon()
		return
	..()

/mob/living/simple_animal
	var/can_saddle = FALSE
	var/obj/item/ssaddle
	var/simple_detect_bonus = 0 // A flat percentage bonus to our ability to detect sneaking people only. Use in lieu of giving mobs huge STAPER bonuses if you want them to be observant.

/obj/item/natural/bone
	name = "bone"
	icon_state = "bone"
	desc = "The meatless remains of the dead. Whether it came from an animal or a person it all looks the same now."
	blade_dulling = 0
	max_integrity = 20
	static_debris = null
	obj_flags = null
	firefuel = null
	w_class = WEIGHT_CLASS_NORMAL
	twohands_required = FALSE
	gripped_intents = null
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP
	bundletype = /obj/item/natural/bundle/bone
