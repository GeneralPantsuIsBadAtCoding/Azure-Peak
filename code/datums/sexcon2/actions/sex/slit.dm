/datum/sex_action/sex/slit
	name = "Трахнуть в щель"
	stamina_cost = 1.0

/datum/sex_action/sex/slit/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!has_slit_sheath(target))
		return FALSE
	return TRUE

/datum/sex_action/sex/slit/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE
	if(user == target)
		return FALSE
	if(!check_location_accessible(user, user, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!has_slit_sheath(target))
		return FALSE
	if(check_sex_lock(user, ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/sex/slit/get_start_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return span_warning("[user] входит свои хером в щель [target]!")

/datum/sex_action/sex/slit/get_start_sound(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg')

/datum/sex_action/sex/slit/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	var/is_knotting = sex_session.do_knot_action
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] [is_knotting ? "трахает щель [target] по самый узел" : "трахает щель [target]"]."))
	playsound(target, sex_session.get_force_sound(), 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	do_onomatopoeia(user)

	sex_session.perform_sex_action(user, 2, 0, TRUE)

	if(sex_session.considered_limp(user))
		sex_session.perform_sex_action(target, 1.2, 3, FALSE)
	else
		var/target_pleasure = is_knotting ? 11 : 7
		sex_session.perform_sex_action(target, 2.4, target_pleasure, FALSE)
	sex_session.handle_passive_ejaculation(target)

/datum/sex_action/sex/slit/handle_climax_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_love("[user] кончает в щель [target]!"))
	user.virginity = FALSE
	return "into"

/datum/sex_action/sex/slit/get_finish_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return span_warning("[user] прекращает сношать щель [target].")

/datum/sex_action/sex/slit/get_knot_count()
	return 1

// Double penis variant
/datum/sex_action/sex/slit/double
	name = "Трахнуть в щель двумя членами"

/datum/sex_action/sex/slit/double/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!has_double_penis(user))
		return FALSE
	return ..()

/datum/sex_action/sex/slit/double/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!has_double_penis(user))
		return FALSE
	return ..()

/datum/sex_action/sex/slit/double/get_start_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return span_warning("[user] входит сразу же всеми двумя членами в щель [target]!")

/datum/sex_action/sex/slit/double/get_start_sound(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg')

/datum/sex_action/sex/slit/double/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	var/is_knotting = sex_session.do_knot_action
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] [is_knotting ? "трахает щель [target] двумя членами разом по самый узел" : "трахает щель [target] двумя членами разом"]."))
	playsound(target, sex_session.get_force_sound(), 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	do_onomatopoeia(user)

	sex_session.perform_sex_action(user, 2, 0, TRUE)

	if(sex_session.considered_limp(user))
		sex_session.perform_sex_action(target, 1.2, 3, FALSE)
	else
		var/target_pleasure = is_knotting ? 16 : 11
		sex_session.perform_sex_action(target, 2.4, target_pleasure, FALSE)
	sex_session.handle_passive_ejaculation(target)

/datum/sex_action/sex/slit/double/get_finish_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return span_warning("[user] прекращает сношать щель.")

/datum/sex_action/sex/slit/double/get_knot_count()
	return 2
