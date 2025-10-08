// Currently the only multi-behavior quirk & the only interaction quirk
// May refactor territorial to be similar later
/datum/flesh_quirk/hoarder
	name = "Hoarder"
	rarity = 1000
	description = "Constantly wants to acquire new items"
	quirk_type = QUIRK_INTERACT | QUIRK_BEHAVIOR | QUIRK_ENVIRONMENT

	var/value_current = 5
	var/value_increment = 2
	var/value_cap = 20

	var/theft_cooldown = 20 MINUTES
	var/next_theft = 0

/datum/flesh_quirk/hoarder/apply_behavior_quirk(score, mob/speaker, message, datum/component/chimeric_heart_beast/beast)
	// if happy, may not demand another item
	if(score >= 75 && prob(50))
		return score
	else
		beast.satisfied = FALSE
		return score

/datum/flesh_quirk/hoarder/apply_environment_quirk(list/visible_turfs, datum/component/chimeric_heart_beast/beast)
	return null

/datum/flesh_quirk/hoarder/apply_item_interaction_quirk(obj/item/I, mob/user, datum/component/chimeric_heart_beast/beast)
	// It can, and will get all the coin it wants itself, this is to challenge players
	if(istype(I, /obj/item/roguecoin))
		beast.heart_beast.visible_message(span_warning("[beast.heart_beast] seems to find the raw coin boring!"))
		return FALSE

	if(I.sellprice < value_current)
		beast.heart_beast.visible_message(span_warning("[beast.heart_beast] seems unimpressed!"))
		return FALSE

	beast.happiness = min(beast.happiness + (beast.max_happiness * 0.20), beast.max_happiness)
	value_current = min(value_current + value_increment, value_cap)

	I.AddComponent(/datum/component/hoarded_item, beast)
	beast.heart_beast.visible_message(span_notice("[beast.heart_beast] hoards the item with its tentacles."))

	// We'll calculate this each time just in case someone silly moves the heartbeast (please don't)
	var/turf/center_turf = get_turf(beast.heart_beast)
	var/turf/T_left = locate(center_turf.x - 1, center_turf.y - 1, center_turf.z)
	var/turf/T_center = locate(center_turf.x, center_turf.y - 1, center_turf.z)
	var/turf/T_right = locate(center_turf.x + 1, center_turf.y - 1, center_turf.z)
	var/list/possible_locs = list(T_left, T_center, T_right)
	var/turf/new_loc = pick(possible_locs)
	user.transferItemToLoc(I, new_loc, TRUE)
	beast.satisfied = TRUE

	return TRUE

/datum/flesh_quirk/hoarder/proc/handle_thief(obj/item/I, mob/living/user, datum/component/chimeric_heart_beast/beast)
	user.apply_status_effect(/datum/status_effect/territorial_rage, beast.heart_beast)
	beast.heart_beast.visible_message(span_userdanger("Tendrils from [beast.heart_beast] lash out at [user]!"))

/datum/component/hoarded_item
	var/datum/component/chimeric_heart_beast/heart_component
	var/datum/flesh_quirk/hoarder/hoarder_quirk
	var/mob/living/current_holder

/datum/component/hoarded_item/Initialize(datum/component/chimeric_heart_beast/heart)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	heart_component = heart
	RegisterSignal(parent, COMSIG_ITEM_PICKUP, .proc/on_pickup)
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/on_moved)
	RegisterSignal(parent, COMSIG_MOVABLE_POST_THROW, .proc/on_post_throw)

	// Find the hoarder quirk in the heart component
	hoarder_quirk = heart_component.active_quirks[/datum/flesh_quirk/hoarder]

	if(!hoarder_quirk)
		return COMPONENT_INCOMPATIBLE

/datum/component/hoarded_item/proc/on_pickup(datum/source, mob/user)
	SIGNAL_HANDLER
	var/obj/item/I = parent
	to_chat(world, span_danger("[get_dist(I, heart_component.heart_beast)] DISTANCE - PICKUP"))
	if(get_dist(I, heart_component.heart_beast) > 3)
		hoarder_quirk.handle_thief(I, user, heart_component)
		qdel(src)
		return

	current_holder = user
	RegisterSignal(current_holder, COMSIG_MOVABLE_MOVED, .proc/on_holder_moved)

/datum/component/hoarded_item/proc/on_moved(datum/source, atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	SIGNAL_HANDLER
	var/obj/item/I = parent
	// Only care if it's moved from the heart beast's location
	to_chat(world, span_danger("[get_dist(I, heart_component.heart_beast)] DISTANCE - MOVED"))
	if(get_dist(I, heart_component.heart_beast) > 3)
		var/mob/living/thief = null
		var/list/potential_targets = list()

		// First see if the thief is currently holding us
		if(ismob(I.loc))
			var/mob/M = I.loc
			if(isliving(M))
				thief = M

		if(!thief)
			// Get all living mobs within 2 tiles of our current turf
			var/turf/current_turf = get_turf(I)
			if(current_turf)
				for(var/atom/movable/A in range(2, current_turf))
					if(isliving(A))
						mob/living/L = A
						if(L.stat != DEAD)
							potential_targets += A
			if(potential_targets.len)
				thief = pick(potential_targets)
		if(thief)
			hoarder_quirk.handle_thief(I, thief, heart_component)
			qdel(src)

/datum/component/hoarded_item/proc/on_holder_moved(datum/source, atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	SIGNAL_HANDLER
	var/obj/item/I = parent

	// it's a good safety check
	if(I.loc != current_holder)
		UnregisterSignal(current_holder, COMSIG_MOVABLE_MOVED, .proc/on_holder_moved)
		current_holder = null
		return

	if(get_dist(source, heart_component.heart_beast) > 3)
		hoarder_quirk.handle_thief(I, current_holder, heart_component)
		UnregisterSignal(current_holder, COMSIG_MOVABLE_MOVED, .proc/on_holder_moved)
		qdel(src)

/datum/component/hoarded_item/proc/on_post_throw(datum/source, datum/thrownthing/TT, spin)
	SIGNAL_HANDLER
	var/obj/item/I = parent
	var/mob/living/thief = TT.thrower 

	if(isliving(thief))
		hoarder_quirk.handle_thief(I, thief, heart_component)
		qdel(src)
		return TRUE
	return FALSE

/datum/component/hoarded_item/proc/is_item_stolen(obj/item/I)
	if(get_dist(I, heart_component.heart_beast) > 3)
		return TRUE

	if(istype(I.loc, /obj/item/storage/roguebag))
		return TRUE

	if(istype(I.loc, /obj/structure/closet))
		return TRUE
	
	// Further checks are handled by the movable on the mob itself
	return FALSE
