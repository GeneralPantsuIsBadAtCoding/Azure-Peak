/datum/advclass/sfighter
	name = "Warrior"
	tutorial = "Trained warriors and estemeed swordsmen from all corners of the world, \
	warriors are defined by martial prowess - whether with a blade or their bare fists."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/sfighter
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER)
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	classes = list("Battlemaster" = "You are a seasoned weapon specialist, clad in maille, with years of experience in warfare and battle under your belt.",
					"Duelist"= "You are an esteemed swordsman who foregoes armor in exchange for a more nimble fighting style.",
					"Barbarian" = "You are a brutal warrior who foregoes armor in order to showcase your raw strength. You specialize in unarmed combat and wrestling.",
					"Monster Hunter" = "You specialize in hunting down monsters and the undead, carrying two blades - one of silver, one of steel.",
					"Flagellant" = "You are a pacifistic warrior who embraces suffering, believing pain is the path to enlightenment. You take the suffering of others upon yourself.")


/datum/outfit/job/roguetown/adventurer/sfighter/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Battlemaster","Duelist","Barbarian","Monster Hunter","Flagellant")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Battlemaster")
			to_chat(H, span_warning("You are a seasoned weapon specialist, clad in maille, with years of experience in warfare and battle under your belt."))
			H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
			H.set_blindness(0)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander2.ogg'
			var/weapons = list("Longsword","Mace","Billhook","Battle Axe","Short Sword & Iron Shield","Iron Saber & Wood Shield")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Longsword")
					H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
					backr = /obj/item/rogueweapon/sword/long
					beltr = /obj/item/rogueweapon/scabbard/sword
				if("Mace")
					H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
					beltr = /obj/item/rogueweapon/mace
				if("Billhook")
					H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
					r_hand = /obj/item/rogueweapon/spear/billhook
					backr = /obj/item/gwstrap
				if("Battle Axe")
					H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
					backr = /obj/item/rogueweapon/stoneaxe/battle
				if("Short Sword & Iron Shield")
					H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
					H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
					backr = /obj/item/rogueweapon/shield/iron
					beltr = /obj/item/rogueweapon/scabbard/sword
					r_hand = /obj/item/rogueweapon/sword/iron/short
				if("Iron Saber & Wood Shield")
					r_hand = /obj/item/rogueweapon/sword/iron/saber
					beltr = /obj/item/rogueweapon/scabbard/sword
					backr = /obj/item/rogueweapon/shield/wood
			var/armors = list("Chainmaille Set","Iron Breastplate","Gambeson & Helmet","Light Naledian Armor")
			var/armor_choice = input("Choose your armor.", "TAKE UP ARMOR") as anything in armors
			switch(armor_choice)
				if("Chainmaille Set")
					armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
					shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/random//giving them something to wear under their armors
					pants = /obj/item/clothing/under/roguetown/chainlegs/iron
					neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
					gloves = /obj/item/clothing/gloves/roguetown/chain/iron
				if("Iron Breastplate")
					armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
					neck = /obj/item/clothing/neck/roguetown/coif/heavypadding
					shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/random
					pants = /obj/item/clothing/under/roguetown/splintlegs/iron
					gloves = /obj/item/clothing/gloves/roguetown/angle
				if("Gambeson & Helmet")
					armor = /obj/item/clothing/suit/roguetown/armor/gambeson
					neck = /obj/item/clothing/neck/roguetown/coif/padded//neck cover
					shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/random
					wrists = /obj/item/clothing/wrists/roguetown/splintarms/iron//adding it since this set feels far too weak compared to the other two, gets one helmet and arm cover at least
					pants = /obj/item/clothing/under/roguetown/trou/leather
					head = /obj/item/clothing/head/roguetown/helmet/kettle
					gloves = /obj/item/clothing/gloves/roguetown/angle
				if("Light Naledian Armor")
					shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/raneshen
					pants = /obj/item/clothing/under/roguetown/trou/leather/pontifex/raneshen
					head = /obj/item/clothing/head/roguetown/roguehood/shalal/hijab
					gloves = /obj/item/clothing/gloves/roguetown/angle
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 2)
			belt = /obj/item/storage/belt/rogue/leather
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			shoes = /obj/item/clothing/shoes/roguetown/boots
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
			backpack_contents = list(
				/obj/item/flashlight/flare/torch = 1,
				/obj/item/rogueweapon/huntingknife = 1,
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1
				)

		if("Duelist")
			to_chat(H, span_warning("You are an esteemed swordsman who foregoes armor in exchange for a more nimble fighting style."))
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_DECEIVING_MEEKNESS, TRAIT_GENERIC)
			H.set_blindness(0)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander2.ogg'
			var/weapons = list("Rapier","Dagger")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Rapier")
					H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
					l_hand = /obj/item/rogueweapon/sword/rapier
					beltl = /obj/item/rogueweapon/scabbard/sword
				if("Dagger")
					H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
					r_hand = /obj/item/rogueweapon/huntingknife/idagger/steel
					beltr = /obj/item/rogueweapon/scabbard/sheath
			H.change_stat("strength", 1)
			H.change_stat("endurance", 1)
			H.change_stat("intelligence", 2)
			H.change_stat("speed", 1)
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			head = /obj/item/clothing/head/roguetown/duelhat
			mask = /obj/item/clothing/mask/rogue/duelmask
			cloak = /obj/item/clothing/cloak/half
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
			pants = /obj/item/clothing/under/roguetown/trou/leather
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/clothing/neck/roguetown/gorget
			gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogueweapon/shield/buckler
			belt = /obj/item/storage/belt/rogue/leather
			backpack_contents = list(
				/obj/item/flashlight/flare/torch = 1,
				/obj/item/rogueweapon/huntingknife/idagger/steel/parrying = 1,
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1
				)

		if("Barbarian")
			to_chat(H, span_warning("You are a brutal warrior who foregoes armor in order to showcase your raw strength. You specialize in unarmed combat and wrestling."))
			H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
			ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
			H.cmode_music = 'sound/music/cmode/antag/combat_darkstar.ogg'
			H.set_blindness(0)
			var/weapons = list("Katar","Axe","Sword","Club","Spear","MY BARE HANDS!!!")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if ("Katar")
					H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
					beltr = /obj/item/rogueweapon/katar
				if("Axe")
					H.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
					beltr = /obj/item/rogueweapon/stoneaxe/boneaxe
				if("Sword")
					H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
					beltr = /obj/item/rogueweapon/sword/short
				if("Club")
					H.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
					beltr = /obj/item/rogueweapon/mace/woodclub
				if("Spear")
					H.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
					r_hand = /obj/item/rogueweapon/spear/bonespear
				if ("MY BARE HANDS!!!")
					H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
					ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)
			H.change_stat("strength", 3)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 2)
			H.change_stat("intelligence", -2)
			if(should_wear_masc_clothes(H))
				H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
				head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
				wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
				pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
				shoes = /obj/item/clothing/shoes/roguetown/boots/leather
				gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
				backl = /obj/item/storage/backpack/rogue/satchel
				belt = /obj/item/storage/belt/rogue/leather
				neck = /obj/item/storage/belt/rogue/pouch/coins/poor
				beltl = /obj/item/rogueweapon/huntingknife
			if(should_wear_femme_clothes(H))
				head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
				armor = /obj/item/clothing/suit/roguetown/armor/leather/bikini
				pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/shorts
				wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
				shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
				gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
				backl = /obj/item/storage/backpack/rogue/satchel
				belt = /obj/item/storage/belt/rogue/leather
				neck = /obj/item/storage/belt/rogue/pouch/coins/poor
				beltl = /obj/item/rogueweapon/huntingknife
			backpack_contents = list(/obj/item/flashlight/flare/torch = 1)

		if("Monster Hunter")
			to_chat(H, span_warning("You specialize in hunting down monsters and the undead, carrying two blades - one of silver, one of steel."))
			H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander2.ogg'
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 1)
			H.change_stat("intelligence", 1)
			beltr = /obj/item/rogueweapon/scabbard/sheath
			r_hand = /obj/item/rogueweapon/sword/silver
			backr = /obj/item/rogueweapon/sword
			backl = /obj/item/storage/backpack/rogue/satchel/black
			wrists = /obj/item/clothing/neck/roguetown/psicross/silver
			armor = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
			belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/steel
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/tights/black
			cloak = /obj/item/clothing/cloak/cape/puritan
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			head = /obj/item/clothing/head/roguetown/bucklehat
			gloves = /obj/item/clothing/gloves/roguetown/angle
			backpack_contents = list(
				/obj/item/flashlight/flare/torch = 1,
				/obj/item/rogueweapon/huntingknife = 1,
				/obj/item/recipe_book/survival = 1,
				)
			beltl = pick(
				/obj/item/reagent_containers/glass/bottle/alchemical/strpot,
				/obj/item/reagent_containers/glass/bottle/alchemical/conpot,
				/obj/item/reagent_containers/glass/bottle/alchemical/endpot,
				/obj/item/reagent_containers/glass/bottle/alchemical/spdpot,
				/obj/item/reagent_containers/glass/bottle/alchemical/perpot,
				/obj/item/reagent_containers/glass/bottle/alchemical/intpot,
				/obj/item/reagent_containers/glass/bottle/alchemical/lucpot,
				)

		if("Flagellant")
			to_chat(H, span_warning("You are a pacifistic warrior who embraces suffering, believing pain is the path to enlightenment."))
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.set_blindness(0)

			ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander2.ogg'
			H.change_stat("constitution", 5)
			H.change_stat("endurance", 5)
			H.change_stat("speed", 1)
			H.change_stat("strength", -2)
			H.change_stat("intelligence", -2)

			pants = /obj/item/clothing/under/roguetown/tights/black
			shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/black
			shoes = /obj/item/clothing/shoes/roguetown/boots
			backl = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/rogueweapon/whip
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			backpack_contents = list(
				/obj/item/recipe_book/survival = 1,
				/obj/item/flashlight/flare/torch = 1,
				)
