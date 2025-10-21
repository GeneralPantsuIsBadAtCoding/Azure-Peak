/datum/advclass/wretch/berserker
	name = "Berserker"
	tutorial = "You are a warrior feared for your brutality, dedicated to using your might for your own gain. Might equals right, and you are the reminder of such a saying."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/berserker
	cmode_music = 'sound/music/cmode/antag/combat_darkstar.ogg'
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STRONGBITE, TRAIT_CRITICAL_RESISTANCE, TRAIT_NOPAINSTUN)
	// Literally same stat spread as Atgervi Shaman
	subclass_stats = list(
		STATKEY_STR = 3,
		STATKEY_CON = 2,
		STATKEY_WIL = 1,
		STATKEY_SPD = 1,
		STATKEY_INT = -1,
		STATKEY_PER = -1
	)
	subclass_skills = list(
		/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/axes = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/tracking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/medicine = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/tanning = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
		/datum/skill/labor/butchering = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/wretch/berserker/pre_equip(mob/living/carbon/human/H)
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	backr = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/flashlight/flare/torch/lantern/prelit = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/rope/chain = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/reagent_containers/glass/bottle/alchemical/healthpot = 1,	//Small health vial
		)
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	if(H.mind)
		var/weapons = list("Discipline - Unarmed","Katar","Knuckledusters","Punch Dagger","Battle Axe","Grand Mace","Falx")
		var/weapon_choice = input(H, "Choose your WEAPON.", "SPILL THEIR ENTRAILS.") as anything in weapons
		switch(weapon_choice)
			if ("Discipline - Unarmed")
				H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_MASTER, TRUE)
				ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)
				ADD_TRAIT(H, TRAIT_STRONGKICK, TRAIT_GENERIC)
			if ("Katar")
				H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_MASTER, TRUE)
				beltr = /obj/item/rogueweapon/katar
			if ("Knuckledusters")
				H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_MASTER, TRUE)
				beltr = /obj/item/rogueweapon/knuckles
			if ("Punch Dagger")
				H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_MASTER, TRUE)
				beltr = /obj/item/rogueweapon/katar/punchdagger
			if ("Battle Axe")
				H.adjust_skillrank_up_to(/datum/skill/combat/axes, SKILL_LEVEL_EXPERT, TRUE)
				beltr = /obj/item/rogueweapon/stoneaxe/battle
			if ("Grand Mace")
				H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_EXPERT, TRUE)
				beltr = /obj/item/rogueweapon/mace/goden/steel
			if ("Falx")
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_EXPERT, TRUE)
				beltr = /obj/item/rogueweapon/scabbard/sword
				r_hand = /obj/item/rogueweapon/sword/falx
		var/gloves = list("Plate Gauntlets","Pugilist's Wrappings - Increased Unarmed Damage, No Protection")
		var/glove_choice = input(H, "Choose your GLOVES.", "CRACK SOME SKULLS.") as anything in gloves
		switch(glove_choice)
			if ("Plate Gauntlets")
				gloves = /obj/item/clothing/gloves/roguetown/plate
			if ("Pugilist's Wrappings - Increased Unarmed Damage, No Protection")
				gloves = /obj/item/clothing/gloves/roguetown/bandages/pugilist
		var/helmets = list("Berserker's Volfskulle Bascinet, Steel Kettle + Wildguard")
		var/helmet_choice = input(H, "Choose your HELMET.", "STEEL YOURSELF.") as anything in helmets
		H.set_blindness(0)
		switch(helmet_choice)
			if ("Berserker's Volfskulle Bascinet")
				head = /obj/item/clothing/head/roguetown/helmet/heavy/volfplate/berserker
				ADD_TRAIT(user, TRAIT_BITERHELM, TRAIT_GENERIC) //Similar boon to the Graggar helmet, as it lets you chew through the helmet.
			if ("Steel Kettle + Wildguard")
				head = /obj/item/clothing/head/roguetown/helmet/kettle
				mask = /obj/item/clothing/mask/rogue/wildguard
		wretch_select_bounty(H)
