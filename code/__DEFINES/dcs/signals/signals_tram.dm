/// Sent from /obj/structure/industrial_lift/tram when its travelling status updates. (travelling)
#define COMSIG_TRAM_SET_TRAVELLING "tram_set_travelling"

/// Sent from /obj/structure/industrial_lift/tram when it begins to travel. (obj/effect/landmark/tram/idle_platform, obj/effect/landmark/tram/to_where)
#define COMSIG_TRAM_TRAVEL "tram_travel"

/// Sent from /obj/structure/industrial_lift/tram when it hits someone: ()
#define COMSIG_TRAM_COLLISION "tram_collided"

///called when an industrial lift enters this turf
#define COMSIG_TURF_INDUSTRIAL_LIFT_ENTER "turf_industrial_life_enter"
/// Sent from /datum/lift_master when a normal lift starts or stops going up or down. (direction if started or 0 if stopped)
#define COMSIG_LIFT_SET_DIRECTION "lift_set_direction"

#define COMSIG_TRAM_REACHED_PLATFORM "tram_reach_platform"

#define COMSIG_TRAM_EMPTY "tram_empty"

#define COMSIG_DISPATCH_CARGO "dispatch_cargo_boat"
