/datum/flesh_quirk
	var/name = "base quirk"
	var/description = "A behavioral quirk"
	var/list/conflicting_quirks = list()
	var/special_behavior = null // Proc reference for special behavior
	var/rarity = 10 // Higher = more common
	var/quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/proc/apply_language_quirk(mob/speaker, message, response_time, datum/component/chimeric_heart_beast/beast)
	return null

/datum/flesh_quirk/proc/apply_behavior_quirk(score, mob/speaker, datum/component/chimeric_heart_beast/beast)
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
	rarity = 2
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
	//special_behavior = /proc/quirk_repetitive_behavior

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
	//special_behavior = /proc/quirk_ambitious_behavior
	rarity = 1

/datum/flesh_quirk/forgetful
	name = "Forgetful"
	description = "Sometimes forgets what it was talking about"
	//special_behavior = /proc/quirk_forgetful_behavior

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
	//special_behavior = /proc/quirk_territorial_behavior

/datum/flesh_quirk/mimic
	name = "Mimic"
	description = "Tends to copy speech patterns and behaviors"
	//special_behavior = /proc/quirk_mimic_behavior
	rarity = 1

/datum/flesh_quirk/hoarder
	name = "Hoarder"
	description = "Constantly wants to acquire new items"
	//special_behavior = /proc/quirk_hoarder_behavior

/datum/flesh_quirk/stubborn
	name = "Stubborn"
	description = "Resistant to change and new ideas"
	conflicting_quirks = list(/datum/flesh_quirk/obedient)
	//special_behavior = /proc/quirk_stubborn_behavior

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
