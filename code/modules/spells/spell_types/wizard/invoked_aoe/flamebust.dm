/obj/effect/proc_holder/spell/invoked/flamebust
	name = "Flame Bust"
	desc = "Flame ground"
	overlay_state = "lightning_sunder"
	cost = 6
	spell_tier = 3
	releasedrain = 50
	chargedrain = 1
	chargetime = 20
	recharge_time = 30 SECONDS //x2 bladebust
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	charging_slowdown = 2
	glow_color = GLOW_COLOR_FIRE
	glow_intensity = GLOW_INTENSITY_HIGH
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	range = 2

/obj/effect/proc_holder/spell/invoked/flamebust/cast(list/targets, mob/user = usr)
	var/turf/T = get_turf(targets[1])
	var/user_skill = user.get_skill_level(associated_skill)
	if(user_skill == 6) //legend
		range = 3
//	var/list/affected_turfs = list()
	playsound(T,'sound/weather/rain/thunder_1.ogg', 80, TRUE)
	T.visible_message(span_boldwarning("The air feels crackling and charged!"))
	sleep(10)
	create_lightning(T)

//meteor storm and lightstorm.
/obj/effect/proc_holder/spell/invoked/flamebust/proc/create_lightning(atom/target)
	if(!target)
		return
	var/turf/targetturf = get_turf(target)
	for(var/t in spiral_range_turfs(range, targetturf))
		var/turf/T = t
		if(!T)
			continue
		var/dist = get_dist(targetturf, T)
		new /obj/effect/temp_visual/targetflame(T)

/obj/effect/temp_visual/targetflame
	icon = 'icons/effects/effects.dmi'
	icon_state = "flame"
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	light_outer_range = 2
	duration = 15
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

/obj/effect/temp_visual/targetflame/Initialize(mapload, list/flame_hit)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(fire), flame_hit)

/obj/effect/temp_visual/targetflame/proc/fire(list/flame_hit)
	var/turf/T = get_turf(src)
	sleep(duration)
	playsound(T,'sound/magic/lightning.ogg', 80, TRUE)
	new /obj/effect/hotspot(T)

	for(var/mob/living/L in T.contents)
		if(L.anti_magic_check())
			continue
		L.adjustFireLoss(20)
		to_chat(L, span_userdanger("You're hit by lightning!!!"))