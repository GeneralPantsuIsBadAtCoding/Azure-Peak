/datum/component/chimeric_heart_beast/proc/create_discharge_projectile(turf/target_turf)
	var/obj/projectile/discharge/projectile = new(get_turf(heart_beast))

	// Set up the projectile using the proper method
	projectile.color = heart_beast.discharge_color
	projectile.preparePixelProjectile(target_turf, heart_beast)

	// Fire the projectile at the target
	projectile.fire()

/obj/projectile/discharge
	name = "discharge"
	icon = 'icons/effects/tomatodecal.dmi'
	icon_state = "smashed_plant"
	nodamage = TRUE
	speed = 10 // Slow speed
	range = 15 // Maximum range
	hitsound = null
	hitsound_wall = null
	var/has_splatted = FALSE

/obj/projectile/discharge/on_hit(atom/target, blocked = FALSE)
	if(has_splatted)
		return BULLET_ACT_HIT

	var/turf/hit_turf = get_turf(target)

	// If we hit a non-dense turf, create mess there
	if(hit_turf && !hit_turf.density)
		create_discharge_mess(hit_turf)
		has_splatted = TRUE
		return BULLET_ACT_HIT

	// If we hit a dense turf, find a nearby non-dense turf to splatter on
	if(isturf(target) && target.density)
		var/list/possible_turfs = list()
		for(var/turf/nearby_turf in RANGE_TURFS(1, hit_turf))
			if(!nearby_turf.density)
				possible_turfs += nearby_turf

		if(possible_turfs.len)
			var/turf/splatter_turf = pick(possible_turfs)
			create_discharge_mess(splatter_turf)
			has_splatted = TRUE
		return BULLET_ACT_HIT

	// For non-turf dense objects, try to splatter on their turf or nearby
	if(!isturf(target) && target.density)
		if(hit_turf && !hit_turf.density)
			create_discharge_mess(hit_turf)
			has_splatted = TRUE
		else
			// Find nearby non-dense turf
			var/list/possible_turfs = list()
			for(var/turf/nearby_turf in RANGE_TURFS(1, hit_turf))
				if(!nearby_turf.density)
					possible_turfs += nearby_turf

			if(possible_turfs.len)
				var/turf/splatter_turf = pick(possible_turfs)
				create_discharge_mess(splatter_turf)
				has_splatted = TRUE

	return BULLET_ACT_HIT

/obj/projectile/discharge/on_range()
	// Create mess when projectile reaches max range
	var/turf/end_turf = get_turf(src)
	if(end_turf && !end_turf.density && !has_splatted)
		create_discharge_mess(end_turf)
		has_splatted = TRUE
	..()

/obj/projectile/discharge/proc/create_discharge_mess(turf/target_turf)
	new /obj/effect/decal/cleanable/discharge(target_turf, color)

/obj/effect/decal/cleanable/discharge/Initialize(mapload, discharge_color, discharge_name)
	. = ..()
	if(discharge_color)
		color = discharge_color

/obj/effect/decal/cleanable/discharge
	name = "discharge"
	desc = "What? Ewww!"
	icon = 'icons/effects/tomatodecal.dmi'
	icon_state = "smashed_plant"
