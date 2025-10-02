/datum/flesh_quirk
	var/name = "base quirk"
	var/description = "A behavioral quirk"
	var/list/conflicting_quirks = list()
	var/special_behavior = null // Proc reference for special behavior
	var/rarity = 1 // Higher = less common
	var/quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/proc/apply_language_quirk(mob/speaker, message, datum/component/chimeric_heart_beast/beast)
	return null

/datum/flesh_quirk/obedient
	name = "Obedient"
	description = "Can be intimidated into compliance"
	conflicting_quirks = list(/datum/flesh_quirk/stubborn, /datum/flesh_quirk/timid, /datum/flesh_quirk/curious)
	quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/obedient/apply_language_quirk(mob/speaker, message, datum/component/chimeric_heart_beast/beast)
	var/list/effects = list()
	var/last_char = copytext(message, -1)

	effects["punctuation_override"] = "!"

	if(last_char != "!")
		effects["score_penalty"] = 25
		effects["happiness_multiplier"] = 0.5

	return effects

/datum/flesh_quirk/curious
	name = "Curious"
	description = "Might be pleased by unexpected but interesting answers"
	conflicting_quirks = list(/datum/flesh_quirk/timid, /datum/flesh_quirk/obedient)
	rarity = 2
	quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/curious/apply_language_quirk(mob/speaker, message, datum/component/chimeric_heart_beast/beast)
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
	//special_behavior = /proc/quirk_impatient_behavior

/datum/flesh_quirk/royal
	name = "Royal"
	description = "Demands to be addressed by a specific title"
	//special_behavior = /proc/quirk_royal_behavior
	rarity = 3

/datum/flesh_quirk/discharge
	name = "Discharge"
	description = "Produces colored discharge when emotional"
	//special_behavior = /proc/quirk_discharge_behavior

/datum/flesh_quirk/repetitive
	name = "Repetitive"
	description = "Often repeats similar topics or questions"
	//special_behavior = /proc/quirk_repetitive_behavior

/datum/flesh_quirk/timid
	name = "Timid"
	description = "Easily frightened by aggressive behavior"
	conflicting_quirks = list(/datum/flesh_quirk/royal, /datum/flesh_quirk/obedient, /datum/flesh_quirk/curious)
	quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/timid/apply_language_quirk(mob/speaker, message, datum/component/chimeric_heart_beast/beast)
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
	rarity = 2

/datum/flesh_quirk/forgetful
	name = "Forgetful"
	description = "Sometimes forgets what it was talking about"
	//special_behavior = /proc/quirk_forgetful_behavior

/datum/flesh_quirk/affectionate
	name = "Affectionate"
	description = "Seeks physical proximity and gentle treatment"
	quirk_type = QUIRK_LANGUAGE

/datum/flesh_quirk/affectionate/apply_language_quirk(mob/speaker, message, datum/component/chimeric_heart_beast/beast)
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
	rarity = 3

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
	//special_behavior = /proc/quirk_patient_behavior
	rarity = 2
