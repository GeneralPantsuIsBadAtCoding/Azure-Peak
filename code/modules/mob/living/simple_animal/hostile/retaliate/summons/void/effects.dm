// Effects for void dragon
/obj/effect/temp_visual/target
	icon = null
	icon_state = null
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	light_outer_range = 2
	duration = 9
	var/exp_heavy = 0
	var/exp_light = 2
	var/exp_flash = 0
	var/exp_fire = 3
	var/exp_hotspot = 0
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

/obj/effect/temp_visual/target/Initialize(mapload, list/flame_hit)
	duration = rand(9, 15)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(fall), flame_hit)

/obj/effect/temp_visual/target/proc/fall(list/flame_hit)	//Potentially minor explosion at each impact point
	var/turf/T = get_turf(src)
	playsound(T,'sound/magic/meteorstorm.ogg', 80, TRUE)
	new /obj/effect/temp_visual/fireball(T)
	sleep(duration)
	if(ismineralturf(T))
		var/turf/closed/mineral/M = T
		M.gets_drilled()
	new /obj/effect/hotspot(T)
	for(var/mob/living/L in T.contents)
		if(islist(flame_hit) && !flame_hit[L])
			L.adjustFireLoss(40)
			L.adjust_fire_stacks(8)
			L.ignite_mob()
			to_chat(L, span_userdanger("You're hit by a meteor!"))
			flame_hit[L] = TRUE
		else
			L.adjustFireLoss(10) //if we've already hit them, do way less damage
	explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, soundin = explode_sound)

/obj/effect/temp_visual/lightning
	icon = 'icons/effects/32x96.dmi'
	icon_state = "lightning"
	name = "lightningbolt"
	desc = "ZAPP!!"
	layer = FLY_LAYER
	plane = GAME_PLANE_UPPER
	randomdir = FALSE
	duration = 7

/obj/effect/temp_visual/lightning/Initialize(mapload)
	. = ..()

/obj/effect/temp_visual/targetlightning
	icon = 'icons/effects/effects.dmi'
	icon_state = "trap"
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	light_outer_range = 2
	duration = 15
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

/obj/effect/temp_visual/targetlightning/Initialize(mapload, list/flame_hit)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(storm), flame_hit)

/obj/effect/temp_visual/targetlightning/proc/storm(list/flame_hit)	//electroshocktherapy
	var/turf/T = get_turf(src)
	sleep(duration)
	playsound(T,'sound/magic/lightning.ogg', 80, TRUE)
	new /obj/effect/temp_visual/lightning(T)

	for(var/mob/living/L in T.contents)
		if(L.anti_magic_check())
			continue
		L.electrocute_act(50)
		to_chat(L, span_userdanger("You're hit by lightning!!!"))

/obj/effect/temp_visual/fireball
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "meteor"
	name = "meteor"
	desc = "Get out of the way!"
	layer = FLY_LAYER
	plane = GAME_PLANE_UPPER
	randomdir = FALSE
	duration = 9
	pixel_z = 270

/obj/effect/temp_visual/fireball/Initialize(mapload, incoming_duration = 9)
	duration = incoming_duration
	. = ..()
	animate(src, pixel_z = 0, time = duration)
