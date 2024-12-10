/datum/ai_planning_subtree/eat_food
	var/datum/ai_behavior/eat_food/behavior = /datum/ai_behavior/eat_food

/datum/ai_planning_subtree/eat_food/SelectBehaviors(datum/ai_controller/controller, delta_time)
	. = ..()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_FOOD_TARGET]
	if(QDELETED(target))
		return
	var/mob/living/pawn = controller.pawn
	if(pawn.doing)
		return
	controller.queue_behavior(behavior, BB_BASIC_MOB_FOOD_TARGET)
	return SUBTREE_RETURN_FINISH_PLANNING //we are going into (eating) battle...no distractions.


/datum/ai_planning_subtree/eat_food/farm_animals
	behavior = /datum/ai_behavior/eat_food_from_ground
