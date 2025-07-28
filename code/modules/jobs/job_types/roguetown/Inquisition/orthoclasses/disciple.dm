/datum/advclass/disciple
	name = "Disciple"
	tutorial = "Psydonite monks trained in the martial arts. They excel at shrugging off terrible blows while wrestling foes into submission."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/disciple
	category_tags = list(CTAG_INQUISITION)

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
	backpack_contents = list(/obj/item/roguekey/inquisition = 1)
	belt = /obj/item/storage/belt/rogue/leather/rope/dark
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	cloak = /obj/item/clothing/cloak/psydontabard/alt
	H.adjust_skillrank(/datum/skill/misc/athletics, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.change_stat("strength", 3)
	H.change_stat("endurance", 3)
	H.change_stat("constitution", 3)
	H.change_stat("intelligence", -2)
	H.change_stat("speed", -1)
	ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INQUISITION, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OUTLANDER, TRAIT_GENERIC)		//You're a foreigner, a guest of the realm.
	H.grant_language(/datum/language/otavan)
	H.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T2, passive_gain = FALSE, devotion_limit = CLERIC_REQ_1)	//Capped to T2 miracles. It's just a self-heal.

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

