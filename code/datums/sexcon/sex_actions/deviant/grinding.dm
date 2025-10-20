/datum/sex_action/grind_body
	name = "Тереться"
	check_same_tile = FALSE

/datum/sex_action/grind_body/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/grind_body/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!target.get_bodypart(check_zone(user.zone_selected)))
		return FALSE
	return TRUE

/datum/sex_action/grind_body/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] прижимается к [target]..."), vision_distance = 1)
	user.sexcon.show_progress = 0

/datum/sex_action/grind_body/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/do_subtle
	if(user.sexcon.force < SEX_FORCE_EXTREME && user.sexcon.speed < SEX_SPEED_EXTREME)
		do_subtle = !prob(user.sexcon.force > SEX_FORCE_MID ? 2 : 5)
	else
		do_subtle = 0
	user.sexcon.show_progress = !do_subtle
	var/list/zone_translations = list(
	BODY_ZONE_HEAD = "голову",
	BODY_ZONE_CHEST = "туловище",
	BODY_ZONE_R_ARM = "правую руку",
	BODY_ZONE_L_ARM = "левую руку",
	BODY_ZONE_R_LEG = "правую ногу",
	BODY_ZONE_L_LEG = "левую ногу",
	BODY_ZONE_PRECISE_R_INHAND = "правую ладонь",
	BODY_ZONE_PRECISE_L_INHAND = "левую ладонь",
	BODY_ZONE_PRECISE_R_FOOT = "правую ступню",
	BODY_ZONE_PRECISE_L_FOOT = "левую ступню",
	BODY_ZONE_PRECISE_SKULL = "череп",
	BODY_ZONE_PRECISE_EARS = "уши",
	BODY_ZONE_PRECISE_R_EYE = "правый глаз",
	BODY_ZONE_PRECISE_L_EYE = "левый глаз",
	BODY_ZONE_PRECISE_NOSE = "нос",
	BODY_ZONE_PRECISE_MOUTH = "рот",
	BODY_ZONE_PRECISE_NECK = "шею",
	BODY_ZONE_PRECISE_STOMACH = "живот",
	BODY_ZONE_PRECISE_GROIN = "пах"
	)
	var/ru_zone_selected = zone_translations[user.zone_selected]
	user.visible_message(user.sexcon.spanify_force("[user] [do_subtle ? pick("незаметно","тайком","скрытно","тихо") : user.sexcon.get_generic_force_adjective()] трется об [ru_zone_selected] [target]..."), vision_distance = (do_subtle ? 1 : DEFAULT_MESSAGE_RANGE))
	if(!do_subtle)
		if(user.sexcon.force > SEX_FORCE_HIGH)
			playsound(target, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
		else
			user.make_sucking_noise()
		do_thrust_animate(user, target)

	user.sexcon.perform_sex_action(user, 1, 0.5, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 1, 0.5, TRUE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/grind_body/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops grinding against [target] ..."), vision_distance = 1)

/datum/sex_action/grind_body/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
