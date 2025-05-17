/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt
	name = "Bolt of Lightning"
	desc = "Emit a bolt of lightning that burns and stuns a target."
	clothes_req = FALSE
	overlay_state = "lightning"
	sound = 'sound/magic/lightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/lightning
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	recharge_time = 25 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokelightning
	associated_skill = /datum/skill/magic/arcane
	glow_color = GLOW_COLOR_LIGHTNING
	glow_intensity = GLOW_INTENSITY_MEDIUM
	spell_tier = 2
	invocation = "Fulmen!"
	invocation_type = "shout"
	cost = 1
	xp_gain = TRUE

/obj/projectile/magic/lightning
	name = "bolt of lightning"
	tracer_type = /obj/effect/projectile/tracer/stun
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	light_color = LIGHT_COLOR_WHITE
	damage = 25
	damage_type = BURN
	accuracy = 40 // Base accuracy is lower for burn projectiles because they bypass armor
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#ffffff"
	light_outer_range = 7

/obj/projectile/magic/lightning/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(isliving(target))
			var/mob/living/L = target
			var/immobduration = 2 SECONDS
			if(L.client)
				if(L.STACON >= 10)
					var/extra_con = L.STACON - 10
					immobduration = max(0, 2 SECONDS - extra_con * 5) //Default immobilization duration is 2 seconds (20), for each point of con above 1 on the target, the duration is reduced by 5 ticks.
					L.Immobilize(immobduration)
					if(immobduration >= 1)
						L.electrocute_act(2, src, 2, SHOCK_NOSTUN)
					else
						L.electrocute_act(1, src, 1, SHOCK_NOSTUN)
						to_chat(L, span_warning("I shrug off the lightning bolt!"))
						L.visible_message(span_danger("[L] shrugs off the lightning bolt!"))
			else
				L.Paralyze(10)
				L.electrocute_act(2, src, 2, SHOCK_NOSTUN)
	qdel(src)
