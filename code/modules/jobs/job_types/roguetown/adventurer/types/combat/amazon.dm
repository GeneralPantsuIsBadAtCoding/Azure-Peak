/datum/advclass/amazon
	name = "Amazon"
	tutorial = "Amazons are warrior-women from the mysterious isle of Issa. These rare fighters are so tough they can beat an average man!"
	allowed_sexes = list(FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/amazon
	category_tags = list(CTAG_ADVENTURER)

	traits_applied = list(TRAIT_CRITICAL_RESISTANCE, TRAIT_NOPAINSTUN, TRAIT_STEELHEARTED)
	cmode_music = 'sound/music/combat_gronn.ogg'

/datum/outfit/job/roguetown/adventurer/amazon/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/huntingknife
	backl = /obj/item/storage/backpack/rogue/satchel
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/bikini
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots
	var/weapons = list("Sword","Spear")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Sword")
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			beltr = /obj/item/rogueweapon/sword
		if("Spear")
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			r_hand = /obj/item/rogueweapon/spear
	H.change_stat("strength", 2)
	H.change_stat("intelligence", -2)
	H.change_stat("constitution", 3)
	H.change_stat("perception", 2)
	H.change_stat("endurance", 2)
	H.change_stat("speed", 1)
