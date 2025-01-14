/datum/reagent/miasmagas
	name = "miasmagas"
	description = "."
	color = "#801E28" // rgb: 128, 30, 40
	taste_description = "ugly"
	metabolization_rate = 1

/datum/reagent/miasmagas/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NOSTINK) && !physician_mask_check(M))
		M.add_nausea(15)
		M.add_stress(/datum/stressevent/miasmagas)
	return ..()

/proc/physician_mask_check(mob/living/carbon/M)
	if(!M)
		return FALSE
	if(!istype(M, /mob/living/carbon/human))
		return FALSE
	var/mob/living/carbon/human/H = M
	if(!H.wear_mask)
		return FALSE
	return istype(H.wear_mask, /obj/item/clothing/mask/rogue/physician)

/datum/reagent/rogueacid
	name = "rogueacid"
	description = "."
	reagent_state = LIQUID
	color = "#5eff00"
	taste_description = "burning"
	self_consuming = TRUE

/datum/reagent/rogueacid/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	M.adjustFireLoss(35, 0)
	..()
