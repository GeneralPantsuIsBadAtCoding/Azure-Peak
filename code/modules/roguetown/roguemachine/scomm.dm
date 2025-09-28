#define GARRISON_SCOM_COLOR "#FF4242"

/obj/structure/roguemachine/scomm
	name = "SCOM"
	desc = "The Supernatural Communication Optical Machine is a wonder of magic and technology, a device able to receive remote messages from the town crier's office. There's a button in the MIDDLE for making private jabberline connections."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "scomm1"
	density = FALSE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	pixel_y = 32
	anchored = TRUE
	verb_say = "squeaks"
	var/next_decree = 0
	var/listening = TRUE
	var/speaking = TRUE
	var/loudmouth_listening = TRUE
	var/dictating = FALSE
	var/scom_number
	var/scom_tag
	var/obj/structure/roguemachine/scomm/calling = null
	var/obj/structure/roguemachine/scomm/called_by = null
	var/spawned_rat = FALSE
	var/garrisonline = FALSE

/obj/structure/roguemachine/scomm/OnCrafted(dirin, mob/user)
	. = ..()
	loc = user.loc
	pixel_y = 0
	switch(dirin)
		if(NORTH)
			pixel_y = 32
		if(SOUTH)
			pixel_y = -32
		if(EAST)
			pixel_x = 32
		if(WEST)
			pixel_x = -32

/obj/structure/roguemachine/scomm/r
	pixel_y = 0
	pixel_x = 32

/obj/structure/roguemachine/scomm/l
	pixel_y = 0
	pixel_x = -32

/obj/structure/roguemachine/scomm/examine(mob/user)
	. = ..()
	if(scom_number)
		. += "Its designation is #[scom_number][scom_tag ? ", labeled as [scom_tag]" : ""]."
	. += "<a href='?src=[REF(src)];directory=1'>Directory</a>"
	if(user.loc == loc)
		. += "<b>THE LAWS OF THE LAND:</b>"
		if(!length(GLOB.laws_of_the_land))
			. += span_danger("The land has no laws! <b>We are doomed!</b>")
			return
		if(!user.is_literate())
			. += span_warning("Uhhh... I can't read them...")
			return
		for(var/i in 1 to length(GLOB.laws_of_the_land))
			. += span_small("[i]. [GLOB.laws_of_the_land[i]]")

/obj/structure/roguemachine/scomm/Topic(href, href_list)
	..()

	if(!usr)
		return

	if(href_list["directory"])
		view_directory(usr)

/obj/structure/roguemachine/scomm/proc/view_directory(mob/user)
	var/dat
	for(var/obj/structure/roguemachine/scomm/X in SSroguemachine.scomm_machines)
		if(X.scom_tag)
			dat += "#[X.scom_number] [X.scom_tag]<br>"

	var/datum/browser/popup = new(user, "scom_directory", "<center>RAT REGISTER</center>", 387, 420)
	popup.set_content(dat)
	popup.open(FALSE)

/obj/structure/roguemachine/scomm/process()
	if(world.time <= next_decree)
		return
	next_decree = world.time + rand(3 MINUTES, 8 MINUTES)
	if(!GLOB.lord_decrees.len)
		return
	if(!speaking)
		return
	say("The [SSticker.rulertype] Decrees: [pick(GLOB.lord_decrees)]", spans = list("info"))

/obj/structure/roguemachine/scomm/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	if(called_by && !calling)
		calling = called_by
		calling.say("Jabberline fused.", spans = list("info"))
		say("Jabberline fused.", spans = list("info"))
		update_icon()
		return
	if(calling)
		listening = !listening
		to_chat(user, span_info("I [listening ? "unmute" : "mute"] the input on the SCOM."))
		return
	if(loudmouth_listening)
		to_chat(user, span_info("I quell the Loudmouth's prattling on the SCOM. It may be muted entirely still."))
		loudmouth_listening = FALSE
	else
		listening = !listening
		speaking = listening
		to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the SCOM."))
		if(listening)
			loudmouth_listening = TRUE
	update_icon()

/obj/structure/roguemachine/scomm/attack_right(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	if(called_by && !calling)
		called_by.say("Jabberline refused.", spans = list("info"))
		say("Jabberline refused.", spans = list("info"))
		called_by.calling = null
		called_by = null
		return
	if(calling)
		speaking = !speaking
		to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the output on the SCOM."))
		return
	var/canread = user.can_read(src, TRUE)
	var/contents
	if(SSticker.rulertype == "Grand Duke")
		contents += "<center>GRAND DUKE'S DECREES<BR>"
	else
		contents += "<center>GRAND DUCHESS' DECREES<BR>"
	contents += "-----------<BR><BR></center>"
	for(var/i = GLOB.lord_decrees.len to 1 step -1)
		contents += "[i]. <span class='info'>[GLOB.lord_decrees[i]]</span><BR>"
	if(!canread)
		contents = stars(contents)
	var/datum/browser/popup = new(user, "VENDORTHING", "", 370, 220)
	popup.set_content(contents)
	popup.open()

/obj/structure/roguemachine/scomm/MiddleClick(mob/living/carbon/human/user)
	if(.)
		return
	if((HAS_TRAIT(user, TRAIT_GUARDSMAN) || (user.job == "Warden") || (user.job == "Squire") || (user.job == "Marshal") || (user.job == "Grand Duke") || (user.job == "Knight Captain") || (user.job == "Grand Duchess")))
		if(alert("Would you like to swap lines or connect to a jabberline?",, "swap", "jabberline") != "jabberline")
			garrisonline = !garrisonline
			to_chat(user, span_info("I [garrisonline ? "connect to the garrison SCOMline" : "connect to the general SCOMLINE"]"))
			playsound(loc, 'sound/misc/garrisonscom.ogg', 100, FALSE, -1)
			update_icon()
			return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	if(calling)
		calling.say("Jabberline severed.", spans = list("info"))
		if(calling.calling == src || calling.called_by == src)
			var/obj/structure/roguemachine/scomm/old_calling = calling
			old_calling.called_by = null
			old_calling.calling = null
			old_calling.speaking = old_calling.listening
			old_calling.update_icon()
		calling = null
		called_by = null
		speaking = listening
		to_chat(user, span_info("I cut the jabberline."))
		say("Jabberline severed.", spans = list("info"))
		update_icon()
	else
		say("Input SCOM designation.", spans = list("info"))
		var/nightcall = input(user, "Input the number you have been provided with.", "INTERFACING") as null|num
		if(!nightcall)
			return
		if(nightcall == scom_number)
			to_chat(user, span_warning("Nothing but rats squeaking back at you."))
			playsound(src, 'sound/vo/mobs/rat/rat_life.ogg', 100, TRUE, -1)
			return
		if(SSroguemachine.scomm_machines.len < nightcall)
			say("There are no rats running this jabberline.", spans = list("info"))
			return
		var/obj/structure/roguemachine/scomm/S = SSroguemachine.scomm_machines[nightcall]
		if(istype(S, /obj/item/scomstone))
			say("The jabberline's rats cannot travel to SCOMstones.") //Check prevents a runtime and leaves room to potentially make scomstones callable by ID later.
			playsound(src, 'sound/vo/mobs/rat/rat_life.ogg', 100, TRUE, -1)
			return
		if(!S)
			to_chat(user, span_warning("Nothing but rats squeaking back at you."))
			playsound(src, 'sound/vo/mobs/rat/rat_life.ogg', 100, TRUE, -1)
			return
		if(S.calling || S.called_by)
			say("This jabberline's rats are occupied.", spans = list("info"))
			return
		if(!S.speaking)
			say("This jabberline's rats have been gagged.", spans = list("info"))
			return
		calling = S
		S.called_by = src
		update_icon()

		for(var/i in 1 to 10)
			if(!calling)
				update_icon()
				return
			if(calling.calling == src)
				return
			calling.ring_ring()
			ring_ring()
			sleep(30)
		say("This jabberline's rats are exhausted.", spans = list("info"))
		calling.called_by = null
		calling = null
		update_icon()

/obj/structure/roguemachine/scomm/obj_break(damage_flag)
	..()
	calling?.say("Jabberline severed.", spans = list("info"))
	calling?.speaking = calling?.listening
	calling?.called_by = null
	calling?.calling = null
	called_by = null
	calling = null
	speaking = FALSE
	listening = FALSE
	update_icon()
	icon_state = "[icon_state]-br"

/obj/structure/roguemachine/scomm/Initialize()
	. = ..()
//	icon_state = "scomm[rand(1,2)]"
	START_PROCESSING(SSroguemachine, src)
	become_hearing_sensitive()
	update_icon()
	SSroguemachine.scomm_machines += src
	scom_number = SSroguemachine.scomm_machines.len

/obj/structure/roguemachine/scomm/update_icon()
	if(obj_broken)
		set_light(0)
		return
	if(garrisonline)
		icon_state = "scomm2"
		return
	if(calling)
		icon_state = "scomm2"
	else if(listening)
		icon_state = "scomm1"
	else
		icon_state = "scomm0"
	if(listening)
		if(!loudmouth_listening)
			icon_state = "scomm3"

/obj/structure/roguemachine/scomm/Destroy()
	lose_hearing_sensitivity()
	SSroguemachine.scomm_machines -= src
	STOP_PROCESSING(SSroguemachine, src)
	set_light(0)
	return ..()

/obj/structure/roguemachine/scomm/proc/ring_ring()
	playsound(src, 'sound/vo/mobs/rat/rat_life.ogg', 100, TRUE, -1)
	var/oldx = pixel_x
	animate(src, pixel_x = oldx+1, time = 0.5)
	animate(pixel_x = oldx-1, time = 0.5)
	animate(pixel_x = oldx, time = 0.5)

/obj/structure/roguemachine/scomm/proc/repeat_message(message, atom/A, tcolor, message_language, list/tspans, broadcaster_tag)
	if(A == src)
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		playsound(loc, 'sound/vo/mobs/rat/rat_life.ogg', 100, TRUE, -1)
		say(message, language = message_language)
	voicecolor_override = null

/obj/structure/roguemachine/scomm/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	if(speaker.loc != loc)
		return
	if(!ishuman(speaker))
		return
	if(!listening)
		return
	#ifdef USES_SCOM_RESTRICTION
	if(!calling && !garrisonline)
		say(span_danger("Either connect to another SCOM via jabberline or go visit the town crier to broadcast a message."))
		playsound(src, 'sound/vo/mobs/rat/rat_life2.ogg', 100, TRUE, -1)
		return
	#endif
	var/mob/living/carbon/human/H = speaker
	var/usedcolor = H.voice_color
	if(H.voicecolor_override)
		usedcolor = H.voicecolor_override
	if(raw_message)
		if(calling)
			if(calling.calling == src)
				calling.repeat_message(raw_message, src, usedcolor, message_language)
			return
		if(length(raw_message) > 100) //When these people talk too much, put that shit in slow motion, yeah
			raw_message = "<small>[raw_message]</small>"
		if(garrisonline)
			raw_message = "<span style='color: [GARRISON_SCOM_COLOR]'>[raw_message]</span>" //Prettying up for Garrison line
			for(var/obj/item/scomstone/garrison/S in SSroguemachine.scomm_machines)
				S.repeat_message(raw_message, src, usedcolor, message_language)
			for(var/obj/item/scomstone/bad/garrison/S in SSroguemachine.scomm_machines)
				S.repeat_message(raw_message, src, usedcolor, message_language)
			for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
				if(S.garrisonline)
					S.repeat_message(raw_message, src, usedcolor, message_language)
			SSroguemachine.crown?.repeat_message(raw_message, src, usedcolor, message_language)
			return
		#ifndef USES_SCOM_RESTRICTION
		else 
			for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
				if(!S.calling)
					S.repeat_message(raw_message, src, usedcolor, message_language)
			for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
				S.repeat_message(raw_message, src, usedcolor, message_language)
			for(var/obj/item/listenstone/S in SSroguemachine.scomm_machines)
				S.repeat_message(raw_message, src, usedcolor, message_language)//make the listenstone hear scom
			SSroguemachine.crown?.repeat_message(raw_message, src, usedcolor, message_language)
		#endif

/obj/structure/roguemachine/scomm/proc/dictate_laws()
	if(dictating)
		return
	dictating = TRUE
	repeat_message("THE LAWS OF THE LAND ARE...", tcolor = COLOR_RED)
	INVOKE_ASYNC(src, PROC_REF(dictation))

/obj/structure/roguemachine/scomm/proc/dictation()
	if(!length(GLOB.laws_of_the_land))
		sleep(2)
		repeat_message("THE LAND HAS NO LAWS!", tcolor = COLOR_RED)
		dictating = FALSE
		return
	for(var/i in 1 to length(GLOB.laws_of_the_land))
		sleep(2)
		repeat_message("[i]. [GLOB.laws_of_the_land[i]]", tcolor = COLOR_RED)
	dictating = FALSE

/proc/scom_announce(message)
	for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
		if(S.speaking)
			S.say(message, spans = list("info"))



//SCOMSTONE                 SCOMSTONE

/obj/item/scomstone
	name = "scomstone"
	icon_state = "ring_scom"
	desc = "A heavy ring made of metal. There is a gem embedded in the center - dim, but alive."
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 10
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP|ITEM_SLOT_NECK|ITEM_SLOT_RING
	obj_flags = null
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	experimental_inhand = FALSE
	muteinmouth = TRUE
	var/cooldown = 60 SECONDS
	var/on_cooldown = FALSE
	var/listening = TRUE
	var/speaking = TRUE
	var/loudmouth_listening = TRUE
	var/messagereceivedsound = 'sound/misc/scom.ogg'
	var/scomstone_number
	var/hearrange = 1 // change to 0 if you want your special scomstone to be only hearable by wearer
	drop_sound = 'sound/foley/coinphy (1).ogg'
	sellprice = 100
	grid_width = 32
	grid_height = 32

/obj/item/scomstone/attack_right(mob/living/carbon/human/user)
	if(on_cooldown)
		to_chat(user, span_warning("The gemstone inside the ring radiates heat. It's still cooling down from its last use."))
		playsound(loc, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	visible_message(span_notice ("[user] presses their ring against their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	var/usedcolor = user.voice_color
	if(user.voicecolor_override)
		usedcolor = user.voicecolor_override
	user.whisper(input_text)
	if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
		input_text = "<small>[input_text]</small>"
	for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
		S.repeat_message(input_text, src, usedcolor)
	for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
		S.repeat_message(input_text, src, usedcolor)
	for(var/obj/item/listenstone/S in SSroguemachine.scomm_machines) //make the listenstone hear scomstone
		S.repeat_message(input_text, src, usedcolor)
	SSroguemachine.crown?.repeat_message(input_text, src, usedcolor)
	on_cooldown = TRUE
	addtimer(CALLBACK(src, PROC_REF(reset_cooldown), user), cooldown)

	//Log message to global broadcast list.
	GLOB.broadcast_list += list(list(
	"message"   = input_text,
	"tag"		= "SCOMSTONE #[scomstone_number]",
	"timestamp" = station_time_timestamp("hh:mm:ss")
	))

/obj/item/scomstone/proc/reset_cooldown(mob/living/carbon/human/user)
	to_chat(user, span_notice("[src] is ready for use again."))
	playsound(loc, 'sound/misc/machineyes.ogg', 100, FALSE, -1)
	on_cooldown = FALSE

/obj/item/scomstone/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	if(loudmouth_listening)
		to_chat(user, span_info("I quell the Loudmouth's prattling on the scomstone. It may be muted entirely still."))
		loudmouth_listening = FALSE
	else
		listening = !listening
		speaking = !speaking
		to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the scomstone."))
		if(listening)
			loudmouth_listening = TRUE
		update_icon()

/obj/item/scomstone/Destroy()
	SSroguemachine.scomm_machines -= src
	lose_hearing_sensitivity()
	return ..()

/obj/item/scomstone/Initialize()
	. = ..()
	become_hearing_sensitive()
	update_icon()
	SSroguemachine.scomm_machines += src
	scomstone_number = SSroguemachine.scomm_machines.len

/obj/item/scomstone/examine(mob/user)
	. = ..()
	if(scomstone_number)
		. += "Its designation is #[scomstone_number]."

/obj/item/scomstone/proc/repeat_message(message, atom/A, tcolor, message_language)
	if(A == src)
		return
	if(!ismob(loc))
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		playsound(loc, messagereceivedsound, 100, TRUE, -1)
		say(message, language = message_language)
	voicecolor_override = null


/obj/item/scomstone/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_default_language()
	if(istype(loc, /obj/item))
		var/obj/item/I = loc
		I.send_speech(message, hearrange, I, , spans, message_language=language)
	else
		send_speech(message, hearrange, src, , spans, message_language=language)

/obj/item/scomstone/bad
	name = "serfstone"
	desc = "A rusty shoddily-made metal ring. The gem embedded within is barely holding on."
	icon_state = "ring_serfscom"
	listening = FALSE
	sellprice = 20

/obj/item/scomstone/bad/attack_right(mob/user)
	return

//LISTENSTONE		LISTENSTONE
/obj/item/listenstone
	name = "emerald choker"
	icon_state = "listenstone"
	desc = "An iron and gold choker with an emerald gem."
	gripped_intents = null
	//dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	//force = 10
	//throwforce = 10
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP|ITEM_SLOT_NECK|ITEM_SLOT_WRISTS
	obj_flags = null
	icon = 'icons/roguetown/clothing/neck.dmi'
	w_class = WEIGHT_CLASS_SMALL
	experimental_inhand = FALSE
	muteinmouth = TRUE
	var/listening = TRUE
	var/speaking = TRUE
	var/loudmouth_listening = TRUE
	sellprice = 200
	grid_width = 32
	grid_height = 32

/obj/item/listenstone/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	if(loudmouth_listening)
		to_chat(user, span_info("I quell the Loudmouth's prattling on the scomstone. It may be muted entirely still."))
		loudmouth_listening = FALSE
	else
		listening = !listening
		speaking = !speaking
		to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the scomstone."))
		if(listening)
			loudmouth_listening = TRUE
	update_icon()
	if(listening)
		icon_state = "listenstone"
	else
		icon_state = "listenstone_act"

/obj/item/listenstone/Initialize()
	. = ..()
	update_icon()
	SSroguemachine.scomm_machines += src


/obj/item/listenstone/proc/repeat_message(message, atom/A, tcolor, message_language)
	if(A == src)
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		playsound(loc, 'sound/vo/mobs/rat/rat_life.ogg', 100, TRUE, -1)
		say(message, language = message_language)
	voicecolor_override = null

/obj/item/listenstone/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_default_language()
	if(istype(loc, /obj/item))
		var/obj/item/I = loc
		I.send_speech(message, 1, I, , spans, message_language=language)
	else
		send_speech(message, 1, src, , spans, message_language=language)

	return

// MATTHIAN SCOMCOIN

/obj/item/mattcoin
	name = "rontz ring"
	icon_state = "mattcoin"
	desc = "A faded coin with a ruby laid into its center."
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 10
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP|ITEM_SLOT_NECK|ITEM_SLOT_RING
	obj_flags = null
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	experimental_inhand = FALSE
	muteinmouth = TRUE
	var/listening = TRUE
	var/speaking = TRUE
	sellprice = 0
	grid_width = 32
	grid_height = 32

/obj/item/mattcoin/Initialize()
	. = ..()
	become_hearing_sensitive()
	update_icon()
	SSroguemachine.scomm_machines += src
	name = pick("rontz ring", "gold ring")

/obj/item/mattcoin/pickup(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_COMMIE))
		to_chat(user, "The coin turns to ash in my hands!")
		playsound(loc, 'sound/items/firesnuff.ogg', 100, FALSE, -1)
		qdel(src)
	..()

/obj/item/mattcoin/doStrip(mob/stripper, mob/owner)
	if(!(stripper?.mind.has_antag_datum(/datum/antagonist/bandit))) //You're not a bandit, you can't strip the bandit coin
		to_chat(stripper, "[src] turns to ash in my hands!")
		playsound(stripper.loc, 'sound/items/firesnuff.ogg', 100, FALSE, -1)
		qdel(src)
		return FALSE
	. = ..()

/obj/item/mattcoin/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	var/input_text = input(user, "Enter your message:", "Message")
	if(input_text)
		var/usedcolor = user.voice_color
		if(user.voicecolor_override)
			usedcolor = user.voicecolor_override
		user.whisper(input_text)
		if(length(input_text) > 100)
			input_text = "<small>[input_text]</small>"
		for(var/obj/item/mattcoin/S in SSroguemachine.scomm_machines)
			S.repeat_message(input_text, src, usedcolor)

/obj/item/mattcoin/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/coindispense.ogg', 100, FALSE, -1)
	listening = !listening
	speaking = !speaking
	to_chat(user, span_info("I [speaking ? "unmute" : "mute"] the Matthian-SCOMstone"))
	update_icon()

/obj/item/mattcoin/Destroy()
	lose_hearing_sensitivity()
	SSroguemachine.scomm_machines -= src
	return ..()

/obj/item/mattcoin/proc/repeat_message(message, atom/A, tcolor, message_language)
	if(A == src)
		return
	if(!ismob(loc))
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		playsound(loc, 'sound/foley/coins1.ogg', 20, TRUE, -1)
		say(message, language = message_language)
	voicecolor_override = null


/obj/item/mattcoin/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_default_language()
	if(istype(loc, /obj/item))
		var/obj/item/I = loc
		I.send_speech(message, 0, I, , spans, message_language=language)
	else
		send_speech(message, 0, src, , spans, message_language=language)


// INQUISITORIAL LISTENERS AND RECEIVER


/obj/item/speakerinq
	name = "secret whisperer"
	desc = "Sweet secrets whispered so freely."
	var/speaking = TRUE
	sellprice = 20
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "scomite"
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 10
	w_class = WEIGHT_CLASS_SMALL
	experimental_inhand = FALSE
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP|ITEM_SLOT_RING
	possible_item_intents = list(INTENT_GENERIC)
	sleeved = 'icons/roguetown/clothing/onmob/neck.dmi'
	grid_width = 32
	grid_height = 32
	var/fakename = "secret whisperer"

/obj/item/speakerinq/proc/repeat_message(message, atom/A, tcolor, message_language)
	if(A == src)
		return
	if(!ismob(loc))
		return
	if(tcolor)
		voicecolor_override = tcolor
	if(speaking && message)
		var/mob/living/carbon/human/wearer = loc
		wearer.playsound_local(wearer, 'sound/vo/mobs/rat/rat_life.ogg', 50, TRUE)
		say(message, language = message_language)
	voicecolor_override = null

/obj/item/speakerinq/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_default_language()
	if(istype(loc, /obj/item))
		var/obj/item/I = loc
		I.send_speech(message, 0, I, , spans, message_language=language)
	else
		send_speech(message, 0, src, , spans, message_language=language)


/obj/item/speakerinq/equipped(mob/user, slot)
	. = ..()
	switch(slot)
		if(SLOT_RING)
			fakename = "silver signet ring"	
			name = fakename
	return TRUE		


/obj/item/speakerinq/dropped(mob/user, silent)
	. = ..()
	name = initial(name)
	sleeved = null
	mob_overlay_icon = null

/obj/item/speakerinq/Destroy()
	SSroguemachine.scomm_machines -= src
	return ..()

/obj/item/speakerinq/Initialize()
	. = ..()
	icon_state = "scomite_active"
	update_icon()
	SSroguemachine.scomm_machines += src

/obj/item/speakerinq/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	speaking = !speaking
	to_chat(user, span_info("I [speaking ? "unsilence" : "silence"] the whisperer."))
	if(speaking)
		icon_state = "[initial(icon_state)]_active"
	else
		icon_state = "[initial(icon_state)]"
	update_icon()

/obj/item/listeningdevice
	name = "listener"
	desc = "An ever-attentive ear..."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "listenstone"
	dropshrink = 0.6
	gripped_intents = null
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 10
	alpha = 255
	w_class = WEIGHT_CLASS_SMALL
	experimental_inhand = FALSE
	grid_width = 32
	grid_height = 32
	var/label = null
	var/inqdesc = null
	var/hidden = FALSE
	layer = TURF_LAYER
	var/active = FALSE
	var/datum/status_effect/bugged/effect

/obj/item/listeningdevice/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_INQUISITION))
		desc = inqdesc
	else
		desc = initial(desc)

/obj/item/listeningdevice/Initialize()
	. = ..()
	become_hearing_sensitive()
	inqdesc = "An ever-attentive ear... [span_notice("This ear hasn't been bent. It's unlabelled.")]"

/obj/item/listeningdevice/Destroy()
	lose_hearing_sensitivity()
	return ..()

/obj/item/listeningdevice/attack_self(mob/living/user)
	var/input = input(user, "SIX LETTERS", "BEND AN EAR")
	if(!input)
		label = null
		inqdesc = "An ever-attentive ear... [span_notice("This ear hasn't been bent. It's unlabelled.")]"
		desc = inqdesc
		return
	label = uppertext(trim(input, 7))
	inqdesc = "An ever-attentive ear... [span_notice("This ear's been bent. It's labelled as [label].")]"
	desc = inqdesc
	return

/obj/item/listeningdevice/attack_right(mob/living/user)
	if(!hidden)
		alpha = 30
		name = "thing"
		desc = "What is that thing?.."
		hidden = TRUE
		return TRUE
	alpha = 255
	name = initial(name)
	desc = initial(desc)
	hidden = FALSE
	return TRUE
/* FINISH THIS AT YOUR OWN LEISURE. IT WON'T TAKE MUCH WORK. AT MOST YOU'LL BE ADDING DISCOVERY CHECKS ON EXAMINE AND THE ABILITY TO RIP OFF DISCOVERED LISTENERS. HAVE FUN! - YISCHE
/obj/item/listeningdevice/attack(mob/living/M, mob/living/user)
	if(!active)
		to_chat(user, span_warning("[src] is inactive.."))
		return FALSE
	
	to_chat(user, span_notice("I attach [src] to [M]."))
	effect = M.apply_status_effect(/datum/status_effect/bugged)
	effect.device = src
	forceMove(M)
	M.contents.Add(src)

	if(M.STAPER > user.STASPD)
		to_chat(M, span_hidden("I feel something brush against the back of my neck. It stings."))

	..()
*/
/obj/item/listeningdevice/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/bug.ogg', 50, FALSE, -1)
	active = !active
	if(active)
		icon_state = "[initial(icon_state)]_active"
	else
		icon_state = initial(icon_state)
	to_chat(user, span_info("I [active ? "undeafen" : "deafen"] the Listener."))
	update_icon()
	return

/obj/item/listeningdevice/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	if(!active)
		return
	if(!ishuman(speaker))
		return
	var/mob/living/carbon/human/H = speaker
	var/usedcolor = H.voice_color
	if(H.voicecolor_override)
		usedcolor = H.voicecolor_override
	if(!raw_message)
		return
	if(length(raw_message) > 100)
		raw_message = "<small>[raw_message]</small>"
	for(var/obj/item/speakerinq/S in SSroguemachine.scomm_machines)
		S.name = label ? "#[label]" : "#NOTSET"
		S.repeat_message(raw_message, src, usedcolor, message_language)
		S.name = (S.fakename)

// garrison scoms/listenstones

/obj/item/scomstone/garrison
	name = "crownstone"
	icon_state = "ring_crownscom"
	desc = "A lavish golden ring with the mark of the Crown. Heavy and garish. The gem embedded flickering in excitement."
	var/garrisonline = TRUE
	messagereceivedsound = 'sound/misc/garrisonscom.ogg'
	hearrange = 0
	sellprice = 100

/obj/item/scomstone/garrison/attack_right(mob/living/carbon/human/user)
	user.changeNext_move(CLICK_CD_INTENTCAP)
	if(on_cooldown)
		to_chat(user, span_warning("The gemstone inside the ring radiates heat. It's still cooling down from its last use."))
		playsound(loc, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		return
	visible_message(span_notice ("[user] presses their ring against their mouth."))
	var/input_text = input(user, "Enter your message:", "Message")
	if(!input_text)
		return
	var/usedcolor = user.voice_color
	if(user.voicecolor_override)
		usedcolor = user.voicecolor_override
	user.whisper(input_text)
	if(length(input_text) > 100) //When these people talk too much, put that shit in slow motion, yeah
		input_text = "<small>[input_text]</small>"

	if(garrisonline)
		input_text = "<big><span style='color: [GARRISON_SCOM_COLOR]'>[input_text]</span></big>" //Prettying up for Garrison line
		for(var/obj/item/scomstone/bad/garrison/S in SSroguemachine.scomm_machines)
			S.repeat_message(input_text, src, usedcolor)
		for(var/obj/item/scomstone/garrison/S in SSroguemachine.scomm_machines)
			S.repeat_message(input_text, src, usedcolor)
		for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
			if(S.garrisonline)
				S.repeat_message(input_text, src, usedcolor)
		SSroguemachine.crown?.repeat_message(input_text, src, usedcolor)
		on_cooldown = TRUE
		addtimer(CALLBACK(src, PROC_REF(reset_cooldown)), cooldown)
		return
	for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
		S.repeat_message(input_text, src, usedcolor)
	for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
		S.repeat_message(input_text, src, usedcolor)
	for(var/obj/item/listenstone/S in SSroguemachine.scomm_machines)
		S.repeat_message(input_text, src, usedcolor)
	SSroguemachine.crown?.repeat_message(input_text, src, usedcolor)
	on_cooldown = TRUE
	
	//Log messages that aren't sent on the garrison line.
	GLOB.broadcast_list += list(list(
	"message"   = input_text,
	"tag"		= "CROWNSTONE #[scomstone_number]",
	"timestamp" = station_time_timestamp("hh:mm:ss")
	))

	addtimer(CALLBACK(src, PROC_REF(reset_cooldown)), cooldown)

/obj/item/scomstone/garrison/attack_self(mob/living/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	garrisonline = !garrisonline
	to_chat(user, span_info("I [garrisonline ? "connect to the garrison SCOMline" : "connect to the general SCOMline"]"))
	update_icon()

/obj/item/scomstone/garrison/update_icon()
	icon_state = "[initial(icon_state)][garrisonline ? "_on" : ""]"

/obj/item/scomstone/bad/garrison
	name = "houndstone"
	desc = "A basic metal ring. It has a well-cut, dismal gem embedded - bearing the mark of the Crown."
	icon_state = "ring_houndscom"
	listening = FALSE
	sellprice = 20
	messagereceivedsound = 'sound/misc/garrisonscom.ogg'
	hearrange = 0

/obj/structure/broadcast_horn
	name = "\improper Streetpipe"
	desc = "Also known as the People's Mouth, so long as the people can afford the ratfeed to pay for it."
	icon_state = "broadcaster_crass"
	icon = 'icons/roguetown/misc/machines.dmi'
	blade_dulling = DULLING_BASH
	max_integrity = 0
	density = TRUE
	anchored = TRUE
	flags_1 = HEAR_1
	speech_span = SPAN_ORATOR
	var/listening = FALSE
	var/speech_color = null
	var/loudmouth = FALSE
	var/broadcaster_tag

/obj/structure/broadcast_horn/examine(mob/user)
	. = ..()
	if(listening)
		. += "There's a faint skittering coming out of it."
	else
		. += "The rats within are quiet."
	if(broadcaster_tag)
		. += "It's[broadcaster_tag ? " labeled as [broadcaster_tag]" : ""]."

/obj/structure/broadcast_horn/redstone_triggered()
	toggle_horn()

/obj/structure/broadcast_horn/proc/toggle_horn()
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	if(listening)
		visible_message(span_notice("[src]'s whine stills."))
		listening = FALSE
	else
		listening = TRUE
		visible_message(span_notice("[src] squeaks alive."))

/obj/structure/broadcast_horn/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	if(!ishuman(speaker))
		return
	if(!listening)
		return
	var/turf/step_turf = get_step(get_turf(src), src.dir)
	if(get_turf(speaker) != step_turf)
		return
	var/mob/living/carbon/human/H = speaker
	var/usedcolor = H.voice_color
	if(H.voicecolor_override)
		usedcolor = H.voicecolor_override
	var/list/tspans = list()
	if(!raw_message)
		return
	if(length(raw_message) > 100)
		raw_message = "<small>[raw_message]</small>"
	tspans |= speech_span
	if(speech_color)
		raw_message = "<span style='color: [speech_color]'>[raw_message]</span>"

	//Log the broadcast here
	GLOB.broadcast_list += list(list(
		"message"   = raw_message,
		"tag"       = broadcaster_tag,
		"timestamp" = station_time_timestamp("hh:mm:ss")
	))

	//Forward to all listeners
	for(var/obj/structure/roguemachine/scomm/S in SSroguemachine.scomm_machines)
		if(!S.calling && (!loudmouth || S.loudmouth_listening))
			S.repeat_message(raw_message, src, usedcolor, message_language, tspans)
	for(var/obj/item/scomstone/S in SSroguemachine.scomm_machines)
		if(!loudmouth || S.loudmouth_listening)
			S.repeat_message(raw_message, src, usedcolor, message_language, tspans)
	for(var/obj/item/listenstone/S in SSroguemachine.scomm_machines)
		if(!loudmouth || S.loudmouth_listening)
			S.repeat_message(raw_message, src, usedcolor, message_language, tspans)
	var/obj/item/clothing/head/roguetown/crown/serpcrown/crowne = SSroguemachine.crown
	if(crowne && (!loudmouth || crowne.loudmouth_listening))
		crowne.repeat_message(raw_message, src, usedcolor, message_language, tspans)
	if(istype(src, /obj/structure/broadcast_horn/paid))
		listening = FALSE
		playsound(src, 'sound/misc/machinelong.ogg', 100, FALSE, -1)

/obj/structure/broadcast_horn/loudmouth
	name = "\improper Golden Mouth"
	desc = "The Loudmouth's own gleaming horn, its surface engraved with the ducal crest."
	icon_state = "broadcaster"
	speech_color = COLOR_ASSEMBLY_GOLD
	broadcaster_tag = "Golden Mouth"
	loudmouth = TRUE

/obj/structure/broadcast_horn/loudmouth/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	toggle_horn()

/obj/structure/broadcast_horn/loudmouth/guest
	name = "\improper Silver Tongue"
	desc = "A guest's horn. Not as gaudy as the Loudmouth's own, but still a fine piece of craftsmanship. "
	broadcaster_tag = "Silver Tongue"
	icon_state = "broadcaster_crass"
	speech_color = COLOR_ASSEMBLY_GURKHA

/obj/structure/broadcast_horn/paid
	name = "\improper Streetpipe"
	desc = "Also known as the People's Mouth, so long as the people can afford the ratfeed to pay for it. Insert a ziliqua to broadcast a message to every SCOM."
	icon_state = "broadcaster_crass"
	icon = 'icons/roguetown/misc/machines.dmi'
	var/is_locked = FALSE

/obj/structure/broadcast_horn/paid/attackby(obj/item/P, mob/user, params)
	// Handle locking/unlocking with crier key
	if(istype(P, /obj/item/roguekey/crier))
		is_locked = !is_locked
		listening = FALSE
		playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
		say(is_locked ? "Streetpipe has been locked." : "Streetpipe has been unlocked.")
		return

	// Handle coin payment
	if(istype(P, /obj/item/roguecoin))
		var/obj/item/roguecoin/C = P
		if(is_locked)
			say("Streetpipe is locked. Consult the crier.")
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return

		if(listening)
			say("Coin already loaded.")
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return

		if(C.get_real_price() != 5)
			to_chat(user, span_warning("Invalid payment! Insert coin worth 5 mammon."))
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return

		listening = TRUE
		qdel(C)

		// Route payments to rousmaster
		for(var/obj/structure/roguemachine/crier/Crier in world)
			Crier.total_payments += 5
			break // Safety. Prevents a runtime if more than 1 rousmaster exists.

		playsound(src, 'sound/misc/coininsert.ogg', 100, FALSE, -1)
		return

	..()

/obj/structure/broadcast_horn/Initialize()
	. = ..()
	become_hearing_sensitive()
	SSroguemachine.broadcaster_machines += src

/obj/structure/broadcast_horn/Destroy()
	lose_hearing_sensitivity()
	return ..()
