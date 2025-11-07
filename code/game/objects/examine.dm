/datum/examine_effect/proc/trigger(mob/user)
	return

/datum/examine_effect/proc/get_examine_line(mob/user)
	return

/obj/item/examine(mob/user) //This might be spammy. Remove?
	. = ..()

	. += integrity_check()

	if(HAS_TRAIT(user, TRAIT_SEEPRICES) || simpleton_price)
		var/appraised_value = appraise_price()
		if(appraised_value > 0)
			. += span_info("Value: [appraised_value] mammon")
	else if(HAS_TRAIT(user, TRAIT_SEEPRICES_SHITTY))
		var/real_value = appraise_price()
		if(real_value > 0)
			//you can get up to 50% of the value if you have shitty see prices
			var/static/fumbling_seed = text2num(GLOB.rogue_round_id)
			var/fumbled_value = max(1, round(real_value + (real_value * clamp(noise_hash(real_value, fumbling_seed) - 0.25, -0.25, 0.25)), 1))
			. += span_info("Value: [fumbled_value] mammon... <i>I think</i>")

	if(smeltresult)
		var/obj/item/smelted = smeltresult
		. += span_info("Smelts into [smelted.name].")
	for(var/datum/examine_effect/E in examine_effects)
		E.trigger(user)

/obj/item/proc/integrity_check(elaborate = FALSE)
	if(!max_integrity)
		return
	if(obj_integrity == max_integrity)
		return

	var/int_percent = round(((obj_integrity / max_integrity) * 100), 1)
	var/result

	if(obj_broken)
		return span_warning("It's broken.")
	if(elaborate)
		switch(int_percent)
			if(1 to 15)
				result = span_warning("It's nearly broken.")
			if(16 to 30)
				result = span_warning("It's severely damaged.")
			if(31 to 80)
				result = span_warning("It's damaged.")
			if(80 to 99)
				result = span_warning("It's a little damaged.")
	return result

/obj/item/clothing/integrity_check(elaborate = FALSE)
	if(islist(body_parts_covered))
		return integrity_check_limb_integ(elaborate)

	if(obj_broken)
		return span_warning("It's broken.")

	var/eff_maxint = max_integrity - (max_integrity * integrity_failure)
	var/eff_currint = max(obj_integrity - (max_integrity * integrity_failure), 0)
	var/ratio =	(eff_currint / eff_maxint)
	var/percent = round((ratio * 100), 1)
	var/result
	if(percent < 100)
		if(elaborate)
			return span_warning("([percent]%)")
		else
			switch(percent)
				if(1 to 15)
					result = span_warning("It's nearly broken.")
				if(16 to 30)
					result = span_warning("It's severely damaged.")
				if(31 to 80)
					result = span_warning("It's damaged.")
				if(80 to 99)
					result = span_warning("It's a little damaged.")
	return result
	

/obj/item/clothing/proc/integrity_check_limb_integ(elaborate = FALSE)
	var/str_damaged_limbs
	for(var/flag in body_parts_covered_dynamic)
		if(elaborate)
			for(var/orgflag in body_parts_covered)
				if(orgflag & flag)
					if(body_parts_covered_dynamic[flag] < body_parts_covered[orgflag])
						str_damaged_limbs += "[integ_to_printout(elaborate, flag, body_parts_covered_dynamic[flag], body_parts_covered[orgflag])] "
						break
		else
			if(body_parts_covered_dynamic[flag] <= 0)
				str_damaged_limbs += "[integ_to_printout(elaborate, flag, body_parts_covered_dynamic[flag])] "
	return str_damaged_limbs

/obj/item/clothing/proc/integ_to_printout(elaborate = FALSE, flag, curr_integ, max_integ = 1)
	var/ratio = curr_integ / max_integ
	var/list/readable_zone = body_parts_covered2organ_names(flag, precise = TRUE)
	if(curr_integ <= 0)
		return "[span_warning("[readable_zone[1]]⨂")]"

	if(elaborate)
		var/str = readable_zone[1]
		switch(ratio)
			if(0.1 to 0.24)
				str += "◔"
			if(0.25 to 0.50)
				str += "◑"
			if(0.51 to 0.74)
				str += "◕"
			if(0.75 to 0.99)
				str += "◉"
		return span_warning(str)
	return
