/datum/advclass/mercenary/freelancer
	name = "Freifechter"
	tutorial = "You are a graduate of the Aavnic Freifechters - \"Freelancers\" - the Potentate's largest fighting guild, recognized as an encomium to Ravox by decree of the Holy See. It has formed in recent years, but its visitors come from all over Western Psydonia. You have swung one weapon ten-thousand times, and not the other way around. Your trust is placed in your skills, not your equipment."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/mercenary/freelancer
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_OUTLANDER)
	cmode_music = 'sound/music/combat_noble.ogg'	
	classes = list("Fencer" = "You are a master in the arts of the longsword. Wielder of Psydonia's most versatile and noble weapon, you needn't anything else.",
					"Lancer" = "You put complete trust in your polearm, the most effective weapon the world has seen. Why wear armour when you cannot be hit?")
					//"Cortador" = "You completely forego long arms, having proven yourself effective in the teachings of the Etruscan knife-fighting masters of old. Your knife and traditionally decorated cloth shield are unrivaled.")

/datum/outfit/job/roguetown/mercenary/freelancer/pre_equip(mob/living/carbon/human/H)
	..()

	// CLASS ARCHETYPES
	H.adjust_blindness(-3)
	var/classes = list("Fencer","Lancer")/*, "Cortador")*/
	var/classchoice = input("Which master did you train under?", "Available archetypes") as anything in classes

	switch(classchoice)
		if("Fencer")
			H.set_blindness(0)
			to_chat(H, span_warning("You are a master in the arts of the longsword. Wielder of Psydonia's most versatile and noble weapon, you needn't anything else. You can choose a regional longsword."))
			H.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.change_stat("perception", 2)
			H.change_stat("constitution", 4)	//+2 CON in place of END, sorry staminachuds!
			H.change_stat("intelligence", 3)	//To give you an edge in specialty moves like feints and stop you from being feinted
			l_hand = /obj/item/rogueweapon/scabbard/sword
			var/weapons = list("Etruscan Longsword", "Kriegsmesser", "Common Longsword")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Etruscan Longsword")
					r_hand = /obj/item/rogueweapon/sword/long/etruscan
					beltr = /obj/item/rogueweapon/huntingknife/idagger/navaja
				if("Kriegsmesser")
					r_hand = /obj/item/rogueweapon/sword/long/kriegmesser
					beltr = /obj/item/rogueweapon/huntingknife/idagger
				if("Common Longsword")	
					r_hand = /obj/item/rogueweapon/sword/long
					beltr = /obj/item/rogueweapon/huntingknife/idagger
		if("Lancer")
			H.set_blindness(0)
			to_chat(H, span_warning("You put complete trust in your polearm, the most effective weapon the world has seen. Why wear armour when you cannot be hit? You can choose your polearm, and are exceptionally accurate."))
			H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)		//Master polearms is not a super bright idea, maybe.
			H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("perception", 3)
			H.change_stat("constitution", 3)
			H.change_stat("speed", -1)
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half/fencer
			beltr = /obj/item/rogueweapon/scabbard/sheath
			l_hand = /obj/item/rogueweapon/huntingknife/idagger
			backl = /obj/item/gwstrap
			var/weapons = list("Steel Spear", "Lucerne")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Steel Spear")
					r_hand = /obj/item/rogueweapon/spear/boar
				if("Lucerne")
					r_hand = /obj/item/rogueweapon/eaglebeak/lucerne
/*		if("Cortador")								TBA
			H.set_blindness(0)
			to_chat(H, span_warning("You completely forego long arms, having proven yourself effective in the teachings of the Etruscan knife-fighting masters of old. You are a master knife fighter and your \"shield\" can daze opponents easily."))
			H.adjust_skillrank(/datum/skill/combat/knives, 5, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.change_stat("speed", 2)
			H.change_stat("perception", 1)
			H.change_stat("constitution", 1)
			H.change_stat("endurance", 3)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT)
			var/weapons = list("Common Dagger", "Facón Dagger")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Common Dagger")
					r_hand = /obj/item/rogueweapon/huntingknife/idagger/steel
				if("Facón Dagger")
					r_hand = /obj/item/rogueweapon/huntingknife/idagger/steel/freelancer	*/

//Gear regardless of class. This will be changed when Cortador is finished.
	belt = /obj/item/storage/belt/rogue/leather/sash
	beltl = /obj/item/flashlight/flare/torch/lantern
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/freifechter
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan/generic
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced/short
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	backr = /obj/item/storage/backpack/rogue/satchel/short

	backpack_contents = list(/obj/item/roguekey/mercenary)

	H.grant_language(/datum/language/aavnic)		//Your character could not have possibly "graduated" without atleast some basic knowledge of Aavnic.
	H.merctype = 6
