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
	gesture_required = TRUE // Potential offensive use, need a target
	antimagic_allowed = TRUE
	recharge_time = 15 SECONDS
	miracle = FALSE

/obj/effect/proc_holder/spell/invoked/bonechill/cast(list/targets, mob/living/user)
	..()
	if(!isliving(targets[1]))
		return FALSE

	var/mob/living/target = targets[1]
	if(target.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
		var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(user.zone_selected))
		if(affecting && (affecting.heal_damage(50, 50) || affecting.heal_wounds(50)))
			target.update_damage_overlays()
		target.visible_message(span_danger("[target] reforms under the vile energy!"), span_notice("I'm remade by dark magic!"))
		return TRUE

	target.visible_message(span_info("Necrotic energy floods over [target]!"), span_userdanger("I feel colder as the dark energy floods into me!"))
	if(iscarbon(target))
		target.apply_status_effect(/datum/status_effect/debuff/chilled)
	else
		target.adjustBruteLoss(20)

	return TRUE

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
	gesture_required = TRUE // Offensive spell
	antimagic_allowed = TRUE
	recharge_time = 15 SECONDS
	miracle = FALSE
	hide_charge_effect = TRUE

/obj/effect/proc_holder/spell/invoked/eyebite/cast(list/targets, mob/living/user)
	..()
	if(!isliving(targets[1]))
		return FALSE
	var/mob/living/carbon/target = targets[1]
	target.visible_message(span_info("A loud crunching sound has come from [target]!"), span_userdanger("I feel arcane teeth biting into my eyes!"))
	target.adjustBruteLoss(30)
	target.blind_eyes(2)
	target.blur_eyes(10)
	return TRUE
	

/obj/effect/proc_holder/spell/invoked/raise_lesser_undead
	name = "Raise Lesser Undead"
	desc = "Raises an undead skeleton."
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
	gesture_required = TRUE // Summon spell
	associated_skill = /datum/skill/magic/arcane
	recharge_time = 30 SECONDS
	var/cabal_affine = FALSE
	var/is_summoned = FALSE
	hide_charge_effect = TRUE

/obj/effect/proc_holder/spell/invoked/raise_lesser_undead/cast(list/targets, mob/living/user)
	. = ..()
	var/turf/T = get_turf(targets[1])
	var/skeleton_roll = rand(1,100)
	if(!isopenturf(T))
		to_chat(user, span_warning("The targeted location is blocked. My summon fails to come forth."))
		return FALSE
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

/obj/effect/proc_holder/spell/invoked/raise_lesser_undead/necromancer
	cabal_affine = TRUE
	is_summoned = TRUE
	recharge_time = 45 SECONDS

/obj/effect/proc_holder/spell/invoked/raise_to_skeleton
	name = "Raise to skeleton"
	cost = 6
	desc = "Reanimate a corpse as a skeleton. The body must have all limbs and its head."
	clothes_req = FALSE
	range = 7
	overlay_state = "animate"
	sound = list('sound/magic/magnet.ogg')
	releasedrain = 100
	chargetime = 60
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	invocation = "Hygf'akni'kthakchratah!"
	invocation_type = "shout"
	chargedrain = 2
	recharge_time = 5 MINUTES

/obj/effect/proc_holder/spell/invoked/raise_to_skeleton/cast(list/targets, mob/living/carbon/human/user)
	. = ..()

	if(!("undead" in user.faction))
		user.faction |= "undead"
	var/obj = targets[1]

	if(!obj || !istype(obj, /mob/living/carbon/human))
		to_chat(user, span_warning("I need to cast this spell on a corpse."))
		return FALSE

	// no goblins, drow, bandits, orcs
	if(istype(obj, /mob/living/carbon/human/species/goblin))
		to_chat(user, span_warning("I cannot raise goblins."))
		return FALSE
	else if(istype(obj, /mob/living/carbon/human/species/elf/dark/drowraider))
		to_chat(user, span_warning("I cannot raise this warrior."))
		return FALSE
	else if(istype(obj, /mob/living/carbon/human/species/orc/npc))
		to_chat(user, span_warning("I cannot raise this orc"))
		return FALSE
	else if(istype(obj, /mob/living/carbon/human/species/human/northern/searaider))
		to_chat(user, span_warning("I cannot raise this body, need else"))
		return FALSE
	else if(istype(obj, /mob/living/carbon/human/species/human/northern/thief))
		to_chat(user, span_warning("I cannot raise this body, need else"))
		return FALSE

	var/mob/living/carbon/human/target = obj

	if(target.stat != DEAD)
		to_chat(user, span_warning("I cannot raise the living."))
		return FALSE

	var/obj/item/bodypart/target_head = target.get_bodypart(BODY_ZONE_HEAD)
	var/obj/item/bodypart/target_larm = target.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/target_rarm = target.get_bodypart(BODY_ZONE_R_ARM)
	var/obj/item/bodypart/target_lleg = target.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/target_rleg = target.get_bodypart(BODY_ZONE_R_LEG)
	if(!target_head)
		to_chat(user, span_warning("This corpse is headless."))
		return FALSE
	if(!target_larm)
		to_chat(user, span_warning("This corpse is missing a left arm."))
		return FALSE
	if(!target_rarm)
		to_chat(user, span_warning("This corpse is missing a right arm."))
		return FALSE
	if(!target_lleg)
		to_chat(user, span_warning("This corpse is missing a left leg."))
		return FALSE
	if(!target_rleg)
		to_chat(user, span_warning("This corpse is missing a right leg."))
		return FALSE

	var/offer_refused = FALSE

	if(target.ckey) //player still inside body

		var/offer = alert(target, "Do you wish to be reanimated as a minion?", "RAISED BY NECROMANCER", "Yes", "GetAnotherSoulToMyBody", "No")
		var/offer_time = world.time

		if(offer == "GetAnotherSoulToMyBody" || world.time > offer_time + 5 SECONDS)
			to_chat(target, span_danger("Another soul will take over."))
			offer_refused = TRUE

		if(offer == "Yes")
			to_chat(target, span_danger("You rise as a minion."))
			target.turn_to_minion(user, target.ckey)
			target.visible_message(span_warning("[target.real_name]'s eyes light up with an evil glow."), runechat_message = TRUE)
		else if(offer == "No")
			to_chat(target, span_danger("Soul wanna to be zombie."))
			return TRUE
		
	if(!target.ckey || offer_refused) //player is not inside body or has refused, poll for candidates	
		var/list/candidates = pollGhostCandidates("Do you want to play as a Necromancer's skeleton?", ROLE_NECRO_SKELETON, null, null, 10 SECONDS, POLL_IGNORE_NECROMANCER_SKELETON)
		if(LAZYLEN(candidates))	
			var/mob/C = pick(candidates)
			target.turn_to_minion(user, C.ckey)
			target.visible_message(span_warning("[target.real_name]'s eyes light up with an evil glow."), runechat_message = TRUE)
			if(!C || !istype(C, /mob/dead))
				return FALSE
			if (istype(C, /mob/dead/new_player))
				var/mob/dead/new_player/N = C
				N.close_spawn_windows()
				target.turn_to_minion(user, C.ckey)
				target.visible_message(span_warning("[target.real_name]'s eyes light up with an evil glow."), runechat_message = TRUE)
				return FALSE
	return FALSE

/mob/living/carbon/human/proc/turn_to_minion(mob/living/carbon/human/master, ckey)

	if(!master)
		return FALSE

	src.revive(TRUE, TRUE)

	if(ckey) //player
		src.ckey = ckey
	if(!mind)
		mind_initialize()
	mind.current.job = null

	dna.species.species_traits |= NOBLOOD
	dna.species.soundpack_m = new /datum/voicepack/skeleton()
	dna.species.soundpack_f = new /datum/voicepack/skeleton()


	cmode_music = 'sound/music/combat_cult.ogg'


	patron = master.patron
	mob_biotypes |= MOB_UNDEAD
	faction = list("undead")
	ambushable = FALSE
	underwear = "Nude"

	for(var/obj/item/bodypart/BP in bodyparts)
		BP.skeletonize()

	var/obj/item/organ/eyes/eyes = getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(src,1)
		QDEL_NULL(eyes)

	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(src)

	if(charflaw)
		QDEL_NULL(charflaw)

	can_do_sex = FALSE //where my bonger go

	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC) //Why wasn't this a thing from the start
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_EASYDISMEMBER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LIMBATTACHMENT, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSLEEP, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_INFINITE_STAMINA, TRAIT_GENERIC)
	update_body()

	to_chat(src, span_userdanger("My master is [master.real_name]. I must to obey him as long as he lives and don't let him die"))

/datum/antagonist/skeleton/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/vampirelord))
		var/datum/antagonist/vampirelord/V = examined_datum
		if(!V.disguised)
			return span_boldnotice("Another deadite.")
	if(istype(examined_datum, /datum/antagonist/zombie))
		return span_boldnotice("Another deadite.")
	if(istype(examined_datum, /datum/antagonist/skeleton))
		return span_boldnotice("Another deadite. My ally.")

	return TRUE
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
	recharge_time = 15 SECONDS

/obj/effect/proc_holder/spell/invoked/gravemark
	name = "Gravemark"
	desc = "Adds or removes a target from the list of allies exempt from your undead's aggression."
	overlay_state = "raiseskele"
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	antimagic_allowed = TRUE
	recharge_time = 15 SECONDS
	hide_charge_effect = TRUE

/obj/effect/proc_holder/spell/invoked/gravemark/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		var/faction_tag = "[user.mind.current.real_name]_faction"
		if (target == user)
			to_chat(user, span_warning("It would be unwise to make an enemy of your own skeletons."))
			return FALSE
		if(target.mind && target.mind.current)
			if (faction_tag in target.mind.current.faction)
				target.mind.current.faction -= faction_tag
				user.say("Hostis declaratus es.")
			else
				target.mind.current.faction += faction_tag
				user.say("Amicus declaratus es.")
		else if(istype(target, /mob/living/simple_animal))
			if (faction_tag in target.faction)
				target.faction -= faction_tag
				user.say("Hostis declaratus es.")
			else
				target.faction |= faction_tag
				user.say("Amicus declaratus es.")
		return TRUE
	return FALSE
