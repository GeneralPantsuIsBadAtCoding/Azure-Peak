/datum/outfit/job/roguetown/templar/monk/pre_equip(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H, TRAIT_CLERGY, TRAIT_GENERIC)
	H.change_stat(STATKEY_STR, -1)

/datum/outfit/job/roguetown/templar/crusader/pre_equip(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H, TRAIT_CLERGY, TRAIT_GENERIC)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_CON, 1)

/datum/advclass/templar/vigilant
	name = "Vigilant"
	tutorial = "You are a vigilant of the Church, the secretive counterspies of the Holy See. Your underhanded methods earn you the scorn of some of your brothers, but they know not of the wars you fight away from their gaze."
	outfit = /datum/outfit/job/roguetown/templar/vigilant
	subclass_languages = list(/datum/language/grenzelhoftian)
	traits_applied = list(TRAIT_DODGEEXPERT)
	subclass_stats = list(
		STATKEY_WIL = 2,
		STATKEY_SPD = 2,
		STATKEY_PER = 1,
		STATKEY_INT = 1,
		STATKEY_STR = -1
	)
	subclass_skills = list(
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/bows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/crossbows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/sneaking = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/lockpicking = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/stealing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/tracking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/traps = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/medicine = SKILL_LEVEL_NOVICE,
		/datum/skill/magic/holy = SKILL_LEVEL_JOURNEYMAN,
	)
	category_tags = list(CTAG_TEMPLAR)
	subclass_stashed_items = list(
		"The Verses and Acts of the Ten" = /obj/item/book/rogue/bibble,
	)
	extra_context = "This subclass can pick twin daggers, gaining Dual Wielder trait and increased speed, or ranged options, gaining increased perception and Mastery of their chosen weapon. Vigilants of Eora can alternatively choose their signature rapier, the Heartstring."

/datum/outfit/job/roguetown/templar/vigilant/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/neck/roguetown/psicross/undivided
	cloak = /obj/item/clothing/cloak/undivided
	id = /obj/item/clothing/ring/gold
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/ritechalk = 1,
		/obj/item/lockpickring/mundane = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/storage/keyring/churchie = 1
		)
	H.cmode_music = 'sound/music/cmode/church/combat_reckoning.ogg'
	switch(H.patron?.type)
		if(/datum/patron/divine/undivided)
			wrists = /obj/item/clothing/neck/roguetown/psicross/undivided
			var/cloaks = list("Cloak", "Tabard")
			var/cloakchoice = input(H,"Choose your covering", "TAKE UP FASHION") as anything in cloaks
			switch(cloakchoice)
				if("Cloak")
					cloak = /obj/item/clothing/cloak/undivided
				if("Tabard")
					cloak = /obj/item/clothing/cloak/templar/undivided
			mask = /obj/item/clothing/mask/rogue/facemask/steel
		if(/datum/patron/divine/astrata)
			head = /obj/item/clothing/head/roguetown/roguehood/astrata
			wrists = /obj/item/clothing/neck/roguetown/psicross/astrata
			cloak = /obj/item/clothing/cloak/tabard/crusader/astrata
			mask = /obj/item/clothing/mask/rogue/facemask/steel
		if(/datum/patron/divine/abyssor)
			head = /obj/item/clothing/head/roguetown/roguehood/abyssor
			wrists = /obj/item/clothing/neck/roguetown/psicross/abyssor
			cloak = /obj/item/clothing/cloak/abyssortabard
			mask = /obj/item/clothing/mask/rogue/facemask/steel
		if(/datum/patron/divine/xylix)
			wrists = /obj/item/clothing/neck/roguetown/luckcharm
			cloak = /obj/item/clothing/cloak/templar/xylixian
			mask = /obj/item/clothing/mask/rogue/facemask/xylixmask/armored //TA edit
			H.cmode_music = 'sound/music/combat_jester.ogg'
		if(/datum/patron/divine/dendor)
			wrists = /obj/item/clothing/neck/roguetown/psicross/dendor
			cloak = /obj/item/clothing/cloak/tabard/crusader/dendor
			mask = /obj/item/clothing/head/roguetown/dendormask/armored
			H.cmode_music = 'sound/music/cmode/garrison/combat_warden.ogg'
		if(/datum/patron/divine/necra)
			head = /obj/item/clothing/head/roguetown/necrahood
			wrists = /obj/item/clothing/neck/roguetown/psicross/necra
			cloak = /obj/item/clothing/cloak/templar/necran
			mask = /obj/item/clothing/mask/rogue/facemask/steel
		if(/datum/patron/divine/pestra)
			head = /obj/item/clothing/head/roguetown/roguehood/phys
			wrists = /obj/item/clothing/neck/roguetown/psicross/pestra
			cloak = /obj/item/clothing/cloak/templar/pestran
			mask = /obj/item/clothing/mask/rogue/facemask/steel
		if(/datum/patron/divine/eora) //Eora content from stonekeep
			head = /obj/item/clothing/head/roguetown/eoramask
			wrists = /obj/item/clothing/neck/roguetown/psicross/eora
			cloak = /obj/item/clothing/suit/roguetown/shirt/robe/eora
		if(/datum/patron/divine/noc)
			head = /obj/item/clothing/head/roguetown/nochood
			wrists = /obj/item/clothing/neck/roguetown/psicross/noc
			cloak = /obj/item/clothing/cloak/tabard/crusader/noc
			mask = /obj/item/clothing/mask/rogue/facemask/steel
		if(/datum/patron/divine/ravox)
			head = /obj/item/clothing/head/roguetown/roguehood
			mask = /obj/item/clothing/head/roguetown/roguehood/ravoxgorget
			wrists = /obj/item/clothing/neck/roguetown/psicross/ravox
			cloak = /obj/item/clothing/cloak/templar/ravox
			backpack_contents = list(/obj/item/ritechalk, /obj/item/book/rogue/law, /obj/item/clothing/mask/rogue/facemask/steel)
		if(/datum/patron/divine/malum)
			head = /obj/item/clothing/head/roguetown/roguehood
			wrists = /obj/item/clothing/neck/roguetown/psicross/malum
			cloak = /obj/item/clothing/cloak/templar/malumite
			mask = /obj/item/clothing/mask/rogue/facemask/steel
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/steel
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	neck = /obj/item/clothing/neck/roguetown/chaincoif/full // пока у них не будет нормальных шлемов
	gloves = /obj/item/clothing/gloves/roguetown/angle
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/iron
	// -- End of section for god specific bonuses --
	ADD_TRAIT(H, TRAIT_CLERGY, TRAIT_GENERIC)

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T2, passive_gain = CLERIC_REGEN_MINOR, devotion_limit = CLERIC_REQ_2)	//Capped to T2 miracles.

/datum/outfit/job/roguetown/templar/vigilant/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	var/weapons = list("Dagger + Parrying Dagger","Rapier + Parrying Dagger","Recurve Bow + Dagger","Slurbow + Dagger")
	switch(H.patron?.type)
		if(/datum/patron/divine/pestra)
			weapons += "Plaguebringer Sickles"
		if(/datum/patron/divine/xylix)
			weapons += "Devilsknives"
			weapons += "Recurve Bow + Cackle Lash"
			weapons += "Slurbow + Cackle Lash"
		if(/datum/patron/divine/eora)
			weapons += "The Heartstring and Misericorde"
		if(/datum/patron/divine/noc)
			weapons += "Twilight Fangs"
		if(/datum/patron/divine/astrata)
			weapons += "Dawnbringers"
		if(/datum/patron/divine/ravox)
			weapons += "Echoes of Triumph"
		if(/datum/patron/divine/abyssor)
			weapons += "Darkwater Rippers"
		if(/datum/patron/divine/dendor)
			weapons += "Madenning Thorns"
		if(/datum/patron/divine/necra)
			weapons += "Osteotomes"
		if(/datum/patron/divine/malum)
			weapons += "Embertongues"

	var/weapon_choice = input(H,"Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	switch(weapon_choice)
		if("Dagger + Parrying Dagger")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/parrying(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
			H.change_stat(STATKEY_SPD, 2)
			H.change_stat(STATKEY_INT, 2)
		if("Rapier + Parrying Dagger")
			H.put_in_hands(new /obj/item/rogueweapon/sword/rapier(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/parrying(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
			H.change_stat(STATKEY_PER, 2)
			H.change_stat(STATKEY_SPD, 1)
			H.change_stat(STATKEY_INT, 1)
		if("Recurve Bow + Dagger")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/special(H), TRUE)
			H.put_in_hands(new /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/quiver/arrows, SLOT_BELT_L, TRUE)
			H.change_stat(STATKEY_PER, 3)
			H.change_stat(STATKEY_SPD, 1)
			H.adjust_skillrank_up_to(/datum/skill/combat/bows, 5, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		if("Slurbow + Dagger")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/special(H), TRUE)
			H.put_in_hands(new /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow/slurbow(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/quiver/bolts, SLOT_BELT_L, TRUE)
			H.change_stat(STATKEY_PER, 3)
			H.change_stat(STATKEY_SPD, 1)
			H.adjust_skillrank_up_to(/datum/skill/combat/crossbows, 5, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		if("Plaguebringer Sickles")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/pestrasickle(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/pestrasickle(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
			H.change_stat(STATKEY_SPD, 2)
			H.change_stat(STATKEY_INT, 2)
		if("Devilsknives")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/devilsknife(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/devilsknife(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
			H.change_stat(STATKEY_SPD, 2)
			H.change_stat(STATKEY_INT, 2)
		if("Recurve Bow + Cackle Lash")
			H.put_in_hands(new /obj/item/rogueweapon/whip/xylix(H), TRUE)
			H.put_in_hands(new /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/quiver/arrows, SLOT_BELT_L, TRUE)
			H.change_stat(STATKEY_PER, 3)
			H.change_stat(STATKEY_SPD, 1)
			H.adjust_skillrank_up_to(/datum/skill/combat/bows, 5, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 4, TRUE)
		if("Slurbow + Cackle Lash")
			H.put_in_hands(new /obj/item/rogueweapon/whip/xylix(H), TRUE)
			H.put_in_hands(new /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow/slurbow(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/quiver/bolts, SLOT_BELT_L, TRUE)
			H.change_stat(STATKEY_PER, 3)
			H.change_stat(STATKEY_SPD, 1)
			H.adjust_skillrank_up_to(/datum/skill/combat/crossbows, 5, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 4, TRUE)
		if("The Heartstring and Misericorde")
			H.put_in_hands(new /obj/item/rogueweapon/sword/rapier/eora(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/parrying/eora(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
			H.change_stat(STATKEY_PER, 2)
			H.change_stat(STATKEY_SPD, 1)
			H.change_stat(STATKEY_INT, 1)
		if("Twilight Fangs")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/throwingknife/steel/noc(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/throwingknife/steel/noc(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
			H.change_stat(STATKEY_SPD, 2)
			H.change_stat(STATKEY_INT, 2)
		if("Dawnbringers")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/astrata(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/astrata(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
			H.change_stat(STATKEY_SPD, 2)
			H.change_stat(STATKEY_INT, 2)
		if("Echoes of Triumph")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/ravox(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/ravox(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
			H.change_stat(STATKEY_SPD, 2)
			H.change_stat(STATKEY_INT, 2)
		if("Darkwater Rippers")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/abyssor(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/abyssor(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
			H.change_stat(STATKEY_SPD, 2)
			H.change_stat(STATKEY_INT, 2)
		if("Madenning Thorns")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/dendor(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/dendor(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
			H.change_stat(STATKEY_SPD, 2)
			H.change_stat(STATKEY_INT, 2)
		if("Osteotomes")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/necra(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/necra(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
			H.change_stat(STATKEY_SPD, 2)
			H.change_stat(STATKEY_INT, 2)
		if("Embertongues")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/malum(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/malum(H), TRUE)
			H.equip_to_slot_or_del(new /obj/item/rogueweapon/scabbard/sheath, SLOT_BELT_L, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
			H.change_stat(STATKEY_SPD, 2)
			H.change_stat(STATKEY_INT, 2)
	// -- Start of section for god specific bonuses --
	if(H.patron?.type == /datum/patron/divine/astrata)
		H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.cmode_music = 'sound/music/cmode/church/combat_astrata.ogg'
	if(H.patron?.type == /datum/patron/divine/dendor)
		H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	if(H.patron?.type == /datum/patron/divine/noc)
		H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE) // Really good at reading... does this really do anything? No. BUT it's soulful.
		H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
		H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
	if(H.patron?.type == /datum/patron/divine/abyssor)
		H.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
		ADD_TRAIT(H, TRAIT_WATERBREATHING, TRAIT_GENERIC)
	if(H.patron?.type == /datum/patron/divine/necra)
		ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SOUL_EXAMINE, TRAIT_GENERIC)
		H.cmode_music = 'sound/music/cmode/church/combat_necra.ogg'
	if(H.patron?.type == /datum/patron/divine/pestra)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
		ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	if(H.patron?.type == /datum/patron/divine/eora)
		ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
		H.cmode_music = 'sound/music/cmode/church/combat_eora.ogg'
	if(H.patron?.type == /datum/patron/divine/malum)
		H.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/smelting, 1, TRUE)
	if(H.patron?.type == /datum/patron/divine/ravox)
		H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	if(H.patron?.type == /datum/patron/divine/xylix)
		H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
