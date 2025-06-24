/datum/advclass/vagabond_runner
	name = "Rumbled Runner"
	tutorial = "Ferrying messages in the dark is a dangerous profession at the best of times. You're lucky to have made it out of your last predicament alive, but all you have now is some rags and your trusty feet."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/vagabond/runner
	category_tags = list(CTAG_VAGABOND)

/datum/outfit/job/roguetown/vagabond/runner/pre_equip(mob/living/carbon/human/H)
	..()
	if(should_wear_femme_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/shirt/rags
	else if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/vagrant/l
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l

	if(prob(33))
		cloak = /obj/item/clothing/cloak/half/brown
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	
	if(prob(10))
		r_hand = /obj/item/rogue/instrument/flute

	if (H.mind)
		H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.change_stat("endurance", 1)
		H.change_stat("intelligence", -2)
