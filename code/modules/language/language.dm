#define SCRAMBLE_CACHE_LEN 50 //maximum of 50 specific scrambled lines per language

/*
	Datum based languages. Easily editable and modular.
*/

/datum/language
	var/name = "an unknown language"  // Fluff name of language if any.
	var/desc = ""          // Short description for 'Check Languages'.
	var/speech_verb = "says"          // 'says', 'hisses', 'farts'.
	var/ask_verb = "asks"             // Used when sentence ends in a ?
	var/exclaim_verb = "exclaims"     // Used when sentence ends in a !
	var/whisper_verb = "whispers"     // Optional. When not specified speech_verb + quietly/softly is used instead.
	var/list/signlang_verb = list("signs", "gestures") // list of emotes that might be displayed if this language has NONVERBAL or SIGNLANG flags
	var/key                           // Character used to speak in language
	// If key is null, then the language isn't real or learnable.
	var/flags                         // Various language flags.
	var/list/syllables                // Used when scrambling text for a non-speaker.
	var/sentence_chance = 5      // Likelihood of making a new sentence after each syllable.
	var/space_chance = 55        // Likelihood of getting a space in the random scramble string
	var/list/spans = list()
	var/list/scramble_cache = list()
	var/default_priority = 0          // the language that an atom knows with the highest "default_priority" is selected by default.
	var/associated_skill = 0

	// if you are seeing someone speak popcorn language, then something is wrong.
	var/icon = 'icons/misc/language.dmi'
	var/icon_state = "popcorn"

/datum/language/proc/display_icon(atom/movable/hearer)
	var/understands = hearer.has_language(src.type)
	if(flags & LANGUAGE_HIDE_ICON_IF_UNDERSTOOD && understands)
		return FALSE
	if(flags & LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD && !understands)
		return FALSE
	return TRUE

// /datum/language/proc/get_icon()
// 	var/datum/asset/spritesheet/sheet = get_asset_datum(/datum/asset/spritesheet/goonchat)
// 	return sheet.icon_tag("language-[icon_state]")

/datum/language/proc/get_random_name(gender, name_count=2, syllable_count=4, syllable_divisor=2)
	if(!syllables || !syllables.len)
		if(gender==FEMALE)
			return capitalize(pick(GLOB.first_names_female)) + " " + capitalize(pick(GLOB.last_names))
		else
			return capitalize(pick(GLOB.first_names_male)) + " " + capitalize(pick(GLOB.last_names))

	var/full_name = ""
	var/new_name = ""

	for(var/i in 0 to name_count)
		new_name = ""
		var/Y = rand(FLOOR(syllable_count/syllable_divisor, 1), syllable_count)
		for(var/x in Y to 0)
			new_name += pick(syllables)
		full_name += " [capitalize(lowertext(new_name))]"

	return "[trim(full_name)]"

/datum/language/proc/check_cache(input)
	var/lookup = scramble_cache[input]
	if(lookup)
		scramble_cache -= input
		scramble_cache[input] = lookup
	. = lookup

/datum/language/proc/add_to_cache(input, scrambled_text)
	// Add it to cache, cutting old entries if the list is too long
	scramble_cache[input] = scrambled_text
	if(scramble_cache.len > SCRAMBLE_CACHE_LEN)
		scramble_cache.Cut(1, scramble_cache.len-SCRAMBLE_CACHE_LEN-1)

/datum/language/proc/scramble(input)

	if(!syllables || !syllables.len)
		if(!signlang_verb || !signlang_verb.len)
			return stars(input)
		else
			return "*[pick(signlang_verb)]"

	// If the input is cached already, move it to the end of the cache and return it
	var/lookup = check_cache(input)
	if(lookup)
		return lookup

	var/input_size = length(input)
	var/scrambled_text = ""
	var/capitalize = TRUE

	while(length(scrambled_text) < input_size)
		var/next = pick(syllables)
		if(capitalize)
			next = capitalize(next)
			capitalize = FALSE
		scrambled_text += next
		var/chance = rand(100)
		if(chance <= sentence_chance)
			scrambled_text += ". "
			capitalize = TRUE
		else if(chance > sentence_chance && chance <= space_chance)
			scrambled_text += " "

	scrambled_text = trim(scrambled_text)
	var/ending = copytext(scrambled_text, length(scrambled_text))
	if(ending == ".")
		scrambled_text = copytext(scrambled_text,1,length(scrambled_text)-1)
	var/input_ending = copytext(input, input_size)
	if(input_ending in list("!","?","."))
		scrambled_text += input_ending

	add_to_cache(input, scrambled_text)

	return scrambled_text

/datum/language/proc/get_spoken_verb(msg_end)
	switch(msg_end)
		if("!")
			return exclaim_verb
		if("?")
			return ask_verb
	return speech_verb

/datum/language/proc/scramble_for_speaker(message, skill_level = 0)
	// Expert speakers and native speakers have perfect speech
	if(skill_level >= 4 || skill_level == 0)
		return message

	// Intermediate speakers get partial scrambling
	var/list/words = splittext(message, " ")
	var/scrambled_text = ""

	for(var/word in words)
		var/word_length = length(word)
		var/punctuation = ""

		// Preserve trailing punctuation
		if(word_length > 1)
			var/last_char = copytext(word, word_length, word_length + 1)
			if(last_char in list(".", ",", "!", "?", ";", ":"))
				punctuation = last_char
				word = copytext(word, 1, word_length)
				word_length--

		// Calculate scramble chance based on skill level and word length
		var/scramble_chance = 0

		switch(skill_level)
			if(1) // Novice
				scramble_chance = max(20, (word_length - 1) * 10) // +10% per extra character beyond 3
			if(2) // Apprentice
				scramble_chance = max(20, (word_length - 3) * 10)
			if(3) // Journeyman
				scramble_chance = max(10, (word_length - 7) * 10)

		if(prob(scramble_chance))
			var/lookup = check_cache(word)
			// If it's already in the cache, don't generate a new scramble for that word. Keeps things consistent.
			word = lookup ? lookup : generate_scrambled_word(word, skill_level)

		// Re-add punctuation and space
		scrambled_text += word + punctuation + " "

	return trim(scrambled_text)

/datum/language/proc/generate_scrambled_word(word, skill_level)
	var/input_size = length(word)
	var/scrambled_word = ""
	var/capitalize = (uppertext(copytext(word, 1, 2)) == copytext(word, 1, 2))

	// Determine scrambling intensity based on skill level
	var/syllable_count = 0
	var/max_syllables = 0
	var/quality_mod = 0

	switch(skill_level)
		if(1)
			max_syllables = rand(3, 5)
			quality_mod = 5
		if(2)
			max_syllables = rand(2, 4)
			quality_mod = 15
		if(3)
			max_syllables = rand(1, 3)
			quality_mod = 25

	while(length(scrambled_word) < input_size && syllable_count < max_syllables)
		var/next = pick(syllables)
		scrambled_word += next
		syllable_count++

		// Higher skills have better syllable selection
		if(prob(quality_mod))
			break

	// Fill remaining characters if needed
	while(length(scrambled_word) < input_size)
		scrambled_word += pick(syllables)

	// Trim to original word length
	scrambled_word = copytext(scrambled_word, 1, input_size + 1)

	// Maintain original capitalization
	if(capitalize)
		scrambled_word = capitalize(scrambled_word)

	// Add to cache for efficiency, if the same word comes up and it rolls for scramble, it -should- scramble as the same thing.
	add_to_cache(word, scrambled_word)
	return scrambled_word

#undef SCRAMBLE_CACHE_LEN
