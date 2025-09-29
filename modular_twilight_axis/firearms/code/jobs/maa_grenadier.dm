/datum/advclass/manorguard/twilight_grenadier
	name = "Grenadier"
	tutorial = "You are a professional soldier of the realm, specializing in revolutionary gunpowder weaponry. There are many men who can block a blade, but you're yet to find one who can block a bullet."
	outfit = /datum/outfit/job/roguetown/manorguard/twilight_grenadier
	maximum_possible_slots = 2
	category_tags = list(CTAG_MENATARMS)
	traits_applied = list(TRAIT_MEDIUMARMOR)
	subclass_stats = list(
		STATKEY_WIL = 1,// seems kinda lame but remember guardsman bonus!!
		STATKEY_PER = 2,
		STATKEY_SPD = 1,
		STATKEY_INT = 1,
	)
	subclass_skills = list(
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/twilight_firearms = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/riding = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/tracking = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/manorguard/twilight_grenadier/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord		
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	gloves = /obj/item/clothing/gloves/roguetown/chain/iron

	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/keyring/guardcastle = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1,
		/obj/item/twilight_powderflask = 1
		)

	H.adjust_blindness(-3)
	var/weapons = list("Аркебуза со штыком","Кулеврина и картечь")
	var/weapon_choice = input("Выберите свое оружие.", "К ОРУЖИЮ") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Аркебуза со штыком")
			beltr = /obj/item/quiver/twilight_bullet/lead
			backl = /obj/item/gun/ballistic/twilight_firearm/arquebus/bayonet
		if("Кулеврина и картечь") 
			beltr = /obj/item/quiver/twilight_bullet/cannonball/grapeshot
			backl = /obj/item/gun/ballistic/twilight_firearm/handgonne
			backpack_contents += list(/obj/item/natural/bundle/fibers/full = 1)

	H.verbs |= /mob/proc/haltyell

	var/helmets = list(
	"Simple Helmet" 	= /obj/item/clothing/head/roguetown/helmet,
	"Kettle Helmet" 	= /obj/item/clothing/head/roguetown/helmet/kettle,
	"Bascinet Helmet"		= /obj/item/clothing/head/roguetown/helmet/bascinet,
	"Sallet Helmet"		= /obj/item/clothing/head/roguetown/helmet/sallet,
	"Winged Helmet" 	= /obj/item/clothing/head/roguetown/helmet/winged,
	"None"
	)
	var/helmchoice = input("Choose your helm.", "TAKE UP ARMOR") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

	var/armors = list(
		"Lightweight Brigandine"		= /obj/item/clothing/suit/roguetown/armor/brigandine/light,
		"Steel Cuirass"		= /obj/item/clothing/suit/roguetown/armor/plate/half,
		"Scalemail"	= /obj/item/clothing/suit/roguetown/armor/plate/scale,
	)
	var/armorchoice = input("Choose your armor.", "TAKE UP ARMOR") as anything in armors
	armor = armors[armorchoice]

	var/arms = list(
		"Brigandine Splint Arms"		= /obj/item/clothing/wrists/roguetown/splintarms,
		"Steel Bracers"		= /obj/item/clothing/wrists/roguetown/bracers,
		"Jack Chains"		= /obj/item/clothing/wrists/roguetown/bracers/jackchain,
		"None"
	)
	var/armschoice = input("Choose your arm protection.", "READY THYSELF") as anything in arms
	if(armschoice != "None")
		wrists = arms[armschoice]

	var/chausses = list(
		"Brigandine Chausses"		= /obj/item/clothing/under/roguetown/splintlegs,
		"Steel Chain Chausses"		= /obj/item/clothing/under/roguetown/chainlegs,
	)
	var/chausseschoice = input("Choose your chausses.", "READY THYSELF") as anything in chausses
	pants = chausses[chausseschoice]
