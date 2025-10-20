/// Pings admins every (time chosen in config) for all open tickets/OPFOR applications
SUBSYSTEM_DEF(ticket_ping)
	name = "Ticket Ping"
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 3 MINUTES

/datum/controller/subsystem/ticket_ping/Initialize()
	if(CONFIG_GET(number/ticket_ping_frequency) < 1)
		flags |= SS_NO_FIRE
		return FALSE

	wait = CONFIG_GET(number/ticket_ping_frequency)

	return ..()

/datum/controller/subsystem/ticket_ping/fire(resumed)
	var/valid_ahelps
	for(var/datum/admin_help/ahelp in GLOB.ahelp_tickets.active_tickets)
		if(ahelp.handler || ahelp.ticket_ping_stop || !ahelp.ticket_ping)
			continue
		valid_ahelps++

	if(!valid_ahelps)
		return

	message_admins(span_adminnotice("У нас сейчас [valid_ahelps] [valid_ahelps == 1 ? "не взятый на рассмотрение тикет" : "не взятых на рассмотрение тикетов"]."))
	for(var/client/staff as anything in GLOB.admins)
		/*var/sound_pick = rand(0, 2)
		switch(sound_pick)
			if(0)
				SEND_SOUND(staff, sound('modular_twilight_axis/sound/adminpings/soft_ping.ogg'))
			if(1)
				SEND_SOUND(staff, sound('modular_twilight_axis/sound/adminpings/sirena.ogg'))
			if(2)
				SEND_SOUND(staff, sound('modular_twilight_axis/sound/adminpings/budilnik.ogg')) */
		SEND_SOUND(staff, sound('modular_twilight_axis/sound/adminpings/soft_ping.ogg'))
		window_flash(staff, ignorepref = TRUE) 

/// Ticket ping frequency. Set 0 for disable that subsystem. 3000 - 5 minutes, 600 - 1 minute.
/datum/config_entry/number/ticket_ping_frequency
