/datum/advclass/mercenary/forlorn
	name = "Forlorn Hope Mercenary"
	tutorial = "The Order of the Forlorn Hope, a order formed off the back of a Ranesheni slave revolt. Drawing from all walks of life, this mercenary company now takes ranks from both purchased and liberated slaves. Coin is power, and power is the path to freedom."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/mercenary/forlorn
	class_select_category = CLASS_CAT_RANESHENI
	min_pq = 2
	cmode_music = 'sound/music/combat_blackstar.ogg'
	category_tags = list(CTAG_MERCENARY)
	// tuff boys
	traits_applied = list(TRAIT_MEDIUMARMOR)
	subclass_stats = list(
		STATKEY_WIL = 3,
		STATKEY_STR = 2,
		STATKEY_CON = 2
	)
	subclass_skills = list(
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/sneaking = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/bows = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/crossbows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/maces = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/polearms = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/riding = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/shields = SKILL_LEVEL_EXPERT,	// This was arguably the OG shield + 1hand weapon merc. If this is too much, we can cut it back again.
	)

/datum/outfit/job/roguetown/mercenary/forlorn/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/clothing/neck/roguetown/gorget/forlorncollar
	head = /obj/item/clothing/head/roguetown/helmet/heavy/volfplate
	pants = /obj/item/clothing/under/roguetown/splintlegs		// They're brigandinejaks. ergo have them start w/the whole thing
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	wrists = /obj/item/clothing/wrists/roguetown/splintarms		// They're brigandinejaks. ergo have them start w/the whole thing
	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/mace/warhammer/steel
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/shield/heater
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife,
		/obj/item/roguekey/mercenary,
		/obj/item/rogueweapon/scabbard/sheath
		)
	
	H.merctype = 5
