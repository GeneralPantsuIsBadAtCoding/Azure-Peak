/datum/advclass/mercenary/grenzelhoft
	name = "Grenzelhoft"
	tutorial = "Experts, Professionals, Expensive. Those are the first words that come to mind when the emperiate Grenzelhoft mercenary guild is mentioned. While you may work for coin like any common sellsword, maintaining the prestige of the guild will be of utmost priority."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/mercenary/grenzelhoft
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_OUTLANDER)
	cmode_music = 'sound/music/combat_grenzelhoft.ogg'	
	classes = list("Doppelsoldner" = "You are a Doppelsoldner - \"Double-pay Mercenary\" - an experienced frontliner trained by the master swordsmen of the Zenitstadt fencing guild.",
					"Halberdier" = "You're an experienced soldier skilled in the use of polearms and axes. Your equals make up the bulk of the mercenary guild's forces.")

/datum/outfit/job/roguetown/mercenary/grenzelhoft/pre_equip(mob/living/carbon/human/H)
	..()

	// CLASS ARCHETYPES
	H.adjust_blindness(-3)
	var/classes = list("Doppelsoldner","Halberdier")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
		if("Doppelsoldner")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a Doppelsoldner - \"Double-pay Mercenary\" - an experienced frontline swordsman trained by the Zenitstadt fencing guild."))
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)	//Won't be using normally with Zwiehander but useful.
			H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)		//Trust me, they'll need it due to stamina drain on their base-sword.
			H.change_stat("strength", 2)	//Should give minimum required stats to use Zweihander
			H.change_stat("endurance", 3)
			H.change_stat("constitution", 3)
			H.change_stat("perception", 1)
			H.change_stat("speed", -1)		//They get heavy armor now + sword option; so lower speed.
			var/weapons = list("Zweihander", "Kriegmesser & Buckler")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Zweihander")
					r_hand = /obj/item/rogueweapon/greatsword/grenz
				if("Kriegmesser & Buckler") // Buckler cuz they have no shield skill.
					r_hand = /obj/item/rogueweapon/scabbard/sword
					beltr = /obj/item/rogueweapon/sword/long/kriegmesser
					l_hand = /obj/item/rogueweapon/shield/buckler
		if("Halberdier")
			H.set_blindness(0)
			to_chat(H, span_warning("You're an experienced soldier skilled in the use of polearms and axes. Your equals make up the bulk of the mercenary guild's forces."))
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)//Now you actually get your fabled axe skill
			H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.change_stat("strength", 2) //same str, worse end, more speed - actually a good tradeoff, now.
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 2)
			H.change_stat("perception", -1)
			H.change_stat("speed", 1)
			var/weapons = list("Halberd", "Partizan")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Halberd")
					r_hand = /obj/item/rogueweapon/halberd
				if("Partizan")
					r_hand = /obj/item/rogueweapon/spear/partizan


	//General gear regardless of class.
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/flashlight/flare/torch
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/grenzelhoft
	head = /obj/item/clothing/head/roguetown/grenzelhofthat
	armor = /obj/item/clothing/suit/roguetown/armor/plate/blacksteel_half_plate
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/grenzelpants
	shoes = /obj/item/clothing/shoes/roguetown/grenzelhoft
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzelgloves
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backl = /obj/item/gwstrap

	backpack_contents = list(
		/obj/item/roguekey/mercenary = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1
		)

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	H.grant_language(/datum/language/grenzelhoftian)
	H.merctype = 7
