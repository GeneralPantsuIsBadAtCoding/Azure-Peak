//elf ranger

/datum/advclass/sentinel
	name = "Sentinel"
	tutorial = "Elvish Sentinels are a specialized group of Rangers known for their mastery of bow and blade alike; their arrows are said to contain poisons from the native trees"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/elf/dark,
		/datum/species/elf/wood,
	)
	outfit = /datum/outfit/job/roguetown/adventurer/sentinal
	traits_applied = list(TRAIT_MEDIUMARMOR, TRAIT_DODGEEXPERT)
	category_tags = list(CTAG_ADVENTURER)


/datum/outfit/job/roguetown/adventurer/sentinal/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 1, TRUE) //Sentinel gets wacky perception and is an upgrade from ranger already
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	cloak = /obj/item/clothing/cloak/raincloak/green
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/sword/sabre/elf
	backpack_contents = list(/obj/item/bait = 1, /obj/item/rogueweapon/huntingknife/idagger/silver/elvish = 1, /obj/item/flashlight/flare/torch/lantern = 1)
	beltl = /obj/item/quiver/arrows
	H.change_stat("perception", 5)
	H.change_stat("endurance", 2)
	H.ambushable = FALSE
