/datum/sex_action/sex
	stored_item_type = /obj/item/organ/genitals/penis
	stored_item_name = "penetrating member"
	requires_hole_storage = TRUE
	abstract_type = /datum/sex_action/sex
	knot_on_finish = TRUE
	can_knot = TRUE
	user_priority = 100
	target_priority = 0

/datum/sex_action/sex/lock_sex_object(mob/living/carbon/human/user, mob/living/carbon/human/target)
	sex_locks |= new /datum/sex_session_lock(user, ORGAN_SLOT_PENIS)
