//shield sword
/datum/advclass/sfighter
	name = "Warrior"
	tutorial = "Warriors are well balanced fighters, skilled in blades and capable of most other weapons. \
	they are an important member to most parties for their combat prowess, but not for much more"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/sfighter
	traits_applied = list(TRAIT_HEAVYARMOR)

	category_tags = list(CTAG_ADVENTURER)


/datum/outfit/job/roguetown/adventurer/sfighter/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Warrior","Monster Hunter",)
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Warrior")
			to_chat(H, span_warning("Warriors are well rounded fighters, experienced often in many theaters of warfare and battle they are capable of rising to any challenge that might greet them on the path."))
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			var/weapons = list("Bastard Sword & Shield","Greatsword","Mace & Shield","Billhook","Battle Axe")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			H.set_blindness(0)
			switch(weapon_choice)
				if("Bastard Sword & Shield")
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
					beltr = /obj/item/rogueweapon/sword/long
					backr = /obj/item/rogueweapon/shield/wood
				if("Greatsword")
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
					r_hand = /obj/item/rogueweapon/greatsword/zwei
				if("Mace & Shield")
					H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
					beltr =/obj/item/rogueweapon/mace/spiked
					backr = /obj/item/rogueweapon/shield/wood
				if("Billhook")
					H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
					r_hand = /obj/item/rogueweapon/spear/billhook
				if("Battle Axe")
					H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
					backr = /obj/item/rogueweapon/stoneaxe/battle
			H.change_stat("strength", 2)
			H.change_stat("endurance", 2) // 7 stat points total as a low-skill martial role without magic. Compared to Pally with 5 points.
			H.change_stat("constitution", 2)
			H.change_stat("speed", 1)
			armor = /obj/item/clothing/suit/roguetown/armor/plate
			head = /obj/item/clothing/head/roguetown/helmet/skullcap

		if("Monster Hunter")
			to_chat(H, span_warning("Monster Hunters are typically contracted champions of the common folk dedicated to the slaying of both lesser vermin and greater beasts of the wilds."))
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1) // Weaker endurance compared to a traditional warrior/soldier. Smarter due to study of rare magical beasts.
			H.change_stat("constitution", 2)
			H.change_stat("intelligence", 1)
			H.change_stat("speed", 1)
			armor = /obj/item/clothing/suit/roguetown/armor/plate/scale // No helms for monster hunters.
			var/weapons = list("Bastard Sword & Shield","Greatsword","Mace & Shield","Billhook","Battle Axe")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			H.set_blindness(0)
			switch(weapon_choice)
				if("Bastard Sword & Shield")
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
					beltr = /obj/item/rogueweapon/sword/long
					backr = /obj/item/rogueweapon/shield/wood
				if("Greatsword")
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
					r_hand = /obj/item/rogueweapon/greatsword/zwei
				if("Mace & Shield")
					H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
					beltr =/obj/item/rogueweapon/mace/spiked
					backr = /obj/item/rogueweapon/shield/wood
				if("Billhook")
					H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
					r_hand = /obj/item/rogueweapon/spear/billhook
				if("Battle Axe")
					H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
					backr = /obj/item/rogueweapon/stoneaxe/battle
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/huntingknife
	shoes = /obj/item/clothing/shoes/roguetown/boots
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	pants = /obj/item/clothing/under/roguetown/tights/black
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
