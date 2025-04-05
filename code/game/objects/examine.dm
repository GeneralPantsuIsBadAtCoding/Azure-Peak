/datum/examine_effect/proc/trigger(mob/user)
	return

/datum/examine_effect/proc/get_examine_line(mob/user)
	return

/obj/item/examine(mob/user) //This might be spammy. Remove?
	. = ..()

	. += integrity_check()

	var/real_value = get_real_price()
	if(real_value > 0)
		if(HAS_TRAIT(user, TRAIT_SEEPRICES) || simpleton_price)
			. += span_info("Value: [real_value] mammon")
		else if(HAS_TRAIT(user, TRAIT_SEEPRICES_SHITTY))
			//you can get up to 50% of the value if you have shitty see prices
			var/static/fumbling_seed = text2num(GLOB.rogue_round_id)
			var/fumbled_value = max(1, round(real_value + (real_value * clamp(noise_hash(real_value, fumbling_seed) - 0.25, -0.25, 0.25)), 1))
			. += span_info("Value: [fumbled_value] mammon... <i>I think</i>")

	for(var/datum/examine_effect/E in examine_effects)
		E.trigger(user)

/obj/item/proc/integrity_check()
	if(!max_integrity)
		return
	if(obj_integrity == max_integrity)
		return

	var/int_percent = round(((obj_integrity / max_integrity) * 100), 1)
	var/result

	if(obj_broken)
		return span_warning("It's broken.")
	switch(int_percent)
		if(1 to 20)
			result = span_warning("It's nearly broken.")
		if(10 to 30)
			result = span_warning("It's severely damaged.")
		if(30 to 80)
			result = span_warning("It's damaged.")
		if(80 to 99)
			result = span_warning("It's a little damaged.")
	return result
