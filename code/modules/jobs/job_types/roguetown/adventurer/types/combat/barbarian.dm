//terrify mobs scream
/datum/advclass/barbarian
	name = "Barbarian"
	tutorial = "A jack-of-all-trades warrior sort. Is skilled in all weapons, but master of none"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/barbarian
	traits_applied = list(TRAIT_CRITICAL_RESISTANCE, TRAIT_NOPAINSTUN, TRAIT_STEELHEARTED)
	cmode_music = 'sound/music/combat_gronn.ogg'
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/barbarian/pre_equip(mob/living/carbon/human/H)
	..() // Compared to the Warrior the barbarian is more suited to the wilds. But they are able to make use of almost any weapon by talent and killer instinct.
	H.adjust_blindness(-3)
	var/classes = list("Brute","Hunter Killer","Ravager")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	switch(classchoice)
		if("Brute")
			H.set_blindness(0)
			to_chat(H, span_warning("Barbarians are great warriors of the outlands, often regarded as the strongest of their tribes -- should they have any that live. These incredible titans of strength and brutality are motivated most often by a single... all consuming instinct. SURVIVE."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			backl = /obj/item/storage/backpack/rogue/satchel
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			head = /obj/item/clothing/head/roguetown/helmet/horned
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
			H.change_stat("intelligence", -2)
			H.change_stat("strength", 3) // Barbs are traditionally a mix of strength/resilience.
			H.change_stat("constitution", 3)
			H.change_stat("endurance", 2)
			H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
			var/weapons = list("Shortsword & Knife (Default)","Bastard Sword","Axe")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			H.set_blindness(0)
			switch(weapon_choice)
				if("Shortsword & Knife (Default)")
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
					H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
					beltr = /obj/item/rogueweapon/sword/iron
					beltl = /obj/item/rogueweapon/huntingknife
				if("Bastard Sword")
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
					r_hand = /obj/item/rogueweapon/sword/long
				if("Axe")
					H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
					beltr = /obj/item/rogueweapon/stoneaxe/woodcut
		if("Hunter Killer")
			H.set_blindness(0)
			to_chat(H, span_warning("Barbarians are great warriors of the outlands, often regarded as the strongest of their tribes -- should they have any that live. These incredible titans of strength and brutality are motivated most often by a single... all consuming instinct. SURVIVE."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut
			r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			l_hand = /obj/item/quiver/arrows
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			backr = /obj/item/storage/backpack/rogue/satchel
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			H.change_stat("intelligence", -1) // The hunter is smarter, more skilled -- but not as tough.
			H.change_stat("strength", 2)
			H.change_stat("constitution", 2)
			H.change_stat("endurance", 3)
			H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
		if("Ravager") //Lower constitution/weaponskills, but they're better at unarmed combat than barbs are with a weapon. Good skills, not much gear. Gets extra bite damage.
			H.set_blindness(0)
			to_chat(H, span_warning("Some barbarians eschew the axe in favour of the most faithful weapons anyone could hope for: fist, claw, and fang."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			backr = /obj/item/storage/backpack/rogue/satchel
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			H.change_stat("intelligence", -2)
			H.change_stat("strength", 3)
			H.change_stat("constitution", 2)
			H.change_stat("endurance", 2)
			ADD_TRAIT(H, TRAIT_STRONGBITE, TRAIT_GENERIC) //doubles bite damage, which is 50% of STR.
			H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
