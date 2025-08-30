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
	to_chat(world, span_userdanger("RESETTING THEM STATS UWU"))
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
	body.ambushable = FALSE
	body.AddComponent(/datum/component/dreamwalker_repair)

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
	to_chat(world, span_userdanger("ADDING STATS NOW"))
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
		// Restore up to 20% of durability instead of all of it. This is the same as I.integrity_failure which I'm confused why it exists at all.
		I.obj_integrity *= 0.2
		I.update_icon()

	// Remove the timer reference
	repair_timers -= I

/obj/effect/proc_holder/spell/invoked/mark_target
	name = "Mark Target"
	desc = "Marks a target for pursuit, making them visible through walls with a special outline. Right-click to mark a random valid target."
	releasedrain = 75
	chargedrain = 1
	chargetime = 1.5 SECONDS
	recharge_time = 35 MINUTES
	overlay_state = "mark"
	invocations = list("Signum persequendi!")
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

/obj/effect/proc_holder/spell/invoked/mark_target/Destroy()
	remove_mark()
	return ..()

/obj/effect/proc_holder/spell/invoked/mark_target/cast(list/targets, mob/user)
	var/mob/living/target = targets[1]

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

	if(target != user)
		to_chat(user, span_warning("[user] traces a glowing symbol in the air指向 [target]."), 
							 span_notice("You mark [target] for pursuit."))

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
