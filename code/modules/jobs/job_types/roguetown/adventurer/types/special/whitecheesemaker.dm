/datum/advclass/whitecheese
	name = "WHITE CHEESE"
	allowed_sexes = list(MALE)
	allowed_races = list(/datum/species/human/northern)
	outfit = /datum/outfit/job/roguetown/adventurer/whitecheese
	traits_applied = list(TRAIT_HEAVYARMOR, TRAIT_BREADY, TRAIT_STEELHEARTED, TRAIT_ARCYNE_T2)
	// oh god oh fuck this dont seem very safe to do
	// this looks kinda op so imma just leave it at patreon level 1 until someone puts this behind a different lock
	maximum_possible_slots = 1

	horse = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigabuck/tame/saddled
	category_tags = list(CTAG_DISABLED)

/datum/outfit/job/roguetown/adventurer/whitecheese
	name = "WHITE CHEESE"

/datum/outfit/job/roguetown/adventurer/whitecheese/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 6, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, rand(4,5), TRUE)
	H.adjust_skillrank(/datum/skill/craft/masonry, rand(1,2), TRUE)


	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	gloves = /obj/item/clothing/gloves/roguetown/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	beltl = /obj/item/storage/belt/rogue/pouch/coins/rich

	H.dna.species.soundpack_m = new /datum/voicepack/male/evil/blkknight()

	H.change_stat(STATKEY_INT, 3)
	H.change_stat(STATKEY_STR, 4)
	H.change_stat(STATKEY_WIL, 4)
	H.change_stat(STATKEY_CON, 4)
	H.change_stat(STATKEY_SPD, 2)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
		H.mind.adjust_spellpoints(9)

	H.ambushable = FALSE
