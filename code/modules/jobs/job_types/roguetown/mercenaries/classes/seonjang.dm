/datum/advclass/mercenary/seonjang //shitcode approved by free
	name = "Seonjang"
	tutorial = "The respected leader and singular representative of the Ruma clan, you're an experienced swordsman. It matters not where the coin comes from, so long as you can make enough to support the clan in its survival from the Xinyi Dynasty and its conflicts, now in strange lands."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = NON_DWARVEN_RACE_TYPES
	outfit = /datum/outfit/job/roguetown/mercenary/seonjang
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_CRITICAL_RESISTANCE, TRAIT_HARDDISMEMBER, TRAIT_NOPAINSTUN)
	cmode_music = 'sound/music/combat_kazengite.ogg'
	maximum_possible_slots = 1
	subclass_stats = list(
		STATKEY_CON = 3,
		STATKEY_WIL = 3,
		STATKEY_STR = 2,
		STATKEY_PER = 1,
		STATKEY_SPD = -1
	)

/datum/outfit/job/roguetown/mercenary/seonjang/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/sword/sabre/mulyeog/rumacaptain
	beltl = /obj/item/rogueweapon/scabbard/sword/kazengun/gold
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/roguekey/mercenary,
		/obj/item/flashlight/flare/torch,
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
	H.adjust_blindness(-3)

	if(should_wear_masc_clothes(H))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1
		cloak = /obj/item/clothing/cloak/eastcloak1
		pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/eastpants1
		gloves = /obj/item/clothing/gloves/roguetown/eastgloves2
		armor = /obj/item/clothing/suit/roguetown/shirt/undershirt/easttats
		shoes = /obj/item/clothing/shoes/roguetown/boots
		H.change_stat(STATKEY_WIL, 1)
		H.change_stat(STATKEY_CON, 1) //to compensate for the permanent lack of armor
		H.dna.species.soundpack_m = new /datum/voicepack/male/evil()
	else if(should_wear_femme_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/armor/basiceast/captainrobe
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/easttats
		shoes = /obj/item/clothing/shoes/roguetown/armor/rumaclan
	H.grant_language(/datum/language/kazengunese)
	H.merctype = 9
