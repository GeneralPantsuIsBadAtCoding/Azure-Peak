/datum/advclass/assassin_hitman
	name = "Assassin - Professional Hitman"
	tutorial = "You spent your life tracking the biggest game of all - mortal men. The direbears you've killed do not even compare to the men you've felled. Track your pray, put down the feral dog, and get your pay.."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/assassin/ranger
	category_tags = list(CTAG_ASSASSIN)
	traits_applied = list(TRAIT_BLACKBAGGER)	// Agent (15)47 - Lets you use the blackbag and garrote you
	// Weighted 14
	subclass_stats = list(
		STATKEY_PER = 1,
		STATKEY_SPD = 3,
		STATKEY_STR = 1,
		STATKEY_WIL = 2,
		STATKEY_CON = 1,
		STATKEY_INT = 1,
		STATKEY_LCK = 1,
	)
	subclass_skills = list(
		/datum/skill/combat/maces = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/wrestling = SKILL_LEVEL_MASTER,		//GRAB HEEEE!!!
		/datum/skill/combat/unarmed = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/crossbows = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/sewing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/medicine = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_MASTER,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/traps = SKILL_LEVEL_NOVICE,
	)
