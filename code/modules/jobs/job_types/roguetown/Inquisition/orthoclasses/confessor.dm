/datum/advclass/confessor
	name = "Confessor"
	tutorial = "Confessors are assistant investigators to the Inquisitor. They are sneaky, quick, and prone to skullduggery. They are ideal listeners and watchers from the dark. Divided into two groups, the Hashashiyan and the Apostle, the former being the slient blade of the Inquisition, and the latter being a doctor in service to the Inquisition."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/confessor
	category_tags = list(CTAG_INQUISITION)
	cmode_music = 'sound/music/combat_rogue.ogg'

/datum/outfit/job/roguetown/confessor/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/psicross/silver
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/boots
	id = /obj/item/clothing/ring/silver
	mask = /obj/item/clothing/mask/rogue/facemask/psydonmask
	head = /obj/item/clothing/head/roguetown/roguehood/psydon
	var/classes = list("Hashashiyan", "Apostle")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	switch(classchoice)
		if("Hashashiyan")
			H.set_blindness(0)
			hashashiyan_equip(H)
		if("Apostle")
			H.set_blindness(0)
			apostle_equip(H)

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/datum/outfit/job/roguetown/confessor/proc/hashashiyan_equip(mob/living/carbon/human/H)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
	cloak = /obj/item/clothing/suit/roguetown/armor/longcoat
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	beltl = /obj/item/rogueweapon/mace/cudgel
	beltr = /obj/item/quiver/bolts
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/psydon
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	backpack_contents = list(/obj/item/roguekey/inquisition = 1, /obj/item/lockpickring/mundane = 1, /obj/item/rogueweapon/huntingknife/idagger/steel, /obj/item/grapplinghook = 1)
	H.change_stat("strength", -1)
	H.change_stat("endurance", 3)
	H.change_stat("perception", 2)
	H.change_stat("speed", 3)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INQUISITION, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_PERFECT_TRACKER, TRAIT_GENERIC)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/datum/outfit/job/roguetown/confessor/proc/apostle_equip(mob/living/carbon/human/H)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
	cloak = /obj/item/clothing/suit/roguetown/armor/longcoat
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	beltl = /obj/item/rogueweapon/mace/cudgel
	backr = /obj/item/storage/backpack/rogue/satchel/black
	belt = /obj/item/storage/belt/rogue/leather/black
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	backpack_contents = list(/obj/item/roguekey/inquisition = 1, /obj/item/rogueweapon/huntingknife/idagger/steel)
	H.change_stat("strength", -1)
	H.change_stat("perception", 2)
	H.change_stat("intelligence", 3)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INQUISITION, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
