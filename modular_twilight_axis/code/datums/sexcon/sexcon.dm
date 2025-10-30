/datum/sex_controller/proc/handle_cock_milking(mob/living/carbon/human/milker)
	if(arousal < ACTIVE_EJAC_THRESHOLD)
		return
	if(is_spent())
		return
	if(!can_ejaculate())
		return FALSE
	ejaculate_container(milker.get_active_held_item())

/datum/sex_controller/proc/handle_breast_milking(mob/living/carbon/human/milker, mob/living/carbon/human/target)
	var/obj/item/organ/breasts/breasts = target.getorganslot(ORGAN_SLOT_BREASTS)
	var/milk_to_add = min(max(breasts.breast_size, 1), breasts.milk_stored)
	if(breasts.lactating && milk_to_add > 0)
		breasts.milk_stored -= milk_to_add
		milk_container(milker.get_active_held_item(), milk_to_add)
	else
		to_chat(milker, span_notice("Молоко не выходит из груди..."))

/datum/sex_controller/proc/milk_container(obj/item/reagent_containers/glass/C, amout)
	user.visible_message(span_lovebold("[user.name] наполняет [C.name] молочком!"))
	playsound(user, 'sound/misc/mat/segso.ogg', 50, TRUE, ignore_walls = FALSE)
	C.reagents.add_reagent(/datum/reagent/consumable/milk, amout)

/datum/sex_controller/proc/ejaculate_container(obj/item/reagent_containers/glass/C)
	log_combat(user, user, "Кончает в емкость")
	user.visible_message(span_lovebold("[user.name] наполняет [C.name] семенем!"))
	playsound(user, 'sound/misc/mat/endout.ogg', 50, TRUE, ignore_walls = FALSE)
	C.reagents.add_reagent(/datum/reagent/erpjuice/cum, 3)
	after_ejaculation()

/datum/sex_controller/proc/handle_container_ejaculation()
	if(arousal < PASSIVE_EJAC_THRESHOLD)
		return
	if(is_spent())
		return
	if(!can_ejaculate())
		return FALSE
	ejaculate_container(user.get_active_held_item())

// From SR carbon_defense.dm
/mob/proc/check_handholding()
	return

/mob/living/carbon/human/check_handholding()
	if(pulledby && pulledby != src)
		var/obj/item/bodypart/LH
		var/obj/item/bodypart/RH
		LH = get_bodypart(BODY_ZONE_PRECISE_L_HAND)
		RH = get_bodypart(BODY_ZONE_PRECISE_R_HAND)
		if(LH || RH)
			for(var/obj/item/grabbing/G in src.grabbedby)
				if(G.limb_grabbed == LH || G.limb_grabbed == RH)
					return TRUE
