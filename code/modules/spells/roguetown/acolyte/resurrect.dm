/obj/effect/proc_holder/spell/invoked/resurrect
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
	recharge_time = 10 MINUTES
	miracle = TRUE
	devotion_cost = 250
	var/revive_pq = PQ_GAIN_REVIVE
	var/required_structure = /obj/structure/fluff/psycross
	var/required_items = list(/obj/item/clothing/neck/roguetown/psicross = 1)
	var/item_radius = 1
	var/debuff_type = /datum/status_effect/debuff/revived
	var/structure_range = 1
	var/harms_undead = TRUE
	priest_excluded = TRUE

/obj/effect/proc_holder/spell/invoked/resurrect/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]

		var/validation_result = validate_items(target)
		if(validation_result != "")
			to_chat(user, span_warning("[validation_result] on the floor next to or on top of [target]"))
			revert_cast()
			return FALSE

		var/found_structure = FALSE
		var/list/search_area = oview(structure_range, target)

		for(var/atom/A in search_area)
			// Check if the atom itself is the required structure type
			if(istype(A, required_structure))
				found_structure = TRUE
				break

			if(istype(A, /turf))
				var/turf/T = A
				for(var/obj/O in T.contents)
					if(istype(O, required_structure))
						found_structure = TRUE
						break // Found it in the turf, no need to check further
			if(found_structure)
				break

		if(!found_structure)
			var/atom/temp_structure = required_structure
			to_chat(user, span_warning("I need a holy [initial(temp_structure.name)] near [target]."))
			revert_cast()
			return FALSE
		if(!target.mind)
			to_chat(user, "This one is inert.")
			revert_cast()
			return FALSE
		if(HAS_TRAIT(target, TRAIT_NECRAS_VOW))
			to_chat(user, "This one has pledged themselves whole to Necra. They are Hers.")
			revert_cast()
			return FALSE
		if(!target.mind.active)
			to_chat(user, "Necra is not done with [target], yet.")
			revert_cast()
			return FALSE
		if(target == user)
			to_chat(user, "By focusing divine energies on myself, I can summise I have every component I need where I'm standing.")
			revert_cast()
			return FALSE
		if(target.stat < DEAD)
			to_chat(user, span_warning("Nothing happens."))
			revert_cast()
			return FALSE
		if(target.mob_biotypes & MOB_UNDEAD && harms_undead) //positive energy harms the undead
			target.visible_message(span_danger("[target] is unmade by divine magic!"), span_userdanger("I'm unmade by divine magic!"))
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
		var/mob/living/carbon/spirit/underworld_spirit = target.get_spirit()
		//GET OVER HERE!
		if(underworld_spirit)
			var/mob/dead/observer/ghost = underworld_spirit.ghostize()
			qdel(underworld_spirit)
			ghost.mind.transfer_to(target, TRUE)
		target.grab_ghost(force = TRUE) // even suicides
		target.emote("breathgasp")
		target.Jitter(100)
		target.update_body()
		target.visible_message(span_notice("[target] is revived by divine magic!"), span_green("I awake from the void."))
		if(revive_pq && !HAS_TRAIT(target, TRAIT_IWASREVIVED) && user?.ckey)
			adjust_playerquality(revive_pq, user.ckey)
			ADD_TRAIT(target, TRAIT_IWASREVIVED, "[type]")
		target.mind.remove_antag_datum(/datum/antagonist/zombie)
		target.remove_status_effect(/datum/status_effect/debuff/rotted_zombie)	//Removes the rotted-zombie debuff if they have it - Failsafe for it.
		target.apply_status_effect(debuff_type)	//Temp debuff on revive, your stats get hit temporarily. Doubly so if having rotted.
		//Due to an increased cost and cooldown, these revival types heal quite a bit.
		target.apply_status_effect(/datum/status_effect/buff/healing, 14)
		consume_items(target)
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/resurrect/cast_check(skipcharge = 0,mob/user = usr)
	if(!..())
		to_chat(user, span_warning("The miracle fizzles."))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/invoked/resurrect/proc/validate_items(atom/center)
	var/list/available_items = list()
	var/list/missing_items = list()

	// Scan for items in radius
	for(var/obj/item/I in range(item_radius, center))
		if(I.type in required_items)
			available_items[I.type] += 1

	// Check quantities and compile missing list
	for(var/item_type in required_items)
		var/needed = required_items[item_type]
		var/have = available_items[item_type] || 0
		
		if(have < needed) {
			var/obj/item/I = item_type
			var/amount_needed = needed - have
			missing_items += "[amount_needed] [initial(I.name)][amount_needed > 1 ? "s" : ""] "
		}

	if(length(missing_items))
		var/string = ""
		for(var/item in missing_items)
			string += item 
		return "Missing components: [string]."
	return ""

/obj/effect/proc_holder/spell/invoked/resurrect/proc/consume_items(atom/center)
	for(var/item_type in required_items)
		var/needed = required_items[item_type]

		for(var/obj/item/I in range(item_radius, center))
			if(needed <= 0)
				break
			if(I.type == item_type)
				needed--
				qdel(I)

/obj/effect/proc_holder/spell/invoked/resurrect/abyssor
	name = "Abyssal Revival"
	desc = "Revive the target at a cost, cast on yourself to check.<br>a dreamfiend will stalk the target and sap their stats until confronted by them."
	sound = 'sound/magic/whale.ogg'
	//A medley of common ocean fish, totalling 10
	required_items = list(
		/obj/item/reagent_containers/food/snacks/fish/sole = 3,
		/obj/item/reagent_containers/food/snacks/fish/cod = 3,
		/obj/item/reagent_containers/food/snacks/fish/bass = 2,
		/obj/item/reagent_containers/food/snacks/fish/plaice = 1,
		/obj/item/reagent_containers/food/snacks/fish/lobster = 1,
	)
	debuff_type = /datum/status_effect/debuff/dreamfiend_curse
	//This will be Abyssor's statue soon.
	required_structure = /turf/open/water/ocean
	overlay_state = "terrors"


/obj/effect/proc_holder/spell/invoked/summon_dreamfiend_curse
	name = "Confront Terror"
	desc = "Summon the dreamfiend haunting you to confront it directly"
	overlay_state = "terrors"
	chargetime = 0
	invocations = list("Face me daemon!")
	invocation_type = "shout"
	sound = 'modular_azurepeak/sound/mobs/abyssal/abyssal_teleport.ogg'
	/// Type of dreamfiend to summon
	var/dreamfiend_type
	recharge_time = 600 SECONDS
	var/timed_cooldown

/obj/effect/proc_holder/spell/invoked/summon_dreamfiend_curse/cast(list/targets, mob/living/user)
	if (world.time < timed_cooldown) 
		to_chat(user, span_warning("You must gather your strength before you are ready to confront your terror!"))
		to_chat(user, span_warning("Time remaining: [max(0, timed_cooldown - world.time)/10] seconds."))
		revert_cast()
		return FALSE
	// Summon the dreamfiend
	if(summon_dreamfiend(
		target = user,
		user = user,
		F = dreamfiend_type,
		outer_tele_radius = 6,
		inner_tele_radius = 5
	))
		// Remove the curse after summoning
		user.remove_status_effect(/datum/status_effect/debuff/dreamfiend_curse)
		user.mind.RemoveSpell(src)
		return TRUE

	to_chat(user, span_warning("No valid space to manifest the nightmare!"))
	return FALSE

/obj/effect/proc_holder/spell/invoked/resurrect/pestra
	name = "Putrid Revival"
	desc = "Revive the target by consuming extracted Lux."
	sound = 'sound/magic/slimesquish.ogg'
	required_items = list(
		/obj/item/reagent_containers/lux = 1
	)
	overlay_state = "pestra_revive"

/obj/effect/proc_holder/spell/invoked/resurrect/eora
	//Does heartfelt even exist?
	name = "Heartfelt Revival"
	desc = "Revive the target at a cost, cast on yourself to check.<br>The target will get hungry faster for a time."
	required_items = list(
		/obj/item/reagent_containers/food/snacks/rogue/breadslice/toast = 5
	)
	debuff_type = /datum/status_effect/debuff/metabolic_acceleration
	sound = 'sound/magic/heartbeat.ogg'
	overlay_state = "eora_revive"

/obj/effect/proc_holder/spell/invoked/resurrect/xylix
	//Cheap, but wildly unpretictable with possibly far worse effects than other methods.
	name = "Anastasis?"
	desc = "Revives the target? Grants them a random debuff from other revivals, small change to be worse or better."
	debuff_type = /datum/status_effect/debuff/random_revival


/obj/effect/proc_holder/spell/invoked/resurrect/malum
	name = "Diligent Revival"
	desc = "Revive the target at a cost, cast on yourself to check.<br>Targets endurance and strenght will be sapped for a time."
	required_items = list(
		/obj/item/ingot/iron = 3
	)
	debuff_type = /datum/status_effect/debuff/malum_revival
	sound = 'sound/magic/clang.ogg'

/obj/effect/proc_holder/spell/invoked/resurrect/ravox
	name = "Just Revival"
	desc = "Revive the target at a cost, cast on yourself to check.<br>Targets strenght and speed will be sapped for a time."
	// The items here are somewhat hard to pick as it still has to be something a ravox acolyte would reasonably obtain.
	// Bones insinuate that mayhaps, they went out there to delete some skeletons for justice?
	required_items = list(
		/obj/item/natural/bone = 10
	)
	debuff_type = /datum/status_effect/debuff/ravox_revival

/obj/effect/proc_holder/spell/invoked/resurrect/dendor
	name = "Wild Revival"
	desc = "Revive the target at a cost, cast on yourself to check.<br>Targets speed and constitution will be sapped for a time."
	//Herbs that have to do with intelligence mostly. Easier to remember.
	required_items = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 3,
		/obj/item/alch/mentha = 3,
		/obj/item/reagent_containers/food/snacks/grown/rogue/swampweed = 3
	)
	debuff_type = /datum/status_effect/debuff/dendor_revival
	required_structure = /obj/structure/flora/roguetree/wise
	sound = 'sound/magic/birdsong.ogg'

/obj/effect/proc_holder/spell/invoked/resurrect/noc
	name = "Moonlit Revival"
	desc = "Revive the target at a cost, cast on yourself to check.<br>Targets intelligence will be sapped for a time, in addition they will be burned by moonlight."
	required_items = list(
		/obj/item/paper/scroll = 15
	)
	debuff_type = /datum/status_effect/debuff/noc_revival
	overlay_state = "noc_revive"
	sound = 'sound/magic/owlhoot.ogg'


/obj/effect/proc_holder/spell/invoked/resurrect/undivided
	name = "Decagram Revival"
	desc = "Revive the target at a cost, cast on yourself to check."
	required_items = list(
		/obj/item/rogueore/gold = 1 // Was thinking Eclipsum combo of gold/silver but that'd probably be *too* expensive. Probably the costliest revival, while having a anastasis equal debuff.
	)
	debuff_type = /datum/status_effect/debuff/revived
	sound = 'sound/magic/revive.ogg'
