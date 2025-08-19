/datum/advclass/templar/vigilant
	name = "Vigilant"
	tutorial = "You are a vigilant of the Church, the secretive counterspies of the Grenzelhoftian Holy See. Your underhanded methods earn you the scorn of some of your brothers, but they know not of the wars you fight away from their gaze."
	outfit = /datum/outfit/job/roguetown/templar/vigilant

	category_tags = list(CTAG_TEMPLAR)

/datum/outfit/job/roguetown/templar/vigilant/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/psicross/astrata
	cloak = /obj/item/clothing/cloak/tabard/crusader/tief
	id = /obj/item/clothing/ring/gold
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/ritechalk = 1,
		/obj/item/lockpickring/mundane = 1,
		/obj/item/rogueweapon/scabbard/sheath = 2,
		)
	H.cmode_music = 'sound/music/cmode/church/combat_reckoning.ogg'
	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			head = /obj/item/clothing/head/roguetown/roguehood/astrata
			neck = /obj/item/clothing/neck/roguetown/psicross/astrata
			cloak = /obj/item/clothing/cloak/tabard/crusader/astrata
		if(/datum/patron/divine/abyssor)
			head = /obj/item/clothing/head/roguetown/roguehood/abyssor
			neck = /obj/item/clothing/neck/roguetown/psicross/abyssor
			cloak = /obj/item/clothing/cloak/abyssortabard
		if(/datum/patron/divine/xylix)
			neck = /obj/item/clothing/neck/roguetown/luckcharm
			cloak = /obj/item/clothing/cloak/templar/xylixian
			mask = /obj/item/clothing/mask/rogue/facemask/xylixmask //TA edit
			H.cmode_music = 'sound/music/combat_jester.ogg'
		if(/datum/patron/divine/dendor)
			head = /obj/item/clothing/head/roguetown/dendormask
			neck = /obj/item/clothing/neck/roguetown/psicross/dendor
			cloak = /obj/item/clothing/cloak/tabard/crusader/dendor
			H.cmode_music = 'sound/music/cmode/garrison/combat_warden.ogg'
		if(/datum/patron/divine/necra)
			head = /obj/item/clothing/head/roguetown/necrahood
			neck = /obj/item/clothing/neck/roguetown/psicross/necra
			cloak = /obj/item/clothing/cloak/templar/necran
		if(/datum/patron/divine/pestra)
			head = /obj/item/clothing/head/roguetown/roguehood/phys
			neck = /obj/item/clothing/neck/roguetown/psicross/pestra
			cloak = /obj/item/clothing/cloak/templar/pestran
		if(/datum/patron/divine/eora) //Eora content from stonekeep
			head = /obj/item/clothing/head/roguetown/eoramask
			neck = /obj/item/clothing/neck/roguetown/psicross/eora
			cloak = /obj/item/clothing/suit/roguetown/shirt/robe/eora
		if(/datum/patron/divine/noc)
			head = /obj/item/clothing/head/roguetown/nochood
			neck = /obj/item/clothing/neck/roguetown/psicross/noc
			cloak = /obj/item/clothing/cloak/tabard/crusader/noc
		if(/datum/patron/divine/ravox)
			head = /obj/item/clothing/head/roguetown/roguehood
			mask = /obj/item/clothing/head/roguetown/roguehood/ravoxgorget
			neck = /obj/item/clothing/neck/roguetown/psicross/ravox
			cloak = /obj/item/clothing/cloak/templar/ravox
			backpack_contents = list(/obj/item/ritechalk, /obj/item/book/rogue/law)
		if(/datum/patron/divine/malum)
			head = /obj/item/clothing/head/roguetown/roguehood
			neck = /obj/item/clothing/neck/roguetown/psicross/malum
			cloak = /obj/item/clothing/cloak/templar/malumite
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/steel
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltr = /obj/item/storage/keyring/churchie
	wrists = /obj/item/clothing/wrists/roguetown/bracers/jackchain
	gloves = /obj/item/clothing/gloves/roguetown/angle
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	H.grant_language(/datum/language/grenzelhoftian)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
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
	// -- End of section for god specific bonuses --
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC)
	H.change_stat("strength", -1)
	H.change_stat("endurance", 2)
	H.change_stat("speed", 3)
	H.change_stat("perception", 1)
	H.change_stat("intelligence", 2)

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T2, passive_gain = CLERIC_REGEN_MINOR, devotion_limit = CLERIC_REQ_2)	//Capped to T2 miracles.

/datum/outfit/job/roguetown/templar/vigilant/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	var/weapons = list("Dagger + Parrying Dagger","Rapier + Parrying Dagger","Recurve Bow")
	switch(H.patron?.type)
		if(/datum/patron/divine/pestra)
			weapons += "Plaguebringer Sickles"
		if(/datum/patron/divine/xylix)
			weapons += "Devilsknives"
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
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		if("Rapier + Parrying Dagger")
			H.put_in_hands(new /obj/item/rogueweapon/sword/rapier(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/parrying(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
		if("Recurve Bow")
			H.put_in_hands(new /obj/item/quiver/arrows(H), TRUE)
			H.put_in_hands(new /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve(H), TRUE) 
			H.adjust_skillrank_up_to(/datum/skill/combat/bows, 4, TRUE)
		if("Plaguebringer Sickles")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/pestrasickle(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/pestrasickle(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		if("Devilsknives")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/devilsknife(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/devilsknife(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		if("The Heartstring and Misericorde")
			H.put_in_hands(new /obj/item/rogueweapon/sword/rapier/eora(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/parrying/eora(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		if("Twilight Fangs")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/throwingknife/steel/noc(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/throwingknife/steel/noc(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		if("Dawnbringers")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/astrata(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/astrata(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		if("Echoes of Triumph")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/ravox(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/ravox(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		if("Darkwater Rippers")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/abyssor(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/abyssor(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		if("Madenning Thorns")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/dendor(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/dendor(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		if("Osteotomes")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/necra(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/necra(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		if("Embertongues")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/malum(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/malum(H), TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)

