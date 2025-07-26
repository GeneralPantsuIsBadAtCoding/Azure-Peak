/datum/advclass/bogguardsman/ranger//Same deal as sergeant pmuch
	name = "Warden"
	tutorial = "You are a ranger, a hunter who volunteered to become a part of the wardens."
	outfit = /datum/outfit/job/roguetown/bogguardsman/ranger
	category_tags = list(CTAG_WARDEN)

/datum/outfit/job/roguetown/bogguardsman/ranger/pre_equip(mob/living/carbon/human/H)
	..()
	backpack_contents = list(
		/obj/item/storage/keyring/guard = 1,
		/obj/item/flashlight/flare/torch/lantern = 1,
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)
	H.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE) // This should let them fry meat on fires.
	H.change_stat("perception", 2) //7 points weighted, same as MAA. They get temp buffs in the woods instead of in the city.
	H.change_stat("endurance", 1)
	H.change_stat("speed", 2)
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_WOODSMAN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)
	H.adjust_blindness(-3)
	var/armor_options = list("Original", "Dendor Style")
	var/armor_choice = input("Choose your armor.", "TAKE UP ARMS") as anything in armor_options
	H.set_blindness(0)

	switch(armor_choice)
		if("Original")
			head = /obj/item/clothing/head/roguetown/helmet/kettle
			mask = /obj/item/clothing/mask/rogue/wildguard
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/woad
		if("Dendor Style")
			head = /obj/item/clothing/head/roguetown/helmet/bascinet/antler
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/warden
			cloak = /obj/item/clothing/cloak/wardencloak
