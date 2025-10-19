/datum/virtue/combat/gunslinger
	name = "Grenadier Training"
	desc = "Back in the day I've been conscripted to serve in my liege's military campaign. Over that time, I've received some training in handling gunpowder weapons."
	custom_text = "+1 to Firearms, Up to Legendary, Minimum Apprentice. Does not affect classes that have Heavy Armor Training or Critical Resistance."
	added_stashed_items = list("Barker" = /obj/item/gun/ballistic/twilight_firearm/barker,
								"Ammo bag" = /obj/item/quiver/twilight_bullet/lead_ten,
								"Powderflask" = /obj/item/twilight_powderflask
	)

/datum/virtue/combat/gunslinger/apply_to_human(mob/living/carbon/human/recipient)
	if (!HAS_TRAIT(recipient, TRAIT_HEAVYARMOR) && !HAS_TRAIT(recipient, TRAIT_CRITICAL_RESISTANCE))
		if(recipient.get_skill_level(/datum/skill/combat/twilight_firearms) < SKILL_LEVEL_APPRENTICE)
			recipient.adjust_skillrank_up_to(/datum/skill/combat/twilight_firearms, SKILL_LEVEL_APPRENTICE, silent = TRUE)
		else
			added_skills = list(list(/datum/skill/combat/twilight_firearms, 1, 6))
