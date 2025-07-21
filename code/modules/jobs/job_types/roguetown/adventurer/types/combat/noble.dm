/datum/advclass/noble
	name = "Noble"
	tutorial = "Traveling nobility from other regions of the world."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_NO_CONSTRUCT
	outfit = /datum/outfit/job/roguetown/adventurer/noble
	traits_applied = list(TRAIT_OUTLANDER)
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	classes = list("Aristocrat" = "You are a traveling noble visiting foreign lands. With wealth, come the poor, ready to pilfer you of your hard earned (inherited) coin, so tread lightly unless you want to meet a grizzly end.",
				"Knight Errant" = "You are a knight from a distant land, a scion of a noble house visiting Azuria for one reason or another.",
				"Squire Errant" = "You are a squire who has traveled far in search of a master to train you and a lord to knight you.")

	cmode_music = 'sound/music/combat_knight.ogg'

/datum/outfit/job/roguetown/adventurer/noble/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Aristocrat","Knight Errant","Squire Errant")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Aristocrat")
			to_chat(H, span_warning("You are a traveling noble visiting foreign lands. With wealth, come the poor, ready to pilfer you of your hard earned (inherited) coin, so tread lightly unless you want to meet a grizzly end."))
			shoes = /obj/item/clothing/shoes/roguetown/boots
			belt = /obj/item/storage/belt/rogue/leather/black
			beltr = /obj/item/flashlight/flare/torch/lantern
			backl = /obj/item/storage/backpack/rogue/satchel
			neck = /obj/item/storage/belt/rogue/pouch/coins/rich
			id = /obj/item/clothing/ring/silver
			beltl = /obj/item/rogueweapon/sword/sabre/dec
			l_hand = /obj/item/rogueweapon/scabbard/sword
			if(should_wear_masc_clothes(H))
				cloak = /obj/item/clothing/cloak/half/red
				shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/red
				pants = /obj/item/clothing/under/roguetown/tights/black
			if(should_wear_femme_clothes(H))
				shirt = /obj/item/clothing/suit/roguetown/shirt/dress/gen/purple
				pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/purple
				cloak = /obj/item/clothing/cloak/raincloak/purple
			H.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
			backpack_contents = list(/obj/item/recipe_book/survival = 1) // Someone gonna argue it is sovlful to not have this but whatever
			var/turf/TU = get_turf(H)
			if(TU)
				new /mob/living/simple_animal/hostile/retaliate/rogue/saiga/tame/saddled(TU)
			ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
			H.change_stat("strength", 1)
			H.change_stat("perception", 2)
			H.change_stat("speed", 1)
			H.change_stat("intelligence", 2)
			H.set_blindness(0)

		if("Knight Errant")
			to_chat(H, span_warning("You are a knight from a distant land, a scion of a noble house visiting Azuria for one reason or another."))
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
				"Slitted Kettle"		= /obj/item/clothing/head/roguetown/helmet/heavy/knight/skettle,
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

			gloves = /obj/item/clothing/gloves/roguetown/chain
			pants = /obj/item/clothing/under/roguetown/chainlegs
			cloak = /obj/item/clothing/cloak/stabard
			neck = /obj/item/clothing/neck/roguetown/bevor
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
			wrists = /obj/item/clothing/wrists/roguetown/bracers
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor
			belt = /obj/item/storage/belt/rogue/leather/steel/tasset
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/flashlight/flare/torch/lantern
			backpack_contents = list(
				/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
				/obj/item/recipe_book/survival = 1,
				)
			H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
			var/turf/TU = get_turf(H)
			if(TU)
				new /mob/living/simple_animal/hostile/retaliate/rogue/saiga/tame/saddled(TU)
			H.set_blindness(0)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
			var/weapons = list("Longsword","Mace + Shield","Flail + Shield","Billhook","Battle Axe","Greataxe")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Longsword")
					H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
					beltr = /obj/item/rogueweapon/sword/long
					r_hand = /obj/item/rogueweapon/scabbard/sword
				if("Mace + Shield")
					H.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
					H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
					beltr = /obj/item/rogueweapon/mace
					backr = /obj/item/rogueweapon/shield/tower/metal
				if("Flail + Shield")
					H.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
					H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
					beltr = /obj/item/rogueweapon/flail
					backr = /obj/item/rogueweapon/shield/tower/metal
				if("Billhook")
					H.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
					r_hand = /obj/item/rogueweapon/spear/billhook
					backr = /obj/item/gwstrap
				if("Battle Axe")
					H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
					r_hand = /obj/item/rogueweapon/stoneaxe/battle
				if("Greataxe")
					H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
					r_hand = /obj/item/rogueweapon/greataxe
					backr = /obj/item/gwstrap
			H.change_stat("strength", 2)
			H.change_stat("constitution", 1)
			H.change_stat("endurance", 1)
			H.change_stat("intelligence", 1)

		if("Squire Errant")
			to_chat(H, span_warning("You are a squire who has traveled far in search of a master to train you and a lord to knight you."))
			head = /obj/item/clothing/head/roguetown/roguehood
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			cloak = /obj/item/clothing/cloak/stabard
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
			shoes = /obj/item/clothing/shoes/roguetown/boots
			belt = /obj/item/storage/belt/rogue/leather
			backr = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/flashlight/flare/torch/lantern
			backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/rogueweapon/hammer/iron = 1, /obj/item/rogueweapon/tongs = 1, /obj/item/recipe_book/survival = 1)
			var/armors = list("Light Armor","Medium Armor")
			var/armor_choice = input("Choose your armor.", "TAKE UP ARMS") as anything in armors
			switch(armor_choice)
				if("Light Armor")
					shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
					pants = /obj/item/clothing/under/roguetown/trou/leather
					gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
					beltr = /obj/item/rogueweapon/huntingknife/idagger
					ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
				if("Medium Armor")
					shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
					pants = /obj/item/clothing/under/roguetown/chainlegs/iron
					gloves = /obj/item/clothing/gloves/roguetown/chain/iron
					beltr = /obj/item/rogueweapon/sword/iron
					ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.set_blindness(0)
			ADD_TRAIT(H, TRAIT_SQUIRE_REPAIR, TRAIT_GENERIC)
			H.change_stat("strength", 1)
			H.change_stat("perception", 1)
			H.change_stat("intelligence", 2)
			H.change_stat("speed", 1)
