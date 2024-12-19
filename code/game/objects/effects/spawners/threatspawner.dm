/*
*	So, here's the general idea behind these:
*	These are static threat spawners. They routinely will, at random, generate enemies
*	in the same way that ambushes spawn them - that is, spawning them around random
*	trees/mushrooms/etc within view of the target. However, unlike ambushes, THESE
*	mobs will actually stick around and not despawn!
*
*	After a specified time into the round, the threat spawners become "active," and will
*	start a cooldown that is randomized between the min and max time. When the cooldown
*	hits 0, it spawns lingering enemies around any valid targets in much the same way
*	that ambushes spawn enemies. Then it goes on a randomized cooldown again, and the
*	cycle repeats for the rest of the round.
*/

GLOBAL_VAR_INIT(threatspawner_cd_min, 10 MINUTES)
GLOBAL_VAR_INIT(threatspawner_cd_max, 17 MINUTES)
// Determines different min/max possible ranges for # of enemies spawned.
// Makes it much more common that only a couple enemies spawn
// while making it unlikely but possible that a bunch of enemies spawn as a !!FUN SURPRISE!!
GLOBAL_LIST_INIT(threatspawner_quantities, list(
	list(1,2) = 40,
	list(2,3) = 15,
	list(3,4) = 3,
	list(4,6) = 1,
))


/obj/effect/landmark/threatspawner
	name = "static threat spawner"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "threatspawner"
	var/inital_cooldown = 30 MINUTES /// How long we wait at round start before becoming active
	var/spawn_range = 5 /// Max range around us to search for spawnable objects
	var/next_spawn_time = 0 /// The time at which we will spawn more dudes
	var/list/mob/living/able_mobs = list() /// List of our spawned mobs who are still able to fight
	var/next_mob_check = 0 /// The time at which we will check our living mobs to see if they're still kickin'
	var/can_spawn = 0 /// Can we spawn more mobs?

/obj/effect/landmark/threatspawner/Initialize()
	. = ..()
	next_spawn_time = world.time + inital_cooldown
	start_check_cooldown()
	START_PROCESSING(SSprocessing, src)

/obj/effect/landmark/threatspawner/Destroy(force)
	. = ..()
	STOP_PROCESSING(SSprocessing, src)

/obj/effect/landmark/threatspawner/process()
	if(world.time > next_spawn_time)
		consider_spawning()
	if(world.time > next_mob_check)
		check_our_mobs()

/obj/effect/landmark/threatspawner/proc/consider_spawning()
	// I shamelessly stole a lot of this from ambush code hehehehe
	if(!can_spawn)
		start_cooldown()
		return
	var/turf/T = get_turf(src)
	if(!T)
		return
	// First, make sure nobody is able to see us or anything we might spawn!
	var/viewers = 0
	for(var/mob/living/carbon/human/L in viewers(src, 7 + spawn_range))
		if(L.stat == CONSCIOUS)
			viewers++
	if(viewers)
		// If there are viewers, we'll just wait a bit and then try again.
		next_spawn_time = world.time + 30 SECONDS
		return
	// Now, make sure we don't have any lit objects around us!
	// (This way we don't wind up spawning dudes in a space a player might be building in)
	var/lights = 0
	for(var/obj/machinery/light/rogue/RF in view(spawn_range, src))
		if(RF.on)
			lights++
	if(lights > 0)
		// If there are, well, guess we'll wait a good while before checking again.
		start_cooldown()
		return
	spawn_threats()
	
/obj/effect/landmark/threatspawner/proc/spawn_threats()
	var/list/possible_targets = list()
	for(var/obj/structure/flora/F in view(src, spawn_range))
		if(isturf(F.loc))
			possible_targets += F.loc
	// If we find no valid flora to spawn them on, then um... uh... I guess we wait a while??
	if(!possible_targets.len)
		start_cooldown()
		return
	// First determine the minimum and maximum possible quantity of dudes we'll spawn
	var/list/minmax = pickweight(GLOB.threatspawner_quantities)
	var/amt2spawn = rand(minmax[1], minmax[2])
	// Now we actually spawn the dudes!!
	var/area/AR = get_area(src)
	var/spawnedtype = get_mob_spawn_type(AR)
	for(var/i in 1 to amt2spawn)
		var/spawnloc = pick(possible_targets)
		if(spawnloc)
			var/mob/living/spawnedmob = new spawnedtype(spawnloc)
			able_mobs.Add(spawnedmob)
			if(istype(spawnedmob, /mob/living/simple_animal/hostile))
				var/mob/living/simple_animal/hostile/M = spawnedmob
				M.attack_same = FALSE
			if(istype(spawnedmob, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = spawnedmob
				H.last_aggro_loss = world.time
	start_cooldown()
	start_check_cooldown()

/obj/effect/landmark/threatspawner/proc/check_our_mobs()
	for(var/mob/living/M in able_mobs)
		if(!is_our_baby_okay(M))
			able_mobs.Remove(M)
	// can_spawn = able_mobs.len <= 1 // commented out to reel back mob induced lag a bit
	can_spawn = able_mobs.len <= 0
	start_check_cooldown()
		

/obj/effect/landmark/threatspawner/proc/is_our_baby_okay(mob/living/M)
	if(!M)
		return FALSE
	if(isanimal(M))
		var/mob/living/simple_animal/A = M
		return is_animal_able_2fight(A)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		return is_human_able_2fight(H)
	// Uhhh we shouldn't reach this point ever but just in case
	return FALSE

/obj/effect/landmark/threatspawner/proc/is_human_able_2fight(mob/living/carbon/human/H)
	// Can't fight if you're dead!
	if(H.stat >= UNCONSCIOUS)
		return FALSE
	// If the mob is unable to walk/stand, they can no longer fight for us and we must sadly let them go
	if((H.mobility_flags & (MOBILITY_MOVE | MOBILITY_STAND)) != (MOBILITY_MOVE | MOBILITY_STAND))
		return FALSE // o7
	return TRUE

/obj/effect/landmark/threatspawner/proc/is_animal_able_2fight(mob/living/simple_animal/A)
	if(A.health <= 0)
		return FALSE
	else
		return TRUE

/// Returns the type of the mob that the spawner will create
/obj/effect/landmark/threatspawner/proc/get_mob_spawn_type(area/AR)
	return pickweight(AR.ambush_mobs)

/obj/effect/landmark/threatspawner/proc/start_cooldown()
	next_spawn_time = world.time + rand(GLOB.threatspawner_cd_min, GLOB.threatspawner_cd_max)

/obj/effect/landmark/threatspawner/proc/start_check_cooldown()
	next_mob_check = world.time + 30 SECONDS 


/// Subtype of threat spawner with a short initial cooldown, intended for places that will be cleared out pretty early on.
/obj/effect/landmark/threatspawner/shortinit
	inital_cooldown = 15 MINUTES


/// Subtype of threat spawner with a longer initial cooldown, intended for places that will probably take a while before being cleared.
/obj/effect/landmark/threatspawner/longinit
	inital_cooldown = 45 MINUTES

/// Debug-only!!
/obj/effect/landmark/threatspawner/instant
	inital_cooldown = 1 SECONDS

// --------------- ONE-TYPE-SPAWN ---------------

// NORMAL GOBLIN
/obj/effect/landmark/threatspawner/goblin
	icon_state = "threatspawner-goblin"
/obj/effect/landmark/threatspawner/goblin/get_mob_spawn_type(area/AR)
	return /mob/living/carbon/human/species/goblin/npc/ambush

/obj/effect/landmark/threatspawner/goblin/shortinit
	inital_cooldown = 15 MINUTES

/obj/effect/landmark/threatspawner/goblin/longinit
	inital_cooldown = 45 MINUTES

/obj/effect/landmark/threatspawner/goblin/instant
	inital_cooldown = 1 SECONDS

// SEA GOBLIN
/obj/effect/landmark/threatspawner/goblin/sea
	icon_state = "threatspawner-goblin-sea"
/obj/effect/landmark/threatspawner/goblin/sea/get_mob_spawn_type(area/AR)
	return /mob/living/carbon/human/species/goblin/npc/ambush/sea

/obj/effect/landmark/threatspawner/goblin/sea/shortinit
	inital_cooldown = 15 MINUTES

/obj/effect/landmark/threatspawner/goblin/sea/longinit
	inital_cooldown = 45 MINUTES

/obj/effect/landmark/threatspawner/goblin/sea/instant
	inital_cooldown = 1 SECONDS

// HELL GOBLIN
/obj/effect/landmark/threatspawner/goblin/hell
	icon_state = "threatspawner-goblin-hell"
/obj/effect/landmark/threatspawner/goblin/hell/get_mob_spawn_type(area/AR)
	return /mob/living/carbon/human/species/goblin/npc/ambush/hell

/obj/effect/landmark/threatspawner/goblin/hell/shortinit
	inital_cooldown = 15 MINUTES

/obj/effect/landmark/threatspawner/goblin/hell/instant
	inital_cooldown = 1 SECONDS

/obj/effect/landmark/threatspawner/goblin/hell/longinit
	inital_cooldown = 45 MINUTES

/obj/effect/landmark/threatspawner/goblin/hell/instant
	inital_cooldown = 1 SECONDS

// CAVE GOBLIN
/obj/effect/landmark/threatspawner/goblin/cave
	icon_state = "threatspawner-goblin-cave"
/obj/effect/landmark/threatspawner/goblin/cave/get_mob_spawn_type(area/AR)
	return /mob/living/carbon/human/species/goblin/npc/ambush/cave

/obj/effect/landmark/threatspawner/goblin/cave/shortinit
	inital_cooldown = 15 MINUTES

/obj/effect/landmark/threatspawner/goblin/cave/longinit
	inital_cooldown = 45 MINUTES

/obj/effect/landmark/threatspawner/goblin/cave/instant
	inital_cooldown = 1 SECONDS

// SKELETON
/obj/effect/landmark/threatspawner/skeleton
	icon_state = "threatspawner-skeleton"
/obj/effect/landmark/threatspawner/skeleton/get_mob_spawn_type(area/AR)
	return /mob/living/carbon/human/species/skeleton/npc/ambush

/obj/effect/landmark/threatspawner/skeleton/shortinit
	inital_cooldown = 15 MINUTES

/obj/effect/landmark/threatspawner/skeleton/longinit
	inital_cooldown = 45 MINUTES

/obj/effect/landmark/threatspawner/skeleton/instant
	inital_cooldown = 1 SECONDS

// WOLF
/obj/effect/landmark/threatspawner/wolf
	icon_state = "threatspawner-wolf"
/obj/effect/landmark/threatspawner/wolf/get_mob_spawn_type(area/AR)
	return /mob/living/simple_animal/hostile/retaliate/rogue/wolf

/obj/effect/landmark/threatspawner/wolf/shortinit
	inital_cooldown = 15 MINUTES

/obj/effect/landmark/threatspawner/wolf/longinit
	inital_cooldown = 45 MINUTES

/obj/effect/landmark/threatspawner/wolf/instant
	inital_cooldown = 1 SECONDS

// SEA RAIDER
/obj/effect/landmark/threatspawner/searaider
	icon_state = "threatspawner-human"
/obj/effect/landmark/threatspawner/searaider/get_mob_spawn_type(area/AR)
	return /mob/living/carbon/human/species/human/northern/searaider/ambush

/obj/effect/landmark/threatspawner/searaider/shortinit
	inital_cooldown = 15 MINUTES

/obj/effect/landmark/threatspawner/searaider/longinit
	inital_cooldown = 45 MINUTES

/obj/effect/landmark/threatspawner/searaider/instant
	inital_cooldown = 1 SECONDS

// BIG RAT
/obj/effect/landmark/threatspawner/bigrat
	icon_state = "threatspawner-rous"
/obj/effect/landmark/threatspawner/bigrat/get_mob_spawn_type(area/AR)
	return /mob/living/simple_animal/hostile/retaliate/rogue/bigrat

/obj/effect/landmark/threatspawner/bigrat/shortinit
	inital_cooldown = 15 MINUTES

/obj/effect/landmark/threatspawner/bigrat/longinit
	inital_cooldown = 45 MINUTES

/obj/effect/landmark/threatspawner/bigrat/instant
	inital_cooldown = 1 SECONDS

// SPIDER
/obj/effect/landmark/threatspawner/spider
	icon_state = "threatspawner-spider-honey"
/obj/effect/landmark/threatspawner/spider/get_mob_spawn_type(area/AR)
	return /mob/living/simple_animal/hostile/retaliate/rogue/spider

/obj/effect/landmark/threatspawner/spider/shortinit
	inital_cooldown = 15 MINUTES

/obj/effect/landmark/threatspawner/spider/longinit
	inital_cooldown = 45 MINUTES

/obj/effect/landmark/threatspawner/spider/instant
	inital_cooldown = 1 SECONDS

// BOG TROLL
/obj/effect/landmark/threatspawner/bogtroll
	icon_state = "threatspawner-troll-bog"
/obj/effect/landmark/threatspawner/bogtroll/get_mob_spawn_type(area/AR)
	return /mob/living/simple_animal/hostile/retaliate/rogue/bogtroll

/obj/effect/landmark/threatspawner/bogtroll/shortinit
	inital_cooldown = 15 MINUTES

/obj/effect/landmark/threatspawner/bogtroll/longinit
	inital_cooldown = 45 MINUTES

/obj/effect/landmark/threatspawner/bogtroll/instant
	inital_cooldown = 1 SECONDS

// CAVE TROLL
/obj/effect/landmark/threatspawner/cavetroll
	icon_state = "threatspawner-troll-cave"
/obj/effect/landmark/threatspawner/cavetroll/get_mob_spawn_type(area/AR)
	return /mob/living/simple_animal/hostile/retaliate/rogue/cavetroll

/obj/effect/landmark/threatspawner/cavetroll/shortinit
	inital_cooldown = 15 MINUTES

/obj/effect/landmark/threatspawner/cavetroll/longinit
	inital_cooldown = 45 MINUTES

/obj/effect/landmark/threatspawner/cavetroll/instant
	inital_cooldown = 1 SECONDS
