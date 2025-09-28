/datum/advclass/disciple
	name = "Disciple"
	tutorial = "Psydonite monks trained in the martial arts. They excel at shrugging off terrible blows while wrestling foes into submission."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/disciple
	subclass_languages = list(/datum/language/otavan)
	category_tags = list(CTAG_INQUISITION)
	traits_applied = list(
		TRAIT_CRITICAL_RESISTANCE,
		TRAIT_CIVILIZEDBARBARIAN,
		TRAIT_NOPAINSTUN,
	)
	subclass_stats = list(
		STATKEY_STR = 3,
		STATKEY_WIL = 3,
		STATKEY_CON = 3,
		STATKEY_INT = -2,
		STATKEY_SPD = -1
	)
	subclass_skills = list(
		/datum/skill/misc/athletics = SKILL_LEVEL_MASTER,
		/datum/skill/combat/unarmed = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
		/datum/skill/magic/holy = SKILL_LEVEL_APPRENTICE,
	)
	subclass_stashed_items = list(
		"Of Psydon" = /obj/item/book/rogue/bibble/psy
	)

/datum/outfit/job/roguetown/disciple
	job_bitflag = BITFLAG_CHURCH

/obj/item/storage/belt/rogue/leather/rope/dark
	color = "#505050"

/datum/outfit/job/roguetown/disciple/pre_equip(mob/living/carbon/human/H)
	..()
	has_loadout = TRUE
	neck = /obj/item/clothing/neck/roguetown/psicross/silver
	wrists = /obj/item/clothing/wrists/roguetown/bracers/psythorns
	gloves = /obj/item/clothing/gloves/roguetown/chain/psydon
	shoes = /obj/item/clothing/shoes/roguetown/boots/psydonboots
	id = /obj/item/clothing/ring/signet/silver
	backl = /obj/item/storage/backpack/rogue/satchel/otavan
	mask = /obj/item/clothing/head/roguetown/helmet/blacksteel/psythorns
	head = /obj/item/clothing/head/roguetown/roguehood/psydon
	backpack_contents = list(/obj/item/roguekey/inquisition = 1,
	/obj/item/paper/inqslip/arrival/ortho = 1)
	belt = /obj/item/storage/belt/rogue/leather/rope/dark
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	cloak = /obj/item/clothing/cloak/psydontabard/alt
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T2, passive_gain = CLERIC_REGEN_WEAK, devotion_limit = CLERIC_REQ_1)	//Capped to T2 miracles. It's just a self-heal.

/datum/outfit/job/roguetown/disciple/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	var/weapons = list("MY BARE HANDS", "Katar", "Knuckles")
	var/weapon_choice = input(H,"Choose your PSYDONIAN weapon.", "TAKE UP PSYDON'S ARMS") as anything in weapons
	switch(weapon_choice)
		if("MY BARE HANDS")
			H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 5, TRUE)
		if("Katar")
			H.put_in_hands(new /obj/item/rogueweapon/katar/psydon(H), TRUE)
		if("Knuckles")
			H.put_in_hands(new /obj/item/rogueweapon/knuckles/psydon(H), TRUE)

