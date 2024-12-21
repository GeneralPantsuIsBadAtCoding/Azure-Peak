/datum/ai_controller/troll
	movement_delay = 0.5 SECONDS

	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/allow_items()

	)

	planning_subtrees = list(

		/datum/ai_planning_subtree/simple_find_target/troll,
		/datum/ai_planning_subtree/basic_melee_attack_subtree, //may be doubling up on subtrees. todo: check perf crix
		/datum/ai_planning_subtree/basic_melee_attack_subtree/opportunistic,

		/datum/ai_planning_subtree/simple_self_recovery, //Can change this up if eating starts to heal

		/datum/ai_planning_subtree/find_dead_bodies,
		/datum/ai_planning_subtree/find_food,
		/datum/ai_planning_subtree/find_dead_bodies,
		/datum/ai_planning_subtree/eat_dead_body,
	
	)

	idle_behavior = /datum/idle_behavior/nothing
