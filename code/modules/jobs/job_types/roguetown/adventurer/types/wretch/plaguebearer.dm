/datum/advclass/wretch/plaguebearer
	name = "Plaguebearer"
	tutorial = "A disgraced physician forced into exile and years of hardship, you have turned to a private practice surrounding the only things you've ever known - poisons and plague. Revel in the spreading of blight, and unleash craven pestilence."
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/plaguebearer
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER, TRAIT_OUTLAW, TRAIT_CICERONE, TRAIT_HERESIARCH, TRAIT_NOSTINK)
	maximum_possible_slots = 1 //They spawn with killer's ice lol I'm limiting this shit 

/datum/outfit/job/roguetown/wretch/plaguebearer/pre_equip(mob/living/carbon/human/H)
	head = /obj/item/clothing/head/roguetown/physician
	mask = /obj/item/clothing/mask/rogue/physician
	neck = /obj/item/clothing/neck/roguetown/chaincoif 
	pants = /obj/item/clothing/under/roguetown/trou/leather/mourning
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/physician
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	r_hand = /obj/item/storage/belt/rogue/surgery_bag/full/physician
	belt = /obj/item/storage/belt/rogue/leather/black
	gloves = /obj/item/clothing/gloves/roguetown/angle
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/poison = 1, // You get one epic poison. As a treat because you're valid. Don't waste it. 
		/obj/item/reagent_containers/glass/bottle/rogue/stampoison = 1,
		/obj/item/recipe_book/alchemy = 1,
		/obj/item/flashlight/flare/torch/lantern/prelit = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/strongpoison = 1,
		)
	H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE) // To escape grapplers, fuck you
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE) //Build your gooncave 
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE) //Disgraced medicine man. 
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 5, TRUE) // This is literally their whole thing
	H.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE) // Farm ingredients so you have something to do that isn't grinding skills
	H.cmode_music = 'sound/music/combat_physician.ogg'
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
	var/weapons = list("Archery", "LET THERE BE PLAGUE!!!")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Archery")
			H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			beltl = /obj/item/quiver/poisonarrows
		if("LET THERE BE PLAGUE!!!")
			H.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			backr = /obj/item/rogueweapon/woodstaff/toper
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/aerosolize)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/acidsplash)
	H.change_stat("perception", 3)
	H.change_stat("constitution", 2)
	H.change_stat("intelligence", 4)
	wretch_select_bounty(H)
