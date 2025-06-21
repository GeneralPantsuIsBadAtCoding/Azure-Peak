/* 
*	based on pages from elden ring in terms of visual design, these guys are intended to be a speedbump to solo adventurers at mount decap
*	deadly but small in numbers. come back with a party, chump
*/

/mob/living/carbon/human/species/human/northern/mad_touched_teasure_hunter
	aggressive=1
	mode = AI_IDLE
	faction = list("viking", "station")
	ambushable = FALSE
	dodgetime = 15
	flee_in_pain = FALSE
	stand_attempts = 6
	possible_rmb_intents = list()

/mob/living/carbon/human/species/human/northern/mad_touched_teasure_hunter/ambush
	aggressive = 1
	wander = TRUE

/mob/living/carbon/human/species/human/northern/mad_touched_teasure_hunter/Initialize()
	. = ..()
	set_species(/datum/species/human/northern)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)

/mob/living/carbon/human/species/human/northern/mad_touched_teasure_hunter/after_creation()
	..()
	job = "Mad-touched Treasure Hunter"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_DISFIGURED, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/mad_touched_teasure_hunter)
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		organ_eyes.eye_color = pick("27becc", "35cc27", "000000")
	update_hair()
	update_body()
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	head.sellprice = 40

/mob/living/carbon/human/species/human/northern/mad_touched_teasure_hunter/npc_idle()
	if(m_intent == MOVE_INTENT_SNEAK)
		return
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc,pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src,pick(GLOB.cardinals)))
	if(!wander && prob(10))
		face_atom(get_step(src,pick(GLOB.cardinals)))

/datum/outfit/job/roguetown/human/species/human/northern/mad_touched_teasure_hunter/pre_equip(mob/living/carbon/human/H)
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	mask = /obj/item/clothing/mask/rogue/facemask/steel/paalloy/mad_touched
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(33))
		beltl = /obj/item/reagent_containers/glass/bottle/alchemical/healthpot
	head = /obj/item/clothing/head/roguetown/menacing/mad_touched_treasure_hunter
	neck = /obj/item/clothing/neck/roguetown/coif
	gloves = /obj/item/clothing/gloves/roguetown/angle
	cloak = /obj/item/clothing/cloak/wickercloak
	if(prob(50))
		r_hand = /obj/item/rogueweapon/greatsword/paalloy
	else
		r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow //they're too stupid to use this but it makes the sprite look cool +  simplemobs are lame
		l_hand = /obj/item/rogueweapon/huntingknife/idagger/steel/padagger
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	H.STASTR = rand(14,16)
	H.STASPD = 18 //you will regret telling me that bows are good for pve
	H.STACON = rand(14,18)
	H.STAEND = 13
	H.STAPER = 10
	H.STAINT = 14
	H.eye_color = "27becc"
	H.hair_color = "61310f"
	H.facial_hair_color = H.hair_color
	if(H.gender == FEMALE)
		H.hairstyle =  "Messy (Rogue)"
	else
		H.hairstyle = "Messy"

/obj/item/clothing/head/roguetown/menacing/mad_touched_treasure_hunter //its here so it doesnt wind up on some class' loadout.
	name = "sack hood"
	desc = "A ragged hood of thick jute fibres. The itchiness is unbearable."
	sewrepair = TRUE
	color = "#999999"
	armor = ARMOR_HEAD_HELMET_BAD

/obj/item/clothing/mask/rogue/facemask/steel/paalloy/mad_touched
	name = "eerie ancient mask"

/obj/item/clothing/mask/rogue/facemask/steel/paalloy/mad_touched/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/datum/ambush_config/solo_treasure_hunter
	mob_types = list(
		/mob/living/carbon/human/species/human/northern/mad_touched_teasure_hunter/ambush = 1,
	)

/datum/ambush_config/duo_treasure_hunter
	mob_types = list(
		/mob/living/carbon/human/species/human/northern/mad_touched_teasure_hunter/ambush = 2,
	)

/datum/ambush_config/treasure_hunter_posse
	mob_types = list(
		/mob/living/carbon/human/species/human/northern/mad_touched_teasure_hunter/ambush = 3,
	)
