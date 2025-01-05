
/datum/surgery/cure_rot
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/burn_rot,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/burn_rot
	name = "burn rot"
	implements = list(
		TOOL_CAUTERY = 85,
		/obj/item/clothing/neck/roguetown/psicross = 85,
		TOOL_WELDER = 70,
		TOOL_HOT = 35,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 8 SECONDS
	surgery_flags = SURGERY_INCISED
	skill_min = SKILL_LEVEL_APPRENTICE
	preop_sound = 'sound/surgery/cautery1.ogg'
	success_sound = 'sound/surgery/cautery2.ogg'

/datum/surgery_step/burn_rot/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to burn the rot within [target]..."),
		span_notice("[user] begins to burn the rot from [target]'s heart."),
		span_notice("[user] begins to burn the rot from [target]'s heart."))
	return TRUE

// calls the remove_rot which is shared with the pestra prayer to remove rot
/datum/surgery_step/burn_rot/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	var/burndam = 20
	if(user.mind)
		burndam -= (user.mind.get_skill_level(/datum/skill/misc/medicine) * 3)

	if(remove_rot(target = target, user = user, method = "surgery", damage = burndam,
		success_message = "You burn away the rot inside of [target].",
		fail_message = "The surgery fails to remove the rot."))

		display_results(user, target, span_notice("You burn away the rot inside of [target]."),
		"[user] burns the rot within [target].",
		"[user] takes a [tool] to [target]'s innards.")

		return TRUE
	return TRUE
