/datum/mob_descriptor/defiant
	name = "Defiant"
	slot = MOB_DESCRIPTOR_SLOT_NOTHING
	verbage = "looks"
	describe = "defiant!"
	show_obscured = TRUE

/datum/mob_descriptor/defiant/can_describe(mob/living/described)
	if(!described.defiant)
		return FALSE
	return TRUE

/datum/mob_descriptor/defiant/can_user_see(mob/living/described, mob/user)
	// Always see if you yourself are
	if(user == described)
		return TRUE
	// Ghosts can see
	if(!isliving(user))
		return TRUE
	var/mob/living/living_user = user
	// Other defiants can not see
	if(living_user.defiant)
		return FALSE
	// Further than 2 tiles dont see it
	if(get_dist(described, living_user) > 2)
		return FALSE
	return TRUE
