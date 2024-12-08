/**
 * Generic Hunger Subtree,
 *
 * Requires at least a living mob that can hold items.
 *
 * relevant blackboards:
 * * BB_NEXT_HUNGRY - set by this subtree, is when the controller is next hungry
 */
/datum/ai_planning_subtree/generic_hunger/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/next_eat = controller.blackboard[BB_NEXT_HUNGRY]
	if(!next_eat)
		//inits the blackboard timer
		next_eat = world.time + rand(0, 30 SECONDS)
		controller.set_blackboard_key(BB_NEXT_HUNGRY, next_eat)

	if(world.time < next_eat)
		return

	if(!controller.blackboard[BB_FOOD_TARGET])
		controller.queue_behavior(/datum/ai_behavior/find_and_set/edible, BB_FOOD_TARGET, /obj/item, 2)
		return

	controller.queue_behavior(/datum/ai_behavior/consume, BB_FOOD_TARGET, BB_NEXT_HUNGRY)
	return SUBTREE_RETURN_FINISH_PLANNING
