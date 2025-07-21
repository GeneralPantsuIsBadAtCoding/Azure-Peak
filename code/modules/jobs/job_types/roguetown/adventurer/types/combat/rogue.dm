/datum/advclass/rogue
	name = "Rogue"
	tutorial = "Thieves, scoundrels, and silver-tongued charlatans from all walks of life."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/rogue
	traits_applied = list(TRAIT_OUTLANDER)
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	classes = list("Treasure Hunter" = "You are a treasure hunter trained in hunting for valuables. Discern what is treasure or not, your fortune could be hidden anywhere.",
					"Thief" = "You are a scoundrel and a thief. A master in getting into places you shouldn't be and taking things that aren't rightfully yours.",
					"Bard" = "You make your fortune in brothels, flop houses, and taverns – gaining fame for your songs and legends. If there is any truth to them, that is.",
					"Swashbuckler" = "You are a daring rogue of the seas! Swashbucklers wield agile swordplay and acrobatic prowess - fighting dirty to outmaneuver foes with flair.")

/datum/outfit/job/roguetown/adventurer/rogue/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Treasure Hunter","Thief","Bard","Swashbuckler")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	switch(classchoice)
	
		if("Treasure Hunter")
			
			to_chat(H, span_warning("You are a treasure hunter trained in hunting for valuables. Discern what is treasure or not, your fortune could be hidden anywhere."))
			pants = /obj/item/clothing/under/roguetown/trou/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
			backl = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			backr = /obj/item/rogueweapon/shovel
			head = /obj/item/clothing/head/roguetown/fedora
			beltl = /obj/item/flashlight/flare/torch/lantern
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			backpack_contents = list(
				/obj/item/lockpick = 1, 
				/obj/item/rogueweapon/huntingknife = 1, 
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1
				)
			H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander3.ogg'
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC)
			var/weapons = list("Sabre","Whip")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			H.set_blindness(0)
			switch(weapon_choice)
				if("Sabre")
					H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
					beltr = /obj/item/rogueweapon/sword/sabre
					r_hand = /obj/item/rogueweapon/scabbard/sword
				if("Whip")
					H.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
					beltr = /obj/item/rogueweapon/whip
			H.change_stat("strength", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 3)

		if("Thief")
			to_chat(H, span_warning("You are a scoundrel and a thief. A master in getting into places you shouldn't be and taking things that aren't rightfully yours."))
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			backl = /obj/item/storage/backpack/rogue/backpack
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			beltl = /obj/item/quiver/Warrows
			beltr = /obj/item/rogueweapon/mace/cudgel
			backpack_contents = list(
				/obj/item/flashlight/flare/torch = 1,
				/obj/item/rogueweapon/huntingknife/idagger/steel = 1,
				/obj/item/lockpickring/mundane = 1,
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1
				)
			H.cmode_music = 'sound/music/cmode/antag/combat_cutpurse.ogg'
			H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/craft/traps, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.change_stat("strength", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 3)
			H.grant_language(/datum/language/thievescant)
			var/loadouts = list("Local Scoundrel","Eastern Agent")
			var/loadout_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in loadouts
			H.set_blindness(0)
			switch(loadout_choice)
				if("Local Scoundrel")
					backpack_contents = list(
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/rogueweapon/huntingknife/idagger/steel = 1,
						/obj/item/lockpickring/mundane = 1,
						/obj/item/recipe_book/survival = 1,
						)
					belt = /obj/item/storage/belt/rogue/leather/knifebelt/iron
					gloves = /obj/item/clothing/gloves/roguetown/fingerless
					pants = /obj/item/clothing/under/roguetown/trou/leather
					shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
					cloak = /obj/item/clothing/cloak/raincloak/mortus
				if("Eastern Agent")
					backpack_contents = list(
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/rogueweapon/huntingknife/idagger/steel/kazengun = 1,
						/obj/item/rogueweapon/scabbard/sheath = 1,
						/obj/item/lockpickring/mundane = 1,
						/obj/item/recipe_book/survival = 1,
						)
					belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/kazengun
					gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
					pants = /obj/item/clothing/under/roguetown/trou/leather/eastern
					shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1
					cloak = /obj/item/clothing/cloak/thief_cloak
					head = /obj/item/clothing/head/roguetown/mentorhat //other armor pieces are nerfed to justify this

		if("Bard")
			to_chat(H, span_warning("You make your fortune in brothels, flop houses, and taverns – gaining fame for your songs and legends. If there is any truth to them, that is."))
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/music, 5, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
			head = /obj/item/clothing/head/roguetown/bardhat
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			beltl = /obj/item/flashlight/flare/torch/lantern
			beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
			backl = /obj/item/storage/backpack/rogue/satchel
			cloak = /obj/item/clothing/cloak/half/red
			backpack_contents = list(
				/obj/item/lockpick = 1,
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1
				)
			if(H.mind)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander3.ogg'
			var/weapons = list("Harp","Lute","Accordion","Guitar","Hurdy-Gurdy","Viola","Vocal Talisman")
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
			H.change_stat("intelligence", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 2)

		if("Swashbuckler")
			to_chat(H, span_warning("You are a daring rogue of the seas! Swashbucklers wield agile swordplay and acrobatic prowess - fighting dirty to outmaneuver foes with flair."))
			head = /obj/item/clothing/head/roguetown/helmet/tricorn
			pants = /obj/item/clothing/under/roguetown/tights/sailor
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogue/instrument/hurdygurdy
			belt = /obj/item/storage/belt/rogue/leather/knifebelt/iron
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			beltl = /obj/item/flashlight/flare/torch/lantern
			beltr = /obj/item/rogueweapon/sword/cutlass
			backpack_contents = list(
				/obj/item/bomb = 1,
				/obj/item/lockpick = 1,
				/obj/item/rogueweapon/huntingknife/idagger/steel/parrying = 1,
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1
				)
			H.cmode_music = 'sound/music/jukeboxes/oldschool/Sea_Shanty2.ogg'
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)
			ADD_TRAIT (H, TRAIT_DECEIVING_MEEKNESS, TRAIT_GENERIC)
			H.change_stat("strength", 1)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 2)
