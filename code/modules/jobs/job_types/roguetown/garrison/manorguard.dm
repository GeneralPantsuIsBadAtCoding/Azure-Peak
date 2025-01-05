/datum/job/roguetown/manorguard
	title = "Man at Arms"
	flag = MANATARMS
	department_flag = GARRISON
	faction = "Station"
	total_positions = 8
	spawn_positions = 8

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	tutorial = "Having proven yourself loyal and capable, you are entrusted to defend the town and enforce its laws. Trained regularly in combat and siege warfare, you stand a small chance of surviving the Duke's reign."
	display_order = JDO_CASTLEGUARD
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/manorguard
	advclass_cat_rolls = list(CTAG_MENATARMS = 20)

	give_bank_account = 22
	min_pq = 3
	max_pq = null
	round_contrib_points = 2

	cmode_music = 'sound/music/combat_guard2.ogg'

/datum/job/roguetown/manorguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard/surcoat/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "man-at-arms jupon ([index])"

/datum/outfit/job/roguetown/manorguard
	cloak = /obj/item/clothing/cloak/stabard/surcoat/guard
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	gloves = /obj/item/clothing/gloves/roguetown/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	beltl = /obj/item/storage/keyring/guardcastle
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	id = /obj/item/scomstone/bad/garrison

// Maces + Axes + Shield	-	Better armor, typical Man-at-Arms loadout
/datum/advclass/manorguard/footsman
	name = "Men-at-Arms Footsman"
	tutorial = "You are a professional soldier of the realm, specializing in melee warfare. Stalwart and hardy, your body can both withstand and dish out powerful strikes.."
	outfit = /datum/outfit/job/roguetown/manorguard/footsman

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/manorguard/footsman/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)		//Skilled swordsman.
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GUARDSMAN, TRAIT_GENERIC) //+1 spd, con, end, +2 per in town
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	H.change_stat("strength", 2) // seems kinda lame but remember guardsman bonus!!
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)

	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord		//Bit worse shirt protection than the archer
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale			//Makes up for worse shirt protection with kinda better armor protection
	head = /obj/item/clothing/head/roguetown/helmet/sallet				//Better protection than kettle archer has
	pants = /obj/item/clothing/under/roguetown/chainlegs
	neck = /obj/item/clothing/neck/roguetown/gorget

	H.adjust_blindness(-3)
	var/weapons = list("Axe & Shield","Billhook & Cudgel")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Axe & Shield")
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel		//If too weak, consider giving steel axe.
			backl = /obj/item/rogueweapon/shield/wood
		if("Billhook & Cudgel")
			beltr = /obj/item/rogueweapon/mace/cudgel
			r_hand = /obj/item/rogueweapon/spear/billhook

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1)
	H.verbs |= /mob/proc/haltyell

// Swords/Daggers + Crossbow/Bow	-	Lighter armor, but ranged and quick-like!
/datum/advclass/manorguard/boltman
	name = "Men-at-Arms Skirmisher"
	tutorial = "You are a professional soldier of the realm, specializing in ranged implements. You sport a keen eye, looking for your enemies weaknesses."
	outfit = /datum/outfit/job/roguetown/manorguard/boltman

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/manorguard/boltman/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)		//Not as good as the boltman
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 5, TRUE)		//Only effects draw and reload time.
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)			//Only effects draw times.
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // Athletics a bit better than ur average gooby
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GUARDSMAN, TRAIT_GENERIC) //+1 spd, con, end, +3 per in town
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	//Garrison ranged/speed class. Time to go wild
	H.change_stat("endurance", 1) // seems kinda lame but remember guardsman bonus!!
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)

	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord			// Cant wear chainmail anymoooree
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded		//Helps against arrows; makes sense for a ranged-type role.
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	beltr = /obj/item/quiver/bolts
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	pants = /obj/item/clothing/under/roguetown/trou/leather

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1)
	H.verbs |= /mob/proc/haltyell
