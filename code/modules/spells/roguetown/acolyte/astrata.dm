/obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
	name = "Sacred Flame"
	overlay_state = "sacredflame"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/heal.ogg'
	invocation = "Cleansing flames, kindle!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 5 SECONDS
	miracle = TRUE
	devotion_cost = 30

/obj/effect/proc_holder/spell/invoked/sacred_flame_rogue/cast(list/targets, mob/user = usr)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/L = targets[1]
		user.visible_message("<font color='yellow'>[user] points at [L]!</font>")
		if(L.anti_magic_check(TRUE, TRUE))
			return FALSE
		L.adjust_fire_stacks(5)
		L.IgniteMob()
		addtimer(CALLBACK(L, TYPE_PROC_REF(/mob/living, ExtinguishMob)), 5 SECONDS)
		return TRUE

	// Spell interaction with ignitable objects (burn wooden things, light torches up)
	else if(isobj(targets[1]))
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
	charge_max = 2 MINUTES
	miracle = TRUE
	devotion_cost = 80
	/// Amount of PQ gained for reviving people
	var/revive_pq = PQ_GAIN_REVIVE

/obj/effect/proc_holder/spell/invoked/revive/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		testing("revived1")
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE
		if(target.stat < DEAD)
			to_chat(user, span_warning("Nothing happens."))
			return FALSE
		if(GLOB.tod == "night")
			to_chat(user, span_warning("Let there be light."))
		for(var/obj/structure/fluff/psycross/S in oview(5, user))
			S.AOE_flash(user, range = 8)
		if(target.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			target.visible_message(span_danger("[target] is unmade by holy light!"), span_userdanger("I'm unmade by holy light!"))
			target.gib()
			return TRUE
		target.adjustOxyLoss(-target.getOxyLoss()) //Ye Olde CPR
		if(!target.revive(full_heal = FALSE))
			to_chat(user, span_warning("Nothing happens."))
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
		target.update_body()
		target.visible_message(span_notice("[target] is revived by holy light!"), span_green("I awake from the void."))
		if(target.mind)
			if(revive_pq && !HAS_TRAIT(target, TRAIT_IWASREVIVED) && user?.ckey)
				adjust_playerquality(revive_pq, user.ckey)
				ADD_TRAIT(target, TRAIT_IWASREVIVED, "[type]")
			target.mind.remove_antag_datum(/datum/antagonist/zombie)
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

/obj/effect/proc_holder/spell/invoked/smite
	name = "Astrata's Judgment"
	overlay_state = "smite"
	releasedrain = 60
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "sydwarning"
	no_early_release = FALSE
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/heal.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 3 MINUTES
	miracle = TRUE
	devotion_cost = 70
	invocation = "By Astrata's burning gaze, let divine judgment rain!"
	invocation_type = "shout"
	var/smite_active = FALSE
	var/smite_target = null
	var/warning_stage = 0
	var/last_stack_time = 0

/obj/effect/proc_holder/spell/invoked/smite/cast(list/targets, mob/living/user)
	if(!..())
		return FALSE

	if(!isliving(targets[1]))
		revert_cast()
		return FALSE

	var/mob/living/L = targets[1]
	// TODO: Re-add this check after testing
	// if(L == user)
	// 	to_chat(user, span_warning("You cannot smite yourself."))
	// 	return FALSE

	if(GLOB.tod == "night")
		to_chat(user, span_warning("Astrata's gaze cannot reach during the night."))
		return FALSE

	var/turf/T = get_turf(L)
	var/area/A = get_area(T)
	if(!A.outdoors)
		to_chat(user, span_warning("The target must be under open sky for Astrata's judgment."))
		return FALSE

	smite_active = TRUE
	smite_target = L
	warning_stage = 0
	last_stack_time = world.time

	var/area/cast_area = get_area(L)
	var/location_name = cast_area.name
	if(cast_area.first_time_text)  // Use the special first_time_text if it exists
		location_name = cast_area.first_time_text
	priority_announce("Astrata's gaze has focused dangerously on [uppertext(location_name)]. Her divine wrath draws near.", "Divine Warning", 'sound/misc/astratascream.ogg')

	// Start the smiting process
	START_PROCESSING(SSobj, src)
	return TRUE

/obj/effect/proc_holder/spell/invoked/smite/process()
	if(!smite_active || !smite_target || GLOB.tod == "night")
		end_smite()
		return

	var/mob/living/L = smite_target
	if(!istype(L) || L.stat == DEAD)
		end_smite()
		return

	// Check if target is indoors
	var/turf/T = get_turf(L)
	var/area/A = get_area(T)
	if(!A.outdoors)
		to_chat(L, span_notice("The burning gaze subsides as you find shelter."))
		end_smite()
		return

	var/elapsed_time = world.time - last_stack_time
	
	// Handle the warning phase (first 10 seconds)
	if(elapsed_time < 10 SECONDS)
		var/warning_threshold = (elapsed_time / (10 SECONDS)) * 8  // 8 total warnings over 10 seconds
		if(warning_stage <= warning_threshold)
			switch(warning_stage)
				if(0)
					L.visible_message(span_warning("The air around [L] begins to shimmer with heat..."))
				if(1)
					L.visible_message(span_warning("The temperature rises dramatically around [L]!"))
				if(2)
					L.visible_message(span_warning("[L] begins to sweat as Astrata's gaze intensifies!"))
				if(3)
					L.visible_message(span_danger("The air crackles with divine fury around [L]!"))
				if(4)
					L.visible_message(span_danger("The very air begins to burn!"))
				if(5)
					L.visible_message(span_danger("Reality warps as the sun's fury bears down!"))
				if(6)
					L.visible_message(span_danger("The sky itself seems to split open with divine light!"))
				if(7)
					L.visible_message(span_danger("ASTRATA'S JUDGMENT IS AT HAND!"))
			warning_stage++
			return
	// After 10 seconds, start applying fire stacks
	else if(world.time >= last_stack_time + 2 SECONDS)  // Apply fire every 2 seconds after the warning phase
		L.adjust_fire_stacks(10)  // Changed from 2 to 10 for more intense burning
		L.IgniteMob()
		last_stack_time = world.time
		L.visible_message(span_danger("Divine flames engulf [L] as Astrata's judgment rains down!"))

/obj/effect/proc_holder/spell/invoked/smite/proc/end_smite()
	if(smite_active)  // Only announce if the spell was actually active
		priority_announce("The sun has resumed its normal cycle.", "Divine Warning")
	smite_active = FALSE
	smite_target = null
	warning_stage = 0
	STOP_PROCESSING(SSobj, src)
