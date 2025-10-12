#define SPAWN_DISTANCE 20

SUBSYSTEM_DEF(mob_spawners)
	name = "Mob Spawners"

	wait = 2 SECONDS
	priority = FIRE_PRIORITY_NPC
	flags = SS_POST_FIRE_TIMING|SS_NO_INIT|SS_BACKGROUND
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	var/list/currentrun = list()

/datum/controller/subsystem/mob_spawners/fire(resumed = FALSE)
	if (!resumed || !src.currentrun.len)
		var/list/activelist = GLOB.mob_spawners
		src.currentrun = activelist.Copy()

	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/obj/effect/landmark/mob_spawner/mob_spawner = currentrun[currentrun.len]
		--currentrun.len

		if(mob_spawner && !QDELETED(mob_spawner))
			for(var/mob/living/mob_player in GLOB.player_list)
				var/turf/im_here = get_turf(mob_spawner)
				var/turf/you_here = get_turf(mob_player)
				if(you_here.z != im_here.z)
					return
				if(get_dist(mob_spawner, mob_player) <= SPAWN_DISTANCE)
					mob_spawner.spawn_and_destroy()

		if (MC_TICK_CHECK)
			return

#undef SPAWN_DISTANCE
