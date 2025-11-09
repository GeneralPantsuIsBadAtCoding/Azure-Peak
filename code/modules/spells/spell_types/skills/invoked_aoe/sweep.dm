

/////////////////////////////////////////
/////////////////////////////////// SWEEP
/*
	reskinned repulse, intended to be given to Warband antagonists
	only goes off if it has 3+ targets
	characters who share a warband ID don't count as targets
	requires a weapon
*/

/datum/looping_sound/martial
	mid_sounds = list('sound/combat/clash_disarm_us.ogg')
	mid_length = 180
	volume = 100

/obj/effect/proc_holder/spell/invoked/sweep
	name = "Sweep"
	desc = "Drive back whomever might surround you. Requires a held weapon, and is ineffective against any fewer than three targets."
	releasedrain = 50
	chargedrain = 1
	chargetime = 5
	recharge_time = 40 SECONDS
	is_cdr_exempt = TRUE
	ignore_los = TRUE
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/martial
	associated_skill = /datum/skill/misc/athletics
	overlay_state = "call_to_arms"
	ignore_cockblock = TRUE
	gesture_required = TRUE
	req_inhand = /obj/item/rogueweapon
	var/maxthrow = 3
	var/repulse_force = MOVE_FORCE_EXTREMELY_STRONG
	var/push_range = 1



/obj/effect/proc_holder/spell/invoked/sweep/cast(list/targets, mob/user, stun_amt = 5)
	var/list/viable_targets = list()
	var/atom/throwtarget

	for(var/mob/living/carbon/AM in view(push_range, user))
		if(AM == user || AM.anchored)
			continue
		if(AM.mind && AM.mind.warband_ID && AM.mind.warband_ID == user.mind.warband_ID)
			return
		viable_targets += AM

	if(viable_targets.len < 3)
		to_chat(user, "There's not enough foes in range!")
		return FALSE

	for(var/mob/living/carbon/screenshaken in view(5, user))
		shake_camera(screenshaken, 10, 1)
		screenshaken.flash_fullscreen("stressflash")

	playsound(user, 'sound/combat/clash_struck.ogg', 80, TRUE)


	for(var/mob/living/carbon/AM in viable_targets)
		var/distfromcaster = get_dist(user, AM)
		throwtarget = get_edge_target_turf(user, get_dir(user, get_step_away(AM, user)))

		if(distfromcaster == 0)
			AM.set_resting(TRUE, TRUE)
			AM.adjustBruteLoss(20)
			to_chat(AM, "<span class='danger'>You're slammed into the floor by [user]!</span>")
		else
			AM.set_resting(TRUE, TRUE)
			to_chat(AM, "<span class='danger'>You're thrown back by [user]!</span>")
			AM.safe_throw_at(throwtarget, ((CLAMP((maxthrow - (CLAMP(distfromcaster - 2, 0, distfromcaster))), 3, maxthrow))), 1,user, force = repulse_force)
	user.visible_message(span_boldred("[user] sweeps their weapon, driving back their foes!"))
	return TRUE
