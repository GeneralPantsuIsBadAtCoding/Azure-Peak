/obj/effect/proc_holder/spell/invoked/projectile/fireball/artillery
	name = "Artillery Fireball"
	desc = "A arc'd fireball that seemingly does far more damage to structures than people."
	clothes_req = FALSE
	cost = 6
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue/artillery
	overlay_state = "fireball_artillery"
	sound = list('sound/magic/fireball.ogg')
	releasedrain = 30
	chargedrain = 1
	chargetime = 25
	recharge_time = 30 SECONDS // 10 seconds more than fireball
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	spell_tier = 4 // Court mage can have this as a treat
	invocations = "Ignis Sphaera directa!"
	invocation_type = "shout"
	glow_color = GLOW_COLOR_FIRE
	glow_intensity = GLOW_INTENSITY_HIGH
	chargedloop = /datum/looping_sound/invokefire
	associated_skill = /datum/skill/magic/arcane
	xp_gain = TRUE

/obj/effect/proc_holder/spell/invoked/projectile/fireball/artillery/cast(list/targets, mob/user = user)
	var/mob/living/carbon/human/H = user
	var/datum/intent/a_intent = H.a_intent
	if(istype(a_intent, /datum/intent/special/magicarc))
		projectile_type = /obj/projectile/magic/aoe/fireball/rogue/artillery/arc
	else
		projectile_type = /obj/projectile/magic/aoe/fireball/rogue/artillery
	. = ..()

/obj/projectile/magic/aoe/fireball/rogue/artillery
	name = "Artillery Fireball"
	exp_heavy = 0
	exp_light = 0
	exp_flash = 0
	exp_fire = 1
	damage = 50 // 10 less damage than actual fireball
	damage_type = BURN
	npc_simple_damage_mult = 2 // HAHAHA
	accuracy = 40 // Base accuracy is lower for burn projectiles because they bypass armor
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/blank.ogg'
	aoe_range = 0

/obj/projectile/magic/aoe/fireball/rogue/artillery/arc
	name = "Arced Artillery Fireball"
	damage = 40 // 20% damage penalty
	arcshot = TRUE

/obj/projectile/magic/aoe/fireball/rogue/artillery/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
	var/turf/fallzone = get_turf(target)
	if(!fallzone)
		return
	var/const/damage = 300 //Structural damage the spell does, on average a door is 1100 integrity, and a window is 200
	var/const/radius = 1
	// The visuals are here, the lava is just for visuals and doesn't ACTUALLY damage you! Just looks cool and indicates what is structures will be damaged.
	for(var/turf/open/visual in view(radius, fallzone))
		var/obj/effect/temp_visual/lavastaff/Lava = new /obj/effect/temp_visual/lavastaff(visual)
		var/datum/effect_system/smoke_spread/S = new /datum/effect_system/smoke_spread // SMOKE EFFECT
		animate(Lava, alpha = 255, time = 5)
		S.set_up(radius, fallzone)
		S.start()
	// Everything from this point has to do with what is damaged, additional structures can be added to the list to have different damage/effects!
	for(var/obj/structure/damaged in view(radius, fallzone))
		if(!istype(damaged, /obj/structure/flora/newbranch))
			damaged.take_damage(damage, BRUTE, "blunt", 1)
	for(var/turf/closed/wall/damagedwalls in view(radius, fallzone))
		damagedwalls.take_damage(damage, BRUTE, "blunt", 1)
