/datum/quest/kill/outlaw
	quest_type = QUEST_OUTLAW
	mob_types_to_spawn = list(
		/mob/living/carbon/human/species/human/northern/deranged_knight
	)
	count_min = 1
	count_max = 1

/datum/quest/kill/outlaw/get_title()
	if(title)
		return title
	return "Defeat [pick("the terrible", "the dreadful", "the monstrous", "the infamous")] [pick("warlord", "beast", "sorcerer", "abomination")]"

/datum/quest/kill/outlaw/get_objective_text()
	return "Slay [initial(target_mob_type.name)]."

/datum/quest/kill/outlaw/generate(obj/effect/landmark/quest_spawner/landmark)
	..()
	if(!landmark)
		return FALSE
	spawn_kill_mobs(landmark)

	return TRUE
