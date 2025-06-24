/datum/job/roguetown/lunatic
	title = "Lunatic"
	flag = LUNATIC
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	round_contrib_points = 2
	var/list/traits_applied
	traits_applied = list(TRAIT_SCHIZO_AMBIENCE, TRAIT_NOSTINK, TRAIT_MANIAC_AWOKEN) // Maniac_Awoken no longer has any function other than the flavor text and trait
  
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	outfit = /datum/outfit/job/roguetown/lunatic
	bypass_lastclass = TRUE
	bypass_jobban = FALSE
	min_pq = 100 //the magic of an allowlist server.
	max_pq = null
	tutorial = "The Lunatic, shunned by society and a magnet for misfortune. Your task is simple yet perilous: survive by any means, though your very existence invites danger from every corner. It is said that Azure Peak drives those most familiar with it, the most insane."
	display_order = JDO_LUNATIC

	cmode_music = 'sound/music/combat_bum.ogg'

/datum/outfit/job/roguetown/lunatic/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.STALUC = rand(3, 8)
	H.change_stat("speed", 2)
	armor = /obj/item/clothing/suit/roguetown/shirt/rags
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	pants = /obj/item/clothing/under/roguetown/tights/vagrant
	belt  = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/rogueweapon/huntingknife/stoneknife
	beltr = /obj/item/flashlight/flare/torch
	ADD_TRAIT(H, TRAIT_JESTERPHOBIA, TRAIT_GENERIC)
