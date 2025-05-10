/datum/job/roguetown/wretch
	title = "Wretch"
	flag = WRETCH
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	allowed_races = RACES_ALL_KINDS
	tutorial = "Somewhere in your lyfe, you fell to the wrong side of civilization. Hounded by the consequences of your actions, you now threaten the peace of those who still heed the authority that condemned you."
	outfit = null
	outfit_female = null
	display_order = JDO_WRETCH
	show_in_credits = FALSE
	min_pq = 20
	max_pq = null

	advclass_cat_rolls = list(CTAG_WRETCH = 20)
	PQ_boost_divider = 10
	round_contrib_points = 2

	announce_latejoin = FALSE
	wanderer_examine = TRUE
	advjob_examine = TRUE
	always_show_on_latechoices = TRUE
	job_reopens_slots_on_death = TRUE
	same_job_respawn_delay = 1 MINUTES

/datum/job/roguetown/wretch/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

		if(GLOB.adventurer_hugbox_duration)
			addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, adv_hugboxing_start)), 1)

/datum/advclass/wretch/deserter
	name = "Deserter"
	tutorial = "You were once a venerated and revered knight - now, a traitor who abandoned your liege. You live the life of an outlaw, shunned and looked down upon by society."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/deserter
	horse = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigabuck/tame/saddled
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER, TRAIT_HEAVYARMOR, TRAIT_OUTLAW, TRAIT_NOBLE)

/datum/outfit/job/roguetown/wretch/deserter/pre_equip(mob/living/carbon/human/H)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	var/weapons = list("Estoc","Mace + Shield","Flail + Shield","Lucerne","Battle Axe")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Estoc")
			r_hand = /obj/item/rogueweapon/estoc
			backr = /obj/item/gwstrap
		if("Mace + Shield")
			beltr = /obj/item/rogueweapon/mace/steel
			backr = /obj/item/rogueweapon/shield/tower/metal
		if("Flail + Shield")
			beltr = /obj/item/rogueweapon/flail/sflail
			backr = /obj/item/rogueweapon/shield/tower/metal
		if("Lucerne")
			r_hand = /obj/item/rogueweapon/eaglebeak/lucerne
			backr = /obj/item/gwstrap
		if("Battle Axe")
			backr = /obj/item/rogueweapon/stoneaxe/battle
	var/helmets = list(
		"Pigface Bascinet" 	= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface,
		"Guard Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/guard,
		"Barred Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/sheriff,
		"Bucket Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/bucket,
		"Knight Helmet"		= /obj/item/clothing/head/roguetown/helmet/heavy/knight,
		"Visored Sallet"			= /obj/item/clothing/head/roguetown/helmet/sallet/visored,
		"Armet"				= /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet,
		"Hounskull Bascinet" 		= /obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull,
		"Etruscan Bascinet" 		= /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan,
		"None"
	)
	var/helmchoice = input("Choose your Helm.", "TAKE UP HELMS") as anything in helmets
	if(helmchoice != "None")
		head = helmets[helmchoice]

	var/armors = list(
		"Brigandine"		= /obj/item/clothing/suit/roguetown/armor/brigandine,
		"Coat of Plates"	= /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates,
		"Steel Cuirass"		= /obj/item/clothing/suit/roguetown/armor/plate/half,				
	)
	var/armorchoice = input("Choose your armor.", "TAKE UP ARMOR") as anything in armors
	armor = armors[armorchoice]
	H.change_stat("strength", 2)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 1)
	gloves = /obj/item/clothing/gloves/roguetown/chain
	pants = /obj/item/clothing/under/roguetown/chainlegs
	neck = /obj/item/clothing/neck/roguetown/bevor
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/steel
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	backl = /obj/item/storage/backpack/rogue/satchel //gwstraps landing on backr asyncs with backpack_contents
	backpack_contents = list(/obj/item/rogueweapon/huntingknife = 1, /obj/item/flashlight/flare/torch/lantern/prelit = 1)
	GLOB.outlawed_players += H.real_name
	var/my_crime = input(H, "What is your crime?", "Crime") as text|null
	if (!my_crime)
		my_crime = "crimes against the Crown"
	var/bounty_total
	bounty_total = rand(151, 250)
	add_bounty(H.real_name, bounty_total, FALSE, my_crime, "The Justiciary of Azuria")
	to_chat(H, span_danger("You are an Antagonistic role. You are expected, by choosing to be a wretch, to sow chaos and division amongst the town while driving a story. Failure to use proper gravitas for this may get you punished for Low Role Play standards."))

/datum/advclass/wretch/outlaw
	name = "Outlaw"
	tutorial = "You're a seasoned criminal known for your heinous acts, your face plastered on wanted posters across the region. A life of theft, robbery, and ill-gotten-gains comes naturally to you."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/outlaw
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER, TRAIT_MEDIUMARMOR, TRAIT_DODGEEXPERT, TRAIT_OUTLAW)


/datum/outfit/job/roguetown/wretch/outlaw/pre_equip(mob/living/carbon/human/H)
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/clothing/neck/roguetown/gorget
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	mask = /obj/item/clothing/mask/rogue/ragmask/black
	beltr = /obj/item/quiver/Wbolts
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/lockpickring/mundane = 1, /obj/item/flashlight/flare/torch/lantern/prelit = 1, /obj/item/rogueweapon/mace/cudgel = 1)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/traps, 5, TRUE)
	H.cmode_music = 'sound/music/combat_vaquero.ogg'
	var/weapons = list("Rapier","Dagger", "Whip")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Rapier")
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			beltl = /obj/item/rogueweapon/sword/rapier
		if("Dagger")
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			beltl = /obj/item/rogueweapon/huntingknife/idagger/silver/elvish
		if ("Whip")
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
			beltl = /obj/item/rogueweapon/whip
	H.change_stat("strength", -1)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 2)
	H.change_stat("speed", 3)
	GLOB.outlawed_players += H.real_name
	var/my_crime = input(H, "What is your crime?", "Crime") as text|null
	if (!my_crime)
		my_crime = "crimes against the Crown"
	var/bounty_total
	bounty_total = rand(151, 250)
	add_bounty(H.real_name, bounty_total, FALSE, my_crime, "The Justiciary of Azuria")
	to_chat(H, span_danger("You are an Antagonistic role. You are expected, by choosing to be a wretch, to sow chaos and division amongst the town while driving a story. Failure to use proper gravitas for this may get you punished for Low Role Play standards."))

/datum/advclass/wretch/poacher
	name = "Poacher"
	tutorial = "You have rejected society and its laws, choosing life in the wilderness instead. Simple thieving highwayman or freedom fighter, you take from those who have and give to the have-nots. Fancy, how the latter includes yourself!"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/poacher
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER, TRAIT_DODGEEXPERT, TRAIT_OUTLAW, TRAIT_WOODSMAN, TRAIT_OUTDOORSMAN)


/datum/outfit/job/roguetown/wretch/poacher/pre_equip(mob/living/carbon/human/H)
	head = /obj/item/clothing/head/roguetown/roguehood/darkgreen
	mask = /obj/item/clothing/mask/rogue/wildguard
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/darkgreen
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/gorget
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	shoes = /obj/item/clothing/shoes/roguetown/boots
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	beltl = /obj/item/quiver/arrows
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	backpack_contents = list(/obj/item/bait = 1, /obj/item/rogueweapon/huntingknife = 1, /obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/flashlight/flare/torch/lantern/prelit = 1)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/traps, 4, TRUE)
	//these people live in the forest so let's give them some peasant skills
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	H.cmode_music = 'sound/music/combat_poacher.ogg'
	var/weapons = list("Dagger","Axe", "Cudgel", "My Bow Is Enough")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Dagger")
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
		if("Axe")
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut
		if ("Cudgel")
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			beltr = /obj/item/rogueweapon/mace/cudgel
		if ("My Bow Is Enough")
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			head = /obj/item/clothing/head/roguetown/duelhat
	H.change_stat("endurance", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)
	GLOB.outlawed_players += H.real_name
	var/my_crime = input(H, "What is your crime?", "Crime") as text|null
	if (!my_crime)
		my_crime = "crimes against the Crown"
	var/bounty_total
	bounty_total = rand(151, 250)
	add_bounty(H.real_name, bounty_total, FALSE, my_crime, "The Justiciary of Azuria")
	to_chat(H, span_danger("You are an Antagonistic role. You are expected, by choosing to be a wretch, to sow chaos and division amongst the town while driving a story. Failure to use proper gravitas for this may get you punished for Low Role Play standards."))

/datum/advclass/wretch/heretic
	name = "Heretic"
	tutorial = "You are a heretic, spurned by the church, cast out from society - frowned upon by Psydon and his children for your faith."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/heretic
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER, TRAIT_HEAVYARMOR, TRAIT_RITUALIST, TRAIT_OUTLAW)


/datum/outfit/job/roguetown/wretch/heretic/pre_equip(mob/living/carbon/human/H)
	if (!(istype(H.patron, /datum/patron/inhumen/zizo) || istype(H.patron, /datum/patron/inhumen/matthios) || istype(H.patron, /datum/patron/inhumen/graggar) || istype(H.patron, /datum/patron/inhumen/baotha)))
		to_chat(H, span_warning("My former deity frowned upon my practices. I have since turned to a new god."))
		H.set_patron(pick(/datum/patron/inhumen/zizo, /datum/patron/inhumen/matthios, /datum/patron/inhumen/graggar, /datum/patron/inhumen/baotha))
	H.mind.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.set_blindness(0)
	var/weapons = list("Bastard Sword","Mace","Flail")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	switch(weapon_choice)
		if("Bastard Sword")
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			beltr = /obj/item/rogueweapon/sword/long
		if("Mace")
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			beltr = /obj/item/rogueweapon/mace/steel
		if("Flail")
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
			beltr = /obj/item/rogueweapon/flail/sflail
	H.change_stat("strength", 2)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 1)
	if (istype (H.patron, /datum/patron/inhumen/zizo))
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/minion_order)
		ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC)
	head = /obj/item/clothing/head/roguetown/helmet/heavy/knight/black
	cloak = /obj/item/clothing/cloak/cape/crusader
	gloves = /obj/item/clothing/gloves/roguetown/chain/blk
	pants = /obj/item/clothing/under/roguetown/chainlegs/blk
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	armor = /obj/item/clothing/suit/roguetown/armor/plate/blk
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/blk
	belt = /obj/item/storage/belt/rogue/leather/steel
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/shield/tower/metal
	beltl = /obj/item/roguekey/inhumen
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/rogueweapon/huntingknife = 1, /obj/item/ritechalk = 1, /obj/item/flashlight/flare/torch/lantern/prelit = 1)
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells(H)
	START_PROCESSING(SSobj, C)
	GLOB.excommunicated_players += H.real_name
	var/my_crime = input(H, "What is your crime?", "Crime") as text|null
	if (!my_crime)
		my_crime = "crimes against the Crown"
	var/bounty_total
	bounty_total = rand(151, 250)
	add_bounty(H.real_name, bounty_total, FALSE, my_crime, "The Holy See")
	H.cmode_music = 'sound/music/combat_cult.ogg'
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	to_chat(H, span_danger("You are an Antagonistic role. You are expected, by choosing to be a wretch, to sow chaos and division amongst the town while driving a story. Failure to use proper gravitas for this may get you punished for Low Role Play standards."))

/datum/advclass/wretch/necromancer
	name = "Necromancer"
	tutorial = "You have been ostracized and hunted by society for your dark magics and perversion of life."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/necromancer
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER, TRAIT_ZOMBIE_IMMUNE, TRAIT_MAGEARMOR, TRAIT_GRAVEROBBER, TRAIT_OUTLAW, TRAIT_ARCYNE_T3)


/datum/outfit/job/roguetown/wretch/necromancer/pre_equip(mob/living/carbon/human/H)
	H.set_patron(/datum/patron/inhumen/zizo)
	head = /obj/item/clothing/head/roguetown/roguehood/black
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
	neck = /obj/item/clothing/neck/roguetown/gorget
	beltl = /obj/item/rogueweapon/huntingknife
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/woodstaff/ruby
	backpack_contents = list(/obj/item/spellbook_unfinished/pre_arcyne = 1, /obj/item/roguegem/amethyst = 1, /obj/item/roguekey/inhumen = 1, /obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/flashlight/flare/torch/lantern/prelit = 1)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
	H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
	H.cmode_music = 'sound/music/combat_cult.ogg'
	if(H.age == AGE_OLD)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
		H.mind.adjust_spellpoints(2)
	H.change_stat("intelligence", 4)
	H.change_stat("endurance", 1)
	H.change_stat("speed", 1)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/eyebite)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/bonechill)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/minion_order)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/raise_lesser_undead/necromancer)
	H.mind.adjust_spellpoints(5)
	GLOB.excommunicated_players += H.real_name
	var/my_crime = input(H, "What is your crime?", "Crime") as text|null
	if (!my_crime)
		my_crime = "crimes against the Crown"
	var/bounty_total
	bounty_total = rand(151, 250)
	add_bounty(H.real_name, bounty_total, FALSE, my_crime, "The Holy See")
	to_chat(H, span_danger("You are an Antagonistic role. You are expected, by choosing to be a wretch, to sow chaos and division amongst the town while driving a story. Failure to use proper gravitas for this may get you punished for Low Role Play standards."))

/datum/advclass/wretch/berserker
	name = "Berserker"
	tutorial = "You are a warrior feared for your brutality, dedicated to using your might for your own gain. Might equals right, and you are the reminder of such a saying."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/berserker
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER, TRAIT_STRONGBITE, TRAIT_CRITICAL_RESISTANCE, TRAIT_NOPAINSTUN, TRAIT_OUTLAW)


/datum/outfit/job/roguetown/wretch/berserker/pre_equip(mob/living/carbon/human/H)
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	mask = /obj/item/clothing/mask/rogue/wildguard
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	gloves = /obj/item/clothing/gloves/roguetown/plate
	backr = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	backpack_contents = list(/obj/item/rogueweapon/huntingknife = 1, /obj/item/flashlight/flare/torch/lantern/prelit = 1, /obj/item/storage/belt/rogue/pouch/coins/poor = 1)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	H.cmode_music = 'sound/music/combat_berserker.ogg'
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	var/weapons = list("Katar","Steel Knuckles","MY BARE HANDS!!!","Battle Axe","Mace","Sword")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if ("Katar")
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			beltr = /obj/item/rogueweapon/katar
		if ("Steel Knuckles")
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			beltr = /obj/item/rogueweapon/knuckles
		if ("MY BARE HANDS!!!")
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)
		if ("Battle Axe")
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
			beltr = /obj/item/rogueweapon/stoneaxe/battle
		if ("Mace")
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			beltr = /obj/item/rogueweapon/mace/goden/steel
		if ("Sword")
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			beltr = /obj/item/rogueweapon/sword/falx
	H.change_stat("strength", 3)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 2)
	H.change_stat("intelligence", -3)
	H.change_stat("perception", -1)
	H.change_stat("speed", 1)
	GLOB.outlawed_players += H.real_name
	var/my_crime = input(H, "What is your crime?", "Crime") as text|null
	if (!my_crime)
		my_crime = "crimes against the Crown"
	var/bounty_total
	bounty_total = rand(151, 250)
	add_bounty(H.real_name, bounty_total, FALSE, my_crime, "The Justiciary of Azuria")
	to_chat(H, span_danger("You are an Antagonistic role. You are expected, by choosing to be a wretch, to sow chaos and division amongst the town while driving a story. Failure to use proper gravitas for this may get you punished for Low Role Play standards."))
