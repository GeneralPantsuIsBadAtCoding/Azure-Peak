/datum/advclass/ranger
	name = "Ranger"
	tutorial = "Rangers prefer to keep their enemies at a distance and rely on bows and ranged weaponry."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/ranger
	traits_applied = list(TRAIT_OUTLANDER)
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	classes = list("Sentinel" = "You are a ranger well-versed in traversing untamed lands, with years of experience taking odd jobs as a pathfinder and bodyguard in areas of wilderness untraversable to common soldiery.",
					"Assassin" = "You've lived the life of a hired killer and have spent your time training with blades and crossbows alike.",
					"Bombadier" = "Bombs? You've got them. Plenty of them - and the skills to make more. You've spent years training under skilled alchemists and have found the perfect mix to create some chaos - now go blow something up!",
					"Biome Wanderer" = "The dangers of the wilds vary upon the plains they rest upon, You happen to be experienced in many.")

/datum/outfit/job/roguetown/adventurer/ranger/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Sentinel","Assassin","Bombadier","Biome Wanderer")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
	
		if("Sentinel")
			to_chat(H, span_warning("You are a ranger well-versed in traversing untamed lands, with years of experience taking odd jobs as a pathfinder and bodyguard in areas of wilderness untraversable to common soldiery."))
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			pants = /obj/item/clothing/under/roguetown/trou/leather
			gloves = /obj/item/clothing/gloves/roguetown/leather
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			cloak = /obj/item/clothing/cloak/raincloak/green
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/flashlight/flare/torch/lantern
			backpack_contents = list(
				/obj/item/bait = 1,
				/obj/item/rogueweapon/huntingknife = 1,
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1
				)
			H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
			H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
			H.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
			H.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
			H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander3.ogg'
			var/weapons = list("Recurve Bow","Crossbow")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			H.set_blindness(0)
			switch(weapon_choice)
				if("Recurve Bow")
					H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
					backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
					beltl = /obj/item/quiver/arrows
				if("Crossbow")
					H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
					backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
					beltl = /obj/item/quiver/bolts
			H.change_stat("perception", 3)
			H.change_stat("speed", 2)

		if("Assassin")
			to_chat(H, span_warning("You've lived the life of a hired killer and have spent your time training with blades and crossbows alike."))
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			belt = /obj/item/storage/belt/rogue/leather/knifebelt/iron
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
			beltr = /obj/item/quiver/bolts
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			backpack_contents = list(
				/obj/item/flashlight/flare/torch = 1,
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1
				)
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander.ogg'
			H.change_stat("perception", 2)
			H.change_stat("speed", 2)
			H.change_stat("endurance", 1)
			H.grant_language(/datum/language/thievescant)
			H.set_blindness(0)

		if("Bombadier")
			to_chat(H, span_warning("Bombs? You've got them. Plenty of them - and the skills to make more. You've spent years training under skilled alchemists and have found the perfect mix to create some chaos - now go blow something up!"))
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			head = /obj/item/clothing/head/roguetown/roguehood
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/mageorange
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			belt = /obj/item/storage/belt/rogue/leather
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/flashlight/flare/torch/lantern
			beltl = /obj/item/rogueweapon/mace/cudgel
			backpack_contents = list(
				/obj/item/bomb = 4,
				/obj/item/rogueweapon/huntingknife = 1,
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1
				)
			H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.adjust_skillrank(/datum/skill/craft/traps, 4, TRUE)
			H.adjust_skillrank(/datum/skill/craft/alchemy, 4, TRUE)
			H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander2.ogg'
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			H.change_stat("constitution", 1)
			H.change_stat("strength", 2)
			H.change_stat("intelligence", 2)
			H.set_blindness(0)

		if("Biome Wanderer")
			to_chat(H, span_warning("The dangers of the wilds vary upon the plains they rest upon, You happen to be experienced in many."))
			head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			belt = /obj/item/storage/belt/rogue/leather
			cloak = /obj/item/clothing/cloak/raincloak/green
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut // Technical main weapon?
			backpack_contents = list(
				/obj/item/rogueweapon/huntingknife = 1,
				/obj/item/flashlight/flare/torch/lantern = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1
				)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE) // Base skill, if not wanted, pick another weapon.
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE) // On par with battlemaster.
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE) // Still a ranger, nerfed. Want more? Go do it yourself, buddy.
			H.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
			H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE) // Won't really equate to much.
			H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander4.ogg'
			ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)
			var/weapons = list("Recurve Bow","Billhook","Sling","Crossbow")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Recurve Bow")
					H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
					backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
					beltl = /obj/item/quiver/arrows
				if("Billhook") // Debatable here, but we love variety.
					H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
					r_hand = /obj/item/rogueweapon/spear/billhook
					backr = /obj/item/gwstrap
				if("Sling")
					H.adjust_skillrank(/datum/skill/combat/slings, 3, TRUE)
					beltl = /obj/item/quiver/sling/iron
					r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/sling
				if("Crossbow") // Hunting crossbows were a thing in these times, shame we don't have an item for it.
					H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
					backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
					beltl = /obj/item/quiver/bolts
			var/armors = list("Light Armor","Medium Armor")
			var/armor_choice = input("Choose your armor.", "TAKE UP ARMS") as anything in armors
			switch(armor_choice)
				if("Light Armor")
					armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
					pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
					gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
					ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
					H.change_stat("speed", 1)
				if("Medium Armor")
					armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
					pants = /obj/item/clothing/under/roguetown/chainlegs/iron
					gloves = /obj/item/clothing/gloves/roguetown/chain/iron
					ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
					H.change_stat("strength", 1)
					H.set_blindness(0)
			H.change_stat("perception", 2) // Look far, but not too far.
			H.change_stat("endurance", 2)
			H.change_stat("intelligence", 1) // Adaptive to their surroundings.
