/datum/examine_effect/proc/trigger(mob/user)
	return

/datum/examine_effect/proc/get_examine_line(mob/user)
	return

/obj/item/examine(mob/user) //This might be spammy. Remove?
	. = ..()

	. += integrity_check()

//	if(has_inspect_verb || (obj_integrity < max_integrity))
//		. += span_notice("<a href='?src=[REF(src)];inspect=1'>Inspect</a>")

	var/real_value = get_real_price()
	if(real_value > 0)
		if(HAS_TRAIT(user, TRAIT_SEEPRICES) || simpleton_price)
			. += span_info("Value: [real_value] mammon")
		else if(HAS_TRAIT(user, TRAIT_SEEPRICES_SHITTY))
			//you can get up to 50% of the value if you have shitty see prices
			var/static/fumbling_seed = text2num(GLOB.rogue_round_id)
			var/fumbled_value = max(1, round(real_value + (real_value * clamp(noise_hash(real_value, fumbling_seed) - 0.25, -0.25, 0.25)), 1))
			. += span_info("Value: [fumbled_value] mammon... <i>I think</i>")

//	. += "[gender == PLURAL ? "They are" : "It is"] a [weightclass2text(w_class)] item."

/*	if(resistance_flags & INDESTRUCTIBLE)
		. += "[src] seems extremely robust! It'll probably withstand anything that could happen to it!"
	else
		if(resistance_flags & LAVA_PROOF)
			. += "[src] is made of an extremely heat-resistant material, it'd probably be able to withstand lava!"
		if(resistance_flags & (ACID_PROOF | UNACIDABLE))
			. += "[src] looks pretty robust! It'd probably be able to withstand acid!"
		if(resistance_flags & FREEZE_PROOF)
			. += "[src] is made of cold-resistant materials."
		if(resistance_flags & FIRE_PROOF)
			. += "[src] is made of fire-retardant materials."
*/

	for(var/datum/examine_effect/E in examine_effects)
		E.trigger(user)

/obj/item/proc/integrity_check(var/span = TRUE, var/simple = FALSE)
	if(max_integrity)
		if(obj_integrity < max_integrity)
			var/meme = round(((obj_integrity / max_integrity) * 100), 1)
			var/result
			if(simple)
				if(meme <= 1)
					return span_warning("It's broken.")
				else
					return ""
			switch(meme)
				if(0 to 1)
					result = span ? span_warning("It's broken.") : "It's broken."
				if(1 to 10)
					result = span ? span_warning("It's nearly broken.") : "It's nearly broken."
				if(10 to 30)
					result = span ? span_warning("It's severely damaged.") : "It's severely damaged."
				if(30 to 80)
					result = span ? span_warning("It's damaged.") : "It's damaged."
				if(80 to 99)
					result = span ? span_warning("It's a little damaged.") : "It's a little damaged."
			return result
