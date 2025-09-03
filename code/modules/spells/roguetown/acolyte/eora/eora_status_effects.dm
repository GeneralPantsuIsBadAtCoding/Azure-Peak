/datum/status_effect/pearlescent_aril
	id = "pearlescent_aril"
	duration = 10 MINUTES
	tick_interval = 2 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/pearlescent_aril

/atom/movable/screen/alert/status_effect/pearlescent_aril
	name = "Pearlescent Cleansing"
	desc = "Poison heals you!"
	icon_state = "pearlescent"

/datum/status_effect/pearlescent_aril/on_apply()
	to_chat(owner, span_notice("A cleansing warmth spreads through your veins as the aril takes effect."))
	return ..()

/datum/status_effect/pearlescent_aril/tick()
	if(!owner.reagents || !iscarbon(owner))
		return
	
	var/mob/living/carbon/C = owner
	var/datum/reagents/R = C.reagents
	var/conversion_occurred = FALSE
	
	for(var/datum/reagent/RG in R.reagent_list)
		if(RG.harmful || istype(RG, /datum/reagent/medicine/stronghealth) && RG.volume > 0.1)
			R.remove_reagent(RG.type, 1)
			R.add_reagent(/datum/reagent/medicine/healthpot, 1)
			conversion_occurred = TRUE
	
	// Visual feedback if conversion occurred
	if(conversion_occurred)
		new /obj/effect/temp_visual/heal(get_turf(C), "#d8d8d8")

/datum/status_effect/pearlescent_aril/on_remove()
	to_chat(owner, span_warning("The cleansing warmth fades from your veins."))
	..()
