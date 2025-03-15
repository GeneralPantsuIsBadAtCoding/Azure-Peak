/datum/virtue/utility/noble
	name = "Nobility"
	desc = "By birth, blade or brain, I am noble known to the royalty of these lands, and have all the benefits associated with it."
	added_traits = list(TRAIT_NOBLE)
	added_skills = list(list(/datum/skill/misc/reading, 1, 6))
	added_stashed_items = list("Heirloom Amulet" = /obj/item/clothing/neck/roguetown/ornateamulet/noble)

/datum/virtue/utility/noble/apply_to_human(mob/living/carbon/human/recipient)
	SStreasury.noble_incomes[recipient] += 15
	var/obj/item/pouch = new /obj/item/storage/belt/rogue/pouch/coins/virtuepouch(get_turf(recipient))
	recipient.put_in_hands(pouch, forced = TRUE)

/datum/virtue/utility/beautiful
	name = "Beautiful"
	desc = "Wherever I go, I turn heads, such is my natural beauty. I am also rather good in bed, though they always say that."
	custom_text = "Incompatible with Ugly virtue."
	added_traits = list(TRAIT_BEAUTIFUL,TRAIT_GOODLOVER)

/datum/virtue/utility/beautiful/handle_traits(mob/living/carbon/human/recipient)
	..()
	if(HAS_TRAIT(recipient, TRAIT_UNSEEMLY))
		to_chat(recipient, "Your attractiveness is cancelled out! You become normal.")
		REMOVE_TRAIT(recipient, TRAIT_BEAUTIFUL, TRAIT_VIRTUE)
		REMOVE_TRAIT(recipient, TRAIT_UNSEEMLY, TRAIT_VIRTUE)

/datum/virtue/utility/deadened
	name = "Deadened"
	desc = "Some terrible incident colours my past, and now, I feel nothing."
	added_traits = list(TRAIT_NOMOOD)

/datum/virtue/utility/light_steps
	name = "Light Steps"
	desc = "Years of skulking about have left my steps quiet, and my hunched gait quicker."
	added_traits = list(TRAIT_LIGHT_STEP)
	added_skills = list(list(/datum/skill/misc/sneaking, 3, 6))

/datum/virtue/utility/resident
	name = "Resident"
	desc = "I'm a resident of Azure Peak. I have an account in the city's treasury and a home in the city."
	added_traits = list(TRAIT_RESIDENT)

/datum/virtue/utility/linguist
	name = "Intellectual"
	desc = "I've spent my life surrounded by various books or sophisticated foreigners, be it through travel or other fortunes beset on my life. I've picked up several tongues and wits, and keep a journal closeby. I can tell people's exact prowess."
	custom_text = "Maximizes Assess benefits with a bonus of the target's Stats. Allows the choice of 3 languages to learn upon joining. +1 INT."
	added_traits = list(TRAIT_INTELLECTUAL)
	added_skills = list(list(/datum/skill/misc/reading, 3, 6))
	added_stashed_items = list(
		"Quill" = /obj/item/natural/feather,
		"Scroll" = /obj/item/paper/scroll,
		"Book" = /obj/item/book/rogue/playerbook
	)

/datum/virtue/utility/linguist/apply_to_human(mob/living/carbon/human/recipient)
	recipient.change_stat("intelligence", 1)
	addtimer(CALLBACK(src, .proc/linguist_apply, recipient), 50)

/datum/virtue/utility/linguist/proc/linguist_apply(mob/living/carbon/human/recipient)
	var/static/list/selectable_languages = list(
		/datum/language/elvish,
		/datum/language/dwarvish,
		/datum/language/orcish, 
		/datum/language/hellspeak,
		/datum/language/draconic,
		/datum/language/celestial,
		/datum/language/grenzelhoftian
	)
		
	var/list/choices = list()
	for(var/language_type in selectable_languages)
		if(recipient.has_language(language_type))
			continue
		var/datum/language/a_language = new language_type()
		choices[a_language.name] = language_type

	if(length(choices))	//If this isn't true then we have no new languages learn -- we probably picked archivist
		var/lang_count = 3
		var/count = lang_count
		for(var/i in 1 to lang_count)
			var/chosen_language = input(recipient, "Choose your extra spoken language.", "VIRTUE: [count] LEFT") as null|anything in choices
			if(chosen_language)
				var/language_type = choices[chosen_language]
				recipient.grant_language(language_type)
				choices -= chosen_language
				to_chat(recipient, span_info("I recall my knowledge of [chosen_language]..."))
				count--

/datum/virtue/utility/deathless
	name = "Deathless"
	desc = "Some fell magick has rendered me inwardly unliving - I do not hunger, and I do not breathe."
	added_traits = list(TRAIT_NOHUNGER, TRAIT_NOBREATH)

/*/datum/virtue/utility/deathless/apply_to_human(mob/living/carbon/human/recipient)
	recipient.mob_biotypes |= MOB_UNDEAD*/

/datum/virtue/utility/blacksmith
	name = "Blacksmith's Apprentice"
	desc = "In my youth, I worked under a skilled blacksmith, honing my skills with an anvil."
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/craft/weaponsmithing, 2, 2),
						list(/datum/skill/craft/armorsmithing, 2, 2),
						list(/datum/skill/craft/blacksmithing, 2, 2),
						list(/datum/skill/craft/smelting, 2, 2)
	)

/datum/virtue/utility/hunter
	name = "Hunter's Apprentice"
	desc = "In my youth, I trained under a skilled hunter, learning how to butcher animals and work with leather/hide."
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/craft/traps, 2, 2),
						list(/datum/skill/labor/butchering, 2, 2),
						list(/datum/skill/misc/sewing, 2, 2),
						list(/datum/skill/craft/tanning, 2, 2),
						list(/datum/skill/misc/tracking, 2, 2)
	)

/datum/virtue/utility/artificer
	name = "Artificer's Apprentice"
	desc = "In my youth, I worked under a skilled artificer, studying construction and engineering."
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/craft/carpentry, 2, 2),
						list(/datum/skill/craft/masonry, 2, 2),
						list(/datum/skill/craft/engineering, 2, 2),
						list(/datum/skill/craft/smelting, 2, 2)
	)

/datum/virtue/utility/physician
	name = "Physician's Apprentice"
	desc = "In my youth, I worked under a skilled physician, studying medicine and alchemy."
	added_stashed_items = list("Medicine Pouch" = /obj/item/storage/belt/rogue/pouch/medicine)
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/craft/alchemy, 2, 2),
						list(/datum/skill/misc/alchemy, 2, 2),
						list(/datum/skill/misc/medicine, 2, 2)
	)

/datum/virtue/utility/feral_appetite
	name = "Feral Appetite"
	desc = "Raw, toxic or spoiled food doesn't bother my superior digestive system."
	added_traits = list(TRAIT_NASTY_EATER)

/datum/virtue/utility/night_vision
	name = "Night-eyed"
	desc = "I have eyes able to see through cloying darkness."
	added_traits = list(TRAIT_DARKVISION)

/datum/virtue/utility/performer
	name = "Performer"
	desc = "Music, artistry and the act of showmanship carried me through life. I've hidden a favorite instrument of mine, know how to please anyone I touch, and how to crack the eggs of hecklers."
	custom_text = "Comes with a stashed instrument of your choice. You choose the instrument after spawning in."
	added_traits = list(TRAIT_NUTCRACKER, TRAIT_GOODLOVER)
	added_skills = list(list(/datum/skill/misc/music, 3, 6))

/datum/virtue/utility/performer/apply_to_human(mob/living/carbon/human/recipient)
    addtimer(CALLBACK(src, .proc/performer_apply, recipient), 50)

/datum/virtue/utility/performer/proc/performer_apply(mob/living/carbon/human/recipient)
    var/list/instruments = list()
    for(var/instrument_type in subtypesof(/obj/item/rogue/instrument))
        var/obj/item/rogue/instrument/instr = new instrument_type()
        instruments[instr.name] = instrument_type
        qdel(instr)  // Clean up the temporary instance
        
    var/chosen_name = input(recipient, "What instrument did I stash?", "STASH") as null|anything in instruments
    if(chosen_name)
        var/instrument_type = instruments[chosen_name]
        recipient.mind?.special_items[chosen_name] = instrument_type

/datum/virtue/utility/larcenous
	name = "Larcenous"
	desc = "Whether it was asked of you, or by a calling for the rush deep within your hollow heart, you seek things that don't belong you. You know how to work a lock, and have stashed a ring of them, for just the occasion."
	added_stashed_items = list("Lockpick Ring" = /obj/item/lockpickring/mundane)
	added_skills = list(list(/datum/skill/misc/lockpicking, 3, 6))

/datum/virtue/utility/granary
	name = "Personal Granary"
	desc = "You've worked in or around the kitchens enough to steal away a sack of supplies that no one would surely miss, just in case. You've picked up on some cooking tips in your spare time, as well."
	added_stashed_items = list("Bag of Food" = /obj/item/storage/roguebag/food)
	added_skills = list(list(/datum/skill/craft/cooking, 3, 6))

/datum/virtue/utility/mining
	name = "Miner's Apprentice"
	desc = "The dark shafts, the damp smells of ichor and the laboring hours are no stranger to me. I keep my pickaxe and lamptern close, and have been taught how to mine well."
	added_stashed_items = list(
		"Steel Pickaxe" = /obj/item/rogueweapon/pick/steel,
		"Lamptern" = /obj/item/flashlight/flare/torch/lantern)
	added_skills = list(list(/datum/skill/labor/mining, 3, 6))

/datum/virtue/utility/ugly
	name = "Ugly"
	desc = "Be it your family's habits in and out of womb, your own choices or Xylix's cruel roll of fate, you have been left unbearable to look at. Stuck to the unseen pits and crevices of the town, you've grown used to the foul odours of lyfe that often follow you. Corpses do not stink for you, and that is all the company you might find."
	custom_text = "Incompatible with Beautiful virtue."
	added_traits = list(TRAIT_UNSEEMLY, TRAIT_NOSTINK)

/datum/virtue/utility/ugly/handle_traits(mob/living/carbon/human/recipient)
	..()
	if(HAS_TRAIT(recipient, TRAIT_BEAUTIFUL))
		to_chat(recipient, "Your repulsiveness is cancelled out! You become normal.")
		REMOVE_TRAIT(recipient, TRAIT_BEAUTIFUL, TRAIT_VIRTUE)
		REMOVE_TRAIT(recipient, TRAIT_UNSEEMLY, TRAIT_VIRTUE)

/datum/virtue/utility/secondvoice
	name = "Second Voice"
	desc = "From performance, deception, or by a need to change yourself in uncanny ways, you've acquired a second, perfect voice. You may switch between them at any point."
	custom_text = "Grants access to a new 'Virtue' tab. It will have the options for setting and changing your voice."

/datum/virtue/utility/secondvoice/apply_to_human(mob/living/carbon/human/recipient)
	recipient.verbs += /mob/living/carbon/human/proc/changevoice
	recipient.verbs += /mob/living/carbon/human/proc/swapvoice

/datum/virtue/utility/keenears
	name = "Keen Ears"
	desc = "Cowering from authorities, loved ones or by a generous gift of the gods, you've adapted a keen sense of hearing, and can identify the speakers even when they are out of sight, and their whispers are louder to you."
	added_skills = list(list(/datum/skill/misc/tracking, 3, 6))
	added_traits = list(TRAIT_KEENEARS)

/datum/virtue/utility/bronzearm_r
	name = "Bronze Arm (R)"
	desc = "Through connections or wealth, my arm had been replaced by one of bronze and gears, that can grip and hold onto things. I've learned just a bit of Engineering as a result."
	custom_text = "Replaces your Right arm with a prosthetic Bronze one. Incompatible with Wood Arm (R) vice"
	added_skills = list(list(/datum/skill/craft/engineering, 1, 6))

/datum/virtue/utility/bronzearm_r/apply_to_human(mob/living/carbon/human/recipient)
	. = ..()
	var/obj/item/bodypart/O = recipient.get_bodypart(BODY_ZONE_R_ARM)
	if(O)
		O.drop_limb()
		qdel(O)
	if(recipient.charflaw)
		if(recipient.charflaw.type == /datum/charflaw/limbloss/arm_r)
			to_chat(recipient, span_info("In my foolishness I believed a sharlatan who wished to trade in my wooden arm for one of bronze. It fell apart. Now I've no arm at all."))
		else
			var/obj/item/bodypart/r_arm/prosthetic/bronzeright/L = new()
			L.attach_limb(recipient)

/datum/virtue/utility/bronzearm_l
	name = "Bronze Arm (L)"
	desc = "Through connections or wealth, my arm had been replaced by one of bronze and gears, that can grip and hold onto things. I've learned just a bit of Engineering as a result."
	custom_text = "Replaces your Left arm with a prosthetic Bronze one. Incompatible with Wood Arm (L) vice"
	added_skills = list(list(/datum/skill/craft/engineering, 1, 6))

/datum/virtue/utility/bronzearm_l/apply_to_human(mob/living/carbon/human/recipient)
	. = ..()
	var/obj/item/bodypart/O = recipient.get_bodypart(BODY_ZONE_L_ARM)
	if(O)
		O.drop_limb()
		qdel(O)
	if(recipient.charflaw)
		if(recipient.charflaw.type == /datum/charflaw/limbloss/arm_l)
			to_chat(recipient, span_info("In my foolishness I believed a sharlatan who wished to trade in my wooden arm for one of bronze. It fell apart. Now I've no arm at all."))
		else
			var/obj/item/bodypart/l_arm/prosthetic/bronzeleft/L = new()
			L.attach_limb(recipient)

//HERETIC VIRTUES

/datum/virtue/heretic/seer
	name = "(ASCENDANT) Seer"
	desc = "You've spent your days studying the tales writ and told by the Ecclesiarchy's rejects and priests alike. You've grown to tell the followers by hunch and sight. They give themselves away so easily in this world slowly brewing to a fester."
	added_traits = list(TRAIT_HERETIC_SEER)
