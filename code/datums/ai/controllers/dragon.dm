/*
	Melee dragon can 'leap'
	Caster dragon can emit a fire cone. Technically it also has leap but AI won't use it.
*/
/datum/ai_controller/dragon
	movement_delay = 0.4 SECONDS

	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic()
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk

	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target/closest,
		/datum/ai_planning_subtree/targeted_mob_ability/continue_planning,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/simple_self_recovery/dragon

	)
