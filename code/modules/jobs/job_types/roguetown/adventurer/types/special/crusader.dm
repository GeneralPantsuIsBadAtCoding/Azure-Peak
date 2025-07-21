/datum/advclass/crusader
	name = "Crusader"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/crusader
	traits_applied = list(TRAIT_HEAVYARMOR, TRAIT_MEDIUMARMOR)

	maximum_possible_slots = 1 // Disabled Role

	tutorial = "The crusaders... Knights who have pledged \
	their wealth and lands to the church, taking up the banner \
	of one of the rival Orders dedicated to retaking the holy land. \
	The 451st crusade is sure to be the last."

	category_tags = list(CTAG_DISABLED)

/datum/outfit/job/roguetown/adventurer/crusader
	name = "Crusader"

/datum/outfit/job/roguetown/adventurer/crusader/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)

	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	armor = /obj/item/clothing/cloak/stabard/crusader
	cloak = /obj/item/clothing/cloak/cape/crusader
	gloves = /obj/item/clothing/gloves/roguetown/chain
	backr = /obj/item/rogueweapon/shield/tower/metal
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/scabbard/sword
	r_hand = /obj/item/rogueweapon/sword/decorated
	beltl = /obj/item/clothing/head/roguetown/helmet/heavy/crusader
	neck = /obj/item/clothing/neck/roguetown/psicross/g
	backpack_contents = list(
						/obj/item/storage/belt/rogue/pouch/coins/rich = 1,
						/obj/item/flashlight/flare/torch = 1,
						)

	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("perception", 1)
	H.change_stat("strength", 2)

	for(var/I in SSrole_class_handler.sorted_class_categories[CTAG_ALLCLASS])
		var/datum/advclass/A = I
		if(A.name == name)
			if(A.total_slots_occupied > 1)
				armor = /obj/item/clothing/cloak/stabard/crusader/t
				cloak = /obj/item/clothing/cloak/raincloak/furcloak
				beltl = /obj/item/clothing/head/roguetown/helmet/heavy/crusader/t
				neck = /obj/item/clothing/neck/roguetown/psicross
				r_hand = /obj/item/rogueweapon/sword/sabre
				beltr = /obj/item/rogueweapon/scabbard/sword
				belt = /obj/item/storage/belt/rogue/leather/plaquesilver

	if(H.pronouns == SHE_HER || H.pronouns == THEY_THEM_F)
		backr = /obj/item/storage/backpack/rogue/satchel
		gloves = null
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		backpack_contents = list(
							/obj/item/rogueweapon/huntingknife/idagger/silver = 1,
							/obj/item/storage/belt/rogue/pouch/coins/rich = 1,
							/obj/item/flashlight/flare/torch = 1,
							/obj/item/rogueweapon/scabbard/sheath = 1
							)
		H.change_stat("strength", 1)


	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T1, passive_gain = CLERIC_REGEN_MINOR)	//Minor regen, can level up to T4.

/obj/item/clothing/cloak/stabard/crusader
	name = "surcoat of the golden order"
	icon_state = "crusader_surcoat"
	icon = 'icons/roguetown/clothing/special/crusader.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/crusader.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/crusader.dmi'

/obj/item/clothing/cloak/stabard/crusader/t
	name = "surcoat of the silver order"
	icon_state = "crusader_surcoatt2"

/obj/item/clothing/cloak/cape/crusader
	name = "desert cape"
	icon_state = "crusader_cloak"
	icon = 'icons/roguetown/clothing/special/crusader.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/crusader.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/crusader.dmi'

/obj/item/clothing/head/roguetown/helmet/heavy/crusader
	name = "bucket helm"
	icon_state = "crusader_helm"
	icon = 'icons/roguetown/clothing/special/crusader.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/crusader.dmi'

/obj/item/clothing/head/roguetown/helmet/heavy/crusader/t
	icon_state = "crusader_helmt2"

/obj/item/clothing/cloak/cape/crusader/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/roguetown/cloak)

/obj/item/clothing/cloak/cape/crusader/attack_right(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		CP.rmb_show(user)
		return TRUE
	..()

/obj/item/clothing/cloak/cape/crusader/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))
