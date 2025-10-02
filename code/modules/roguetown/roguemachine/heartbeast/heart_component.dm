#define QUIRK_LANGUAGE (1<<0)

/datum/component/chimeric_heart_beast
	var/obj/structure/roguemachine/chimeric_heart_beast/heart_beast
	var/base_blood_output = 1
	var/blood_output = 1
	var/blood_pool = 0
	var/max_blood_pool = 20000
	var/happiness = 0
	var/max_happiness = 1000
	var/tech_points = 0
	var/language_tier = 1
	var/max_language_tier = 4
	var/current_language_progress = 0
	var/max_language_progress = 1000

	var/datum/flesh_task/current_task
	var/last_task_time = 0
	var/task_cooldown = 0.1 MINUTES

	var/mob/living/current_listener
	var/listener_timeout_time = 0
	var/last_happiness_decay = 0
	var/happiness_decay_interval = 30 SECONDS

	var/list/active_quirks = list()
	var/list/language_quirks = list()

/datum/component/chimeric_heart_beast/Initialize()
	. = ..()
	if(!istype(parent, /obj/structure/roguemachine/chimeric_heart_beast))
		return COMPONENT_INCOMPATIBLE

	heart_beast = parent
	START_PROCESSING(SSobj, src)

	last_happiness_decay = world.time

	RegisterSignal(heart_beast, COMSIG_HEART_BEAST_HEAR, .proc/on_hear)
	RegisterSignal(heart_beast, COMSIG_ATOM_ATTACK_HAND, .proc/on_interact)

	initialize_quirks()

/datum/component/chimeric_heart_beast/proc/initialize_quirks()
	if(!heart_beast.quirks)
		return

	for(var/datum/flesh_quirk/quirk in heart_beast.quirks)
		active_quirks[quirk.type] = quirk

		if(quirk.quirk_type & QUIRK_LANGUAGE)
			language_quirks += quirk

/datum/component/chimeric_heart_beast/proc/has_quirk(quirk_type)
	return active_quirks[quirk_type] != null

/datum/component/chimeric_heart_beast/proc/apply_language_quirks(mob/speaker, message)
	var/list/penalties = list()
	penalties["score_penalty"] = 0
	penalties["score_bonus"] = 0
	penalties["happiness_multiplier"] = 1
	penalties["blood_multiplier"] = 1
	penalties["tech_multiplier"] = 1
	penalties["punctuation_override"] = 0

	if(!language_quirks.len)
		return penalties

	// Use default values, but apply differences for each language quirk that acts up
	for(var/datum/flesh_quirk/quirk in language_quirks)
		var/list/quirk_effects = quirk.apply_language_quirk(speaker, message, src)
		if(quirk_effects)
			penalties["score_penalty"] += quirk_effects["score_penalty"]
			penalties["score_bonus"] += quirk_effects["score_bonus"]
			penalties["happiness_multiplier"] *= (quirk_effects["happiness_multiplier"])
			penalties["blood_multiplier"] *= (quirk_effects["blood_multiplier"])
			penalties["tech_multiplier"] *= (quirk_effects["tech_multiplier"])
			if(quirk_effects["punctuation_override"])
				penalties["punctuation_override"] = quirk_effects["punctuation_override"]
	return penalties

/datum/component/chimeric_heart_beast/Destroy()
	STOP_PROCESSING(SSobj, src)
	UnregisterSignal(heart_beast, list(COMSIG_HEART_BEAST_HEAR, COMSIG_ATOM_ATTACK_HAND))
	. = ..()

/datum/component/chimeric_heart_beast/proc/update_blood_output()
	blood_output = 1 + 2 * (happiness / max_happiness)

/datum/component/chimeric_heart_beast/process(delta_time)
	blood_pool = min(blood_pool + blood_output * delta_time, max_blood_pool)
	update_blood_overlay()

	if(!current_task && world.time > last_task_time + task_cooldown)
		generate_new_task()

	if(world.time > last_happiness_decay + happiness_decay_interval)
		decay_happiness()
		last_happiness_decay = world.time

	if(current_listener && world.time > listener_timeout_time)
		clear_listener()

/datum/component/chimeric_heart_beast/proc/decay_happiness()
	happiness = max(happiness - (max_happiness * 0.05), 0)

	if(happiness <= 20 && prob(20))
		heart_beast.visible_message(span_warning("[heart_beast] seems discontent..."))

/datum/component/chimeric_heart_beast/proc/update_blood_overlay()
	var/blood_percent = blood_pool / max_blood_pool
	heart_beast.cut_overlay("blood_pool")

	var/chunk = round(blood_percent * 5) // This gives us 0-5
	if(chunk >= 1)
		heart_beast.add_overlay(mutable_appearance('icons/obj/structures/heart_beast.dmi', "blood_[chunk]"))

/datum/component/chimeric_heart_beast/proc/generate_new_task()
	current_task = new /datum/flesh_task/knowledge(language_tier, heart_beast)
	last_task_time = world.time

	heart_beast.say(current_task.question)
	playsound(heart_beast, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)

/datum/component/chimeric_heart_beast/proc/on_interact(datum/source, mob/user)
	SIGNAL_HANDLER

	if(current_task)
		heart_beast.say(current_task.question)
		playsound(heart_beast, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)

		set_current_listener(user)

		heart_beast.visible_message(span_warning("Tendrils from [heart_beast] extend towards [user] attentively!"))

/datum/component/chimeric_heart_beast/proc/set_current_listener(mob/user)
	current_listener = user
	listener_timeout_time = world.time + 1 MINUTES

/datum/component/chimeric_heart_beast/proc/clear_listener()
	current_listener = null
	listener_timeout_time = 0
	heart_beast.visible_message(span_notice("The tendrils from [heart_beast] retract, no longer focused on anyone."))

/datum/component/chimeric_heart_beast/proc/on_hear(datum/source, mob/speaker, raw_message)
	SIGNAL_HANDLER

	// Only process if we have a current task and this is our designated listener
	if(!current_task)
		return
	if(speaker != current_listener)
		return

	// Check if this might be an answer to our question
	evaluate_answer(raw_message, speaker)

/datum/component/chimeric_heart_beast/proc/evaluate_answer(message, mob/speaker)
	var/datum/flesh_task/knowledge/task = current_task
	if(!istype(task))
		return

	var/list/quirk_effects = apply_language_quirks(speaker, message)

	var/score = 0
	var/word_count = length(splittext(message, " "))
	var/last_char = copytext(message, -1)

	// Check word count
	if(word_count >= task.min_words && word_count <= task.max_words)
		score += 30

	// Check punctuation
	var/expected_punctuation = quirk_effects["punctuation_override"] ? quirk_effects["punctuation_override"] : task.preferred_punctuation
	if(last_char == expected_punctuation)
		score += 20

	// Check for keywords (up to 2)
	var/keywords_found = 0
	for(var/keyword in task.answer_keywords)
		if(findtext(lowertext(message), lowertext(keyword)))
			keywords_found++
			if(keywords_found >= 2)
				break

	to_chat(world, span_userdanger("KEYWORDS FOUND: [keywords_found]"))
	score += min(keywords_found, 2) * 25

	// If our quirks act up for whatever reason, reduce our score by a flat amount
	to_chat(world, span_userdanger("SCORE BEFORE REDUCE: [score]"))
	if(quirk_effects["score_penalty"])
		score = max(score - quirk_effects["score_penalty"], 0)
		to_chat(world, span_userdanger("SCORE AFTER REDUCE: [score]"))
	else if(quirk_effects["score_bonus"])
		score = min(score + quirk_effects["score_bonus"], 100)
		to_chat(world, span_userdanger("SCORE AFTER INCREASE: [score]"))

	// Determine success
	if(score >= 20) // Passing score
		complete_task(score, speaker, quirk_effects)
	else
		fail_task(score, speaker)

/datum/component/chimeric_heart_beast/proc/complete_task(score, mob/speaker, list/quirk_effects)
	var/reward_multiplier = score / 100

	// Calculate rewards
	var/blood_reward = (max_blood_pool / 10) * reward_multiplier * (quirk_effects["blood_multiplier"] || 1)
	// 5 - 10 - 20 - 40 Under perfect circumstances
	var/tech_reward = (5 * (2 ^ (language_tier - 1))) * reward_multiplier * (quirk_effects["tech_multiplier"] || 1)
	var/happiness_reward = (max_happiness / 4) * reward_multiplier * (quirk_effects["happiness_multiplier"] || 1)
	var/language_progress_reward = (max_language_progress / 4) * reward_multiplier

	// Apply rewards
	blood_pool = min(blood_pool + blood_reward, max_blood_pool)
	tech_points += tech_reward
	happiness = min(happiness + happiness_reward, max_happiness)
	current_language_progress = min(current_language_progress + language_progress_reward, max_language_progress)
	update_blood_output()
	upgrade_language_tier()

	var/feedback_message = get_tier_feedback("success", score)
	heart_beast.say(feedback_message)
	playsound(heart_beast, 'sound/misc/machineyes.ogg', 100, FALSE, -1)

	current_task = null
	clear_listener()

/datum/component/chimeric_heart_beast/proc/fail_task(score, mob/speaker)
	var/happiness_penalty = max_happiness * 0.05

	// Apply penalties
	happiness = max(happiness - happiness_penalty, 0)
	update_blood_output()

	var/feedback_message = get_tier_feedback("failure", score)
	heart_beast.say(feedback_message)
	playsound(heart_beast, 'sound/misc/machineno.ogg', 100, FALSE, -1)

	// Clear listener but keep task
	clear_listener()

/datum/component/chimeric_heart_beast/proc/upgrade_language_tier()
	if(current_language_progress >= max_language_progress && language_tier != max_language_tier)
		language_tier++
		heart_beast.visible_message(span_notice("[heart_beast] seems to resonate with newfound understanding!"))
		playsound(heart_beast, 'sound/misc/machinelong.ogg', 100, FALSE, -1)

/datum/component/chimeric_heart_beast/proc/get_tier_feedback(type, score)
	var/list/success_responses = list()
	var/list/failure_responses = list()

	//25% increased chance per language tier to give extra feedback on how good answers are.
	if(prob(language_tier * 25))
		switch(score)
			if(0 to 49)
				heart_beast.visible_message(span_warning("[heart_beast] seems only moderately satisfied."))
			if(50 to 74)
				heart_beast.visible_message(span_notice("[heart_beast] pulses gently, seeming satisfied."))
			if(75 to 100)
				heart_beast.visible_message(span_cult("[heart_beast] pulses strongly, seeming deeply satisfied!"))

	switch(language_tier)
		if(1)
			success_responses = list(
				"Grok...",
				"Know... yes...",
				"Pattern... good...",
				"Understand... flow..."
			)
			failure_responses = list(
				"Bad... pattern...",
				"No... know...",
				"Wrong... shape...",
				"Confuse... RrRrrhhh..."
			)
		if(2)
			success_responses = list(
				"Understanding flows...",
				"Knowledge accepted.",
				"The pattern clarifies.",
				"Yes... I see..."
			)
			failure_responses = list(
				"Incomprehensible...",
				"The meaning eludes...",
				"Pattern unclear.",
				"Not right..."
			)
		if(3)
			success_responses = list(
				"The understanding flows gracefully.",
				"Your knowledge is accepted with gratitude.",
				"The pattern becomes beautifully clear.",
				"I comprehend your meaning fully."
			)
			failure_responses = list(
				"Your meaning remains obscure to me.",
				"The pattern fails to resolve clearly.",
				"I cannot extract understanding from this.",
				"This answer lacks coherence."
			)
		if(4)
			success_responses = list(
				"The essence of understanding flows through me with perfect clarity.",
				"Your wisdom is gratefully accepted and integrated into my being.",
				"The grand pattern of existence clarifies before our shared consciousness.",
				"With this knowledge, we approach true unity of thought and purpose."
			)
			failure_responses = list(
				"Even at our heightened state, this answer fails to convey meaningful understanding.",
				"The pattern remains frustratingly opaque despite our connection.",
				"This response lacks the coherence expected at our level of communion.",
				"I cannot integrate this fragmented thought into our shared understanding."
			)

	if(type == "success")
		return pick(success_responses)
	else
		return pick(failure_responses)

// Task datums
/datum/flesh_task
	var/question
	var/min_words = 1
	var/max_words = 50
	var/preferred_punctuation = "?"
	var/list/answer_keywords = list()

/datum/flesh_task/knowledge
	var/datum/flesh_concept/concept

/datum/flesh_task/knowledge/New(language_tier, var/obj/structure/roguemachine/chimeric_heart_beast/heart_beast)
	. = ..()
	var/list/possible_concepts = list()
	for(var/datum/flesh_trait/trait in heart_beast.traits)
		possible_concepts += trait.liked_concepts

	if(possible_concepts.len)
		var/concept_type = pick(possible_concepts)
		concept = new concept_type()
	else
		// Fallback just in case
		concept = pick(new /datum/flesh_concept/identity(), new /datum/flesh_concept/unity())

	answer_keywords = concept.answer_keywords.Copy()
	question = pick(concept.tier_questions[language_tier])

	// Adjust parameters based on traits
	for(var/datum/flesh_trait/trait in heart_beast.traits)
		if(trait.preferred_approaches["min_words"])
			min_words = trait.preferred_approaches["min_words"]
		if(trait.preferred_approaches["max_words"])
			max_words = trait.preferred_approaches["max_words"]
		if(trait.preferred_approaches["punctuation"])
			preferred_punctuation = trait.preferred_approaches["punctuation"]
