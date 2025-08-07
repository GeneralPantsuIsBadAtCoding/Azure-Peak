/datum/job/roguetown/apothecary
	title = "Apothecary"
	flag = APOTHECARY
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT)

	tutorial = "Working under the tutelage of the court physician, you still remain a mere apprentice in the medical arts. Woe is the one who has to suffer your hand holding the scalpel when your master is out."

	outfit = /datum/outfit/job/roguetown/apothecary

	cmode_music = 'sound/music/combat_physician.ogg'

	display_order = JDO_APOTHECARY
	give_bank_account = 30

	min_pq = 0
	max_pq = null
	round_contrib_points = 2

/datum/outfit/job/roguetown/apothecary/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood/black
	pants = /obj/item/clothing/under/roguetown/trou/apothecary
	shirt = /obj/item/clothing/suit/roguetown/shirt/apothshirt
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	belt = /obj/item/storage/belt/rogue/leather/rope
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/storage/belt/rogue/surgery_bag/full/physician
	beltr = /obj/item/roguekey/physician
	id = /obj/item/scomstone/bad
	r_hand = /obj/item/rogueweapon/woodstaff/
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/natural/worms/leech/cheele = 1,
		/obj/item/recipe_book/alchemy = 1,
		/obj/item/clothing/mask/rogue/physician = 1,
	)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE) //enhances survival chances. 
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	H.change_stat("intelligence", 3)
	H.change_stat("perception", 2)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
