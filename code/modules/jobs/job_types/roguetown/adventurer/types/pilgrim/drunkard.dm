/datum/advclass/drunkard
	name = "Gambler"
	tutorial = "You are a gambler. Everyone in your life has given up on you, and the stress of losing it all over and over has taken its toll on your body. All you have left to your name are some cards, dice and whatever is in this bottle. At least you're still in Baotha's good graces, whether you reciprocate such feelings or not..."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/drunkard
	traits_applied = list(TRAIT_HOMESTEAD_EXPERT)
	
	category_tags = list(CTAG_TOWNER)
	subclass_stats = list(
		STATKEY_FOR = 5, // High fortune just make sense. Inb4 Gambler Struggler Meta.
		STATKEY_CON = 1, // One exception to the 7 points stats. 3 Weight not including Fortune
		STATKEY_STR = 1,
		STATKEY_SPD = 1, // Running away from your debt
		STATKEY_INT = -2
	)
	subclass_skills = list(
		/datum/skill/misc/stealing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_APPRENTICE, //Climbing into windows to steal drugs or booze.
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/adventurer/drunkard/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/tights/vagrant
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	armor = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/clothing/mask/cigarette/rollie/cannabis
	beltl = /obj/item/flint
	backpack_contents = list(
						/obj/item/storage/pill_bottle/dice = 1,
						/obj/item/toy/cards/deck = 1,
						/obj/item/reagent_containers/glass/bottle/rogue/wine = 1,
						/obj/item/flashlight/flare/torch = 1,
						)
	if(H.patron.type == /datum/patron/divine/xylix)
		ADD_TRAIT(H, TRAIT_CRACKHEAD, TRAIT_GENERIC)
