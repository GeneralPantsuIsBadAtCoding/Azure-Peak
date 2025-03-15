//Speech verbs.


/mob/verb/say_verb(message as text)
	set name = "Say"
	set category = "IC"
	set hidden = 1

	// If they don't type anything just drop the message.
	set_typing_indicator(FALSE)
	if(!length(message))
		return
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return
	if(message)
		set_typing_indicator(FALSE)
		say(message)

///Whisper verb
/mob/verb/whisper_verb(message as text)
	set name = "Whisper"
	set category = "IC"
	set hidden = 1

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return
	whisper(message)

///whisper a message
/mob/proc/whisper(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	say(message, language) //only living mobs actually whisper, everything else just talks

///The me emote verb
/mob/verb/me_verb(message as text)
	set name = "Me"
	set category = "IC"
	set hidden = 1
#ifndef MATURESERVER
	return
#endif
	// If they don't type anything just drop the message.
	set_typing_indicator(FALSE)
	if(!length(message))
		return
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return
	message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
	message = parsemarkdown_basic(message, limited = TRUE, barebones = TRUE)
	if(check_subtler(message, FALSE))
		return
	usr.emote("me",1,message,TRUE, custom_me = TRUE)

///The me emote verb
/mob/verb/me_big_verb(message as message)
	set name = "Me(big)"
	set category = "IC"
	set hidden = 1
#ifndef MATURESERVER
	return
#endif
	// If they don't type anything just drop the message.
	set_typing_indicator(FALSE)
	if(!length(message))
		return
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return
	message = trim(copytext_char(html_encode(message), 1, MAX_MESSAGE_BIGME))
	message = parsemarkdown_basic(message, limited = TRUE, barebones = TRUE)
	if(check_subtler(message, FALSE))
		return
	usr.emote("me",1,message,TRUE, custom_me = TRUE)

///Speak as a dead person (ghost etc)
/mob/proc/say_dead(message)

	return // RTCHANGE

///Check if this message is an emote
/mob/proc/check_emote(message, forced)
	if(copytext_char(message, 1, 2) == "*")
		emote(copytext_char(message, 2), intentional = !forced, custom_me = TRUE)
		return 1

/mob/proc/check_whisper(message, forced)
	if(copytext_char(message, 1, 2) == "+")
		whisper(copytext_char(message, 2),sanitize = FALSE)//already sani'd
		return 1

///Check if the mob has a hivemind channel
/mob/proc/hivecheck()
	return 0

///Check if the mob has a ling hivemind
/mob/proc/lingcheck()
	return LINGHIVE_NONE

/**
  * Get the mode of a message
  *
  * Result can be
  * * MODE_WHISPER (Quiet speech)
  * * MODE_HEADSET (Common radio channel)
  * * A department radio (lots of values here)
  */
/mob/proc/get_message_mode(message)
	var/key = copytext_char(message, 1, 2)
	if(key == "#")
		return MODE_WHISPER
	else if(key == ";")
		return MODE_HEADSET
	else if(length(message) > 2 && (key in GLOB.department_radio_prefixes))
		var/key_symbol = lowertext(copytext_char(message, 2, 3))
		return GLOB.department_radio_keys[key_symbol]
