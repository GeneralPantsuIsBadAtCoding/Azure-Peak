/datum/advclass/psydoniantemplar // A templar, but for the Inquisition
	name = "Adjudicator"
	tutorial = "Psydonite knights, clad in fluted chainmaille and blessed with the capacity to invoke lesser miracles. In lieu of greater miracles and rituals, they compensate through martial discipline and blessed weaponry."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/psydoniantemplar
	category_tags = list(CTAG_INQUISITION)
	subclass_languages = list(/datum/language/otavan)
	cmode_music = 'sound/music/templarofpsydonia.ogg'
	traits_applied = list(TRAIT_HEAVYARMOR)
	subclass_stats = list(
		STATKEY_WIL = 3,
		STATKEY_CON = 2,
		STATKEY_STR = 2
	)
	subclass_skills = list(
		/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/whipsflails = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/crossbows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/bows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/magic/holy = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/medicine = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/shields = SKILL_LEVEL_JOURNEYMAN,
	)

/datum/outfit/job/roguetown/psydoniantemplar
	job_bitflag = BITFLAG_CHURCH

/datum/outfit/job/roguetown/psydoniantemplar/pre_equip(mob/living/carbon/human/H)
	..()
	has_loadout = TRUE
	wrists = /obj/item/clothing/neck/roguetown/psicross/silver
	cloak = /obj/item/clothing/cloak/psydontabard
	backr = /obj/item/rogueweapon/shield/tower/metal
	gloves = /obj/item/clothing/gloves/roguetown/chain/psydon
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	pants = /obj/item/clothing/under/roguetown/chainlegs
	backl = /obj/item/storage/backpack/rogue/satchel/otavan
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/inq
	shoes = /obj/item/clothing/shoes/roguetown/boots/psydonboots
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/ornate
	/obj/item/clothing/head/roguetown/helmet/heavy/psydonhelm
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	id = /obj/item/clothing/ring/signet/silver
	backpack_contents = list(/obj/item/roguekey/inquisition = 1,
	/obj/item/paper/inqslip/arrival/ortho = 1)

	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T2, passive_gain = CLERIC_REGEN_WEAK, devotion_limit = CLERIC_REQ_1) //Capped to T2 miracles. ENDURE. WITH RESPITE.


/datum/outfit/job/roguetown/psydoniantemplar/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	var/helmets = list("Barbute", "Sallet", "Armet", "Bucket Helm")
	var/helmet_choice = input(H,"Choose your PSYDONIAN helmet.", "TAKE UP PSYDON'S HELMS") as anything in helmets
	switch(helmet_choice)
		if("Barbute")
			H.equip_to_slot_or_del(new /obj/item/clothing/head/roguetown/helmet/heavy/psydonbarbute, SLOT_HEAD, TRUE)
		if("Sallet")
			H.equip_to_slot_or_del(new /obj/item/clothing/head/roguetown/helmet/heavy/psysallet, SLOT_HEAD, TRUE)
		if("Armet")
			H.equip_to_slot_or_del(new /obj/item/clothing/head/roguetown/helmet/heavy/psydonhelm, SLOT_HEAD, TRUE)
		if("Bucket Helm")
			H.equip_to_slot_or_del(new /obj/item/clothing/head/roguetown/helmet/heavy/psybucket, SLOT_HEAD, TRUE)

	var/weapons = list("Sword", "Axe", "Whip", "Flail", "Mace", "Spear")
	var/weapon_choice = input(H,"Choose your PSYDONIAN weapon.", "TAKE UP PSYDON'S ARMS") as anything in weapons
	switch(weapon_choice)
		if("Sword")
			H.put_in_hands(new /obj/item/rogueweapon/sword/long/psysword(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/scabbard/sword(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
		if("Axe")
			H.put_in_hands(new /obj/item/rogueweapon/stoneaxe/battle/psyaxe(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/axes, 4, TRUE)
		if("Whip")
			H.put_in_hands(new /obj/item/rogueweapon/whip/psywhip_lesser(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 4, TRUE)
		if("Flail")
			H.put_in_hands(new /obj/item/rogueweapon/flail/sflail/psyflail(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 4, TRUE)
		if("Mace")
			H.put_in_hands(new /obj/item/rogueweapon/mace/goden/psymace(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/maces, 4, TRUE)
		if("Spear")
			H.put_in_hands(new /obj/item/rogueweapon/spear/psyspear(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/polearms, 4, TRUE)

