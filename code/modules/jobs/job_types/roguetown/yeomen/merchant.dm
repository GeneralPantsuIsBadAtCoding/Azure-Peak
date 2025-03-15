/datum/job/roguetown/merchant
	title = "Merchant"
	flag = MERCHANT
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	selection_color = JCOLOR_YEOMAN
	allowed_races = RACES_ALL_KINDS
	tutorial = "You were born into wealth, learning from before you could talk about the basics of mathematics. Counting coins is a simple pleasure for any person, but you've made it an art form. These people are addicted to your wares, and you are the literal beating heart of this economy: Don't let these filth-covered troglodytes ever forget that."

	display_order = JDO_MERCHANT

	outfit = /datum/outfit/job/roguetown/merchant
	give_bank_account = 22
	noble_income = 100 // Guild Support - The sole Money Role outside of the keep, should help them keep pace a bit + pick up if they get completely knocked out of coin.
	min_pq = 1 //"Yeah...my guy says the best I can do is one PQ, final offer"
	max_pq = null
	required = TRUE
	round_contrib_points = 3
	cmode_music = 'sound/music/combat_noble.ogg'

/datum/outfit/job/roguetown/merchant/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/appraise/secular)
		backpack_contents = /obj/item/rogueweapon/huntingknife/idagger/navaja
	ADD_TRAIT(H, TRAIT_SEEPRICES, type)
	neck = /obj/item/clothing/neck/roguetown/horus
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/merchant
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
	pants = /obj/item/clothing/under/roguetown/tights/sailor
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/storage/keyring/merchant
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	id = /obj/item/clothing/ring/gold
	if(should_wear_masc_clothes(H))
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
	else if(should_wear_femme_clothes(H))
		shoes = /obj/item/clothing/shoes/roguetown/gladiator
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 3)
	H.change_stat("strength", -1)

