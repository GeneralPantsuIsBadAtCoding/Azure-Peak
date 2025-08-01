/datum/advclass/foreigner
	name = "Foreigner"
	tutorial = "Strangers from relatively obscure lands, with completely different cultures\
	they usually bring unique and varied fighting styles. They typically originate from Kazengun, or elsewhere."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = NON_DWARVEN_RACE_TYPES //roughneck & custodian sprites dont have dwarf variants - adjust if/when a second update comes out with dwarf sprites
	outfit = /datum/outfit/job/roguetown/adventurer/foreigner
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER)
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	classes = list("Roughneck" = "You are a foreign swordsman, carrying nothing but your sword and its scabbard.",
					"Custodian"= "You are an ex-guardian, whenever that be a petty noble, or a small shrine. You excel in defense with quarterstaffs, or have taken up the Naginata's offensive martial capabilities.",)

/datum/outfit/job/roguetown/adventurer/foreigner/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Roughneck","","Custodian") //more to be added in a later pr
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Roughneck")
			to_chat(H, span_warning("You are a foreign swordsman, carrying nothing but your sword and your skill."))
			head = /obj/item/clothing/head/roguetown/mentorhat
			gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants1
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1
			armor = /obj/item/clothing/suit/roguetown/armor/basiceast
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/rogueweapon/scabbard/sword/kazengun
			beltl = /obj/item/rogueweapon/sword/sabre/mulyeog
			belt = /obj/item/storage/belt/rogue/leather/black
			backr = /obj/item/storage/backpack/rogue/satchel
			H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)		//to encourage use of the scabbard as a shield	
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE) 			//this shouldn't be enough to allow them to craft shit, rather just repair their prone-to-break armor
			backpack_contents = list(
				/obj/item/recipe_book/survival = 1,
				/obj/item/flashlight/flare/torch/lantern,
				)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 2)
			H.set_blindness(0)
			H.cmode_music = 'sound/music/combat_kazengite.ogg'

		if("Custodian")
			to_chat(H, span_warning("You are an ex-guardian, whenever that be for a petty noble, or a small shrine. You excel in defense with quarterstaffs, or have taken up the Naginata's offensive martial capabilities."))
			head = /obj/item/clothing/head/roguetown/mentorhat
			gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants1
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt2
			armor = /obj/item/clothing/suit/roguetown/armor/basiceast/mentorsuit
			shoes = /obj/item/clothing/shoes/roguetown/boots
			belt = /obj/item/storage/belt/rogue/leather/
			beltl = /obj/item/flashlight/flare/torch/lantern
			backl = /obj/item/storage/backpack/rogue/satchel
			H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)		
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			backpack_contents = list(/obj/item/recipe_book/survival = 1)
			H.set_blindness(0)
			var/weapons = list("Naginata","Quarterstaff")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Naginata")
					r_hand = /obj/item/rogueweapon/spear/naginata
				if("Quarterstaff")
					backr = /obj/item/rogueweapon/woodstaff/quarterstaff/steel
			H.change_stat("strength", 2) // Took off the weight and moved it to qstaff
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 2)
			H.cmode_music = 'sound/music/combat_kazengite.ogg'

	H.grant_language(/datum/language/kazengunese)
