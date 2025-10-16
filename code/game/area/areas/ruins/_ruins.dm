//Parent types

/area/ruin
	name = "\improper Unexplored Location"
	icon_state = "away"
	hidden = TRUE
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	ambientsounds = RUINS
	blob_allowed = FALSE
	flags_1 = CAN_BE_DIRTY_1


/area/ruin/unpowered
	always_unpowered = FALSE

/area/ruin/powered
	requires_power = FALSE
