/datum/advclass/wretch/poacher
	name = "Poacher"
	tutorial = "You have rejected society and its laws, choosing life in the wilderness instead. Simple thieving highwayman or freedom fighter, you take from those who have and give to the have-nots. Fancy, how the latter includes yourself!"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/poacher
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER, TRAIT_DODGEEXPERT, TRAIT_OUTLAW, TRAIT_WOODSMAN, TRAIT_OUTDOORSMAN, TRAIT_HERESIARCH)


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
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	beltl = /obj/item/quiver/arrows
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	backpack_contents = list(
		/obj/item/bait = 1,
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/flashlight/flare/torch/lantern/prelit = 1,
		/obj/item/rope/chain = 1,
		)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 4, TRUE)
	//these people live in the forest so let's give them some peasant skills
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	H.cmode_music = 'sound/music/combat_poacher.ogg'
	var/weapons = list("Dagger","Axe", "Cudgel", "My Bow Is Enough")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Dagger")
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			beltr = /obj/item/rogueweapon/scabbard/sheath
			r_hand = /obj/item/rogueweapon/huntingknife/idagger/steel
		if("Axe")
			H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut
		if ("Cudgel")
			H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			beltr = /obj/item/rogueweapon/mace/cudgel
		if ("My Bow Is Enough")
			H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			head = /obj/item/clothing/head/roguetown/duelhat
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 1) // No straight upgrade to perception / speed to not stack one stat too high, but still stronger than MAA Skirm out of town.
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)
	wretch_select_bounty(H)
