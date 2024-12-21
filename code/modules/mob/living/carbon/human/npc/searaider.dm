GLOBAL_LIST_INIT(searaider_aggro, world.file2list("strings/rt/searaideraggrolines.txt"))

/mob/living/carbon/human/species/human/northern/searaider
	aggressive=1
	mode = AI_IDLE
	faction = list("viking", "station")
	ambushable = FALSE
	dodgetime = 30
	flee_in_pain = TRUE
	stand_attempts = 6
	possible_rmb_intents = list()
	var/is_silent = FALSE /// Determines whether or not we will scream our funny lines at people.


/mob/living/carbon/human/species/human/northern/searaider/ambush
	aggressive=1

	wander = TRUE

/mob/living/carbon/human/species/human/northern/searaider/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(!is_silent && target != newtarg)
			say(pick(GLOB.searaider_aggro))
			linepoint(target)

/mob/living/carbon/human/species/human/northern/searaider/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()

/mob/living/carbon/human/species/human/northern/searaider/Initialize()
	. = ..()
	set_species(/datum/species/human/northern)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)
	is_silent = TRUE


/mob/living/carbon/human/species/human/northern/searaider/after_creation()
	..()
	job = "Sea Raider"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/searaider)
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		organ_eyes.eye_color = pick("27becc", "35cc27", "000000")
	update_hair()
	update_body()

/mob/living/carbon/human/species/human/northern/searaider/npc_idle()
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

/mob/living/carbon/human/species/human/northern/searaider/handle_combat()
	if(mode == AI_HUNT)
		if(prob(50)) // ignores is_silent because they should at least still be able to scream at people!
			emote("rage")
	. = ..()

/datum/outfit/job/roguetown/human/species/human/northern/searaider/pre_equip(mob/living/carbon/human/H)
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(50))
		wrists = /obj/item/clothing/wrists/roguetown/bracers
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
	pants = /obj/item/clothing/under/roguetown/tights
	if(prob(50))
		pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	head = /obj/item/clothing/head/roguetown/helmet/leather
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/horned
	if(prob(50))
		neck = /obj/item/clothing/neck/roguetown/gorget
	if(prob(50))
		gloves = /obj/item/clothing/gloves/roguetown/leather
	H.STASPD = 9
	H.STACON = rand(10,12) //so their limbs no longer pop off like a skeleton
	H.STAEND = 15
	H.STAPER = 10
	H.STAINT = 1
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword
	else
		r_hand = /obj/item/rogueweapon/stoneaxe/battle
	l_hand = /obj/item/rogueweapon/shield/wood
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	if(prob(30))
		neck = /obj/item/clothing/neck/roguetown/chaincoif
		H.eye_color = pick("27becc", "35cc27", "000000")
	H.hair_color = pick ("4f4f4f", "61310f", "faf6b9")
	H.facial_hair_color = H.hair_color
	if(H.gender == FEMALE)
		H.STASTR = rand(14,16) //GENDER EQUALITY!!
		H.hairstyle = pick("Ponytail (Country)","Braid (Low)", "Braid (Short)", "Messy (Rogue)")
	else
		H.STASTR = rand(14,16)
		H.hairstyle = pick("Mohawk","Braid (Low)", "Braid (Short)", "Messy")
		H.facial_hairstyle = pick("Beard (Viking)", "Beard (Long)", "Beard (Manly)")
