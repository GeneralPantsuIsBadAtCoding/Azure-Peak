/datum/advclass/wapprentice/practice
	name = "Magician Practice"
	tutorial = "You are a magician who has chosen the path of the blade and magic. You still have a lot to learn, both swordsmanship and magic."
	outfit = /datum/outfit/job/roguetown/wapprentice/practice

	category_tags = list(CTAG_WAPPRENTICE)

/datum/outfit/job/roguetown/wapprentice/practice/pre_equip(mob/living/carbon/human/H)
	to_chat(H, span_warning("You are skilled in both the arcyne art and the art of the blade. But you are not a master of either nor could you channel your magick in armor."))
	head = /obj/item/clothing/head/roguetown/bucklehat
	pants = /obj/item/clothing/under/roguetown/trou/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	gloves = /obj/item/clothing/gloves/roguetown/angle
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	backl = /obj/item/storage/backpack/rogue/satchel
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backpack_contents = list(
		/obj/item/roguegem/amethyst = 1, 
		/obj/item/spellbook_unfinished/pre_arcyne = 1,
		/obj/item/recipe_book/alchemy = 1,
		/obj/item/recipe_book/magic = 1,
		/obj/item/chalk = 1,
		/obj/item/storage/keyring/mageapprentice,
		)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/airblade)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/enchant_weapon)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/conjure_weapon)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.change_stat("strength", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H?.mind.adjust_spellpoints(15)
	ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCYNE_T2, TRAIT_GENERIC)
	var/weapons = list("Bastard Sword", "Falchion & Buckler Shield", "Messer & Buckler Shield", "Battle Axe", "Steel Warhammer & Buckler Shield", "Billhook")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	switch(weapon_choice)
		if("Bastard Sword")
			beltr = /obj/item/rogueweapon/scabbard/sword
			r_hand = /obj/item/rogueweapon/sword/long
			H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Falchion & Buckler Shield")
			beltr = /obj/item/rogueweapon/scabbard/sword
			backr = /obj/item/rogueweapon/shield/buckler
			r_hand = /obj/item/rogueweapon/sword/falchion
			H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Messer & Buckler Shield")
			beltr = /obj/item/rogueweapon/scabbard/sword
			backr = /obj/item/rogueweapon/shield/buckler
			r_hand = /obj/item/rogueweapon/sword/short/messer/iron
			H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Battle Axe")
			beltr = /obj/item/rogueweapon/stoneaxe/battle
			H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
		if("Steel Warhammer & Buckler Shield")
			beltr = /obj/item/rogueweapon/mace/warhammer/steel
			backr = /obj/item/rogueweapon/shield/buckler
			H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		if("Billhook")
			r_hand = /obj/item/rogueweapon/spear/billhook
			H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	switch(H.patron?.type)
		if(/datum/patron/inhumen/zizo)
			H.cmode_music = 'sound/music/combat_heretic.ogg'
