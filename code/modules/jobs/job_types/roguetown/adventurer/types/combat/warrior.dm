/datum/advclass/sfighter
	name = "Battlemaster"
	tutorial = "You are a seasoned weapon specialist, clad in maille, with years of experience in warfare and battle under your belt."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/sfighter
	cmode_music = 'sound/music/cmode/adventurer/combat_outlander2.ogg'
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_MEDIUMARMOR)
	class_select_category = CLASS_CAT_WARRIOR
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_WIL = 1,
		STATKEY_CON = 2,
	)
	subclass_skills = list(
		/datum/skill/combat/polearms = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/axes = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/swords = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/shields = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/adventurer/sfighter/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning("You are a seasoned weapon specialist, clad in maille, with years of experience in warfare and battle under your belt."))
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	H.set_blindness(0)
	if(H.mind)
		var/weapons = list("Longsword","Mace","Billhook","Battle Axe","Short Sword & Iron Shield","Iron Saber & Wood Shield")
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		switch(weapon_choice)
			if("Longsword")
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_EXPERT, TRUE)
				backr = /obj/item/rogueweapon/sword/long
				beltr = /obj/item/rogueweapon/scabbard/sword
			if("Mace")
				H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_EXPERT, TRUE)
				beltr = /obj/item/rogueweapon/mace
			if("Billhook")
				H.adjust_skillrank_up_to(/datum/skill/combat/polearms, SKILL_LEVEL_EXPERT, TRUE)
				r_hand = /obj/item/rogueweapon/spear/billhook
				backr = /obj/item/rogueweapon/scabbard/gwstrap
			if("Battle Axe")
				H.adjust_skillrank_up_to(/datum/skill/combat/axes, SKILL_LEVEL_EXPERT, TRUE)
				backr = /obj/item/rogueweapon/stoneaxe/battle
			if("Short Sword & Iron Shield")
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_EXPERT, TRUE)
				H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_JOURNEYMAN, TRUE)
				backr = /obj/item/rogueweapon/shield/iron
				beltr = /obj/item/rogueweapon/scabbard/sword
				r_hand = /obj/item/rogueweapon/sword/short/iron
			if("Iron Saber & Wood Shield")
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_EXPERT, TRUE)
				H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_JOURNEYMAN, TRUE)
				r_hand = /obj/item/rogueweapon/sword/saber/iron
				beltr = /obj/item/rogueweapon/scabbard/sword
				backr = /obj/item/rogueweapon/shield/wood
		var/armors = list("Chainmaille Set","Iron Breastplate","Gambeson & Helmet","Light Raneshi Armor")
		var/armor_choice = input(H, "Choose your armor.", "TAKE UP ARMOR") as anything in armors
		switch(armor_choice)
			if("Chainmaille Set")
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
				shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/random//giving them something to wear under their armors
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
				neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
				gloves = /obj/item/clothing/gloves/roguetown/chain/iron
			if("Iron Breastplate")
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				neck = /obj/item/clothing/neck/roguetown/coif/heavypadding
				shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/random
				pants = /obj/item/clothing/under/roguetown/splintlegs/iron
				gloves = /obj/item/clothing/gloves/roguetown/angle
			if("Gambeson & Helmet")
				armor = /obj/item/clothing/suit/roguetown/armor/gambeson
				neck = /obj/item/clothing/neck/roguetown/coif/padded//neck cover
				shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/random
				wrists = /obj/item/clothing/wrists/roguetown/splintarms/iron//adding it since this set feels far too weak compared to the other two, gets one helmet and arm cover at least
				pants = /obj/item/clothing/under/roguetown/trou/leather
				head = /obj/item/clothing/head/roguetown/helmet/kettle
				gloves = /obj/item/clothing/gloves/roguetown/angle
			if("Light Raneshi Armor")
				shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/raneshen
				pants = /obj/item/clothing/under/roguetown/trou/leather/pontifex/raneshen
				head = /obj/item/clothing/head/roguetown/roguehood/shalal/hijab
				gloves = /obj/item/clothing/gloves/roguetown/angle
	belt = /obj/item/storage/belt/rogue/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	backpack_contents = list(
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/recipe_book/survival = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)

/datum/advclass/sfighter/duelist
	name = "Duelist"
	tutorial = "You are an esteemed swordsman who foregoes armor in exchange for a more nimble fighting style."
	outfit = /datum/outfit/job/roguetown/adventurer/duelist
	cmode_music = 'sound/music/cmode/adventurer/combat_outlander2.ogg'
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_DODGEEXPERT, TRAIT_DECEIVING_MEEKNESS)
	subclass_stats = list(
		STATKEY_INT = 2,
		STATKEY_STR = 1,
		STATKEY_WIL = 1,
		STATKEY_SPD = 1,
	)
	subclass_skills = list(
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/swords = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/shields = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/adventurer/duelist/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning("You are an esteemed swordsman who foregoes armor in exchange for a more nimble fighting style."))
	H.set_blindness(0)
	if(H.mind)
		var/weapons = list("Rapier","Dagger")
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		switch(weapon_choice)
			if("Rapier")
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_EXPERT, TRUE)
				l_hand = /obj/item/rogueweapon/sword/rapier
				r_hand = /obj/item/rogueweapon/scabbard/sword
			if("Dagger")
				H.adjust_skillrank_up_to(/datum/skill/combat/knives, SKILL_LEVEL_EXPERT, TRUE)
				r_hand = /obj/item/rogueweapon/huntingknife/idagger/steel
				beltr = /obj/item/rogueweapon/scabbard/sheath
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	head = /obj/item/clothing/head/roguetown/duelhat
	mask = /obj/item/clothing/mask/rogue/duelmask
	cloak = /obj/item/clothing/cloak/half
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/trou/leather
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/clothing/neck/roguetown/gorget
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/shield/buckler
	belt = /obj/item/storage/belt/rogue/leather
	backpack_contents = list(
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/rogueweapon/huntingknife/idagger/steel/parrying = 1,
		/obj/item/recipe_book/survival = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)

/datum/advclass/sfighter/mhunter
	name = "Monster Hunter"
	tutorial = "You specialize in hunting down monsters and the undead, carrying two blades - one of silver, one of steel."
	outfit = /datum/outfit/job/roguetown/adventurer/mhunter
	cmode_music = 'sound/music/cmode/adventurer/combat_outlander2.ogg'
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_MEDIUMARMOR)
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_WIL = 1,
		STATKEY_CON = 1,
		STATKEY_INT = 1,
	)
	subclass_skills = list(
		/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/tracking = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/alchemy = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/adventurer/mhunter/pre_equip(mob/living/carbon/human/H, visualsOnly)
	..()
	to_chat(H, span_warning("You specialize in hunting down monsters and the undead, carrying two blades - one of silver, one of steel."))
	if(H.mind)
		var/steel = list("Parrying Dagger","Sword","Dagger")
		var/steel_choice = input(H, "Choose your steel.", "PURGE THE LIVING") as anything in steel
		switch(steel_choice)
			if ("Parrying Dagger")
				l_hand = /obj/item/rogueweapon/huntingknife/idagger/steel/parrying
				beltr = /obj/item/rogueweapon/scabbard/sheath
			if("Sword")
				l_hand = /obj/item/rogueweapon/sword
				beltr = /obj/item/rogueweapon/scabbard/sword
			if ("Dagger")
				l_hand = /obj/item/rogueweapon/huntingknife/idagger/steel
				beltr = /obj/item/rogueweapon/scabbard/sheath
		var/silver = list("Silver Sword","Silver Dagger")
		var/silver_choice = input(H, "Choose your silver.", "PURGE THE CURSED") as anything in silver
		switch(silver_choice)
			if("Silver Sword")
				r_hand = /obj/item/rogueweapon/sword/silver
				backr = /obj/item/rogueweapon/scabbard/sword
			if ("Silver Dagger")
				r_hand = /obj/item/rogueweapon/huntingknife/idagger/silver
				backr = /obj/item/rogueweapon/scabbard/sheath
	backl = /obj/item/storage/backpack/rogue/satchel/black
	wrists = /obj/item/clothing/neck/roguetown/psicross/silver
	armor = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/steel
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/tights/black
	cloak = /obj/item/clothing/cloak/cape/puritan
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	head = /obj/item/clothing/head/roguetown/bucklehat
	gloves = /obj/item/clothing/gloves/roguetown/angle
	backpack_contents = list(
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/recipe_book/survival = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)
	beltl = pick(
		/obj/item/reagent_containers/glass/bottle/alchemical/strpot,
		/obj/item/reagent_containers/glass/bottle/alchemical/conpot,
		/obj/item/reagent_containers/glass/bottle/alchemical/endpot,
		/obj/item/reagent_containers/glass/bottle/alchemical/spdpot,
		/obj/item/reagent_containers/glass/bottle/alchemical/perpot,
		/obj/item/reagent_containers/glass/bottle/alchemical/intpot,
		/obj/item/reagent_containers/glass/bottle/alchemical/lucpot,
		)

/datum/advclass/sfighter/barbarian
	name = "Barbarian"
	tutorial = "You are a brutal warrior who foregoes armor in order to showcase your raw strength. You specialize in unarmed combat and wrestling."
	outfit = /datum/outfit/job/roguetown/adventurer/barbarian
	cmode_music = 'sound/music/cmode/antag/combat_darkstar.ogg'
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_CRITICAL_RESISTANCE, TRAIT_NOPAINSTUN)
	subclass_stats = list(
		STATKEY_STR = 3,
		STATKEY_CON = 2,
		STATKEY_WIL = 1,
		STATKEY_INT = -2,
	)
	subclass_skills = list(
		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/axes = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/swords = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/polearms = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
	)

/datum/outfit/job/roguetown/adventurer/barbarian/pre_equip(mob/living/carbon/human/H, visualsOnly)
	..()
	to_chat(H, span_warning("You are a brutal warrior who foregoes armor in order to showcase your raw strength. You specialize in unarmed combat and wrestling."))
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	H.set_blindness(0)
	if(H.mind)
		var/weapons = list("Katar","Axe","Sword","Club","Spear","MY BARE HANDS!!!")
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		switch(weapon_choice)
			if ("Katar")
				H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_EXPERT, TRUE)
				beltr = /obj/item/rogueweapon/katar
			if("Axe")
				H.adjust_skillrank_up_to(/datum/skill/combat/axes, SKILL_LEVEL_JOURNEYMAN, TRUE)
				beltr = /obj/item/rogueweapon/stoneaxe/boneaxe
			if("Sword")
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_JOURNEYMAN, TRUE)
				beltr = /obj/item/rogueweapon/scabbard/sword
				r_hand = /obj/item/rogueweapon/sword/short
			if("Club")
				H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_JOURNEYMAN, TRUE)
				beltr = /obj/item/rogueweapon/mace/woodclub
			if("Spear")
				H.adjust_skillrank_up_to(/datum/skill/combat/polearms, SKILL_LEVEL_JOURNEYMAN, TRUE)
				r_hand = /obj/item/rogueweapon/spear/bonespear
			if ("MY BARE HANDS!!!")
				H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_EXPERT, TRUE)
				ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)
	if(should_wear_masc_clothes(H))
		H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
		head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
		backl = /obj/item/storage/backpack/rogue/satchel
		belt = /obj/item/storage/belt/rogue/leather
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltl = /obj/item/rogueweapon/huntingknife
	if(should_wear_femme_clothes(H))
		head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
		armor = /obj/item/clothing/suit/roguetown/armor/leather/bikini
		pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/shorts
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
		gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
		backl = /obj/item/storage/backpack/rogue/satchel
		belt = /obj/item/storage/belt/rogue/leather
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltl = /obj/item/rogueweapon/huntingknife
	backpack_contents = list(/obj/item/flashlight/flare/torch = 1)

/datum/advclass/sfighter/ironclad
	name = "Ironclad"
	tutorial = "You are a warrior who puts their trust in durable armor. The best offense is a good defense."
	outfit = /datum/outfit/job/roguetown/adventurer/ironclad
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_HEAVYARMOR)
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_WIL = 2,
		STATKEY_CON = 1,
	)
	subclass_skills = list(
		/datum/skill/combat/polearms = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/axes = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/swords = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/shields = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/whipsflails = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/adventurer/ironclad/pre_equip(mob/living/carbon/human/H, visualsOnly)
	..()
	if(H.mind)
		to_chat(H, span_warning("You put your trust into your durable armor. The best offense is a good defense."))
		var/helmets = list(
			"Sallet"			= /obj/item/clothing/head/roguetown/helmet/sallet/iron,
			"Visored Sallet"	= /obj/item/clothing/head/roguetown/helmet/sallet/visored/iron,
			"Kettle Helmet"		= /obj/item/clothing/head/roguetown/helmet/kettle/iron,
			"Bucket Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/bucket/iron,
			"Knight Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/knight/iron,
			"None"
			)
		var/helmchoice = input(H, "Choose your Helm.", "TAKE UP HELMS") as anything in helmets
		if(helmchoice != "None")
			head = helmets[helmchoice]

		var/armors = list(
			"Breastplate + Hauberk",
			"Half-Plate + Light Gambeson"
			)
		var/armorchoice = input(H, "Choose your armor.", "TAKE UP ARMOR") as anything in armors
		switch(armorchoice)
			if("Breastplate + Hauberk")
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/iron
			if("Half-Plate + Light Gambeson")
				armor = /obj/item/clothing/suit/roguetown/armor/plate/iron
				shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light

		var/legs = list(
			"Chain Chausses"	= /obj/item/clothing/under/roguetown/chainlegs/iron,
			"Chain Kilt"		= /obj/item/clothing/under/roguetown/chainlegs/iron/kilt
			)
		var/legschoice = input(H, "Choose your Pants.", "TAKE UP PANTS") as anything in legs
		pants = legs[legschoice]
	gloves = /obj/item/clothing/gloves/roguetown/chain/iron
	neck = /obj/item/clothing/neck/roguetown/bevor/iron
	wrists = /obj/item/clothing/wrists/roguetown/bracers/iron
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/iron
	belt = /obj/item/storage/belt/rogue/leather/battleskirt/black
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/recipe_book/survival = 1,
		)
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	H.set_blindness(0)
	if(H.mind)
		var/weapons = list("Executioner's Sword","Warhammer + Shield","Flail + Shield","Lucerne","Greataxe")
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		switch(weapon_choice)
			if("Executioner's Sword")
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_JOURNEYMAN, TRUE)
				backr = /obj/item/rogueweapon/sword/long/exe
			if("Warhammer + Shield")
				H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_JOURNEYMAN, TRUE)
				H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_JOURNEYMAN, TRUE)
				beltr = /obj/item/rogueweapon/mace/warhammer
				backr = /obj/item/rogueweapon/shield/iron
			if("Flail + Shield")
				H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, SKILL_LEVEL_JOURNEYMAN, TRUE)
				H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_JOURNEYMAN, TRUE)
				beltr = /obj/item/rogueweapon/flail
				backr = /obj/item/rogueweapon/shield/iron
			if("Lucerne")
				H.adjust_skillrank_up_to(/datum/skill/combat/polearms, SKILL_LEVEL_JOURNEYMAN, TRUE)
				r_hand = /obj/item/rogueweapon/eaglebeak/lucerne
				backr = /obj/item/rogueweapon/scabbard/gwstrap
			if("Greataxe")
				H.adjust_skillrank_up_to(/datum/skill/combat/axes, SKILL_LEVEL_JOURNEYMAN, TRUE)
				r_hand = /obj/item/rogueweapon/greataxe
				backr = /obj/item/rogueweapon/scabbard/gwstrap
