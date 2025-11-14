/datum/advclass/wapprentice/practice
	name = "Magician Practice"
	tutorial = "You are a magician who has chosen the path of the blade and magic. You still have a lot to learn, both swordsmanship and magic."
	outfit = /datum/outfit/job/roguetown/wapprentice/practice

	category_tags = list(CTAG_WAPPRENTICE)
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_INT = 1,
		STATKEY_WIL = 1,
		STATKEY_CON = 1,
	)
	subclass_spellpoints = 15
	subclass_skills = list(
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/swords = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/axes = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/maces = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/polearms = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/shields = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/magic/arcane = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
	)

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
				H.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
			if("Steel Warhammer & Buckler Shield")
				beltr = /obj/item/rogueweapon/mace/warhammer/steel
				backr = /obj/item/rogueweapon/shield/buckler
				H.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			if("Billhook")
				r_hand = /obj/item/rogueweapon/spear/billhook
				H.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		switch(H.patron?.type)
			if(/datum/patron/inhumen/zizo)
				H.cmode_music = 'sound/music/combat_heretic.ogg'
