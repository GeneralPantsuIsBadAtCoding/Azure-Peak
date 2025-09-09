/mob/living/carbon/human/species/seelie
	race = /datum/species/seelie
	gender = FEMALE

/datum/species/seelie
	name = "Seelie"
	id = "seelie"
	desc = "<b>Seelie</b><br>\
	The smallest of Fae-folk, Seelie are a mysterious race and not well understood. \
    Parentless creatures and apparently only feminine in nature, it is clear that they do not propogate in a typical human way. \
    Instead, Seelie tend to appear and gather in places of chaos and misfortune, thriving in such an environment. \
    Seelie are known to have Elemental Attunements, an influence of nature that mystically sprung them into existance. \
    Any tribalism or history regarding the race is scarce and uncommmon, and as such misconception and myth surrounds them. \
    The wary traveller should take heed of such beings, as both fortune and missery is said to accompany the little troublemakers."

	skin_tone_wording = "Elemental Connection"

	//gender = FEMALE
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY)	//Default shit that ever race gets
	inherent_traits = list(TRAIT_NOMOBSWAP)	//Use this to add custom Fae traits
	default_features = MANDATORY_FEATURE_LIST
	use_skintones = 1
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = NONE
	possible_ages = ALL_AGES_LIST
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/f/fm.dmi'		//CHANGE THESE TO NEW SPRITEWORK
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'		//All fairies are technically female in code, but are genderless in lore
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/female/elf
	soundpack_f = /datum/voicepack/female/elf
	offset_features = list(
		OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),\
		OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
		OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1), \
		OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,1), \
		OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1), \
		OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,0), OFFSET_BACK_F = list(0,-1), \
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0), \
		)
	specstats = list(
		"perception" = 4,
		"intelligence" = 2,
		"constitution" = -6,
		"endurance" = -1,
		"speed" = 7,
		"fortune" = 2
		)
	enflamed_icon = "widefire"
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/elfw,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		//ADD WINGS HERE
		ORGAN_SLOT_WINGS = /obj/item/organ/wings/seelie,
		)
	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
		///datum/bodypart_feature/hair/facial, //I think remove facial hair as all seelie are genderless female centric
	)
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/organ/wings/seelie,
		/datum/customizer/organ/testicles/human,
		/datum/customizer/organ/penis/human,
		/datum/customizer/organ/breasts/human,
		/datum/customizer/organ/vagina/human,
		)
	body_markings = list(
		/datum/body_marking/tonage,
	)
	languages = list(
		/datum/language/common,
		/datum/language/faexin,	//seelie speak here
	)
	stress_examine = TRUE
	stress_desc = span_red("A tiny seelie, mischievous in nature.")

/datum/species/seelie/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	ADD_TRAIT(C, TRAIT_TINY, "[type]")
	ADD_TRAIT(C, TRAIT_NOFALLDAMAGE1, TRAIT_GENERIC)
	C.transform = C.transform.Scale(0.5, 0.5)
	C.update_transform()
	C.pass_flags = PASSTABLE | PASSMOB
	//C.movement_type = FLYING
	C.set_mob_offsets("pixie_hover", _x = 0, _y = 10)
	C.set_light(3, 1, "#d4fcac")

/datum/species/seelie/after_creation(mob/living/carbon/C)
	..()
	to_chat(C, "<span class='info'>I can speak Faexin with ,p before my speech.</span>")
	C.verbs |= (/mob/living/carbon/human/proc/Turnlight)
	C.verbs |= (/mob/living/carbon/proc/switchaura)

/datum/species/seelie/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
	REMOVE_TRAIT(C, TRAIT_TINY, "[type]")
	REMOVE_TRAIT(C, TRAIT_NOFALLDAMAGE1, TRAIT_GENERIC)
	C.transform = C.transform.Scale(2, 2)
	C.update_transform()
	C.pass_flags = 0
	C.reset_offsets("pixie_hover")
	//C.movement_type = (C.movement_type | ~FLYING)
	//C.Jitter(0)
	C.set_light(0, 0, null)

/datum/species/seelie/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/seelie/get_skin_list()
	return list(
		//Change all of this to new skin or element colors
		"Water" = SKIN_COLOR_WATER,
		"Soil" = SKIN_COLOR_SOIL,
		"Rock" = SKIN_COLOR_ROCK,
		"Air" = SKIN_COLOR_AIR,
		"Fire" = SKIN_COLOR_FIRE,
		"Flora" = SKIN_COLOR_FLORA,
		"Lightning" = SKIN_COLOR_ELECTRIC,
	)

/datum/species/seelie/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b"
	))

/datum/species/seelie/random_name(gender,unique,lastname)

	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/fairyf.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/fairyf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/other/fairyf.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/other/fairyf.txt") )
	return randname

/datum/species/seelie/random_surname()
	return " [pick(world.file2list("strings/rt/names/other/fairyf.txt"))]"
