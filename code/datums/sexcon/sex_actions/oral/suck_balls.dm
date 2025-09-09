/datum/sex_action/suck_balls
	name = "Suck their balls"

/datum/sex_action/suck_balls/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_TESTICLES))
		return FALSE
	if(HAS_TRAIT(target, TRAIT_TINY))	//Someone else can figure out how a full sized humen gives a tiny seelie a ball sucking...
		return FALSE
	return TRUE

/datum/sex_action/suck_balls/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_TESTICLES))
		return FALSE
	return TRUE

/datum/sex_action/suck_balls/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(HAS_TRAIT(user, TRAIT_TINY) && !(HAS_TRAIT(target, TRAIT_TINY)))
		user.visible_message(span_warning("[user] starts licking [target]'s balls..."))	//Fairy too small to do anything but lick instead
	else
		user.visible_message(span_warning("[user] starts sucking [target]'s balls..."))

/datum/sex_action/suck_balls/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(HAS_TRAIT(user, TRAIT_TINY) && !(HAS_TRAIT(target, TRAIT_TINY)))
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] licks [target]'s balls..."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] sucks [target]'s balls..."))
	user.make_sucking_noise()

	user.sexcon.perform_sex_action(target, 1, 3, TRUE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/suck_balls/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(HAS_TRAIT(user, TRAIT_TINY) && !(HAS_TRAIT(target, TRAIT_TINY)))
		user.visible_message(span_warning("[user] stops licking [target]'s balls ..."))
	else
		user.visible_message(span_warning("[user] stops sucking [target]'s balls ..."))

/datum/sex_action/suck_balls/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
