/datum/job/roguetown/wapprentice
	title = "Magicians Apprentice"
	flag = MAGEAPPRENTICE
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 3
	spawn_positions = 4

	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT)

	tutorial = "Your master once saw potential in you, although you are uncertain if they still do, given how rigorous and difficult your studies have been. The path to using magic is a treacherous and untamed one, and you are still decades away from calling yourself even a journeyman in the field. Listen and serve, and someday you will earn your hat."

	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation, /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt)
	outfit = /datum/outfit/job/roguetown/wapprentice

	display_order = JDO_MAGEAPPRENTICE
	give_bank_account = TRUE

	min_pq = 0
	max_pq = null
	round_contrib_points = 2
	cmode_music = 'sound/music/combat_bandit_mage.ogg'

/datum/outfit/job/roguetown/wapprentice/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights/random
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/keyring/mage
	backr = /obj/item/storage/backpack/rogue/satchel
	r_hand = /obj/item/rogueweapon/woodstaff
	backpack_contents = list(/obj/item/roguegem/amethyst = 1)
	if(H.pronouns == SHE_HER || H.pronouns == THEY_THEM_F)
		shoes = /obj/item/clothing/shoes/roguetown/sandals
	else
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_spellpoints(1)
	H.change_stat("intelligence", 2)
	H.change_stat("speed", 1)
	switch(H.patron?.type)
		if(/datum/patron/inhumen/zizo)
			H.cmode_music = 'sound/music/combat_cult.ogg'
