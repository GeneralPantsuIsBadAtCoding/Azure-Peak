// Define the fire immunity trait at the top of the file
#define TRAIT_FIRE_IMMUNE "fire_immune"

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

// Define a basic fireball projectile if it doesn't exist elsewhere
/obj/projectile/magic/fireball
	name = "fireball"
	icon_state = "fireball"
	damage = 20
	damage_type = BURN
	
/obj/projectile/magic/fireball/on_hit(target)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		L.adjust_fire_stacks(2)
		L.IgniteMob()

/obj/effect/proc_holder/spell/targeted/astrata_projectile
	name = "Astrata's Wrath"
	desc = "Launches a projectile that changes based on the time of day."
	school = "evocation"
	clothes_req = FALSE
	invocation = "Astrata's fury, manifest!"
	invocation_type = "shout"
	range = 20
	charge_max = 30 SECONDS
	cooldown_min = 30 SECONDS
	selection_type = "view"
	sound = 'sound/magic/fireball.ogg'
	var/fireball_damage = 20
	var/spitfire_damage = 15
	var/spitfire_burn = 10
	action_icon = 'icons/mob/actions/actions_spells.dmi'
	action_icon_state = "fireball"
	action_background_icon_state = "bg_spell"
	antimagic_allowed = TRUE
	
/obj/projectile/magic/spitfire
	name = "spitfire"
	icon_state = "fireball"
	damage = 15
	damage_type = BURN
	var/burn = 10
	
/obj/projectile/magic/spitfire/on_hit(target)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		L.adjust_fire_stacks(1)
		L.IgniteMob()
		L.adjustFireLoss(burn)

/obj/effect/proc_holder/spell/targeted/astrata_projectile/cast(list/targets, mob/living/user)
	for(var/mob/living/target in targets)
		if(GLOB.tod == "night")
			// At night, cast spitfire
			var/obj/projectile/magic/spitfire/SF = new(get_turf(user))
			SF.damage = spitfire_damage
			SF.burn = spitfire_burn
			SF.firer = user
			SF.fire(target)
			user.visible_message(span_danger("[user] spits a stream of blue fire at [target]!"))
		else
			// During day, cast the fireball
			var/obj/projectile/magic/fireball/FB = new(get_turf(user))
			FB.damage = fireball_damage
			FB.firer = user
			FB.fire(target)
			user.visible_message(span_danger("[user] casts a fireball at [target]!"))

/obj/effect/proc_holder/spell/invoked/flame_shield
	name = "Flame Shield"
	overlay_state = "flame_shield"
	releasedrain = 60
	chargedrain = 0
	chargetime = 30
	range = 2
	warnie = "sydwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/heal.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 1 MINUTES
	miracle = TRUE
	devotion_cost = 50
	invocation = "Astrata, shield thy faithful in your holy flames!"
	invocation_type = "shout"

/obj/effect/proc_holder/spell/invoked/flame_shield/cast(list/targets, mob/living/user)
	if(!..())
		return FALSE

	if(!isliving(targets[1]))
		revert_cast()
		return FALSE

	var/mob/living/L = targets[1]
	
	// Protect the target with flame stacks that don't harm them
	L.visible_message(span_notice("Divine flames engulf [L], forming a protective shield!"), span_green("I feel Astrata's fire shield me from harm!"))
	
	// Apply fire stacks but prevent them from hurting the target
	L.adjust_fire_stacks(15)
	L.IgniteMob()
	ADD_TRAIT(L, TRAIT_NOFIRE, "flame_shield")
	
	// Create a flame shield effect
	var/obj/effect/flame_shield_effect/shield = new(get_turf(L))
	shield.target = L
	shield.shield_health = 100
	shield.attached_user = user
	
	// Start processing the shield effect
	START_PROCESSING(SSobj, shield)
	
	// Let the target know what's happening
	to_chat(L, span_notice("The divine flames will shield you from [shield.shield_health] damage. The shield will gradually weaken over time."))
	
	return TRUE

/obj/effect/flame_shield_effect
	name = "flame shield"
	desc = "A shield of divine flames."
	icon = 'icons/effects/effects.dmi'
	icon_state = "fire_shield"
	anchored = TRUE
	var/mob/living/target = null
	var/shield_health = 100
	var/shield_decay_rate = 5 // Amount of shield health lost per tick
	var/last_decay_time = 0
	var/decay_interval = 3 SECONDS
	var/mob/living/attached_user = null

/obj/effect/flame_shield_effect/Initialize()
	. = ..()
	alpha = 200
	layer = ABOVE_MOB_LAYER
	last_decay_time = world.time

/obj/effect/flame_shield_effect/Destroy()
	if(target)
		to_chat(target, span_warning("Your flame shield dissipates!"))
		REMOVE_TRAIT(target, TRAIT_NOFIRE, "flame_shield")
		target.ExtinguishMob()
		target = null
	attached_user = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/effect/flame_shield_effect/process()
	if(!target || target.stat == DEAD || !target.fire_stacks)
		qdel(src)
		return
	
	// Position the effect on the target
	forceMove(get_turf(target))
	
	// Decay shield over time
	if(world.time >= last_decay_time + decay_interval)
		shield_health -= shield_decay_rate
		last_decay_time = world.time
		
		// Visual feedback on shield strength
		alpha = 200 * (shield_health / 100)
		
		// Also reduce fire stacks
		target.adjust_fire_stacks(-1)
	
	// If shield depleted or fire stacks gone, remove it
	if(shield_health <= 0 || target.fire_stacks <= 0)
		qdel(src)
		return

// When the shielded mob takes damage, reduce shield health instead
/obj/effect/flame_shield_effect/Crossed(atom/movable/AM)
	. = ..()
	if(istype(AM, /obj/projectile))
		var/obj/projectile/P = AM
		reduce_shield(P.damage)

/obj/effect/flame_shield_effect/proc/reduce_shield(amount)
	shield_health -= amount
	if(shield_health <= 0)
		qdel(src)
		return
	
	// Visual feedback
	alpha = 200 * (shield_health / 100)
	
	// Reduce fire stacks proportionally to damage absorbed
	var/stacks_to_reduce = amount / 10
	if(stacks_to_reduce > 0)
		target.adjust_fire_stacks(-stacks_to_reduce)
	
	// If fire stacks gone, remove shield
	if(target.fire_stacks <= 0)
		qdel(src)

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
					L.visible_message(span_danger("The air begins to burn!"))
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
