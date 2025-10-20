/datum/outfit/job/roguetown/martyr/basic/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_TEMPLAR, TRAIT_GENERIC)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/martyr_guidance)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/martyr_expedite)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/martyr_onfeet)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/martyr_laststand)

/obj/effect/proc_holder/spell/invoked/order/martyr_guidance
	name = "Dictat of Noc"
	desc = "Command your Templar to aim for the weak spots. +1 Perception outside the Holy Ground, +3 Perception within Holy Ground."
	overlay_state = "takeaim"

/datum/status_effect/buff/order/martyr_guidance
	id = "martyr_guidance"
	alert_type = /atom/movable/screen/alert/status_effect/buff/order/martyr_guidance
	effectedstats = list(STATKEY_PER = 1)
	duration = 1 MINUTES

/datum/status_effect/buff/order/martyr_guidance/church
	id = "martyr_guidance_church"
	alert_type = /atom/movable/screen/alert/status_effect/buff/order/martyr_guidance
	effectedstats = list(STATKEY_PER = 3)
	duration = 1 MINUTES

/atom/movable/screen/alert/status_effect/buff/order/martyr_guidance
	name = "Dictat of Noc"
	desc = "My captain has blessed me with Noc's guidance!"
	icon_state = "buff"

/datum/status_effect/buff/order/martyr_guidance/on_apply()
	. = ..()
	to_chat(owner, span_blue("My captain has blessed me with Noc's guidance!"))

/obj/effect/proc_holder/spell/invoked/order/martyr_guidance/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(!HAS_TRAIT(target, TRAIT_TEMPLAR))
			to_chat(user, span_alert("I cannot order one not of the Templar ranks!"))
			revert_cast()
			return	
		if(target == user)
			to_chat(user, span_alert("I cannot order myself!"))
			revert_cast()
			return
		user.say("Храмовники, сосредоточьтесь на цели! Да направит Нок вашу руку!!")
		var/area/rogue/our_area = get_area(target)
		if(!(our_area.holy_area))
			target.apply_status_effect(/datum/status_effect/buff/order/martyr_guidance)
		else
			target.apply_status_effect(/datum/status_effect/buff/order/martyr_guidance/church)
		for (var/mob/living/carbon/human/H in view(7, target))
			if(HAS_TRAIT(H, TRAIT_TEMPLAR))
				if(!(our_area.holy_area))
					H.apply_status_effect(/datum/status_effect/buff/order/martyr_guidance)
				else
					H.apply_status_effect(/datum/status_effect/buff/order/martyr_guidance/church)
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/order/martyr_expedite
	name = "Dictat of Xylix"
	desc = "Command your Templar to advance quickly. +1 Speed outside the Holy Ground, +3 Speed within Holy Ground."
	overlay_state = "movemovemove"

/datum/status_effect/buff/order/martyr_expedite
	id = "martyr_expedite"
	alert_type = /atom/movable/screen/alert/status_effect/buff/order/martyr_expedite
	effectedstats = list(STATKEY_SPD = 1)
	duration = 1 MINUTES

/datum/status_effect/buff/order/martyr_expedite/church
	id = "martyr_expedite_church"
	alert_type = /atom/movable/screen/alert/status_effect/buff/order/martyr_expedite
	effectedstats = list(STATKEY_SPD = 3)
	duration = 1 MINUTES

/atom/movable/screen/alert/status_effect/buff/order/martyr_expedite
	name = "Dictat of Xylix"
	desc = "My captain has blessed me with Xylix's guidance!"
	icon_state = "buff"

/datum/status_effect/buff/order/martyr_expedite/on_apply()
	. = ..()
	to_chat(owner, span_blue("My captain has blessed me with Xylix's guidance!"))

/obj/effect/proc_holder/spell/invoked/order/martyr_expedite/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(!HAS_TRAIT(target, TRAIT_TEMPLAR))
			to_chat(user, span_alert("I cannot order one not of the Templar ranks!"))
			revert_cast()
			return	
		if(target == user)
			to_chat(user, span_alert("I cannot order myself!"))
			revert_cast()
			return
		user.say("Вперёд, храмовники! Ксайликс направит нас к победе!!")
		var/area/rogue/our_area = get_area(target)
		if(!(our_area.holy_area))
			target.apply_status_effect(/datum/status_effect/buff/order/martyr_expedite)
		else
			target.apply_status_effect(/datum/status_effect/buff/order/martyr_expedite/church)
		for (var/mob/living/carbon/human/H in view(7, target))
			if(HAS_TRAIT(H, TRAIT_TEMPLAR))
				if(!(our_area.holy_area))
					H.apply_status_effect(/datum/status_effect/buff/order/martyr_expedite)
				else
					H.apply_status_effect(/datum/status_effect/buff/order/martyr_expedite/church)
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/order/martyr_onfeet
	name = "Dictat of Ravox"
	desc = "Command your Templar to hold fast. Forces them to stand up, enduring through the struggle. Grants resistance to pain within Holy Ground."
	overlay_state = "onfeet"

/datum/status_effect/buff/order/martyr_onfeet
	id = "martyr_onfeet"
	alert_type = /atom/movable/screen/alert/status_effect/buff/order/martyr_onfeet
	duration = 5 SECONDS

/datum/status_effect/buff/order/martyr_onfeet/church
	id = "martyr_onfeet_church"
	alert_type = /atom/movable/screen/alert/status_effect/buff/order/martyr_onfeet
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/buff/order/martyr_onfeet
	name = "Dictat of Ravox"
	desc = "My captain has blessed me with Ravox's guidance!"
	icon_state = "buff"

/datum/status_effect/buff/order/martyr_onfeet/on_apply()
	. = ..()
	to_chat(owner, span_blue("My captain has blessed me with Ravox's guidance!"))

/datum/status_effect/buff/order/martyr_onfeet/church/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)

/datum/status_effect/buff/order/martyr_onfeet/church/on_remove()
	REMOVE_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)
	. = ..()

/obj/effect/proc_holder/spell/invoked/order/martyr_onfeet/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(!HAS_TRAIT(target, TRAIT_TEMPLAR))
			to_chat(user, span_alert("I cannot order one not of the Templar ranks!"))
			revert_cast()
			return	
		if(target == user)
			to_chat(user, span_alert("I cannot order myself!"))
			revert_cast()
			return
		user.say("Храмовники! Встаньте и сражайтесь! Равокс смотрит на вас!!")
		var/area/rogue/our_area = get_area(target)
		if(!(target.mobility_flags & MOBILITY_STAND))
			target.SetUnconscious(0)
			target.SetSleeping(0)
			target.SetParalyzed(0)
			target.SetImmobilized(0)
			target.SetStun(0)
			target.SetKnockdown(0)
			target.set_resting(FALSE)
		if(our_area.holy_area)
			target.apply_status_effect(/datum/status_effect/buff/order/martyr_onfeet/church)
		else
			target.apply_status_effect(/datum/status_effect/buff/order/martyr_onfeet)
		for (var/mob/living/carbon/human/H in view(7, target))
			if(HAS_TRAIT(H, TRAIT_TEMPLAR))
				if(!(target.mobility_flags & MOBILITY_STAND))
					H.SetUnconscious(0)
					H.SetSleeping(0)
					H.SetParalyzed(0)
					H.SetImmobilized(0)
					H.SetStun(0)
					H.SetKnockdown(0)
					H.set_resting(FALSE)
				if(our_area.holy_area)
					H.apply_status_effect(/datum/status_effect/buff/order/martyr_onfeet/church)
				else
					H.apply_status_effect(/datum/status_effect/buff/order/martyr_onfeet)
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/order/martyr_laststand
	name = "Dictat of Malum"
	desc = "Command your Templar to assume defense formation. +1 Willpower and Constitution outside the Holy Ground, +2 Willpower and Constitution within Holy Ground."
	overlay_state = "hold"

/datum/status_effect/buff/order/martyr_laststand
	id = "martyr_laststand"
	alert_type = /atom/movable/screen/alert/status_effect/buff/order/martyr_laststand
	effectedstats = list(STATKEY_WIL = 1, STATKEY_CON = 1)
	duration = 40 SECONDS

/datum/status_effect/buff/order/martyr_laststand/church
	id = "martyr_laststand_church"
	alert_type = /atom/movable/screen/alert/status_effect/buff/order/martyr_laststand
	effectedstats = list(STATKEY_WIL = 2, STATKEY_CON = 2)
	duration = 40 SECONDS

/atom/movable/screen/alert/status_effect/buff/order/martyr_laststand
	name = "Dictat of Malum"
	desc = "My captain has blessed me with Malum's guidance!"
	icon_state = "buff"

/datum/status_effect/buff/order/martyr_laststand/on_apply()
	. = ..()
	to_chat(owner, span_blue("My captain has blessed me with Malum's guidance!"))

/obj/effect/proc_holder/spell/invoked/order/martyr_laststand/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(!HAS_TRAIT(target, TRAIT_TEMPLAR))
			to_chat(user, span_alert("I cannot order one not of the Templar ranks!"))
			revert_cast()
			return	
		if(target == user)
			to_chat(user, span_alert("I cannot order myself!"))
			revert_cast()
			return
		user.say("Ни шагу назад, храмовники! Малум укрепит нашу волю!!")
		var/area/rogue/our_area = get_area(target)
		if(!(our_area.holy_area))
			target.apply_status_effect(/datum/status_effect/buff/order/martyr_laststand)
		else
			target.apply_status_effect(/datum/status_effect/buff/order/martyr_laststand/church)
		for (var/mob/living/carbon/human/H in view(7, target))
			if(HAS_TRAIT(H, TRAIT_TEMPLAR))
				if(!(our_area.holy_area))
					H.apply_status_effect(/datum/status_effect/buff/order/martyr_laststand)
				else
					H.apply_status_effect(/datum/status_effect/buff/order/martyr_laststand/church)
		return TRUE
	revert_cast()
	return FALSE
