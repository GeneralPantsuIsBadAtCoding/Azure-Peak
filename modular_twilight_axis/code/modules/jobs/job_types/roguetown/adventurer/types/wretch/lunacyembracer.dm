/datum/advclass/wretch/lunacyembracer
	name = "Lunacy Embracer"
	tutorial = "You have rejected and terrorized civilization in the name of nature. You run wild under the moon, a terror to the townsfolk and a champion of Dendor's wild domain."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/lunacyembracer
	category_tags = list(CTAG_WRETCH)
	maximum_possible_slots = 1

/datum/outfit/job/roguetown/wretch/lunacyembracer/pre_equip(mob/living/carbon/human/H)
	H.set_patron(/datum/patron/divine/dendor)
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T3, passive_gain = CLERIC_REGEN_MAJOR)
	neck = /obj/item/clothing/neck/roguetown/psicross/dendor

	ADD_TRAIT(H, TRAIT_NUDIST, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STRONGBITE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_WOODWALKER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HERESIARCH, TRAIT_GENERIC)

	H.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/fishing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, SKILL_LEVEL_EXPERT, TRUE)

	H.change_stat("strength", 3)
	H.change_stat("willpower", 2)
	H.change_stat("constitution", 2)
	H.change_stat("speed", 2)
	H.change_stat("fortune", 2) //nature smiles at me!
	H.change_stat("intelligence", -2)
	H.change_stat("perception", -2)
	H.cmode_music = 'modular_twilight_axis/sound/music/combat_berserker.ogg'
	to_chat(H, span_danger("You have abandoned your humanity to run wild under the moon. The call of nature fills your soul!"))
	wretch_select_bounty(H)
