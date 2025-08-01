/obj/effect/proc_holder/spell/invoked/projectile/arcynebolt
	name = "Arcyne Bolt"
	desc = "Shoot out a rapid bolt of arcyne magic. Inflicts blunt damage similar to a slingstone. \n\
	Damage is increased by 50% versus simple-minded creechurs."
	clothes_req = FALSE
	range = 12
	projectile_type = /obj/projectile/energy/rogue3
	overlay_state = "force_dart"
	sound = list('sound/magic/vlightning.ogg')
	active = FALSE
	releasedrain = 20
	chargedrain = 1
	chargetime = 0
	recharge_time = 4 SECONDS
	human_req = TRUE
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	spell_tier = 2
	invocation = "Magicae Sagitta!"
	invocation_type = "shout"
	glow_color = GLOW_COLOR_ARCANE
	glow_intensity = GLOW_INTENSITY_LOW
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 3

/obj/projectile/energy/rogue3
	name = "Arcyne Bolt"
	icon_state = "arcane_barrage"
	damage = 40
	woundclass = BCLASS_BLUNT
	nodamage = FALSE
	npc_damage_mult = 1.5 // Makes it more effective against NPCs.
	hitsound = 'sound/combat/hits/blunt/shovel_hit2.ogg'
	speed = 1

/obj/projectile/energy/rogue3/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/living/carbon/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		playsound(get_turf(target), 'sound/combat/hits/blunt/shovel_hit2.ogg', 100) //CLANG
	else
		return
