/datum/sex_action/force_blowjob
	name = "Заставить отсосать"
	stamina_cost = 1.0
	category = SEX_CATEGORY_PENETRATE
	user_sex_part = SEX_PART_COCK
	target_sex_part = SEX_PART_JAWS

/datum/sex_action/force_blowjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless)
				return TRUE
		else
			return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/force_blowjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
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
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!user.sexcon.can_use_penis())
		return FALSE
	return TRUE

/datum/sex_action/force_blowjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(isdullahan(user))
		var/datum/species/dullahan/dullahan = user.dna.species
		if(dullahan.headless)
			user.visible_message(span_warning("[user] прижимает свою оторванную голову себе к паху и заталкивает член прямо в рот!"))
		else
			user.visible_message(span_warning("[user] прижимает голову [target] к паху и заталкивает свой член прямо в рот!"))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] прижимает оторванную голову [target] к паху и заталкивает свой член прямо в рот!"))
			else
				user.visible_message(span_warning("[user] прижимает голову [target] к паху и заталкивает свой член прямо в рот!"))
		else
			user.visible_message(span_warning("[user] прижимает голову [target] к паху и заталкивает свой член прямо в рот!"))
	playsound(target, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/datum/sex_action/force_blowjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(isdullahan(user))
		var/datum/species/dullahan/dullahan = user.dna.species
		if(dullahan.headless)
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] насаживает свою собственную голову себе на член и проталкивает её до упора."))
			target.make_sucking_noise()
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] насаживает [target] на свой хер, проталкивая тот в глотку до упора."))
			target.make_sucking_noise()
			target.sexcon.do_thrust_animate(user)
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] насаживает оторванную голову [target] на свой член, проталкивая тот в глотку до упора."))
				target.make_sucking_noise()
			else
				user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] насаживает [target] на свой хер, проталкивая тот в глотку до упора."))
				target.make_sucking_noise()
				target.sexcon.do_thrust_animate(user)
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] насаживает [target] на свой хер, проталкивая тот в глотку до упора."))
			target.make_sucking_noise()
			target.sexcon.do_thrust_animate(user)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	if(user.sexcon.check_active_ejaculation())
		if(isdullahan(user))
			var/datum/species/dullahan/dullahan = user.dna.species
			if(dullahan.headless)
				user.visible_message(span_lovebold("[user] кончает прямо в собственную же глотку!"))
			else
				user.visible_message(span_lovebold("[user] кончает прямо в глотку [target]!"))
		else
			user.visible_message(span_lovebold("[user] кончает прямо в глотку [target]!"))
		user.sexcon.cum_into(oral = TRUE, splashed_user = target)

	user.sexcon.perform_sex_action(target, 0, 7, FALSE)
	if(!user.sexcon.considered_limp())
		user.sexcon.perform_deepthroat_oxyloss(target, 1.3)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/force_blowjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(isdullahan(user))
		var/datum/species/dullahan/dullahan = user.dna.species
		if(dullahan.headless)
			user.visible_message(span_warning("[user] вытаскивает свой хер из собственной же глотки."))
		else
			user.visible_message(span_warning("[user] вытаскивает свой хер из глотки [target]."))
	else
		if(isdullahan(target))
			var/datum/species/dullahan/dullahan = target.dna.species
			if(dullahan.headless && user.is_holding(dullahan.my_head))
				user.visible_message(span_warning("[user] вытаскивает свой хер из оторванной головы [target]."))
			else
				user.visible_message(span_warning("[user] вытаскивает свой хер из глотки [target]."))
		else
			user.visible_message(span_warning("[user] вытаскивает свой хер из глотки [target]."))

/datum/sex_action/force_blowjob/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
