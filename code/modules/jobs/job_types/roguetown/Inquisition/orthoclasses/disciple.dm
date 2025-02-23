/datum/advclass/disciple
	name = "Disciple"
	tutorial = "Disciples are Otavan martial artists, recruited by the Inquisition for their iron physique. Psydonian Monks."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/disciple
	category_tags = list(CTAG_INQUISITION)

/datum/outfit/job/roguetown/disciple/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/psicross/silver
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/sandals
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	id = /obj/item/clothing/ring/silver
	backl = /obj/item/storage/backpack/rogue/satchel
	mask = /obj/item/clothing/mask/rogue/facemask/psydonmask
	head = /obj/item/clothing/head/roguetown/roguehood/psydon
	var/classes = list("Otavan Brute", "Naledi-Trained Scholar")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	switch(classchoice)
		if("Otavan Brute")
			H.set_blindness(0)
			brute_equip(H)
		if("Naledi-Trained Scholar")
			H.set_blindness(0)
			naledi_equip(H)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_paladin(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/datum/outfit/job/roguetown/disciple/proc/brute_equip(mob/living/carbon/human/H)
	backpack_contents = list(/obj/item/roguekey/inquisition = 1)
	gloves = /obj/item/clothing/gloves/roguetown/chain/psydon
	armor = /obj/item/clothing/suit/roguetown/armor/skin_armor/monk_skin
	cloak = /obj/item/clothing/cloak/psydontabard/alt
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("endurance", 4)
		H.change_stat("constitution", 4)
		H.change_stat("intelligence", -2)
		ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_INQUISITION, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)

/datum/outfit/job/roguetown/disciple/proc/naledi_equip(mob/living/carbon/human/H)
	backpack_contents = list(/obj/item/roguekey/inquisition = 1)
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	cloak = /obj/item/clothing/cloak/psydontabard/alt
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_spellpoints(-6)
		H.change_stat("strength", 3)
		H.change_stat("speed", 2)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 1)
		H.change_stat("perception", -1)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch) // Pre-set spell list
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/sickness)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/forcewall)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/message)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/summonrogueweapon/bladeofpsydon)
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_INQUISITION, TRAIT_GENERIC)
