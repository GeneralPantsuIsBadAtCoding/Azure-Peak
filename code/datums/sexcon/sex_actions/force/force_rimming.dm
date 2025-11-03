/datum/sex_action/force_rimming
	name = "Принудить к риммингу"
	stamina_cost = 1.0
	user_sex_part = SEX_PART_ANUS
	target_sex_part = SEX_PART_JAWS

/datum/sex_action/force_rimming/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless && !user.is_holding(dullahan.my_head))
				return FALSE
		else
			return FALSE
	if(isdullahan(target))
		var/datum/species/dullahan/dullahan = target.dna.species
		if(dullahan.headless)
			return TRUE
	if(user.sexcon.can_zodomize())
		return TRUE
	return FALSE

/datum/sex_action/force_rimming/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless && !user.is_holding(dullahan.my_head))
				return FALSE
		else
			return FALSE
	var/grabstate = user.get_highest_grab_state_on(target)
	if(isdullahan(user))
		var/datum/species/dullahan/dullahan = user.dna.species
		if(dullahan.headless && user.is_holding(dullahan.my_head))
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
	if(isdullahan(target))
		var/datum/species/dullahan/dullahan = target.dna.species
		if(dullahan.headless && user.is_holding(dullahan.my_head))
		else
			if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_MOUTH))
				return FALSE
	else
		if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_MOUTH))
			return FALSE
	return TRUE

/datum/sex_action/force_rimming/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] прижимает собственную голову к своему заду!"))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] прижимает оторванную голову [target] к своему заду!"))
			else
				user.visible_message(span_warning("[user] прижимает голову [target] к своему заду!"))
		else
			user.visible_message(span_warning("[user] прижимает голову [target] к своему заду!"))

/datum/sex_action/force_rimming/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] вдавливает рот собственной головы к своему анальному кольцу."))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] вдавливает рот оторванной головы [target] к своему анальному кольцу."))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] вдавливает рот [target] к своему анальному кольцу."))
				target.sexcon.do_thrust_animate(user)
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] вдавливает рот [target] к своему анальному кольцу."))
			target.sexcon.do_thrust_animate(user)
	target.make_sucking_noise()

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 0, 2, FALSE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/force_rimming/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] убирает собственную голову от своей задницы."))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] убирает оторванную голову [target] от своей задницы."))
			else
				user.visible_message(span_warning("[user] отпускает голову [target]."))
		else
			user.visible_message(span_warning("[user] отпускает голову [target]."))

/datum/sex_action/force_rimming/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
