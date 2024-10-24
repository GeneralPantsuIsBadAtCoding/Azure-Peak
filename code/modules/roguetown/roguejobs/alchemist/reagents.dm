/datum/reagent/medicine/healthpot
	name = "Dated Health Potion"
	description = "Gradually regenerates all types of damage, is past it's shelf-life."
	reagent_state = LIQUID
	color = "#A20000"
	taste_description = "red"
	overdose_threshold = 45
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/healthpot/on_mob_life(mob/living/carbon/M)
	if(volume >= 60)
		M.reagents.remove_reagent(/datum/reagent/medicine/healthpot, 2) //No overhealing.
	var/list/wCount = M.get_wounds()
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+50, BLOOD_VOLUME_MAXIMUM)
	else
		//can overfill you with blood, but at a slower rate
		M.blood_volume = min(M.blood_volume+10, BLOOD_VOLUME_MAXIMUM)
	if(wCount.len > 0)
		//some peeps dislike the church, this allows an alternative thats not a doctor or sleep.
		M.heal_wounds(3) //at a motabalism of .5 U a tick this translates to 120WHP healing with 20 U Most wounds are unsewn 15-100. This is powerful on single wounds but rapidly weakens at multi wounds.
		M.update_damage_overlays()
	M.adjustBruteLoss(-0.7*REM, 0)
	M.adjustFireLoss(-0.7*REM, 0)
	M.adjustOxyLoss(-0.7, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -0.7*REM)
	M.adjustCloneLoss(-0.7*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/healthpot/overdose_start(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!istype(H.dna.species, /datum/species/werewolf))
			H.playsound_local(H, 'sound/misc/heroin_rush.ogg', 100, FALSE)
			H.visible_message(span_warning("Blood runs from [H]'s nose."))
	. = 1

/datum/reagent/medicine/healthpot/overdose_process(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!istype(H.dna.species, /datum/species/werewolf))
			M.adjustToxLoss(2, 0)
	..()
	. = 1

/datum/reagent/medicine/healthpotnew
	name = "Health Potion"
	description = "Gradually regenerates all types of damage."
	reagent_state = LIQUID
	color = "#ff0000"
	taste_description = "red"
	overdose_threshold = 45
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/healthpotnew/on_mob_life(mob/living/carbon/M)
	M.reagents.remove_reagent(/datum/reagent/medicine/healthpot, 100) //removes old health pot so you can't double-up
	if(volume >= 60)
		M.reagents.remove_reagent(/datum/reagent/medicine/healthpotnew, 2) //No overhealing.
	var/list/wCount = M.get_wounds()
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+50, BLOOD_VOLUME_MAXIMUM)
	else
		//can overfill you with blood, but at a slower rate
		M.blood_volume = min(M.blood_volume+10, BLOOD_VOLUME_MAXIMUM)
	if(wCount.len > 0)
		//some peeps dislike the church, this allows an alternative thats not a doctor or sleep.
		M.heal_wounds(3) //at a motabalism of .5 U a tick this translates to 120WHP healing with 20 U Most wounds are unsewn 15-100. This is powerful on single wounds but rapidly weakens at multi wounds.
		M.update_damage_overlays()
	M.adjustBruteLoss(-1.4*REM, 0)
	M.adjustFireLoss(-1.4*REM, 0)
	M.adjustOxyLoss(-1.4, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1.4*REM)
	M.adjustCloneLoss(-1.4*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/healthpotnew/overdose_start(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!istype(H.dna.species, /datum/species/werewolf))
			H.playsound_local(H, 'sound/misc/heroin_rush.ogg', 100, FALSE)
			H.visible_message(span_warning("Blood runs from [H]'s nose."))
	. = 1

/datum/reagent/medicine/healthpotnew/overdose_process(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!istype(H.dna.species, /datum/species/werewolf))
			M.adjustToxLoss(2, 0)
	..()
	. = 1

/datum/reagent/medicine/manapot
	name = "Mana Potion"
	description = "Gradually regenerates stamina."
	reagent_state = LIQUID
	color = "#0000ff"
	taste_description = "manna"
	overdose_threshold = 45
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/manapot/on_mob_life(mob/living/carbon/M)
	M.rogstam_add(10)
	..()
	. = 1

/datum/reagent/medicine/manapot/overdose_start(mob/living/M)
	M.playsound_local(M, 'sound/misc/heroin_rush.ogg', 100, FALSE)
	M.visible_message(span_warning("Blood runs from [M]'s nose."))
	. = 1

/datum/reagent/medicine/manapot/overdose_process(mob/living/M)
	M.adjustToxLoss(3, 0)
	..()
	. = 1

/datum/reagent/berrypoison
	name = "Berry Poison"
	description = "Contains a poisonous thick, dark purple liquid."
	reagent_state = LIQUID
	color = "#00B4FF"
	metabolization_rate = 0.1

/datum/reagent/berrypoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER))
		M.add_nausea(9)
		M.adjustToxLoss(3, 0)
	return ..()

/datum/reagent/organpoison
	name = "Organ Poison"
	description = "A viscous black liquid clings to the glass."
	reagent_state = LIQUID
	color = "#ff2f00"
	metabolization_rate = 0.1

/datum/reagent/organpoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER) && !HAS_TRAIT(M, TRAIT_ORGAN_EATER))
		M.add_nausea(9)
		M.adjustToxLoss(3, 0)
	return ..()

//pyro flower nectar - stonekeep port
/datum/reagent/toxin/fyritiusnectar
	name = "fyritius nectar"
	description = "oh no"
	reagent_state = LIQUID
	color = "#ffc400"
	metabolization_rate = 0.5

/datum/reagent/toxin/fyritiusnectar/on_mob_life(mob/living/carbon/M)
	if(volume > 0.99)
		M.add_nausea(9)
		M.adjustFireLoss(2, 0)
		M.adjust_fire_stacks(1)
		M.IgniteMob()
	return ..()

//toxin of the special pyroclastic crop harvest, just a stronger fyritius nectar
/datum/reagent/toxin/fyritiusnectar_special
	name = "pure fyritius extract"
	description = "oh no"
	reagent_state = LIQUID
	color = "#ffc400"
	metabolization_rate = 0.5

/datum/reagent/toxin/fyritiusnectar_special/on_mob_life(mob/living/carbon/M)
	if(volume > 0.99)
		M.add_nausea(9)
		M.adjustFireLoss(4, 0)
		M.adjust_fire_stacks(2)
		M.IgniteMob()
	return ..()
