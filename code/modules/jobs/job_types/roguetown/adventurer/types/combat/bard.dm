/datum/advclass/bard
	name = "Bard"
	tutorial = "Bards make up one of the largest populations of \
	registered adventurers in Enigma, mostly because they are \
	the last ones in a party to die. Their wish is to experience \
	the greatest adventures of the age and write amazing songs about them. \
	The class has the option between the jack of all trades Bard, the martial-focused Skald, magic-equip arcanist, and the gospel Hymnist." //Azure peak updated for Hymnist
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/bard
	category_tags = list(CTAG_ADVENTURER)
	cmode_music = 'sound/music/combat_bard.ogg'

/datum/outfit/job/roguetown/adventurer/bard/pre_equip(mob/living/carbon/human/H)
	..() // The entertaining jack of all trades, uniquely handy with crossbows and swords. They're incredibly well travelled, can sneak, steal and survive on their own.
	H.adjust_blindness(-3)
	var/classes = list("Bard","Skald","Arcanist","Hymnist") //Azure Peak Edit for Hymnist
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Bard") // Jack of all trades
			to_chat(H, span_warning("Bards make their fortunes in brothels, flop houses and taverns -- gaining fame for their songs and legends. If there is any truth to them, that is."))
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
			head = /obj/item/clothing/head/roguetown/bardhat
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/tights/random
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
			cloak = /obj/item/clothing/cloak/raincloak/blue
			if(prob(50))
				cloak = /obj/item/clothing/cloak/raincloak/red
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
			backpack_contents = list(
							/obj/item/lockpickring/one = 1,
							/obj/item/flashlight/flare/torch = 1,
							)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 2)
			ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery)
		if("Skald") // Less skilled, better martial prowess. Also a sword!
			to_chat(H, span_warning("Skalds are wandering storytellers, and for many villages they are local historians keeping the tales of great legends and heroes alive."))
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
			head = /obj/item/clothing/head/roguetown/bardhat
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/tights/random
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
			cloak = /obj/item/clothing/cloak/raincloak/blue
			if(prob(50))
				cloak = /obj/item/clothing/cloak/raincloak/red
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/rogueweapon/sword/iron
			backpack_contents = list(
						/obj/item/rogueweapon/huntingknife/idagger/steel,
						/obj/item/storage/belt/rogue/pouch/coins/mid,
						/obj/item/flashlight/flare/torch = 1,
						)
			H.change_stat("constitution", 2)
			H.change_stat("strength", 1)
			H.change_stat("speed", 1)
			H.change_stat("endurance", 1)
			ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)
		if("Arcanist") //Magic and some utility skills, less combat prowess
			to_chat(H, span_warning("Many bards are well-versed in esoteric lore, and indeed, some take up their art for love of the study itself. You're well-read, but you don't tend to come out on the winning side of a barfight."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			H.mind.adjust_spellpoints(1) // total of 3
			head = /obj/item/clothing/head/roguetown/physician
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/tights/black
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/white
			cloak = /obj/item/clothing/cloak/raincloak/purple
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			backpack_contents = list(
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/lockpickring/one = 1,
						)
			H.change_stat("intelligence", 2)
			H.change_stat("perception", 2)
			H.change_stat("speed", 2)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery)
			ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
		if("Hymnist") //Azure Peak Update, Miracles and some utility skills, less combat prowess
			to_chat(H, span_warning("The tales of the gods are mighty indeed, though your skill in their retelling through song has granted you a touch of their favor as thanks."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
			head = /obj/item/clothing/head/roguetown/bardhat
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/tights/black
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/white
			cloak = /obj/item/clothing/cloak/raincloak
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			backpack_contents = list(
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/lockpickring/one = 1
						)
			switch(H.patron?.type)
				if(/datum/patron/divine/astrata)
					neck = /obj/item/clothing/neck/roguetown/psicross/astrata
				if(/datum/patron/divine/noc)
					neck = /obj/item/clothing/neck/roguetown/psicross/noc
				if(/datum/patron/divine/dendor)
					neck = /obj/item/clothing/neck/roguetown/psicross/dendor
				if(/datum/patron/divine/necra)
					neck = /obj/item/clothing/neck/roguetown/psicross/necra
				if(/datum/patron/divine/pestra)
					neck = /obj/item/clothing/neck/roguetown/psicross/pestra
				if(/datum/patron/divine/ravox)
					neck = /obj/item/clothing/neck/roguetown/psicross/ravox
				if(/datum/patron/divine/malum)
					neck = /obj/item/clothing/neck/roguetown/psicross/malum
				if(/datum/patron/divine/eora) //Eora content from Stonekeep
					neck = /obj/item/clothing/neck/roguetown/psicross/eora
			H.change_stat("strength", 1)
			H.change_stat("intelligence", 2)
			H.change_stat("perception", 1)
			H.change_stat("speed", 1)
			var/datum/devotion/C = new /datum/devotion(H, H.patron)
			C.grant_spells_templar(H)
			H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
			ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

	var/weapons = list("Harp","Lute","Accordion","Guitar","Hurdy-Gurdy","Viola","Vocal Talisman")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
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
