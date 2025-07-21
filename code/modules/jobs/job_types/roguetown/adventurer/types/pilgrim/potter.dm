/datum/advclass/potter
	name = "Potter"
	tutorial = "You are a skilled artisan in the manipulation of ceramics, \
	and their fashioning into a multitude of different objects and valuables, including glass."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/potter
	
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)

/datum/outfit/job/roguetown/adventurer/potter/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) // Potters are fairly active, having to source their own clay.
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE) // They mostly work with their bare hands...?
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE) // Something about wrestling clay into shape?
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE) // They probably have some insight in carpentry and masonry.
	H.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE) // They probably have some insight in carpentry and masonry.
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/ceramics, 5, TRUE)
	head = /obj/item/clothing/head/roguetown/hatfur
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu

	cloak = /obj/item/clothing/cloak/apron/blacksmith
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/rogueweapon/blowrod
	beltr = /obj/item/rogueweapon/tongs   // Necessary for removing hot glass panes from furnaces.
	backl = /obj/item/storage/backpack/rogue/backpack
	backr = /obj/item/rogueweapon/shovel  // For getting clay

	backpack_contents = list(
		/obj/item/natural/clay = 3,
		/obj/item/natural/clay/glassbatch = 1, 
		/obj/item/rogueore/coal = 1,
		/obj/item/roguegear = 1,
		/obj/item/dye_brush = 1,
		/obj/item/recipe_book/ceramics = 1)
	// Clay and glassBatch are raw materials
	// Coal so he can build an ore furnace for glass blowing
	// Coggers so he can build a potter's wheel.

	H.change_stat("endurance", 2)
	H.change_stat("constitution", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", -1)
