/datum/quest/retrieval
	quest_type = QUEST_RETRIEVAL

/datum/quest/retrieval/get_title()
	if(title)
		return title
	return "Retrieve [pick("an ancient", "a rare", "a stolen", "a magical")] [pick("artifact", "relic", "doohickey", "treasure")]"

/datum/quest/retrieval/get_objective_text()
	return "Retrieve [progress_required] [initial(target_item_type.name)]."

/datum/quest/retrieval/generate(obj/effect/landmark/quest_spawner/landmark)
	if(!landmark)
		return FALSE

	// Select random item type from landmark's list
	target_item_type = pick(landmark.fetch_items)
	progress_required = rand(1, 3)
	target_amount = progress_required // Legacy compatibility
	target_spawn_area = get_area_name(get_turf(landmark))

	// Generate title if not set
	if(!title)
		title = get_title()

	// Spawn items
	for(var/i in 1 to progress_required)
		var/turf/spawn_turf = landmark.get_safe_spawn_turf()
		if(!spawn_turf)
			continue

		var/obj/item/new_item = new target_item_type(spawn_turf)
		new_item.AddComponent(/datum/component/quest_object/retrieval, src)
		add_tracked_atom(new_item)

	return TRUE
