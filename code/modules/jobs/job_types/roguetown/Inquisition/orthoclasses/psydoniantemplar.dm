/datum/advclass/psydoniantemplar // A templar, but for the Inquisition
	name = "Adjudicator"
	tutorial = "You are the strong arm of the Inquisition. You serve as a Templar under the local Inquisitor to forward the goals of the Otavan Inquisition. PSYDON Endures."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/psydoniantemplar
	category_tags = list(CTAG_INQUISITION)
	cmode_music = 'sound/music/templarofpsydonia.ogg'

/datum/outfit/job/roguetown/psydoniantemplar/pre_equip(mob/living/carbon/human/H)
	..()
	has_loadout = TRUE
	wrists = /obj/item/clothing/neck/roguetown/psicross/silver
	cloak = /obj/item/clothing/cloak/psydontabard
	backr = /obj/item/rogueweapon/shield/tower/metal
	gloves = /obj/item/clothing/gloves/roguetown/chain/psydon
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	pants = /obj/item/clothing/under/roguetown/chainlegs
	backl = /obj/item/storage/backpack/rogue/satchel/black
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	shoes = /obj/item/clothing/shoes/roguetown/boots/psydonboots
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/fluted
	head = /obj/item/clothing/head/roguetown/helmet/heavy/psydonhelm
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	id = /obj/item/clothing/ring/silver
	backpack_contents = list(/obj/item/roguekey/inquisition = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 3)
		
		ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_INQUISITION, TRAIT_GENERIC)

		H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
		var/datum/devotion/C = new /datum/devotion(H, H.patron)
		C.grant_spells_templar(H)
		H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)


/datum/outfit/job/roguetown/psydoniantemplar/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	var/weapons = list("Bastard Sword","Whip","Executioner Sword")
	var/weapon_choice = input(H,"Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	switch(weapon_choice)
		if("Bastard Sword")
			H.put_in_hands(new /obj/item/rogueweapon/sword/long(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Whip")
			H.put_in_hands(new /obj/item/rogueweapon/whip(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		if("Executioner Sword")
			H.put_in_hands(new /obj/item/rogueweapon/sword/long/exe(H), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
