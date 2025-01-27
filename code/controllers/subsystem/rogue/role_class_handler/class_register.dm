/datum/class_register
	var/id = null
	var/list/registered_messages = list()
	var/list/listening_mobs = list()

/datum/class_register/proc/add_listener(mob/listener)
	for(var/msg in registered_messages)
		to_chat(listener, span_notice(msg))
	listening_mobs += listener

/datum/class_register/proc/remove_listener(mob/listener)
	listening_mobs -= listener

/datum/class_register/proc/add_message(msg, mob/invoker)
	for(var/mob/listener as anything in listening_mobs)
		if(listener == invoker)
			continue
		to_chat(listener, span_notice(msg))
	registered_messages += msg
