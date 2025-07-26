// Melee goon
/datum/advclass/manorguard/footsman
	name = "Footman"
	tutorial = "You are a professional soldier of the realm, specializing in melee warfare. Stalwart and hardy, your body can both withstand and dish out powerful strikes.."
	outfit = /datum/outfit/job/roguetown/manorguard/footsman

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/manorguard/footsman/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/slings, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 1, TRUE)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GUARDSMAN, TRAIT_GENERIC) //+1 spd, con, end, +2 per in town
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	H.change_stat("strength", 2) // seems kinda lame but remember guardsman bonus!!
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)

	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	neck = /obj/item/clothing/neck/roguetown/gorget
	gloves = /obj/item/clothing/gloves/roguetown/plate/iron

	H.adjust_blindness(-3)
	var/weapons = list("Warhammer & Shield","Axe & Shield","Halberd","Greataxe")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Warhammer & Shield")
			beltr = /obj/item/rogueweapon/mace/warhammer
			backl = /obj/item/rogueweapon/shield/iron
		if("Axe & Shield")
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel
			backl = /obj/item/rogueweapon/shield/iron
		if("Halberd")
			r_hand = /obj/item/rogueweapon/halberd
			backl = /obj/item/gwstrap
		if("Greataxe")
			r_hand = /obj/item/rogueweapon/greataxe
			backl = /obj/item/gwstrap
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/keyring/guardcastle = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)
	H.verbs |= /mob/proc/haltyell

	var/helmets = list(
	"Simple Helmet" 	= /obj/item/clothing/head/roguetown/helmet,
	"Kettle Helmet" 	= /obj/item/clothing/head/roguetown/helmet/kettle,
	"Bascinet Helmet"		= /obj/item/clothing/head/roguetown/helmet/bascinet,
	"Sallet Helmet"		= /obj/item/clothing/head/roguetown/helmet/sallet,
	"Winged Helmet" 	= /obj/item/clothing/head/roguetown/helmet/winged,
	"Skull Cap"			= /obj/item/clothing/head/roguetown/helmet/skullcap,
	"None"
	)
	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

	var/armors = list(
		"Lightweight Brigandine"		= /obj/item/clothing/suit/roguetown/armor/brigandine/light,
		"Iron Hauberk"		= /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/iron,
		"Scalemail"	= /obj/item/clothing/suit/roguetown/armor/plate/scale,
	)
	var/armorchoice = input("Choose your armor.", "TAKE UP ARMOR") as anything in armors
	armor = armors[armorchoice]

	var/arms = list(
		"Brigandine Splint Arms"		= wrists = /obj/item/clothing/wrists/roguetown/splintarms,
		"Steel Bracers"		= wrists = /obj/item/clothing/wrists/roguetown/bracers,
		"Jack Chains"		= wrists = /obj/item/clothing/wrists/roguetown/bracers/jackchain,
	)
	var/armschoice = input("Choose your arm protection.", "READY THYSELF") as anything in arms
	wrists = arms[armschoice]

	var/chausses = list(
		"Brigandine Chausses"		= /obj/item/clothing/under/roguetown/splintlegs,
		"Steel Chain Chausses"		= /obj/item/clothing/under/roguetown/chainlegs,
	)
	var/chausseschoice = input("Choose your chausses.", "READY THYSELF") as anything in chausses
	pants = chausses[chausseschoice]
