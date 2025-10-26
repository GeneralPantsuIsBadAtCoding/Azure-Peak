/obj/structure/mineral_door/secret
	name = "wall"
	icon = 'icons/turf/walls/brick_wall.dmi'
	resistance_flags = NONE
	max_integrity = 9999
	damage_deflection = 30
	layer = ABOVE_MOB_LAYER

	repairable = FALSE
	repair_cost_first = null
	repair_cost_second = null
	repair_skill = null

	var/open_phrase = "open sesame"

	var/speaking_distance = 1
	var/lang = /datum/language/common
	var/list/vip
	var/vipmessage

/obj/structure/mineral_door/secret/Initialize(mapload, ...)
	. = ..()
	open_phrase = open_word() + " " + magic_word()

/obj/structure/mineral_door/secret/redstone_triggered(mob/user)
	if(!door_opened)
		force_open()
	else
		force_closed()

/obj/structure/mineral_door/secret/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	var/mob/living/carbon/human/H = speaker
	if(speaker == src) //door speaking to itself
		return FALSE
	var/distance = get_dist(speaker, src)
	if(distance > speaking_distance)
		return FALSE
	if(obj_broken) //door is broken
		return FALSE
	if(!ishuman(speaker))
		return FALSE

	var/message2recognize = sanitize_hear_message(original_message)

	if(is_type_in_list(H.mind?.assigned_role, vip)) //are they a VIP?
		if(findtext(message2recognize, "help"))
			send_speech(span_purple("'say phrase'... 'set phrase'..."), speaking_distance, src, message_language = lang, message_mode = MODE_WHISPER)
			return TRUE
		if(findtext(message2recognize, "say phrase"))
			send_speech(span_purple("[open_phrase]..."), speaking_distance, src, message_language = lang, message_mode = MODE_WHISPER)
			return TRUE
		if(findtext(message2recognize, "set phrase"))
			var/new_pass = stripped_input(H, "What should the new close phrase be?")
			open_phrase = new_pass
			send_speech(span_purple("It is done, [flavor_name()]..."), speaking_distance, src, message_language = lang, message_mode = MODE_WHISPER)
			return TRUE

	if(findtext(message2recognize, open_phrase))
		if(!door_opened)
			force_open()
		else
			force_closed()
		return TRUE

/obj/structure/mineral_door/secret/Open(silent = FALSE)
	isSwitchingStates = TRUE
	if(!silent)
		playsound(src, openSound, 90)
	if(!windowed)
		set_opacity(FALSE)
	animate(src, pixel_x = -22, alpha = 50, time = close_delay)
	sleep(close_delay)
	density = FALSE
	door_opened = TRUE
	layer = OPEN_DOOR_LAYER
	air_update_turf(TRUE)
	isSwitchingStates = FALSE

	if(close_delay > 0)
		addtimer(CALLBACK(src, PROC_REF(Close), silent), close_delay)

/obj/structure/mineral_door/secret/force_open()
	isSwitchingStates = TRUE
	if(!windowed)
		set_opacity(FALSE)
	animate(src, pixel_x = -22, alpha = 50, time = close_delay)
	sleep(close_delay)
	density = FALSE
	door_opened = TRUE
	layer = OPEN_DOOR_LAYER
	air_update_turf(TRUE)
	isSwitchingStates = FALSE

	if(close_delay > 0)
		addtimer(CALLBACK(src, PROC_REF(Close)), close_delay)

/obj/structure/mineral_door/secret/Close(silent = FALSE)
	if(isSwitchingStates || !door_opened)
		return
	var/turf/T = get_turf(src)
	for(var/mob/living/L in T)
		return
	isSwitchingStates = TRUE
	if(!silent)
		playsound(src, closeSound, 90)
	animate(src, pixel_x = 0, alpha = 255, time = close_delay)
	sleep(close_delay)
	density = TRUE
	if(!windowed)
		set_opacity(TRUE)
	door_opened = FALSE
	layer = CLOSED_DOOR_LAYER
	air_update_turf(TRUE)
	isSwitchingStates = FALSE
	playsound(src, locksound, 100)
	locked = TRUE

/obj/structure/mineral_door/secret/force_closed()
	isSwitchingStates = TRUE
	if(!windowed)
		set_opacity(TRUE)
	animate(src, pixel_x = 0, alpha = 255, time = close_delay)
	sleep(close_delay)
	density = TRUE
	door_opened = FALSE
	layer = CLOSED_DOOR_LAYER
	air_update_turf(TRUE)
	isSwitchingStates = FALSE

/proc/open_word()
	var/list/open_word = list(
		"open",
		"pass",
		"part",
		"break",
		"reveal",
		"unbar",
		"gape", //You wanted this.
		"extend",
		"widen",
		"unfold",
		"rise"
		)
	return pick(open_word)

/proc/close_word()
	var/list/close_word = list(
		"close",
		"seal",
		"still",
		"fade",
		"retreat",
		"consume",
		"envelope",
		"hide",
		"halt",
		"cease",
		"vanish",
		"end"
		)
	return pick(close_word)


/proc/magic_word()
	var/list/magic_word = list(
		"sesame",
		"abyss",
		"fire",
		"wind",
		"earth",
		"shadow",
		"night",
		"oblivion",
		"void",
		"time",
		"dead",
		"decay",
		"gods",
		"ancient",
		"twisted",
		"corrupt",
		"secrets",
		"lore",
		"text",
		"ritual",
		"sacrifice",
		"deal",
		"pact",
		"bargain",
		"ritual",
		"dream",
		"nightmare",
		"vision",
		"hunger",
		"lust",
		"necra",
		"noc",
		"psydon"
		)
	return pick(magic_word)

/proc/flavor_name()
	var/list/flavor_name = list(
		"my friend",
		"love",
		"my love",
		"honey",
		"darling",
		"stranger",
		"companion",
		"mate",
		"you harlot",
		"comrade",
		"fellow",
		"chum",
		"bafoon"
		)
	return pick(flavor_name)
