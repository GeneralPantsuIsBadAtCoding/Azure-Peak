/datum/advclass/butcher
	name = "Butcher"
	tutorial = "Some say you're a strange individual, some say you're a cheat, while some claim you're a savant in the art of sausage making. Without your skilled hands and knifework, most of the livestock around the town would be wasted. "
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/butcher
	cmode_music = 'sound/music/cmode/towner/combat_retired.ogg'
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	subclass_stats = list(
		STATKEY_CON = 2,
		STATKEY_WIL = 2,
		STATKEY_STR = 1
	)
	subclass_skills = list(
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/axes = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/tanning = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/riding = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/labor/butchering = SKILL_LEVEL_MASTER,
	)

/datum/outfit/job/roguetown/adventurer/butcher/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/huntingknife/cleaver // old tbutcher had no knife. as a butcher.
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	backpack_contents = list(
						/obj/item/kitchen/spoon,
						/obj/item/reagent_containers/food/snacks/rogue/truffles,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/recipe_book/survival = 1,
						/obj/item/reagent_containers/food/snacks/fat = 2, // make sausages :)
						/obj/item/rogueweapon/scabbard/sheath = 1
						)
	if(H.pronouns == SHE_HER || H.pronouns == THEY_THEM_F)
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
	else
		pants = /obj/item/clothing/under/roguetown/trou
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
