/datum/advclass/wretch/outlaw
	name = "Outlaw"
	tutorial = "You are the person folk fear at night - use your cunning and speed to strike fast and get out with your spoils before anyone notices."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/outlaw
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_DODGEEXPERT)
	subclass_stats = list(
		STATKEY_SPD = 3,
		STATKEY_WIL = 2,
		STATKEY_PER = 1
	)


/datum/outfit/job/roguetown/wretch/outlaw/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning("You are the person folk fear at night - use your cunning and speed to strike fast and get out with your spoils before anyone notices."))
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	neck = /obj/item/clothing/neck/roguetown/gorget
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	mask = /obj/item/clothing/mask/rogue/ragmask/black
	beltr = /obj/item/quiver/bolts
	r_hand = /obj/item/rogueweapon/mace/cudgel //From thief PR
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/lockpickring/mundane = 1,
		/obj/item/flashlight/flare/torch/lantern/prelit = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/roguebag = 1,
		/obj/item/ammo_casing/caseless/rogue/bolt/water = 3,
		/obj/item/reagent_containers/glass/bottle/alchemical/healthpot = 1,	//Small health vial
		)
	H.adjust_skillrank(/datum/skill/misc/tracking, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE) //A bonus rather than something to be encouraged
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 5, TRUE)
	H.cmode_music = 'sound/music/cmode/antag/combat_cutpurse.ogg'
	var/weapons = list("Rapier","Dagger", "Whip")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Rapier")
			H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			beltl = /obj/item/rogueweapon/scabbard/sword
			l_hand = /obj/item/rogueweapon/sword/rapier
		if("Dagger")
			H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			beltl = /obj/item/rogueweapon/scabbard/sheath
			l_hand = /obj/item/rogueweapon/huntingknife/idagger/steel/special // Why were they spawning with an elven dagger in the first place??? Please LMK.
		if ("Whip")
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
			beltl = /obj/item/rogueweapon/whip
	H.grant_language(/datum/language/thievescant)
	wretch_select_bounty(H)

/datum/advclass/wretch/outlaw/marauder
	name = "Marauder"
	tutorial = "You are a brigand and a pillager - you prefer to get your coins with direct means from unfortunate victims."
	outfit = /datum/outfit/job/roguetown/wretch/marauder
	//Still the speed class
	subclass_stats = list(
		STATKEY_CON = 2,
		STATKEY_SPD = 2,
		STATKEY_STR = 1,
		STATKEY_WIL = 1
	)

/datum/outfit/job/roguetown/wretch/marauder/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning("You are a brigand and a pillager - you prefer to get your coins with direct means from unfortunate victims."))
	head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	cloak = /obj/item/clothing/cloak/stabard/dungeon
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	gloves = /obj/item/clothing/gloves/roguetown/angle
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	neck = /obj/item/clothing/neck/roguetown/gorget 
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	mask = /obj/item/clothing/mask/rogue/ragmask/black
	r_hand = /obj/item/rogueweapon/mace/cudgel //From thief PR
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/flashlight/flare/torch/lantern/prelit = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/roguebag = 1,
		)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
	H.cmode_music = 'sound/music/cmode/antag/combat_thewall.ogg'
	var/weapons = list("Just A Heater Shield","Dagger + Crossbow", "Militia Warpick + Heater Shield", "Militia Spear + Heater Shield")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Just An Iron Shield")
			H.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
			backr = /obj/item/rogueweapon/shield/iron
		if("Dagger + Crossbow")
			H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			beltl = /obj/item/rogueweapon/scabbard/sheath
			l_hand = /obj/item/rogueweapon/huntingknife/idagger/steel
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			beltr = /obj/item/quiver/bolts
		if ("Militia Warpick + Heater Shield")
			H.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
			beltl = /obj/item/rogueweapon/pick/militia
			backr = /obj/item/rogueweapon/shield/iron
		if ("Militia Spear + Heater Shield")
			H.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			l_hand = /obj/item/rogueweapon/spear/militia
			backr = /obj/item/rogueweapon/shield/heater
	H.grant_language(/datum/language/thievescant)
	wretch_select_bounty(H)
