/datum/advclass/drunkard
	name = "Gambler"
	tutorial = "You are a gambler. Everyone in your life has given up on you, and the stress of losing it all over and over has taken its toll on your body. All you have left to your name are some cards, dice and whatever is in this bottle. At least you're still in Baotha's good graces, whether you reciprocate such feelings or not..."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/drunkard
	
	category_tags = list(CTAG_TOWNER)

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
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE) //Climbing into windows to steal drugs or booze.
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.change_stat("intelligence", -2)
	H.change_stat("constitution", 1)
	H.change_stat("strength", 1)
	H.change_stat("fortune", 2)
	if(H.patron.type == /datum/patron/divine/xylix)
		ADD_TRAIT(H, TRAIT_CRACKHEAD, TRAIT_GENERIC)
