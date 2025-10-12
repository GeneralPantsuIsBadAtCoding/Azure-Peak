//human treesbane

/datum/advclass/masterwoodcutter
	name = "Master Lumberjack"
	tutorial = "The strongest and wisest Lumberjack, trained in the art of both chopping and transforming wood. \
	With your mighty hands you chopped countless trees, Dendor fears you, the elves tell the children stories about you, \
	so they don't wander in the forest."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/masterwoodcutter
	traits_applied = list(TRAIT_HOMESTEAD_EXPERT)
	maximum_possible_slots = 1
	pickprob = 5
	category_tags = list(CTAG_TOWNER)
	subclass_stats = list(
		STATKEY_STR = 4,
		STATKEY_INT = 2,
		STATKEY_WIL = 2,
		STATKEY_CON = 2,
		STATKEY_PER = 1
	)
	subclass_skills = list(
		/datum/skill/combat/axes = SKILL_LEVEL_LEGENDARY, // AXE MEN! GIVE ME SPLINTERS!
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT, 
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/crafting = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/carpentry = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/engineering = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/sewing = SKILL_LEVEL_NOVICE,
		/datum/skill/labor/butchering = SKILL_LEVEL_NOVICE,
		/datum/skill/labor/lumberjacking = SKILL_LEVEL_LEGENDARY,
		/datum/skill/craft/traps = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE,
	)
	
/datum/outfit/job/roguetown/adventurer/masterwoodcutter/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	pants = /obj/item/clothing/under/roguetown/trou
	head = /obj/item/clothing/head/roguetown/hatfur
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	backr = /obj/item/storage/backpack/rogue/backpack
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black 
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel/woodcutter
	beltl = /obj/item/rogueweapon/huntingknife
	backpack_contents = list(
						/obj/item/flint = 1,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/rogueweapon/scabbard/sheath = 1
						)

