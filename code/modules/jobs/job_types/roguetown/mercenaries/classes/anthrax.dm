/datum/advclass/mercenary/anthrax
	name = "Anthrax"
	tutorial = "With the brutal dismantlement of drow society, the talents of the redeemed Anthraxi were no longer needed. Yet where one door closes, another opens - the decadent mortals of the overworld clamber over each other to bid for your blade. Show them your craft."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/elf/dark,
	)
	outfit = /datum/outfit/job/roguetown/mercenary/anthrax
	class_select_category = CLASS_CAT_RACIAL
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5

	cmode_music = 'sound/music/combat_delf.ogg'

	traits_applied = list(TRAIT_DARKVISION) //cave elfes
	subclass_stats = list(
		STATKEY_WIL = 2,
		STATKEY_PER = 1,
		STATKEY_INT = 1
	)
	subclass_skills = list(
		/datum/skill/combat/bows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT, 
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT, 
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/riding = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/traps = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/alchemy = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/mercenary/anthrax/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	belt = /obj/item/storage/belt/rogue/leather/black
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/shadowpants
	backl = /obj/item/storage/backpack/rogue/satchel/black
	head = /obj/item/clothing/neck/roguetown/chaincoif/full/black
	backpack_contents = list(
		/obj/item/roguekey/mercenary = 1, 
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1, 
		/obj/item/rogueweapon/huntingknife/idagger/steel/corroded/dirk = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/strongpoison = 1,
		/obj/item/rogueweapon/scabbard/sheath)
	if(H.mind)

		H.verbs |= /mob/living/carbon/human/proc/torture_victim //Secret police training owing to their origins.

		if(H.gender == FEMALE) //Melee defense-oriented brute, heavy lean towards non-lethal takedowns and capture.
			armor = /obj/item/clothing/suit/roguetown/armor/plate/fluted/shadowplate
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/shadowrobe
			gloves = /obj/item/clothing/gloves/roguetown/plate/shadowgauntlets
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
			mask = /obj/item/clothing/mask/rogue/facemask/shadowfacemask
			neck = /obj/item/clothing/neck/roguetown/chaincoif/chainmantle
			backr = /obj/item/rogueweapon/shield/tower/spidershield
			beltr = /obj/item/rogueweapon/whip/spiderwhip
			beltl = /obj/item/rope/chain

			H.adjust_skillrank_up_to(/datum/skill/combat/axes, SKILL_LEVEL_JOURNEYMAN, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_JOURNEYMAN, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, SKILL_LEVEL_EXPERT, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_EXPERT, TRUE)

			H.change_stat(STATKEY_STR, 2) //Grenz merc statline but with maluses.
			H.change_stat(STATKEY_CON, 1)
			H.change_stat(STATKEY_WIL, 2)
			H.change_stat(STATKEY_INT, -1) //Brutebrain, relies on archer for healing, lockpicking and crafting.
			H.change_stat(STATKEY_SPD, -1)

			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

		if(H.gender == MALE) //Squishy hit-and-runner assassin.
			shirt = /obj/item/clothing/suit/roguetown/shirt/shadowshirt/elflock
			armor = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/shadowrobe
			cloak = /obj/item/clothing/cloak/half/shadowcloak/elflock
			gloves = /obj/item/clothing/gloves/roguetown/fingerless/shadowgloves/elflock
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
			mask = /obj/item/clothing/mask/rogue/shepherd/shadowmask/delf
			neck = /obj/item/clothing/neck/roguetown/chaincoif/chainmantle
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/short //Coupled with the racial PER malus, abysmal damage, but good for poison arrows.
			beltr = /obj/item/quiver/poisonarrows
			beltl = /obj/item/rogueweapon/scabbard/sword
			r_hand = /obj/item/rogueweapon/sword/sabre/elf/stalker

			H.adjust_skillrank_up_to(/datum/skill/misc/sneaking, SKILL_LEVEL_MASTER, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/misc/lockpicking, SKILL_LEVEL_EXPERT, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/bows, SKILL_LEVEL_EXPERT, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/crossbows, SKILL_LEVEL_JOURNEYMAN, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_EXPERT, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, SKILL_LEVEL_EXPERT, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/misc/sewing, SKILL_LEVEL_NOVICE, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/misc/medicine, SKILL_LEVEL_APPRENTICE, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/craft/cooking, SKILL_LEVEL_NOVICE, TRUE) //Spread-out support skills, but inferior to Steppesman.
			H.adjust_skillrank_up_to(/datum/skill/craft/traps, SKILL_LEVEL_EXPERT, TRUE)

			H.change_stat(STATKEY_SPD, 3)
			H.change_stat(STATKEY_WIL, 2)
			H.change_stat(STATKEY_PER, 2)

			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

		var/riding = list("Im a spiderider", "I walk on my legs")
		var/ridingchoice = input("Choose your faith", "FAITH") as anything in riding
		switch(ridingchoice)
			if("Im a spiderider")
				var/turf/TU = get_turf(H)
				if(TU)
					new /mob/living/simple_animal/hostile/retaliate/rogue/drider/tame/saddled(TU)
			if("I walk on my legs")
				H.adjust_skillrank_up_to(/datum/skill/misc/athletics, SKILL_LEVEL_MASTER, TRUE) //+1

		H.merctype = 15
