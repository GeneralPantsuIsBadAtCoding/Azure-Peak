/datum/advclass/wretch/licker
	name = "Licker"
	tutorial = "You are a LICKER. LICK MY PUSSY"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/licker
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(
		TRAIT_STEELHEARTED
		//TRAIT_SILVER_WEAK
	)

/datum/outfit/job/roguetown/wretch/licker/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/list/possible_classes = list()
	for(var/datum/advclass/CHECKS in SSrole_class_handler.sorted_class_categories[CTAG_ADVENTURER])
		if(!(CTAG_LICKER_WRETCH in CHECKS.category_tags))
			continue
		possible_classes += CHECKS

	var/datum/advclass/C = input(H.client, "What is my class?", "Adventure") as null|anything in possible_classes
	C.equipme(H)

	H.adjust_skillrank_up_to(/datum/skill/magic/blood, 3, TRUE)
	var/datum/antagonist/vampire/new_antag = new /datum/antagonist/vampire(generation = GENERATION_NEONATE)
	H.mind.add_antag_datum(new_antag)
