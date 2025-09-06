/datum/job/roguetown/crier
	title = "Town Crier"
	tutorial = "Keeper of the Horn, Master of the Jabberline, and self-appointed Voice of Reason. From your desk in the SCOM atelier, you decide which words will thunder across the realm and which will die in the throats of petitioners who didn't pay enough ratfeed. Nobles and cutpurses alike shuffle up to your counter, coins in hand, desperate for a moment in the golden glow of the broadcast horn. In your upstairs studio, you host debates, recite gossip, and spin tales that will ripple through every corner of town. After all, you hold the true power: the power to decide what all of the city hears... and how loudly."
	flag = CRIER
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	allowed_races = ALL_RACES_TYPES
	allowed_ages = ALL_AGES_LIST

	outfit = /datum/outfit/job/roguetown/loudmouth
	display_order = JDO_CRIER
	give_bank_account = 15
	min_pq = 3 // Has actual responsibility and is a key figure in town.
	max_pq = null
	round_contrib_points = 3

/datum/outfit/job/roguetown/loudmouth/pre_equip(mob/living/carbon/human/H)
	..()
	if(should_wear_femme_clothes(H))
		pants = /obj/item/legwears/black
	else
		pants = /obj/item/clothing/under/roguetown/tights/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/black
	armor = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/loudmouth
	head = /obj/item/clothing/head/roguetown/loudmouth
	backr = /obj/item/storage/backpack/rogue/satchel
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltl = /obj/item/roguekey/crier
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	id = /obj/item/scomstone
	backpack_contents = list(
		/obj/item/recipe_book/alchemy
	)

	H.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
	H.grant_language(/datum/language/elvish)
	H.grant_language(/datum/language/dwarvish)
	H.grant_language(/datum/language/celestial)
	H.grant_language(/datum/language/hellspeak)
	H.grant_language(/datum/language/orcish)
	H.grant_language(/datum/language/grenzelhoftian)
	H.grant_language(/datum/language/otavan)
	H.grant_language(/datum/language/etruscan)
	H.grant_language(/datum/language/gronnic)
	H.grant_language(/datum/language/kazengunese)
	H.grant_language(/datum/language/draconic)
	H.grant_language(/datum/language/aavnic) // All but beast, which is associated with werewolves.
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, "[type]")
	ADD_TRAIT(H, TRAIT_INTELLECTUAL, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCYNE_T1, TRAIT_GENERIC)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_INT, 3)
	H.change_stat(STATKEY_WIL, 3)
	if (H && H.mind)
		H.mind.adjust_spellpoints(6)
	if(H.age == AGE_OLD)
		H.change_stat(STATKEY_SPD, -1)
		H.change_stat(STATKEY_INT, 1)
