//Move to turfs file after codebase debloat


/turf/open/lava/can_traverse_safely(atom/movable/traveler)
	return FALSE

/turf/open/transparent/openspace/can_traverse_safely(atom/movable/traveler)
	return FALSE

/turf/proc/can_traverse_safely(atom/movable/traveler)
	return TRUE
