/datum/job/roguetown/clerk
	title = "Clerk"
	flag = CLERK
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)

	tutorial = "Clerk, tax-collector, blessed fool. You help the Steward with anything they need and perform their tasks when they are unavailable. Although you aren't a noble, it's not the worst position. The caveat? If money is misplaced or goes missing, a noble could probably weasel out of the stockades as punishment. You? Eh...well, Etrusca is lovely this time of year."

	outfit = /datum/outfit/job/roguetown/clerk
	display_order = JDO_CLERK
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null
	round_contrib_points = 2

/datum/outfit/job/roguetown/clerk/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, type)

	if(H.mind) //bad skills, even worse than smth like shophand, but compensated for with ok stats and starting luxuries. you aren't him, bud. you, quite explicitly, are not that guy.
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.change_stat("strength", -1) //NERDDDDDDD!!
		H.change_stat("speed", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("fortune", 2)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/appraise/secular)

	if(should_wear_femme_clothes(H))
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/green
	else if(should_wear_masc_clothes(H))
		armor = /obj/item/clothing/cloak/tabard/knight
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt

	pants = /obj/item/clothing/under/roguetown/tights
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/storage/keyring/steward //serously doubt this is gonna be an issue, but if it is, i'll change it
	backr = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/scomstone/bad
