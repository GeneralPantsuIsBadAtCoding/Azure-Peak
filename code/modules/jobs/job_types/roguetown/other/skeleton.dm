/datum/job/roguetown/skeleton
	title = "Skeleton"
	flag = SKELETON
	department_flag = SLOP
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	min_pq = null //no pq
	max_pq = null

	tutorial = ""

	outfit = /datum/outfit/job/roguetown/skeleton
	show_in_credits = FALSE
	give_bank_account = FALSE

	cmode_music = 'sound/music/combat_weird.ogg'

/datum/job/roguetown/skeleton/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		L.can_do_sex = FALSE
		if(M.mind)
			M.mind.special_role = "skeleton"
			M.mind.assigned_role = "skeleton"
			M.mind.current.job = null
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
		H.remove_all_languages()
		H.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/simple/claw)
		H.update_a_intents()
		H.ambushable = FALSE
		if(H.charflaw)
			QDEL_NULL(H.charflaw)
		H.mob_biotypes = MOB_UNDEAD
		H.faction = list("undead")
		H.name = "skelelon"
		H.real_name = "skelelon"
		ADD_TRAIT(H, TRAIT_NOMOOD, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOROGSTAM, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBREATH, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOSLEEP, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
		for(var/obj/item/bodypart/B in H.bodyparts)
			B.skeletonize(FALSE)
		H.update_body()

/datum/outfit/job/roguetown/skeleton/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(50))
		wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(40))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	if(prob(10))
		head = /obj/item/clothing/head/roguetown/helmet
	if(prob(10))
		head = /obj/item/clothing/head/roguetown/helmet/skullcap
	if(prob(10))
		head = /obj/item/clothing/head/roguetown/helmet/horned
	if(prob(10))
		head = /obj/item/clothing/head/roguetown/helmet/kettle
	if(prob(50))
		beltr = /obj/item/rogueweapon/sword
		if(should_wear_femme_clothes(H))
			beltr = /obj/item/rogueweapon/sword/sabre
	H.STASTR = 10
	H.STASPD = rand(7,10)
	H.STAINT = 1
	H.STACON = 3
	var/datum/antagonist/new_antag = new /datum/antagonist/skeleton()
	H.mind.add_antag_datum(new_antag)
