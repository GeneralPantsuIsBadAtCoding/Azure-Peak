//Lich skeletons.
/datum/job/roguetown/skeleton_greater
	title = "Greater Skeleton"
	flag = SKELETON
	department_flag = SLOP
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	
	advclass_cat_rolls = list(CTAG_SKELETON = 20)

	tutorial = "You are a minion to your master, be they a Necromancer or a wandering Lich foraging a new kingdom. Go forth unto the world and wreck havoc."

	outfit = /datum/outfit/job/roguetown/greater_skeleton
	show_in_credits = FALSE
	give_bank_account = FALSE

	cmode_music = 'sound/music/combat_weird.ogg'

/datum/job/roguetown/skeleton_greater/after_spawn(mob/living/L, mob/M, latejoin = FALSE)
	..()
	var/mob/living/carbon/human/H = L
	H.advsetup = TRUE
	H.invisibility = INVISIBILITY_MAXIMUM
	H.become_blind("advsetup")

//Master-path gear all them get regardless of selection.
/datum/outfit/job/roguetown/greater_skeleton
	cloak = /obj/item/clothing/cloak/half	//starts black, so they can be identified.
	belt = /obj/item/storage/belt/rogue/leather/black
	wrists = /obj/item/clothing/wrists/roguetown/bracers/paalloy
	backl = /obj/item/storage/backpack/rogue/satchel
	gloves = /obj/item/clothing/gloves/roguetown/chain/paalloy

// Melee goon w/ javelins. All-rounder.
/datum/advclass/greater_skeleton/legionnaire
	name = "Ancient Legionnaire"
	tutorial = "You were once a veteran of many wars, some forgotten to time. Your soul was consumed and forced to wander this earth; only to find its new place. Necra did not embrace you.. but your new master has."
	outfit = /datum/outfit/job/roguetown/greater_skeleton/legionnaire

	category_tags = list(CTAG_SKELETON)

/datum/outfit/job/roguetown/greater_skeleton/legionnaire/pre_equip(mob/living/carbon/human/H)
	..()
	// Assign stats first.
	H.STASTR = 12
	H.STASPD = 8
	H.STACON = 9
	H.STAEND = 12
	H.STAINT = 3
	H.STAPER = 11	//Base min to hit aimed hits accurately.
	// Now comes their skills.
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	//Extra skills because no intel i guess.
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	// Now comes the loadout armor.
	head = /obj/item/clothing/head/roguetown/helmet/heavy/paalloy
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/paalloy
	pants = /obj/item/clothing/under/roguetown/chainlegs/kilt/paalloy
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	neck = /obj/item/clothing/neck/roguetown/chaincoif/paalloy
	shoes = /obj/item/clothing/shoes/roguetown/sandals/aalloy
	// Now weapons and misc gear.
	backr = /obj/item/rogueweapon/shield/wood	//all of them get the wood shield
	beltl = /obj/item/quiver/javelin/paalloy	//all of them get a javelin bag of STEEL javelins which are stupid strong but whatever
	H.adjust_blindness(-3)
	var/weapons = list("Gladius","Kopesh","Shortsword","Axe", "Flail")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Gladius")
			beltr = /obj/item/rogueweapon/sword/iron/short/gladius/pagladius
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Kopesh")
			beltr = /obj/item/rogueweapon/sword/sabre/palloy
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Shortsword")
			beltr = /obj/item/rogueweapon/sword/short/pashortsword
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Axe")
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel/paaxe
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
		if("Flail")
			beltr = /obj/item/rogueweapon/flail/sflail/paflail
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)

// Ranged goon w/ a dumb bow. Ranger, what else is there to say.
/datum/advclass/greater_skeleton/ballistiares
	name = "Ancient Ballistiares"
	tutorial = "You were once a skilled marksman, hunting down wild game and man alike. Your soul was forced to wander, not embraced by Necra. But you have found your new master.."
	outfit = /datum/outfit/job/roguetown/greater_skeleton/ballistiares

	category_tags = list(CTAG_SKELETON)

/datum/outfit/job/roguetown/greater_skeleton/ballistiares/pre_equip(mob/living/carbon/human/H)
	..()
	// Assign stats first.
	H.STASTR = 10
	H.STASPD = 10
	H.STACON = 7
	H.STAEND = 14
	H.STAINT = 6
	H.STAPER = 15	//For bow skill, maybe tune down if too strong w/ longbows or shit.
	// Now comes their skills.
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.mind.adjust_skillrank(/datum/skill/combat/bows , 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/slings, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	//Extra skills because no intel i guess.
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	// Now comes the loadout armor.
	head = /obj/item/clothing/head/roguetown/helmet/heavy/paalloy
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/paalloy
	pants = /obj/item/clothing/under/roguetown/chainlegs/kilt/paalloy
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	neck = /obj/item/clothing/neck/roguetown/chaincoif/paalloy
	shoes = /obj/item/clothing/shoes/roguetown/sandals/aalloy
	// Now weapons and misc gear.
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel/padagger
	H.adjust_blindness(-3)
	var/weapons = list("Recurve Bow","Yew Longbow","Crossbow","Sling")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Recurve Bow")
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			beltl = /obj/item/quiver/bodkin/paalloy
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		if("Yew Longbow")
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/longbow
			beltl = /obj/item/quiver/bodkin/paalloy
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		if("Crossbow")
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			beltl = /obj/item/quiver/bolts/paalloy
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
		if("Sling")
			beltl = /obj/item/gun/ballistic/revolver/grenadelauncher/sling
			backr = /obj/item/quiver/sling/paalloy
			H.mind.adjust_skillrank(/datum/skill/combat/slings, 1, TRUE)

// Heavy/Tanky goon. Not heavy armor but due to the steel + weapons they'll fare just fine.
/datum/advclass/greater_skeleton/bulwark
	name = "Ancient Death Bulwark"
	tutorial = "You were once a renowned warrior, a champion. A master of heavy and large weapons. Reduced to.. this. A pile of bones after Necra refused to embrace you. But now, you found your new master. It's time to claim glory.."
	outfit = /datum/outfit/job/roguetown/greater_skeleton/bulwark

	category_tags = list(CTAG_SKELETON)

/datum/outfit/job/roguetown/greater_skeleton/bulwark/pre_equip(mob/living/carbon/human/H)
	..()
	// Assign god stats first.
	H.STASTR = 14
	H.STASPD = 5
	H.STACON = 11
	H.STAEND = 10
	H.STAINT = 1
	H.STAPER = 10	//Woe be upon ye. Not terrible, not good. Get fucked.

	// Now comes their skills.
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	//Extra skills because no intel i guess.
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	// Now comes the loadout armor.
	head = /obj/item/clothing/head/roguetown/helmet/heavy/guard/paalloy
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/paalloy
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/paalloy
	neck = /obj/item/clothing/neck/roguetown/gorget/paalloy
	shoes = /obj/item/clothing/shoes/roguetown/boots/aalloy
	// Now weapons and misc gear.
	H.adjust_blindness(-3)
	var/weapons = list("Greatsword","Bardiche","Grand Mace","Spear", "Warhammer + Shield")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Greatsword")
			backr = /obj/item/rogueweapon/greatsword/paalloy
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Bardiche")
			beltr = /obj/item/rogueweapon/halberd/bardiche/paalloy
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if("Grand Mace")
			beltr = /obj/item/rogueweapon/mace/goden/steel/paalloy
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Spear")
			beltr = /obj/item/rogueweapon/spear/paalloy
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if("Warhammer + Shield")
			beltr = /obj/item/rogueweapon/mace/warhammer/steel/paalloy
			backr = /obj/item/rogueweapon/shield/wood
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)

// non-Combat crafter goon. Worse weapons + armor but does base-building. Fortnite.
/datum/advclass/greater_skeleton/sapper
	name = "Broken-Bone Sapper"
	tutorial = "You were no warrior. A craftsman, a tradesman, a yoeman - logistics.. or even a fallen veteran far past his prime. Logistics and building is your trade. Necra rejected you, but now you have a new master.."
	outfit = /datum/outfit/job/roguetown/greater_skeleton/bulwark

	category_tags = list(CTAG_SKELETON)

/datum/outfit/job/roguetown/greater_skeleton/sapper/pre_equip(mob/living/carbon/human/H)
	..()
	// Assign god + stats first.
	H.set_patron(/datum/patron/inhumen/zizo)
	H.STASTR = 10
	H.STASPD = 6
	H.STACON = 9
	H.STAEND = 10
	H.STAINT = 6
	H.STAPER = 10
	// Now comes their skills.
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)	//Fuck it, they can keep it cus their stats are ass.
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows , 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/slings, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	//Good non-combat skills for shit. They get shit intel and no level ups so good crafting stats.
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/masonry, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/traps, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/engineering, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/mining, 4, TRUE)			//Good miner.
	H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 3, TRUE)
	// Now comes the loadout armor.
	head = /obj/item/clothing/head/roguetown/helmet/kettle/minershelm
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/paalloy
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	neck = /obj/item/clothing/neck/roguetown/coif
	shoes = /obj/item/clothing/shoes/roguetown/sandals/aalloy
	backl = /obj/item/storage/backpack/rogue/satchel
	// Now weapons and misc gear.
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut/aaxe
	beltl = /obj/item/rogueweapon/pick/aalloy
	