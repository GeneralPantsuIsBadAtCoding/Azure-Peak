/datum/advclass/vagabond_unraveled
    name = "The Unraveled"
    tutorial = "Your mind is frayed and unraveling — reality slips through your fingers like threads of a broken tapestry. Hallucinations blur truth and lie, driving you between brilliance and madness."
    allowed_sexes = list(MALE, FEMALE)
    allowed_races = RACES_NO_CONSTRUCT
    outfit = /datum/outfit/job/roguetown/vagabond/unraveled
    category_tags = list(CTAG_VAGABOND)
    traits_applied = list(TRAIT_SCHIZO_AMBIENCE)
    subclass_stats = list(
        STATKEY_INT = -2,
        STATKEY_LCK = -2,
    )
    subclass_skills = list(
        /datum/skill/misc/medicine = SKILL_LEVEL_JOURNEYMAN,
        /datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
    )

/datum/outfit/job/roguetown/vagabond/unraveled/pre_equip(mob/living/carbon/human/human)
    ..()
        
    pants = /obj/item/clothing/under/roguetown/loincloth
    r_hand = /obj/item/rogueweapon/woodstaff

    if(prob(33))
        cloak = /obj/item/clothing/cloak/half/brown
        gloves = /obj/item/clothing/gloves/roguetown/fingerless
	
    human.hallucination = INFINITY
