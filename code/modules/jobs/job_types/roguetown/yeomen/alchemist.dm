/datum/job/roguetown/alchemist
	title = "Alchemist"
	flag = ALCHEMIST
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0

	allowed_races = RACES_ALL_KINDS

	tutorial = "You came to Azure Peak after hearing that there is a lack of potion-makers outside of the nobility. Stir up potions with your alchemy expertise--whether of health or death."

	outfit = /datum/outfit/job/roguetown/alchemist
	display_order = 6
	give_bank_account = 12
	min_pq = -3
	max_pq = null

/datum/outfit/job/roguetown/alchemist
	name = "Alchemist"
	jobtype = /datum/job/roguetown/alchemist

/datum/outfit/job/roguetown/alchemist/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 6, TRUE)
		else
			H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 5, TRUE)
//Requires a lot of sprites, so this is just a placeholder
	if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/trou
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		cloak = /obj/item/clothing/cloak/apron/brown
		H.change_stat("intelligence", 3)
		H.change_stat("speed", -1)
	else if(should_wear_femme_clothes(H))
		pants = /obj/item/clothing/under/roguetown/trou
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		cloak = /obj/item/clothing/cloak/apron/brown
		H.change_stat("intelligence", 2)
		H.change_stat("speed", -2)
