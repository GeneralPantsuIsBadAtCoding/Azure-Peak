/obj/structure/roguemachine/chimeric_heart_beast
	var/datum/flesh_archetype/archetype
	var/list/datum/flesh_trait/traits = list()
	var/list/datum/flesh_quirk/quirks = list()
	var/list/identified_traits = list() // Traits players have figured out
	var/list/identified_quirks = list() // Quirks players have figured out
	var/royal_title = "" // For royal quirk
	var/discharge_color = "#ffffff" // Current discharge color
	var/understanding_bonus = 0 // Bonus from correctly identifying traits/quirks
	icon = 'icons/obj/structures/heart_beast.dmi'
	icon_state = "heart_beast"
	flags_1 = HEAR_1
	pixel_x = -32

/obj/structure/roguemachine/chimeric_heart_beast/proc/initialize_personality()
	// Pick random archetype
	var/archetype_types = list(
		/datum/flesh_archetype/fearful,
		/datum/flesh_archetype/authoritarian, 
		/datum/flesh_archetype/aggressive,
		/datum/flesh_archetype/arbitrary,
		/datum/flesh_archetype/inquisitive,
		/datum/flesh_archetype/split_personality
	)
	var/archetype_type = pick(archetype_types)
	archetype = new archetype_type()

	// Pick 2 non-conflicting traits
	var/list/available_traits = archetype.possible_traits.Copy()
	while(traits.len < 2 && available_traits.len)
		var/trait_type = pick(available_traits)
		available_traits -= trait_type

		var/datum/flesh_trait/candidate = new trait_type()
		var/valid = TRUE

		// Check for conflicts with existing traits
		for(var/datum/flesh_trait/existing in traits)
			if(trait_type in existing.conflicting_traits)
				valid = FALSE
				break
			if(existing.type in candidate.conflicting_traits)
				valid = FALSE
				break

		if(valid)
			traits += candidate

	// Pick 3 non-conflicting quirks with rarity consideration
	var/list/available_quirks = archetype.possible_quirks.Copy()
	var/attempts = 0
	while(quirks.len < 3 && available_quirks.len && attempts < 10)
		attempts++

		// Weight by rarity (lower rarity = more common)
		var/list/weighted_quirks = list()
		for(var/quirk_type in available_quirks)
			var/datum/flesh_quirk/temp = new quirk_type()
			weighted_quirks[quirk_type] = temp.rarity
			qdel(temp)

		var/quirk_type = pickweight(weighted_quirks)
		available_quirks -= quirk_type

		var/datum/flesh_quirk/candidate = new quirk_type()
		var/valid = TRUE

		// Check for conflicts
		for(var/datum/flesh_quirk/existing in quirks)
			if(quirk_type in existing.conflicting_quirks)
				valid = FALSE
				break
			if(existing.type in candidate.conflicting_quirks)
				valid = FALSE
				break

		if(valid)
			quirks += candidate

	// Set discharge color if applicable
	if(locate(/datum/flesh_quirk/discharge) in quirks)
		discharge_color = pick(archetype.discharge_colors)

	// Set royal title if applicable
	if(locate(/datum/flesh_quirk/royal) in quirks)
		royal_title = pick("Majesty", "Great One", "Master", "Overlord", "Eminence")

	var/list/debug_info = list()
	debug_info += "Archetype: [archetype.name]"
	debug_info += "Traits:"
	for(var/datum/flesh_trait/trait in traits)
		debug_info += "  - [trait.name]"
	debug_info += "Quirks:"
	for(var/datum/flesh_quirk/quirk in quirks)
		debug_info += "  - [quirk.name]"
	debug_info += "Discharge Color: [discharge_color]"
	if(royal_title)
		debug_info += "Royal Title: [royal_title]"

	to_chat(world, span_userdanger("[debug_info.Join("\n")]"))

/obj/structure/roguemachine/chimeric_heart_beast/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	// . = ..()

	if(get_dist(src, speaker) > 7)
		return
	if(speaker == src)
		return
	if(!ishuman(speaker))
		return
	SEND_SIGNAL(src, COMSIG_HEART_BEAST_HEAR, speaker, raw_message)

/obj/structure/roguemachine/chimeric_heart_beast/Initialize()
	. = ..()
	initialize_personality()
	AddComponent(/datum/component/chimeric_heart_beast)
	become_hearing_sensitive()

/obj/structure/roguemachine/chimeric_heart_beast/Destroy()
	lose_hearing_sensitivity()
	return ..()
