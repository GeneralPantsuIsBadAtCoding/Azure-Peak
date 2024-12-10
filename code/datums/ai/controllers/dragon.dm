/datum/ai_controller/dragon
	movement_delay = 0.5 SECONDS

	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic()
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk

	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target/dragon,
		/datum/ai_planning_subtree/targeted_mob_ability,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,

		//datum/ai_planning_subtree/move_to_cardinal,

	)
