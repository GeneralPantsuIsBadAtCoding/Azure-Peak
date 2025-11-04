/datum/sex_action/force_armpit_nuzzle
	name = "Прижать к своим подмыхам"
	require_grab = TRUE
	stamina_cost = 1.0
	target_sex_part = SEX_PART_JAWS

/datum/sex_action/force_armpit_nuzzle/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				return TRUE
		else
			return FALSE
	if(isdullahan(target))
		var/datum/species/dullahan/dullahan = target.dna.species
		if(dullahan.headless)
			return TRUE
	return TRUE

/datum/sex_action/force_armpit_nuzzle/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				return TRUE
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
	if(!check_location_accessible(user, user, BODY_ZONE_CHEST, TRUE))
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	return TRUE

/datum/sex_action/force_armpit_nuzzle/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] силой прижимает собственную голову к своему подплечию!"))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] силой прижимает оторванную голову [target] к своему подплечию!"))
			else
				user.visible_message(span_warning("[user] силой прижимает голову [target] к своему подплечию!"))
		else
			user.visible_message(span_warning("[user] силой прижимает голову [target] к своему подплечию!"))

/datum/sex_action/force_armpit_nuzzle/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] вдавливает нос собственной оторванной головы в свою подмышку."))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] вдавливает нос оторванной головы [target] в свою подмышку."))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] вдавливает нос [target] в свою подмышку."))
				target.sexcon.do_thrust_animate(user)
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] вдавливает нос [target] в свою подмышку."))
			target.sexcon.do_thrust_animate(user)

	user.sexcon.perform_sex_action(user, 0.5, 0, TRUE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/force_armpit_nuzzle/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] убирает собственную голову от своего плеча."))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] убирает оторванную голову [target] от своего плеча."))
			else
				user.visible_message(span_warning("[user] отталкивает башню [target] от своего плеча."))
		else
			user.visible_message(span_warning("[user] отталкивает башню [target] от своего плеча."))

/datum/sex_action/force_armpit_nuzzle/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
