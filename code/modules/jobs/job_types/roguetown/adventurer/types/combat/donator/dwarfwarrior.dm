
/datum/advclass/dwarfwarrior
	name = "Cavern Warrior"
	tutorial = "Dwarf Warriors are the bread and butter of their miliary sworn to defend their mountain fortress. Armed with either a battle axe or mace, they are a force to be reckoned with."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/dwarf/mountain)
	outfit = /datum/outfit/job/roguetown/adventurer/dwarfwarrior

	traits_applied = list(TRAIT_HEAVYARMOR)
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/dwarfwarrior/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/winged
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backr = /obj/item/rogueweapon/shield/wood
	backl = /obj/item/storage/backpack/rogue/satchel
	mask = /obj/item/clothing/mask/rogue/facemask
	gloves = /obj/item/clothing/gloves/roguetown/chain
	if(prob(50))
		beltl = /obj/item/rogueweapon/mace/steel
	else if(prob(50))
		beltl = /obj/item/rogueweapon/stoneaxe/battle
	else
		r_hand = /obj/item/rogueweapon/halberd
		beltl = /obj/item/rogueweapon/huntingknife


	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1,, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.change_stat("constitution", 3) // Seven points just like Warrior. They already get a debuff racial to speed. Please do not stack it God please.
	H.change_stat("strength", 2)
	H.change_stat("endurance", 2)
