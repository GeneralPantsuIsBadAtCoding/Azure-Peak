/datum/sex_action/toy_other_oral
	name = "Трахнуть игрушкой (орал)"
	target_sex_part = SEX_PART_JAWS
	category = SEX_CATEGORY_PENETRATE

/datum/sex_action/toy_other_oral/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_dildo_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/toy_other_oral/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if(!get_dildo_in_either_hand(user))
		return FALSE
	return TRUE

/datum/sex_action/toy_other_oral/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	user.visible_message(span_warning("[user] проталкивает в ротик [target] [dildo]..."))

/datum/sex_action/toy_other_oral/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] трахает при помощи дилдо ротик [target]..."))
	target.make_sucking_noise()

/datum/sex_action/toy_other_oral/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/obj/item/dildo = get_dildo_in_either_hand(user)
	user.visible_message(span_warning("[user] вынимает [dildo] из рта [target]."))

/datum/sex_action/toy_other_oral/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
