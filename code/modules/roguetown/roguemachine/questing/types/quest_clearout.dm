/datum/quest/clearout
	quest_type = QUEST_CLEAR_OUT

/datum/quest/clearout/get_title()
	if(title)
		return title
	return "Clear out [pick("a nest of", "a den of", "a group of", "a pack of")] [pick("monsters", "bandits", "creatures", "vermin")]"

/datum/quest/clearout/get_objective_text()
	return "Eliminate [progress_required] [initial(target_mob_type.name)]."

/datum/quest/clearout/get_location_text()
	return target_spawn_area ? "Reported infestation in [target_spawn_area] region." : "Reported infestations in Azuria region."

/datum/quest/clearout/generate(obj/effect/landmark/quest_spawner/landmark)
	if(!landmark)
		return FALSE

	// Select random mob type from landmark's list
	target_mob_type = pick(landmark.kill_mobs)
	progress_required = rand(3, 6) // Clearout has more targets
	target_amount = progress_required // Legacy compatibility
	target_spawn_area = get_area_name(get_turf(landmark))

	// Generate title if not set
	if(!title)
		title = get_title()

	// Spawn mobs
	for(var/i in 1 to progress_required)
		var/turf/spawn_turf = landmark.get_safe_spawn_turf()
		if(!spawn_turf)
			continue

		var/mob/living/new_mob = new target_mob_type(spawn_turf)
		new_mob.faction |= "quest"
		new_mob.AddComponent(/datum/component/quest_object/kill, src)
		add_tracked_atom(new_mob)
		landmark.add_quest_faction_to_nearby_mobs(spawn_turf)
		sleep(1)

	return TRUE
