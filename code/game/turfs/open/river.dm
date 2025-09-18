#define RANDOM_UPPER_X 200
#define RANDOM_UPPER_Y 200

#define RANDOM_LOWER_X 50
#define RANDOM_LOWER_Y 50

/turf/proc/Spread(probability = 30, prob_loss = 25, whitelisted_area)
	if(probability <= 0)
		return
	var/list/cardinal_turfs = list()
	var/list/diagonal_turfs = list()
	var/logged_turf_type
	for(var/F in RANGE_TURFS(1, src) - src)
		var/turf/T = F
		var/area/new_area = get_area(T)
		if(!T || (T.density && !ismineralturf(T)) || (whitelisted_area && !istype(new_area, whitelisted_area)) || (T.flags_1 & NO_LAVA_GEN_1) )
			continue

		if(!logged_turf_type && ismineralturf(T))
			var/turf/closed/mineral/M = T
			logged_turf_type = M.turf_type

		if(get_dir(src, F) in GLOB.cardinals)
			cardinal_turfs += F
		else
			diagonal_turfs += F

	for(var/F in cardinal_turfs) //cardinal turfs are always changed but don't always spread
		var/turf/T = F
		if(!istype(T, logged_turf_type) && T.ChangeTurf(type, baseturfs, CHANGETURF_IGNORE_AIR) && prob(probability))
			T.Spread(probability - prob_loss, prob_loss, whitelisted_area)

	for(var/F in diagonal_turfs) //diagonal turfs only sometimes change, but will always spread if changed
		var/turf/T = F
		if(!istype(T, logged_turf_type) && prob(probability) && T.ChangeTurf(type, baseturfs, CHANGETURF_IGNORE_AIR))
			T.Spread(probability - prob_loss, prob_loss, whitelisted_area)
		else if(ismineralturf(T))
			var/turf/closed/mineral/M = T
			M.ChangeTurf(M.turf_type, M.baseturfs, CHANGETURF_IGNORE_AIR)



#undef RANDOM_UPPER_X
#undef RANDOM_UPPER_Y

#undef RANDOM_LOWER_X
#undef RANDOM_LOWER_Y
