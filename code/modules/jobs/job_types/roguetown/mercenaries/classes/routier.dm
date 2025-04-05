/datum/advclass/mercenary/routier
	name = "Otavan Routiers"
	tutorial = "The Routiers are a formidable Otavan mercenary band, a brotherhood of knights from noble families serving lords who seek to profit in peacetime. The Otavan nobility at large and even some of the clergy eagerly awaits to hear about your feats, they expect you to ENDURE, to be the champion of their faith and represent the true values of nobility, will you?"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = NON_DWARVEN_RACE_TYPES
	outfit = /datum/outfit/job/roguetown/mercenary/routier
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_OUTLANDER)
	cmode_music = 'sound/music/combat_routier.ogg'

/datum/outfit/job/roguetown/mercenary/routier/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		var/classes = list("Noble Routier", "Routier Footsman")
		var/classchoice = input("Choose your archetype", "Available archetypes") as anything in classes
		switch(classchoice)
			if("Noble Routier")
				H.set_blindness(0)
				to_chat(H, span_warning("You are a Knight of Otava, well experienced in the use of your chosen arms."))
				H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
				H.change_stat("strength", 2)
				H.change_stat("endurance", 2)
				H.change_stat("constitution", 4)
				H.change_stat("perception", 1)
				H.change_stat("speed", -1)
				var/weapons = list("Swordsman","Macebearer","Flailman")
				var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
				H.set_blindness(0)
				switch(weapon_choice)
					if("Swordsman")
						H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
						r_hand = /obj/item/rogueweapon/sword/falchion
					if("Macebearer")
						H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
						r_hand = /obj/item/rogueweapon/mace/steel/morningstar
					if("Flailman")
						H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
						r_hand = /obj/item/rogueweapon/flail/sflail
				wrists = /obj/item/clothing/wrists/roguetown/bracers
				belt = /obj/item/storage/belt/rogue/leather
				beltl = /obj/item/flashlight/flare/torch
				beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
				neck = /obj/item/clothing/neck/roguetown/fencerguard
				shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/otavan
				head = /obj/item/clothing/head/roguetown/helmet/otavan
				armor = /obj/item/clothing/suit/roguetown/armor/otavan
				pants = /obj/item/clothing/under/roguetown/trou/otavan
				shoes = /obj/item/clothing/shoes/roguetown/boots/otavan
				gloves = /obj/item/clothing/gloves/roguetown/otavan
				backr = /obj/item/storage/backpack/rogue/satchel/black
				backl = /obj/item/rogueweapon/shield/tower/metal
				backpack_contents = list(/obj/item/roguekey/mercenary)

				ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
				ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)

			if("Routier Footsman")
				H.set_blindness(0)
				to_chat(H, span_warning("You are a footsman from Otava, a veteran trained under the arch militant. Pikesmen battle-hardened and volunteered to assist the routiers in both hunting and in battle."))
				H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
				H.change_stat("strength", 1)
				H.change_stat("endurance", 2)
				H.change_stat("constitution", 2)
				H.change_stat("perception", 3)
				H.change_stat("speed", 1)
				wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
				belt = /obj/item/storage/belt/rogue/leather
				beltl = /obj/item/rogueweapon/huntingknife
				beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
				neck = /obj/item/clothing/neck/roguetown/coif
				cloak = /obj/item/clothing/cloak/half
				shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
				head = /obj/item/clothing/head/roguetown/duelhat
				armor = /obj/item/clothing/suit/roguetown/armor/leather
				pants = /obj/item/clothing/under/roguetown/trou/otavan
				shoes = /obj/item/clothing/shoes/roguetown/boots/otavan
				gloves = /obj/item/clothing/gloves/roguetown/otavan
				backr = /obj/item/storage/backpack/rogue/satchel
				r_hand = /obj/item/rogueweapon/spear
				backpack_contents = list(/obj/item/roguekey/mercenary)

				ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
