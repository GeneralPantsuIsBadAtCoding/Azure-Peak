/*
* a collection of sprite accessories for constructs that are designed to represent plating, greebles, panels, etc
*/

/datum/body_marking/construct_plating_light
	icon = 'icons/mob/body_markings/construct_plating.dmi'
	name = "Light Plating"
	icon_state = "light_plating"
	affected_bodyparts = CHEST | HAND_LEFT | HAND_RIGHT | ARM_LEFT | ARM_RIGHT | LEG_LEFT | LEG_RIGHT
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE
	gendered = FALSE

/datum/body_marking/construct_plating_medium
	icon = 'icons/mob/body_markings/construct_plating.dmi'
	name = "Medium Plating"
	icon_state = "medium_plating"
	affected_bodyparts = CHEST | HAND_LEFT | HAND_RIGHT | ARM_LEFT | ARM_RIGHT | LEG_LEFT | LEG_RIGHT
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE
	gendered = FALSE

/datum/body_marking/construct_plating_heavy
	icon = 'icons/mob/body_markings/construct_plating.dmi'
	name = "Heavy Plating"
	icon_state = "heavy_plating"
	affected_bodyparts = CHEST | HAND_LEFT | HAND_RIGHT | ARM_LEFT | ARM_RIGHT | LEG_LEFT | LEG_RIGHT
	default_color = DEFAULT_SECONDARY
	covers_chest = TRUE
	gendered = FALSE

/datum/body_marking_set/construct_plating_light
	name = "Light Plating"
	body_marking_list = list(/datum/body_marking/construct_plating_light)

/datum/body_marking_set/construct_plating_medium
	name = "Medium Plating"
	body_marking_list = list(/datum/body_marking/construct_plating_medium)

/datum/body_marking_set/construct_plating_heavy
	name = "Heavy Plating"
	body_marking_list = list(/datum/body_marking/construct_plating_heavy)

/datum/body_marking/construct_head_standard
	icon = 'icons/mob/body_markings/construct_heads.dmi'
	name = "Standard Head"
	icon_state = "standard"
	affected_bodyparts = HEAD
	default_color = DEFAULT_SECONDARY
	gendered = FALSE

/datum/body_marking/construct_head_round
	icon = 'icons/mob/body_markings/construct_heads.dmi'
	name = "Round Head"
	icon_state = "round"
	affected_bodyparts = HEAD
	default_color = DEFAULT_SECONDARY
	gendered = FALSE

/datum/body_marking/construct_standard_eyes
	name = "Standard Eyes"
	icon = 'icons/mob/body_markings/construct_eyes.dmi'
	icon_state = "standard"
	affected_bodyparts = HEAD
	default_color = DEFAULT_SECONDARY
	gendered = FALSE

/datum/body_marking/construct_visor_eyes
	name = "Visored Eyes"
	icon = 'icons/mob/body_markings/construct_eyes.dmi'
	icon_state = "visor"
	affected_bodyparts = HEAD
	default_color = DEFAULT_SECONDARY
	gendered = FALSE

/datum/body_marking/construct_psyclops_eye
	name = "Psyclopean Eye"
	icon = 'icons/mob/body_markings/construct_eyes.dmi'
	icon_state = "psyclops"
	affected_bodyparts = HEAD
	default_color = DEFAULT_SECONDARY
	gendered = FALSE
