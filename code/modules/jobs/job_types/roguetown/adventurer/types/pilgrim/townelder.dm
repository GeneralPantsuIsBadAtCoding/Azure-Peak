/datum/advclass/elder
	name = "Town Elder"
	maximum_possible_slots = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_OLD)
	tutorial = "You are as venerable and ancient as the trees themselves, wise even for your years spent with the first Wardens. The people look up to you both as a teacher and a guide to solve lesser issues before violence is involved. Not everything must end in bloodshed, no matter how much the retinue wish it were the case. Lead your fellow townsfolk in these troubling times lest they incur wrath of the nobility with their ignorance."
	outfit = /datum/outfit/job/roguetown/elder
	cmode_music = 'sound/music/cmode/towner/combat_retired.ogg'
	category_tags = list(CTAG_TOWNER)

/datum/outfit/job/roguetown/elder/pre_equip(mob/living/carbon/human/H)
	..()
	cloak = /obj/item/clothing/cloak/stabard/guardhood/elder
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/white
	pants = /obj/item/clothing/under/roguetown/tights
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/mace
	beltl = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/scomstone/bad
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/storage/belt/rogue/pouch/coins/rich = 1)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/engineering, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/ceramics, 3, TRUE)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_WIL, 2)
	H.change_stat(STATKEY_SPD, -1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_INT, 3)
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, "[type]")
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDICINE_EXPERT, TRAIT_GENERIC)
	if(should_wear_femme_clothes(H))
		head = /obj/item/clothing/head/roguetown/chaperon/greyscale/elder
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress
		backr = /obj/item/clothing/cloak/raincloak/furcloak
	else if(should_wear_masc_clothes(H))
		head = /obj/item/clothing/head/roguetown/chaperon/greyscale/elder
		shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
		gloves = /obj/item/clothing/gloves/roguetown/leather
