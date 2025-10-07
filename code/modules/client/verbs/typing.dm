#define IC_VERBS list("say", "me", "whisper", "subtle")

/client/var/commandbar_thinking = FALSE
/client/var/commandbar_typing = FALSE

/client/proc/initialize_commandbar_spy()
	src << output('html/typing_indicator.html', "commandbar_spy")

/client/proc/handle_commandbar_typing(href_list)


/**
 * Handles the user typing. After a brief period of inactivity,
 * signals the client mob to revert to the "thinking" icon.
 */
/client/proc/start_typing(channel)
	var/mob/client_mob = mob
	client_mob.display_typing_indicator()
	addtimer(CALLBACK(src, PROC_REF(stop_typing), channel), 5 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_STOPPABLE)

/**
 * Callback to remove the typing indicator after a brief period of inactivity.
 * If the user was typing IC, the thinking indicator is shown.
 */
/client/proc/stop_typing(channel)
	if(isnull(mob))
		return FALSE
	var/mob/client_mob = mob
	client_mob.clear_typing_indicator()

#undef IC_VERBS
