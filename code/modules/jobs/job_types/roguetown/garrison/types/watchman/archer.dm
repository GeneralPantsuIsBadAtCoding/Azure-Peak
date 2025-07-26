/datum/advclass/watchman/archer
	name = "Watch Archer"
	tutorial = "You are an archer of the Town Watch. Once a hunter, now a man-hunter for your lord. Rooftops, bows, and daggers are your best friend."
	outfit = /datum/outfit/job/roguetown/guardsman/archer

	category_tags = list(CTAG_WATCH)

/datum/outfit/job/roguetown/guardsman/archer/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 5, TRUE)		//Why master? Because all it does is effect draw time, which is strength x skill / 1.2. (Bow is just skill / 1.0). You get poor bonus strength, so you get skill to offset.
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)		//Maybe take away? Leaving for now just as a fall-back for non-lethal ability.
	H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)	//For basic crafting; you'll need it due to relegated support role.
	H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)	//Likely hunter background; very crappy basic skill.
	H.adjust_skillrank(/datum/skill/misc/tracking, 1, TRUE) 
	H.change_stat("strength", 1)
	H.change_stat("perception", 2)
	H.change_stat("intelligence", 1)		//Gets some int for crafting + feinting, makes up for no medium armor training along with the speed.
	H.change_stat("constitution", 1)
	H.change_stat("speed", 2)

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)		//You don't get medium armor training, instead you get a bonus to light armor usage.

	head = /obj/item/clothing/head/roguetown/roguehood/red		//To-do: Make a guard hood come in kingdom's colors.
	armor = /obj/item/clothing/suit/roguetown/armor/leather		//So they get default-dodge expert usage.
	beltr = /obj/item/quiver/bolts
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	backr = /obj/item/storage/backpack/rogue/satchel/black
	beltl = /obj/item/storage/keyring/guardcastle
	belt = /obj/item/storage/belt/rogue/leather/black
	gloves = /obj/item/clothing/gloves/roguetown/leather
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel = 1,
		/obj/item/rope/chain = 1,
		)
	H.verbs |= /mob/proc/haltyell
