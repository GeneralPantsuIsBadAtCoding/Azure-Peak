
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
	chargetime = 20
	charge_max = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokelightning
	associated_skill = /datum/skill/magic/arcane
	cost = 2
	xp_gain = TRUE

/obj/projectile/magic/lightning
	name = "bolt of lightning"
	tracer_type = /obj/effect/projectile/tracer/stun
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	light_color = LIGHT_COLOR_WHITE
	damage = 15
	damage_type = BURN
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
			if(L.STACON <= 14)
				L.electrocute_act(2, src, 2, SHOCK_NOSTUN)
				L.Paralyze(10)
			else
				L.electrocute_act(1, src, 1, SHOCK_NOSTUN)
				L.Paralyze(10)
	qdel(src)

/obj/effect/proc_holder/spell/invoked/projectile/bloodlightning
	name = "Blood Bolt"
	desc = ""
	clothes_req = FALSE
	overlay_state = "bloodlightning"
	sound = 'sound/magic/vlightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/bloodlightning
	releasedrain = 30
	chargedrain = 1
	chargetime = 25
	charge_max = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood

/obj/projectile/magic/bloodlightning
	name = "blood bolt"
	tracer_type = /obj/effect/projectile/tracer/blood
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	damage = 35
	damage_type = BURN
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#802121"
	light_outer_range = 7

/obj/projectile/magic/bloodlightning/on_hit(target)
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
			L.electrocute_act(3, src)
	qdel(src)

/obj/effect/proc_holder/spell/invoked/projectile/bloodsteal
	name = "Blood Steal"
	desc = ""
	clothes_req = FALSE
	overlay_state = "bloodsteal"
	sound = 'sound/magic/vlightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/bloodsteal
	releasedrain = 30
	chargedrain = 1
	chargetime = 25
	charge_max = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood

/obj/projectile/magic/bloodsteal
	name = "blood steal"
	tracer_type = /obj/effect/projectile/tracer/bloodsteal
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	damage = 25
	damage_type = BRUTE
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#e74141"
	light_outer_range = 7

/obj/projectile/magic/bloodsteal/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			var/datum/antagonist/vampirelord/VDrinker = sender.mind.has_antag_datum(/datum/antagonist/vampirelord)
			H.blood_volume = max(H.blood_volume-45, 0)
			H.handle_blood()
			H.visible_message(span_danger("[target] has their blood ripped from their body!!"), \
					span_userdanger("My blood erupts from my body!"), \
					span_hear("..."), COMBAT_MESSAGE_RANGE, target)
			new /obj/effect/decal/cleanable/blood/puddle(H.loc)
			VDrinker.handle_vitae(400)
	qdel(src)

/obj/effect/proc_holder/spell/invoked/projectile/fireball
	name = "Fireball"
	desc = "Shoot out a ball of fire that emits a light explosion on impact, setting the target alight."
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue
	overlay_state = "fireball"
	sound = list('sound/magic/fireball.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	charge_max = 10 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokefire
	associated_skill = /datum/skill/magic/arcane
	cost = 2
	xp_gain = TRUE

/obj/projectile/magic/aoe/fireball/rogue
	name = "fireball"
	exp_heavy = 0
	exp_light = 0
	exp_flash = 0
	exp_fire = 1
	damage = 10
	damage_type = BURN
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/blank.ogg'
	aoe_range = 0


/obj/projectile/magic/aoe/fireball/rogue/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK



/obj/effect/proc_holder/spell/invoked/projectile/fireball/greater
	name = "Greater Fireball"
	desc = "Shoot out an immense ball of fire that explodes on impact."
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue/great
	overlay_state = "fireball_wide"
	sound = list('sound/magic/fireball.ogg')
	active = FALSE
	releasedrain = 50
	chargedrain = 1
	chargetime = 15
	charge_max = 10 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokefire
	cost = 5
	xp_gain = TRUE

/obj/projectile/magic/aoe/fireball/rogue/great
	name = "fireball"
	exp_heavy = 0
	exp_light = 1
	exp_flash = 2
	exp_fire = 2
	flag = "magic"

/obj/effect/proc_holder/spell/invoked/projectile/spitfire
	name = "Spitfire"
	desc = "Shoot out a low-powered ball of fire that shines brightly on impact, potentially blinding a target."
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue2
	overlay_state = "fireball_multi"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 1
	charge_max = 4 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokefire
	associated_skill = /datum/skill/magic/arcane
	cost = 1
	xp_gain = TRUE

/obj/projectile/magic/aoe/fireball/rogue2
	name = "fireball"
	exp_heavy = 0
	exp_light = 0
	exp_flash = 1
	exp_fire = 0
	damage = 20
	damage_type = BURN
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/blank.ogg'
	aoe_range = 0

/obj/effect/proc_holder/spell/invoked/projectile/fetch
	name = "Fetch"
	desc = "Shoot out a magical bolt that draws in the target struck towards the caster."
	clothes_req = FALSE
	range = 15
	projectile_type = /obj/projectile/magic/fetch
	overlay_state = ""
	sound = list('sound/magic/magnet.ogg')
	active = FALSE
	releasedrain = 5
	chargedrain = 0
	chargetime = 0
	warnie = "spellwarning"
	overlay_state = "fetch"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 1
	xp_gain = TRUE

/obj/projectile/magic/fetch/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[target] repells the fetch!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
