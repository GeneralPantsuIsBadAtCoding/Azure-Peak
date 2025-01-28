/datum/virtue/utility/noble
	name = "Nobility"
	desc = "By birth, blade or brain, I am noble known to the royalty of these lands, and have all the benefits associated with it."
	added_traits = list(TRAIT_NOBLE)
	added_skills = list(/datum/skill/misc/reading = 1)
	added_stashed_items = list("Heirloom Amulet" = /obj/item/clothing/neck/roguetown/ornateamulet)

/datum/virtue/utility/noble/apply_to_human(mob/living/carbon/human/recipient)
	SStreasury.noble_incomes[recipient] += 15
	var/obj/item/pouch = new /obj/item/storage/belt/rogue/pouch/coins/rich(get_turf(recipient))
	recipient.put_in_hands(pouch, forced = TRUE)

/datum/virtue/utility/beautiful
	name = "Beautiful"
	desc = "Wherever I go, I turn heads, such is my natural beauty. I am also rather good in bed, though they always say that."
	added_traits = list(TRAIT_BEAUTIFUL,TRAIT_GOODLOVER)

/datum/virtue/utility/deadened
	name = "Deadened"
	desc = "Some terrible incident colours my past, and now, I feel nothing."
	added_traits = list(TRAIT_NOMOOD)

/datum/virtue/utility/light_steps
	name = "Light Steps"
	desc = "Years of skulking about have left my steps quiet, and my hunched gait quicker."
	added_traits = list(TRAIT_LIGHT_STEP)
	added_skills = list(list(/datum/skill/misc/sneaking, 3, 6))

/datum/virtue/utility/linguist
	name = "Intellectual"
	desc = "I've spent my life surrounded by various books or sophisticated foreigners, be it through travel or other fortunes beset on my life. I've picked up several tongues and wits, and keep a journal closeby. I can tell people's exact prowess.(+1 INT, 3 Languages, Stashed Book, Ability to Assess)"
	added_traits = list(TRAIT_INTELLECTUAL)

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
	var/lang_count = 3
	var/count = lang_count
	for(var/i = 1, i <= lang_count, i++)
		var/chosen_language = input(recipient, "Choose your extra spoken language.", "VIRTUE: [count] LEFT") as null|anything in choices
		if (chosen_language)
			var/datum/language/new_language = choices[chosen_language]
			recipient.grant_language(new_language)
			LAZYREMOVE(choices,chosen_language)
			to_chat(recipient, span_info("I recall my knowledge of [new_language.name]..."))	
			count--
	recipient.change_stat("intelligence", 1)
	added_skills = list(list(/datum/skill/misc/reading, 3, 6))
	added_stashed_items = list(
		"Quill" = /obj/item/natural/feather,
		"Scroll" = /obj/item/paper/scroll,
		"Book" = /obj/item/book/rogue/playerbook
	)

/datum/virtue/utility/deathless
	name = "Deathless"
	desc = "Some fell magick has rendered me inwardly unliving - I do not hunger, and I do not breathe."
	added_traits = list(TRAIT_NOHUNGER, TRAIT_NOBREATH)

/*/datum/virtue/utility/deathless/apply_to_human(mob/living/carbon/human/recipient)
	recipient.mob_biotypes |= MOB_UNDEAD*/

/datum/virtue/utility/crafter
	name = "Crafter's Apprentice"
	desc = "In my youth, I worked for the Artisan's Guild in a variety of disciplines. (Apprentice in most crafting skills)"
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/craft/weaponsmithing, 2, 2),
						list(/datum/skill/craft/armorsmithing, 2, 2),
						list(/datum/skill/craft/blacksmithing, 2, 2),
						list(/datum/skill/craft/carpentry, 2, 2),
						list(/datum/skill/craft/masonry, 2, 2),
						list(/datum/skill/craft/traps, 2, 2),
						list(/datum/skill/craft/engineering, 2, 2),
						list(/datum/skill/misc/sewing, 2, 2),
						list(/datum/skill/craft/tanning, 2, 2),
						list(/datum/skill/craft/smelting, 2, 2),
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
	if(!eyes)
		return
	eyes.see_in_dark = 12
	eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_DARKVISION
	recipient.update_sight()

/datum/virtue/utility/performer
	name = "Performer"
	desc = "Music, artistry and the act of showmanship carried me through life. I've hidden a favorite instrument of mine, know how to please anyone I touch, and how to crack the eggs of hecklers."
	added_traits = list(TRAIT_NUTCRACKER,TRAIT_GOODLOVER)

/datum/virtue/utility/performer/apply_to_human(mob/living/carbon/human/recipient)
	added_skills = list(list(/datum/skill/misc/music, 3, 6))
	var/list/instruments = list()
	for(var/path in subtypesof(/obj/item/rogue/instrument))
		var/obj/item/rogue/instrument/instr = path
		instruments[instr.name] = path
	var/item = input(recipient, "What instrument did I stash?", "STASH") as null|anything in instruments
	if(item)
		var/instr = instruments[item]
		var/obj/item/rogue/instrument/I = instr
		recipient.mind?.special_items[I.name] = instr
