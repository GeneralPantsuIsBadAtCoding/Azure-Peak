/datum/advclass/foreigner
	name = "Nomad"
	tutorial = "Foreigners are common in Azuria, but these strangers hail from far, relatively obscure lands, often with completely different cultures and ideals."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/foreigner
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER)
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	classes = list(
		"Easterner" = "A traveler hailing from the distant land of Kazengun, far across the eastern sea. Your fellow countrymen are few and far between in Azuria.",
		"Exile" = "An exile from the Holy See of Otava, accused of heresy and cast out of your homeland. Some consider yours a fate worse than death; the iron mask seared onto your face serving as a permanent reminder of your sins.",
		"Chainbearer" = "In parts of Psydonia, the practice of slavery is still a common sight. You hail from the Raneshen Empire, where the market of flesh is ancient and unbroken, and your coin is earned in the trade of living souls.",
		"Refugee" = "A refugee from the war-torn deserts of Naledi, driven north as your homeland continues to be ravaged by an endless conflict against the Djinn.")
/datum/outfit/job/roguetown/adventurer/foreigner/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	H.cmode_music = 'sound/music/combat_kazengite.ogg'
	var/classes = list("Easterner","Exile","Chainbearer","Refugee")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	switch(classchoice)
		if("Chainbearer")
			to_chat(H, span_warning("In parts of Psydonia, the practice of slavery is still a common sight. \
			You hail from the Ranesheni Empire, where the market of flesh is ancient and unbroken, and your coin is earned in the trade of living souls."))
			mask = /obj/item/clothing/mask/rogue/facemask/steel
			head = /obj/item/clothing/head/roguetown/roguehood/shalal/purple
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			shoes = /obj/item/clothing/shoes/roguetown/shalal
			pants = /obj/item/clothing/under/roguetown/chainlegs
			gloves = /obj/item/clothing/gloves/roguetown/angle
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/purple
			belt = /obj/item/storage/belt/rogue/leather/shalal/purple
			armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
			cloak = /obj/item/clothing/cloak/cape/purple
			backr = /obj/item/rogueweapon/shield/heater
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/flashlight/flare/torch/lantern
			beltr = /obj/item/rogueweapon/sword/long/shotel
			backpack_contents = list(/obj/item/rope/chain = 2, /obj/item/storage/belt/rogue/pouch/coins/poor = 1)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE) //Spawns with pretty good medium armor, but jman skills.
			H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE) //Stabilizing captives.
			H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE) //Doesn't spawn with a saiga, but can ride if they manage to acquire one in-round.
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			H.change_stat(STATKEY_STR, 2)
			H.change_stat(STATKEY_CON, 2)
			H.change_stat(STATKEY_WIL, 1)
			H.grant_language(/datum/language/celestial)

		if("Refugee")
			to_chat(H, span_warning("An asylum-seeker from the war-torn deserts of Naledi, \
			driven north as your homeland continues to be ravaged by an endless conflict against the Djinn."))
			mask = /obj/item/clothing/mask/rogue/lordmask/tarnished
			r_hand = /obj/item/rogueweapon/spear/assegai
			backl = /obj/item/rogueweapon/scabbard/gwstrap
			backr = /obj/item/storage/backpack/rogue/satchel
			wrists = /obj/item/clothing/neck/roguetown/psicross/naledi
			shoes = /obj/item/clothing/shoes/roguetown/sandals
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/hierophant/civilian
			pants = /obj/item/clothing/under/roguetown/skirt/black
			belt = /obj/item/storage/belt/rogue/leather/black
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			head = /obj/item/clothing/head/roguetown/roguehood/shalal/hijab/black
			beltr = /obj/item/flashlight/flare/torch/lantern
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.change_stat(STATKEY_INT, 1)
			H.change_stat(STATKEY_PER, 1)
			H.change_stat(STATKEY_WIL, 1)
			H.change_stat(STATKEY_SPD, 2)
			H.grant_language(/datum/language/celestial)

		if("Exile")
			to_chat(H, span_warning("An exile from the Holy See of Otava, accused of heresy and cast out of your homeland. \
			Some consider yours a fate worse than death; the iron mask seared onto your face serving as a permanent reminder of your sins. \
			You are a living example of what becomes of those who stand in defiance of the Otavan inquisition."))
			mask = /obj/item/clothing/mask/rogue/facemask/steel/paalloy/mad_touched
			wrists = /obj/item/clothing/neck/roguetown/psicross
			shirt = /obj/item/clothing/cloak/psydontabard
			gloves = /obj/item/clothing/gloves/roguetown/chain/psydon
			shoes = /obj/item/clothing/shoes/roguetown/boots/psydonboots
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
			backr = /obj/item/storage/backpack/rogue/satchel/otavan
			belt = /obj/item/storage/belt/rogue/leather/rope/dark
			head = /obj/item/clothing/head/roguetown/roguehood/psydon
			beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/whip
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
			ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
			H.change_stat(STATKEY_STR, 1)
			H.change_stat(STATKEY_WIL, 3)
			H.change_stat(STATKEY_CON, 3)
			H.change_stat(STATKEY_SPD, -1)
			H.grant_language(/datum/language/otavan)

		if("Easterner")
			to_chat(H, span_warning("A traveler hailing from the distant land of Kazengun, far across the eastern sea. \
			 Your fellow countrymen are few and far between in Azuria."))
			var/subclasses = list("Okaru (Warrior)","Yoruku (Rogue)")
			var/subclasschoice = input("Choose your archetypes", "Available archetypes") as anything in subclasses
			H.grant_language(/datum/language/kazengunese)

			switch(subclasschoice)
				if("Okaru (Warrior)")
					to_chat(H, span_warning("You are an ex-guardian, whether for a petty noble or a small shrine."))
					head = /obj/item/clothing/head/roguetown/mentorhat
					gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
					pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants1
					shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt2
					armor = /obj/item/clothing/suit/roguetown/armor/basiceast
					shoes = /obj/item/clothing/shoes/roguetown/boots
					neck = /obj/item/storage/belt/rogue/pouch/coins/poor
					belt = /obj/item/storage/belt/rogue/leather/black
					backr = /obj/item/storage/backpack/rogue/satchel	
					H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
					H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
					H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
					H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
					H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
					H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
					H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
					backpack_contents = list(
						/obj/item/recipe_book/survival = 1,
						/obj/item/flashlight/flare/torch/lantern,
						)
					H.change_stat(STATKEY_STR, 2)
					H.change_stat(STATKEY_WIL, 1)
					H.change_stat(STATKEY_CON, 2)
					H.set_blindness(0)
					var/weapons = list("Naginata","Quarterstaff","Hwando")
					var/weapon_choice = input("Choose your weapon", "TAKE UP ARMS") as anything in weapons
					switch(weapon_choice)
						if("Naginata")
							r_hand = /obj/item/rogueweapon/spear/naginata
							H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
						if("Quarterstaff")
							backr = /obj/item/rogueweapon/woodstaff/quarterstaff/steel
							H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
						if("Hwando")
							beltl = /obj/item/rogueweapon/sword/sabre/mulyeog
							beltr = /obj/item/rogueweapon/scabbard/sword/kazengun
							H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
							H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)

				if("Yoruku (Rogue)")
					to_chat(H, span_warning("You are a Kazengunese agent trained in assassination, sabotage, and irregular combat."))
					head = /obj/item/clothing/head/roguetown/roguehood/shalal/hijab/yoruku
					backr = /obj/item/storage/backpack/rogue/satchel
					backpack_contents = list(
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/recipe_book/survival = 1,
						/obj/item/smokebomb = 3,
						)
					belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/kazengun
					gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
					pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants1
					shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1
					cloak = /obj/item/clothing/cloak/thief_cloak/yoruku
					shoes = /obj/item/clothing/shoes/roguetown/boots
					H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
					H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
					H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
					H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
					H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
					H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
					H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
					H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
					ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
					H.change_stat(STATKEY_PER, 1)
					H.change_stat(STATKEY_WIL, 1)
					H.change_stat(STATKEY_SPD, 3)
					H.set_blindness(0)
					var/weapons = list("Tanto","Kodachi")
					var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
					switch(weapon_choice)
						if("Tanto")
							beltr = /obj/item/rogueweapon/huntingknife/idagger/steel/kazengun
							beltl = /obj/item/rogueweapon/scabbard/sheath/kazengun
							H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
						if("Kodachi")
							beltr = /obj/item/rogueweapon/sword/short/kazengun
							beltl = /obj/item/rogueweapon/scabbard/sword/kazengun/kodachi
							H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
					var/masks = list("Oni","Kitsune")
					var/mask_choice = input("Choose your mask.", "HIDE YOURSELF") as anything in masks
					switch(mask_choice)
						if("Oni")
							mask = /obj/item/clothing/mask/rogue/facemask/yoruku_oni
						if("Kitsune")
							mask = /obj/item/clothing/mask/rogue/facemask/yoruku_kitsune

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/hierophant/civilian
	name = "shawl"
	desc = "Thick and protective while remaining light and breezy; the perfect garb for protecting one from the hot sun and the harsh sands of Naledi."
	color = CLOTHING_BLACK

/obj/item/clothing/head/roguetown/roguehood/shalal/hijab/black
	color = CLOTHING_BLACK

/obj/item/storage/belt/rogue/leather/shalal/purple
	color = CLOTHING_PURPLE