/datum/sex_action/sex/tailpegging_oral
	name = "Трахать горло хвостом"
	stamina_cost = 1.0

/datum/sex_action/sex/tailpegging_oral/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_TAIL))
		return FALSE
	return TRUE

/datum/sex_action/sex/tailpegging_oral/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE
	if(user == target)
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_TAIL))
		return FALSE
	return TRUE

/datum/sex_action/sex/tailpegging_oral/get_start_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return span_warning("[user] засовывает [user.p_their()] хвост в горло [target]!")

/datum/sex_action/sex/tailpegging_oral/get_start_sound(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg')

/datum/sex_action/sex/tailpegging_oral/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] трахает горло [target] своим хвостом."))
	playsound(target, sex_session.get_force_sound(), 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	do_onomatopoeia(user)

	sex_session.perform_sex_action(target, 2.4, 7, TRUE)
	sex_session.handle_passive_ejaculation(target)

/datum/sex_action/sex/tailpegging_oral/get_finish_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return span_warning("[user] вытаскивает [user.p_their()] хвост из горла [target].")
