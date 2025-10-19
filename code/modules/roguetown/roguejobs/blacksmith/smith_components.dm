/datum/component/anvil_quenchable
	var/datum/anvil_recipe/recipe
	var/obj/item/ingot/associated_ingot

/datum/component/anvil_quenchable/Initialize(datum/anvil_recipe/R, obj/item/ingot/I)
	if(!istype(R) || !istype(I))
		return COMPONENT_INCOMPATIBLE

	recipe = R
	associated_ingot = I
	RegisterSignal(associated_ingot, COMSIG_ITEM_QUENCHED, .proc/on_quenched)

/datum/component/anvil_quenchable/proc/on_quenched(obj/item/ingot/source, mob/user, turf/used_turf)
	SIGNAL_HANDLER

	// Only process if the recipe is complete. Sanity check
	if(recipe.progress < recipe.max_progress)
		to_chat(user, span_warning("It's not finished yet."))
		return

	// Create the item(s)
	recipe.handle_creation(used_turf)

	// Clean up
	qdel(associated_ingot)
	qdel(src)
