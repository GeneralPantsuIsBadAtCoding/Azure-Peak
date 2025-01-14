/datum/ai_controller/simple_skeleton
	movement_delay = SKELETON_MOVEMENT_SPEED

	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic()
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target/closest,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk


/datum/ai_controller/skeleton_spear
	movement_delay = SKELETON_MOVEMENT_SPEED

	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic()
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target/closest,
		/datum/ai_planning_subtree/spacing/spear,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/spear,
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk

/datum/ai_controller/skeleton_ranged
	movement_delay = SKELETON_MOVEMENT_SPEED * 1.2 //ranged malus

	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic()
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target/closest,
		/datum/ai_planning_subtree/spacing/ranged,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree,
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk
