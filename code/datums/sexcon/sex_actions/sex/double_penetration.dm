/datum/sex_action/double_penetration_sex
	name = "Трахнуть обе дырки"
	stamina_cost = 1.0
	category = SEX_CATEGORY_PENETRATE
	user_sex_part = SEX_PART_COCK
	target_sex_part = SEX_PART_CUNT|SEX_PART_ANUS
	knot_on_finish = TRUE

/datum/sex_action/double_penetration_sex/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_VAGINA) || !target.sexcon.can_zodomize())
		return FALSE
	var/obj/item/organ/penis/penis = user.getorganslot(ORGAN_SLOT_PENIS)
	if(!penis || penis.penis_type != PENIS_TYPE_TAPERED_DOUBLE && penis.penis_type != PENIS_TYPE_TAPERED_DOUBLE_KNOTTED)
		return FALSE
	return TRUE

/datum/sex_action/double_penetration_sex/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!check_location_accessible(user, user, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	var/obj/item/organ/penis/penis = user.getorganslot(ORGAN_SLOT_PENIS)
	if(!penis || penis.penis_type != PENIS_TYPE_TAPERED_DOUBLE && penis.penis_type != PENIS_TYPE_TAPERED_DOUBLE_KNOTTED)
		return FALSE
	if(!user.sexcon.can_use_penis())
		return FALSE
	return TRUE

/datum/sex_action/double_penetration_sex/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] протискивает члены в обе дырки [target]!"))
	playsound(target, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/datum/sex_action/double_penetration_sex/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!user.sexcon.do_knot_action)
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] долбит во все щели [target] за раз."))
	else
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] долбит во все щели [target] за раз по самый узел."))
	playsound(target, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
	user.sexcon.do_thrust_animate(target)

	user.sexcon.perform_sex_action(user, 3, 0, TRUE)
	if(user.sexcon.check_active_ejaculation())
		user.visible_message(span_love("[user] заполняет дырки [target] горячим семенем!"))
		user.sexcon.cum_into(splashed_user = target)
		user.try_impregnate(target)
		user.virginity = FALSE
		target.virginity = FALSE

	if(user.sexcon.considered_limp())
		user.sexcon.perform_sex_action(target, 1.4, 4, FALSE)
	else
		user.sexcon.perform_sex_action(target, 2.7, !user.sexcon.do_knot_action ? 9 : 14, FALSE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/double_penetration_sex/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] вытаскивает члены из щелей [target]."))

/datum/sex_action/double_penetration_sex/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
