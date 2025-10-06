/datum/quest/outlaw
	quest_type = QUEST_OUTLAW

/datum/quest/outlaw/get_title()
	if(title)
		return title
	return "Defeat [pick("the terrible", "the dreadful", "the monstrous", "the infamous")] [pick("warlord", "beast", "sorcerer", "abomination")]"

/datum/quest/outlaw/get_objective_text()
	return "Slay [initial(target_mob_type.name)]."

/datum/quest/outlaw/generate(obj/effect/landmark/quest_spawner/landmark)
	if(!landmark)
		return FALSE

	// Select miniboss type from landmark's list
	target_mob_type = pick(landmark.miniboss_mobs)
	progress_required = 1 // Outlaw is always a single strong target
	target_amount = 1 // Legacy compatibility
	target_spawn_area = get_area_name(get_turf(landmark))

	// Generate title if not set
	if(!title)
		title = get_title()

	// Spawn miniboss
	var/turf/spawn_turf = landmark.get_safe_spawn_turf()
	if(!spawn_turf)
		return FALSE

	var/mob/living/new_mob = new target_mob_type(spawn_turf)
	new_mob.faction |= "quest"
	new_mob.AddComponent(/datum/component/quest_object/kill, src)
	new_mob.maxHealth *= 2
	new_mob.health = new_mob.maxHealth
	add_tracked_atom(new_mob)
	landmark.add_quest_faction_to_nearby_mobs(spawn_turf)

	return TRUE
