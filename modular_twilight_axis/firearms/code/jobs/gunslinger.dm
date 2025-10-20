/datum/advclass/mercenary/twilight_gunslinger
	name = "Gunslinger"
	tutorial = "As gunpowder becomes more widespread accross Grimoria, so do the Gunslingers - those who earn their living through their skill with those advanced weapons. Excelling both with your pistol and your trusty saber, you count yourself as one of these fine gentlemen, travelling the land with but a gun in your hand."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/mercenary/twilight_gunslinger
	maximum_possible_slots = 2
	min_pq = 10
	cmode_music = 'modular_twilight_axis/firearms/sound/music/combat_gunslinger.ogg'
	class_select_category = CLASS_CAT_OTAVA
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_MEDIUMARMOR)
	classes = list("Lone Wolf" = "With no allegiance but to self, you travel through many different lands, finding yourself in employ of those who can afford to pay for your meals and ammunition. Working for the Guild is a novelty for you, but perhaps this is where you'll find a camaraderie you've never known?",
					"Otavan Dragoon" = "Having left the ranks of the Otavan militant orders, you set off into the wider world, selling your combat skills to the highest bidder. Your rare runelock firearm, once awarded to you for your service, is now your primary tool of the trade.")
	subclass_stats = list(
		STATKEY_STR = 1,
		STATKEY_PER = 2,
		STATKEY_CON = 1,
		STATKEY_SPD = 2,
		STATKEY_WIL = 2,
	)
	subclass_skills = list(
		/datum/skill/combat/twilight_firearms = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/medicine = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/tracking = SKILL_LEVEL_APPRENTICE,
	)
	extra_context = "Chooses between Lone Wolf (Sabre & Arquebus Pistol) and Otavan Dragoon (Falchion & Runelock Pistol) subclasses."

/datum/outfit/job/roguetown/mercenary/twilight_gunslinger/pre_equip(mob/living/carbon/human/H)
	..()

	H.adjust_blindness(-3)
	var/classes = list("Lone Wolf","Otavan Dragoon")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
		if("Lone Wolf")
			H.set_blindness(0)
			to_chat(H, span_warning("With no allegiance but to self, you travel through many different lands, finding yourself in employ of those who can afford to pay for your meals and ammunition. Working for the Guild is a novelty for you, but perhaps this is where you'll find a camaraderie you've never known?"))
			H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			beltl = /obj/item/quiver/twilight_bullet/lead
			beltr = /obj/item/gun/ballistic/twilight_firearm/arquebus_pistol
			backl = /obj/item/storage/backpack/rogue/satchel/black
			r_hand = /obj/item/rogueweapon/sword/sabre
			shoes = /obj/item/clothing/shoes/roguetown/grenzelhoft/gunslinger
			gloves = /obj/item/clothing/gloves/roguetown/leather
			head = /obj/item/clothing/head/roguetown/bucklehat/gunslinger
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
			backpack_contents = list(/obj/item/roguekey/mercenary = 1, /obj/item/twilight_powderflask = 1, /obj/item/rogueweapon/huntingknife = 1, /obj/item/storage/belt/rogue/pouch/coins/poor = 1)
		if("Otavan Dragoon")
			H.set_blindness(0)
			to_chat(H, span_warning("Having left the ranks of the Otavan militant orders, you set off into the wider world, selling your combat skills to the highest bidder. Your rare runelock firearm, once awarded to you for your service, is now your primary tool of the trade."))
			if(istype(H.patron, /datum/patron/inhumen/zizo) || istype(H.patron, /datum/patron/inhumen/matthios) || istype(H.patron, /datum/patron/inhumen/graggar) || istype(H.patron, /datum/patron/inhumen/baotha))
				to_chat(H, span_warning("Even if Inhumen once watched over me, my loyalty to them did not survive the trials of Otava. Psydon is one true God!"))
				H.set_patron(/datum/patron/old_god)
			H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
			beltl = /obj/item/quiver/twilight_bullet/runed
			beltr = /obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock
			backl = /obj/item/storage/backpack/rogue/satchel/otavan
			r_hand = /obj/item/rogueweapon/sword/short/falchion
			shoes = /obj/item/clothing/shoes/roguetown/boots/otavan
			gloves = /obj/item/clothing/gloves/roguetown/otavan
			head = /obj/item/clothing/head/roguetown/duelhat/gunslinger
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
			backpack_contents = list(/obj/item/roguekey/mercenary = 1, /obj/item/rogueweapon/huntingknife = 1, /obj/item/storage/belt/rogue/pouch/coins/poor = 1)
			H.merctype = 10
			H.grant_language(/datum/language/otavan)

	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	belt = /obj/item/storage/belt/rogue/leather/black
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half
	backr = /obj/item/rogueweapon/scabbard/sword
	cloak = /obj/item/clothing/suit/roguetown/armor/longcoat
