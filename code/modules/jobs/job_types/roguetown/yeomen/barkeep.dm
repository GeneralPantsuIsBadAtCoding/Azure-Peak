/datum/job/roguetown/barkeep
	title = "Innkeeper"
	flag = BARKEEP
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS

	tutorial = "Adventurers and warriors alike have two exit plans; the early grave or even earlier retirement. As the proud owner of this fine establishment, you took the latter: The Azurian Pint, tavern, inn, and bathhouse! You even have an assortment of staff to help you, and plenty of business from the famished townsfolk looking to eat, weary travelers looking to rest, and characters of dubious repute seeking their own sort of success. Your bladework has gotten a little rusty, and the church across the street gives you the odd evil eye for the extra 'delights' of the bathhouse--but, well...you can't win 'em all!"

	outfit = /datum/outfit/job/roguetown/barkeep
	display_order = JDO_BARKEEP
	give_bank_account = 43
	min_pq = -4
	max_pq = null
	round_contrib_points = 3

/datum/outfit/job/roguetown/barkeep/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	backr = /obj/item/storage/backpack/rogue/satchel
	cloak = /obj/item/clothing/cloak/apron/waist
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltr = /obj/item/storage/keyring/innkeep
	if(H.pronouns == SHE_HER || H.pronouns == THEY_THEM_F)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	H.change_stat("strength", 1)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEADEPT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC) // Guess they were a bard.
