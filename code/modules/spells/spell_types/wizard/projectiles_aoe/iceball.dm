/obj/effect/proc_holder/spell/invoked/projectile/iceball
	name = "Iceball"
	desc = "Shoot out a ball of fire that emits a light explosion on impact, setting the target alight."
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/iceball
	overlay_state = "iceball"
	sound = list('sound/magic/whiteflame.ogg')
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	recharge_time = 15 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	spell_tier = 3 // AOE
	invocations = list("Sphaera Ignis!")
	invocation_type = "shout"
	glow_color = GLOW_COLOR_ARCANE
	glow_intensity = GLOW_INTENSITY_HIGH
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 6
	xp_gain = TRUE

/obj/projectile/magic/aoe/iceball
	name = "iceball"
	icon_state = "iceball"
	light_color = "#07c8f8ff"
	damage = 30
	damage_type = BURN
	npc_simple_damage_mult = 3 // 90 dmg similar fireball
	accuracy = 40 // Base accuracy is lower for burn projectiles because they bypass armor
	speed = 5
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/blank.ogg'
	var/area_of_effect = 1


/obj/projectile/magic/aoe/iceball/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ismob(target))
		var/mob/living/M = target
		var/turf/T = get_turf(M)
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		M.apply_status_effect(/datum/status_effect/freon/freezing)
		M.Immobilize(10)
		M.OffBalance(10)
		explosion(M, -1, 0, 1, 0, 0, flame_range = 0, soundin = 'sound/magic/whiteflame.ogg')

		for(M in range(area_of_effect, T)) //apply damage over time to mobs
			M.apply_status_effect(/datum/status_effect/buff/frostbite)
			M.stamina_add(damage)

		for(var/turf/affected_turf in view(area_of_effect, T))
			new /obj/effect/temp_visual/snap_freeze(affected_turf)
			new /obj/effect/temp_visual/iceblast(affected_turf)

		for(var/turf/affected_turf in view(area_of_effect, T))
			if(M in affected_turf)
				continue
			new /obj/structure/roguerock/iceblast(affected_turf)

/obj/effect/temp_visual/iceblast
	icon = 'icons/turf/roguefloor.dmi'
	icon_state = "blackice"
	name = "tought ice"
	desc = "A deep black rock glazed over with unnaturally cold ice."
	randomdir = TRUE
	duration = 20 SECONDS
	layer = 1

/obj/structure/roguerock/iceblast
	name = "ice pillar"
	desc = "A rock protuding from the ground."
	icon_state = "ice1"
	icon = 'icons/effects/effects.dmi'
	opacity = 0
	max_integrity = 10
	climbable = TRUE
	climb_time = 30
	density = TRUE
	layer = 1.1
	blade_dulling = DULLING_BASH
	static_debris = null
	debris = null
	alpha = 255
	climb_offset = 14
	static_debris = list()

/obj/structure/roguerock/Initialize()
	. = ..()
	icon_state = "ice[rand(1,3)]"
