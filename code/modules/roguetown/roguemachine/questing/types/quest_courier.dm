/datum/quest/courier
	quest_type = QUEST_COURIER

/datum/quest/courier/get_title()
	if(title)
		return title
	return "Deliver [pick("an important", "a sealed", "a confidential", "a valuable")] [pick("package", "parcel", "letter", "delivery")]"

/datum/quest/courier/get_objective_text()
	return "Deliver [initial(target_delivery_item.name)] to [initial(target_delivery_location.name)]."

/datum/quest/courier/get_location_text()
	var/text = ""
	if(target_spawn_area)
		text += "Pickup location: Reported sighting in [target_spawn_area] region.<br>"
	text += "Destination: [initial(target_delivery_location.name)]."
	return text

/datum/quest/courier/generate(obj/effect/landmark/quest_spawner/landmark)
	if(!landmark)
		return FALSE

	// Select delivery location
	target_delivery_location = pick(
		/area/rogue/indoors/town/tavern,
		/area/rogue/indoors/town/church,
		/area/rogue/indoors/town/dwarfin,
		/area/rogue/indoors/town/shop,
		/area/rogue/indoors/town/manor,
		/area/rogue/indoors/town/magician,
	)

	progress_required = 1
	target_amount = 1 // Legacy compatibility
	target_spawn_area = get_area_name(get_turf(landmark))

	// Generate title if not set
	if(!title)
		title = get_title()

	// Spawn courier item using landmark's method
	var/obj/item/parcel/delivery_parcel = landmark.spawn_courier_item(src, target_delivery_location)
	if(!delivery_parcel)
		return FALSE

	return TRUE
