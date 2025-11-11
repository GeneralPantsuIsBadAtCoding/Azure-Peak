/datum/sex_action/masturbate/penis_over
	name = "Вздрочнуть на кого-то"
	check_same_tile = FALSE
	user_priority = 20

/datum/sex_action/masturbate/penis_over/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(check_sex_lock(user, ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/masturbate/penis_over/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE
	if(user == target)
		return FALSE
	if(!check_location_accessible(user, user, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(check_sex_lock(user, ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/masturbate/penis_over/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] надрачивает на [target]..."))

/datum/sex_action/masturbate/penis_over/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	var/chosen_verb = pick(list("дрочит свой хер", "ублажает свой член", "мастурбирует", "дрочит"))
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] [chosen_verb] над [target]"))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	sex_session.perform_sex_action(user, 2, 4, TRUE)

/datum/sex_action/masturbate/penis_over/handle_climax_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_love("[user] кончает на [target]!"))
	return "onto"

/datum/sex_action/masturbate/penis_over/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] заканчивает наяривать."))

/datum/sex_action/masturbate/penis_over/lock_sex_object(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	sex_locks |= new /datum/sex_session_lock(user, ORGAN_SLOT_PENIS)
