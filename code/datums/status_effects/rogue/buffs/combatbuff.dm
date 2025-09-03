///////////////////////////
// Combat Related Buffs    //
///////////////////////////

//any combat related buffs go here

/datum/status_effect/buff/clash
	id = "clash"
	duration = 6 SECONDS
	var/dur
	alert_type = /atom/movable/screen/alert/status_effect/buff/clash

/datum/status_effect/buff/clash/on_apply()
	. = ..()
	if(!ishuman(owner))
		return
	dur = world.time
	var/mob/living/carbon/human/H = owner
	H.play_overhead_indicator('icons/mob/overhead_effects.dmi', prob(50) ? "clash" : "clashr", duration, OBJ_LAYER, soundin = 'sound/combat/clash_initiate.ogg', y_offset = 28)

/datum/status_effect/buff/clash/tick()
	if(!owner.get_active_held_item() || !(owner.mobility_flags & MOBILITY_STAND))
		var/mob/living/carbon/human/H = owner
		H.bad_guard()

/datum/status_effect/buff/clash/on_remove()
	. = ..()
	owner.apply_status_effect(/datum/status_effect/debuff/clashcd)
	var/newdur = world.time - dur
	var/mob/living/carbon/human/H = owner
	if(newdur > (duration - 0.3 SECONDS))	//Not checking exact duration to account for lag and any other tick / timing inconsistencies.
		H.bad_guard(span_warning("I held my focus for too long. It's left me drained."))
	var/mutable_appearance/appearance = H.overlays_standing[OBJ_LAYER]
	H.clear_overhead_indicator(appearance)


/atom/movable/screen/alert/status_effect/buff/clash
	name = "Ready to Clash"
	desc = span_notice("I am on guard, and ready to clash. If I am hit, I will successfully defend. Attacking will make me lose my focus.")
	icon_state = "clash"

/atom/movable/screen/alert/status_effect/buff/adrenaline_rush
	name = "Adrenaline Rush"
	desc = "The gambit worked! I can do anything! My heart races, the throb of my wounds wavers."
	icon_state = "adrrush"

/datum/status_effect/buff/adrenaline_rush
	id = "adrrush"
	alert_type = /atom/movable/screen/alert/status_effect/buff/adrenaline_rush
	duration = 18 SECONDS
	examine_text = "SUBJECTPRONOUN is amped up!"
	effectedstats = list("endurance" = 1)
	var/blood_restore = 30

/datum/status_effect/buff/adrenaline_rush/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_ADRENALINE_RUSH, INNATE_TRAIT)
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.playsound_local(get_turf(H), 'sound/misc/adrenaline_rush.ogg', 100, TRUE)
		H.blood_volume = min((H.blood_volume + blood_restore), BLOOD_VOLUME_NORMAL)
		H.stamina -= max((H.stamina - (H.max_stamina / 2)), 0)

/datum/status_effect/buff/adrenaline_rush/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_ADRENALINE_RUSH, INNATE_TRAIT)

/datum/status_effect/buff/oiled
	id = "oiled"
	duration = 5 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/oiled
	var/slip_chance = 2 // chance to slip when moving

/datum/status_effect/buff/oiled/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))

/datum/status_effect/buff/oiled/on_remove()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

/datum/status_effect/buff/oiled/proc/on_move(mob/living/mover, atom/oldloc, direction, forced)
	if(forced)
		return
	var/slipping_prob = slip_chance
	if(iscarbon(mover))
		var/mob/living/carbon/carbon = mover
		if(!carbon.shoes) // being barefoot makes you slip lesss
			slipping_prob /= 2

	if(!prob(slip_chance))
		return

	if(istype(mover))
		if(istype(mover.mind?.assigned_role, /datum/job/roguetown/jester))
			mover.liquid_slip(total_time = 1 SECONDS, stun_duration = 1 SECONDS, height = 30, flip_count = 10)
		else
			mover.liquid_slip(total_time = 1 SECONDS, stun_duration = 1 SECONDS, height = 12, flip_count = 0)

/atom/movable/screen/alert/status_effect/oiled
	name = "Oiled"
	desc = "I'm covered in oil, making me slippery and harder to grab!"
	icon_state = "oiled"
