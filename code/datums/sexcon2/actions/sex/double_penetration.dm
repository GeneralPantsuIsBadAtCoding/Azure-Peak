/datum/sex_action/sex/double_penetration
	name = "Fuck both their holes"
	stamina_cost = 1.0

/datum/sex_action/sex/double_penetration/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!has_double_penis(user))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	return TRUE

/datum/sex_action/sex/double_penetration/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE
	if(user == target)
		return FALSE
	if(!check_location_accessible(user, user, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!has_double_penis(user))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	if(check_sex_lock(user, ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/sex/double_penetration/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] slides [user.p_their()] cocks into [target]'s holes!"))
	playsound(target, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/datum/sex_action/sex/double_penetration/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] fucks [target]'s holes together."))
	playsound(target, sex_session.get_force_sound(), 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	do_onomatopoeia(user)

	sex_session.perform_sex_action(user, 3, 0, TRUE)

	if(sex_session.considered_limp(user))
		sex_session.perform_sex_action(target, 1.4, 4, FALSE)
	else
		sex_session.perform_sex_action(target, 2.7, 14, FALSE)
	sex_session.handle_passive_ejaculation(target)

/datum/sex_action/sex/double_penetration/handle_climax_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_love("[user] cums into [target]'s holes at the same time!"))
	user.try_impregnate(target)
	user.virginity = FALSE
	target.virginity = FALSE
	return "into"

/datum/sex_action/sex/double_penetration/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] pulls [user.p_their()] twin cocks out of [target]'s holes."))
