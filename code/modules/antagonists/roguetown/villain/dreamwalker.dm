/datum/antagonist/dreamwalker
	name = "Dreamwalker"
	roundend_category = "Dreamwalker"
	antagpanel_category = "Dreamwalker"
	job_rank = ROLE_DREAMWALKER
	confess_lines = list(
		"MY VISION ABOVE ALL!",
		"I'LL TAKE YOU TO MY REALM!",
		"HIS FORM IS MAGNICIFENT!",
	)
	rogue_enabled = TRUE

	var/traits_dreamwalker = list(
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_NOPAIN,
		TRAIT_TOXIMMUNE,
		TRAIT_STEELHEARTED,
		TRAIT_NOSLEEP,
		TRAIT_NOMOOD,
		TRAIT_NOLIMBDISABLE,
		TRAIT_SHOCKIMMUNE,
		TRAIT_CRITICAL_RESISTANCE,
		TRAIT_HEAVYARMOR,
		TRAIT_COUNTERCOUNTERSPELL,
		TRAIT_RITUALIST,
		TRAIT_ARCYNE_T1,
		TRAIT_STRENGTH_UNCAPPED,
		TRAIT_DREAMWALKER
		)

	var/STASTR = 15
	var/STASPD = 12
	var/STAINT = 12
	var/STAEND = 12
	var/STACON = 12
	var/STAPER = 12
	var/STALUC = 10

/datum/antagonist/dreamwalker/on_gain()
	SSmapping.retainer.dreamwalkers |= owner
	. = ..()
	reset_stats()
	// We'll set the special role later to avoid revealing dreamwalkers early!
	//owner.special_role = name
	greet()
	return ..()

/datum/antagonist/dreamwalker/greet()
	to_chat(owner.current, span_notice("I feel a rare ability awaken within me. I am someone coveted as a champion by most gods. A dreamwalker. Not merely touched by Abyssor's dream, but able to pull materia and power from his realm effortlessly. I shall bring glory to my patron. My mind frays under the influence of dream entities, but surely my resolve is stronger than theirs."))
	owner.announce_objectives()
	..()

/datum/antagonist/dreamwalker/proc/reset_stats()
	owner.current.STASTR = src.STASTR
	owner.current.STAPER = src.STAPER
	owner.current.STAINT = src.STAINT
	owner.current.STASPD = src.STASPD
	owner.current.STAEND = src.STAEND
	owner.current.STACON = src.STACON
	owner.current.STALUC = src.STALUC
	//Dreamfiends fear them up close.
	var/mob/living/carbon/human/body = owner.current 
	body.faction |= "dream"
	for (var/trait in traits_dreamwalker)
		ADD_TRAIT(body, trait, "[type]")
	if(body.mind)
		body.mind.RemoveAllSpells()
		body.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/blink)
		body.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mark_target)
		body.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/jaunt)
	body.ambushable = FALSE
	body.AddComponent(/datum/component/dreamwalker_repair)
	body.AddComponent(/datum/component/dreamwalker_mark)

/datum/outfit/job/roguetown/dreamwalker/pre_equip(mob/living/carbon/human/H) //Equipment is located below
	..()

	H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	// We lose our statpack & racial, so bonuses are significant.
	H.change_stat("strength", 5)
	H.change_stat("intelligence", 2)
	H.change_stat("constitution", 2)
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)
	H.change_stat("endurance", 2)

	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/blink)
	H.ambushable = FALSE

/datum/component/dreamwalker_repair
	/// List of dream items being repaired
	var/list/repairing_items = list()
	/// List of timers for broken items being fully repaired
	var/list/repair_timers = list()
	/// Processing interval
	/// Careful touching this as setting it too low makes it REALLY hard to break items.
	var/process_interval = 5 SECONDS
	/// Time of last processing
	var/last_process = 0

/datum/component/dreamwalker_repair/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	to_chat(parent, span_userdanger("Your body pulses with strange dream energies."))
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, .proc/on_item_equipped)
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, .proc/on_item_dropped)
	// Register for processing
	START_PROCESSING(SSprocessing, src)

/datum/component/dreamwalker_repair/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	// Clean up all timers
	for(var/obj/item/I in repair_timers)
		deltimer(repair_timers[I])
	repair_timers = null
	repairing_items = null
	return ..()

/datum/component/dreamwalker_repair/process(delta_time)
	// Only process every x seconds
	if(world.time < last_process + process_interval)
		return

	last_process = world.time

	// Process all items in the repair list
	for(var/obj/item/I in repairing_items)
		if(I.obj_broken)
			continue // Broken items are handled separately
		if(I.obj_integrity < I.max_integrity)
			I.obj_integrity = min(I.obj_integrity + I.max_integrity * 0.01, I.max_integrity) // Repair 1% of max integrity
			I.update_icon()
		if(I.blade_int < I.max_blade_int)
			I.add_bintegrity(min(I.blade_int + I.max_blade_int * 0.01, I.max_blade_int), src.parent) // Sharpen 1% of max sharpness

/datum/component/dreamwalker_repair/proc/on_item_equipped(mob/user, obj/item/source, slot)
	SIGNAL_HANDLER
	if(source.item_flags & DREAM_ITEM)
		to_chat(parent, span_notice("the [source] pulses in your hands, dream energies passively repairing it."))
		add_item(source)

/datum/component/dreamwalker_repair/proc/on_item_dropped(mob/user, obj/item/source)
	SIGNAL_HANDLER
	if(source.item_flags & DREAM_ITEM)
		to_chat(parent, span_notice("the [source] stops pulsing as it leaves your person."))
		remove_item(source)

/datum/component/dreamwalker_repair/proc/add_item(obj/item/I)
	if(I in repairing_items)
		return
	repairing_items += I
	RegisterSignal(I, COMSIG_ITEM_BROKEN, .proc/on_item_broken)

	// If item is already broken, start full repair process
	if(I.obj_broken)
		start_full_repair(I)

/datum/component/dreamwalker_repair/proc/remove_item(obj/item/I)
	if(I in repairing_items)
		repairing_items -= I
		UnregisterSignal(I, COMSIG_ITEM_BROKEN)
		// Cancel any ongoing full repair
		if(I in repair_timers)
			deltimer(repair_timers[I])
			repair_timers -= I

/datum/component/dreamwalker_repair/proc/on_item_broken(obj/item/source)
	SIGNAL_HANDLER
	if(source in repairing_items)
		source.visible_message(span_danger("The [source] shatters, but it seems strange energies are slowly bending the metal back into shape."))
		start_full_repair(source)

/datum/component/dreamwalker_repair/proc/start_full_repair(obj/item/I)
	// Cancel any existing timer
	if(I in repair_timers)
		deltimer(repair_timers[I])

	// Set a timer to fully repair after 1 minute
	repair_timers[I] = addtimer(CALLBACK(src, .proc/finish_full_repair, I), 1 MINUTES, TIMER_STOPPABLE)

/datum/component/dreamwalker_repair/proc/finish_full_repair(obj/item/I)
	// Check if the item is still in our inventory and broken
	if(I && (I in repairing_items) && I.obj_broken)
		I.visible_message(span_danger("The [I] melds back into a useable shape."))
		I.obj_fix()
		// Restore up to 25% of durability instead of all of it. This is slightly more as I.integrity_failure for MOST things.
		I.obj_integrity *= 0.25
		I.update_icon()

	// Remove the timer reference
	repair_timers -= I

/obj/effect/proc_holder/spell/invoked/mark_target
	name = "Mark Target"
	desc = "Marks a random target for pursuit. Track them, extract metal from their mind to complete your vision."
	releasedrain = 75
	chargedrain = 1
	chargetime = 1.5 SECONDS
	recharge_time = 25 MINUTES
	overlay_state = "mark"
	invocations = list("Dream... manifest my vision, bend to my will.")
	invocation_type = "whisper"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 1
	associated_skill = /datum/skill/magic/arcane

	// Define roles that are considered valid targets
	var/static/list/valid_target_roles = list(
		"Acolyte"
	)

	var/mob/living/marked_target = null
	var/obj/effect/proc_holder/spell/invoked/track_mark/tracking_spell = null

/obj/effect/proc_holder/spell/invoked/mark_target/Destroy()
	remove_mark()
	return ..()

/obj/effect/proc_holder/spell/invoked/mark_target/cast(list/targets, mob/user)
	var/mob/living/target = targets[1]

	var/datum/component/dreamwalker_mark/mark_component = user.GetComponent(/datum/component/dreamwalker_mark)
	if(!mark_component)
		mark_component = user.AddComponent(/datum/component/dreamwalker_mark)

	if(target == user || ishuman(target))
		to_chat(user, span_warning("You mark [target] for testing purposes!"))
		if(marked_target)
			remove_mark()
		// Apply new mark
		marked_target = target
		tracking_spell = new()
		tracking_spell.marked_target = marked_target
		tracking_spell.parent_spell = src
		user.mind.AddSpell(tracking_spell)
		mark_component.set_marked_target(marked_target)
		return TRUE

	var/list/valid_targets = get_valid_targets(user)
	if(!length(valid_targets))
		to_chat(user, span_warning("No valid targets found."))
		revert_cast()
		return
	target = pick(valid_targets)
	to_chat(user, span_notice("The spell seeks out a worthy target..."))

	// Remove previous mark if it exists
	if(marked_target)
		remove_mark()
	// Apply new mark
	marked_target = target
	tracking_spell = new()
	tracking_spell.marked_target = marked_target
	tracking_spell.parent_spell = src
	user.mind.AddSpell(tracking_spell)
	mark_component.set_marked_target(marked_target)

	if(marked_target != user)
		to_chat(user, span_warning("[user] traces a glowing symbol in the air marking [marked_target]."), 
							 span_notice("You mark [marked_target] for pursuit."))

	return TRUE

/obj/effect/proc_holder/spell/invoked/mark_target/proc/get_valid_targets(mob/user)
	var/list/valid_targets = list()
	
	for(var/mob/living/carbon/human/player in GLOB.player_list)
		if(player == user || player.stat == DEAD || !player.mind || !player.client)
			continue
		if(player.mind.assigned_role in valid_target_roles)
			valid_targets += player
	return valid_targets

/obj/effect/proc_holder/spell/invoked/mark_target/proc/is_valid_target(mob/living/target)
	if(!ishuman(target) || target.stat == DEAD || !target.mind || !target.client)
		return FALSE
	return (target.mind.assigned_role in valid_target_roles)

/obj/effect/proc_holder/spell/invoked/mark_target/proc/remove_mark()
	if(marked_target)
		marked_target = null
	if(tracking_spell && usr && usr.mind)
		usr.mind.RemoveSpell(tracking_spell)
		tracking_spell = null

/obj/effect/proc_holder/spell/invoked/track_mark
	name = "Track Marked Target"
	recharge_time = 10 SECONDS
	var/mob/living/marked_target = null
	var/obj/effect/proc_holder/spell/invoked/mark_target/parent_spell = null
	releasedrain = 75
	chargedrain = 1
	chargetime = 0.5 SECONDS
	overlay_state = "mark"
	invocations = list("Signum persequendi!")
	invocation_type = "whisper"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 1
	associated_skill = /datum/skill/magic/arcane

/obj/effect/proc_holder/spell/invoked/track_mark/cast(list/targets, mob/user)
	if(!marked_target)
		to_chat(user, span_warning("The mark has faded!"))
		user.mind.RemoveSpell(src)
		return

	var/turf/user_turf = get_turf(user)
	var/turf/target_turf = get_turf(marked_target)

	if(user_turf.z != target_turf.z)
		// Different z-level
		var/z_direction = "unknown"
		if(user_turf.z > target_turf.z)
			z_direction = "above"
		else
			z_direction = "below"

		to_chat(user, span_notice("The target is on a level [z_direction] you."))
	else
		// Same z-level
		var/distance = get_dist(user, marked_target)
		var/direction = get_dir(user, marked_target)

		if(distance == 0)
			to_chat(user, span_notice("The target is here!"))
		else
			var/direction_text = dir2text(direction)
			to_chat(user, span_notice("The target is [distance] tiles away to the [direction_text]."))

	// Check if the target is downed and adjacent
	if(user.Adjacent(marked_target) && !(marked_target.mobility_flags & MOBILITY_STAND) && !marked_target.buckled)
		to_chat(user, span_notice("The target is vulnerable. You begin to pull metal from their mind..."))

		if(do_after(user, 1 SECONDS, target = marked_target))
			// Small stun to stop our target from messing with the ingot
			marked_target.Stun(10)
			// Create an ingot
			new /obj/item/ingot/sylveric(get_turf(user))
			marked_target.apply_status_effect(/datum/status_effect/debuff/dreamfiend_curse)
			to_chat(user, span_notice("You successfully manifest an ingot of strange metal using your target's psyche."))

			// Remove the mark
			if(parent_spell)
				parent_spell.remove_mark()
			user.mind.RemoveSpell(src)
		else
			to_chat(user, span_warning("You were interrupted."))

/obj/effect/proc_holder/spell/invoked/jaunt
	name = "Dream Jaunt"
	desc = "Teleports you to a random coastal area after a short channel, leaving a temporary portal behind. You may be followed."
	chargedrain = 0
	chargetime = 2 SECONDS
	recharge_time = 20 MINUTES
	invocation_type = "whisper"
	invocations = list("Whisper of the dream...")
	movement_interrupt = FALSE
	charging_slowdown = 1
	associated_skill = /datum/skill/magic/arcane

/obj/effect/proc_holder/spell/invoked/jaunt/cast(list/targets, mob/user)
	var/turf/original_turf = get_turf(user)
	if(!original_turf)
		revert_cast()
		return

	// Find destination area
	var/static/list/possible_areas = list(
		/area/rogue/outdoors/beach,
		/area/rogue/outdoors/beach/north,
		/area/rogue/outdoors/beach/south
	)
	var/area/destination_area = GLOB.areas_by_type[pick(possible_areas)]
	if(!destination_area)
		revert_cast()
		return

	// Find safe turfs in destination area
	var/list/safe_turfs = list()
	for(var/turf/T in get_area_turfs(destination_area))
		if(istype(T, /turf/open/water/ocean/deep))
			continue
		if(T.density)
			continue
		var/valid = TRUE
		for(var/atom/movable/AM in T)
			if(AM.density && AM.anchored)
				valid = FALSE
				break
		if(valid)
			safe_turfs += T

	if(!safe_turfs.len)
		revert_cast()
		return

	var/turf/destination = pick(safe_turfs)
	
	// Create portal at origin
	var/obj/structure/portal_jaunt/portal = new(original_turf)
	portal.linked_turf = destination

	// Teleport user
	if(do_teleport(user, destination))
		// Create return portal at destination
		return TRUE

	qdel(portal)
	revert_cast()
	return FALSE

/obj/structure/portal_jaunt
	name = "dream rift"
	desc = "A shimmering portal to another place. You hear countless whispers when you get close, seems dangerous."
	icon_state = "shitportal"
	icon = 'icons/roguetown/misc/structure.dmi'
	max_integrity = 250
	var/cooldown = 0
	var/uses = 0
	var/max_uses = 3
	var/turf/linked_turf

/obj/structure/portal_jaunt/Initialize()
	. = ..()
	cooldown = world.time + 4 SECONDS
	visible_message(span_warning("[src] shimmers into existence!"))
	playsound(src, 'sound/magic/charging_lightning.ogg', 50, TRUE)

/obj/structure/portal_jaunt/attack_hand(mob/user)
	if(!do_after(user, 1 SECONDS, target = src))
		to_chat(user, span_warning("I must stand still to use the portal."))
		return

	if(world.time < cooldown)
		var/time_left = (cooldown - world.time) * 0.1
		to_chat(user, span_warning("The portal is not stable yet. [time_left] seconds remaining."))
		return

	if(uses >= max_uses)
		to_chat(user, span_warning("The portal collapses as you touch it!"))
		qdel(src)
		return

	if(!linked_turf || !do_teleport(user, linked_turf))
		to_chat(user, span_warning("The portal flickers but nothing happens."))
		return

	uses++
	cooldown = world.time + 15 SECONDS
	// High likelyhood of getting a dreamfiend summon upon non dreamwalkers when used.
	if(!HAS_TRAIT(user, TRAIT_DREAMWALKER) && prob(75))
		summon_dreamfiend(
			target = user,
			user = user,
			F = /mob/living/simple_animal/hostile/rogue/dreamfiend,
			outer_tele_radius = 3,
			inner_tele_radius = 2,
			include_dense = FALSE,
			include_teleport_restricted = FALSE
		)

	visible_message(span_warning("[user] steps through [src]!"))
	playsound(src, 'sound/magic/lightning.ogg', 50, TRUE)

	if(uses >= max_uses)
		visible_message(span_danger("[src] collapses in on itself!"))
		QDEL_IN(src, 1)

// Component to track marked targets and hits
/datum/component/dreamwalker_mark
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/mob/living/marked_target = null
	var/hit_count = 0
	var/max_hits = 5
	var/mark_duration = 30 MINUTES
	var/mark_start_time = 0
	var/mark_minimum_duration = 10 MINUTES
	var/obj/effect/proc_holder/spell/invoked/summon_marked/summon_spell = null

/datum/component/dreamwalker_mark/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_MOB_ITEM_ATTACK, .proc/on_attack)

/datum/component/dreamwalker_mark/Destroy()
	if(marked_target)
		UnregisterSignal(marked_target, COMSIG_LIVING_DEATH)
		marked_target = null

	if(summon_spell && ishuman(parent))
		var/mob/living/carbon/human/H = parent
		if(H.mind)
			H.mind.RemoveSpell(summon_spell)
		QDEL_NULL(summon_spell)
	return ..()

/datum/component/dreamwalker_mark/proc/set_marked_target(mob/living/target)
	if(marked_target)
		UnregisterSignal(marked_target, COMSIG_LIVING_DEATH)
		if(marked_target.has_status_effect(/datum/status_effect/dream_mark))
			marked_target.remove_status_effect(/datum/status_effect/dream_mark)

	marked_target = target
	hit_count = 0
	mark_start_time = 0

	if(marked_target)
		RegisterSignal(marked_target, COMSIG_LIVING_DEATH, .proc/on_target_death)
		to_chat(parent, span_notice("You begin focusing your dream energy on [marked_target]."))

		// Remove any existing summon spell
		if(summon_spell && ishuman(parent))
			var/mob/living/carbon/human/H = parent
			if(H.mind)
				H.mind.RemoveSpell(summon_spell)
			QDEL_NULL(summon_spell)

/datum/component/dreamwalker_mark/proc/on_attack(mob/parent, mob/living/target, mob/user, obj/item/I)
	SIGNAL_HANDLER

	if(!marked_target || target != marked_target)
		return

	if(!(I.item_flags & DREAM_ITEM))
		return

	if(marked_target.has_status_effect(/datum/status_effect/dream_mark))
		return

	hit_count++
	to_chat(user, span_notice("Your dream weapon strikes true. [hit_count]/[max_hits] hits to establish a connection."))

	if(hit_count >= max_hits)
		// Apply the mark status effect
		marked_target.apply_status_effect(/datum/status_effect/dream_mark, mark_duration)
		mark_start_time = world.time
		to_chat(user, span_warning("You've established a strong dream connection with [marked_target]! You'll be able to summon them in 10 minutes."))
		to_chat(marked_target, span_userdanger("You feel an unnatural connection forming with [user]. Your very essence feels tethered to them."))

		create_summon_spell()

/datum/component/dreamwalker_mark/proc/create_summon_spell()
	if(!marked_target || !ishuman(parent))
		return

	// Check if mark is still active
	if(!marked_target.has_status_effect(/datum/status_effect/dream_mark))
		to_chat(parent, span_warning("Your connection with [marked_target] has faded before you could summon them!"))
		return

	// Create the summon spell
	summon_spell = new()
	var/mob/living/carbon/human/H = parent
	if(H.mind)
		H.mind.AddSpell(summon_spell)
		to_chat(H, span_warning("Your connection with [marked_target] is now strong enough to summon them!"))

/datum/component/dreamwalker_mark/proc/on_target_death()
	SIGNAL_HANDLER
	to_chat(parent, span_warning("Your connection with [marked_target] has been severed by death."))
	set_marked_target(null)

/datum/component/dreamwalker_mark/proc/can_summon()
	if(!marked_target)
		return FALSE

	if(!marked_target.has_status_effect(/datum/status_effect/dream_mark))
		return FALSE

	if(world.time < mark_start_time + mark_minimum_duration)
		var/time_left = ((mark_start_time + mark_minimum_duration) - world.time) * 0.1
		to_chat(parent, span_warning("The mark is not stable yet. [time_left] seconds remaining."))
		return FALSE

	return TRUE

// Status effect for marked targets
/datum/status_effect/dream_mark
	id = "dream_mark"
	duration = 30 MINUTES // Increased to 30 minutes
	alert_type = /atom/movable/screen/alert/status_effect/dream_mark

/datum/status_effect/dream_mark/on_apply()
	to_chat(owner, span_userdanger("You feel your essence being pulled toward another realm. You've been marked by a dreamwalker!"))
	return TRUE

/datum/status_effect/dream_mark/on_remove()
	to_chat(owner, span_notice("The connection to the dream realm fades."))

/atom/movable/screen/alert/status_effect/dream_mark
	name = "Dream Marked"
	desc = "A dreamwalker has established a connection to your essence. They may attempt to summon you once the connection stabilizes."
	icon_state = "dream_mark"

// Summon marked target spell
/obj/effect/proc_holder/spell/invoked/summon_marked
	name = "Summon Marked"
	desc = "Summons your marked target to your location, leaving a temporary portal behind. Requires the target to be marked for at least 10 minutes."
	chargedrain = 0
	chargetime = 1.5 SECONDS
	recharge_time = 30 SECONDS
	invocation_type = "whisper"
	invocations = list("I invoke the dream connection, come to me!")
	movement_interrupt = FALSE
	charging_slowdown = 1
	associated_skill = /datum/skill/magic/arcane

/obj/effect/proc_holder/spell/invoked/summon_marked/cast(list/targets, mob/user)
	var/datum/component/dreamwalker_mark/mark_component = user.GetComponent(/datum/component/dreamwalker_mark)
	if(!mark_component || !mark_component.marked_target)
		to_chat(user, span_warning("You have no target marked for summoning!"))
		revert_cast()
		return

	// Check if we can summon (10 minutes have passed)
	if(!mark_component.can_summon())
		revert_cast()
		return

	var/mob/living/target = mark_component.marked_target

	if(!target.has_status_effect(/datum/status_effect/dream_mark))
		to_chat(user, span_warning("Your connection with [target] has faded!"))
		revert_cast()
		return

	if(target.stat == DEAD)
		to_chat(user, span_warning("[target] is dead and cannot be summoned!"))
		revert_cast()
		return

	to_chat(target, span_userdanger("YOU CAN FEEL THE DREAMWALKER BEGIN TO SUMMON YOU BY FORCE."))
	if(!do_after(user, 20 SECONDS, FALSE, user))
		to_chat(user, span_warning("You must stand still to summon your target!"))
		// Counts as a finished spellcast to make it impossible to spam your target with messages...
		return TRUE

	var/turf/original_turf = get_turf(target)
	var/turf/destination = get_turf(user)

	if(!original_turf || !destination)
		revert_cast()
		return

	// Create portal at target's original location
	var/obj/structure/portal_jaunt/portal = new(original_turf)
	portal.linked_turf = destination

	// Teleport target
	if(do_teleport(target, destination))
		to_chat(user, span_warning("You summon [target] to your location!"))
		to_chat(target, span_userdanger("You're violently pulled through the dream realm to [user]'s location!"))
		// Reset mark after teleport.
		target.remove_status_effect(/datum/status_effect/dream_mark)
		mark_component.marked_target = null
		return TRUE

	qdel(portal)
	revert_cast()
	return FALSE

/obj/item/ingot/sylveric
	name = "Sylveric ingot"
	icon = 'icons/roguetown/items/ore.dmi'
	icon_state = "ingotsylveric"
	desc = "An impossibly light metal that seems to grow harder and heavier when pressured. Nothing seems to be able to shape this metal."
