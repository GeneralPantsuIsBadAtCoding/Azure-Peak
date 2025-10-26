/obj/item/heart_canister
	name = "alchemical canister"
	desc = ""
	icon = 'icons/obj/structures/heart_items.dmi'
	icon_state = "canister_empty"
	w_class = WEIGHT_CLASS_TINY
	
	var/obj/structure/stone_rack/parent_rack
	var/filled = FALSE
	var/current_color = "#ffffff"
	var/current_aspect_name = ""
	var/current_aspect_type = null
	var/required_item_type = null
	var/expected_color = "#ffffff"
	var/aspect_datum_ref = null
	var/attuned = FALSE
	var/calibrated = FALSE
	var/calibration_progress = 0
	var/calibration_required = 0
	var/broken = FALSE

/obj/item/heart_canister/attack_self(mob/user)
	if(broken)
		to_chat(user, span_warning("This canister is broken and useless."))
		return

	if(filled)
		to_chat(user, span_warning("This canister is already filled!"))
		return

	if(attuned)
		to_chat(user, span_warning("This canister is already attuned to [current_aspect_name]!"))
		return

	show_aspect_menu(user)

/obj/item/heart_canister/proc/show_aspect_menu(mob/user)
	var/list/categories = list(
		"Archetypes" = "Choose from available archetypes",
		"Traits" = "Choose from available traits", 
		"Quirks" = "Choose from available quirks",
		"Cancel" = "Do not attune"
	)

	var/category_choice = input(user, "Select aspect category to attune:", "Canister Attunement") as null|anything in categories
	if(!category_choice || category_choice == "Cancel")
		return

	show_aspects_in_category(category_choice, user)

/obj/item/heart_canister/proc/show_aspects_in_category(category, mob/user)
	var/list/aspects = list()
	var/category_name = ""
	var/singular_name = ""

	switch(category)
		if("Archetypes")
			aspects = get_global_archetypes()
			category_name = "archetypes"
			singular_name = "archetype"
		if("Traits")
			aspects = get_global_traits()
			category_name = "traits"
			singular_name = "trait"
		if("Quirks")
			aspects = get_global_quirks()
			category_name = "quirks"
			singular_name = "quirk"

	if(!aspects.len)
		to_chat(usr, span_warning("No [category_name] found!"))
		return

	var/list/selection_options = list()
	for(var/datum_type in aspects)
		var/datum/A = aspects[datum_type]

		var/datum/flesh_archetype/archetype
		var/datum/flesh_trait/trait  
		var/datum/flesh_quirk/quirk
		
		var/aspect_name
		var/required_item_type
		
		if(istype(A, /datum/flesh_archetype))
			archetype = A
			aspect_name = archetype.name
			required_item_type = archetype.required_item
			calibration_required = archetype.calibration_required
		else if(istype(A, /datum/flesh_trait))
			trait = A
			aspect_name = trait.name
			required_item_type = trait.required_item
			calibration_required = trait.calibration_required
		else if(istype(A, /datum/flesh_quirk))
			quirk = A
			aspect_name = quirk.name
			required_item_type = quirk.required_item
			calibration_required = quirk.calibration_required
		else
			continue

		var/obj/item/temp_item = required_item_type
		var/required_item_name = initial(temp_item.name)

		selection_options["[aspect_name] (Requires: [required_item_name])"] = A

	// Sort alphabetically
	selection_options = sortList(selection_options)
	selection_options["Cancel"] = "CANCEL"

	var/choice = input(user, "Select a [singular_name] to attune", "[category_name] Selection") as null|anything in selection_options
	if(!choice || choice == "Cancel")
		return

	var/datum/selected_aspect = selection_options[choice]
	if(selected_aspect && selected_aspect != "CANCEL")
		attune_to_aspect(user, selected_aspect)

/obj/item/heart_canister/update_icon()
	. = ..()
	cut_overlays()

	if(broken)
		icon_state = "canister_broken"
	if(filled)
		var/mutable_appearance/fluid = mutable_appearance(icon, "canister_fluid")
		fluid.color = current_color
		add_overlay(fluid)
	else
		icon_state = "canister_empty"

/obj/item/heart_canister/attackby(obj/item/I, mob/user)
	if(filled)
		to_chat(user, span_warning("This canister is already filled!"))
		return TRUE

	if(!attuned)
		to_chat(user, span_warning("This canister needs to be attuned to an aspect first! Use in-hand to choose an aspect."))
		return TRUE

	if(!istype(I, required_item_type))
		var/obj/item/temp_item = required_item_type
		var/required_item_name = initial(temp_item.name)
		to_chat(user, span_warning("This canister requires [required_item_name]! You're holding [I.name]."))
		return TRUE

	// Correct item - fill the canister
	if(do_after(user, 3 SECONDS))
		qdel(I)
		filled = TRUE
		current_color = expected_color
		update_icon()
	return TRUE

/obj/item/heart_canister/examine(mob/user)
	. = ..()
	if(broken)
		return
	if(!filled && attuned)
		var/obj/item/temp_item = required_item_type
		var/required_item_name = initial(temp_item.name)
		. += span_notice("It is attuned to [current_aspect_name] and requires [required_item_name] to fill.")
	else if(!attuned)
		. += span_notice("Use in-hand to attune this canister to an aspect.")
	else if (filled)
		. += span_notice("It is attuned to [current_aspect_name]")

/obj/item/heart_canister/proc/attune_to_aspect(mob/user, datum/A)
	var/datum/flesh_archetype/archetype
	var/datum/flesh_trait/trait
	var/datum/flesh_quirk/quirk

	var/aspect_name
	var/aspect_color

	if(istype(A, /datum/flesh_archetype))
		archetype = A
		aspect_name = archetype.name
		aspect_color = archetype.color
		required_item_type = archetype.required_item
	else if(istype(A, /datum/flesh_trait))
		trait = A
		aspect_name = trait.name
		aspect_color = trait.color
		required_item_type = trait.required_item
	else if(istype(A, /datum/flesh_quirk))
		quirk = A
		aspect_name = quirk.name
		aspect_color = quirk.color
		required_item_type = quirk.required_item
	else
		return

	current_aspect_name = aspect_name
	current_aspect_type = A.type
	expected_color = aspect_color
	aspect_datum_ref = A
	required_item_type = required_item_type
	attuned = TRUE

	var/obj/item/temp_item = required_item_type
	var/required_item_name = initial(temp_item.name)

	if(istype(A, /datum/flesh_archetype))
		name = "[aspect_name] personality canister"
	else if(istype(A, /datum/flesh_trait))
		name = "[aspect_name] trait canister"
	else if(istype(A, /datum/flesh_quirk))
		name = "[aspect_name] quirk canister"

	update_icon()
	to_chat(usr, span_notice("You attune the canister to [aspect_name]. It now requires [required_item_name] to fill."))

/obj/item/heart_canister/proc/advance_calibration()
	if(calibrated || broken || !filled)
		return FALSE

	calibration_progress++
	if(calibration_progress >= calibration_required)
		if(check_aspect_match())
			calibrated = TRUE
			return TRUE
		else
			break_canister()
			return FALSE
	update_icon()
	return FALSE

/obj/item/heart_canister/proc/check_aspect_match()
	if(!parent_rack)
		return FALSE

	var/datum/A = aspect_datum_ref
	var/obj/structure/roguemachine/chimeric_heart_beast/heart = parent_rack.heart_component.heart_beast

	if(istype(A, /datum/flesh_archetype))
		return heart.archetype && A.type == heart.archetype.type
	else if(istype(A, /datum/flesh_trait))
		for(var/datum/flesh_trait/trait in heart.traits)
			if(A.type == trait.type)
				return TRUE
		return FALSE
	else if (istype(A, /datum/flesh_quirk))
		for(var/datum/flesh_quirk/quirk in heart.quirks)
			if(A.type == quirk.type)
				return TRUE
		return FALSE
	return FALSE

/obj/item/heart_canister/proc/break_canister()
	broken = TRUE
	calibrated = FALSE
	filled = FALSE
	name = "Broken canister"
	desc = "It's irreversibly damaged."
	icon_state = "canister_broken"
	playsound(src, 'sound/foley/glassbreak.ogg', 75, TRUE)
	update_icon()

/obj/item/heart_blood_canister
	name = "Heartblood canister"
	desc = "An empty canister yearning to be filled with chimeric heartbeast blood."
	icon = 'icons/obj/structures/heart_items.dmi'
	icon_state = "blood_canister_empty"
	w_class = WEIGHT_CLASS_TINY

/obj/item/heart_blood_canister/filled
	name = "Full heartblood canister"
	desc = "A canister full of viscous blood, despite being closed it somehow still exudes a putrid smell. Highly valued, due to their ability to purify lux."
	icon_state = "blood_canister_filled"

/obj/item/heart_blood_vial
	name = "Heartblood vial"
	desc = "An empty vial yearning to be filled with chimeric heartbeast blood."
	icon = 'icons/obj/structures/heart_items.dmi'
	icon_state = "blood_vial_empty"
	w_class = WEIGHT_CLASS_TINY

/obj/item/heart_blood_vial/filled
	name = "Full heartblood vial"
	desc = "A vial full of viscous blood, despite being closed it somehow still exudes a putrid smell. Highly valued, due to their ability to purify lux."
	icon_state = "blood_vial_filled"
