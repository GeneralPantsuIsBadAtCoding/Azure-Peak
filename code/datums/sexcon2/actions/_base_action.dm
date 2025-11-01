/datum/sex_session_lock
	var/mob/living/locked_host
	var/locked_organ_slot
	var/obj/item/locked_item

/datum/sex_session_lock/New(mob/_host, _locked_slot, obj/item/_locked_item)
	. = ..()
	locked_host = _host
	locked_organ_slot = _locked_slot
	locked_item = _locked_item
	LAZYADD(GLOB.locked_sex_objects, src)

/datum/sex_session_lock/Destroy(force, ...)
	. = ..()
	LAZYREMOVE(GLOB.locked_sex_objects, src)
	locked_host = null
	locked_item = null

/datum/storage_tracking_entry
	var/obj/item/stored_item = null
	var/mob/living/carbon/human/original_owner = null
	var/insertion_time = null
	var/hole_id = null
	var/stored_by_ckey = null

/datum/storage_tracking_entry/New(obj/item/item, mob/living/carbon/human/owner, hole_id_param, mob/living/carbon/human/stored_by)
	stored_item = item
	original_owner = owner
	insertion_time = world.time
	hole_id = hole_id_param
	if(stored_by?.ckey)
		stored_by_ckey = stored_by.ckey

/datum/storage_tracking_entry/Destroy()
	stored_item = null
	original_owner = null
	return ..()


/datum/sex_action
	abstract_type = /datum/sex_action

	/// Display name of the action
	var/name = "Generic Action"
	///Description for hover
	var/description = "Generic desc"

	/// Whether this action can continue indefinitely
	var/continous = TRUE
	/// How long each iteration takes
	var/do_time = 3.3 SECONDS
	/// Stamina cost per iteration
	var/stamina_cost = 0.5
	/// Whether to check if user is incapacitated
	var/check_incapacitated = TRUE
	/// Whether participants must be on same tile
	var/check_same_tile = TRUE
	/// Whether this requires a grab
	var/require_grab = FALSE
	/// Minimum grab state required
	var/required_grab_state = GRAB_PASSIVE
	/// Whether aggressive grab bypasses same tile requirement
	var/aggro_grab_instead_same_tile = FALSE
	/// Whether this action requires hole storage integration
	var/requires_hole_storage = FALSE
	/// What hole ID this action uses (if any)
	var/hole_id = null
	/// What item type this action stores in the hole
	var/atom/stored_item_type = null
	/// Custom item name for the stored object
	var/stored_item_name = null
	/// Storage tracking for this action
	var/list/datum/storage_tracking_entry/tracked_storage = list()
	///this is a list of locks we created to prevent penis portal powers
	var/list/datum/sex_session_lock/sex_locks = list()
	///this is the priority of our action for the target so when ejaculate messages are looked at its highest priority
	var/target_priority = 10
	///this is the priority of our action for the user
	var/user_priority = 10
	/// Whether this action supports knotting on climax
	var/knot_on_finish = FALSE
	/// Whether this action can trigger knots
	var/can_knot = FALSE
	///basically for actions being done by the user where the target is the inserter set this to true
	var/flipped = FALSE

/datum/sex_action/Destroy()
	// Clean up any tracked storage entries
	for(var/datum/storage_tracking_entry/entry in tracked_storage)
		qdel(entry)
	tracked_storage.Cut()

	for(var/datum/sex_session_lock/lock in sex_locks)
		qdel(lock)
	sex_locks.Cut()

	return ..()

/datum/sex_action/proc/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return TRUE

/datum/sex_action/proc/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	SHOULD_CALL_PARENT(TRUE)
	if(requires_hole_storage)
		if(!check_hole_storage_available(target, user))
			return FALSE
	return TRUE

/datum/sex_action/proc/try_knot_on_climax(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!knot_on_finish)
		return FALSE
	if(!can_knot)
		return FALSE

	var/datum/sex_session/session = get_sex_session(user, target)
	if(!session)
		return FALSE
	return SEND_SIGNAL(user, COMSIG_SEX_TRY_KNOT, target, session.force)

/datum/sex_action/proc/check_location_accessible(mob/living/carbon/human/user, mob/living/carbon/human/target, location = BODY_ZONE_CHEST, grabs = FALSE, skipundies = TRUE)
	var/obj/item/bodypart/bodypart = target.get_bodypart(location)
	var/self_target = FALSE
	if(target == user)
		self_target = TRUE

	if(!bodypart)
		return FALSE

	if(src.check_same_tile && (user != target || self_target))
		var/same_tile = (get_turf(user) == get_turf(target))
		var/grab_bypass = (src.aggro_grab_instead_same_tile && user.get_highest_grab_state_on(target) == GRAB_AGGRESSIVE)
		if(!same_tile && !grab_bypass)
			return FALSE

	if(src.require_grab && (user != target || self_target))
		var/grabstate = user.get_highest_grab_state_on(target)
		if((grabstate == null || grabstate < src.required_grab_state))
			return FALSE

	var/result = get_location_accessible(target, location = location, grabs = grabs, skipundies = skipundies)
	return result

/datum/sex_action/proc/check_hole_storage_available(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(!hole_id || !stored_item_type)
		return TRUE // No storage requirements

	// Check if target has hole storage component
	var/datum/component/hole_storage/storage_comp = target.GetComponent(/datum/component/hole_storage)
	if(!storage_comp)
		return FALSE

	// Create the item we want to store for testing
	var/obj/item/item_to_test
	if(stored_item_type == /obj/item/organ/genitals/penis)
		// Get user's penis and create fake variant for testing
		var/obj/item/organ/genitals/penis/user_penis = get_users_penis(user)
		if(!user_penis)
			return FALSE
		item_to_test = user_penis.create_fake_variant(user)
	else
		item_to_test = new stored_item_type()
		if(stored_item_name)
			item_to_test.name = stored_item_name

	// Check if the specific hole can fit our item
	var/can_fit = SEND_SIGNAL(target, COMSIG_HOLE_TRY_FIT, item_to_test, hole_id, user, TRUE) // Silent check

	// Clean up test item
	qdel(item_to_test)

	return can_fit

/datum/sex_action/proc/get_users_penis(mob/living/carbon/human/user)
	if(!user)
		return null
	return user.getorganslot(ORGAN_SLOT_PENIS)

/datum/sex_action/proc/try_store_in_hole(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!requires_hole_storage || !hole_id || !stored_item_type)
		return TRUE

	var/obj/item/item_to_store

	// Handle penis storage specially - create fake variant
	if(stored_item_type == /obj/item/organ/genitals/penis)
		var/obj/item/organ/genitals/penis/user_penis = get_users_penis(user)
		if(!user_penis)
			to_chat(user, span_warning("You don't have a penis to use!"))
			return FALSE

		// Create fake variant instead of removing real penis
		item_to_store = user_penis.create_fake_variant(user)
	else
		// Create the item to store
		item_to_store = new stored_item_type()
		if(stored_item_name)
			item_to_store.name = stored_item_name

	// Try to fit it in the hole
	var/success = SEND_SIGNAL(target, COMSIG_HOLE_TRY_FIT, item_to_store, hole_id, user, FALSE)
	if(!success)
		qdel(item_to_store)
		to_chat(user, span_warning("[target]'s [hole_id] can't accommodate [item_to_store.name]!"))
		return FALSE

	// Track the storage
	var/datum/storage_tracking_entry/entry = new(item_to_store, user, hole_id, user)
	tracked_storage += entry

	return TRUE

/datum/sex_action/proc/remove_from_hole(mob/living/carbon/human/user, mob/living/carbon/human/target, silent = FALSE)
	if(!requires_hole_storage || !hole_id)
		return TRUE

	for(var/datum/storage_tracking_entry/entry in tracked_storage)
		if(entry.hole_id == hole_id && entry.stored_item)
			var/obj/item/stored_item = entry.stored_item

			SEND_SIGNAL(target, COMSIG_HOLE_REMOVE_ITEM, stored_item, hole_id)

			if(istype(stored_item, /obj/item/penis_fake))
				var/obj/item/penis_fake/fake_penis = stored_item
				var/mob/living/carbon/human/original_owner = find_original_owner_by_ckey(fake_penis.original_owner_ckey)

				if(!silent)
					if(original_owner)
						to_chat(original_owner, span_notice("Your penis has been withdrawn from [target]'s [hole_id]."))
						if(original_owner != user)
							to_chat(user, span_notice("Withdrew [original_owner.name]'s penis from [target]'s [hole_id]."))
					else
						to_chat(user, span_notice("Withdrew penis from [target]'s [hole_id]."))
				qdel(stored_item)
			else
				if(!silent)
					to_chat(user, span_notice("Removed [stored_item.name] from [target]'s [hole_id]."))
				qdel(stored_item)

			tracked_storage -= entry
			qdel(entry)

	return TRUE

/datum/sex_action/proc/find_original_owner_by_ckey(target_ckey)
	if(!target_ckey)
		return null

	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(H.ckey == target_ckey)
			return H

	return null

/datum/sex_action/proc/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	SHOULD_CALL_PARENT(TRUE)
	if(requires_hole_storage)
		if(flipped)
			if(!try_store_in_hole(target, user))
				return FALSE
		else
			if(!try_store_in_hole(user, target))
				return FALSE
	lock_sex_object(user, target)
	return TRUE

/datum/sex_action/proc/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return

/datum/sex_action/proc/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	SHOULD_CALL_PARENT(TRUE)
	if(requires_hole_storage)
		if(flipped)
			remove_from_hole(target, user)
		else
			remove_from_hole(user, target)
	unlock_sex_object(user, target)
	return

/datum/sex_action/proc/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	if(sex_session.finished_check())
		return TRUE
	return FALSE


/datum/sex_action/proc/lock_sex_object(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return FALSE

/datum/sex_action/proc/unlock_sex_object(mob/living/carbon/human/user, mob/living/carbon/human/target)
	for(var/datum/sex_session_lock/lock as anything in sex_locks)
		qdel(lock)
	sex_locks.Cut()

/datum/sex_action/proc/handle_climax_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return

/datum/sex_action/proc/check_sex_lock(mob/locked, organ_slot, obj/item/item)
	if(!organ_slot && !item)
		return FALSE
	for(var/datum/sex_session_lock/lock as anything in GLOB.locked_sex_objects)
		if(lock in sex_locks)
			continue
		if(lock.locked_host != locked)
			continue
		if(lock.locked_item != item && lock.locked_organ_slot != organ_slot)
			continue
		return TRUE
	return FALSE


/datum/sex_action/proc/do_onomatopoeia(mob/living/carbon/human/user)
	user.balloon_alert_to_viewers("Plap!", alpha = rand(100, 200), x_offset = rand(-15, 15), y_offset = rand(0, 25), size = 0.8)

/datum/sex_action/proc/show_sex_effects(mob/living/carbon/human/user)
	for(var/i in 1 to rand(1, 3))
		if(!user.cmode) // Combat mode
			new /obj/effect/temp_visual/heart/sex_effects(get_turf(user))
		else
			new /obj/effect/temp_visual/heart/sex_effects/red_heart(get_turf(user))

