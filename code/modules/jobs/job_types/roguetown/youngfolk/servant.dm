/datum/job/roguetown/servant
	title = "Servant"
//	f_title = "Maid"
	flag = SERVANT
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 6
	spawn_positions = 6

	allowed_races = RACES_ALL_KINDS
	allowed_ages = ALL_AGES_LIST

	tutorial = "Granted a life of comfortable servitude in the Duke's manor, you follow the Seneschal's commands and spend your day performing necessary but menial tasks. This role offers an aesthetic choice between labor-servant, maid, butler, and concubine."

	outfit = /datum/outfit/job/roguetown/servant
	advclass_cat_rolls = list(CTAG_SERVANT = 20)
	display_order = JDO_SERVANT
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null
	round_contrib_points = 2
	advjob_examine = TRUE
	cmode_music = 'sound/music/combat_bard.ogg'

/datum/job/roguetown/servant/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup") // Classes are for aesthetic clothing only, mechanically they're identical.

/datum/advclass/servant/servant
	name = "Servant"
	tutorial = "You are a humdrum servant, dressed the part; lowly and best out of sight. It's practical, however."
	outfit = /datum/outfit/job/roguetown/servant/servant
	category_tags = list(CTAG_SERVANT)

/datum/outfit/job/roguetown/servant/servant/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/servant
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	armor = /obj/item/clothing/suit/roguetown/armor/workervest
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		if(H.age == AGE_MIDDLEAGED)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.change_stat("speed", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 2)
		ADD_TRAIT(H, TRAIT_CICERONE, TRAIT_GENERIC)

/datum/advclass/servant/maid
	name = "Maid"
	tutorial = "Not one really mentions how hard it is to do yardwork in a dress and stockings, but at least you still look really good."
	outfit = /datum/outfit/job/roguetown/servant/maid
	category_tags = list(CTAG_SERVANT)

/datum/outfit/job/roguetown/servant/maid/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/armingcap
	armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/black
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	pants = pick(/obj/item/clothing/under/roguetown/tights/stockings/black, /obj/item/clothing/under/roguetown/tights/stockings/white) 
	cloak = /obj/item/clothing/cloak/apron/waist
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/servant
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		if(H.age == AGE_MIDDLEAGED)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.change_stat("speed", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 2)
		ADD_TRAIT(H, TRAIT_CICERONE, TRAIT_GENERIC)

/datum/advclass/servant/butler
	name = "Butler"
	tutorial = "An impeccable appearance is your core being. You still dig through the mud, though, you just do the laundry more."
	outfit = /datum/outfit/job/roguetown/servant/butler
	category_tags = list(CTAG_SERVANT)

/datum/outfit/job/roguetown/servant/butler/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/tights/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/servant
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		if(H.age == AGE_MIDDLEAGED)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.change_stat("speed", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 2)
		ADD_TRAIT(H, TRAIT_CICERONE, TRAIT_GENERIC)

/datum/advclass/servant/concubine
	name = "Concubine"
	tutorial = "You are a prized possession of the nobility, adorned in exotic silks and gold. Your role is to provide companionship, entertainment, and pleasure to your master. Your exotic appearance and skills make you a valuable asset in the court, though your position is one of both privilege and servitude."
	outfit = /datum/outfit/job/roguetown/servant/concubine
	category_tags = list(CTAG_SERVANT)

/datum/outfit/job/roguetown/servant/concubine/pre_equip(mob/living/carbon/human/H)
	..()
	mask = /obj/item/clothing/mask/rogue/exoticsilkmask
	neck = /obj/item/clothing/neck/roguetown/collar
	belt = /obj/item/storage/belt/rogue/leather/exoticsilkbelt
	shoes = /obj/item/clothing/shoes/roguetown/anklets
	backl = /obj/item/storage/backpack/rogue/satchel
	shirt = /obj/item/clothing/suit/roguetown/shirt/exoticsilkbra
	pants = /obj/item/clothing/under/roguetown/tights/stockings/silk
	
	// Add items to the satchel
	backpack_contents = list(
		/obj/item/rope = 1,
		/obj/item/candle = 1,
		/obj/item/rogueweapon/whip = 1,
		/obj/item/clothing/mask/rogue/blindfold = 1
	)
	
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)
		H.change_stat("strength", 1)
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
	
	// Let the concubine choose an instrument
	var/weapons = list("Harp","Lute","Accordion","Guitar","Hurdy-Gurdy","Viola","Vocal Talisman","Flute")
	var/weapon_choice = input("Choose your instrument.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Harp")
			backr = /obj/item/rogue/instrument/harp
		if("Lute")
			backr = /obj/item/rogue/instrument/lute
		if("Accordion")
			backr = /obj/item/rogue/instrument/accord
		if("Guitar")
			backr = /obj/item/rogue/instrument/guitar
		if("Hurdy-Gurdy")
			backr = /obj/item/rogue/instrument/hurdygurdy
		if("Viola")
			backr = /obj/item/rogue/instrument/viola
		if("Vocal Talisman")
			backr = /obj/item/rogue/instrument/vocals
		if("Flute")
			backr = /obj/item/rogue/instrument/flute
