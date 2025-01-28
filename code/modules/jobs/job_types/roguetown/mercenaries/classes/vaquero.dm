/datum/advclass/vaquero
	name = "Vaquero"
	tutorial = "A band of mercenaries hailing from the Isles of Etrusca, their name traced back to humble origins as cattle drivers."
	outfit = /datum/outfit/job/roguetown/mercenary/vaquero
	horse = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigabuck/tame/saddled
	cmode_music = 'sound/music/combat_vaquero.ogg'
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_OUTLANDER)

/datum/advclass/vaquero/equipme(mob/living/carbon/human/H)
	if(H.pronouns == SHE_HER || H.pronouns == THEY_THEM_F)
		horse = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/tame/saddled
	return ..()

/datum/outfit/job/roguetown/mercenary/vaquero/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/music, 3, TRUE)
	head = /obj/item/clothing/head/roguetown/bardhat
	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/clothing/neck/roguetown/gorget
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	belt = /obj/item/storage/belt/rogue/leather
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	cloak = /obj/item/clothing/cloak/half/rider/red
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/sword/rapier
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel/parrying
	backr = /obj/item/rogue/instrument/guitar
	backpack_contents = list(
					/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
					/obj/item/rogueweapon/huntingknife/idagger/navaja = 1,
					/obj/item/lockpick = 1,
					/obj/item/flashlight/flare/torch = 1
					)
	H.change_stat("strength", 1)
	H.change_stat("intelligence", 2)
	H.change_stat("endurance", 2)
	H.change_stat("speed", 3)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT (H, TRAIT_DECEIVING_MEEKNESS, TRAIT_GENERIC)
