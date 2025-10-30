/obj/effect/proc_holder/spell/invoked/projectile/teslaball
	name = "Lightball"
	desc = "Shoot out a ball of fire that emits a light explosion on impact, setting the target alight."
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/teslaball
	overlay_state = "teslaball"
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
	glow_color = GLOW_COLOR_LIGHTNING
	glow_intensity = GLOW_INTENSITY_HIGH
	chargedloop = /datum/looping_sound/invokelightning
	associated_skill = /datum/skill/magic/arcane
	cost = 6
	xp_gain = TRUE

/obj/projectile/magic/aoe/teslaball
	name = "teslaball"
	icon_state = "tesla_projectile"
	light_color = "#ecec88ff"
	damage = 60
	damage_type = BURN
	speed = 7
	npc_simple_damage_mult = 1.5 // 90 dmg similar fireball
	accuracy = 40 // Base accuracy is lower for burn projectiles because they bypass armor
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/blank.ogg'
	var/area_of_effect = 2


/obj/projectile/magic/aoe/teslaball/on_hit(atom/target, blocked = FALSE, mob/living/user)
	. = ..()
	if(ismob(target))
		var/mob/living/M = target
		var/turf/T = get_turf(M)
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		M.apply_status_effect(/datum/status_effect/debuff/clickcd, 1 SECONDS)
		M.electrocute_act(1, src, 1, SHOCK_NOSTUN)
		M.apply_status_effect(/datum/status_effect/buff/lightningstruck, 6 SECONDS)
		explosion(M, -1, 0, 1, 0, 0, flame_range = 0, soundin = 'sound/magic/lightning.ogg')
		for(var/mob/living/L in range(area_of_effect, T) - M)
			M.apply_status_effect(/datum/status_effect/debuff/clickcd, 1 SECONDS)
			M.electrocute_act(1, src, 1, SHOCK_NOSTUN)
			M.apply_status_effect(/datum/status_effect/buff/lightningstruck, 6 SECONDS)
			M.adjustFireLoss(60)