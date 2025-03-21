GLOBAL_VAR_INIT(ambush_chance_pct, 20) // Please don't raise this over 100 admins :')
GLOBAL_VAR_INIT(ambush_global_cooldown, 3 MINUTES) // Cooldown for the game spawning ambushes on anyone
GLOBAL_VAR_INIT(ambush_mobconsider_cooldown, 15 SECONDS) // Cooldown for each individual mob being considered for an ambush

/mob/living/proc/ambushable()
	// If the mob has the Curse of Woe, they are always ambushable
	if(has_status_effect(/datum/status_effect/debuff/curse_of_woe))
		return TRUE
		
	if(mob_timers["ambushlast"])
		if(world.time < mob_timers["ambushlast"] + GLOB.ambush_global_cooldown)
			return FALSE
	if(stat)
		return FALSE
	
	// For NPCs, check if they have the ambushable var set
	if(!istype(src, /mob/living/carbon/human))
		return ambushable ? TRUE : FALSE
		
	return ambushable

/mob/living/proc/consider_ambush(always = FALSE)
	// Check if the mob has the Curse of Woe
	var/has_woe = has_status_effect(/datum/status_effect/debuff/curse_of_woe)
	var/ambush_chance = has_woe ? 40 : GLOB.ambush_chance_pct // 40% chance for those with Curse of Woe
	
	if(prob(100 - ambush_chance))
		return
	if(HAS_TRAIT(src, TRAIT_AZURENATIVE) && !always)
		return
	if(mob_timers["ambush_check"])
		if(world.time < mob_timers["ambush_check"] + GLOB.ambush_mobconsider_cooldown)
			return
	mob_timers["ambush_check"] = world.time
	
	// For those with Curse of Woe, skip the ambushable check
	if(!has_woe && !ambushable())
		return
		
	var/area/AR = get_area(src)
	var/turf/T = get_turf(src)
	if(!T)
		return
	
	// For those with Curse of Woe, skip the turf type check
	if(!has_woe && !(T.type in AR.ambush_types))
		return
		
	// For areas with no ambush mobs defined, use a default set
	if(!AR.ambush_mobs || !length(AR.ambush_mobs))
		AR.ambush_mobs = list(
			/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 40,
			/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 60
		)
		
	var/campfires = 0
	for(var/obj/machinery/light/rogue/RF in view(5, src))
		if(RF.on)
			campfires++
	// Those with Curse of Woe can be ambushed even near light sources
	if(campfires > 0 && !has_woe)
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
	
	// For those with Curse of Woe, ANY tile can be a spawn point
	if(has_woe)
		for(var/turf/F in view(7, src))
			if(F != T) // Don't spawn on the target's tile
				possible_targets += F
	else
		// Regular spawn points for normal ambushes
		for(var/obj/structure/flora/roguetree/RT in view(5, src))
			if(istype(RT,/obj/structure/flora/roguetree/stump))
				continue
			if(isturf(RT.loc))
				testing("foundtree")
				possible_targets += RT.loc
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
			
	if(length(possible_targets))
		mob_timers["ambushlast"] = world.time
		for(var/mob/living/V in victimsa)
			V.mob_timers["ambushlast"] = world.time
		
		var/mustype = 1
		
		// Those with Curse of Woe get more attackers
		var/spawn_count = has_woe ? CLAMP(victims*1.5, 2, 4) : CLAMP(victims*1, 2, 3)
		
		// For those with Curse of Woe, spawn jester raiders instead of normal ambush mobs
		if(has_woe)
			for(var/i in 1 to spawn_count)
				var/spawnloc = pick(possible_targets)
				if(spawnloc)
					var/mob/living/carbon/human/species/human/northern/jester_raider/jester = new(spawnloc)
					jester.is_silent = FALSE // Allow them to speak their lines
					jester.target = src
					jester.mode = AI_HUNT
					jester.aggressive = 1
					jester.wander = TRUE
					
					// Make them say something when they spawn
					addtimer(CALLBACK(jester, TYPE_PROC_REF(/mob/living/carbon/human/species/human/northern/jester_raider, retaliate), src), 5)
			
			// Special effects for jester raiders
			to_chat(src, span_warning("<b>Xylix's jesters emerge to claim you!</b>"))
			playsound_local(src, pick('sound/vo/male/jester/laugh (1).ogg','sound/vo/male/jester/laugh (2).ogg','sound/vo/male/jester/laugh (3).ogg'), 100, vary = TRUE)
			mustype = 3 // Special mustype for jesters
		else
			// Regular ambush mobs for those without the curse
			var/spawnedtype = pickweight(AR.ambush_mobs)
			
			for(var/i in 1 to spawn_count)
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
		
		// Special effects for those with Curse of Woe
		if(has_woe && mustype != 3)
			to_chat(src, span_warning("<b>Xylix's curse draws enemies to you...</b>"))
			
		if(mustype == 1)
			playsound_local(src, pick('sound/misc/jumpscare (1).ogg','sound/misc/jumpscare (2).ogg','sound/misc/jumpscare (3).ogg','sound/misc/jumpscare (4).ogg'), 100)
		else if(mustype == 2)
			playsound_local(src, pick('sound/misc/jumphumans (1).ogg','sound/misc/jumphumans (2).ogg','sound/misc/jumphumans (3).ogg'), 100)
		shake_camera(src, 2, 2)
		if(iscarbon(src))
			var/mob/living/carbon/C = src
			if(C.get_stress_amount() >= 30 && (prob(has_woe ? 5 : 0)))
				C.heart_attack()
				
		// Check if this was triggered by Xylix's Curse of Woe and remove it if so
		check_curse_of_woe_ambush()
