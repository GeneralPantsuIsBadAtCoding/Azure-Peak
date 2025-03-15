GLOBAL_VAR_INIT(ambush_chance_pct, 20) // Please don't raise this over 100 admins :')
GLOBAL_VAR_INIT(ambush_global_cooldown, 3 MINUTES) // Cooldown for the game spawning ambushes on anyone
GLOBAL_VAR_INIT(ambush_mobconsider_cooldown, 15 SECONDS) // Cooldown for each individual mob being considered for an ambush

/mob/living/proc/ambushable()
	if(mob_timers["ambushlast"])
		if(world.time < mob_timers["ambushlast"] + GLOB.ambush_global_cooldown)
			return FALSE
	if(stat)
		return FALSE
	return ambushable

/mob/living/proc/consider_ambush(always = FALSE)
	if(prob(100 - GLOB.ambush_chance_pct))
		return
	if(HAS_TRAIT(src, TRAIT_AZURENATIVE) && !always)
		return
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
	if(!(T.type in AR.ambush_types))
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
			testing("foundtree")
			possible_targets += RT.loc
//	for(var/obj/structure/flora/roguegrass/bush/RB in range(7, src))
//		if(can_see(src, RB))
//			possible_targets += RB
	for(var/obj/structure/flora/rogueshroom/RX in view(5, src))
		if(isturf(RX.loc))
			testing("foundshroom")
			possible_targets += RX.loc
	for(var/obj/structure/flora/newtree/RS in view(5, src))
		if(!RS.density)
			continue
		if(isturf(RS.loc))
			testing("foundshroom")
			possible_targets += RS.loc
	if(possible_targets.len)
		mob_timers["ambushlast"] = world.time
		for(var/mob/living/V in victimsa)
			V.mob_timers["ambushlast"] = world.time
		var/spawnedtype = pickweight(AR.ambush_mobs)
		var/mustype = 1
		for(var/i in 1 to CLAMP(victims*1,2,3))
			var/spawnloc = pick(possible_targets)
			if(spawnloc)
				var/mob/spawnedmob = new spawnedtype(spawnloc)
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
