/obj/effect/proc_holder/spell/invoked/projectile/guided_bolt
	name = "Guided Bolt"
	desc = "Shoot out a bolt of arcyne magic in an indirect arc. Difficult to hit, but quick to recharge and able to arc over friendly. Inflicts blunt damage. \n\
	Damage is increased by 50% versus simple-minded creechurs."
	clothes_req = FALSE
	range = 12
	projectile_type = /obj/projectile/energy/guided_bolt
	overlay_state = "force_dart"
	sound = list('sound/magic/vlightning.ogg')
	active = FALSE
	releasedrain = 20
	chargedrain = 1
	chargetime = 3
	recharge_time = 4 SECONDS // This has to be aimed unlike Arcyne Bolt.
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	spell_tier = 2
	invocations = list("Sagitta Dirigitur!")
	invocation_type = "shout"
	glow_color = GLOW_COLOR_ARCANE
	glow_intensity = GLOW_INTENSITY_LOW
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 2 // slightly less useful than Arcyne Bolt and supportish, so 2 cost

/obj/projectile/energy/guided_bolt
	name = "Guided Bolt"
	icon_state = "arcane_barrage"
	damage = 40
	woundclass = BCLASS_BLUNT
	arcshot = TRUE
	nodamage = FALSE
	npc_damage_mult = 1.5 
	hitsound = 'sound/combat/hits/blunt/shovel_hit2.ogg'
	speed = 1

/obj/projectile/energy/guided_bolt/on_hit(target)
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
