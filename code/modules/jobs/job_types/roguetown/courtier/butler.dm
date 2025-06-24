/datum/job/roguetown/butler // really need to re-name all these when the codebase isn't a fork and search will update for the peasants...
	title = "Seneschal"
	flag = BUTLER
	department_flag = COURTIERS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS

	tutorial = "Servitude unto death; that is your motto. You are the manor's major-domo, commanding over the house servants and seeing to the administrative affairs, day to day of the estate. This role has style options for chief butlers and head maids."
	outfit = /datum/outfit/job/roguetown/seneschal
	advclass_cat_rolls = list(CTAG_SENESCHAL = 20)
	display_order = JDO_BUTLER
	give_bank_account = 30
	min_pq = 3
	max_pq = null
	round_contrib_points = 3

/datum/job/roguetown/butler/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup") // Classes are for aesthetic clothing only, mechanically they're identical.

/datum/advclass/seneschal/seneschal
	name = "Seneschal"
	tutorial = "While still expected to fill in for the duties of the household servantry as needed, you have styled yourself as a figure beyond them."
	outfit = /datum/outfit/job/roguetown/seneschal/seneschal
	category_tags = list(CTAG_SENESCHAL)

/datum/outfit/job/roguetown/seneschal/seneschal/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/tights
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/servant
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	id = /obj/item/scomstone/bad
	if(should_wear_femme_clothes(H)) 
		armor = /obj/item/clothing/suit/roguetown/armor/silkcoat
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	if(H.age == AGE_MIDDLEAGED)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.change_stat("speed", 1)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 2)
	H.change_stat("fortune", 1) // Usual leadership carrot.
	ADD_TRAIT(H, TRAIT_CICERONE, TRAIT_GENERIC)

/datum/advclass/seneschal/headmaid
	name = "Head Maid"
	tutorial = "Whether you were promoted from one or just like the frills, you stylize yourself as a head maid. Your duties and talents remain the same, though."
	outfit = /datum/outfit/job/roguetown/seneschal/headmaid
	category_tags = list(CTAG_SENESCHAL)

/datum/outfit/job/roguetown/seneschal/headmaid/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen
	pants = pick(/obj/item/clothing/under/roguetown/tights/stockings/silk/white, /obj/item/clothing/under/roguetown/tights/stockings/silk/black) 
	armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/black
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	cloak = /obj/item/clothing/cloak/apron/waist
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/servant
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	id = /obj/item/scomstone/bad
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	if(H.age == AGE_MIDDLEAGED)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.change_stat("speed", 1)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 2)
	H.change_stat("fortune", 1) // Usual leadership carrot.
	ADD_TRAIT(H, TRAIT_CICERONE, TRAIT_GENERIC)

/datum/advclass/seneschal/chiefbutler
	name = "Chief Butler"
	tutorial = "You are the ruling class of butler and your ability to clear your throat and murmur 'I say' is without peer. Your duties and talents as seneschal remain the same, though."
	outfit = /datum/outfit/job/roguetown/seneschal/chiefbutler
	category_tags = list(CTAG_SENESCHAL)

/datum/outfit/job/roguetown/seneschal/chiefbutler/pre_equip(mob/living/carbon/human/H)
	..() // They need a monocle.
	pants = /obj/item/clothing/under/roguetown/tights/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/servant
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	id = /obj/item/scomstone/bad
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	if(H.age == AGE_MIDDLEAGED)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.change_stat("speed", 1)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 2)
	H.change_stat("fortune", 1) // Usual leadership carrot.
	ADD_TRAIT(H, TRAIT_CICERONE, TRAIT_GENERIC)

