// Diagnose
/obj/effect/proc_holder/spell/invoked/diagnose
	name = "Diagnose"
	desc = "Examine anothers vitals."
	overlay_icon = 'icons/mob/actions/pestraspells.dmi'
	action_icon = 'icons/mob/actions/pestraspells.dmi'
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
	recharge_time = 5 SECONDS //very stupidly simple spell
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
	desc = "Attach all limbs and organs you or your target is holding, and near your target."
	overlay_icon = 'icons/mob/actions/pestraspells.dmi'
	action_icon = 'icons/mob/actions/pestraspells.dmi'
	overlay_state = "flextape"
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
	recharge_time = 60 SECONDS //attaching a limb is pretty intense
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
		var/same_owner = FALSE
		if(human_target.has_status_effect(/datum/status_effect/buff/necras_vow))
			same_owner = TRUE
			to_chat(user, span_warning("This one has pledged a vow to Necra. Only their own limbs will be accepted."))
		for(var/obj/item/bodypart/limb as anything in get_limbs(human_target, user))
			if(!human_target.get_bodypart(limb.body_zone) && same_owner)
				if(limb.original_owner != human_target)
					continue
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

/obj/effect/proc_holder/spell/invoked/infestation
	name = "Infestation"
	desc = "Causes a swarm of bugs to surround your target, bites them and causes sickness. Infecting targets gives you charges to use other spells."
	overlay_icon = 'icons/mob/actions/pestraspells.dmi'
	action_icon = 'icons/mob/actions/pestraspells.dmi'
	overlay_state = "infestation0"
	releasedrain = 50
	chargetime = 10
	recharge_time = 20 SECONDS
	range = 8
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	devotion_cost = 50 // attack miracle
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/fliesloop
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	miracle = TRUE

	invocations = list("Rot, take them!")
	invocation_type = "shout" //can be none, whisper, emote and shout
	var/datum/component/infestation_charges/charge_component

/obj/effect/proc_holder/spell/invoked/infestation/on_gain(mob/living/user)
	// Note: there is no logic to remove the component yet, this should be fine
	. = ..()
	if(overlay_state && !hide_charge_effect)
		var/obj/effect/R = new /obj/effect/spell_rune
		R.icon = action_icon
		R.icon_state = "infestation10"
		action.overlay_alpha = overlay_alpha
		mob_charge_effect = R
	if(user && !charge_component)
		// Sanity check
		var/datum/component/existing_component = user.GetComponent(/datum/component/infestation_charges)
		if(existing_component)
			charge_component = existing_component
			charge_component.parent_spell = src
		else
			charge_component = user.AddComponent(/datum/component/infestation_charges, src)

/obj/effect/proc_holder/spell/invoked/infestation/proc/update_charge_overlay(charge_count)
	overlay_state = "infestation[charge_count]"
	update_icon()
	action.UpdateButtonIcon(FALSE, TRUE)
	action.desc = "[desc]\n<span class='notice'>Charges = [charge_count]</span>"

/obj/effect/proc_holder/spell/invoked/infestation/cast(list/targets, mob/living/user)
	var/atom/target = targets[1]
	if(isliving(target))
		var/mob/living/carbon/M = target
		M.visible_message(span_warning("[M] is surrounded by a cloud of pestilent vermin!"), span_notice("You surround [M] in a cloud of pestilent vermin!"))
		M.apply_status_effect(/datum/status_effect/buff/infestation/) //apply debuff
		SEND_SIGNAL(src, COMSIG_INFESTATION_CHARGE_ADD, 10)
		return TRUE
	if(SSchimeric_tech.get_node_status("INFESTATION_ROT_SNACKS") && istype(target, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/snack = target
		var/total_charge = 5
		var/rotted_count = 1
		var/search_count = SSchimeric_tech.get_infestation_food_rot_count()
		snack.become_rotten()

		// Check for additional food items if tech nodes are unlocked
		if(search_count)
			for(var/obj/item/reagent_containers/food/snacks/extra_snack in range(1, snack))
				// I hate checking for rotten food this way but it's how it's done so let's be consistent?
				if(extra_snack.eat_effect == /datum/status_effect/debuff/rotfood)
					continue
				if(rotted_count >= search_count)
					break
				extra_snack.become_rotten()
				total_charge += 5
				rotted_count++
		if(rotted_count <= 1)
			snack.visible_message(span_warning("[snack] is swarmed by vermin and rapidly rots!"))
		else
			snack.visible_message(span_warning("some food is swarmed by vermin and rapidly rots!"))
		SEND_SIGNAL(src, COMSIG_INFESTATION_CHARGE_ADD, total_charge)
		return TRUE
	revert_cast()
	return FALSE

/datum/status_effect/buff/infestation
	id = "infestation"
	alert_type = /atom/movable/screen/alert/status_effect/buff/infestation
	duration = 10 SECONDS
	effectedstats = list(STATKEY_CON = -2)
	var/static/mutable_appearance/rotten = mutable_appearance('icons/roguetown/mob/rotten.dmi', "rotten")

/datum/status_effect/buff/infestation/on_apply()
	. = ..()
	var/mob/living/target = owner
	to_chat(owner, span_danger("I am suddenly surrounded by a cloud of bugs!"))
	target.Jitter(20)
	target.add_overlay(rotten)
	target.update_vision_cone()

/datum/status_effect/buff/infestation/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(rotten)
	target.update_vision_cone()
	. = ..()

/datum/status_effect/buff/infestation/tick()
	var/mob/living/target = owner
	var/mob/living/carbon/M = target
	target.adjustToxLoss(2)
	target.adjustBruteLoss(1)
	var/prompt = pick(1,2,3)
	var/message = pick(
		"Ticks on my skin start to engorge with blood!",
		"Flies are laying eggs in my open wounds!",
		"Something crawled in my ear!",
		"There are too many bugs to count!",
		"They're trying to get under my skin!",
		"Make it stop!",
		"Millipede legs tickle the back of my ear!",
		"Fire ants bite at my feet!",
		"A wasp sting right on the nose!",
		"Cockroaches scurry across my neck!",
		"Maggots slimily wriggle along my body!",
		"Beetles crawl over my mouth!",
		"Fleas bite my ankles!",
		"Gnats buzz around my face!",
		"Lice suck my blood!",
		"Crickets chirp in my ears!",
		"Earwigs crawl into my ears!")
	if(prompt == 1 && iscarbon(M))
		M.add_nausea(pick(10,20))
		to_chat(target, span_warning(message))

/atom/movable/screen/alert/status_effect/buff/infestation
	name = "Infestation"
	desc = "Pestilent vermin bite and chew at my skin."
	icon_state = "debuff"

// Cure rot
/obj/effect/proc_holder/spell/invoked/cure_rot
	name = "Cure Rot"
	desc = "Invoke Pestras will though a Psycross to cast out rot from people or regrow their flesh."
	overlay_icon = 'icons/mob/actions/pestraspells.dmi'
	action_icon = 'icons/mob/actions/pestraspells.dmi'
	overlay_state = "rot"
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
	devotion_cost = 30
	/// Amount of PQ gained for curing zombos
	var/unzombification_pq = PQ_GAIN_UNZOMBIFY
	var/is_lethal = TRUE

/obj/effect/proc_holder/spell/invoked/cure_rot/priest
	desc = "Burn out the rot by Astratas will."
	is_lethal = FALSE

/obj/effect/proc_holder/spell/invoked/cure_rot/cast(list/targets, mob/living/user)
	var/stinky = FALSE
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE

		if(GLOB.tod == "night")
			to_chat(user, span_warning("Let there be light."))
		for(var/obj/structure/fluff/psycross/S in oview(5, user))
			S.AOE_flash(user, range = 8)

		var/datum/antagonist/zombie/was_zombie = target.mind?.has_antag_datum(/datum/antagonist/zombie)
		if(target.stat == DEAD || was_zombie)	//Checks if the target is a dead rotted corpse.
			var/datum/component/rot/rot = target.GetComponent(/datum/component/rot)
			if(rot && rot.amount && rot.amount >= 5 MINUTES)	//Fail-safe to make sure the dead person has at least rotted for ~5 min.
				stinky = TRUE

		if(remove_rot(target = target, user = user, method = "prayer",
			success_message = "The rot leaves [target]'s body!",
			fail_message = "Nothing happens.", lethal = is_lethal))
			target.visible_message(span_notice("The rot leaves [target]'s body!"), span_green("I feel the rot leave my body!"))
			target.remove_status_effect(/datum/status_effect/debuff/rotted_zombie)	//Removes the rotted-zombie debuff if they have it.
			if(stinky)
				target.apply_status_effect(/datum/status_effect/debuff/rotted)	//Perma debuff, needs cure
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

/obj/effect/proc_holder/spell/invoked/pestra_leech
	name = "Leeching Purge"
	desc = "Manifest leeches inside of target, causing them to puke them out while restoring some blood and curing minor poisoning."
	overlay_icon = 'icons/mob/actions/pestraspells.dmi'
	action_icon = 'icons/mob/actions/pestraspells.dmi'
	overlay_state = "leech"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	range = 4
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/gore/flesh_eat_03.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 60 SECONDS
	miracle = TRUE
	devotion_cost = 30

/obj/effect/proc_holder/spell/invoked/pestra_leech/cast(list/targets, mob/living/user)
	if(iscarbon(targets[1]))
		var/mob/living/carbon/C = targets[1]
		if(C.cmode)
			to_chat(user, span_warning("They're too tense for the delicate arts!"))
			revert_cast()
			return FALSE
		C.vomit()
		C.adjustToxLoss(-30)
		if(C.blood_volume < BLOOD_VOLUME_NORMAL)
			C.blood_volume = min(C.blood_volume+30, BLOOD_VOLUME_NORMAL)
		C.visible_message(span_warning("[C] expels some leeches out of them!"), span_warning("Something roils within me!"))
		new /obj/item/natural/worms/leech(get_turf(C))
		if(prob( (user.get_skill_level(/datum/skill/magic/holy) * 10) ))
			new /obj/item/natural/worms/leech(get_turf(C))
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/pestra_heal
	name = "Rebirth"
	desc = "A greater heal, more effective on targets affected by some form of greater rot. Requires infestation charges to cast."
	overlay_icon = 'icons/mob/actions/pestraspells.dmi'
	action_icon = 'icons/mob/actions/pestraspells.dmi'
	overlay_state = "heal"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0.6 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/heal.ogg'
	invocations = list("Pestra! Let them be reborn!")
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 10 SECONDS
	miracle = TRUE
	// Greater heal, but requires a resource to cast.
	devotion_cost = 45
	var/datum/component/infestation_charges/charge_component

/obj/effect/proc_holder/spell/invoked/pestra_heal/cast_check(skipcharge = 0, mob/user = usr)
	if(!..())
		return FALSE
	if(!charge_component)
		charge_component = user.GetComponent(/datum/component/infestation_charges)
	// Check again just in case the component got deleted somehow!
	if(!charge_component || charge_component.get_charges() < 1)
		to_chat(user, span_warning("I need at least one infestation charge to cast this spell!"))
		update_charges(0)
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/invoked/pestra_heal/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/charge_count
		if(!charge_component)
			to_chat(user, span_warning("Oopsie woopsie, seems the infestation gear somehow got lost... Make a bug report!"))
			revert_cast()
			return FALSE
		charge_count = charge_component.get_charges()
		if(charge_count < 1)
			to_chat(user, span_warning("I need at least one infestation charge to cast this spell!"))
			update_charges(charge_count)
			revert_cast()
			return FALSE
		var/mob/living/target = targets[1]
		if(HAS_TRAIT(target, TRAIT_PSYDONITE))
			target.visible_message(span_info("[target] stirs for a moment, the miracle dissipates."), span_notice("A dull warmth swells in your heart, only to fade as quickly as it arrived."))
			playsound(target, 'sound/magic/PSY.ogg', 100, FALSE, -1)
			user.playsound_local(user, 'sound/magic/PSY.ogg', 100, FALSE, -1)
			return FALSE
		// Keep in mind this is 7.5 per tick with fortify!
		// Double the power of miracle
		var/healing = 5
		target.visible_message(span_info("Skittering ghostly bugs envelop [target]!"), span_notice("Ethereal bugs knit my flesh back together with their mandibles!"))
		target.apply_status_effect(/datum/status_effect/buff/healing, healing)
		// 225 healing but slowly released across 10 minutes, can't be refreshed.
		target.apply_status_effect(/datum/status_effect/buff/pestra_care)
		remove_infestation_charges(user, 10)
		// We just reduced it by 1 so we can assume that we might not have enough charges to cast again.
		update_charges(charge_count - 1)
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/pestra_heal/proc/update_charges(charge_count)
	if(charge_count > 0)
		overlay_state = "heal"
	else
		overlay_state = "heal_disabled"
	update_icon()
	if(action)
		action.UpdateButtonIcon(FALSE, TRUE)

/obj/effect/proc_holder/spell/invoked/divine_rebirth
	name = "Divine Rebirth"
	desc = "A miraculous heal that can restore even the most grievous wounds, including missing limbs. But it requires being at maximum infestation capacity. No force can resist this miracle."
	overlay_icon = 'icons/mob/actions/pestraspells.dmi'
	action_icon = 'icons/mob/actions/pestraspells.dmi'
	overlay_state = "heal_ascended"
	releasedrain = 50
	chargedrain = 0
	chargetime = 2 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/ahh2.ogg'
	invocations = list("O SWARM MOTHER, CONSUME AND CLEANSE!!!")
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	// Doesn't matter in the slightest, as the cooldown of this is handled by the component, not the spell.
	recharge_time = 999 MINUTES
	miracle = TRUE
	devotion_cost = 250
	chargedloop = /datum/looping_sound/invokeholy

// Given this is Pestra's true T4 spell, and it is limited in availability and gated heavily behind tech, this heal does affect Psydonites.
// You can't resist Pestra's most divine gift.
/obj/effect/proc_holder/spell/invoked/divine_rebirth/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		target.visible_message(span_info("An ethereal, mushroom infested arm carresses [target]!"), span_notice("I feel a caring touch!"))
		target.apply_status_effect(/datum/status_effect/buff/divine_rebirth_healing)
		SEND_SIGNAL(user, COMSIG_DIVINE_REBIRTH_CAST, target)
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/pestilent_blade
	name = "Pestilent Blade"
	desc = "Enchant your blade with Pestra's power, consuming one infestation charge to make your next strike against an infested target more potent. Negligible effect if the target isn't infested..."
	overlay_icon = 'icons/mob/actions/pestraspells.dmi'
	action_icon = 'icons/mob/actions/pestraspells.dmi'
	overlay_state = "blade"
	releasedrain = 20
	chargedrain = 0
	chargetime = 1 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	range = 1 // Self-target
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/slimesquish.ogg'
	invocations = list("Pestra, bless this blade!")
	invocation_type = "whisper"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 30 SECONDS
	miracle = TRUE
	devotion_cost = 25
	var/datum/component/infestation_charges/charge_component

/obj/effect/proc_holder/spell/invoked/pestilent_blade/cast_check(skipcharge = 0, mob/user = usr)
	if(!..())
		return FALSE

	if(!charge_component)
		charge_component = user.GetComponent(/datum/component/infestation_charges)

	if(!charge_component || charge_component.get_charges() < 1)
		to_chat(user, span_warning("I need at least one infestation charge to enchant my blade!"))
		return FALSE

	var/obj/item/held_item = user.get_active_held_item()
	if(!held_item || !isitem(held_item))
		to_chat(user, span_warning("I need to be holding a weapon to enchant it!"))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/invoked/pestilent_blade/cast(list/targets, mob/living/user)
	var/obj/item/weapon = user.get_active_held_item()
	if(!weapon || !isitem(weapon))
		to_chat(user, span_warning("I must hold a weapon to enchant it!"))
		revert_cast()
		return FALSE

	if(!charge_component || charge_component.get_charges() < 1)
		to_chat(user, span_warning("The infestation charges have been depleted!"))
		revert_cast()
		return FALSE

	if(weapon.AddComponent(/datum/component/pestilent_blade_enchant))
		remove_infestation_charges(user, 10)
		to_chat(user, span_infection("I feel pestilence flow into my [weapon.name]!"))
		weapon.visible_message(span_infection("[weapon] glows with a sickly green light!"))
		return TRUE

	revert_cast()
	return FALSE
