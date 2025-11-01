/datum/sex_action/force_cunnilingus
	name = "Заставить отлизать"
	require_grab = TRUE
	stamina_cost = 1.0
	user_sex_part = SEX_PART_CUNT
	target_sex_part = SEX_PART_JAWS

/datum/sex_action/force_cunnilingus/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
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
	if(!user.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	return TRUE

/datum/sex_action/force_cunnilingus/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
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
	if(!user.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	return TRUE

/datum/sex_action/force_cunnilingus/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(isdullahan(user))
		var/datum/species/dullahan/dullahan = user.dna.species
		if(dullahan.headless)
			user.visible_message(span_warning("[user] вжимает нос собственной головы в свою киску!"))
		else
			user.visible_message(span_warning("[user] вжимает носом [target] в свою киску!"))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] вжимает носом оторванной головы [target] в свою киску!"))
			else
				user.visible_message(span_warning("[user] вжимает носом [target] в свою киску!"))
		else
			user.visible_message(span_warning("[user] вжимает носом [target] в свою киску!"))

/datum/sex_action/force_cunnilingus/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(isdullahan(user))
		var/datum/species/dullahan/dullahan = user.dna.species
		if(dullahan.headless)
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] вылизывает собственную киску своей оторванной головой."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] заставляет [target] отлизать свою киску."))
			target.sexcon.do_thrust_animate(user)
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] заставляет оторванную голову [target] отлизать свою киску."))
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] заставляет [target] отлизать свою киску."))
				target.sexcon.do_thrust_animate(user)
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] заставляет [target] отлизать свою киску."))
			target.sexcon.do_thrust_animate(user)

	target.make_sucking_noise()

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 0, 2, FALSE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/force_cunnilingus/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(isdullahan(user))
		var/datum/species/dullahan/dullahan = user.dna.species
		if(dullahan.headless)
			user.visible_message(span_warning("[user] убирает собственную голову от своей промежности."))
		else
			user.visible_message(span_warning("[user] освобождает лик [target] от своей промежности."))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] освобождает оторванную голову [target] от своей промежности."))
			else
				user.visible_message(span_warning("[user] освобождает лик [target] от своей промежности."))
		else
			user.visible_message(span_warning("[user] освобождает лик [target] от своей промежности."))

/datum/sex_action/force_cunnilingus/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
