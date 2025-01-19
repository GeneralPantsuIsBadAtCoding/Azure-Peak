SUBSYSTEM_DEF(hotspots)
	name = "Fire Hotspots"
	priority = FIRE_PRIORITY_HOTSPOTS
	wait = 5
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	var/list/hotspots = list()
	var/list/currentrun = list()
/datum/controller/subsystem/hotspots/fire(resumed = 0)
	if (!resumed)
		src.currentrun = hotspots.Copy()
	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun
	while(currentrun.len)
		var/obj/effect/hotspot/H = currentrun[currentrun.len]
		currentrun.len--
		if (H)
			H.process()
		else
			hotspots -= H
		if(MC_TICK_CHECK)
			return
