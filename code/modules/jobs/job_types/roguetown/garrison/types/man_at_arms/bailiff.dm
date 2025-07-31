// Whip goon
/datum/advclass/manorguard/bailiff
	name = "Bailiff"
	tutorial = "You are a professional soldier of the realm, specializing in unconventional tactics. Few can hope to survive your onslaught be it your fists or deadly whip."
	outfit = /datum/outfit/job/roguetown/manorguard/bailiff
	maximum_possible_slots = 1 // You only get one rn as well
	cmode_music = 'sound/music/combat_dungeoneer.ogg'

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/manorguard/bailiff/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE) //Technically get maces but they should just manhandle ppl anyway
	H.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE) //hilarious
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)//Enough for majority of surgeries without grinding.
	H.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GUARDSMAN, TRAIT_GENERIC) //+1 spd, con, end, +2 per in town
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	H.change_stat("strength", 2)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 2)

	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	neck = /obj/item/clothing/neck/roguetown/gorget
	gloves = /obj/item/clothing/gloves/roguetown/plate/iron
	beltr = /obj/item/rogueweapon/whip/antique

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
