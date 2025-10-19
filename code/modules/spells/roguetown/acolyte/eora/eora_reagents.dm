//Dummy fluid for effect
/datum/reagent/medicine/revival_fluid
	name = "Eoran Balm"
	description = "A miraculous fluid that slowly heals the dead, bringing them back to life when their wounds are mended."
	color = "#cd2be2"
	metabolization_rate = REAGENTS_METABOLISM
	taste_description = "cold hope"

/obj/item/reagent_containers/glass/bottle/revival
	name = "vial of Eoran Balm"
	desc = "An ominous violet fluid that seems to pulse with faint light. It's made out of strange shimmering glass. Looks fragile."
	list_reagents = list(/datum/reagent/medicine/revival_fluid = 48)

/obj/item/reagent_containers/glass/bottle/revival/attack(mob/living/M, mob/living/user)
	if(M.stat < DEAD)
		to_chat(user, "They're not dead!")
		return FALSE
	if(M.mind && !M.mind.active)
		to_chat(user, "[M]'s heart is inert. Maybe it will respond later?")
		return FALSE

	. = ..()
	if(iscarbon(M))
		if(HAS_TRAIT(M, TRAIT_DNR) && M.stat == DEAD)
			to_chat(user, span_warning("[M] will never come back, again."))
			return FALSE
		M.apply_status_effect(/datum/status_effect/buff/eoran_balm_effect)
	to_chat(user, span_notice("The bottle shatters after use!"))
	qdel(src)
	return TRUE
