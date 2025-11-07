/datum/sex_action/spanking
	name = "Шлепать задницу"
	// Allow through all clothes, so no body zone accessibility check for clothing
	check_same_tile = FALSE
	do_time = 2.5 SECONDS // Slightly faster than average for repeated action
	stamina_cost = 0

/datum/sex_action/spanking/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/spanking/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE
	var/locked = user.get_active_precise_hand()
	if(check_sex_lock(user, locked))
		return FALSE
	if(user == target)
		return FALSE
	if(!user.Adjacent(target))
		return FALSE
	// No clothing or body zone checks, can always spank
	return TRUE

/datum/sex_action/spanking/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] готовит свою руку, чтобы отшлепать [target] по заднице!"))

/datum/sex_action/spanking/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	var/force = sex_session.force
	var/sound = pick('sound/foley/slap.ogg', 'sound/foley/smackspecial.ogg')
	playsound(target, sound, 50, TRUE, -2, ignore_walls = FALSE)

	var/msg = "[user] [sex_session.get_generic_force_adjective()] шлепает задницу [target]."
	user.visible_message(sex_session.spanify_force(msg))

	// Arousal and pain logic
	var/arousal_amt = 1.2 + (force * 0.5)
	var/pain_amt = 2 * force
	sex_session.perform_sex_action(target, arousal_amt, pain_amt, TRUE)
	sex_session.handle_passive_ejaculation(target)

	// Soreness messaging depending on force
	if(force >= SEX_FORCE_HIGH)
		to_chat(target, span_warning("Моя задница начинает болеть от порки!"))
	else if(force == SEX_FORCE_MID)
		if(prob(30))
			to_chat(target, span_notice("Я чувствую приятное покалывание в спине."))
	else if(force == SEX_FORCE_LOW)
		if(prob(10))
			to_chat(target, span_notice("Нежное тепло разливается по моим ягодицам."))

/datum/sex_action/spanking/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] прекращает шлепать [target]."))

/datum/sex_action/spanking/lock_sex_object(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/locked = user.get_active_precise_hand()
	sex_locks |= new /datum/sex_session_lock(user, locked)
