/datum/outfit/job/roguetown/guildmaster/basic/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/twilight_firearms, 2, TRUE)
