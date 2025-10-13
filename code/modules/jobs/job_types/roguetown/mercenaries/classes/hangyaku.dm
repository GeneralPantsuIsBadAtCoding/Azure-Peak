/datum/advclass/mercenary/hangyaku
	name = "Wandering Hangyaku"
	tutorial = "Rebel. Outlaw. Failure. Once, you served the upper echelons of Kazengun society as more than just a 'knight'- you were a bodyguard, a beacon of virtue, a legend in the making. Now you wander distant Psydonia, seeking a fresh start... or fresh coin, at least."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_NO_CONSTRUCT //do they have constructs in kazengun?
	outfit = /datum/outfit/job/roguetown/mercenary/hangyaku
	subclass_languages = list(/datum/language/kazengunese)
	class_select_category = CLASS_CAT_KAZENGUN
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_NOBLE) //i hate nobles but it's thematic
	cmode_music = 'sound/music/combat_kazengite.ogg'
	subclass_stats = list(
		STATKEY_CON = 2,
		STATKEY_WIL = 2,
		STATKEY_STR = 2,
		STATKEY_PER = 2,
		STATKEY_SPD = -1
	)
	subclass_skills = list( //impressively limited in terms of what they can do. this is a wall that doesn't do much else.
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/sneaking = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/bows = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN, //doesn't do much, but they're meant to be noblemen.
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
	)
	extra_context = "This subclass is race-limited from: Constructs."

/datum/outfit/job/roguetown/mercenary/hangyaku/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.set_blindness(0)
		var/weapons = list("Sword","Great Mace","Spear","Bow")
		var/weapon_choice = input(H, "Choose your weapon.", "WHEN STEEL MUST SPEAK...") as anything in weapons
		switch(weapon_choice)
			if("Sword")
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_EXPERT, TRUE)
				backr = /obj/item/rogueweapon/sword/long/kriegmesser/ssangsudo
			if("Great Mace")
				H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_EXPERT, TRUE)
				r_hand = /obj/item/rogueweapon/mace/goden/kanabo
				backr = /obj/item/rogueweapon/scabbard/gwstrap
			if("Spear")
				H.adjust_skillrank_up_to(/datum/skill/combat/polearms, SKILL_LEVEL_EXPERT, TRUE)
				r_hand = /obj/item/rogueweapon/spear/naginata
				backr = /obj/item/rogueweapon/scabbard/gwstrap
			if("Bow")
				H.adjust_skillrank_up_to(/datum/skill/combat/bows, SKILL_LEVEL_EXPERT, TRUE)
				backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
				beltr = /obj/item/quiver/arrows
		var/armors = list("Heavy Armor","Medium Armor")
		var/armor_choice = input(H, "Choose your armor.", "...THE TONGUE MUST STAY QUIET.") as anything in armors
		switch(armor_choice)
			if("Heavy Armor")
				ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
				head = /obj/item/clothing/head/roguetown/helmet/heavy/kabuto
				armor = /obj/item/clothing/suit/roguetown/armor/plate/full/samsibsa
				shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
				pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			if("Medium Armor")
				ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
				head = /obj/item/clothing/head/roguetown/helmet/kettle/jingasa
				armor = /obj/item/clothing/suit/roguetown/armor/brigandine/haraate
				shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/random
				pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/kazengun
		var/masks = list("Full Mask","Half-Mask")
		var/mask_choice = input(H, "Choose your mask.", "GREET THE SUN?") as anything in masks
		switch(mask_choice)
			if("Full Mask")
				mask = /obj/item/clothing/mask/rogue/facemask/steel/kazengun/full
			if("Half-Mask")
				mask = /obj/item/clothing/mask/rogue/facemask/steel/kazengun

	to_chat(H, span_warning("Rebel. Outlaw. Failure. Once, you served the upper echelons of Kazengun society as more than just a 'knight'- you were a bodyguard, a beacon of virtue, a legend in the making. Now you wander distant Psydonia, seeking a fresh start... or fresh coin, at least."))
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/gorget/steel/kazengun
	cloak = /obj/item/clothing/cloak/kazengun
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced/kazengun
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	gloves = /obj/item/clothing/gloves/roguetown/plate/kote
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/roguekey/mercenary,
		/obj/item/flashlight/flare/torch/lantern,
		/obj/item/storage/belt/rogue/pouch/coins/poor,
		)
	H.merctype = 9
