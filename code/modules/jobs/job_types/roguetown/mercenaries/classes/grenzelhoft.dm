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
					"Halberdier" = "You're an experienced soldier skilled in the use of polearms and axes. Your equals make up the bulk of the mercenary guild's forces.",
					"Armbrustschutze" = "You're a proved marksman with a crossbow, and learned how to set up camp and defenses in the wild. The guild needs you.")

/datum/outfit/job/roguetown/mercenary/grenzelhoft/pre_equip(mob/living/carbon/human/H)
	..()

	// CLASS ARCHETYPES
	H.adjust_blindness(-3)
	var/classes = list("Doppelsoldner","Halberdier","Armbrustschutze")
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
			backl = /obj/item/rogueweapon/scabbard/gwstrap
			armor = /obj/item/clothing/suit/roguetown/armor/plate/blacksteel_half_plate
			H.change_stat(STATKEY_STR, 2)	//Should give minimum required stats to use Zweihander
			H.change_stat(STATKEY_WIL, 3)
			H.change_stat(STATKEY_CON, 3)
			H.change_stat(STATKEY_PER, 1)
			H.change_stat(STATKEY_SPD, -1)		//They get heavy armor now + sword option; so lower speed.
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			var/weapons = list("Zweihander", "Kriegmesser & Buckler")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Zweihander")
					r_hand = /obj/item/rogueweapon/greatsword/grenz
				if("Kriegmesser & Buckler") // Buckler cuz they have no shield skill.
					beltr = /obj/item/rogueweapon/scabbard/sword
					r_hand = /obj/item/rogueweapon/sword/long/kriegmesser
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
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)		// Foot soldier that carries the Big Fuckin Polearm around. Also polearm stam drain from the fact they gon' be catching swings all day.
			backl = /obj/item/rogueweapon/scabbard/gwstrap
			armor = /obj/item/clothing/suit/roguetown/armor/plate/blacksteel_half_plate
			H.change_stat(STATKEY_STR, 2) //same str, worse end, more speed - actually a good tradeoff, now.
			H.change_stat(STATKEY_WIL, 2)
			H.change_stat(STATKEY_CON, 2)
			H.change_stat(STATKEY_PER, -1)
			H.change_stat(STATKEY_SPD, 1)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			var/weapons = list("Halberd", "Partizan")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Halberd")
					r_hand = /obj/item/rogueweapon/halberd
				if("Partizan")
					r_hand = /obj/item/rogueweapon/spear/partizan
		if("Armbrustschutze")			//crossbow and axe class. Rearguard. Utility skills, no medium armor, no dodge expert. This is NOT a go-face-first-into-war class.
			H.set_blindness(0)
			to_chat(H, span_warning("You're a proved marksman with a crossbow, and learned how to set up camp and defenses in the wild. The guild needs you."))
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)		// gotta get to a vantage point
			H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)		// this is not only a tool!
			H.adjust_skillrank(/datum/skill/combat/crossbows, 5, TRUE)		//every combat class with a ranged weapon gets this . eat my jorts. They have no dodge expert.
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)		// Make your energy count, little silly individual
			H.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)		// meant to live off the land and set up camp.
			H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)		// learn 2 maintain your uniform.
			H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)		// Just so you don't suck at cooking
			H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)	
			H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)	// crafting for pallisades, lumberjacking for not fucking up wood
			beltr = /obj/item/quiver/bolts
			beltl = /obj/item/rogueweapon/stoneaxe/woodcut/steel
			r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			H.change_stat(STATKEY_STR, 1) // 1 STR for the axe and crossbow reload. END for chopping trees, a bit of SPD for running, PER for shooting. -1 CON bc you aint a frontliner
			H.change_stat(STATKEY_WIL, 2)
			H.change_stat(STATKEY_CON, -1)
			H.change_stat(STATKEY_PER, 2)
			H.change_stat(STATKEY_SPD, 2)
			var/armor_options = list("Light Brigandine", "Studded Leather Vest")
			var/armor_choice = input("Choose your armor.", "DRESS UP") as anything in armor_options
			switch(armor_choice)
				if("Light Brigandine")
					armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light	// find a smithy to fix it
				if("Studded Leather Vest")
					armor = /obj/item/clothing/suit/roguetown/armor/leather/studded		// or maintain it yourself!

	//General gear regardless of class.
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/grenzelhoft
	head = /obj/item/clothing/head/roguetown/grenzelhofthat
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/grenzelpants
	shoes = /obj/item/clothing/shoes/roguetown/grenzelhoft
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzelgloves
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(
		/obj/item/roguekey/mercenary = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)

	H.grant_language(/datum/language/grenzelhoftian)
	H.merctype = 7
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)		// me when my business is combat and I get shocked when ppl lose limbs
