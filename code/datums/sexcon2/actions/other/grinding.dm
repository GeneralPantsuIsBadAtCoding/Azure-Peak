/datum/sex_action/grind_body
	name = "Тереться"
	check_same_tile = FALSE

/datum/sex_action/grind_body/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/grind_body/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/grind_body/get_start_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return span_warning("[user] прижимается к [target]...")

/datum/sex_action/grind_body/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	var/do_subtle
	if(sex_session.force < SEX_FORCE_EXTREME && sex_session.speed < SEX_SPEED_EXTREME)
		do_subtle = !prob(sex_session.force > SEX_FORCE_MID ? 2 : 5)
	else
		do_subtle = 0
	sex_session.show_progress = !do_subtle
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
	user.visible_message(sex_session.spanify_force("[user] [do_subtle ? pick("незаметно","тайком","скрытно","тихо") : sex_session.get_generic_force_adjective()] трется об [ru_zone_selected] [target]..."), vision_distance = (do_subtle ? 1 : DEFAULT_MESSAGE_RANGE))
	if(!do_subtle)
		if(sex_session.force > SEX_FORCE_HIGH)
			playsound(target, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
		else
			user.make_sucking_noise()
		do_thrust_animate(user, target)

	sex_session.perform_sex_action(user, 1, 0.5, TRUE)
	sex_session.handle_passive_ejaculation(user)

	sex_session.perform_sex_action(target, 1, 0.5, TRUE)
	sex_session.handle_passive_ejaculation(target)

/datum/sex_action/grind_body/get_finish_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return span_warning("[user] перестает тереться об [target]...")
