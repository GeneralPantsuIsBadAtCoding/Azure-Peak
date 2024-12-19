/mob/living/carbon/human/species/tieberian
	race = /datum/species/tieberian

/datum/species/tieberian
	name = "Tiefling"
	id = "tiefling"
	desc = "<b>Tiefling</b><br>\
	Tieflings, also known as \"Infernal-Spawn\" by the Dwarves, are a relatively new species in the lands. \
	Having shown up sometime within the past two centuries, very little is known about their culture \
	as many seem to seamlessly intergrate into whatever society they find themselves in. \
	Despite this, Tieflings often cause strong disturbances wherever they go due to their fiendish appearances. \
	Many have claimed that they are the spawn of a succubus (Or incubus) laying with a mortal. \
	Due to this speculation, their species has suffered vast tragedy throughout their short history, \
	facing harsh scrutiny, unfair judgement, and even outright genocide in the worst cases. This history of brutal treatment and prejudce has resulted in the damage of many a Tiefling's psyche, causing to most of their kind to seek a solitary life away from the judgemental eyes of others. Tieflings cannot reproduce with mortals, and as a result no half-breed exists. Tieflings tend to be extremely perceptive and paranoid, as luck is rarely on their side, and their unique biology makes them extremely susceptible to injury.<br>\
	(+1 Intelligence)"

	skin_tone_wording = "Progenitor"

	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = MANDATORY_FEATURE_LIST
	use_skintones = 1
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = NONE
	possible_ages = ALL_AGES_LIST
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mt.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/male/elf
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
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,-1), \
		)
	race_bonus = list(STAT_INTELLIGENCE = 1)
	enflamed_icon = "widefire"
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/tiefling,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		//ORGAN_SLOT_TAIL = /obj/item/organ/tail/tiefling,
		//ORGAN_SLOT_HORNS = /obj/item/organ/horns/tiefling, We don't need these. No duplicate horns!
		)
	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
		/datum/bodypart_feature/hair/facial,
	)
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/bodypart_feature/underwear,
		/datum/customizer/organ/horns/anthro,
		/datum/customizer/organ/tail/tiefling,
		/datum/customizer/organ/testicles/anthro,
		/datum/customizer/organ/penis/anthro,
		/datum/customizer/organ/breasts/human,
		/datum/customizer/organ/vagina/human,
		)
	body_marking_sets = list(
		/datum/body_marking_set/none,
		/datum/body_marking_set/belly,
		/datum/body_marking_set/bellysocks,
		/datum/body_marking_set/tiger,
		/datum/body_marking_set/tiger_dark,
	)
	body_markings = list(
		/datum/body_marking/flushed_cheeks,
		/datum/body_marking/eyeliner,
		/datum/body_marking/tonage,
	)
	languages = list(
		/datum/language/common,
		/datum/language/hellspeak,
	)
	stress_examine = TRUE
	stress_desc = span_red("Helldweller... better stay away.")

/datum/species/tieberian/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/tieberian/after_creation(mob/living/carbon/C)
	..()
	to_chat(C, "<span class='info'>I can speak Infernal with ,h before my speech.</span>")

/datum/species/tieberian/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/tieberian/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/tieberian/get_skin_list()
	return list(
		"Jehoel" = SKIN_COLOR_JEHOEL,
		"Urvix" = SKIN_COLOR_URVIX,
		"Sarvyra" = SKIN_COLOR_SARVYRA,
		"Vheslyn" = SKIN_COLOR_VHESLYN,
		"Arlenneth" = SKIN_COLOR_ARLENNETH,
		"Nessyss" = SKIN_COLOR_NESSYSS,
		"Helixia" = SKIN_COLOR_HELIXIA,
		"Nymsea" = SKIN_COLOR_NYMSEA,
		"Calvus" = SKIN_COLOR_CALVUS
	)

/datum/species/tieberian/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b"
	))

/datum/species/tieberian/random_name(gender,unique,lastname)

	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/tiefm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/tieff.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/other/tiefm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/other/tieff.txt") )
	return randname

/datum/species/tieberian/random_surname()
	return " [pick(world.file2list("strings/rt/names/other/tieflast.txt"))]"
