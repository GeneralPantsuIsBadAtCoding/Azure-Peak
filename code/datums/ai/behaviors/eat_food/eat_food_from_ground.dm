/datum/ai_behavior/eat_food_from_ground
	action_cooldown = 1.5 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH

/datum/ai_behavior/eat_food_from_ground/setup(datum/ai_controller/controller, target_key)
	. = ..()
	//Hiding location is priority
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	set_movement_target(controller, (target))

/datum/ai_behavior/eat_food_from_ground/perform(seconds_per_tick, datum/ai_controller/controller, target_key, hunger_timer_key)
	. = ..()
	var/mob/living/living_pawn = controller.pawn
	var/obj/item/target = controller.blackboard[target_key]
	
	if(QDELETED(target))
		return

	living_pawn.face_atom(target)

	if(istype(living_pawn, /mob/living/simple_animal)) //they're probably a farm animal
		var/mob/living/simple_animal/hostile/retaliate/rogue/mob = controller.pawn
		if(mob.food == mob.food_max && !mob.eat_forever) /*very hacky way of eating. to be refactored crix*/
			return
		living_pawn.visible_message(span_danger("[living_pawn] munches on [target]!"))
		playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
		qdel(target)
		mob.food = max(mob.food + 30, 100)

	finish_action(controller, TRUE)


/datum/ai_behavior/eat_food_from_ground/finish_action(datum/ai_controller/controller, succeeded, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	if(!succeeded)
		controller.clear_blackboard_key(target_key)


