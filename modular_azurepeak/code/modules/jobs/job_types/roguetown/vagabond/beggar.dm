/datum/advclass/vagabond_beggar
	name = "Beggar"
	tutorial = "You are without coin and without worth. The pity of others is your bread, and their mercy is your butter. Having sat by waystones and watched many a traveller pass in the hopes for alms, you've nursed a surprising talent for thievery, and have even cajoled knowledge of lockpicking out of an especially sentimental rogue."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/vagabond/beggar
	category_tags = list(CTAG_VAGABOND)

/datum/outfit/job/roguetown/vagabond/beggar/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(20))
		head = /obj/item/clothing/head/roguetown/knitcap

	if(prob(5))
		beltr = /obj/item/reagent_containers/powder/moondust

	if(prob(10))
		beltl = /obj/item/clothing/mask/cigarette/rollie/cannabis

	if(prob(10))
		cloak = /obj/item/clothing/cloak/raincloak/brown

	if(should_wear_femme_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/shirt/rags
	else if(should_wear_masc_clothes(H))
		armor = null
		pants = /obj/item/clothing/under/roguetown/tights/vagrant

		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/vagrant/l

		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant

		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l

	if(prob(5))
		r_hand = /obj/item/rogueweapon/mace/woodclub
	else
		r_hand = null

	if(prob(5))
		l_hand = /obj/item/rogueweapon/mace/woodclub
	else
		l_hand = null

	if (H.mind)
		H.adjust_skillrank(/datum/skill/misc/sneaking, rand(1,5), TRUE)
		H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, rand(1,5), TRUE)
		H.adjust_skillrank(/datum/skill/misc/lockpicking, pick (1,2,3,4,5), TRUE)
		H.STALUC = rand(5, 15)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", -4)
		H.change_stat("constitution", -3)
		H.change_stat("endurance", -3)
		H.grant_language(/datum/language/thievescant)
		ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NASTY_EATER, TRAIT_GENERIC)
		
