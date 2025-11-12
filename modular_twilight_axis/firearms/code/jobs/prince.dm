/datum/outfit/job/roguetown/heir/daring/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.adjust_skillrank(/datum/skill/combat/twilight_firearms, 2, TRUE)
