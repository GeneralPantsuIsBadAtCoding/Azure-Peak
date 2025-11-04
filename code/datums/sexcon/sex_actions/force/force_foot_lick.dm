/datum/sex_action/force_foot_lick
	name = "Заставить вылизать ножки"
	check_same_tile = FALSE
	require_grab = TRUE
	stamina_cost = 1.0
	target_sex_part = SEX_PART_JAWS

/datum/sex_action/force_foot_lick/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
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

/datum/sex_action/force_foot_lick/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
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
	if(!check_location_accessible(user, user, BODY_ZONE_PRECISE_L_FOOT) && !check_location_accessible(user, user, BODY_ZONE_PRECISE_R_FOOT))
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	return TRUE

/datum/sex_action/force_foot_lick/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] упирает ступни в собственную голову!"))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] упирает ступни в оторванную голову [target]!"))
			else
				user.visible_message(span_warning("[user] упирает ступни в лицо [target]!"))
		else
			user.visible_message(span_warning("[user] упирает ступни в лицо [target]!"))

/datum/sex_action/force_foot_lick/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] вылизывает собственной же головой свои ножки."))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] заставляет оторванную голову [target] вылизывать ножки."))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] заставляет [target] вылизывать ножки."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] заставляет [target] вылизывать ножки."))
	target.make_sucking_noise()

/datum/sex_action/force_foot_lick/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] убирает ножки с собственной головы."))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] убирает ножки с оторванной головы [target]."))
			else
				user.visible_message(span_warning("[user] убирает ножки с лика [target]."))
		else
			user.visible_message(span_warning("[user] убирает ножки с лика [target]."))
