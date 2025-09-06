/datum/advclass/twilight_afreet
	name = "Afreet"
	tutorial = "'Demon of Fire', the slaves used to call you, when you, dressed in black uniform, emerged from the sands, having shot their masters dead with weapons they could not comprehend. During the War, you were deployed deep within the Naledi lands, tasked with plundering Golden Empire's slave trade routes. Perhaps you found it too profitable and enjoyable to leave behind, or perhaps you still wage your war to this day — either way, you no longer answer to the Kaiser or his lackeys."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/bandit/twilight_afreet
	category_tags = list(CTAG_BANDIT)
	cmode_music = 'modular_twilight_axis/firearms/sound/music/combat_corsair.ogg'
	maximum_possible_slots = 2

/datum/outfit/job/roguetown/bandit/twilight_afreet/pre_equip(mob/living/carbon/human/H) //Basically an evil jager
	..()
	if (!(istype(H.patron, /datum/patron/inhumen/zizo) || istype(H.patron, /datum/patron/inhumen/matthios) || istype(H.patron, /datum/patron/inhumen/graggar) || istype(H.patron, /datum/patron/inhumen/baotha)))
		to_chat(H, span_warning("My former deity has abandoned me.. Matthios is my new master."))
		H.set_patron(/datum/patron/inhumen/matthios)	//We allow other heretics into the cool-kids club, but if you are a tennite/psydonian it sets you to matthiosan.
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/quiver/twilight_bullet/lead
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut
	backl = /obj/item/storage/backpack/rogue/backpack
	neck = /obj/item/clothing/neck/roguetown/coif
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/grenzelhoft
	head = /obj/item/clothing/head/roguetown/grenzelhofthat
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/grenzelpants
	shoes = /obj/item/clothing/shoes/roguetown/grenzelhoft
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzelgloves
	backr = /obj/item/gun/ballistic/twilight_firearm/flintgonne
	mask = /obj/item/clothing/mask/rogue/facemask/steel
	cloak = /obj/item/clothing/cloak/half/brown
	id = /obj/item/mattcoin
	backpack_contents = list(/obj/item/twilight_powderflask = 1, /obj/item/rogueweapon/huntingknife = 1, /obj/item/flint = 1, /obj/item/bedroll = 1, /obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1, /obj/item/flashlight/flare/torch = 1)

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.grant_language(/datum/language/grenzelhoftian)

	H.adjust_skillrank(/datum/skill/combat/twilight_firearms, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.change_stat("strength", 1)
	H.change_stat("endurance", 2)
	H.change_stat("speed", 3)
	H.change_stat("perception", 2)
	H.change_stat("constitution", 1)
