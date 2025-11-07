/datum/sex_action/armpit_nuzzle
	name = "Прижаться к подмышкам"

/datum/sex_action/armpit_nuzzle/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/armpit_nuzzle/can_perform(mob/living/user, mob/living/target)
	. = ..()
	if(!.)
		return FALSE
	if(user == target)
		return FALSE
	if(check_sex_lock(user, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_CHEST))
		return FALSE
	if(!check_location_accessible(user, user, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	return TRUE

/datum/sex_action/armpit_nuzzle/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] залезает под руки [target]..."))

/datum/sex_action/armpit_nuzzle/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] тыкается носом в подмышки [target]..."))

/datum/sex_action/armpit_nuzzle/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] перестает прижиматься к подмышкам [target]..."))

/datum/sex_action/armpit_nuzzle/lock_sex_object(mob/living/carbon/human/user, mob/living/carbon/human/target)
	sex_locks |= new /datum/sex_session_lock(user, BODY_ZONE_PRECISE_MOUTH)
