#define MAX_MUMBLEBOOP_CHARACTERS 30

// This system was ported from Concordia and modified
// Pseudo-Voice system. Vaguely TTS without being actual reliable TTS and hopefully avoiding the shortcomings of TTS.
// Gives nice ambience for when people is talking but is GENERALLY useless for information
/datum/component/mumbleboop
	var/chosen_boop // The voice type assigned by preferences
	var/volume = MUMBLEBOOP_DEFAULT_VOLUME
	var/falloff = 4.5
	var/duration = MUMBLEBOOP_DEFAULT_DURATION // Affects how fast the next phonetic will play, affects general speech speed.
	var/last_mumbleboop = 0

/datum/component/mumbleboop/Initialize(mob/living/target, volume = MUMBLEBOOP_DEFAULT_VOLUME, duration = MUMBLEBOOP_DEFAULT_DURATION)
	. = ..()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	src.volume = volume
	src.duration = duration

/datum/component/mumbleboop/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOB_POST_SAY, .proc/after_say)

/datum/component/mumbleboop/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_MOB_POST_SAY)

/datum/component/mumbleboop/proc/after_say(mob/mumblebooper, list/speech_args, list/speech_spans, list/speech_mods)
	SIGNAL_HANDLER

	last_mumbleboop = world.time
	INVOKE_ASYNC(src, .proc/handle_booping, mumblebooper, speech_args, speech_spans, speech_mods)

/datum/component/mumbleboop/proc/handle_booping(mob/living/mumblebooper, list/speech_args, list/speech_spans, list/speech_mods)
	chosen_boop = mumblebooper?.voice_type_mumble || random_voice_type(mumblebooper?.gender) // Uses the boop chosen by the player. If it's null for whatever unholy reason, it should chose a completely random voice for every single phonetic which should be funny.
	var/message = speech_args[SPEECH_MESSAGE]
	var/initial_mumbleboop_time = last_mumbleboop
	var/initial_volume = volume
	var/initial_pitch = 0 // We shouldn't use this probably. Actual Pitch variation won't be possible until the BYOND update, this stuff SUCKS. It's basically just play speed. Evidence of this will be left below, but it's not applied to the final sound.
	var/initial_falloff = falloff
	var/boop_letter = null
	var/final_boop = null
	if(speech_mods[MODE_WHISPER]) // Makes you quieter when whispering...
		initial_volume -= 25
		initial_falloff -= 5
	if(speech_spans[SPAN_YELL]) // And louder when yelling
		initial_volume += 15
		initial_pitch += 5
		initial_falloff += 3
	var/obj/item/clothing/mask/mask = mumblebooper.get_item_by_slot(ITEM_SLOT_MASK)
	if(istype(mask) && mask.lowers_pitch && !mask.mask_adjusted) // Helps muffle a little bit
		initial_pitch -= 10
	var/initial_delay = duration
	var/list/hearers = GLOB.player_list.Copy() 	// This stuff is for people that don't want to hear it
	for(var/mob/hearer as anything in hearers)
		if(hearer.client && hearer.can_hear() && hearer.client.prefs.toggles & TOGGLE_MUMBLEBOOP)
			continue
		hearers -= hearer
	var/mumbleboop_delay_cumulative = 0
	for(var/i in 1 to min(length(message), MAX_MUMBLEBOOP_CHARACTERS))
		var/volume = initial_volume
		//var/pitch = initial_pitch Disabled for now. Doesn't work as intended- seemingly anything above default is dumb sounding
		var/falloff_exponent = initial_falloff
		var/current_delay = initial_delay
		switch(lowertext(message[i])) // A super convoluted list of checks, I know. I doubt there's a better way to do it.
			if("a")
				boop_letter = "A"
			if("b")
				boop_letter = "B"
			if("c")
				boop_letter = "C"
			if("d")
				boop_letter = "D"
			if("e")
				boop_letter = "E"
			if("f")
				boop_letter = "F"
			if("g")
				boop_letter = "G"
			if("h")
				boop_letter = "H"
			if("i")
				boop_letter = "I"
			if("j")
				boop_letter = "J"
			if("k")
				boop_letter = "K"
			if("l")
				boop_letter = "L"
			if("m")
				boop_letter = "M"
			if("n")
				boop_letter = "N"
			if("o")
				boop_letter = "O"
			if("p")
				boop_letter = "P"
			if("q")
				boop_letter = "Q"
			if("r")
				boop_letter = "R"
			if("s")
				boop_letter = "S"
			if("t")
				boop_letter = "T"
			if("u")
				boop_letter = "U"
			if("v")
				boop_letter = "V"
			if("w")
				boop_letter = "W"
			if("x")
				boop_letter = "X"
			if("y")
				boop_letter = "Y"
			if("z")
				boop_letter = "Z"
			if("!")
				volume = 0
				current_delay *= 1.5
			if("?")
				volume = 0
				current_delay *= 2
			if(",", ";", "-")
				volume = 0
				current_delay *= 1.5
			if(".")
				volume = 0
				current_delay *= 2

			else // This is to avoid any special characters not covered doing some weird stuff. Things like the ' symbol would duplicate the last played phonetic ~3 times. Sounded weird.
				volume = 0
				current_delay -= 1

		final_boop = "mojave/sound/voices/[chosen_boop]/s_[boop_letter].wav"
		addtimer(CALLBACK(src, .proc/play_mumbleboop, hearers, mumblebooper, final_boop, volume, initial_mumbleboop_time), mumbleboop_delay_cumulative + current_delay, falloff_exponent)
		mumbleboop_delay_cumulative += current_delay

/datum/component/mumbleboop/proc/play_mumbleboop(list/hearers, mob/mumblebooper, final_boop, volume, initial_mumbleboop_time, falloff_exponent)
	if(!volume || (last_mumbleboop != initial_mumbleboop_time))
		return
	for(var/mob/hearer as anything in hearers)
		hearer.playsound_local(get_turf(mumblebooper), final_boop, volume, FALSE, falloff_exponent)

#undef MAX_MUMBLEBOOP_CHARACTERS
