/datum/outfit/job/roguetown/puritan/inspector/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.adjust_skillrank(/datum/skill/combat/twilight_firearms, 3, TRUE)
	belt = /obj/item/storage/belt/rogue/leather/twilight_holsterbelt/runelock
	beltr = /obj/item/quiver/twilight_bullet/runed
	backl = null

/datum/advclass/puritan/blackpowder
	name = "Black Vanguard"
	tutorial = "A truly rare specimen among the ranks of the Inquisition - an agent of the Black Powder Order now serving as an Ordinator, hunting down Psydon's many enemies, set upon this task by Marshal Inquisitionis himself. There are many mistakes a heretic can commit over their lifespan, but when facing a Black Vanguard, their final error tends to be the fact that they brought a sword to a gunfight."
	outfit = /datum/outfit/job/roguetown/puritan/blackpowder
	cmode_music = 'sound/music/combat_inqordinator.ogg'

	category_tags = list(CTAG_PURITAN)

/datum/outfit/job/roguetown/puritan/blackpowder/pre_equip(mob/living/carbon/human/H)
	..()
	has_loadout = TRUE
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/twilight_firearms, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.change_stat("strength", 2)
	H.change_stat("endurance", 3)
	H.change_stat("constitution", 3)
	H.change_stat("perception", 3)
	H.change_stat("speed", 1)
	H.change_stat("intelligence", 3)
	H.verbs |= /mob/living/carbon/human/proc/faith_test
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SILVER_BLESSED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INQUISITION, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_PERFECT_TRACKER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_PURITAN, JOB_TRAIT)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/inq
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat
	neck = /obj/item/clothing/neck/roguetown/gorget/steel
	shoes = /obj/item/clothing/shoes/roguetown/boots/otavan/inqboots
	wrists = /obj/item/clothing/neck/roguetown/psicross/silver
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
	backr = /obj/item/storage/backpack/rogue/satchel/otavan
	cloak = /obj/item/clothing/cloak/psydontabard
	head = /obj/item/clothing/head/roguetown/inqhat
	gloves = /obj/item/clothing/gloves/roguetown/otavan/psygloves
	id = /obj/item/clothing/ring/signet/silver
	backpack_contents = list(
		/obj/item/storage/keyring/puritan = 1,
		/obj/item/lockpickring/mundane = 1,
		/obj/item/rogueweapon/huntingknife/idagger/silver/psydagger,
		/obj/item/grapplinghook = 1,
		/obj/item/storage/belt/rogue/pouch/coins/rich = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/paper/inqslip/arrival/inq = 1
		)

/datum/outfit/job/roguetown/puritan/blackpowder/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	var/weapons = list("Doomsdae (Runelock Rifle)", "Purgatory (Handcannon)", "Umbra (Assassin's Firearm)")
	var/weapon_choice = input(H,"CHOOSE YOUR RELIQUARY PIECE.", "WIELD THEM IN HIS NAME.") as anything in weapons
	switch(weapon_choice)
		if("Doomsdae (Runelock Rifle)")
			H.equip_to_slot_or_del(new /obj/item/storage/belt/rogue/leather/steel, SLOT_BELT, TRUE)
			H.equip_to_slot_or_del(new /obj/item/quiver/twilight_bullet/blessed, SLOT_BELT_R, TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sword, SLOT_BELT_L, TRUE)
			H.put_in_hands(new /obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/sword/rapier/psyrapier(H), TRUE)
		if("Purgatory (Handcannon)")
			H.equip_to_slot_or_del(new /obj/item/storage/belt/rogue/leather/steel, SLOT_BELT, TRUE)
			H.equip_to_slot_or_del(new /obj/item/quiver/twilight_bullet/cannonball/otavian_grapeshot, SLOT_BELT_R, TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sword, SLOT_BELT_L, TRUE)
			H.put_in_hands(new /obj/item/gun/ballistic/twilight_firearm/handgonne/purgatory(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/sword/rapier/psyrapier(H), TRUE)
			var/obj/item/belt = H.get_item_by_slot(SLOT_BELT)
			var/obj/item/insert = new /obj/item/twilight_powderflask(H)
			if(!SEND_SIGNAL(belt, COMSIG_TRY_STORAGE_INSERT, insert, null, TRUE, TRUE))
				addtimer(CALLBACK(PROC_REF(move_storage), insert, H.loc), 3 SECONDS)
			insert = new /obj/item/natural/bundle/fibers/full(H)
			if(!SEND_SIGNAL(belt, COMSIG_TRY_STORAGE_INSERT, insert, null, TRUE, TRUE))
				addtimer(CALLBACK(PROC_REF(move_storage), insert, H.loc), 3 SECONDS)
		if("Umbra (Assassin's Firearm)")
			H.equip_to_slot_or_del(new /obj/item/storage/belt/rogue/leather/twilight_holsterbelt, SLOT_BELT, TRUE)
			H.equip_to_slot_or_del(new /obj/item/quiver/twilight_bullet/silver, SLOT_BELT_R, TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sword, SLOT_BELT_L, TRUE)
			H.put_in_hands(new /obj/item/gun/ballistic/twilight_firearm/arquebus_pistol/umbra(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/sword/rapier/psyrapier(H), TRUE)
			var/obj/item/belt = H.get_item_by_slot(SLOT_BELT)
			var/obj/item/powderflask = new /obj/item/twilight_powderflask/thunder(H)
			if(!SEND_SIGNAL(belt, COMSIG_TRY_STORAGE_INSERT, powderflask, null, TRUE, TRUE))
				addtimer(CALLBACK(PROC_REF(move_storage), powderflask, H.loc), 3 SECONDS)
