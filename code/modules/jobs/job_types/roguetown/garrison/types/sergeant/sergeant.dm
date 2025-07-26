//Rare-ish anti-armor two hander sword. Kinda alternative of a bastard sword type. Could be cool.
/datum/advclass/sergeant/sergeant
	name = "Sergeant-at-Arms"
	tutorial = "You are a not just anybody but the Sergeant-at-Arms of the Duchy's garrison. While you may have started as some peasant or mercenary, you have advanced through the ranks to that of someone who commands respect and wields it. Take up arms, sergeant!"
	outfit = /datum/outfit/job/roguetown/sergeant/sergeant

	category_tags = list(CTAG_SERGEANT)

/datum/outfit/job/roguetown/sergeant/sergeant/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)	
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 5, TRUE)	// We are basically identical to a regular MAA, except having better athletics to help us manage our order usage better
	H.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)	//Decent tracking akin to Skirmisher.
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GUARDSMAN, TRAIT_GENERIC) //+1 spd, con, end, +3 per in town
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.change_stat("strength", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 1)
	H.change_stat("perception", 1)		//Gets bow-skills, so give a SMALL tad of perception to aid in bow draw.
	H.change_stat("endurance", 1)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/movemovemove)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/takeaim)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/onfeet)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/hold)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/focustarget)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/convertrole/guard) // We'll just use Watchmen as sorta conscripts yeag?
	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw, /mob/proc/haltyell, /mob/living/carbon/human/mind/proc/setorders)
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/keyring/guardsergeant = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)
	H.adjust_blindness(-3)
	var/weapons = list("Rhomphaia","Flail & Shield","Halberd","Sabre & Crossbow")	//Bit more unique than footsman, you are a jack-of-all-trades + slightly more 'elite'.
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Rhomphaia")			//Rare-ish anti-armor two hander sword. Kinda alternative of a bastard sword type. Could be cool.
			backl = /obj/item/rogueweapon/scabbard/sword
			l_hand = /obj/item/rogueweapon/sword/long/rhomphaia
			beltr = /obj/item/rogueweapon/mace/cudgel
		if("Flail & Shield")	//Tower-shield, higher durability wood shield w/ more coverage. Plus a steel flail; maybe.. less broken that a steel mace?
			beltr = /obj/item/rogueweapon/flail/sflail
			backl = /obj/item/rogueweapon/shield/tower
		if("Halberd")			//Halberd - basically exact same as MAA. It's a really valid build. Spear thrust + sword chop + bash.
			r_hand = /obj/item/rogueweapon/halberd
			backl = /obj/item/gwstrap
			beltr = /obj/item/rogueweapon/mace/cudgel
		if("Sabre & Crossbow")	//Versetile skirmisher class. Considered other swords but sabre felt best without being too strong. (This one gets no cudgel, no space.)
			beltr = /obj/item/quiver/bolts
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			r_hand = /obj/item/rogueweapon/sword/sabre
			l_hand = /obj/item/rogueweapon/scabbard/sword

	var/armors = list(
		"Lightweight Brigandine"		= /obj/item/clothing/suit/roguetown/armor/brigandine/light,
		"Steel Cuirass"		= /obj/item/clothing/suit/roguetown/armor/plate/half,
		"Scalemail"	= /obj/item/clothing/suit/roguetown/armor/plate/scale,
	)
	var/armorchoice = input("Choose your armor.", "TAKE UP ARMOR") as anything in armors
	armor = armors[armorchoice]
