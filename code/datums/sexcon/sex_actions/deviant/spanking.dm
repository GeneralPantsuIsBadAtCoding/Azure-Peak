/datum/sex_action/spanking
	name = "Шлепать задницу"
	// Allow through all clothes, so no body zone accessibility check for clothing
	check_same_tile = FALSE
	do_time = 2.5 SECONDS // Slightly faster than average for repeated action
	stamina_cost = 0
	category = SEX_CATEGORY_HANDS

/datum/sex_action/spanking/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	return TRUE
/datum/sex_action/spanking/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!user.Adjacent(target))
		return FALSE
	// No clothing or body zone checks, can always spank
	return TRUE
/datum/sex_action/spanking/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] готовит свою руку, чтобы отшлепать [target] по заднице!"))
/datum/sex_action/spanking/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/force = user.sexcon.force
	var/sound = pick('sound/foley/slap.ogg', 'sound/foley/smackspecial.ogg')
	playsound(target, sound, 50, TRUE, -2, ignore_walls = FALSE)
	var/msg = "[user] [user.sexcon.get_generic_force_adjective()] шлепает задницу [target]."
	user.visible_message(user.sexcon.spanify_force(msg))
	// Arousal and pain logic
	var/arousal_amt = 1.2 + (force * 0.5)
	var/pain_amt = 2 * force
	user.sexcon.perform_sex_action(target, arousal_amt, pain_amt, TRUE)
	target.sexcon.handle_passive_ejaculation()
	// Soreness messaging depending on force
	if(force >= SEX_FORCE_HIGH)
		to_chat(target, span_warning("Твоя задница начинает болеть от порки!"))
	else if(force == SEX_FORCE_MID)
		if(prob(30))
			to_chat(target, span_notice("Вы чувствуете приятное покалывание в спине."))
	else if(force == SEX_FORCE_LOW)
		if(prob(10))
			to_chat(target, span_notice("Нежное тепло разливается по вашим ягодицам."))
/datum/sex_action/spanking/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] прекращает шлепать [target]."))
/datum/sex_action/spanking/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
