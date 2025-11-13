/datum/sex_action/sex/boobjob
	name = "Вздрочнуть сиськами"

/datum/sex_action/sex/boobjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return
	return TRUE

/datum/sex_action/sex/boobjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE
	if(user == target)
		return FALSE
	if(!check_location_accessible(user, user, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_CHEST))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_BREASTS))
		return FALSE
	if(check_sex_lock(user, ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/sex/boobjob/get_start_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return span_warning("[user] хватает сиськи [target] и погружает свой хер в ложбинку!")

/datum/sex_action/sex/boobjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] трахает сиськи [target]."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 20, TRUE, -2, ignore_walls = FALSE)

	sex_session.perform_sex_action(user, 2, 4, TRUE)

/datum/sex_action/sex/boobjob/get_finish_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return span_warning("[user] поднимает хер из ложбинки меж грудей [target].")
