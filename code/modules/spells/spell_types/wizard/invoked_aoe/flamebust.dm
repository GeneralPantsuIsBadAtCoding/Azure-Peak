/obj/effect/proc_holder/spell/invoked/flamebust
	name = "Flame Bust"
	desc = "Flame ground"
	overlay_state = "justflame"
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
	range = 1

/obj/effect/proc_holder/spell/invoked/flamebust/cast(list/targets, mob/user = usr)
	var/turf/T = get_turf(targets[1])
	var/user_skill = user.get_skill_level(associated_skill)
	if(user_skill == 6) //legend
		range = 2
//	var/list/affected_turfs = list()
	playsound(T,'sound/misc/explode/incendiary (1).ogg', 80, TRUE)
	T.visible_message(span_boldwarning("The air feels crackling and charged!"))
	create_fire(T)

//meteor storm and lightstorm.
/obj/effect/proc_holder/spell/invoked/flamebust/proc/create_fire(atom/target)
	if(!target)
		return
	var/turf/targetturf = get_turf(target)
	for(var/t in spiral_range_turfs(range, targetturf))
		var/turf/T = t
		if(!T)
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
		L.adjustFireLoss(20)
		to_chat(L, span_userdanger("You're hit by lightning!!!"))