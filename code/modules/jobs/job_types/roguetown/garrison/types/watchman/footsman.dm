/datum/advclass/watchman/footsman
	name = "Watch Footsman"
	tutorial = "You are a footsman of the Town Watch. Well versed in various close-quarters weapons and aprehending street-savy criminals."
	outfit = /datum/outfit/job/roguetown/guardsman/footsman

	category_tags = list(CTAG_WATCH)

/datum/outfit/job/roguetown/guardsman/footsman/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 1, TRUE) 
	H.change_stat("strength", 2)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("speed", 1)

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)	//You get medium armor training to go with your armor.

	head = /obj/item/clothing/head/roguetown/helmet
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	beltr = /obj/item/rogueweapon/mace/cudgel
	backr = /obj/item/rogueweapon/shield/wood		//Maybe give a buckler? Gave wood because 40 coverage is better than 10 but dunno.
	backr = /obj/item/storage/backpack/rogue/satchel/black
	beltl = /obj/item/storage/keyring/guardcastle
	belt = /obj/item/storage/belt/rogue/leather/black
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel = 1,
		/obj/item/rope/chain = 1,
		)
	H.verbs |= /mob/proc/haltyell
