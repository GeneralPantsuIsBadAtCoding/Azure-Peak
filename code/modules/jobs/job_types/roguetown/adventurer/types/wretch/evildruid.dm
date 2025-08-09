/datum/advclass/wretch/evildruid
	name = "Corrupted Druid"
	tutorial = "Dendor is angry. He rages; He writhes. Worms will fill this earth. Psydonia must weep ichorous blood. Astrata's tyranny was too much, and in one way or another--the Treefather has gifted you His rage."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/evildruid
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_RITUALIST, TRAIT_OUTLANDER, TRAIT_OUTDOORSMAN, TRAIT_OUTLAW, TRAIT_HERESIARCH)
	maximum_possible_slots = 2 // kneestinger spam

/datum/outfit/job/roguetown/wretch/evildruid/pre_equip(mob/living/carbon/human/H)
	belt = /obj/item/storage/belt/rogue/leather/rope
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltr = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/rogue/satchel
	head = /obj/item/clothing/head/roguetown/dendormask
	wrists = /obj/item/clothing/neck/roguetown/psicross/dendor
	shirt = /obj/item/clothing/suit/roguetown/shirt/robe/dendor
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/flashlight/flare/torch/lantern/prelit = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/rope/chain = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/ritechalk = 1)
	H.set_patron(/datum/patron/divine/dendor) // needed for spells, also you're a druid
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
	H.adjust_skillrank(/datum/skill/magic/druidic, 3, TRUE) // shapeshifters
	H.grant_language(/datum/language/beast)
	H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
	H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander.ogg' // this shit rocks
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	var/weapons = list("Katar","Steel Knuckles","Punch Dagger","DENDOR'S CLAWS!!!","Whip")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if ("Katar")
			H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			beltr = /obj/item/rogueweapon/katar
		if ("Steel Knuckles")
			H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			beltr = /obj/item/rogueweapon/knuckles
		if ("Punch Dagger")
			H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			beltr = /obj/item/rogueweapon/katar/punchdagger
		if ("DENDOR'S CLAWS!!!")
			H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)
		if ("Whip")
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
			beltr = /obj/item/rogueweapon/whip
		if ("Bows")
			H.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			beltr = /obj/item/quiver/arrows
	H.change_stat("strength", 1)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1) // starts with dogshit armor
	H.change_stat("perception", -1) // forces them to stay in the woods
	H.change_stat("speed", 1)
	H.ambushable = FALSE

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T4, passive_gain = CLERIC_REGEN_MINOR) // unloved compared to real druids

	wretch_select_bounty(H)
