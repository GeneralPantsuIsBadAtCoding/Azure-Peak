/obj/item
	/// A lazylist to store inhands data.
	var/list/onprop
	var/d_type = "blunt"
//#ifdef TESTSERVER
	var/force_reupdate_inhand = TRUE
	var/smelted = FALSE // Sanity for smelteries to avoid runtimes, if this is a bar smelted through ore for exp gain
	/// Determines whether this item is silver or not.
	var/is_silver = FALSE
	var/last_used = 0
	var/toggle_state = null
	var/icon_x_offset = 0
	var/icon_y_offset = 0
	var/always_destroy = FALSE
	var/is_important = FALSE // If TRUE, this item is not allowed to be minted. May be useful for other things later.
//#else
//	var/force_reupdate_inhand = FALSE
//#endif

// Initalize addon for the var for custom inhands 32x32.
/obj/item/Initialize()
	. = ..()
	if(!experimental_inhand)
		inhand_x_dimension = 32
		inhand_y_dimension = 32

/obj/item/inhand_tester
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "inhand_test"

/obj/item/inhand_tester/big
	icon = 'icons/roguetown/misc/64x64.dmi'

/obj/item/proc/getmoboverlay(tag, prop, behind = FALSE, mirrored = FALSE)
	// REPLACED with caching system - icons_cache.dm September 29 2025
	return get_cached_appearance(tag, prop, behind, mirrored)

/obj/item/proc/get_extra_onmob_index()
	//perhaps in the future: force items like flasks to use getflaticon to get their filled states and drinking cups too. that's all
	return

/obj/item/proc/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.2,"sx" = -7,"sy" = -4,"nx" = 7,"ny" = -4,"wx" = -4,"wy" = -4,"ex" = 2,"ey" = -4,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
			if("wielded")
				return null
			if("altgrip")
				return null
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
			if("onback")
				return list("shrink" = 0.5,"sx" = 1,"sy" = -1,"nx" = 1,"ny" = -1,"wx" = 4,"wy" = -1,"ex" = -1,"ey" = -1,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/proc/mirror_fix(shrink, big)
	if(!shrink)
		return FALSE
	switch(shrink)
		if(0.5)
			return 1
		if(0.6)
			if(big)
				return 1
			else
				return 2
		if(0.7)
			return 1

// For checking if we have a specific icon state in an icon.
// Cached cause asking icons is expensive. This is still expensive, so avoid using it if
// you can reasonably expect the icon_state to exist beforehand, or if you can cache the
// value somewhere.
GLOBAL_LIST_EMPTY(icon_state_cache)
/proc/check_state_in_icon(var/checkstate, var/checkicon)
	// isicon() is apparently quite expensive so short-circuit out early if we can.
	if(!istext(checkstate) || isnull(checkicon) || !(isfile(checkicon) || isicon(checkicon)))
		return FALSE
	var/checkkey = "\ref[checkicon]"
	var/list/check = GLOB.icon_state_cache[checkkey]
	if(!check)
		check = list()
		for(var/istate in icon_states(checkicon))
			check[istate] = TRUE
		GLOB.icon_state_cache[checkkey] = check
	. = check[checkstate]

/obj/item/var/has_behind_state

#ifdef TESTSERVER

/client/verb/output_inhands()
	set category = "INHANDS"
	set name = "Output Variables"
	set desc = ""

	var/mob/living/carbon/human/LI = mob
	var/obj/item/I = LI.get_active_held_item()
	if(!I)
		I = LI.beltr
	if(!I)
		I = LI.beltl
	if(!I)
		I = LI.backr
	if(!I)
		I = LI.backl
	if(I)
		for(var/X in I.onprop)
			var/list/L = I.onprop[X]
			var/list/tegst = list()
			to_chat(mob, "\"[X]\"")
			tegst += "return list("
			if(L && L.len)
				for(var/P in L)
					tegst += "\"[P]\" = [L[P]],"
			to_chat(mob, "[tegst.Join()]")

/client/verb/inhand_xplus()
	set category = "INHANDS"
	set name = "X+1"

	if(!isliving(mob))
		return
	var/mob/living/carbon/human/LI = mob

	var/needtofind
	switch(LI.dir)
		if(NORTH)
			needtofind = "nx"
		if(SOUTH)
			needtofind = "sx"
		if(WEST)
			needtofind = "wx"
		if(EAST)
			needtofind = "ex"

	var/obj/item/I = LI.get_active_held_item()
	var/used_cat
	if(!I)
		I = LI.beltr
		used_cat = "onbelt"
	if(!I)
		I = LI.beltl
	if(!I)
		used_cat = "onback"
		I = LI.backr
	if(!I)
		I = LI.backl
	if(I)
		if(!used_cat && I.altgripped)
			used_cat = "altgrip"
		if(!used_cat && I.wielded)
			used_cat = "wielded"
		if(!used_cat)
			used_cat = "gen"

		for(var/X in I.onprop)
			if(X == used_cat)
				var/list/L = I.onprop[X]
				if(L.len)
					for(var/P in L)
						if(P == needtofind)
							L[P] += 1
							to_chat(LI, "[needtofind] = [L[P]]")
	LI.update_inv_hands()
	LI.update_inv_belt()
	LI.update_inv_back()

/client/verb/inhand_xminus()
	set category = "INHANDS"
	set name = "X-1"

	if(!isliving(mob))
		return
	var/mob/living/carbon/human/LI = mob

	var/needtofind
	switch(LI.dir)
		if(NORTH)
			needtofind = "nx"
		if(SOUTH)
			needtofind = "sx"
		if(WEST)
			needtofind = "wx"
		if(EAST)
			needtofind = "ex"

	var/obj/item/I = LI.get_active_held_item()
	var/used_cat
	if(!I)
		I = LI.beltr
		used_cat = "onbelt"
	if(!I)
		I = LI.beltl
	if(!I)
		used_cat = "onback"
		I = LI.backr
	if(!I)
		I = LI.backl
	if(I)
		if(!used_cat && I.altgripped)
			used_cat = "altgrip"
		if(!used_cat && I.wielded)
			used_cat = "wielded"
		if(!used_cat)
			used_cat = "gen"

		for(var/X in I.onprop)
			if(X == used_cat)
				var/list/L = I.onprop[X]
				if(L.len)
					for(var/P in L)
						if(P == needtofind)
							L[P] -= 1
							to_chat(LI, "[needtofind] = [L[P]]")
	LI.update_inv_hands()
	LI.update_inv_belt()
	LI.update_inv_back()

/client/verb/inhand_yplus()
	set category = "INHANDS"
	set name = "Y+1"

	if(!isliving(mob))
		return
	var/mob/living/carbon/human/LI = mob

	var/needtofind
	switch(LI.dir)
		if(NORTH)
			needtofind = "ny"
		if(SOUTH)
			needtofind = "sy"
		if(WEST)
			needtofind = "wy"
		if(EAST)
			needtofind = "ey"

	var/obj/item/I = LI.get_active_held_item()
	var/used_cat
	if(!I)
		I = LI.beltr
		used_cat = "onbelt"
	if(!I)
		I = LI.beltl
	if(!I)
		used_cat = "onback"
		I = LI.backr
	if(!I)
		I = LI.backl
	if(I)
		if(!used_cat && I.altgripped)
			used_cat = "altgrip"
		if(!used_cat && I.wielded)
			used_cat = "wielded"
		if(!used_cat)
			used_cat = "gen"

		for(var/X in I.onprop)
			if(X == used_cat)
				var/list/L = I.onprop[X]
				if(L.len)
					for(var/P in L)
						if(P == needtofind)
							L[P] += 1
							to_chat(LI, "[needtofind] = [L[P]]")
	LI.update_inv_hands()
	LI.update_inv_belt()
	LI.update_inv_back()

/client/verb/inhand_yminus()
	set category = "INHANDS"
	set name = "Y-1"

	if(!isliving(mob))
		return
	var/mob/living/carbon/human/LI = mob

	var/needtofind
	switch(LI.dir)
		if(NORTH)
			needtofind = "ny"
		if(SOUTH)
			needtofind = "sy"
		if(WEST)
			needtofind = "wy"
		if(EAST)
			needtofind = "ey"

	var/obj/item/I = LI.get_active_held_item()
	var/used_cat
	if(!I)
		I = LI.beltr
		used_cat = "onbelt"
	if(!I)
		I = LI.beltl
	if(!I)
		used_cat = "onback"
		I = LI.backr
	if(!I)
		I = LI.backl
	if(I)
		if(!used_cat && I.altgripped)
			used_cat = "altgrip"
		if(!used_cat && I.wielded)
			used_cat = "wielded"
		if(!used_cat)
			used_cat = "gen"

		for(var/X in I.onprop)
			if(X == used_cat)
				var/list/L = I.onprop[X]
				if(L.len)
					for(var/P in L)
						if(P == needtofind)
							L[P] -= 1
							to_chat(LI, "[needtofind] = [L[P]]")
	LI.update_inv_hands()
	LI.update_inv_belt()
	LI.update_inv_back()

/client/verb/inhand_flip()
	set category = "INHANDS"
	set name = "FLIP"

	if(!isliving(mob))
		return
	var/mob/living/carbon/human/LI = mob

	var/needtofind
	switch(LI.dir)
		if(NORTH)
			needtofind = "nflip"
		if(SOUTH)
			needtofind = "sflip"
		if(WEST)
			needtofind = "wflip"
		if(EAST)
			needtofind = "eflip"

	var/obj/item/I = LI.get_active_held_item()
	var/used_cat
	if(!I)
		I = LI.beltr
		used_cat = "onbelt"
	if(!I)
		I = LI.beltl
	if(!I)
		used_cat = "onback"
		I = LI.backr
	if(!I)
		I = LI.backl
	if(I)
		if(!used_cat && I.altgripped)
			used_cat = "altgrip"
		if(!used_cat && I.wielded)
			used_cat = "wielded"
		if(!used_cat)
			used_cat = "gen"

		for(var/X in I.onprop)
			if(X == used_cat)
				var/list/L = I.onprop[X]
				if(L.len)
					if(!needtofind in L)
						L += needtofind
					for(var/P in L)
						if(P == needtofind)
							if(!L[P])
								L[P] = NORTH
							else
								switch(L[P])
									if(NORTH)
										L[P] = SOUTH
									if(SOUTH)
										L[P] = WEST
									if(WEST)
										L[P] = EAST
									if(EAST)
										L[P] = 0
							to_chat(LI, "[needtofind] = [L[P]]")
	LI.update_inv_hands()
	LI.update_inv_belt()
	LI.update_inv_back()

/client/verb/inhand_turnplus()
	set category = "INHANDS"
	set name = "Turn +1"

	if(!isliving(mob))
		return
	var/mob/living/carbon/human/LI = mob

	var/needtofind
	switch(LI.dir)
		if(NORTH)
			needtofind = "nturn"
		if(SOUTH)
			needtofind = "sturn"
		if(WEST)
			needtofind = "wturn"
		if(EAST)
			needtofind = "eturn"

	var/obj/item/I = LI.get_active_held_item()
	var/used_cat
	if(!I)
		I = LI.beltr
		used_cat = "onbelt"
	if(!I)
		I = LI.beltl
	if(!I)
		used_cat = "onback"
		I = LI.backr
	if(!I)
		I = LI.backl
	if(I)
		if(!used_cat && I.altgripped)
			used_cat = "altgrip"
		if(!used_cat && I.wielded)
			used_cat = "wielded"
		if(!used_cat)
			used_cat = "gen"

		for(var/X in I.onprop)
			if(X == used_cat)
				var/list/L = I.onprop[X]
				if(L.len)
					if(!needtofind in L)
						L += needtofind
					for(var/P in L)
						if(P == needtofind)
							L[P] += 1
							to_chat(LI, "[needtofind] = [L[P]]")
	LI.update_inv_hands()
	LI.update_inv_belt()
	LI.update_inv_back()

/client/verb/inhand_turnminus()
	set category = "INHANDS"
	set name = "Turn -1"

	if(!isliving(mob))
		return
	var/mob/living/carbon/human/LI = mob

	var/needtofind
	switch(LI.dir)
		if(NORTH)
			needtofind = "nturn"
		if(SOUTH)
			needtofind = "sturn"
		if(WEST)
			needtofind = "wturn"
		if(EAST)
			needtofind = "eturn"

	var/obj/item/I = LI.get_active_held_item()
	var/used_cat
	if(!I)
		I = LI.beltr
		used_cat = "onbelt"
	if(!I)
		I = LI.beltl
	if(!I)
		used_cat = "onback"
		I = LI.backr
	if(!I)
		I = LI.backl
	if(I)
		if(!used_cat && I.altgripped)
			used_cat = "altgrip"
		if(!used_cat && I.wielded)
			used_cat = "wielded"
		if(!used_cat)
			used_cat = "gen"

		for(var/X in I.onprop)
			if(X == used_cat)
				var/list/L = I.onprop[X]
				if(L.len)
					if(!needtofind in L)
						L += needtofind
					for(var/P in L)
						if(P == needtofind)
							L[P] -= 1
							to_chat(LI, "[needtofind] = [L[P]]")
	LI.update_inv_hands()
	LI.update_inv_belt()
	LI.update_inv_back()

/client/verb/inhand_scaleplus()
	set category = "INHANDS"
	set name = "Shrink+0.1"

	if(!isliving(mob))
		return
	var/mob/living/carbon/human/LI = mob

	var/needtofind = "shrink"

	var/obj/item/I = LI.get_active_held_item()
	var/used_cat
	if(!I)
		I = LI.beltr
		used_cat = "onbelt"
	if(!I)
		I = LI.beltl
	if(!I)
		used_cat = "onback"
		I = LI.backr
	if(!I)
		I = LI.backl
	if(I)
		if(!used_cat && I.altgripped)
			used_cat = "altgrip"
		if(!used_cat && I.wielded)
			used_cat = "wielded"
		if(!used_cat)
			used_cat = "gen"

		if(length(I.onprop?[used_cat]))
			var/list/L = I.onprop[used_cat]
			L[needtofind] += 0.1
			to_chat(LI, "[needtofind] = [L[needtofind]]")
	LI.update_inv_hands()
	LI.update_inv_belt()
	LI.update_inv_back()

/client/verb/inhand_scaleminus()
	set category = "INHANDS"
	set name = "Shrink-0.1"

	if(!isliving(mob))
		return
	var/mob/living/carbon/human/LI = mob

	var/needtofind = "shrink"

	var/obj/item/I = LI.get_active_held_item()
	var/used_cat
	if(!I)
		I = LI.beltr
		used_cat = "onbelt"
	if(!I)
		I = LI.beltl
	if(!I)
		used_cat = "onback"
		I = LI.backr
	if(!I)
		I = LI.backl
	if(I)
		if(!used_cat && I.altgripped)
			used_cat = "altgrip"
		if(!used_cat && I.wielded)
			used_cat = "wielded"
		if(!used_cat)
			used_cat = "gen"

		if(length(I.onprop?[used_cat]))
			var/list/L = I.onprop[used_cat]
			L[needtofind] -= 0.1
			to_chat(LI, "[needtofind] = [L[needtofind]]")
	LI.update_inv_hands()
	LI.update_inv_belt()
	LI.update_inv_back()

/client/verb/give_me_money()
	set category = "DEBUGTEST"
	set name = "GiveMeMoney"
	if(mob)
		var/turf/T = get_turf(mob)
		if(T)
			new /obj/item/roguecoin/gold/pile(T)
/*
/client/verb/wwolf()
	set category = "DEBUGTEST"
	set name = "Werewolf"
	if(mob.mind)
		if(mob.mind.has_antag_datum(/datum/antagonist/werewolf, TRUE))
			to_chat(mob, "I am already a werewolf.")
		else
			var/datum/antagonist/werewolf/new_antag = new /datum/antagonist/werewolf()
			mob.mind.add_antag_datum(new_antag)
*/

/client/verb/zoomtest()
	set category = "DEBUGTEST"
	set name = "ZoomTest"
	if(mob)
		if(iscarbon(mob))
			var/mob/living/carbon/C = mob
			var/list/screens = list(C.hud_used.plane_masters["[FLOOR_PLANE]"], C.hud_used.plane_masters["[GAME_PLANE]"], C.hud_used.plane_masters["[LIGHTING_PLANE]"])
			var/matrix/skew = matrix()
			skew.Scale(2)
			var/matrix/newmatrix = skew
			for(var/whole_screen in screens)
				animate(whole_screen, transform = newmatrix, time = 5, easing = QUAD_EASING, loop = -1)
				animate(transform = -newmatrix, time = 5, easing = QUAD_EASING)

/client/verb/zoomteststop()
	set category = "DEBUGTEST"
	set name = "ZoomTestEnd"
	if(mob)
		if(iscarbon(mob))
			var/mob/living/carbon/C = mob
			var/list/screens = list(C.hud_used.plane_masters["[FLOOR_PLANE]"], C.hud_used.plane_masters["[GAME_PLANE]"], C.hud_used.plane_masters["[LIGHTING_PLANE]"])
			for(var/whole_screen in screens)
				animate(whole_screen, transform = matrix(), time = 5, easing = QUAD_EASING)
#endif

#ifdef TESTING
/client/verb/door_test_button()
	set category = "DEBUGTEST"
	set name = "door_test_button"
	if(mob)
		var/mob/M = mob
		if(isturf(M.loc))
			var/turf/T = M.loc
			for(var/obj/structure/mineral_door/D in T)
				to_chat(M, "DOOR - [D]")
				to_chat(M, "LOCKID: [D.lockid]")
				to_chat(M, "LOCKSTATUS: [D.locked]")
#endif
