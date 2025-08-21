GLOBAL_VAR_INIT(ambush_chance_pct, 20) // Please don't raise this over 100 admins :')
GLOBAL_VAR_INIT(ambush_mobconsider_cooldown, 5 MINUTES) // Cooldown for each individual mob being considered for an ambush
// Instead of setting it on area and hoping no one forgets it on area we're just doing this
GLOBAL_LIST_INIT(valid_ambush_turfs, list(
	/turf/open/floor/rogue/dirt,
	/turf/open/floor/rogue/dirt/road,
	/turf/open/floor/rogue/grass,
	/turf/open/floor/rogue/grasscold,
	/turf/open/floor/rogue/cobble,
	/turf/open/floor/rogue/sand,
	/turf/open/floor/rogue/snow,
	/turf/open/floor/rogue/AzureSand,
	/turf/open/water
))

/mob/living/proc/ambushable()
	if(stat)
		return FALSE
	return ambushable

/mob/living/proc/consider_ambush(always = FALSE)
	if(prob(100 - GLOB.ambush_chance_pct))
		return
	if(!always)
		if(HAS_TRAIT(src, TRAIT_AZURENATIVE))
			return
		if(world.time > last_client_interact + 0.3 SECONDS)
			return // unmoving afks can't trigger random ambushes i.e. when being pulled/kicked/etc
	if(mob_timers["ambush_check"])
		if(world.time < mob_timers["ambush_check"] + GLOB.ambush_mobconsider_cooldown)
			return
	mob_timers["ambush_check"] = world.time
	if(!ambushable())
		return
	var/area/AR = get_area(src)
	var/turf/T = get_turf(src)
	if(!T)
		return
	if(!(T.type in GLOB.valid_ambush_turfs))
		return
	var/campfires = 0
	for(var/obj/machinery/light/rogue/RF in view(5, src))
		if(RF.on)
			campfires++
	if(campfires > 0)
		return
	var/victims = 1
	var/list/victimsa = list()
	for(var/mob/living/V in view(5, src))
		if(V != src)
			if(V.ambushable())
				victims++
				victimsa += V
			if(victims > 3)
				return
	var/list/possible_targets = list()
	for(var/obj/structure/flora/roguetree/RT in view(5, src))
		if(istype(RT,/obj/structure/flora/roguetree/stump))
			continue
		if(isturf(RT.loc))
			possible_targets += get_adjacent_ambush_turfs(RT.loc)
	for(var/obj/structure/flora/roguegrass/bush/RB in view(5, src))
		if(isturf(RB.loc))
			possible_targets += get_adjacent_ambush_turfs(RB.loc)
	for(var/obj/structure/flora/rogueshroom/RX in view(5, src))
		if(isturf(RX.loc))
			possible_targets += get_adjacent_ambush_turfs(RX.loc)
	for(var/obj/structure/flora/newtree/RS in view(5, src))
		if(!RS.density)
			continue
		if(isturf(RS.loc))
			possible_targets += get_adjacent_ambush_turfs(RS.loc)
	if(possible_targets.len)
		mob_timers["ambushlast"] = world.time
		for(var/mob/living/V in victimsa)
			V.mob_timers["ambushlast"] = world.time
		var/list/mobs_to_spawn = list()
		var/mobs_to_spawn_single = FALSE
		var/max_spawns = 3
		var/mustype = 1
		var/spawnedtype = pickweight(AR.ambush_mobs)

		if(ispath(spawnedtype, /mob/living))
			max_spawns = CLAMP(victims*1, 2, 3)
			mobs_to_spawn_single = TRUE
		else if(istype(spawnedtype, /datum/ambush_config))
			var/datum/ambush_config/A = spawnedtype
			for(var/type_path in A.mob_types)
				var/amt = A.mob_types[type_path]
				for(var/i in 1 to amt)
					mobs_to_spawn += type_path
				max_spawns = mobs_to_spawn.len

		for(var/i in 1 to max_spawns)
			var/spawnloc = pick(possible_targets)
			if(spawnloc)
				var/mob_type
				if(mobs_to_spawn_single)
					mob_type = spawnedtype
				else
					if(!mobs_to_spawn.len)
						continue
					mob_type = mobs_to_spawn[1]
					mobs_to_spawn.Cut(1, 2)
				var/mob/spawnedmob = new mob_type(spawnloc)
				if(istype(spawnedmob, /mob/living/simple_animal/hostile))
					var/mob/living/simple_animal/hostile/M = spawnedmob
					M.attack_same = FALSE
					M.del_on_deaggro = 44 SECONDS
					M.GiveTarget(src)
				if(istype(spawnedmob, /mob/living/carbon/human))
					var/mob/living/carbon/human/H = spawnedmob
					H.del_on_deaggro = 44 SECONDS
					H.last_aggro_loss = world.time
					H.retaliate(src)
					mustype = 2
		if(mustype == 1)
			playsound_local(src, pick('sound/misc/jumpscare (1).ogg','sound/misc/jumpscare (2).ogg','sound/misc/jumpscare (3).ogg','sound/misc/jumpscare (4).ogg'), 100)
		else
			playsound_local(src, pick('sound/misc/jumphumans (1).ogg','sound/misc/jumphumans (2).ogg','sound/misc/jumphumans (3).ogg'), 100)
		shake_camera(src, 2, 2)
		if(iscarbon(src))
			var/mob/living/carbon/C = src
			if(C.get_stress_amount() >= 30 && (prob(0)))
				C.heart_attack()

/proc/get_adjacent_ambush_turfs(turf/T)
	var/list/adjacent = list()
	for(var/turf/AT in get_adjacent_turfs(T))
		if(AT.density || T.LinkBlockedWithAccess(AT, null))
			continue
		adjacent += AT
	return adjacent
