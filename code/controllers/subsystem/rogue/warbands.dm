SUBSYSTEM_DEF(warbands)
	name = "warbands"
	wait = 20
	flags = SS_NO_FIRE // FIXNOTE: don't leave nofire in when territories are added
	priority = 10
	var/list/warband_managers = list()
	var/list/warband_machines = list()
	var/warband_managers_busy = FALSE	 // prevents multiple warbands from being loaded in at once | necessary, as warband_ID assignments for objects will expect this to be the case

	var/fiefs = list()
	var/territory_factions = list()


/datum/mind
	var/atom/movable/screen/warband/manager/warband_manager
