/datum/surgery_step/teeth_replacement
	name = "Teeth replacement"
	time = 1 SECONDS
	accept_hand = TRUE
	accept_any_item = FALSE
	possible_locs = list(
		BODY_ZONE_PRECISE_MOUTH
	)
	lying_required = TRUE
	self_operable = TRUE
	skill_min = SKILL_LEVEL_JOURNEYMAN
	skill_median = SKILL_LEVEL_EXPERT
	surgery_flags = SURGERY_BLOODY
	implements_speed = null
	implements = null

/datum/surgery_step/teeth_replacement/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/human/H = target
	if(!istype(H))
		return FALSE

	var/obj/item/bodypart/head/head = H.get_bodypart(check_zone(target_zone))
	if(!istype(head))
		return FALSE

	if(head?.get_teeth_count() >= head.max_teeth_count)
		to_chat(user, span_notice("They aren't missing any teeth!"))
		return FALSE

/datum/surgery_step/teeth_replacement/tool_check(mob/user, obj/item/tool)
	..() // FUCK U - Halford
	if(!istype(tool, /obj/item/natural/tooth))
		return FALSE

	return TRUE

/datum/surgery_step/teeth_replacement/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	var/obj/item/bodypart/head/head = target.get_bodypart(check_zone(target_zone))
	if(!istype(head))
		return FALSE

	if(head?.get_teeth_count() >= head.max_teeth_count)
		return FALSE

	display_results(user, target, span_notice("I successfully install \the [tool] in [target]'s mouth!."),
		span_notice("[user] successfully installs \the [tool] in [target]'s mouth!"),
		span_notice("[user] successfully installs \the [tool] in [target]'s mouth!"))
	head.teeth_types[tool.type]++
	user.dropItemToGround(tool, TRUE, TRUE)
	qdel(tool)
	return TRUE

/datum/surgery_step/teeth_punching
	name = "Teeth punching"
	time = 2 SECONDS
	accept_hand = TRUE
	accept_any_item = FALSE
	possible_locs = list(
		BODY_ZONE_PRECISE_MOUTH
	)
	lying_required = FALSE
	self_operable = TRUE
	skill_min = SKILL_LEVEL_NONE
	skill_median = SKILL_LEVEL_NONE
	surgery_flags = SURGERY_BLOODY
	implements = list(TOOL_TOOTHSETTER = 100)
	implements_speed = list(TOOTH_SETTER = 1)

/datum/surgery_step/teeth_punching/tool_check(mob/user, obj/item/tool)
	. = ..()
	var/obj/item/rogueweapon/surgery/toothsetter/setter = tool
	if(!istype(setter))
		return FALSE

	if(setter.get_teeth_count() <= 0)
		return FALSE

	if(!setter.selected_tooth_type || !setter.teeth_types[setter.selected_tooth_type] || setter.teeth_types[setter.selected_tooth_type] <= 0)
		to_chat(user, span_danger("\The [setter] has no teeth of this type loaded!"))
		return FALSE

	return setter.tool_behaviour

/datum/surgery_step/teeth_punching/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/human/H = target
	if(!istype(H))
		return FALSE

	var/obj/item/bodypart/head/head = H.get_bodypart(check_zone(target_zone))
	if(!istype(head))
		return FALSE

	if(head?.get_teeth_count() >= head.max_teeth_count)
		to_chat(user, span_notice("They aren't missing any teeth!"))
		return FALSE

/datum/surgery_step/teeth_punching/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	var/obj/item/bodypart/head/head = target.get_bodypart(check_zone(target_zone))
	var/obj/item/rogueweapon/surgery/toothsetter/setter = tool
	if(!istype(head))
		return FALSE

	if(!setter.selected_tooth_type || !setter.teeth_types[setter.selected_tooth_type] || setter.teeth_types[setter.selected_tooth_type] <= 0)
		return FALSE

	if(head?.get_teeth_count() >= head.max_teeth_count)
		return FALSE

	display_results(user, target, span_notice("I successfully punches \the [tool] in [target]'s gumline!."),
		span_notice("[user] successfully punches \the [tool] in [target]'s gumline!"),
		span_notice("[user] successfully punches \the [tool] in [target]'s gumline!"))
	if(!target.has_status_effect(/datum/status_effect/buff/drunk) || !HAS_TRAIT(target, TRAIT_NOPAIN))
		target.flash_fullscreen("redflash1")
		target.stuttering += 5
	head.teeth_types[setter.selected_tooth_type]++
	setter.teeth_types[setter.selected_tooth_type]--
	setter.update_icon()
	return TRUE
