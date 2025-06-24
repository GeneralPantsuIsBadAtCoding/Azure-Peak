/datum/advclass/vagabond_goatherd
	name = "Lone Goatherd"
	tutorial = "Having lost your idyllic pastoral existence, only a solitary member of your herd now remains as a reminder of what was. Is your sole charge a friend, or is it food? You decide."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/vagabond/goatherd
	category_tags = list(CTAG_VAGABOND)
	horse = /mob/living/simple_animal/hostile/retaliate/rogue/goatmale/tame

/datum/outfit/job/roguetown/vagabond/goatherd/pre_equip(mob/living/carbon/human/H)
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
		H.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.change_stat("intelligence", -1)
		H.change_stat("constitution", -1)
		H.change_stat("endurance", 2)

/mob/living/simple_animal/hostile/retaliate/rogue/goat/tame/Initialize()
	..()
	tamed()
