/datum/ai_controller/mudcrab
	movement_delay = 4 SECONDS

	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic()

	)

	planning_subtrees = list(

		//datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/target_retaliate,
	)

	idle_behavior = /datum/idle_behavior/idle_crab_walk
