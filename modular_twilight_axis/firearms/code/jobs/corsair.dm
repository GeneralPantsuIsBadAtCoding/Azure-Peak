/obj/item/clothing/suit/roguetown/armor/leather/vest/sailor/grenzelhoft
	name = "reichsmarine sailor's jacket"
	desc = "A dark coat commonly worn by Grenzelhoft sailors and officers. Made out of studded leather and provides decent protection against blades."
	color = "#3C3C3C"
	icon_state = "longcoat"
	item_state = "longcoat"
	body_parts_covered = COVERAGE_ALL_BUT_ARMS
	armor = ARMOR_LEATHER_GOOD
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT, BCLASS_CHOP, BCLASS_SMASH)
	max_integrity = ARMOR_INT_CHEST_LIGHT_MASTER
	sellprice = 25

/datum/advclass/wretch/twilight_corsair
	name = "Corsair"
	tutorial = "During the Twilight War, you served aboard a Reichsmarine warship, intercepting, boarding and ravaging Golden Empire's trade vessels on Kaiser's orders. After the war ended, your crew saw it fit to continue with the practice, flying a flag with a different shade of black."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/twilight_corsair
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_DODGEEXPERT, TRAIT_OUTLAW, TRAIT_HERESIARCH)
	maximum_possible_slots = 2
	subclass_languages = list(/datum/language/grenzelhoftian)
	cmode_music = 'modular_twilight_axis/firearms/sound/music/combat_corsair.ogg'
	subclass_stats = list(
		STATKEY_WIL = 2,
		STATKEY_SPD = 2,
		STATKEY_PER = 2,
	)
	subclass_skills = list(
		/datum/skill/combat/twilight_firearms = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/bows = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/crossbows = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/axes = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_EXPERT,
		/datum/skill/labor/lumberjacking = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/swimming = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/tracking = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/sneaking = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/stealing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/lockpicking = SKILL_LEVEL_JOURNEYMAN,
	)

/datum/outfit/job/roguetown/wretch/twilight_corsair/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/quiver/twilight_bullet/lead
	beltr = /obj/item/rogueweapon/scabbard/sword
	backl = /obj/item/storage/backpack/rogue/satchel
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/grenzelhoft
	head = /obj/item/clothing/head/roguetown/helmet/tricorn/grenzel
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor/grenzelhoft
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/grenzelpants
	shoes = /obj/item/clothing/shoes/roguetown/grenzelhoft
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzelgloves
	backr = /obj/item/gun/ballistic/twilight_firearm/flintgonne
	r_hand = /obj/item/rogueweapon/sword/cutlass
	backpack_contents = list(/obj/item/twilight_powderflask = 1, /obj/item/natural/cloth = 1, /obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1, /obj/item/storage/belt/rogue/pouch/coins/poor = 1)
	

	var/masks = list(
		"Steel Mask"		= /obj/item/clothing/mask/rogue/facemask/steel,
		"Wildguard"			= /obj/item/clothing/mask/rogue/wildguard,
		"None"
		)
	H.set_blindness(0)
	var/maskchoice = input("Choose your Mask.", "MASK MASK MASK") as anything in masks // Run from it. MASK. MASK. MASK.
	if(maskchoice != "None")
		mask = masks[maskchoice]	

	wretch_select_bounty(H)
