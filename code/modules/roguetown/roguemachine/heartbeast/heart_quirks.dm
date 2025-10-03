/datum/flesh_quirk
	var/name = "base quirk"
	var/description = "A behavioral quirk"
	var/list/conflicting_quirks = list()
	var/rarity = 10 // Higher = more common
	var/quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/proc/apply_language_quirk(mob/speaker, message, response_time, datum/component/chimeric_heart_beast/beast)
	return null

/datum/flesh_quirk/proc/apply_behavior_quirk(score, mob/speaker, datum/component/chimeric_heart_beast/beast)
	return null

/datum/flesh_quirk/proc/apply_environment_quirk(list/visible_turfs, datum/component/chimeric_heart_beast/beast)
	return null

/datum/flesh_quirk/obedient
	name = "Obedient"
	description = "Can be intimidated into compliance"
	conflicting_quirks = list(/datum/flesh_quirk/stubborn, /datum/flesh_quirk/timid, /datum/flesh_quirk/curious)
	quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/obedient/apply_language_quirk(mob/speaker, message, response_time, datum/component/chimeric_heart_beast/beast)
	var/list/effects = list()
	var/last_char = copytext(message, -1)

	effects["punctuation_override"] = "!"

	if(last_char != "!")
		effects["score_penalty"] = 25
		effects["happiness_multiplier"] = 0

	return effects

/datum/flesh_quirk/curious
	name = "Curious"
	description = "Might be pleased by unexpected but interesting answers"
	conflicting_quirks = list(/datum/flesh_quirk/timid, /datum/flesh_quirk/obedient)
	rarity = 5
	quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/curious/apply_language_quirk(mob/speaker, message, response_time, datum/component/chimeric_heart_beast/beast)
	var/list/effects = list()
	var/last_char = copytext(message, -1)

	effects["punctuation_override"] = "?"

	if(last_char != "?")
		effects["score_penalty"] = 25
		effects["happiness_multiplier"] = 0

	return effects

/datum/flesh_quirk/impatient
	name = "Impatient"
	description = "Prefers quick responses and gets frustrated by delays"
	conflicting_quirks = list(/datum/flesh_quirk/patient)
	quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/impatient/apply_language_quirk(mob/speaker, message, response_time, datum/component/chimeric_heart_beast/beast)
	var/list/effects = list()

	if(response_time > beast.response_time_threshold)
		effects["score_penalty"] = 25
		effects["happiness_multiplier"] = 0.5

	return effects

/datum/flesh_quirk/royal
	name = "Royal"
	description = "Demands to be addressed by a specific title"
	quirk_type = QUIRK_LANGUAGE
	rarity = 5

/datum/flesh_quirk/royal/apply_language_quirk(mob/speaker, message, datum/component/chimeric_heart_beast/beast, response_time)
	var/list/effects = list()

	// Royal quirk only manifests at tier 2 and above
	if(beast.language_tier < 2)
		return effects

	var/obj/structure/roguemachine/chimeric_heart_beast/heart_beast = beast.heart_beast
	var/royal_title = heart_beast.royal_title

	var/has_title = findtext(lowertext(message), lowertext(royal_title))
	if(!has_title)
		effects["score_penalty"] = 25
		effects["happiness_multiplier"] = 0

		var/feedback_chance = beast.language_tier * 25
		// Tier-appropriate feedback
		if(prob(feedback_chance))
			switch(beast.language_tier)
				if(2)
					heart_beast.visible_message(span_warning("[heart_beast] seems offended!"))
				if(3)
					heart_beast.visible_message(span_warning("[heart_beast] appears deeply offended!"))
				if(4)
					heart_beast.visible_message(span_cultlarge("[heart_beast] radiates displeasure!"))

	return effects

/datum/flesh_quirk/discharge
	name = "Discharge"
	description = "Produces colored discharge when emotional"
	quirk_type = QUIRK_BEHAVIOR

/datum/flesh_quirk/discharge/apply_behavior_quirk(score, mob/speaker, datum/component/chimeric_heart_beast/beast)
	if(beast.happiness >= beast.max_happiness * 0.75)
		return

	var/happiness_percentage = (1 - (beast.happiness / beast.max_happiness))
	var/discharge_chance = calculate_discharge_chance(beast.language_tier, score, happiness_percentage)

	if(prob(discharge_chance))
		beast.trigger_discharge_effect()

/datum/flesh_quirk/discharge/proc/calculate_discharge_chance(language_tier, score, happiness_percentage)
	var/base_chance = 0

	switch(language_tier)
		if(1)
			base_chance = 60
		if(2)
			base_chance = 40
		if(3)
			base_chance = 25
		if(4)
			base_chance = 15

	// 26% at 74% happiness. up to 100% at 0% happiness.
	base_chance *= happiness_percentage
	// 1 at 0 or 100, 0 at 50
	var/score_modifier = 1 - (abs(score - 50) / 50)
	// Up to 200%
	base_chance *= (1 + score_modifier)

	return base_chance

/datum/flesh_quirk/repetitive
	name = "Repetitive"
	description = "Often repeats similar topics or questions"

/datum/flesh_quirk/timid
	name = "Timid"
	description = "Easily frightened by aggressive behavior"
	conflicting_quirks = list(/datum/flesh_quirk/royal, /datum/flesh_quirk/obedient, /datum/flesh_quirk/curious)
	quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/timid/apply_language_quirk(mob/speaker, message, response_time, datum/component/chimeric_heart_beast/beast)
	var/list/effects = list()
	var/last_char = copytext(message, -1)

	//Honestly, they're happy if you say nothing at all :)
	effects["punctuation_override"] = " "
	
	if(last_char == "!")
		effects["score_penalty"] = 25
		effects["happiness_multiplier"] = 0
	else
		// Any other form of punctuation is good
		effects["score_bonus"] = 20

	return effects

/datum/flesh_quirk/ambitious
	name = "Ambitious"
	description = "Responds better to people with titles or authority"
	rarity = 1
	quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/ambitious/apply_language_quirk(mob/speaker, message, response_time, datum/component/chimeric_heart_beast/beast)
	// Too tired for this, but allow wearing a crown or circlet for this later.
	var/list/effects = list()

	if(beast.language_tier < 2)
		return effects

	if(!HAS_TRAIT(speaker, TRAIT_NOBLE))
		effects["score_penalty"] = 25
		effects["happiness_multiplier"] = 0.75
		var/feedback_chance = beast.language_tier * 20
		if(prob(feedback_chance))
			switch(beast.language_tier)
				if(3)
					heart_beast.visible_message(span_warning("[heart_beast] sneers!"))
				if(4)
					heart_beast.visible_message(span_cultlarge("[heart_beast] scoffs!"))

	return effects

/datum/flesh_quirk/forgetful
	name = "Forgetful"
	description = "Sometimes forgets what it was talking about"
	quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/forgetful/apply_language_quirk(mob/speaker, message, response_time, datum/component/chimeric_heart_beast/beast)
	var/list/effects = list()

	var/word_count = length(splittext(message, " "))
	if(word_count < 6)
		return effects

	var/actual_chance = calculate_forget_chance(beast.language_tier, beast.happiness, beast.max_happiness)

	if(prob(actual_chance))
		forget_current_interaction(beast)
		effects["happiness_multiplier"] = 0
		effects["blood_multiplier"] = 0
		effects["tech_multiplier"] = 0
		effects["score_penalty"] = 100
	return effects

/datum/flesh_quirk/forgetful/proc/calculate_forget_chance(language_tier, happiness, max_happiness)
	var/chance = forget_chance

	switch(language_tier)
		if(2)
			chance *= 0.75
		if(3)
			chance *= 0.5
		if(4)
			chance *= 0.25

	var/happiness_percent = (happiness / max_happiness) * 100
	if(happiness_percent < 25)
		chance *= 1.5
	else if(happiness_percent > 75)
		chance *= 0.75

	return chance

/datum/flesh_quirk/forgetful/proc/forget_current_interaction(datum/component/chimeric_heart_beast/beast)
	if(!beast.current_task)
		return

	if(prob(beast.language_tier * 25))
	switch(beast.language_tier)
		if(1)
			beast.heart_beast.say("What...?")
		if(2)
			beast.heart_beast.say("I've forgotten...")
		if(3)
			beast.heart_beast.say("My thoughts have scattered...")
		if(4)
			beast.heart_beast.say("The thread of our discourse has escaped me...")

	beast.current_task = null
	beast.clear_listener()

	// The next task will come very swiftly
	beast.last_task_time = world.time - (beast.task_cooldown * 0.75)

/datum/flesh_quirk/affectionate
	name = "Affectionate"
	description = "Seeks physical proximity and gentle treatment"
	quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/affectionate/apply_language_quirk(mob/speaker, message, response_time, datum/component/chimeric_heart_beast/beast)
	var/list/effects = list()
	var/distance = get_dist(beast.heart_beast, speaker)
	to_chat(world, span_userdanger("DISTANCE = [distance]"))

	if(distance > 1)
		effects["score_penalty"] = 25
		effects["happiness_multiplier"] = 0

	return effects

/datum/flesh_quirk/territorial
	name = "Territorial"
	description = "Protective of its space and possessions"
	quirk_type = QUIRK_ENVIRONMENT
	var/last_attack_time = 0
	var/attack_cooldown = 0
	var/saw_meat = FALSE

/datum/flesh_quirk/territorial/apply_environment_quirk(list/visible_turfs, datum/component/chimeric_heart_beast/beast)
	// Check cooldown
	if(world.time < last_attack_time + attack_cooldown)
		return

	if(beast.heart_beast.recently_fed)
		attack_cooldown = 120 SECONDS
		last_attack_time = world.time
		beast.heart_beast.recently_fed = FALSE
		return

	// Calculate happiness percentage (1-100)
	var/happiness_percent = round((beast.happiness / beast.max_happiness) * 100)

	if(happiness_percent >= 75)
		return

	var/attack_prob = 100 - happiness_percent
	var/attack_prob_fraction = attack_prob / 100
	var/cooldown_lower_limit = round(30 * attack_prob_fraction)
	var/cooldown_upper_limit = cooldown_lower_limit * 2
	var/cooldown = (rand(cooldown_lower_limit, cooldown_upper_limit) SECONDS)

	// Look for mobs within 2 tiles in visible turfs
	var/attack_triggered = FALSE
	for(var/turf/T in visible_turfs)
		if(get_dist(beast.heart_beast, T) > 2)
			continue

		for(var/mob/living/L in T)
			if(L.stat == DEAD)
				continue
			var/has_meat = FALSE
			if(!saw_meat)
				for(var/obj/item/I in L.held_items)
					if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat))
						if(I.item_flags & FRESH_FOOD_ITEM)
							has_meat = TRUE
							break

				if(has_meat)
					cooldown = 20 SECONDS
					last_attack_time = world.time
					attack_triggered = TRUE
					saw_meat = TRUE
					break

			// Calculate attack probability based on unhappiness
			if(prob(attack_prob))
				trigger_territorial_attack(L, beast)
				attack_triggered = TRUE
				saw_meat = FALSE
				break

		if(attack_triggered)
			break

	if(attack_triggered)
		last_attack_time = world.time
		attack_cooldown = cooldown

/datum/flesh_quirk/territorial/proc/trigger_territorial_attack(mob/living/target, datum/component/chimeric_heart_beast/beast)
	target.apply_status_effect(/datum/status_effect/territorial_rage, beast.heart_beast)
	beast.heart_beast.visible_message(span_userdanger("Tendrils from [beast.heart_beast] lash out at [target]!"))

/datum/flesh_quirk/mimic
	name = "Mimic"
	description = "Tends to copy speech patterns and behaviors"
	rarity = 1

/datum/flesh_quirk/hoarder
	name = "Hoarder"
	description = "Constantly wants to acquire new items"

/datum/flesh_quirk/stubborn
	name = "Stubborn"
	description = "Resistant to change and new ideas"
	conflicting_quirks = list(/datum/flesh_quirk/obedient)

/datum/flesh_quirk/patient
	name = "Patient"
	description = "Willing to wait for thoughtful responses"
	conflicting_quirks = list(/datum/flesh_quirk/impatient)
	quirk_type = QUIRK_LANGUAGE
	rarity = 5

/datum/flesh_quirk/patient/apply_language_quirk(mob/speaker, message, response_time, datum/component/chimeric_heart_beast/beast)
	var/list/effects = list()

	if(response_time < beast.response_time_threshold)
		effects["score_penalty"] = 25
		effects["happiness_multiplier"] = 0

	return effects
