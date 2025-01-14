/datum/ai_controller/troll
	movement_delay = TROLL_MOVEMENT_SPEED

	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/allow_items()

	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target/closest,

		/datum/ai_planning_subtree/basic_melee_attack_subtree/opportunistic, 
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		
		/datum/ai_planning_subtree/simple_self_recovery,

		/datum/ai_planning_subtree/find_dead_bodies,
		/datum/ai_planning_subtree/eat_dead_body,
		/datum/ai_planning_subtree/find_food,
		/datum/ai_planning_subtree/eat_food,
	
	)

	idle_behavior = /datum/idle_behavior/nothing

