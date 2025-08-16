/datum/advclass/wretch/heretic
	name = "Heretic"
	tutorial = "You are a heretic, spurned by the church, cast out from society - frowned upon by Psydon and his children for your faith."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/heretic
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER, TRAIT_HEAVYARMOR, TRAIT_RITUALIST, TRAIT_OUTLAW, TRAIT_HERESIARCH)
	maximum_possible_slots = 3 //Ppl dont like heavy armor antags.

/datum/outfit/job/roguetown/wretch/heretic/pre_equip(mob/living/carbon/human/H)
	H.mind.current.faction += "[H.name]_faction"
	H.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE) //Heretic is probably up there as the #1 class that gets constantly grappled. 
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // Heretics should be on-par with templars and other melee-oriented wretch classes in terms of athletics. 
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.set_blindness(0)
	var/weapons = list("Longsword", "Mace", "Flail", "Axe")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	switch(weapon_choice)
		if("Longsword")
			H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			beltr = /obj/item/rogueweapon/scabbard/sword
			r_hand = /obj/item/rogueweapon/sword/long
		if("Mace")
			H.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			beltr = /obj/item/rogueweapon/mace/steel
		if("Flail")
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
			beltr = /obj/item/rogueweapon/flail/sflail
		if("Axe")
			H.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
			beltr = /obj/item/rogueweapon/stoneaxe/battle
	H.change_stat("strength", 2)  // Heretic is by far the best class with access to rituals (as long as they play a god with ritual), holy and heavy armor. So they keep 7 points.
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 1)
	if (istype (H.patron, /datum/patron/inhumen/zizo))
		if(H.mind)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/minion_order)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/gravemark)
			H.mind.current.faction += "[H.name]_faction"
		ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC)
	mask = /obj/item/clothing/mask/rogue/facemask/steel
	neck = /obj/item/clothing/neck/roguetown/chaincoif/chainmantle
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/shield/tower/metal
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/huntingknife
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/ritechalk = 1,
		/obj/item/flashlight/flare/torch/lantern/prelit = 1,
		/obj/item/rope/chain = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/reagent_containers/glass/bottle/alchemical/healthpot = 1,	//Small health vial
		)
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T1, passive_gain = CLERIC_REGEN_MINOR, devotion_limit = CLERIC_REQ_4)	//Minor regen, can level up to T4.
	wretch_select_bounty(H)
	switch(H.patron?.type)
		if(/datum/patron/inhumen/zizo)
			H.cmode_music = 'sound/music/combat_heretic.ogg'
			head = /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet
			H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE) 
			H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
			H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
		if(/datum/patron/inhumen/matthios)
			H.cmode_music = 'sound/music/combat_matthios.ogg'
			head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket/gold
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		if(/datum/patron/inhumen/baotha)
			H.cmode_music = 'sound/music/combat_baotha.ogg'
			head = /obj/item/clothing/head/roguetown/helmet/heavy/sheriff
			ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
		if(/datum/patron/inhumen/graggar)
			H.cmode_music = 'sound/music/combat_graggar.ogg'
			head = /obj/item/clothing/head/roguetown/helmet/heavy/guard
			H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		if(/datum/patron/divine/astrata)
			wrists = /obj/item/clothing/neck/roguetown/psicross/astrata
			head = /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan
			H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		if(/datum/patron/divine/abyssor)
			wrists = /obj/item/clothing/neck/roguetown/psicross/abyssor
			head = /obj/item/clothing/head/roguetown/helmet/heavy/sheriff
			H.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
			ADD_TRAIT(H, TRAIT_WATERBREATHING, TRAIT_GENERIC)
		if(/datum/patron/divine/xylix)
			head = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull
			H.cmode_music = 'sound/music/combat_jester.ogg'
			H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		if(/datum/patron/divine/dendor)
			wrists = /obj/item/clothing/neck/roguetown/psicross/dendor
			head = /obj/item/clothing/head/roguetown/helmet/heavy/volfplate
			H.cmode_music = 'sound/music/cmode/garrison/combat_warden.ogg'
			H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		if(/datum/patron/divine/necra)
			wrists = /obj/item/clothing/neck/roguetown/psicross/necra
			head = /obj/item/clothing/head/roguetown/helmet/sallet/visored
			ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SOUL_EXAMINE, TRAIT_GENERIC)
		if(/datum/patron/divine/pestra)
			wrists = /obj/item/clothing/neck/roguetown/psicross/pestra
			head = /obj/item/clothing/head/roguetown/helmet/sallet/visored
			ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
			H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
		if(/datum/patron/divine/eora)
			wrists = /obj/item/clothing/neck/roguetown/psicross/eora
			head = /obj/item/clothing/head/roguetown/helmet/heavy/knight
			ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
		if(/datum/patron/divine/noc)
			wrists = /obj/item/clothing/neck/roguetown/psicross/noc
			head = /obj/item/clothing/head/roguetown/helmet/heavy/knight/skettle
			H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE) // Really good at reading... does this really do anything? No. BUT it's soulful.
			H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
			H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
		if(/datum/patron/divine/ravox)
			wrists = /obj/item/clothing/neck/roguetown/psicross/ravox
			head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket/gold
			H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		if(/datum/patron/divine/malum)
			wrists = /obj/item/clothing/neck/roguetown/psicross/malum
			head = /obj/item/clothing/head/roguetown/helmet/heavy
			H.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
			H.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
			H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
			H.adjust_skillrank(/datum/skill/craft/smelting, 1, TRUE)
		if(/datum/patron/old_god)
			wrists = /obj/item/clothing/neck/roguetown/psicross
			cloak = /obj/item/clothing/cloak/tabard/crusader/psydon //IDGAF this is based 
			head = /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet
			H.change_stat("endurance", 2) //ENDVRE.
