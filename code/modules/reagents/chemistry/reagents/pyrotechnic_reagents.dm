/datum/reagent/stabilizing_agent
	name = "Stabilizing Agent"
	description = "Keeps unstable chemicals stable. This does not work on everything."
	reagent_state = LIQUID
	color = "#FFFF00"
	taste_description = "metal"

/datum/reagent/gunpowder
	name = "Gunpowder"
	description = "Explodes. Violently."
	reagent_state = LIQUID
	color = "#000000"
	metabolization_rate = 0.05
	taste_description = "salt"

/datum/reagent/gunpowder/on_mob_life(mob/living/carbon/M)
	. = TRUE
	..()
	M.set_drugginess(15)
	if(M.hallucination < volume)
		M.hallucination += 5

/datum/reagent/gunpowder/on_ex_act()
	var/location = get_turf(holder.my_atom)
	var/datum/effect_system/reagents_explosion/e = new()
	e.set_up(1 + round(volume/6, 1), location, 0, 0, message = 0)
	e.start()
	holder.clear_reagents()
