/datum/advclass/mercenary/twilight_grenzelhoft_jager
	name = "Grenzelhoft Jäger"
	tutorial = "Trackers, Huntsmen, Marksmen. Those are the first words that describe a Jäger of the Free Corps. \
	Jägers are skilled handgonners and scouts of the Companies of the Grenzel Emperiate. Beastmen and elves are commonly found to \
	fill the Auxiliary ranks, however you are one of the lucky few that was allowed to join the Free Corps. \
	You are expected to provide the Guild with your expertise in tracking, and scouting. Alongside your marksmanship."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/mercenary/twilight_grenzelhoft_jager
	maximum_possible_slots = 4
	min_pq = 15
	cmode_music = 'sound/music/combat_grenzelhoft.ogg'
	class_select_category = CLASS_CAT_GRENZELHOFT
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_OUTLANDER, TRAIT_DODGEEXPERT)
	subclass_stats = list(
		STATKEY_CON = 1,
		STATKEY_WIL = 2,
		STATKEY_SPD = 3,
		STATKEY_PER = 2,
	)

/datum/outfit/job/roguetown/mercenary/twilight_grenzelhoft_jager/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/quiver/twilight_bullet/lead
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel
	backl = /obj/item/storage/backpack/rogue/backpack
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/grenzelhoft
	head = /obj/item/clothing/head/roguetown/grenzelhofthat
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/grenzelpants
	shoes = /obj/item/clothing/shoes/roguetown/grenzelhoft
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzelgloves
	backr = /obj/item/gun/ballistic/twilight_firearm/arquebus
	backpack_contents = list(/obj/item/roguekey/mercenary = 1, /obj/item/twilight_powderflask = 1, /obj/item/rogueweapon/huntingknife = 1, /obj/item/flint = 1, /obj/item/bedroll = 1, /obj/item/storage/belt/rogue/pouch/coins/poor = 1)

	H.grant_language(/datum/language/grenzelhoftian)

	H.adjust_skillrank(/datum/skill/combat/twilight_firearms, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
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

	H.merctype = 7
