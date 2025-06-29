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
	possible_rmb_intents = list(/datum/rmb_intent/feint, /datum/rmb_intent/aimed, /datum/rmb_intent/weak)
	cmode_music = 'sound/music/combat_weird.ogg'

/mob/living/carbon/human/species/skeleton/npc
	aggressive = 1
	mode = NPC_AI_IDLE
	wander = FALSE
	skel_fragile = TRUE
	npc_jump_chance = 0 // no jumping skeletons
	rude = TRUE

/mob/living/carbon/human/species/skeleton/npc/ambush

	wander = TRUE
	skel_outfit = /datum/outfit/job/roguetown/npc/skeleton/ambush

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
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
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
	H.STASTR = 14
	H.STASPD = 8
	H.STACON = 4
	H.STAEND = 15
	H.STAINT = 1

	var/skeletonclass = rand(1, 15)
	if(skeletonclass < 4) // basic ass skele. Kinda sucks.
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/aalloy
		pants = /obj/item/clothing/under/roguetown/chainlegs/kilt/aalloy
		shoes = /obj/item/clothing/shoes/roguetown/boots/aalloy
		if(prob(50))
			r_hand = /obj/item/rogueweapon/stoneaxe/woodcut/aaxe
		else
			r_hand = /obj/item/rogueweapon/sword/iron/short/ashort
		return
	if(skeletonclass < 6) // Skeletal Pirate. Avast ye.
		head =  /obj/item/clothing/head/roguetown/helmet/tricorn
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
		wrists = /obj/item/clothing/wrists/roguetown/bracers/aalloy
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/aalloy
		pants = /obj/item/clothing/under/roguetown/tights/sailor
		shoes = /obj/item/clothing/shoes/roguetown/boots/aalloy
		if(prob(50))
			r_hand = /obj/item/rogueweapon/huntingknife/idagger/adagger
		else
			r_hand = /obj/item/rogueweapon/knuckles/aknuckles
		return
	if(skeletonclass < 10) // Skeletal MAA Equal. Getting kinda up there in being dangerous.
		cloak = /obj/item/clothing/cloak/stabard/surcoat/guard // Ooo Spooky Old Dead MAA
		head = /obj/item/clothing/head/roguetown/helmet/heavy/aalloy
		armor = /obj/item/clothing/suit/roguetown/armor/plate/half/aalloy
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/aalloy
		wrists = /obj/item/clothing/wrists/roguetown/bracers/aalloy
		pants = /obj/item/clothing/under/roguetown/chainlegs/kilt/aalloy
		shoes = /obj/item/clothing/shoes/roguetown/boots/aalloy
		neck = /obj/item/clothing/neck/roguetown/chaincoif/iron/aalloy
		gloves = /obj/item/clothing/gloves/roguetown/chain/aalloy
		l_hand = /obj/item/rogueweapon/shield/tower/metal/alloy
		if(prob(33))
			r_hand = /obj/item/rogueweapon/spear/aalloy
		else if(prob(33))
			r_hand = /obj/item/rogueweapon/sword/iron/short/gladius/agladius	// ave
		else
			r_hand = /obj/item/rogueweapon/flail/aflail
		return
	if(skeletonclass <= 13) // Skeletal Khopesh wielders(kinda spooky cultist sorta vibes idk?)
		cloak = /obj/item/clothing/cloak/hierophant
		mask = /obj/item/clothing/mask/rogue/facemask/aalloy
		armor = /obj/item/clothing/suit/roguetown/armor/plate/half/aalloy
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/aalloy
		wrists = /obj/item/clothing/wrists/roguetown/bracers/aalloy
		pants = /obj/item/clothing/under/roguetown/platelegs/aalloy
		shoes = /obj/item/clothing/shoes/roguetown/boots/aalloy
		neck = /obj/item/clothing/neck/roguetown/zcross/aalloy
		gloves = /obj/item/clothing/gloves/roguetown/chain/aalloy
		r_hand = /obj/item/rogueweapon/sword/sabre/alloy
		l_hand = /obj/item/rogueweapon/sword/sabre/alloy
		return
	if(skeletonclass == 15) // Withered Dread Knight
		cloak = /obj/item/clothing/cloak/tabard/blkknight
		head = /obj/item/clothing/head/roguetown/helmet/heavy/guard/aalloy
		armor = /obj/item/clothing/suit/roguetown/armor/plate/aalloy
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/aalloy
		wrists = /obj/item/clothing/wrists/roguetown/bracers/aalloy
		pants = /obj/item/clothing/under/roguetown/platelegs/aalloy
		shoes = /obj/item/clothing/shoes/roguetown/boots/aalloy
		neck = /obj/item/clothing/neck/roguetown/gorget/aalloy
		gloves = /obj/item/clothing/gloves/roguetown/plate/aalloy
		if(prob(50))
			r_hand = /obj/item/rogueweapon/greatsword/aalloy
		else
			r_hand = /obj/item/rogueweapon/mace/goden/aalloy
		return

/datum/outfit/job/roguetown/npc/skeleton/ambush/pre_equip(mob/living/carbon/human/H)
	var/skeletonclass = rand(1, 5)
	if(skeletonclass < 4) // basic ass skele. Kinda sucks.
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/aalloy
		pants = /obj/item/clothing/under/roguetown/chainlegs/kilt/aalloy
		shoes = /obj/item/clothing/shoes/roguetown/boots/aalloy
		if(prob(50))
			r_hand = /obj/item/rogueweapon/stoneaxe/woodcut/aaxe
		else
			r_hand = /obj/item/rogueweapon/sword/iron/short/ashort
		return
	if(skeletonclass < 6) // Skeletal Pirate. Avast ye.
		head =  /obj/item/clothing/head/roguetown/helmet/tricorn
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
		wrists = /obj/item/clothing/wrists/roguetown/bracers/aalloy
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/aalloy
		pants = /obj/item/clothing/under/roguetown/tights/sailor
		shoes = /obj/item/clothing/shoes/roguetown/boots/aalloy
		if(prob(50))
			r_hand = /obj/item/rogueweapon/huntingknife/idagger/adagger
		else
			r_hand = /obj/item/rogueweapon/knuckles/aknuckles
		return

/mob/living/carbon/human/species/skeleton/npc/no_equipment
    skel_outfit = null

/mob/living/carbon/human/species/skeleton/no_equipment
    skel_outfit = null
