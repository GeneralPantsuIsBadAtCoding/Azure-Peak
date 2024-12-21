/datum/advclass/sorceress
	name = "Sorceress"
	tutorial = "In some places in Grimmoria, women are banned from the study of magic. Those that do even then are afforded the title Sorceress in honor of their resolve."
	allowed_sexes = list(FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/sorceress
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	category_tags = list(CTAG_DISABLED)
	cmode_music = 'sound/music/combat_bandit_mage.ogg'

/datum/outfit/job/roguetown/adventurer/sorceress/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	pants = /obj/item/clothing/under/roguetown/trou/leather
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
	belt = /obj/item/storage/belt/rogue/leather/rope
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
						/obj/item/flashlight/flare/torch = 1,
						)
	beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
	beltl = /obj/item/rogueweapon/huntingknife
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	r_hand = /obj/item/rogueweapon/woodstaff
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(0,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, pick(2,3,3), TRUE)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 4)
		H.change_stat("speed", 1)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
