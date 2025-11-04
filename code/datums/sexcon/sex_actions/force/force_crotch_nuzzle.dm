/datum/sex_action/force_crotch_nuzzle
	name = "Прижать к паху"
	require_grab = TRUE
	stamina_cost = 1.0
	target_sex_part = SEX_PART_JAWS

/datum/sex_action/force_crotch_nuzzle/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless)
				return TRUE
		else
			return FALSE
	if(isdullahan(target))
		var/datum/species/dullahan/dullahan = target.dna.species
		if(dullahan.headless)
			return TRUE
	return TRUE

/datum/sex_action/force_crotch_nuzzle/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless)
				return TRUE
		else
			return FALSE
	var/grabstate = user.get_highest_grab_state_on(target)
	if(isdullahan(user))
		var/datum/species/dullahan/dullahan = user.dna.species
		if(dullahan.headless)
		else
			if(grabstate == null || grabstate < GRAB_AGGRESSIVE)
				return FALSE
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
			else
				if(grabstate == null || grabstate < GRAB_AGGRESSIVE)
					return FALSE
		else
			if(grabstate == null || grabstate < GRAB_AGGRESSIVE)
				return FALSE
	if(!check_location_accessible(user, user, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	return TRUE

/datum/sex_action/force_crotch_nuzzle/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(isdullahan(user))
		var/datum/species/dullahan/dullahan = user.dna.species
		if(dullahan.headless)
			user.visible_message(span_warning("[user] прижимает свою оторванную голову к паху!"))
		else
			user.visible_message(span_warning("[user] прижимает лицо [target] к своему лобку!"))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] прижимает оторванную голову [target] к своему паху!"))
			else
				user.visible_message(span_warning("[user] прижимает лицо [target] к своему лобку!"))
		else
			user.visible_message(span_warning("[user] прижимает лицо [target] к своему лобку!"))

/datum/sex_action/force_crotch_nuzzle/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(isdullahan(user))
		var/datum/species/dullahan/dullahan = user.dna.species
		if(dullahan.headless)
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] водит носом собственной головы по своему паху."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] водит носом [target] по своему паху."))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] водит носом оторванной головы [target] по своему паху."))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] водит носом [target] по своему паху."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] водит носом [target] по своему паху."))

	user.sexcon.perform_sex_action(user, 0.5, 0, TRUE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/force_crotch_nuzzle/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(isdullahan(user))
		var/datum/species/dullahan/dullahan = user.dna.species
		if(dullahan.headless)
			user.visible_message(span_warning("[user] убирает собственную голову от паха."))
		else
			user.visible_message(span_warning("[user] отталкивает личико [target] от своего лобка."))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] отталкивает оторванную голову [target] от своего паха."))
			else
				user.visible_message(span_warning("[user] отталкивает личико [target] от своего лобка."))
		else
			user.visible_message(span_warning("[user] отталкивает личико [target] от своего лобка."))

/datum/sex_action/force_crotch_nuzzle/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
