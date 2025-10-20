/datum/advclass/vagabond_wanted
	name = "Wanted"
	tutorial = "The long arm of the law reaches out for you - are you slippery enough to evade its grip this time, or is your head destined to end up in an Excidium's maw?"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = ACCEPTED_RACES
	outfit = /datum/outfit/job/roguetown/vagabond/wanted
	category_tags = list(CTAG_VAGABOND)
	subclass_stats = list(
		STATKEY_PER = 2,
		STATKEY_SPD = 2,
		STATKEY_INT = -1
	)
	subclass_skills = list(
		/datum/skill/misc/sneaking = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/stealing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
	)
	extra_context = "This class starts with a bounty."

/datum/outfit/job/roguetown/vagabond/wanted/pre_equip(mob/living/carbon/human/H)
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
	
	if (H.mind)
		H.change_stat(STATKEY_LCK, rand(-2, 2))
		var/my_crime = input(H, "What is your crime?", "Crime") as text|null
		if (!my_crime)
			my_crime = "crimes against the Crown"
		var/list/bounty_cats = list("Meager", "Moderate", "Massive")
		var/bounty_amount = input(H, "How ample is your bounty?", "Blooded Gold") as anything in bounty_cats
		var/race = H.dna.species
		var/gender = H.gender
		var/list/d_list = H.get_mob_descriptors()
		var/descriptor_height = build_coalesce_description_nofluff(d_list, H, list(MOB_DESCRIPTOR_SLOT_HEIGHT), "%DESC1%")
		var/descriptor_body = build_coalesce_description_nofluff(d_list, H, list(MOB_DESCRIPTOR_SLOT_BODY), "%DESC1%")
		var/descriptor_voice = build_coalesce_description_nofluff(d_list, H, list(MOB_DESCRIPTOR_SLOT_VOICE), "%DESC1%")
		var/bounty_total = rand(51, 200)
		switch (bounty_amount)
			if ("Meager")
				bounty_total = rand(51, 100)
			if ("Moderate")
				bounty_total = rand(101, 150)
			if ("Massive")
				bounty_total = rand(150, 200)
	
		add_bounty(H.real_name, race, gender, descriptor_height, descriptor_body, descriptor_voice, bounty_total, FALSE, my_crime, "The Justiciary of Azuria")
		to_chat(H, span_notice("I'm on the run from the law, and there's a [lowertext(bounty_amount)] sum of mammons out on my head... better lay low."))
