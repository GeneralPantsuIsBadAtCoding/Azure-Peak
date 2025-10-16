/datum/advclass/wretch/licker
	name = "Licker"
	tutorial = "You have recently been embraced as a vampire. You do not know whom your sire is, strange urges, unnatural strength, a thirst you can barely control. You were outed as a monster and are now on the run."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_NO_CONSTRUCT
	outfit = /datum/outfit/job/roguetown/wretch/licker
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(
		TRAIT_STEELHEARTED,
		TRAIT_SILVER_WEAK,
	)
	maximum_possible_slots = 2
	applies_post_equipment = FALSE

/datum/outfit/job/roguetown/wretch/licker/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.adjust_blindness(-3)
		var/list/possible_classes = list()
		for(var/datum/advclass/CHECKS in SSrole_class_handler.sorted_class_categories[CTAG_LICKER_WRETCH])
			possible_classes += CHECKS

		var/datum/advclass/C = input(H.client, "What is my class?", "Adventure") as null|anything in possible_classes
		C.equipme(H)

		H.adjust_skillrank_up_to(/datum/skill/magic/blood, 4, TRUE)
		var/datum/antagonist/vampire/new_antag = new /datum/antagonist/vampire(generation = GENERATION_NEONATE)
		H.mind.add_antag_datum(new_antag)
