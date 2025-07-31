#define GET_AI_BEHAVIOR(behavior_type) SSai_behaviors.ai_behaviors[behavior_type]
#define HAS_AI_CONTROLLER_TYPE(thing, type) istype(thing?.ai_controller, type)
#define AI_STATUS_ON		1
#define AI_STATUS_OFF		2
#define AI_STATUS_IDLE		3

///Carbon checks
#define SHOULD_RESIST(source) (source.on_fire || source.buckled || HAS_TRAIT(source, TRAIT_RESTRAINED) || (source.pulledby && source.pulledby.grab_state > GRAB_PASSIVE))
#define IS_DEAD_OR_INCAP(source) (source.incapacitated() || source.stat)

///Max pathing attempts before auto-fail
#define MAX_PATHING_ATTEMPTS 30
///Flags for ai_behavior new()
#define AI_CONTROLLER_INCOMPATIBLE (1<<0)

///Does this task require movement from the AI before it can be performed?
#define AI_BEHAVIOR_REQUIRE_MOVEMENT (1<<0)
///Does this require the current_movement_target to be adjacent and in reach?
#define AI_BEHAVIOR_REQUIRE_REACH (1<<1)
///Does this task let you perform the action while you move closer? (Things like moving and shooting)
#define AI_BEHAVIOR_MOVE_AND_PERFORM (1<<2)
///Does finishing this task not null the current movement target?
#define AI_BEHAVIOR_KEEP_MOVE_TARGET_ON_FINISH (1<<3)
///Does finishing this task make the AI stop moving towards the target?
#define AI_BEHAVIOR_KEEP_MOVING_TOWARDS_TARGET_ON_FINISH (1<<4)
///Does this behavior NOT block planning?
#define AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION (1<<5)

///Cooldown on planning if planning failed last time
#define AI_FAILED_PLANNING_COOLDOWN 1.5 SECONDS

///Subtree defines
///This subtree should cancel any further planning, (Including from other subtrees)
#define SUBTREE_RETURN_FINISH_PLANNING 1

///AI flags
#define STOP_MOVING_WHEN_PULLED (1<<0)

//Blackboard

//Generic BB keys
#define BB_CURRENT_MIN_MOVE_DISTANCE "min_move_distance"

/// Signal sent when a blackboard key is set to a new value
#define COMSIG_AI_BLACKBOARD_KEY_SET(blackboard_key) "ai_blackboard_key_set_[blackboard_key]"

///Targetting keys for something to run away from, if you need to store this separately from current target
#define BB_BASIC_MOB_FLEE_TARGET "BB_basic_flee_target"
#define BB_BASIC_MOB_FLEE_TARGET_HIDING_LOCATION "BB_basic_flee_target_hiding_location"
#define BB_FLEE_TARGETTING_DATUM "flee_targetting_datum"

#define BB_FUTURE_MOVEMENT_PATH "BB_future_path"

///time until we should next eat, set by the generic hunger subtree
#define BB_NEXT_HUNGRY "BB_NEXT_HUNGRY"
///what we're going to eat next
#define BB_BASIC_MOB_FOOD_TARGET "BB_basic_food_target"
///what corpse we'll next try to eat
#define BB_BASIC_MOB_CORPSE_TARGET "BB_basic_mob_corpse_target"
///What creature we want to cocoon
#define BB_BASIC_MOB_COCOON_TARGET "BB_basic_mob_cocoon_target"
///Who we want dead above all else...
#define BB_MAIN_TARGET "BB_main_target"
///How many times we'll attack defendants before getting disinterested
#define BB_RETALIATE_ATTACKS_LEFT "BB_relatiate_attacks_left"
#define BB_RETALIATE_COOLDOWN "BB_retaliate_cooldown"

#define BB_BASIC_MOB_TAMED "BB_basic_mob_tamed"

#define BB_WANDER_POINT "BB_wander_point"

//farm animals ai
#define BB_CHICKEN_LAY_EGG "BB_chicken_lay_egg"
#define BB_CHICKEN_NESTING_BOX "BB_chicken_nest_box"
#define BB_COW_TIP_REACTING "BB_cow_tip_reacting"
#define	BB_COW_TIPPER "BB_cow_tipper"

//Move then recheck ai
#define MOVEMENT_LOOP_START_FAST (1<<0)
