/datum/quest/kill
	quest_type = QUEST_KILL

/datum/quest/kill/get_title()
	if(title)
		return title
	return "Slay [pick("a dangerous", "a fearsome", "a troublesome", "an elusive")] [pick("beast", "monster", "brigand", "creature")]"

/datum/quest/kill/get_objective_text()
	return "Slay [progress_required] [initial(target_mob_type.name)]."

/datum/quest/kill/generate(obj/effect/landmark/quest_spawner/landmark)
	if(!landmark)
		return FALSE

	// Select random mob type from landmark's list
	target_mob_type = pick(landmark.kill_mobs)
	progress_required = rand(1, 3)
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
