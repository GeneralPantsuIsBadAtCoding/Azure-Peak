// Diagnose
/obj/effect/proc_holder/spell/invoked/diagnose
	name = "Diagnose"
	overlay_state = "diagnose"
	releasedrain = 10
	chargedrain = 0
	chargetime = 0
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/diagnose.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 5 SECONDS //very stupidly simple spell
	miracle = TRUE
	devotion_cost = 0 //come on, this is very basic

/obj/effect/proc_holder/spell/invoked/diagnose/cast(list/targets, mob/living/user)
	if(ishuman(targets[1]))
		var/mob/living/carbon/human/human_target = targets[1]
		human_target.check_for_injuries(user)

		if (human_target.reagents.has_reagent(/datum/reagent/infection/major))
			to_chat(user, span_boldwarning("Streaks of black and yellow doubtlessly indicate an excess of melancholic humour."))
		else if (human_target.reagents.has_reagent(/datum/reagent/infection))
			to_chat(user, span_warning("Reddened and inflamed flesh accompanied by a brow flecked with sweat. Excess choleric, perhaps?"))
		else if (human_target.reagents.has_reagent(/datum/reagent/infection/minor))
			to_chat(user, span_warning("A slight yellowing indicates the barest presence of disrupted choleric humor."))

		//To tell thresholds of toxins in the system, here so people don't have info of their own toxins outside of diagnosis method
		switch(human_target.toxloss)
			if(0 to 1)
				to_chat(user, span_notice("No sign of toxicity in the body."))
			if(1 to 50)
				to_chat(user, span_notice("Some traces of toxicity are found under scrutiny."))
			if(50 to 100)
				to_chat(user, span_notice("Significant signs of toxicity are apparent."))
			if(100 to 150)
				to_chat(user, span_warning("The body is wracked by toxicity."))
			if(150 to INFINITY)
				to_chat(user, span_necrosis("The body is devastated by toxicity."))
		
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/diagnose/secular
	name = "Secular Diagnosis"
	overlay_state = "diagnose"
	range = 1
	associated_skill = /datum/skill/misc/medicine
	miracle = FALSE
	devotion_cost = 0 //Doctors are not clerics

// Limb or organ attachment
/obj/effect/proc_holder/spell/invoked/attach_bodypart
	name = "Bodypart Miracle"
	overlay_state = "limb_attach"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/gore/flesh_eat_03.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 60 SECONDS //attaching a limb is pretty intense
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/invoked/attach_bodypart/proc/get_organs(mob/living/target, mob/living/user)
	var/list/missing_organs = list(
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_TONGUE,
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
		ORGAN_SLOT_APPENDIX,
	)
	for(var/missing_organ_slot in missing_organs)
		if(!target.getorganslot(missing_organ_slot))
			continue
		missing_organs -= missing_organ_slot
	if(!length(missing_organs))
		return
	var/list/organs = list()
	//try to get from user's hands first
	for(var/obj/item/organ/potential_organ in user?.held_items)
		if(potential_organ.owner || !(potential_organ.slot in missing_organs))
			continue
		organs += potential_organ
	//then target's hands
	for(var/obj/item/organ/dismembered in target.held_items)
		if(dismembered.owner || !(dismembered.slot in missing_organs))
			continue
		organs += dismembered
	//then finally, 1 tile range around target
	for(var/obj/item/organ/dismembered in range(1, target))
		if(dismembered.owner || !(dismembered.slot in missing_organs))
			continue
		organs += dismembered
	return organs

/obj/effect/proc_holder/spell/invoked/attach_bodypart/proc/get_limbs(mob/living/target, mob/living/user)
	var/list/missing_limbs = target.get_missing_limbs()
	if(!length(missing_limbs))
		return
	var/list/limbs = list()
	//try to get from user's hands first
	for(var/obj/item/bodypart/potential_limb in user?.held_items)
		if(potential_limb.owner || !(potential_limb.body_zone in missing_limbs))
			continue
		limbs += potential_limb
	//then target's hands
	for(var/obj/item/bodypart/dismembered in target.held_items)
		if(dismembered.owner || !(dismembered.body_zone in missing_limbs))
			continue
		limbs += dismembered
	//then finally, 1 tile range around target
	for(var/obj/item/bodypart/dismembered in range(1, target))
		if(dismembered.owner || !(dismembered.body_zone in missing_limbs))
			continue
		limbs += dismembered
	return limbs

// consider adding functionality to regrow one entire organ or limb per casting?
/obj/effect/proc_holder/spell/invoked/attach_bodypart/cast(list/targets, mob/living/user)
	if(ishuman(targets[1]))
		var/mob/living/carbon/human/human_target = targets[1]
		for(var/obj/item/bodypart/limb as anything in get_limbs(human_target, user))
			if(human_target.get_bodypart(limb.body_zone) || !limb.attach_limb(human_target))
				continue
			human_target.visible_message(span_info("\The [limb] attaches itself to [human_target]!"), \
								span_notice("\The [limb] attaches itself to me!"))
		for(var/obj/item/organ/organ as anything in get_organs(human_target, user))
			if(human_target.getorganslot(organ.slot) || !organ.Insert(human_target))
				continue
			human_target.visible_message(span_info("\The [organ] attaches itself to [human_target]!"), \
								span_notice("\The [organ] attaches itself to me!"))
		if(!(human_target.mob_biotypes & MOB_UNDEAD))
			for(var/obj/item/bodypart/limb as anything in human_target.bodyparts)
				limb.rotted = FALSE
				limb.skeletonized = FALSE
		human_target.update_body()
		return TRUE
	revert_cast()
	return FALSE

// Cure rot
/obj/effect/proc_holder/spell/invoked/cure_rot
	name = "Cure Rot"
	overlay_state = "cure_rot"
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
	charge_max = 2 MINUTES
	miracle = TRUE
	devotion_cost = 30
	/// Amount of PQ gained for curing zombos
	var/unzombification_pq = PQ_GAIN_UNZOMBIFY

/obj/effect/proc_holder/spell/invoked/cure_rot/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE

		if(GLOB.tod == "night")
			to_chat(user, span_warning("Let there be light."))
		for(var/obj/structure/fluff/psycross/S in oview(5, user))
			S.AOE_flash(user, range = 8)

		if(remove_rot(target = target, user = user, method = "prayer",
			success_message = "The rot leaves [target]'s body!",
			fail_message = "Nothing happens."))
			target.visible_message(span_notice("The rot leaves [target]'s body!"), span_green("I feel the rot leave my body!"))
			return TRUE
		else //Attempt failed, no rot
			target.visible_message(span_warning("The rot fails to leave [target]'s body!"), span_warning("I feel no different..."))
			return FALSE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/cure_rot/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		return FALSE
	var/found = null
	for(var/obj/structure/fluff/psycross/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need a holy cross."))
		return FALSE
	return TRUE
