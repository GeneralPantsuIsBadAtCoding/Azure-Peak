/datum/advclass/mercenary/freelancer
	name = "Freifechter"
	tutorial = "You are a graduate of the Aavnic Freifechters - \"Freelancers\" - a prestigious fighting guild localized in the independent City-state of Szöréndnížina, recognized as an encomium to Ravox by the Holy See. It has formed an odd thirty yils ago, but its visitors come from all over Western Psydonia. You have swung one weapon ten-thousand times, and not the other way around. This class is for experienced combatants who have a solid grasp on footwork and stamina management, master skills alone won't save your lyfe."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/mercenary/freelancer
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_OUTLANDER)
	cmode_music = 'sound/music/combat_noble.ogg'
	classes = list("Fencer" = "You are a master in the arts of the longsword. Wielder of Psydonia's most versatile and noble weapon, you needn't anything else.",
					"Lancer" = "Your polearm is the most effective weapon the world has seen, 'tis your lyfe's dedication to show why. Why wear armour when you cannot be hit?")
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
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)	//I got told that having zero climbing is a PITA. Bare minimum for a combat class.
			H.change_stat("perception", 3)
			H.change_stat("constitution", 2)
			H.change_stat("intelligence", 4)	//To give you an edge in specialty moves like feints and stop you from being feinted
			l_hand = /obj/item/rogueweapon/scabbard/sword
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half/fencer	//Experimental.
			var/weapons = list("Modified Training Sword !!!CHALLENGE!!!", "Etruscan Longsword", "Kriegsmesser", "Field Longsword")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Modified Training Sword !!!CHALLENGE!!!")		//A sharp feder. Less damage, better defense. Definitely not a good choice.
					r_hand = /obj/item/rogueweapon/sword/long/frei
					beltr = /obj/item/rogueweapon/huntingknife/idagger
				if("Etruscan Longsword")		//A longsword with a compound ricasso. Accompanied by a traditional flip knife.
					r_hand = /obj/item/rogueweapon/sword/long/etruscan
					beltr = /obj/item/rogueweapon/huntingknife/idagger/navaja
				if("Kriegsmesser")		//Och- eugh- German!
					r_hand = /obj/item/rogueweapon/sword/long/kriegmesser
					beltr = /obj/item/rogueweapon/huntingknife/idagger
				if("Field Longsword")		//A common longsword.
					r_hand = /obj/item/rogueweapon/sword/long
					beltr = /obj/item/rogueweapon/huntingknife/idagger
		if("Lancer")
			H.set_blindness(0)
			to_chat(H, span_warning("You put complete trust in your polearm, the most effective weapon the world has seen. Why wear armour when you cannot be hit? You can choose your polearm, and are exceptionally accurate."))
			H.adjust_skillrank(/datum/skill/combat/polearms, 5, TRUE)	//This is the danger zone. Ultimately, the class won't be picked without this. I took the liberty of adjusting everything around to make this somewhat inoffensive, but we'll see if it sticks.
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)	//Wrestling is a swordsman's luxury.
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)	//I got told that having zero climbing is a PITA. Bare minimum for a combat class.
			H.change_stat("strength", 1)
			H.change_stat("speed", 1)	//We want to encourage backstepping since you no longer get an extra layer of armour. I don't think this will break much of anything.
			H.change_stat("perception", 3)
			H.change_stat("constitution", 4)	//This is going to need live testing, since I'm not sure they should be getting this much CON without using a statpack to spec. Revision pending.
			H.change_stat("endurance", -2)
			armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/freifechter
			backl = /obj/item/gwstrap
			var/weapons = list("Graduate's Spear", "Boar Spear", "Lucerne")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Graduate's Spear")		//A steel spear with a cool-looking stick & a banner sticking out of it.
					r_hand = /obj/item/rogueweapon/spear/boar/frei
					l_hand = /obj/item/rogueweapon/katar/punchdagger/frei
				if("Boar Spear")
					r_hand = /obj/item/rogueweapon/spear/boar
					wrists = /obj/item/rogueweapon/katar/punchdagger
				if("Lucerne")		//A normal lucerne for the people that get no drip & no bitches.
					r_hand = /obj/item/rogueweapon/eaglebeak/lucerne
					wrists = /obj/item/rogueweapon/katar/punchdagger
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
	ADD_TRAIT(H, TRAIT_BADTRAINER, TRAIT_GENERIC)
	H.merctype = 6
