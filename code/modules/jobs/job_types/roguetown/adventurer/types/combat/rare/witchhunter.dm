
/datum/advclass/puritan
	name = "Witch Hunter"
	tutorial = "Witch Hunters belong to a special sect of the One-God Church that believe all magyk \
	use is inherently sinful. They are extremely devoted to hunting necromancers and often preach \
	to magyk users to end their sinful ways."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/puritan
	traits_applied = list(TRAIT_MEDIUMARMOR)
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/puritan
	allowed_patrons = list(/datum/patron/old_god)

/datum/outfit/job/roguetown/adventurer/puritan/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/psicross/silver
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/tights/black
	cloak = /obj/item/clothing/cloak/cape/puritan
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	head = /obj/item/clothing/head/roguetown/puritan
	gloves = /obj/item/clothing/gloves/roguetown/leather
	beltl = /obj/item/rogueweapon/sword/rapier
	backl = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/silver = 1)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/tracking, 1, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)
		H.change_stat("constitution", 1)
		H.change_stat("perception", 2)
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
	H.verbs |= /mob/living/carbon/human/proc/faith_test

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
