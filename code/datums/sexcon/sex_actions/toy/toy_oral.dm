/datum/sex_action/toy_oral
	name = "Игрушка (орал)"
	user_sex_part = SEX_PART_JAWS
	target_sex_part = SEX_PART_JAWS
	category = SEX_CATEGORY_PENETRATE

/datum/sex_action/toy_oral/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!get_dildo_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/toy_oral/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if(!get_dildo_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/toy_oral/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	user.visible_message(span_warning("[user] обхватывает головку [dildo] и погружает ту глубже..."))

/datum/sex_action/toy_oral/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] отсасывает [dildo]..."))
	user.make_sucking_noise()

/datum/sex_action/toy_oral/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	user.visible_message(span_warning("[user] перестает играться с [dildo]."))

/datum/sex_action/toy_oral/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
