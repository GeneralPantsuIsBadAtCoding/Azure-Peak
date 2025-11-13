/datum/sex_action/tailjob
	name = "Подрочить хвостом"
	check_same_tile = FALSE
	target_sex_part = SEX_PART_COCK

/datum/sex_action/tailjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_TAIL))
		return FALSE
	return TRUE

/datum/sex_action/tailjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_TAIL))
		return FALSE
	return TRUE

/datum/sex_action/tailjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] обматывает своим хвостом член [target]..."))

/datum/sex_action/tailjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] ласкает член [target] своим хвостом."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 0, TRUE)

	target.sexcon.handle_passive_ejaculation(user)

/datum/sex_action/tailjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] перестает наяривать хвостом хер [target]."))

/datum/sex_action/tailjob/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
