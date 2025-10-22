/datum/sex_action/tailpegging_anal
	name = "Трахнуть зад хвостом"
	check_incapacitated = FALSE
	stamina_cost = 1.0
	category = SEX_CATEGORY_PENETRATE
	target_sex_part = SEX_PART_ANUS


/datum/sex_action/tailpegging_anal/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_TAIL))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_TAIL).can_penetrate)
		return FALSE
	return TRUE

/datum/sex_action/tailpegging_anal/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_TAIL))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_TAIL).can_penetrate)
		return FALSE
	return TRUE

/datum/sex_action/tailpegging_anal/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.visible_message(span_warning("[user] проскальзывает хвостиком прямиков в задницу [target]!"))
	playsound(target, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/datum/sex_action/tailpegging_anal/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] поступательными движениями, проталкивается глубже в попку [target] кончиком хвоста."))
	playsound(target, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	if(user.sexcon.considered_limp())
		user.sexcon.perform_sex_action(target, 1.2, 4, FALSE)
	else
		user.sexcon.perform_sex_action(target, 2.4, 9, FALSE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/tailpegging_anal/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.visible_message(span_warning("[user] освобождая отверстие [target], вываливает свой хвост."))
