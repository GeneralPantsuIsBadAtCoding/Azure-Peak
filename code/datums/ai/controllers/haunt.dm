//not sure if there's anything special that haunts do. just reg mobprog for now. maybe eat limbs later
/datum/ai_controller/haunt
	movement_delay = 1 SECONDS

	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic()
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		//datum/ai_planning_subtree/find_dead_bodies,
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk
