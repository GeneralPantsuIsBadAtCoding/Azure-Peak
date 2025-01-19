/mob/living/carbon/human/species/npc/deadite

	aggressive=TRUE
	mode = AI_IDLE
	dodgetime = 8 
	flee_in_pain = FALSE

	wander = TRUE

/mob/living/carbon/human/species/npc/deadite/Initialize()
	. = ..()
	var/species = list(
		/datum/species/human/northern,
		/datum/species/dwarf/mountain,
		/datum/species/elf/dark,
		/datum/species/elf/wood,
		/datum/species/goblinp,
		/datum/species/aasimar,
		/datum/species/human/halfelf,
		/datum/species/halforc,
		/datum/species/tieberian,
	)

	set_species(pick(species))
	gender = pick(MALE, FEMALE)

	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)

/mob/living/carbon/human/species/npc/deadite/after_creation()
	. = ..()
	src.mind_initialize()
	src.mind.add_antag_datum(/datum/antagonist/zombie, team = FALSE, admin_panel = TRUE)
	equipOutfit(new /datum/outfit/job/roguetown/deadite)

/datum/outfit/job/roguetown/deadite/pre_equip(mob/living/carbon/human/H)
	..()
	head = null
	beltr = null
	beltl = null
	if(prob(30))
		cloak = /obj/item/clothing/cloak/raincloak/brown
	else
		cloak = null
	if(prob(10))
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	else
		gloves = null

	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/rags
	else
		armor = null
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/vagrant/l
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l

	r_hand = null
	l_hand = null
