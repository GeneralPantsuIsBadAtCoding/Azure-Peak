/datum/skill
	abstract_type = /datum/skill
	var/name = "Skill"
	var/desc = ""

	var/dream_cost_base = 2
	var/dream_cost_per_level = 0.5
	var/dream_legendary_extra_cost = 1
	var/list/specific_dream_costs
	var/list/dreams
	var/randomable_dream_xp = TRUE
	var/expert_name

/datum/skill/proc/get_skill_speed_modifier(level)
	return

/datum/skill/proc/get_dream_cost_for_level(level, mob/living/user)
	if(length(specific_dream_costs) >= level)
		return specific_dream_costs[level]
	var/cost = FLOOR(dream_cost_base + (dream_cost_per_level * (level - 1)), 1)
	if(level == SKILL_LEVEL_LEGENDARY)
		cost += dream_legendary_extra_cost
	
	// Malum worshippers (with TRAIT_FORGEBLESSED) spend fewer dream points on craft skills
	if(user && HAS_TRAIT(user, TRAIT_FORGEBLESSED) && (istype(src, /datum/skill/craft) || (istype(src, /datum/skill/misc/sewing))))
		cost = max(1, FLOOR(cost * 0.5, 1)) // 50% reduction, minimum cost of 1
	else if(user && HAS_TRAIT(user, TRAIT_JACKOFALLTRADES))
		cost = max(1, FLOOR(cost * 0.5, 1)) // Ditto for Homesteader towners
	return cost

/datum/skill/proc/skill_level_effect(level, datum/mind/mind)
	return

/datum/skill/proc/get_random_dream()
	if(!dreams)
		return null
	return pick(dreams)

/datum/skill/Topic(href, href_list)
	. = ..()

	if(href_list["skill_detail"])
		to_chat(usr, desc)
