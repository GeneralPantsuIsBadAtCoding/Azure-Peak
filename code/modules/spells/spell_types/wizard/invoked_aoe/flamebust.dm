/obj/effect/proc_holder/spell/invoked/pyro/flamebust
	name = "Flame Bust"
	desc = "After a short delay, create a powerful burst of flame across the area! \n\
	Damage is increased by 100% versus simple-minded creechurs \n\
	True arcana masters can enhance this spell!"
	overlay_state = "flamebust"
	action_icon_state = "flamebust"
	cost = 6
	spell_tier = 3
	releasedrain = 50
	chargedrain = 1
	chargetime = 5 SECONDS
	recharge_time = 30 SECONDS //x2 bladebust
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	glow_color = GLOW_COLOR_FIRE
	glow_intensity = GLOW_INTENSITY_HIGH
	chargedloop = /datum/looping_sound/invokefire
	associated_skill = /datum/skill/magic/arcane
	range = 1

/obj/effect/proc_holder/spell/invoked/pyro/flamebust/cast(list/targets, mob/user = usr)
	var/turf/T = get_turf(targets[1])
	var/user_skill = user.get_skill_level(associated_skill)
	if(user_skill == 6) //legend
		range = 2
//	var/list/affected_turfs = list()
	playsound(T,'sound/misc/explode/incendiary (1).ogg', 80, TRUE)
	T.visible_message(span_boldwarning("The air feels crackling and charged!"))
	create_fire(T)

//meteor storm and lightstorm.
/obj/effect/proc_holder/spell/invoked/pyro/flamebust/proc/create_fire(atom/target)
	if(!target)
		return
	var/turf/targetturf = get_turf(target)
	for(var/t in spiral_range_turfs(range, targetturf))
		var/turf/T = t
		if(!T)
			continue
		if(istype(T, /turf/closed))
			continue
		new /obj/effect/temp_visual/targetflame(T)

/obj/effect/temp_visual/targetflame
	icon = 'icons/effects/effects.dmi'
	icon_state = "flame"
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	light_outer_range = 2
	duration = 20
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

/obj/effect/temp_visual/targetflame/Initialize(mapload, list/flame_hit)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(fire), flame_hit)

/obj/effect/temp_visual/targetflame/proc/fire(list/flame_hit)
	var/turf/T = get_turf(src)
	sleep(duration)
	playsound(T,'sound/misc/explode/incendiary (2).ogg', 80, TRUE)
	new /obj/effect/hotspot(T)

	for(var/mob/living/L in T.contents)
		if(L.anti_magic_check())
			continue
		if (!L.mind && istype(L, /mob/living/simple_animal))
			L.adjustFireLoss(30) //x2 VS mobs
		L.adjustFireLoss(30)
		to_chat(L, span_userdanger("You're hit by flame!!!"))