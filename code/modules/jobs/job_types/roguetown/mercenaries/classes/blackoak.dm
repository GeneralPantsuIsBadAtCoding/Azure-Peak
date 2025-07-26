// Elven unique mercenary type; should be scary in a way solo but easy to kill with a group or bow.
/datum/advclass/mercenary/blackoak
	name = "Black Oak's Guardian"
	tutorial = "A shady guardian of the Black Oaks. Half mercenary band, half irregular militia fighting for control of their ancestral elven homeland of the Peaks. Thankfully, you are not here today to shed the blood of the Duke's men- unless someone pays you to..."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/human/halfelf,
		/datum/species/elf/wood,
	)
	outfit = /datum/outfit/job/roguetown/mercenary/blackoak
	category_tags = list(CTAG_MERCENARY)
	cmode_music = 'sound/music/combat_blackoak.ogg'

/datum/outfit/job/roguetown/mercenary/blackoak/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/elven_boots
	cloak = /obj/item/clothing/cloak/forrestercloak
	gloves = /obj/item/clothing/gloves/roguetown/elven_gloves
	belt = /obj/item/storage/belt/rogue/leather/black
	backl = /obj/item/storage/backpack/rogue/satchel
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/trou/leather
	var/classes = list("Melee (Polearms)", "Ranged (Bows)")
	var/classchoice = input("Choose your archetype", "Available archetypes") as anything in classes
	switch(classchoice)
		if("Melee (Polearms)")
			H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
			H.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 1)
			H.change_stat("perception", 1)
			H.change_stat("intelligence", -1)
			H.change_stat("strength", 3)
			head = /obj/item/clothing/head/roguetown/helmet/heavy/elven_helm
			armor = /obj/item/clothing/suit/roguetown/armor/plate/elven_plate
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			beltl = /obj/item/rogueweapon/huntingknife/idagger/steel/special
			beltr = /obj/item/flashlight/flare/torch
			r_hand = /obj/item/rogueweapon/halberd/glaive
			backr = /obj/item/gwstrap
			backpack_contents = list(
				/obj/item/roguekey/mercenary = 1,
				/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1
				)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		if("Ranged (Bows)")
			H.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
			H.change_stat("constitution", -1)
			H.change_stat("endurance", 2)
			H.change_stat("perception", 2)
			H.change_stat("speed", 3)
			head = /obj/item/clothing/head/roguetown/helmet/sallet/elven
			armor = /obj/item/clothing/suit/roguetown/armor/leather/trophyfur
			neck = /obj/item/clothing/neck/roguetown/chaincoif/full
			beltr = /obj/item/rogueweapon/scabbard/sheath
			r_hand = /obj/item/rogueweapon/huntingknife/idagger/silver/elvish
			beltl = /obj/item/quiver/arrows
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			backpack_contents = list(
				/obj/item/roguekey/mercenary = 1,
				/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
				/obj/item/rogueweapon/huntingknife/idagger/navaja = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1,
				/obj/item/flashlight/flare/torch = 1,
				)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

	//Shared minor skillblock from Wardens
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
	ADD_TRAIT(H, TRAIT_AZURENATIVE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)
	H.merctype = 2
