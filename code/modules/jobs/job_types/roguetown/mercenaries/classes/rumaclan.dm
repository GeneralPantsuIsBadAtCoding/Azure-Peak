/datum/advclass/mercenary/rumaclan
	name = "Ruma Clan"
	tutorial = "A band of foreign outcast Kazengunites. The Ruma Clan were outcasts from the Xinyi Dynasty, believed to be associated with the rebels at the time. The clan departed lest they risked being executed for such suspicions, or worse. It is no organized group of soldiers, but rather a loose collection of experienced fighters."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = NON_DWARVEN_RACE_TYPES //no dwarf sprites
	outfit = /datum/outfit/job/roguetown/mercenary/rumaclan
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_OUTLANDER)
	cmode_music = 'sound/music/combat_kazengite.ogg'
	classes = list("Kyodai" = "You are relatively versed in the art of \"swinging a sword until enemy death.\" - You would gladly take up most jobs for money, or a chance to cut loose.",
					"Ishu" = "You are an archer. Pretty good in the art of \"pelting until enemy death.\" - You would gladly take up most jobs for money, or a chance to shoot loose.")
/datum/outfit/job/roguetown/mercenary/rumaclan/pre_equip(mob/living/carbon/human/H)
	..()

	// CLASS ARCHETYPES
	H.adjust_blindness(-3)
	var/classes = list("Gun-in", "Sasu")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes //probably gonna add in some more classes when i get more sprites

	switch(classchoice)
		if("Gun-in")
			H.set_blindness(0)
			to_chat(H, span_warning("You are well versed and experienced in swordfighting, you have no problem in taking up most jobs so long as the coin is good, for either yourself or the clan and the seonjang."))
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/rogueweapon/scabbard/sword/kazengun/steel
			beltl = /obj/item/rogueweapon/sword/sabre/mulyeog/rumahench
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt2
			cloak = /obj/item/clothing/cloak/eastcloak1
			armor = /obj/item/clothing/suit/roguetown/shirt/undershirt/easttats
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants2
			shoes = /obj/item/clothing/shoes/roguetown/armor/rumaclan
			gloves = /obj/item/clothing/gloves/roguetown/eastgloves2
			backr = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(
				/obj/item/roguekey/mercenary,
				/obj/item/flashlight/flare/torch/lantern,
				)
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 3)
			H.change_stat("constitution", 3)
			H.change_stat("perception", 1)
			H.change_stat("speed", -1)

		if("Sasu")
			H.set_blindness(0)
			to_chat(H, span_warning("You are an archer of the clan, many have called you an true marksman for your skills with the bow. You have no problem in taking up most jobs so long as the coin is good, for either yourself or the clan and the seonjang."))
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/quiver/arrows
			beltl = /obj/item/flashlight/flare/torch/lantern
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt2
			cloak = /obj/item/clothing/cloak/eastcloak1
			armor = /obj/item/clothing/suit/roguetown/shirt/undershirt/easttats
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants2
			shoes = /obj/item/clothing/shoes/roguetown/armor/rumaclan
			gloves = /obj/item/clothing/gloves/roguetown/eastgloves2
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			backr = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(
				/obj/item/roguekey/mercenary,
				/obj/item/storage/belt/rogue/pouch/coins/poor,
				/obj/item/rogueweapon/huntingknife/idagger,
				/obj/item/rogueweapon/scabbard/sheath = 1,
				)
			H.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
			H.change_stat("constitution", -1)
			H.change_stat("endurance", 2)
			H.change_stat("perception", 2)
			H.change_stat("speed", 4)
			H.change_stat("strength", -1)

	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC) //i swear this isn't as good as it sounds
	H.grant_language(/datum/language/kazengunese)
