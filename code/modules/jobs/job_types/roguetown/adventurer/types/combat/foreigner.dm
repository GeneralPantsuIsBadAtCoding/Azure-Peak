/datum/advclass/foreigner
	name = "Foreigner"
	tutorial = "Strangers from relatively obscure lands, with completely different cultures\
	they usually bring unique and varied fighting styles. They typically originate from Kazengun, or elsewhere."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = NON_DWARVEN_RACE_TYPES //roughneck & custodian sprites dont have dwarf variants - adjust if/when a second update comes out with dwarf sprites
	outfit = /datum/outfit/job/roguetown/adventurer/foreigner
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER)
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	classes = list(
		"Roughneck" = "You are a foreign swordsman, carrying nothing but your sword and its scabbard.",
		"Custodian"= "You are an ex-guardian, whenever that be a petty noble, or a small shrine. You excel in defense with quarterstaffs, or have taken up the \
		Naginata's offensive martial capabilities.",
		"Yoruku" = "You are a Kazengunese agent trained in assassination, sabotage, and irregular combat. You are armed with daggers or a short sword, perfect \
		for combat in the tight confines of castles and back alleys.")

/datum/outfit/job/roguetown/adventurer/foreigner/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list(
		"Roughneck",
		"Custodian",
		"Yoruku",
		)
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Roughneck")
			to_chat(H, span_warning("You are a foreign swordsman, carrying nothing but your sword and your skill."))
			head = /obj/item/clothing/head/roguetown/mentorhat
			gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants1
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1
			armor = /obj/item/clothing/suit/roguetown/armor/basiceast
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/rogueweapon/scabbard/sword/kazengun
			beltl = /obj/item/rogueweapon/sword/sabre/mulyeog
			belt = /obj/item/storage/belt/rogue/leather/black
			backr = /obj/item/storage/backpack/rogue/satchel
			H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)		//to encourage use of the scabbard as a shield	
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE) 			//this shouldn't be enough to allow them to craft shit, rather just repair their prone-to-break armor
			backpack_contents = list(
				/obj/item/recipe_book/survival = 1,
				/obj/item/flashlight/flare/torch/lantern,
				)
			H.change_stat(STATKEY_STR, 2)
			H.change_stat(STATKEY_WIL, 1)
			H.change_stat(STATKEY_CON, 2)
			H.set_blindness(0)
			H.cmode_music = 'sound/music/combat_kazengite.ogg'

		if("Custodian")
			to_chat(H, span_warning("You are an ex-guardian, whenever that be for a petty noble, or a small shrine. You excel in defense with quarterstaffs, or have taken up the Naginata's offensive martial capabilities."))
			head = /obj/item/clothing/head/roguetown/mentorhat
			gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants1
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt2
			armor = /obj/item/clothing/suit/roguetown/armor/basiceast/mentorsuit
			shoes = /obj/item/clothing/shoes/roguetown/boots
			belt = /obj/item/storage/belt/rogue/leather/
			beltl = /obj/item/flashlight/flare/torch/lantern
			backl = /obj/item/storage/backpack/rogue/satchel
			H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)		
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			backpack_contents = list(/obj/item/recipe_book/survival = 1)
			H.set_blindness(0)
			var/weapons = list("Naginata","Quarterstaff")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Naginata")
					r_hand = /obj/item/rogueweapon/spear/naginata
				if("Quarterstaff")
					backr = /obj/item/rogueweapon/woodstaff/quarterstaff/steel
			H.change_stat(STATKEY_STR, 2) // Took off the weight and moved it to qstaff
			H.change_stat(STATKEY_WIL, 1)
			H.change_stat(STATKEY_CON, 2)
			H.cmode_music = 'sound/music/combat_kazengite.ogg'

		if("Yoruku")
			to_chat(H, span_warning("You are a Kazengunese agent trained in assassination, sabotage, and irregular combat. You are armed with daggers or a short sword, perfect \
			for combat in the tight confines of castles and back alleys."))
			head = /obj/item/clothing/head/roguetown/roguehood/shalal/hijab/yoruku
			backr = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(
				/obj/item/flashlight/flare/torch = 1,
				/obj/item/recipe_book/survival = 1,
				/obj/item/smokebomb = 3,
				)
			belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/kazengun
			gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants1
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1
			cloak = /obj/item/clothing/cloak/thief_cloak/yoruku
			shoes = /obj/item/clothing/shoes/roguetown/boots
			H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.change_stat(STATKEY_PER, 1)
			H.change_stat(STATKEY_WIL, 1)
			H.change_stat(STATKEY_SPD, 3)
			H.set_blindness(0)
			var/weapons = list("Tanto","Kodachi")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Tanto")
					beltr = /obj/item/rogueweapon/huntingknife/idagger/steel/kazengun
					beltl = /obj/item/rogueweapon/scabbard/sheath/kazengun
					H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
				if("Kodachi")
					beltr = /obj/item/rogueweapon/sword/short/kazengun
					beltl = /obj/item/rogueweapon/scabbard/sword/kazengun/kodachi
					H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
			var/masks = list("Oni","Kitsune")
			var/mask_choice = input("Choose your mask.", "HIDE YOURSELF") as anything in masks
			switch(mask_choice)
				if("Oni")
					mask = /obj/item/clothing/mask/rogue/facemask/yoruku_oni
				if("Kitsune")
					mask = /obj/item/clothing/mask/rogue/facemask/yoruku_kitsune

	H.grant_language(/datum/language/kazengunese)
