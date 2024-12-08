/datum/advclass/forlorn
	name = "Forlorn Hope Mercenary"
	tutorial = "The Order of the Forlorn Hope, a order formed off the back of a Zybantian slave revolt. Drawing from all walks of life, this mercenary company now takes ranks from both purchased and liberated slaves. Coin is power, and power is the path to freedom."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/mercenary/forlorn
	min_pq = 2
	cmode_music = 'sound/music/combat_blackstar.ogg'
	category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/forlorn/pre_equip(mob/living/carbon/human/H)
	..()

	H.adjust_blindness(-3)
	var/classes = list("Bindbreaker","Lashturner","Bladehand")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	switch(classchoice)
		if("Bindbreaker")
			H.set_blindness(0)
			to_chat(H, span_warning("There is no better tool to break through the armoured hands that hold those in binds, than that of the simple hammer; and so you use it well to this day- even if now it is a tool fit for war, more than smithing."))
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/clothing/neck/roguetown/gorget/forlorncollar
			head = /obj/item/clothing/head/roguetown/helmet/heavy/volfplate
			pants = /obj/item/clothing/under/roguetown/tights/black
			gloves = /obj/item/clothing/gloves/roguetown/leather/black
			belt = /obj/item/storage/belt/rogue/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
			armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
			beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/mace/warhammer/steel
			backr = /obj/item/storage/backpack/rogue/satchel
			backl = /obj/item/rogueweapon/shield/heater
			backpack_contents = list(/obj/item/rogueweapon/huntingknife, /obj/item/roguekey/mercenary)
			H.change_stat("strength", 3) // big damage, with warhammer. lower speed, and athletics to compensate.
			H.change_stat("endurance", 2) 
			H.change_stat("constitution", 2)
			H.change_stat("speed", -1) 
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
		if("Lashturner")
			H.set_blindness(0)
			to_chat(H, span_warning("The whip may be seen as a tool of captors and slavers by most, perhaps even your comrades; but to you it holds another meaning, to turn the arms and abuse of your former masters unto themselves."))
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE) //a last resort trained well, as they don't have a blocking tool.
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/clothing/neck/roguetown/gorget/forlorncollar
			head = /obj/item/clothing/head/roguetown/helmet/heavy/volfplate
			pants = /obj/item/clothing/under/roguetown/tights/black
			gloves = /obj/item/clothing/gloves/roguetown/leather/black
			belt = /obj/item/storage/belt/rogue/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
			armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
			beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/whip	
			backr = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/rogueweapon/huntingknife, /obj/item/roguekey/mercenary)
			H.change_stat("strength", 1)
			H.change_stat("endurance", 4) // these men survived the lash, and lived to tell the tale. This did not lead to much other excersize.
			H.change_stat("constitution", 3) 
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
		if("Bladehand")
			H.set_blindness(0)
			to_chat(H, span_warning("Come the time of your freedom, you had used the knives and shears of your captors to slit their throats and spill their bowels; though those times have passed- your aptitude for knives has not."))
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)  //climby
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE) //sneaky, too
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) //runny boys as well
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/clothing/neck/roguetown/gorget/forlorncollar
			head = /obj/item/clothing/head/roguetown/helmet/heavy/volfplate
			pants = /obj/item/clothing/under/roguetown/tights/black
			gloves = /obj/item/clothing/gloves/roguetown/leather/black
			belt = /obj/item/storage/belt/rogue/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
			armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
			beltr = /obj/item/rogueweapon/huntingknife/idagger/steel/parrying
			beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
			backr = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/rogueweapon/huntingknife, /obj/item/roguekey/mercenary,/obj/item/storage/belt/rogue/pouch/coins/poor)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 3)
			H.change_stat("speed", 1) //speedy fuck
			H.change_stat("constitution", 1) //not the best at taking hits
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)