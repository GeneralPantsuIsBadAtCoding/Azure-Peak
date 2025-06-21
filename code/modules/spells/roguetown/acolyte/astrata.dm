/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt/sacred_flame_rogue
	name = "Sacred Flame"
	overlay_state = "sacredflame"
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	invocation = null
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 25 SECONDS
	miracle = TRUE
	devotion_cost = 100
	projectile_type = /obj/projectile/magic/lightning/astratablast

/obj/projectile/magic/lightning/astratablast
	damage = 10 
	name = "ray of holy fire"
	damage_type = BURN
	flag = "magic"
	light_color = "#a98107"
	light_outer_range = 7
	tracer_type = /obj/effect/projectile/tracer/solar_beam
	var/fuck_that_guy_multiplier = 2.5
	var/biotype_we_look_for = MOB_UNDEAD

/obj/projectile/magic/lightning/astratablast/on_hit(target)
	. = ..()

	if(ismob(target))
		var/mob/living/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(M.mob_biotypes & biotype_we_look_for || istype(M, /mob/living/simple_animal/hostile/rogue/skeleton))
			damage *= fuck_that_guy_multiplier
			M.adjust_fire_stacks(4)
			M.IgniteMob()
			visible_message(span_warning("[src] ignites [target] in holy flame!"))
	return FALSE

/obj/effect/proc_holder/spell/invoked/ignition
	name = "Ignition"
	desc = "Ignite a flammable object at range."
	overlay_state = "sacredflame"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	sound = 'sound/magic/heal.ogg'
	invocation = null
	invocation_type = null
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 5 SECONDS
	miracle = TRUE
	devotion_cost = 10

/obj/effect/proc_holder/spell/invoked/sacred_flame_rogue/cast(list/targets, mob/user = usr)
	. = ..()
	// Spell interaction with ignitable objects (burn wooden things, light torches up)
	if(isobj(targets[1]))
		var/obj/O = targets[1]
		if(O.fire_act())
			user.visible_message("<font color='yellow'>[user] points at [O], igniting it with sacred flames!</font>")
			return TRUE
		else
			to_chat(user, span_warning("You point at [O], but it fails to catch fire."))
			return FALSE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/revive
	name = "Anastasis"
	overlay_state = "revive"
	releasedrain = 90
	chargedrain = 0
	chargetime = 50
	range = 1
	warnie = "sydwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/revive.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 2 MINUTES
	miracle = TRUE
	devotion_cost = 80
	/// Amount of PQ gained for reviving people
	var/revive_pq = PQ_GAIN_REVIVE

/obj/effect/proc_holder/spell/invoked/revive/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		testing("revived1")
		var/mob/living/target = targets[1]
		if(!target.mind)
			revert_cast()
			return FALSE
		if(HAS_TRAIT(target, TRAIT_NECRAS_VOW))
			to_chat(user, "This one has pledged themselves whole to Necra. They are Hers.")
			revert_cast()
			return FALSE
		if(!target.mind.active)
			to_chat(user, "Astrata is not done with [target], yet.")
			revert_cast()
			return FALSE
		if(target == user)
			revert_cast()
			return FALSE
		if(target.stat < DEAD)
			to_chat(user, span_warning("Nothing happens."))
			revert_cast()
			return FALSE
		if(GLOB.tod == "night")
			to_chat(user, span_warning("Let there be light."))
		for(var/obj/structure/fluff/psycross/S in oview(5, user))
			S.AOE_flash(user, range = 8)
		if(target.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			target.visible_message(span_danger("[target] is unmade by holy light!"), span_userdanger("I'm unmade by holy light!"))
			target.gib()
			return TRUE
		if(alert(target, "They are calling for you. Are you ready?", "Revival", "I need to wake up", "Don't let me go") != "I need to wake up")
			target.visible_message(span_notice("Nothing happens. They are not being let go."))
			return FALSE
		target.adjustOxyLoss(-target.getOxyLoss()) //Ye Olde CPR
		if(!target.revive(full_heal = FALSE))
			to_chat(user, span_warning("Nothing happens."))
			revert_cast()
			return FALSE
		testing("revived2")
		var/mob/living/carbon/spirit/underworld_spirit = target.get_spirit()
		//GET OVER HERE!
		if(underworld_spirit)
			var/mob/dead/observer/ghost = underworld_spirit.ghostize()
			qdel(underworld_spirit)
			ghost.mind.transfer_to(target, TRUE)
		target.grab_ghost(force = TRUE) // even suicides
		target.emote("breathgasp")
		target.Jitter(100)
		GLOB.azure_round_stats[STATS_ASTRATA_REVIVALS]++
		target.update_body()
		target.visible_message(span_notice("[target] is revived by holy light!"), span_green("I awake from the void."))
		if(revive_pq && !HAS_TRAIT(target, TRAIT_IWASREVIVED) && user?.ckey)
			adjust_playerquality(revive_pq, user.ckey)
			ADD_TRAIT(target, TRAIT_IWASREVIVED, "[type]")
		target.mind.remove_antag_datum(/datum/antagonist/zombie)
		target.remove_status_effect(/datum/status_effect/debuff/rotted_zombie)	//Removes the rotted-zombie debuff if they have it - Failsafe for it.
		target.apply_status_effect(/datum/status_effect/debuff/revived)	//Temp debuff on revive, your stats get hit temporarily. Doubly so if having rotted.
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/revive/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		return FALSE
	var/found = null
	for(var/obj/structure/fluff/psycross/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need a holy cross."))
		return FALSE
	return TRUE

//T0. Removes cone vision for a dynamic duration.
/obj/effect/proc_holder/spell/self/astrata_gaze
	name = "Astratan Gaze"
	overlay_state = "astrata_gaze"
	releasedrain = 10
	chargedrain = 0
	chargetime = 0
	chargedloop = /datum/looping_sound/invokeholy
	sound = 'sound/magic/astrata_choir.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	invocation = "Astrata show me true."
	invocation_type = "shout"
	recharge_time = 120 SECONDS
	devotion_cost = 30
	miracle = TRUE

/obj/effect/proc_holder/spell/self/astrata_gaze/cast(list/targets, mob/user)
	if(!ishuman(user))
		revert_cast()
		return FALSE
	var/mob/living/carbon/human/H = user
	H.apply_status_effect(/datum/status_effect/buff/astrata_gaze, user.mind?.get_skill_level(associated_skill))
	return TRUE

/atom/movable/screen/alert/status_effect/buff/astrata_gaze
	name = "Astratan's Gaze"
	desc = "She shines through me, illuminating all injustice."
	icon_state = "astrata_gaze"

/datum/status_effect/buff/astrata_gaze
	id = "astratagaze"
	alert_type = /atom/movable/screen/alert/status_effect/buff/astrata_gaze
	duration = 20 SECONDS

/datum/status_effect/buff/astrata_gaze/on_apply(assocskill)
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.viewcone_override = TRUE
		H.hide_cone()
		H.update_cone_show()
	var/per_bonus = 0
	if(assocskill)
		if(assocskill > SKILL_LEVEL_NOVICE)
			per_bonus++
		duration *= assocskill
	if(GLOB.tod == "day" || GLOB.tod == "dawn")
		per_bonus++
		duration *= 2
	if(per_bonus > 0)
		effectedstats = list("perception" = per_bonus)
	to_chat(owner, span_info("She shines through me! I can perceive all clear as dae!"))
	. = ..()

/datum/status_effect/buff/astrata_gaze/on_remove()
	. = ..()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.viewcone_override = FALSE
		H.hide_cone()
		H.update_cone_show()
