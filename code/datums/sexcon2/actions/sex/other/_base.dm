/datum/sex_action/sex/other
	abstract_type = /datum/sex_action/sex/other
	target_priority = 100
	user_priority = 0
	flipped = TRUE

/datum/sex_action/sex/other/try_knot_on_climax(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!knot_on_finish)
		return FALSE
	if(!can_knot)
		return FALSE

	var/datum/sex_session/session = get_sex_session(user, target)
	if(!session)
		return FALSE
	return SEND_SIGNAL(target, COMSIG_SEX_TRY_KNOT, user, session.force)

/datum/sex_action/sex/other/lock_sex_object(mob/living/carbon/human/user, mob/living/carbon/human/target)
	sex_locks |= new /datum/sex_session_lock(target, ORGAN_SLOT_PENIS)


/datum/sex_action/sex/other/check_hole_storage_available(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(!hole_id || !stored_item_type)
		return TRUE // No storage requirements

	// Check if target has hole storage component
	var/datum/component/hole_storage/storage_comp = user.GetComponent(/datum/component/hole_storage)
	if(!storage_comp)
		return FALSE

	// Create the item we want to store for testing
	var/obj/item/item_to_test
	if(stored_item_type == /obj/item/organ/genitals/penis)
		// Get user's penis and create fake variant for testing
		var/obj/item/organ/genitals/penis/user_penis = get_users_penis(target)
		if(!user_penis)
			return FALSE
		item_to_test = user_penis.create_fake_variant(target)
	else
		item_to_test = new stored_item_type()
		if(stored_item_name)
			item_to_test.name = stored_item_name

	// Check if the specific hole can fit our item
	var/can_fit = SEND_SIGNAL(user, COMSIG_HOLE_TRY_FIT, item_to_test, hole_id, target, TRUE) // Silent check

	// Clean up test item
	qdel(item_to_test)

	return can_fit
