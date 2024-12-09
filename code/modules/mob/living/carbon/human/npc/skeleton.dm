/mob/living/carbon/human/species/skeleton
	name = "skeleton"

	race = /datum/species/human/northern
	gender = MALE
	bodyparts = list(/obj/item/bodypart/chest, /obj/item/bodypart/head, /obj/item/bodypart/l_arm,
					 /obj/item/bodypart/r_arm, /obj/item/bodypart/r_leg, /obj/item/bodypart/l_leg)
	faction = list("undead")
	var/skel_outfit = /datum/outfit/job/roguetown/npc/skeleton
	var/skel_fragile = FALSE
	ambushable = FALSE
	rot_type = null
	base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/unarmed/claw)
	a_intent = INTENT_HELP
	possible_mmb_intents = list(INTENT_STEAL, INTENT_JUMP, INTENT_KICK, INTENT_BITE)
	possible_rmb_intents = list(/datum/rmb_intent/feint, /datum/rmb_intent/aimed, /datum/rmb_intent/strong, /datum/rmb_intent/weak)
	possible_rmb_intents = list()
	stand_attempts = 4
	cmode_music = 'sound/music/combat_weird.ogg'

/mob/living/carbon/human/species/skeleton/npc
	aggressive = 1
	mode = AI_IDLE
	wander = FALSE
	skel_fragile = TRUE

/mob/living/carbon/human/species/skeleton/npc/ambush

	wander = TRUE

/mob/living/carbon/human/species/skeleton/Initialize()
	. = ..()
	cut_overlays()
	spawn(10)
		after_creation()

/mob/living/carbon/human/species/skeleton/after_creation()
	..()
	if(src.dna && src.dna.species)
		src.dna.species.species_traits |= NOBLOOD
		src.dna.species.soundpack_m = new /datum/voicepack/skeleton()
		src.dna.species.soundpack_f = new /datum/voicepack/skeleton()
	var/obj/item/bodypart/O = src.get_bodypart(BODY_ZONE_R_ARM)
	if(O)
		O.drop_limb()
		qdel(O)
	O = src.get_bodypart(BODY_ZONE_L_ARM)
	if(O)
		O.drop_limb()
		qdel(O)
	src.regenerate_limb(BODY_ZONE_R_ARM)
	src.regenerate_limb(BODY_ZONE_L_ARM)
	// src.remove_all_languages()
	// uncomment this to prohibit skeletons from knowing or speaking any languages. This is commented to allow skeletons to be the main subject of admin events. (eg: skeleton traders, skeletons concealing their bones and blending in with the kingdom society, the underworld bar skeletons, skeletons telling skeleton jokes)
	if(src.charflaw)
		QDEL_NULL(src.charflaw)
	mob_biotypes |= MOB_UNDEAD
	faction = list("undead")
	name = "Skeleton"
	real_name = "Skeleton"
	voice_type = VOICE_TYPE_MASC //So that "Unknown Man" properly substitutes in with face cover
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_EASYDISMEMBER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LIMBATTACHMENT, TRAIT_GENERIC)
	if(skel_fragile)
		ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	var/obj/item/organ/eyes/eyes = src.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(src,1)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(src)
	for(var/obj/item/bodypart/B in src.bodyparts)
		B.skeletonize(FALSE)
	update_body()
	if(skel_outfit)
		var/datum/outfit/OU = new skel_outfit
		if(OU)
			equipOutfit(OU)

/datum/outfit/job/roguetown/npc/skeleton/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(50))
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(10))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	if(prob(30))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l
	if(prob(30))
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/vagrant/l
	if(prob(10))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	if(prob(10))
		head = /obj/item/clothing/head/roguetown/roguehood
	if(H.gender == FEMALE)
		H.STASTR = rand(9,12)
	else
		H.STASTR = rand(14,16)
	H.STASPD = 8
	H.STACON = 4
	H.STAEND = 15
	H.STAINT = 1
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword
	else
		r_hand = /obj/item/rogueweapon/stoneaxe/woodcut

/datum/outfit/job/roguetown/greater_skeleton/pre_equip(mob/living/carbon/human/H) //equipped onto Summon Greater Undead player skeletons only after the mind is added
	..()
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l
	pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	head = /obj/item/clothing/head/roguetown/helmet/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots

	H.STASTR = rand(14,16)
	H.STASPD = 8
	H.STACON = 9
	H.STAEND = 15
	H.STAINT = 1

	//light labor skills for skeleton manual labor and some warrior-adventurer skills, equipment is still bad probably
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)

	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)

	H.set_patron(/datum/patron/inhumen/zizo)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

	H.possible_rmb_intents = list(/datum/rmb_intent/feint,\
	/datum/rmb_intent/aimed,\
	/datum/rmb_intent/strong,\
	/datum/rmb_intent/swift,\
	/datum/rmb_intent/riposte,\
	/datum/rmb_intent/weak)
	H.swap_rmb_intent(num=1) //dont want to mess with base NPCs too much out of fear of breaking them so I assigned the intents in the outfit

	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword
	else
		r_hand = /obj/item/rogueweapon/stoneaxe/woodcut

/mob/living/carbon/human/species/skeleton/npc/no_equipment
    skel_outfit = null

/mob/living/carbon/human/species/skeleton/no_equipment
    skel_outfit = null
