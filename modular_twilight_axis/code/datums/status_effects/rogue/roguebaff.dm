/datum/status_effect/buff/goodloving
	id = "Good Loving"
	alert_type = /atom/movable/screen/alert/status_effect/buff/goodloving
	effectedstats = list("fortune" = 2)
	duration = 60 MINUTES //Note, you can only benefit from this buff ONCE

/atom/movable/screen/alert/status_effect/buff/goodloving
	name = "Good Loving"
	desc = "Some good loving has left me feeling very fortunate."
	icon_state = "stressg"

/atom/movable/screen/alert/status_effect/buff/templarbuff
	name = "Decem Dii Vult"
	desc = "I am a member of this temple, sworn to defend the House of the Ten until my very dying breath."
	icon_state = "buff"

/datum/status_effect/buff/templarbuff
	id = "templarbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/templarbuff
	effectedstats = list(STATKEY_STR = 1,STATKEY_WIL = 2,STATKEY_INT = 1,STATKEY_SPD = 1,STATKEY_CON = 2,STATKEY_LCK = 1)
	var/lastcheck = 0

/datum/status_effect/buff/templarbuff/process()

	.=..()
	var/area/rogue/our_area = get_area(owner)
	if(!(our_area.holy_area) && !(world.time < lastcheck + 10 SECONDS))
		lastcheck = world.time
		var/preserve = FALSE
		for(var/turf/T in view(5, owner))
			var/area/rogue/mercyarea = get_area(T)
			if(mercyarea.holy_area)
				preserve = TRUE
		for(var/mob/living/carbon/human/H in view(7, owner))
			if(H.mind?.assigned_role == "Bishop")
				preserve = TRUE
		if(!preserve)
			owner.remove_status_effect(/datum/status_effect/buff/templarbuff)
	
/mob/living/carbon/human
	var/priest_timer_check = 0

/mob/living/carbon/human/Life()
	. = ..()
	if((src.mind?.assigned_role == "Bishop") && !(world.time < priest_timer_check + 10 SECONDS))
		priest_timer_check = world.time
		for(var/mob/living/carbon/human/H in view(7, src))
			if(HAS_TRAIT(H, TRAIT_CLERGY) && !H.has_status_effect(/datum/status_effect/buff/templarbuff))
				H.apply_status_effect(/datum/status_effect/buff/templarbuff)

/area/rogue/Entered(mob/living/carbon/human/guy)

	.=..()
	if((src.holy_area == TRUE) && HAS_TRAIT(guy, TRAIT_CLERGY) && !guy.has_status_effect(/datum/status_effect/buff/templarbuff) && !HAS_TRAIT(guy, TRAIT_EXCOMMUNICATED) && !HAS_TRAIT(guy, TRAIT_HERESIARCH))
		guy.apply_status_effect(/datum/status_effect/buff/templarbuff)
