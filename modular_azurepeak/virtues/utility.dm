/datum/virtue/utility/noble
	name = "Nobility"
	desc = "By birth, blade or brain, I am noble known to the royalty of these lands, and have all the benefits associated with it."
	added_traits = list(TRAIT_NOBLE)
	added_skills = list(/datum/skill/misc/reading = 1)

/datum/virtue/utility/noble/apply_to_human(mob/living/carbon/human/recipient)
	SStreasury.noble_incomes[recipient] += 15

/datum/virtue/utility/beautiful
	name = "Beautiful"
	desc = "Wherever I go, I turn heads, such is my natural beauty."
	added_traits = list(TRAIT_BEAUTIFUL)

/datum/virtue/utility/deadened
	name = "Deadened"
	desc = "Some terrible incident colours my past, and now, I feel nothing."
	added_traits = list(TRAIT_NOMOOD)

/datum/virtue/utility/light_steps
	name = "Light Steps"
	desc = "Years of skulking about have left my steps quiet."
	added_traits = list(TRAIT_LIGHT_STEP)
	added_skills = list(list(/datum/skill/misc/sneaking, 2, 5))

/datum/virtue/utility/linguist
	name = "Linguist"
	desc = "I've spent a while studying a foreign language, and can speak and understand it fluently."

/datum/virtue/utility/linguist/apply_to_human(mob/living/carbon/human/recipient)
	var/list/selectable_languages = list(/datum/language/elvish, /datum/language/dwarvish, /datum/language/orcish, /datum/language/hellspeak, /datum/language/draconic, /datum/language/celestial)
	var/list/choices = list()
	for(var/i = 1, i <= selectable_languages.len, i++)
		if (recipient.has_language(selectable_languages[i]))
			continue
		var/datum/language/a_language = selectable_languages[i]
		choices["[a_language.name]"] = a_language
	if (!LAZYLEN(choices))
		return // no new languages to learn - we probably picked archivist
	var/chosen_language = input(recipient, "Choose your extra spoken language.", "VIRTUE") as null|anything in choices

	if (chosen_language)
		var/datum/language/new_language = choices[chosen_language]
		recipient.grant_language(new_language)
		to_chat(recipient, span_info("I recall my knowledge of [new_language.name]..."))

/datum/virtue/utility/deathless
	name = "Deathless"
	desc = "Some fell magick has rendered me inwardly unliving - I do not hunger, and I do not breathe."
	added_traits = list(TRAIT_NOHUNGER, TRAIT_NOBREATH)

/*/datum/virtue/utility/deathless/apply_to_human(mob/living/carbon/human/recipient)
	recipient.mob_biotypes |= MOB_UNDEAD*/

/datum/virtue/utility/crafter
	name = "Crafter's Apprentice"
	desc = "In my youth, I worked for the Artisan's Guild in a variety of disciplines."
	added_skills = list(list(/datum/skill/craft/crafting, 2, 5),
						list(/datum/skill/craft/weaponsmithing, 2, 5),
						list(/datum/skill/craft/armorsmithing, 2, 5),
						list(/datum/skill/craft/blacksmithing, 2, 5),
						list(/datum/skill/craft/carpentry, 2, 5),
						list(/datum/skill/craft/masonry, 2, 5),
						list(/datum/skill/craft/traps, 2, 5),
						list(/datum/skill/craft/engineering, 2, 5),
						list(/datum/skill/misc/sewing, 2, 5),
	)

/datum/virtue/utility/feral_appetite
	name = "Feral Appetite"
	desc = "Raw, toxic or spoiled food doesn't bother my superior digestive system."
	added_traits = list(TRAIT_NASTY_EATER)

/datum/virtue/utility/night_vision
	name = "Night-eyed"
	desc = "I have eyes able to see through cloying darkness."

/datum/virtue/utility/night_vision/apply_to_human(mob/living/carbon/human/recipient)
	var/obj/item/organ/eyes/eyes = recipient.getorganslot(ORGAN_SLOT_EYES)
	if (!eyes)
		return
	eyes.lighting_alpha = min(eyes.lighting_alpha, LIGHTING_PLANE_ALPHA_DARKVISION)
	recipient.update_sight()

/datum/virtue/utility/learned
	name = "Learned"
	desc = "I am surprisingly well-read for someone of my station, and have no issue with literacy or numbers."
	added_skills = list(/datum/skill/misc/reading = 3)
	added_stashed_items = list(
		"Quill" = /obj/item/natural/feather,
		"Scroll" = /obj/item/paper/scroll,
		"Book" = /obj/item/book/rogue/playerbook
	)
