/datum/sex_action/anal_ride_sex
	name = "Оседлать (анал)"
	stamina_cost = 1.0
	aggro_grab_instead_same_tile = FALSE
	user_sex_part = SEX_PART_ANUS
	target_sex_part = SEX_PART_COCK
	category = SEX_CATEGORY_PENETRATE

/datum/sex_action/anal_ride_sex/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/anal_ride_sex/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/anal_ride_sex/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user.name] занимает верх над [target] и прижимает головку к анальному колечку!"))
	playsound(target, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/datum/sex_action/anal_ride_sex/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user.name] [user.sexcon.get_generic_force_adjective()] скачет на [target]."))
	playsound(target, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	target.sexcon.perform_sex_action(target, 2, 0, TRUE)
	if(target.sexcon.check_active_ejaculation())
		target.visible_message(span_lovebold("[target.name] кончает прямо в попку [user]!"))
		target.sexcon.cum_into(splashed_user = user)
		target.virginity = FALSE

	if(target.sexcon.considered_limp())
		target.sexcon.perform_sex_action(user, 1.2, 4, FALSE)
	else
		target.sexcon.perform_sex_action(user, 2.4, 9, FALSE)
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/anal_ride_sex/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user.name] поднимается с [target]."))

/datum/sex_action/anal_ride_sex/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
