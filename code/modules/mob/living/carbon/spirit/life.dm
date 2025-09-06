

/mob/living/carbon/spirit


/mob/living/carbon/spirit/Life()
	set invisibility = 0

	if (notransform)
		return

/mob/living/carbon/spirit/handle_environment()
//ATMO/TURF/TEMPERATURE
	var/turf/cur_turf = get_turf(src)
	var/loc_temp = cur_turf.temperature

	if(stat != DEAD)
		adjust_bodytemperature(natural_bodytemperature_stabilization())

	if(!on_fire) //If you're on fire, you do not heat up or cool down based on surrounding gases
		if(loc_temp < bodytemperature)
			adjust_bodytemperature(max((loc_temp - bodytemperature) / BODYTEMP_COLD_DIVISOR, BODYTEMP_COOLING_MAX))
		else
			adjust_bodytemperature(min((loc_temp - bodytemperature) / BODYTEMP_HEAT_DIVISOR, BODYTEMP_HEATING_MAX))


	if(bodytemperature > BODYTEMP_HEAT_DAMAGE_LIMIT && !HAS_TRAIT(src, TRAIT_RESISTHEAT))
		switch(bodytemperature)
			if(360 to 400)
				throw_alert("temp", /atom/movable/screen/alert/hot, 1)
				apply_damage(HEAT_DAMAGE_LEVEL_1, BURN)
			if(400 to 460)
				throw_alert("temp", /atom/movable/screen/alert/hot, 2)
				apply_damage(HEAT_DAMAGE_LEVEL_2, BURN)
			if(460 to INFINITY)
				throw_alert("temp", /atom/movable/screen/alert/hot, 3)
				if(on_fire)
					apply_damage(HEAT_DAMAGE_LEVEL_3, BURN)
				else
					apply_damage(HEAT_DAMAGE_LEVEL_2, BURN)

	else if(bodytemperature < BODYTEMP_COLD_DAMAGE_LIMIT && !HAS_TRAIT(src, TRAIT_RESISTCOLD))
		switch(bodytemperature)
			if(200 to 260)
				throw_alert("temp", /atom/movable/screen/alert/cold, 1)
				apply_damage(COLD_DAMAGE_LEVEL_1, BURN)
			if(120 to 200)
				throw_alert("temp", /atom/movable/screen/alert/cold, 2)
				apply_damage(COLD_DAMAGE_LEVEL_2, BURN)
			if(-INFINITY to 120)
				throw_alert("temp", /atom/movable/screen/alert/cold, 3)
				apply_damage(COLD_DAMAGE_LEVEL_3, BURN)

	else
		clear_alert("temp")

	return

/mob/living/carbon/spirit/handle_random_events()
	..()
	if (prob(1) && prob(2))
		emote("scratch")

/mob/living/carbon/spirit/has_smoke_protection()
	if(wear_mask)
		if(wear_mask.clothing_flags & BLOCK_GAS_SMOKE_EFFECT)
			return 1
