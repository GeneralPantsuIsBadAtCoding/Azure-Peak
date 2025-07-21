/datum/advclass/mage
	name = "Mage"
	tutorial = "Mages are skilled in the arcane. Scholars all over the world spend years studying magic - most do not succeed."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/mage
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	traits_applied = list(TRAIT_OUTLANDER)
	classes = list("Sorcerer" = "You are a learned mage and a scholar, having spent your life studying the arcane and its ways.", 
					"Spellblade" = "You are skilled in both the arcyne art and swordsmanship. But you are not a master of either nor could you channel your magick in armor.",			
					"Spellsinger" = "You belong to a school of bards renowned for their study of both the arcane and the arts.")

/datum/outfit/job/roguetown/adventurer/mage/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Sorcerer", ,"Spellblade", "Spellsinger")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
	
		if("Sorcerer")
			to_chat(H, span_warning("You are a learned mage and a scholar, having spent your life studying the arcane and its ways."))
			head = /obj/item/clothing/head/roguetown/roguehood/mage
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogueweapon/woodstaff
			backpack_contents = list(
				/obj/item/flashlight/flare/torch = 1,
				/obj/item/spellbook_unfinished/pre_arcyne = 1,
				/obj/item/roguegem/amethyst = 1,
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1,
				/obj/item/recipe_book/magic = 1,
				/obj/item/chalk = 1
				)
			H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
			H.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
			if(H.age == AGE_OLD)
				H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
				H.mind?.adjust_spellpoints(6)
			H.change_stat("intelligence", 3)
			H.change_stat("perception", 2)
			H.change_stat("speed", 1)
			H.mind?.adjust_spellpoints(18)
			H.mind?.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_ARCYNE_T3, TRAIT_GENERIC)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander4.ogg'
			switch(H.patron?.type)
				if(/datum/patron/inhumen/zizo)
					H.cmode_music = 'sound/music/combat_heretic.ogg'
		if("Spellblade") // They get a unique spell of air slash
			to_chat(H, span_warning("You are skilled in both the arcyne art and the art of the blade. But you are not a master of either nor could you channel your magick in armor."))
			head = /obj/item/clothing/head/roguetown/bucklehat
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			gloves = /obj/item/clothing/gloves/roguetown/angle
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			backpack_contents = list(/obj/item/flashlight/flare/torch = 1, /obj/item/recipe_book/survival = 1)
			if(H.mind)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/airblade)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/enchant_weapon)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/conjure_weapon)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.change_stat("strength", 2) // Favoring a less speedy and more steady playstyle vs spellsinger
			H.change_stat("intelligence", 1)
			H.change_stat("constitution", 1)
			H.change_stat("endurance", 1)
			H?.mind.adjust_spellpoints(12)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander3.ogg'
			ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_ARCYNE_T2, TRAIT_GENERIC)
			var/weapons = list("Bastard Sword", "Falchion & Wooden Shield", "Messer & Wooden Shield", "Foreign Straight Sword") // Much smaller selection with only three swords. You will probably want to upgrade.
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Bastard Sword")
					beltr = /obj/item/rogueweapon/scabbard/sword
					r_hand = /obj/item/rogueweapon/sword/long
					armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
				if("Falchion & Wooden Shield")
					beltr = /obj/item/rogueweapon/scabbard/sword
					backr = /obj/item/rogueweapon/shield/wood
					r_hand = /obj/item/rogueweapon/sword/falchion
					armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
					H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
				if("Messer & Wooden Shield")
					beltr = /obj/item/rogueweapon/scabbard/sword
					backr = /obj/item/rogueweapon/shield/wood
					r_hand = /obj/item/rogueweapon/sword/iron/messer
					armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
					H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
				if("Foreign Straight Sword")
					r_hand = /obj/item/rogueweapon/sword/sabre/mulyeog // Meant to not have the special foreign scabbards.
					beltr = /obj/item/rogueweapon/scabbard/sword
					armor = /obj/item/clothing/suit/roguetown/armor/basiceast
			switch(H.patron?.type)
				if(/datum/patron/inhumen/zizo)
					H.cmode_music = 'sound/music/combat_heretic.ogg'
		if("Spellsinger")
			to_chat(H, span_warning("You belong to a school of bards renowned for their study of both the arcane and the arts."))
			head = /obj/item/clothing/head/roguetown/spellcasterhat
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/councillor
			gloves = /obj/item/clothing/gloves/roguetown/angle
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/clothing/neck/roguetown/gorget/steel
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/spellcasterrobe
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			beltr = /obj/item/rogueweapon/scabbard/sword
			r_hand = /obj/item/rogueweapon/sword/sabre
			backpack_contents = list(/obj/item/flashlight/flare/torch = 1, /obj/item/recipe_book/survival = 1)
			if(H.mind)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/enchant_weapon)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/conjure_weapon)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.change_stat("intelligence", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 2)
			H?.mind.adjust_spellpoints(12)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander3.ogg'
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_ARCYNE_T2, TRAIT_GENERIC)
			switch(H.patron?.type)
				if(/datum/patron/inhumen/zizo)
					H.cmode_music = 'sound/music/combat_heretic.ogg'
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
