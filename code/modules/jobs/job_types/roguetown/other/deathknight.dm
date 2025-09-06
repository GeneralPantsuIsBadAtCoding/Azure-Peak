/datum/job/roguetown/deathknight
	title = "Death Knight"
	flag = DEATHKNIGHT
	department_flag = SLOP
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	min_pq = null //no pq
	max_pq = null

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	tutorial = ""

	outfit = /datum/outfit/job/roguetown/deathknight

	show_in_credits = FALSE
	give_bank_account = FALSE
	announce_latejoin = FALSE
	
	cmode_music = 'sound/music/combat_weird.ogg'

/datum/outfit/job/roguetown/deathknight/pre_equip(mob/living/carbon/human/H)
	..()
	SSmapping.find_and_remove_world_trait(/datum/world_trait/death_knight)
	SSmapping.retainer.death_knights |= H.mind
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/platelegs/blk/death
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/blkknight/death
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	armor = /obj/item/clothing/suit/roguetown/armor/plate/blkknight/death
	gloves = /obj/item/clothing/gloves/roguetown/plate/blk/death
	backl = /obj/item/rogueweapon/sword/long/death
	head = /obj/item/clothing/head/roguetown/helmet/heavy/knight/black
	neck = /obj/item/clothing/neck/roguetown/bervor/death
	beltr = /obj/item/rogueweapon/scabbard/sword
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.STASTR = 12
		H.STAINT = 13
		H.STACON = 12
		H.STAWIL = 12
		H.STASPD = 7
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/gravity)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
		H.ambushable = FALSE
		var/datum/antagonist/new_antag = new /datum/antagonist/skeleton/knight()
		H.mind.add_antag_datum(new_antag)

	..()
	if(H)
		H.can_do_sex = FALSE
		if(H.mind)
			H.mind.special_role = "Death Knight"
			H.mind.assigned_role = "Death Knight"
			H.mind.current.job = null
		if(H.dna && H.dna.species)
			H.dna.species.species_traits |= NOBLOOD
			H.dna.species.soundpack_m = new /datum/voicepack/skeleton()
			H.dna.species.soundpack_f = new /datum/voicepack/skeleton()
		var/obj/item/bodypart/O = H.get_bodypart(BODY_ZONE_R_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		O = H.get_bodypart(BODY_ZONE_L_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		H.regenerate_limb(BODY_ZONE_R_ARM)
		H.regenerate_limb(BODY_ZONE_L_ARM)
//		H.remove_all_languages()
		H.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/simple/claw)
		H.update_a_intents()

		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.Remove(H,1)
			QDEL_NULL(eyes)
		eyes = new /obj/item/organ/eyes/night_vision/zombie
		eyes.Insert(H)
		H.ambushable = FALSE
		if(H.charflaw)
			QDEL_NULL(H.charflaw)
		H.mob_biotypes |= MOB_UNDEAD
		H.faction = list("undead")
		H.name = "Death Knight"
		H.real_name = "Death Knight"
		ADD_TRAIT(H, TRAIT_NOMOOD, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_INFINITE_STAMINA, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBREATH, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOSLEEP, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_ARCYNE_T2, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_VAMPMANSION, TRAIT_GENERIC)
	/*	H.possible_rmb_intents = list(/datum/rmb_intent/feint,\
		/datum/rmb_intent/aimed,\
		/datum/rmb_intent/strong,\
		/datum/rmb_intent/riposte,\
		/datum/rmb_intent/weak) */
		for(var/obj/item/bodypart/B in H.bodyparts)
			B.skeletonize(FALSE)
		H.update_body()

/obj/item/clothing/suit/roguetown/armor/plate/blkknight/death
	color = CLOTHING_BLACK

/obj/item/clothing/shoes/roguetown/boots/armor/blkknight/death
	color = CLOTHING_BLACK

/obj/item/clothing/gloves/roguetown/plate/blk/death
	color = CLOTHING_BLACK

/obj/item/clothing/under/roguetown/platelegs/blk/death
	color = CLOTHING_BLACK

/obj/item/clothing/neck/roguetown/bervor/death
	color = CLOTHING_BLACK
