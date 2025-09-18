/datum/advclass/mercenary/condottiero
	name = "Condottiero Guildsman"
	tutorial = "Hailing from the Kingdom of Etrusca, Condottieri are soldiers of fortune oft found in the employ of powerful merchants. Without a war to fight back home, the Grand Duchy has become a much-needed source of contracts. Afterall, this land is rich in coin yet poor in manpower..."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/mercenary/condottiero
	class_select_category = CLASS_CAT_ETRUSCA
	category_tags = list(CTAG_MERCENARY)
	subclass_languages = list(/datum/language/etruscan, /datum/language/thievescant)
	cmode_music = 'sound/music/combat_condottiero.ogg'
	traits_applied = list(TRAIT_DODGEEXPERT)
	subclass_stats = list(
		STATKEY_WIL = 2,
		STATKEY_PER = 2,
		STATKEY_SPD = 2,
		STATKEY_INT = 1
	)
	subclass_skills = list(
		/datum/skill/combat/crossbows = SKILL_LEVEL_MASTER, //Possibly too high, no idea.
		/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/knives = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/sneaking = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/stealing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/lockpicking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/tracking = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/traps = SKILL_LEVEL_JOURNEYMAN,
	)

/datum/outfit/job/roguetown/mercenary/condottiero/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	cloak = /obj/item/clothing/cloak/half/red
	gloves = /obj/item/clothing/gloves/roguetown/angle
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/iron
	head = /obj/item/clothing/head/roguetown/helmet
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/scabbard/sword
	l_hand = /obj/item/rogueweapon/sword/short
	beltr = /obj/item/quiver/bolts
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	pants = /obj/item/clothing/under/roguetown/trou/leather
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	backpack_contents = list(
		/obj/item/roguekey/mercenary = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/rogueweapon/huntingknife/idagger/navaja = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/lockpick = 1
		)
	H.merctype = 3
