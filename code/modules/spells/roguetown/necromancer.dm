/obj/effect/proc_holder/spell/invoked/bonechill
	name = "Bone Chill"
	overlay_state = "raiseskele"
	releasedrain = 30
	chargetime = 5
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	charge_max = 15 SECONDS
	miracle = FALSE

/obj/effect/proc_holder/spell/invoked/bonechill/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(user.zone_selected))
			if(affecting)
				if(affecting.heal_damage(50, 50))
					target.update_damage_overlays()
				if(affecting.heal_wounds(50))
					target.update_damage_overlays()
			target.visible_message(span_danger("[target] reforms under the vile energy!"), span_notice("I'm remade by dark magic!"))
			return TRUE
		target.visible_message(span_info("Necrotic energy floods over [target]!"), span_userdanger("I feel colder as the dark energy floods into me!"))
		if(iscarbon(target))
			target.apply_status_effect(/datum/status_effect/debuff/chilled)
		else
			target.adjustBruteLoss(20)
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/eyebite
	name = "Eyebite"
	overlay_state = "raiseskele"
	releasedrain = 30
	chargetime = 15
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	sound = 'sound/items/beartrap.ogg'
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	charge_max = 15 SECONDS
	miracle = FALSE

/obj/effect/proc_holder/spell/invoked/eyebite/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.visible_message(span_info("A loud crunching sound has come from [target]!"), span_userdanger("I feel arcane teeth biting into my eyes!"))
		target.adjustBruteLoss(30)
		target.blind_eyes(2)
		target.blur_eyes(10)
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/raise_undead
	name = "Raise Greater Undead"
	desc = ""
	clothes_req = FALSE
	range = 7
	overlay_state = "animate"
	sound = list('sound/magic/magnet.ogg')
	releasedrain = 40
	chargetime = 60
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	charge_max = 60 SECONDS

/obj/effect/proc_holder/spell/invoked/raise_undead/cast(list/targets, mob/living/user)
	. = ..()
	var/turf/T = get_turf(targets[1])
	if(isopenturf(T))
		var/mob/living/carbon/human/target = new /mob/living/carbon/human/species/skeleton/no_equipment(T)
		var/list/candidates = pollCandidatesForMob("Do you want to play as a Necromancer's skeleton?", ROLE_NECRO_SKELETON, null, null, 100, target, POLL_IGNORE_NECROMANCER_SKELETON)
		if(LAZYLEN(candidates))
			var/mob/C = pick(candidates)
			if(istype(C,/mob/dead/new_player))
				var/mob/dead/new_player/N = C
				N.close_spawn_windows()
			target.key = C.key
			target.visible_message(span_warning("[target]'s eyes light up with an eerie glow!"))
			target.mind.AddSpell(new /obj/effect/proc_holder/spell/self/suicidebomb/lesser)
			target.equipOutfit(/datum/outfit/job/roguetown/greater_skeleton)
		else
			target.visible_message(span_warning("[target]'s form crumbles into dust."))
			qdel(target)
			revert_cast()
		return TRUE
	to_chat(user, span_warning("The targeted location is blocked. My summon fails to come forth."))
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/raise_lesser_undead
	name = "Raise Lesser Undead"
	desc = ""
	clothes_req = FALSE
	overlay_state = "animate"
	range = 7
	sound = list('sound/magic/magnet.ogg')
	releasedrain = 40
	chargetime = 60
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	charge_max = 30 SECONDS
	var/cabal_affine = FALSE

/obj/effect/proc_holder/spell/invoked/raise_lesser_undead/cast(list/targets, mob/living/user)
	. = ..()
	var/turf/T = get_turf(targets[1])
	var/skeleton_roll = rand(1,100)
	if(isopenturf(T))
		switch(skeleton_roll)
			if(1 to 20)
				new /mob/living/simple_animal/hostile/rogue/skeleton/axe(T, user, cabal_affine)
			if(21 to 40)
				new /mob/living/simple_animal/hostile/rogue/skeleton/spear(T, user, cabal_affine)
			if(41 to 60)
				new /mob/living/simple_animal/hostile/rogue/skeleton/guard(T, user, cabal_affine)
			if(61 to 80)
				new /mob/living/simple_animal/hostile/rogue/skeleton/bow(T, user, cabal_affine)
			if(81 to 100)
				new /mob/living/simple_animal/hostile/rogue/skeleton(T, user, cabal_affine)
		return TRUE
	else
		to_chat(user, span_warning("The targeted location is blocked. My summon fails to come forth."))
		return FALSE

/obj/effect/proc_holder/spell/invoked/raise_lesser_undead/necromancer
	cabal_affine = TRUE
	charge_max = 45 SECONDS

/obj/effect/proc_holder/spell/invoked/raise_lesser_undead/necromancer/cast(list/targets, mob/living/user)
	. = ..()
	var/turf/T = get_turf(targets[1])
	var/skeleton_roll = rand(1,100)
	if(isopenturf(T))
		switch(skeleton_roll)
			if(1 to 20)
				new /mob/living/simple_animal/hostile/rogue/skeleton/axe/necromancer(T, user, cabal_affine)
			if(21 to 40)
				new /mob/living/simple_animal/hostile/rogue/skeleton/spear/necromancer(T, user, cabal_affine)
			if(41 to 60)
				new /mob/living/simple_animal/hostile/rogue/skeleton/guard/necromancer(T, user, cabal_affine)
			if(61 to 80)
				new /mob/living/simple_animal/hostile/rogue/skeleton/bow/necromancer(T, user, cabal_affine)
			if(81 to 100)
				new /mob/living/simple_animal/hostile/rogue/skeleton/necromancer(T, user, cabal_affine)
		return TRUE
	else
		to_chat(user, span_warning("The targeted location is blocked. My summon fails to come forth."))
		return FALSE

/obj/effect/proc_holder/spell/invoked/projectile/sickness
	name = "Ray of Sickness"
	desc = ""
	clothes_req = FALSE
	range = 15
	projectile_type = /obj/projectile/magic/sickness
	overlay_state = "raiseskele"
	sound = list('sound/misc/portal_enter.ogg')
	active = FALSE
	releasedrain = 30
	chargetime = 10
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	charge_max = 15 SECONDS

/obj/effect/proc_holder/spell/self/suicidebomb
	name = "Calcic Outburst"
	desc = "Explode in a wonderful blast of osseous shrapnel."
	overlay_state = "tragedy"
	chargedrain = 0
	chargetime = 0
	charge_max = 10 SECONDS
	sound = 'sound/magic/swap.ogg'
	warnie = "spellwarning"
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	stat_allowed = TRUE
	var/exp_heavy = 0
	var/exp_light = 3
	var/exp_flash = 3
	var/exp_fire = 0

/obj/effect/proc_holder/spell/self/suicidebomb/cast(list/targets, mob/living/user = usr)
	. = ..()
	if(!user)
		return
	if(user.stat == DEAD)
		return
	if(alert(user, "Do you wish to sacrifice this vessel in a powerful explosion?", "ELDRITCH BLAST", "Yes", "No") == "No")
		return FALSE
	playsound(get_turf(user), 'sound/magic/antimagic.ogg', 100)
	user.visible_message(span_danger("[user] begins to shake violently, a blindingly bright light beginning to emanate from them!"), span_danger("Powerful energy begins to expand outwards from inside me!"))

	user.Immobilize(50)
	user.Knockdown(50)

	var/turf/T = get_turf(user)
	sleep(5 SECONDS)

	var/datum/antagonist/lich/lichman = user.mind.has_antag_datum(/datum/antagonist/lich)
	if(lichman)
		if(user.stat != DEAD)
			if(!lichman.consume_phylactery(0)) //Use phylactery at 0 timer. Returns false if none left.
				user.death() // If no more phylacteries, die
	else
		user.death()

	explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, soundin = 'sound/misc/explode/incendiary (1).ogg')

	return TRUE

/obj/effect/proc_holder/spell/self/suicidebomb/lesser
	name = "Lesser Calcic Outburst"
	exp_heavy = 0
	exp_light = 2
	exp_flash = 2
	exp_fire = 0
