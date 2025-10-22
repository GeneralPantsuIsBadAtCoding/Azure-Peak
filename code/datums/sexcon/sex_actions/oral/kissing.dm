/datum/sex_action/kissing
	name = "Поцеловаться"
	check_same_tile = FALSE
	user_sex_part = SEX_PART_JAWS

/datum/sex_action/kissing/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/kissing/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	return TRUE

/datum/sex_action/kissing/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.visible_message(span_warning("[user] сливается в поцелуе с [target]..."))

/datum/sex_action/kissing/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] целуется с [target]..."))
	user.make_sucking_noise()

	user.sexcon.perform_sex_action(user, 1, 2, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 1, 2, TRUE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/kissing/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.visible_message(span_warning("[user] разрывает поцелуй с [target] ..."))
