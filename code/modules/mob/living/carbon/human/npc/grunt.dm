/mob/living/carbon/human/species/human/northern/grunt
	aggressive=1
	rude = FALSE
	mode = NPC_AI_IDLE
	ambushable = FALSE
	dodgetime = 30
	flee_in_pain = TRUE
	d_intent = INTENT_PARRY
	possible_rmb_intents = list()
	var/is_silent = FALSE
	var/warbandID
	var/warband = "FEUD"
	var/subtype
	var/faith
	var/list/abandon_textoptions = list("succumbs to an old infection - collapsing first to their knees, then crashing down face first.", "succumbs to the elements.", "goes pale, and faints soon afterwards. Their breathing stills.", "is lost to a hunger long unsated. They die thin and frail.")

/mob/living/carbon/human/species/human/northern/grunt/ambush
	aggressive=1

	wander = TRUE

/mob/living/carbon/human/species/human/northern/grunt/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(!is_silent && target != newtarg)
			say(pick(GLOB.highwayman_aggro))
			linepoint(target)

/mob/living/carbon/human/species/human/northern/grunt/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()


/mob/living/carbon/human/species/human/northern/grunt/proc/abandonevent(living)
	if(living)
		var/abandon_message = pick(abandon_textoptions)
		src.visible_message(span_info("[src] [abandon_message]"))
		src.adjustOxyLoss(200)
		src.adjustToxLoss(200)
		addtimer(CALLBACK(src, PROC_REF(rot_event)), 60 SECONDS) // repeats itself after 1 minute, clearing out the grunt's corpse
	else
		src.rot_event()

/mob/living/carbon/human/species/human/northern/grunt/proc/rot_event()
	src.visible_message(span_info("[src]'s corpse is taken by the Rot."))
	new /obj/effect/decal/remains/human(src.loc)
	qdel(src)

// killed by ocean & sewer tiles, so the warband's avenues of attack are limited
/mob/living/carbon/human/species/human/northern/grunt/proc/drownevent()
	src.emote("agony", forced = TRUE)
	src.visible_message(span_info("[src] thrashes and flails in the high waters, drowning under the weight of their gear!"))
	addtimer(CALLBACK(src, PROC_REF(drown_followup)), 3 SECONDS)

/mob/living/carbon/human/species/human/northern/grunt/proc/drown_followup()
		src.adjustOxyLoss(200)
		src.adjustToxLoss(200)

/mob/living/carbon/human/species/human/northern/grunt/Initialize()
	. = ..()
	set_species(/datum/species/human/northern)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)
	is_silent = TRUE


/mob/living/carbon/human/species/human/northern/grunt/after_creation()
	..()
	job = "Grunt"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_FORMATIONFIGHTER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

	//FIXNOTE: set faith
	//FIXNOTE: create NPC loadouts
	if(subtype)
		return
	else
		switch(warband)
			if("Rival Lord")
				equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/grunt)

			if("Sect")
				equipOutfit(new /datum/outfit/job/roguetown/quest_miniboss/matthios)

			if("Mercenary Company")
				equipOutfit(new /datum/outfit/job/roguetown/quest_miniboss/zizo)

			if("Peasant Rebellion")
				equipOutfit(new /datum/outfit/job/roguetown/quest_miniboss/zizo)

			if("Sorcerer-King")
				equipOutfit(new /datum/outfit/job/roguetown/quest_miniboss/blacksteel)



	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	var/hairf = pick(list(/datum/sprite_accessory/hair/head/bedhead, 
						/datum/sprite_accessory/hair/head/bob))
	var/hairm = pick(list(/datum/sprite_accessory/hair/head/ponytail1, 
						/datum/sprite_accessory/hair/head/shaved))
	var/beard = pick(list(/datum/sprite_accessory/hair/facial/vandyke,
						/datum/sprite_accessory/hair/facial/croppedfullbeard))

	var/datum/bodypart_feature/hair/head/new_hair = new()
	var/datum/bodypart_feature/hair/facial/new_facial = new()

	if(gender == FEMALE)
		new_hair.set_accessory_type(hairf, null, src)
	else
		new_hair.set_accessory_type(hairm, null, src)
		new_facial.set_accessory_type(beard, null, src)

	if(prob(50))
		new_hair.accessory_colors = "#96403d"
		new_hair.hair_color = "#96403d"
		new_facial.accessory_colors = "#96403d"
		new_facial.hair_color = "#96403d"
		hair_color = "#96403d"
	else
		new_hair.accessory_colors = "#C7C755"
		new_hair.hair_color = "#C7C755"
		new_facial.accessory_colors = "#C7C755"
		new_facial.hair_color = "#C7C755"
		hair_color = "#C7C755"

	head.add_bodypart_feature(new_hair)
	head.add_bodypart_feature(new_facial)

	dna.update_ui_block(DNA_HAIR_COLOR_BLOCK)
	dna.species.handle_body(src)


	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		var/picked_eye_color = pick("#365334", "#395c70", "#30261e")
		organ_eyes.eye_color = picked_eye_color
		organ_eyes.accessory_colors = picked_eye_color + picked_eye_color


	update_hair()
	update_body()

/mob/living/carbon/human/species/human/northern/grunt/npc_idle()
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

/mob/living/carbon/human/species/human/northern/grunt/handle_combat()
	if(mode == NPC_AI_HUNT)
		if(prob(2)) 
			emote("rage")
	. = ..()

/datum/outfit/job/roguetown/human/species/human/northern/grunt/pre_equip(mob/living/carbon/human/H)
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/iron
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	cloak = /obj/item/clothing/cloak/stabard/warband
	r_hand = /obj/item/rogueweapon/shield/heater
/// WEAPONS
	if(prob(60))
		l_hand = /obj/item/rogueweapon/spear
	else
		l_hand = /obj/item/rogueweapon/sword/iron
// EXTRA ARMOR
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/sallet/iron
	else
		head = null	
	if(prob(50))
		gloves = /obj/item/clothing/gloves/roguetown/plate/iron
	else
		gloves = null
	if(prob(50))
		neck = /obj/item/clothing/neck/roguetown/gorget
	else
		neck = null
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 1, TRUE)
	H.STASTR = 12
	H.STASPD = 11
	H.STACON = 14
	H.STAWIL = 12
	H.STAINT = 10
	H.STAPER = 12
