#define BASE_GRIND_TIME 1 SECONDS
/obj/item/millstone // Previous structure path means it cannot be crafted on tables
	name = "millstone"
	desc = "A millstone used to grind grain into flour."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "millstone"
	density = FALSE
	anchored = FALSE
	blade_dulling = DULLING_BASH
	max_integrity = 400
	var/list/obj/item/to_grind = list()

/obj/item/millstone/attackby(obj/item/W, mob/living/user, params)
	var/datum/skill/craft/cooking/cs = user?.get_skill_level(/datum/skill/craft/cooking)
	var/scaled_grind_time = BASE_GRIND_TIME / get_cooktime_divisor(cs)
	if(W.mill_result)
		if(do_after(user, scaled_grind_time, target = src))
			new W.mill_result(get_turf(loc))
			qdel(W)
	..()

#undef BASE_GRIND_TIME
