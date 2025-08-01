/datum/advclass/mercenary/steppesman
	name = "Steppesman"
	tutorial = "Once serving a Hetmen from the frontiers, you have been rented out as a mercenary in the distant realms to bring coin home. There are three things you value most; saigas, freedom, and coin."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/mercenary/steppesman
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_OUTLANDER)
	cmode_music = 'sound/music/combat_steppe.ogg'
	horse = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/tame/saddled

/datum/outfit/job/roguetown/mercenary/steppesman/pre_equip(mob/living/carbon/human/H)
	..()

	//Universal gear
	belt = /obj/item/storage/belt/rogue/leather/black
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/chargah
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/roguekey/mercenary,
		/obj/item/flashlight/flare/torch,
		/obj/item/rogueweapon/huntingknife/idagger/steel,
		/obj/item/storage/belt/rogue/pouch/coins/poor,
		/obj/item/rogueweapon/whip/nagaika,
		/obj/item/rogueweapon/scabbard/sheath
		)

	//Universal skills
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)

	// CLASS ARCHETYPES
	H.adjust_blindness(-3)
	var/classes = list("Bahadur - Armored Fighter","Druzhina - Ranged Skirmisher","Kozak - Melee Skirmisher")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
		if("Bahadur - Armored Fighter")	//Tl;dr - medium armor class for Mount and Blade larpers who still get a saiga. Akin to Vaquero with specific drip.
			H.set_blindness(0)
			to_chat(H, span_warning("The Bahadur are the elites of the southern steppes, veterans of conflict across the realm. Outfitted with a sabre and shield, these warriors sacrifice their swiftness for armor and civilized respect."))
			shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
			head = /obj/item/clothing/head/roguetown/helmet			//Needs a unique helmet + mask combo at some point. 
			mask = /obj/item/clothing/mask/rogue/facemask			//See above. Trying to emulate a Cuman/Mongolic looking metal face-mask.
			gloves = /obj/item/clothing/gloves/roguetown/chain
			armor = /obj/item/clothing/suit/roguetown/armor/plate/scale/steppe	//Scale armor w/ better durability & unique sprite
			cloak = /obj/item/clothing/cloak/raincloak/furcloak
			wrists = /obj/item/clothing/wrists/roguetown/bracers
			beltr = /obj/item/rogueweapon/shield/wood
			beltl= /obj/item/rogueweapon/scabbard/sword
			l_hand = /obj/item/rogueweapon/sword/sabre
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 2)
			H.change_stat("speed", 1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			H.dna.species.soundpack_m = new /datum/voicepack/male/evil() 	//Fits in my head all too well.
		if("Druzhina - Ranged Skirmisher")	//Tl;dr - light armor class for Tatar-style archery. Has 'Druzhina' as a name cus czech/polish influence, couldn't think of better one.
			H.set_blindness(0)
			to_chat(H, span_warning("A Druzhina, a commoner of the steppes made into a professional soldier. Hunters, herders, and various nomads from all walks of life. Equal in service, equal behind their bow, and ready to fight."))
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
			head = /obj/item/clothing/head/roguetown/helmet
			gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/steppe
			cloak = /obj/item/clothing/cloak/raincloak/furcloak
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			beltr = /obj/item/quiver/javelin/iron
			beltl = /obj/item/quiver/arrows
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			neck = /obj/item/clothing/neck/roguetown/leather
			H.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/slings, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
			H.change_stat("perception", 3)
			H.change_stat("endurance", 2)
			H.change_stat("speed", 2)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		if("Kozak - Melee Skirmisher")		//Tl;dr - Old Steppesman whip build, light armor, be the glass canon you always wanted to be. Live your life, king. 
			H.set_blindness(0)
			to_chat(H, span_warning("Being a Kozak is not a title one earns, nor is born with. It's a way of life. Known to be esentric, living life on the edge - but living as free as possible. Skilled with whips, these madmen are the bane of civilized warriors."))
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
			head = /obj/item/clothing/head/roguetown/papakha	//No helm
			gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/steppe
			cloak = /obj/item/clothing/cloak/volfmantle			//Crazed man, gives the look.
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			beltr = /obj/item/rogueweapon/shield/buckler		//Doesn't get good shield skill + no armor, so they get this to compensate for no parry on whip.
			beltl = /obj/item/rogueweapon/whip
			neck = /obj/item/clothing/neck/roguetown/bevor		//Better neckpiece for slightly less skill variety. Based it off a cool piece of art...
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)		//Bit high but he doesn't get huge strength boons so makes up for it. Same as a guard.
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
			H.change_stat("strength", 1)
			H.change_stat("perception", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 2)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()		//Semi-crazed warrior vibe.
			H.merctype = 11
