#define SEX_ZONE_NULL				0
#define SEX_ZONE_GROIN				(1<<0)
#define SEX_ZONE_GROIN_GRAB			(1<<1)
#define SEX_ZONE_L_FOOT				(1<<2)
#define SEX_ZONE_R_FOOT				(1<<3)
#define SEX_ZONE_MOUTH				(1<<4)
#define SEX_ZONE_CHEST				(1<<5)
#define SEX_ZONE_CHEST_GRAB			(1<<6)

/datum/sex_controller
	/// The user and the owner of the controller
	var/mob/living/carbon/human/user
	/// Target of our actions, can be ourself
	var/mob/living/carbon/human/target
	/// Who is targeting us
	// Disabled as it'd require properly stopping actions when the popup is closed.
	// Different behavior which might be invasive.
	//var/receiving = list()
	/// Whether the user desires to stop his current action
	var/desire_stop = FALSE
	/// What is the current performed action
	var/current_action = null
	/// Enum of desired speed
	var/speed = SEX_SPEED_MID
	/// Enum of desired force
	var/force = SEX_FORCE_MID
	/// Our arousal
	var/arousal = 0
	///Makes genital arousal automatic by default
	var/manual_arousal = SEX_MANUAL_AROUSAL_DEFAULT
	/// Our charge gauge
	var/charge = SEX_MAX_CHARGE
	/// Whether we want to screw until finished, or non stop
	var/do_until_finished = TRUE
	/// Arousal won't change if active.
	var/arousal_frozen = FALSE
	var/last_arousal_increase_time = 0
	var/last_ejaculation_time = 0
	var/last_moan = 0
	var/last_pain = 0
	var/aphrodisiac = 1 //1 by default, acts as a multiplier on arousal gain. If this is different than 1, set/freeze arousal is disabled.
	/// Which zones we are using in the current action.
	var/using_zones = list()
	/// Cache body parts used for accessibility check
	var/access_zone_bitfield = SEX_ZONE_NULL
	/// Menu based variables
	var/action_category = SEX_CATEGORY_MISC
	/// Show progress bar
	var/show_progress = 1
	/// Knot based variables
	var/do_knot_action = FALSE
	var/knotted_status = KNOTTED_NULL // knotted state and used to prevent multiple knottings when we do not handle that case
	var/knotted_part = SEX_PART_NULL // which orifice was knotted (bitflag)
	var/knotted_part_partner = SEX_PART_NULL // which orifice was knotted on partner (bitflag)
	var/tugging_knot = FALSE
	var/tugging_knot_check = 0
	var/tugging_knot_blocked = FALSE
	var/mob/living/carbon/knotted_owner = null // whom has the knot
	var/mob/living/carbon/knotted_recipient = null // whom took the knot

/datum/sex_controller/New(mob/living/carbon/human/owner)
	user = owner

/datum/sex_controller/Destroy()
	//remove_from_target_receiving()
	user = null
	target = null
	if(knotted_status)
		knot_exit()
	//receiving = list()
	. = ..()

/datum/sex_controller/proc/do_thrust_animate(atom/movable/target, pixels = 4, time = 2.7)
	var/oldx = user.pixel_x
	var/oldy = user.pixel_y
	var/target_x = oldx
	var/target_y = oldy
	var/dir = get_dir(user, target)
	if(user.loc == target.loc)
		dir = user.dir
	if(speed > SEX_SPEED_MID)
		time -= 0.25
	if(force < SEX_FORCE_MID)
		pixels -= 1
	switch(dir)
		if(NORTH)
			target_y += pixels
		if(SOUTH)
			target_y -= pixels
		if(WEST)
			target_x -= pixels
		if(EAST)
			target_x += pixels

	animate(user, pixel_x = target_x, pixel_y = target_y, time = time)
	animate(pixel_x = oldx, pixel_y = oldy, time = time)

/datum/sex_controller/proc/is_spent()
	if(charge < CHARGE_FOR_CLIMAX)
		return TRUE
	return FALSE

// any new sex commands that target new locations, will need to be added here, and given a unique bitflag define
/datum/sex_controller/proc/update_all_accessible_body_zones()
	access_zone_bitfield = SEX_ZONE_NULL
	if(get_location_accessible(user, BODY_ZONE_PRECISE_GROIN, grabs = FALSE, skipundies = TRUE))
		access_zone_bitfield |= SEX_ZONE_GROIN
	if(get_location_accessible(user, BODY_ZONE_PRECISE_GROIN, grabs = TRUE, skipundies = TRUE))
		access_zone_bitfield |= SEX_ZONE_GROIN_GRAB
	if(get_location_accessible(user, BODY_ZONE_PRECISE_L_FOOT, grabs = FALSE, skipundies = TRUE))
		access_zone_bitfield |= SEX_ZONE_L_FOOT
	if(get_location_accessible(user, BODY_ZONE_PRECISE_R_FOOT, grabs = FALSE, skipundies = TRUE))
		access_zone_bitfield |= SEX_ZONE_R_FOOT
	if(get_location_accessible(user, BODY_ZONE_PRECISE_MOUTH, grabs = FALSE, skipundies = TRUE))
		access_zone_bitfield |= SEX_ZONE_MOUTH
	if(get_location_accessible(user, BODY_ZONE_CHEST, grabs = FALSE, skipundies = TRUE))
		access_zone_bitfield |= SEX_ZONE_CHEST
	if(get_location_accessible(user, BODY_ZONE_CHEST, grabs = TRUE, skipundies = TRUE))
		access_zone_bitfield |= SEX_ZONE_CHEST_GRAB

// only check active accessible body zones
/datum/sex_controller/proc/update_current_accessible_body_zones(body_zone, grabs)
	switch(body_zone)
		if(BODY_ZONE_PRECISE_GROIN)
			if(grabs)
				if((access_zone_bitfield&SEX_ZONE_GROIN_GRAB) && !get_location_accessible(user, BODY_ZONE_PRECISE_GROIN, grabs = TRUE, skipundies = TRUE))
					access_zone_bitfield &= ~SEX_ZONE_GROIN_GRAB
			else if((access_zone_bitfield&SEX_ZONE_GROIN) && !get_location_accessible(user, BODY_ZONE_PRECISE_GROIN, grabs = FALSE, skipundies = TRUE))
				access_zone_bitfield &= ~SEX_ZONE_GROIN
		if(BODY_ZONE_PRECISE_L_FOOT)
			if((access_zone_bitfield&SEX_ZONE_L_FOOT) && !get_location_accessible(user, BODY_ZONE_PRECISE_L_FOOT, grabs = FALSE, skipundies = TRUE))
				access_zone_bitfield &= ~SEX_ZONE_L_FOOT
		if(BODY_ZONE_PRECISE_R_FOOT)
			if((access_zone_bitfield&SEX_ZONE_R_FOOT) && !get_location_accessible(user, BODY_ZONE_PRECISE_R_FOOT, grabs = FALSE, skipundies = TRUE))
				access_zone_bitfield &= ~SEX_ZONE_R_FOOT
		if(BODY_ZONE_PRECISE_MOUTH)
			if((access_zone_bitfield&SEX_ZONE_MOUTH) && !get_location_accessible(user, BODY_ZONE_PRECISE_MOUTH, grabs = FALSE, skipundies = TRUE))
				access_zone_bitfield &= ~SEX_ZONE_MOUTH
		if(BODY_ZONE_CHEST)
			if(grabs)
				if((access_zone_bitfield&SEX_ZONE_CHEST_GRAB) && !get_location_accessible(user, BODY_ZONE_CHEST, grabs = TRUE, skipundies = TRUE))
					access_zone_bitfield &= ~SEX_ZONE_CHEST_GRAB
			else if((access_zone_bitfield&SEX_ZONE_CHEST) && !get_location_accessible(user, BODY_ZONE_CHEST, grabs = FALSE, skipundies = TRUE))
				access_zone_bitfield &= ~SEX_ZONE_CHEST
		else
		 	// hey YOU, add the new targeted zone to SEX_ZONE bitfield, and update update_all_accessible_body_zones()/get_accessible_body_zone()
			CRASH("sex_action: attempt to access non-existent bitfield for var body_zone_bitfield [body_zone]")

/datum/sex_controller/proc/get_accessible_body_zone(body_zone_bitfield, body_zone, grabs)
	switch(body_zone)
		if(BODY_ZONE_PRECISE_GROIN)
			if(grabs)
				return (body_zone_bitfield&SEX_ZONE_GROIN_GRAB) != SEX_ZONE_NULL
			return (body_zone_bitfield&SEX_ZONE_GROIN) != SEX_ZONE_NULL
		if(BODY_ZONE_PRECISE_L_FOOT)
			return (body_zone_bitfield&SEX_ZONE_L_FOOT) != SEX_ZONE_NULL
		if(BODY_ZONE_PRECISE_R_FOOT)
			return (body_zone_bitfield&SEX_ZONE_R_FOOT) != SEX_ZONE_NULL
		if(BODY_ZONE_PRECISE_MOUTH)
			return (body_zone_bitfield&SEX_ZONE_MOUTH) != SEX_ZONE_NULL
		if(BODY_ZONE_CHEST)
			if(grabs)
				return (body_zone_bitfield&SEX_ZONE_CHEST_GRAB) != SEX_ZONE_NULL
			return (body_zone_bitfield&SEX_ZONE_CHEST) != SEX_ZONE_NULL
	// hey YOU, add the new targeted zone to SEX_ZONE bitfield, and update update_all_accessible_body_zones()/update_current_accessible_body_zones()
	CRASH("sex_action: attempt to access non-existent bitfield for var body_zone_bitfield [body_zone]")

/datum/sex_action/proc/check_location_accessible(mob/living/carbon/human/user, mob/living/carbon/human/target, location = BODY_ZONE_CHEST, grabs = FALSE)
	var/obj/item/bodypart/bodypart = target.get_bodypart(location)

	var/self_target = FALSE
	var/datum/sex_controller/user_controller = user.sexcon
	if(user_controller.target == user)
		self_target = TRUE

	var/signalargs = list(src, bodypart, self_target)
	signalargs += args

	var/sigbitflags = SEND_SIGNAL(target, COMSIG_ERP_LOCATION_ACCESSIBLE, signalargs)
	bodypart = signalargs[ERP_BODYPART]

	if(sigbitflags & SIG_CHECK_FAIL)
		return FALSE

	if(!bodypart)
		return FALSE

	if(!(sigbitflags & SKIP_ADJACENCY_CHECK) && !user.Adjacent(target))
		return FALSE

	if(src.check_same_tile && (user != target || self_target) && !(sigbitflags & SKIP_TILE_CHECK))
		var/same_tile = (get_turf(user) == get_turf(target))
		var/grab_bypass = (src.aggro_grab_instead_same_tile && user.get_highest_grab_state_on(target) == GRAB_AGGRESSIVE)
		if(!same_tile && !grab_bypass)
			return FALSE

	if(src.require_grab && (user != target || self_target) && !(sigbitflags & SKIP_GRAB_CHECK))
		var/grabstate = user.get_highest_grab_state_on(target)
		if((grabstate == null || grabstate < src.required_grab_state))
			return FALSE

	if(!isnull(user_controller.current_action) && user_controller.current_action == src.type) // action is active, update the currently accessible body zones
		target.sexcon.update_current_accessible_body_zones(location, grabs)
	var/result = user_controller.get_accessible_body_zone(target.sexcon.access_zone_bitfield, location, grabs)
	if(result && user == target && !(bodypart in user_controller.using_zones) && user_controller.current_action == SEX_ACTION(src))
		user_controller.using_zones += location
	
	return result

/datum/sex_controller/proc/finished_check()
	if(!do_until_finished)
		return FALSE
	if(!just_ejaculated())
		return FALSE
	return TRUE

/datum/sex_controller/proc/adjust_speed(amt)
	speed = clamp(speed + amt, SEX_SPEED_MIN, SEX_SPEED_MAX)

/datum/sex_controller/proc/adjust_force(amt)
	force = clamp(force + amt, SEX_FORCE_MIN, SEX_FORCE_MAX)
/datum/sex_controller/proc/adjust_arousal_manual(amt)
	manual_arousal = clamp(manual_arousal + amt, SEX_MANUAL_AROUSAL_MIN, SEX_MANUAL_AROUSAL_MAX)

/datum/sex_controller/proc/update_pink_screen()
	var/severity = 0
	switch(arousal)
		if(1 to 10)
			severity = 1
		if(10 to 20)
			severity = 2
		if(20 to 30)
			severity = 3
		if(30 to 40)
			severity = 4
		if(40 to 50)
			severity = 5
		if(50 to 60)
			severity = 6
		if(60 to 70)
			severity = 7
		if(70 to 80)
			severity = 8
		if(80 to 90)
			severity = 9
		if(90 to INFINITY)
			severity = 10
	if(severity > 0)
		user.overlay_fullscreen("horny", /atom/movable/screen/fullscreen/love, severity)
	else
		user.clear_fullscreen("horny")

/datum/sex_controller/proc/start(mob/living/carbon/human/new_target)
	if(!ishuman(new_target))
		return
	set_target(new_target)
	show_ui()

/datum/sex_controller/proc/cum_onto(var/mob/living/carbon/human/splashed_user = null)
	log_combat(user, target, "Кончает на партнера")
	playsound(target, 'sound/misc/mat/endout.ogg', 50, TRUE, ignore_walls = FALSE)
	add_cum_floor(get_turf(target))
	if(splashed_user)
		var/datum/status_effect/facial/facial = splashed_user.has_status_effect(/datum/status_effect/facial)
		if(!facial)
			splashed_user.apply_status_effect(/datum/status_effect/facial)
		else
			facial.refresh_cum()
	after_ejaculation()
	target.reagents.add_reagent(/datum/reagent/erpjuice/cum, 3)

/datum/sex_controller/proc/cum_into(oral = FALSE, var/mob/living/carbon/human/splashed_user = null)
	log_combat(user, target, "Кончает в партнера")
	if(oral)
		playsound(target, pick(list('sound/misc/mat/mouthend (1).ogg','sound/misc/mat/mouthend (2).ogg')), 100, FALSE, ignore_walls = FALSE)
	else
		playsound(target, 'sound/misc/mat/endin.ogg', 50, TRUE, ignore_walls = FALSE)
	if(user != target && do_knot_action)
		knot_try()
	if(splashed_user && !splashed_user.sexcon.knotted_status)
		var/status_type = !oral ? /datum/status_effect/facial/internal : /datum/status_effect/facial
		var/datum/status_effect/facial/splashed_type = splashed_user.has_status_effect(status_type)
		if(!splashed_type)
			splashed_user.apply_status_effect(status_type)
		else
			splashed_type.refresh_cum()
	after_ejaculation()
	target.reagents.add_reagent(/datum/reagent/erpjuice/cum, 3)
	if(!oral)
		after_intimate_climax()

/datum/status_effect/facial
	id = "facial"
	alert_type = null // don't show an alert on screen
	tick_interval = 12 MINUTES // use this time as our dry count down
	var/has_dried_up = FALSE // used as our dry status

/datum/status_effect/facial/internal
	id = "creampie"
	alert_type = null // don't show an alert on screen
	tick_interval = 7 MINUTES // use this time as our dry count down

/datum/status_effect/facial/on_apply()
	RegisterSignal(owner, list(COMSIG_COMPONENT_CLEAN_ACT, COMSIG_COMPONENT_CLEAN_FACE_ACT),PROC_REF(clean_up))
	has_dried_up = FALSE
	return ..()

/datum/status_effect/facial/on_remove()
	UnregisterSignal(owner, list(COMSIG_COMPONENT_CLEAN_ACT, COMSIG_COMPONENT_CLEAN_FACE_ACT))
	return ..()

/datum/status_effect/facial/tick()
	has_dried_up = TRUE

/datum/status_effect/facial/proc/refresh_cum()
	has_dried_up = FALSE
	tick_interval = world.time + initial(tick_interval)

///Callback to remove pearl necklace
/datum/status_effect/facial/proc/clean_up(datum/source, strength)
	if(strength >= CLEAN_WEAK && !QDELETED(owner))
		if(!owner.has_stress_event(/datum/stressevent/bathcleaned))
			to_chat(owner, span_notice("I feel much cleaner now!"))
			owner.add_stress(/datum/stressevent/bathcleaned)
		owner.remove_status_effect(src)

/datum/sex_controller/proc/ejaculate()
	log_combat(user, user, "Кончает!")
	user.visible_message(span_lovebold("[user.name] пачкает все вокруг своими выделениями!"))
	playsound(user, 'sound/misc/mat/endout.ogg', 50, TRUE, ignore_walls = FALSE)
	add_cum_floor(get_turf(user))
	after_ejaculation()

/datum/sex_controller/proc/after_ejaculation()
	set_arousal(40)
	adjust_charge(-CHARGE_FOR_CLIMAX)
	if(user.has_flaw(/datum/charflaw/addiction/lovefiend))
		user.sate_addiction()
	user.add_stress(/datum/stressevent/cumok)
	user.emote("sexmoanhvy", forced = TRUE)
	user.playsound_local(user, 'sound/misc/mat/end.ogg', 100)
	last_ejaculation_time = world.time
	record_round_statistic(STATS_PLEASURES)

/datum/sex_controller/proc/after_intimate_climax()
	if(user == target)
		return
	if(HAS_TRAIT(target, TRAIT_GOODLOVER))
		if(!user.mob_timers["cumtri"])
			user.mob_timers["cumtri"] = world.time
			user.adjust_triumphs(1)
			to_chat(user, span_love("Наша любовь - истинный ТРИУМФ!"))
			user.add_stress(/datum/stressevent/cumgood)
			user.apply_status_effect(/datum/status_effect/buff/goodloving)
	if(HAS_TRAIT(user, TRAIT_GOODLOVER))
		if(!target.mob_timers["cumtri"])
			target.mob_timers["cumtri"] = world.time
			target.adjust_triumphs(1)
			to_chat(user, span_love("Наша любовь - истинный ТРИУМФ!"))
			target.add_stress(/datum/stressevent/cumgood)
			target.apply_status_effect(/datum/status_effect/buff/goodloving)

/datum/sex_controller/proc/just_ejaculated()
	return (last_ejaculation_time + 2 SECONDS >= world.time)

/datum/sex_controller/proc/set_charge(amount)
	var/empty = (charge < CHARGE_FOR_CLIMAX)
	charge = clamp(amount, 0, SEX_MAX_CHARGE)
	var/after_empty = (charge < CHARGE_FOR_CLIMAX)
	if(empty && !after_empty)
		to_chat(user, span_notice("I feel like I'm not so spent anymore"))
	if(!empty && after_empty)
		to_chat(user, span_notice("I'm spent!"))

/datum/sex_controller/proc/adjust_charge(amount)
	set_charge(charge + amount)

/datum/sex_controller/proc/handle_charge(dt)
	if(user.has_flaw(/datum/charflaw/addiction/lovefiend))
		dt *= 2
	adjust_charge(dt * CHARGE_RECHARGE_RATE)
	if(is_spent())
		if(arousal > 60)
			to_chat(user, span_warning("I'm too spent!"))
			adjust_arousal(-20)
		adjust_arousal(-dt * SPENT_AROUSAL_RATE)

/datum/sex_controller/proc/set_arousal(amount)
	if(amount > arousal)
		last_arousal_increase_time = world.time
	arousal = clamp(amount, 0, MAX_AROUSAL)
	update_pink_screen()
	update_blueballs()
	update_erect_state()

/datum/sex_controller/proc/update_erect_state()
	var/obj/item/organ/penis/penis = user.getorganslot(ORGAN_SLOT_PENIS)

	if(user.mind)
		var/datum/antagonist/werewolf/W = user.mind.has_antag_datum(/datum/antagonist/werewolf/)
		if(W && W.transformed == TRUE)
			user.regenerate_icons()

	if(penis && hascall(penis, "update_erect_state"))
		penis.update_erect_state()

/datum/sex_controller/proc/adjust_arousal(amount)
	if(aphrodisiac > 1 && amount > 0)
		set_arousal(arousal + (amount * aphrodisiac))
	else set_arousal(arousal + amount)

/datum/sex_controller/proc/perform_deepthroat_oxyloss(mob/living/carbon/human/action_target, oxyloss_amt)
	var/oxyloss_multiplier = 0
	switch(force)
		if(SEX_FORCE_LOW)
			oxyloss_multiplier = 0
		if(SEX_FORCE_MID)
			oxyloss_multiplier = 0
		if(SEX_FORCE_HIGH)
			oxyloss_multiplier = 1.0
		if(SEX_FORCE_EXTREME)
			oxyloss_multiplier = 2.0
	oxyloss_amt *= oxyloss_multiplier
	if(oxyloss_amt <= 0)
		return
	action_target.adjustOxyLoss(oxyloss_amt)

/datum/sex_controller/proc/perform_sex_action(mob/living/carbon/human/action_target, arousal_amt, pain_amt, giving)
	action_target.sexcon.receive_sex_action(arousal_amt, pain_amt, giving, force, speed)

/datum/sex_controller/proc/receive_sex_action(arousal_amt, pain_amt, giving, applied_force, applied_speed)
	arousal_amt *= get_force_pleasure_multiplier(applied_force, giving)
	pain_amt *= get_force_pain_multiplier(applied_force)
	pain_amt *= get_speed_pain_multiplier(applied_speed)

	if(user.stat == DEAD)
		arousal_amt = 0
		pain_amt = 0

	if(!arousal_frozen)
		adjust_arousal(arousal_amt)

	damage_from_pain(pain_amt)
	try_do_moan(arousal_amt, pain_amt, applied_force, giving)
	try_do_pain_effect(pain_amt, giving)

/datum/sex_controller/proc/damage_from_pain(pain_amt)
	if(pain_amt < PAIN_MINIMUM_FOR_DAMAGE)
		return
	var/damage = (pain_amt / PAIN_DAMAGE_DIVISOR)
	var/obj/item/bodypart/part = user.get_bodypart(BODY_ZONE_CHEST)
	if(!part)
		return
	user.apply_damage(damage, BRUTE, part)

/datum/sex_controller/proc/try_do_moan(arousal_amt, pain_amt, applied_force, giving)
	if(arousal_amt < 1.5)
		return
	if(user.stat != CONSCIOUS)
		return
	if(last_moan + MOAN_COOLDOWN >= world.time)
		return
	if(prob(50))
		return
	var/chosen_emote
	switch(arousal_amt)
		if(0 to 5)
			chosen_emote = "sexmoanlight"
		if(5 to INFINITY)
			chosen_emote = "sexmoanhvy"

	if(pain_amt >= PAIN_MILD_EFFECT)
		if(giving)
			if(prob(30))
				chosen_emote = "groan"
		else
			if(prob(40))
				chosen_emote = "painmoan"
	if(pain_amt >= PAIN_MED_EFFECT)
		if(giving)
			if(prob(50))
				chosen_emote = "groan"
		else
			if(prob(60))
				chosen_emote = "painmoan"

	last_moan = world.time
	user.emote(chosen_emote, forced = TRUE)

/datum/sex_controller/proc/try_do_pain_effect(pain_amt, giving)
	if(pain_amt < PAIN_MILD_EFFECT)
		return
	if(last_pain + PAIN_COOLDOWN >= world.time)
		return
	if(prob(50))
		return
	last_pain = world.time
	if(pain_amt >= PAIN_HIGH_EFFECT)
		var/pain_msg = pick(list("БОЛЬНО!!!", "Я ХОЧУ ПРЕКРАТИТЬ!!!", "Я БОЛЬШЕ НЕ МОГУ!!!"))
		to_chat(user, span_boldwarning(pain_msg))
		user.flash_fullscreen("redflash2")
		if(prob(70) && user.stat == CONSCIOUS)
			user.visible_message(span_warning("[user] корчится в муках боли!"))
	else if(pain_amt >= PAIN_MED_EFFECT)
		var/pain_msg = pick(list("Больно!", "Мне больно!"))
		to_chat(user, span_boldwarning(pain_msg))
		user.flash_fullscreen("redflash1")
		if(prob(40) && user.stat == CONSCIOUS)
			user.visible_message(span_warning("[user] болезненно содрогается!"))
	else
		var/pain_msg = pick(list("Больновато...", "Слегка жжется болью...", "Все побаливает..."))
		to_chat(user, span_warning(pain_msg))

/datum/sex_controller/proc/update_blueballs()
	if(arousal >= BLUEBALLS_GAIN_THRESHOLD)
		user.add_stress(/datum/stressevent/blueb)
	else if (arousal <= BLUEBALLS_LOOSE_THRESHOLD)
		user.remove_stress(/datum/stressevent/blueb)

/datum/sex_controller/proc/check_active_ejaculation()
	if(arousal < ACTIVE_EJAC_THRESHOLD)
		return FALSE
	if(is_spent())
		return FALSE
	if(!can_ejaculate())
		return FALSE
	return TRUE

/datum/sex_controller/proc/can_ejaculate()
	if(!user.getorganslot(ORGAN_SLOT_TESTICLES) && !user.getorganslot(ORGAN_SLOT_VAGINA))
		return FALSE
	if(HAS_TRAIT(user, TRAIT_LIMPDICK))
		return FALSE
	return TRUE

/datum/sex_controller/proc/handle_passive_ejaculation(var/mob/living/carbon/human/splashed_user = null)
	var/mob/living/carbon/human/M = user
	if(aphrodisiac > 1.5)
		if(M.check_handholding())
			if(prob(5)) //Yeah.
				try_do_moan(3, 0, 1, 0)
			if(arousal < 70)
				adjust_arousal(0.2)
		if(M.handcuffed)
			if(prob(8))
				var/chaffepain = pick(10,10,10,10,20,20,30)
				try_do_moan(3, chaffepain, 1, 0)
				damage_from_pain(chaffepain)
				try_do_pain_effect(chaffepain)
				last_moan = 0
				M.visible_message(("<span class='love_mid'>[M] squirms uncomfortably in [M.p_their()] restraints.</span>"), \
					("<span class='love_extreme'>I feel [M.handcuffed] rub uncomfortably against my skin.</span>"))
			if(arousal < ACTIVE_EJAC_THRESHOLD)
				adjust_arousal(0.25)
			else
				if(prob(3))
					ejaculate()
					if(splashed_user)
						var/datum/status_effect/facial/facial = splashed_user.has_status_effect(/datum/status_effect/facial)
						if(!facial)
							splashed_user.apply_status_effect(/datum/status_effect/facial)
						else
							facial.refresh_cum()
	if(arousal < PASSIVE_EJAC_THRESHOLD)
		return
	if(is_spent())
		return
	if(!can_ejaculate())
		return FALSE
	ejaculate()
	if(splashed_user)
		var/datum/status_effect/facial/facial = splashed_user.has_status_effect(/datum/status_effect/facial)
		if(!facial)
			splashed_user.apply_status_effect(/datum/status_effect/facial)
		else
			facial.refresh_cum()

/datum/sex_controller/proc/can_use_penis()
	if(HAS_TRAIT(user, TRAIT_LIMPDICK))
		return FALSE
	var/obj/item/organ/penis/penor = user.getorganslot(ORGAN_SLOT_PENIS)
	if(!penor)
		return FALSE
	if(!penor.functional)
		return FALSE
	return TRUE

/datum/sex_controller/proc/considered_limp()
	if(arousal >= AROUSAL_HARD_ON_THRESHOLD)
		return FALSE
	return TRUE

/datum/sex_controller/proc/process_sexcon(dt)
	handle_arousal_unhorny(dt)
	handle_charge(dt)
	handle_passive_ejaculation()

/datum/sex_controller/proc/handle_arousal_unhorny(dt)
	if(arousal_frozen)
		return
	if(!can_ejaculate())
		adjust_arousal(-dt * IMPOTENT_AROUSAL_LOSS_RATE)
	if(last_arousal_increase_time + AROUSAL_TIME_TO_UNHORNY >= world.time)
		return
	var/rate
	switch(arousal)
		if(-INFINITY to 25)
			rate = AROUSAL_LOW_UNHORNY_RATE
		if(25 to 40)
			rate = AROUSAL_MID_UNHORNY_RATE
		if(40 to INFINITY)
			rate = AROUSAL_HIGH_UNHORNY_RATE
	adjust_arousal(-dt * rate)

/datum/sex_controller/proc/show_ui()
	var/list/dat = list()
	var/force_name = get_force_string()
	var/speed_name = get_speed_string()
	var/manual_arousal_name = get_manual_arousal_string()
	dat += "<center><a href='?src=[REF(src)];task=speed_down'>\<</a> [speed_name] <a href='?src=[REF(src)];task=speed_up'>\></a> ~|~ <a href='?src=[REF(src)];task=force_down'>\<</a> [force_name] <a href='?src=[REF(src)];task=force_up'>\></a>"
	if(user.getorganslot(ORGAN_SLOT_PENIS))
		dat += " ~|~ <a href='?src=[REF(src)];task=manual_arousal_down'>\<</a> [manual_arousal_name] <a href='?src=[REF(src)];task=manual_arousal_up'>\></a>"
	dat += "</center><center><a href='?src=[REF(src)];task=toggle_finished'>[do_until_finished ? "ПОКА НЕ КОНЧУ" : "ПОКА НЕ ОСТАНОВЛЮСЬ"]</a>"
	if(current_action && !desire_stop)
		var/datum/sex_action/action = SEX_ACTION(current_action)
		if(action.knot_on_finish && knot_penis_type())
			if(do_knot_action)
				dat += " | <a href='?src=[REF(src)];task=toggle_knot'><font color='#d146f5'>ИСПОЛЬЗОВАТЬ УЗЕЛ</font></a>"
			else
				dat += " | <a href='?src=[REF(src)];task=toggle_knot'><font color='#eac8de'>НЕ ИСПОЛЬЗОВАТЬ УЗЕЛ</font></a>"
	dat += "</center><center><a href='?src=[REF(src)];task=set_arousal'>ЗАДАТЬ ВОЗБУЖДЕНИЕ</a> | <a href='?src=[REF(src)];task=freeze_arousal'>[arousal_frozen ? "ВОЗБУЖДАТЬСЯ" : "НЕ ВОЗБУЖДАТЬСЯ"]</a></center>"
	if(target == user)
		dat += "<center>Самоудовлетворение</center>"
	else
		dat += "<center>Соитие с [target]</center>"
	if(current_action && !desire_stop)
		dat += "<center><a href='?src=[REF(src)];task=stop'>Прекратить</a></center>"
	else
		dat += "<br>"
	dat += "<center><a href='?src=[REF(src)];task=category_hands'>[action_category == SEX_CATEGORY_HANDS ? "<font color='#eac8de'>РУКИ</font>" : "РУКИ"]</a> | "
	dat += "<a href='?src=[REF(src)];task=category_penetrate'>[action_category == SEX_CATEGORY_PENETRATE ? "<font color='#eac8de'>ПРОНИКНОВЕНИЕ</font>" : "ПРОНИКНОВЕНИЕ"]</a> | "
	dat += "<a href='?src=[REF(src)];task=category_misc'>[action_category == SEX_CATEGORY_MISC ? "<font color='#eac8de'>ОСТАЛЬНОЕ</font>" : "ОСТАЛЬНОЕ"]</a></center>"
	dat += "<table width='100%'><td width='50%'></td><td width='50%'></td><tr>"
	var/i = 0
	var/user_is_incapacitated = user.incapacitated()
	user.sexcon.update_all_accessible_body_zones()
	if(target != user)
		target.sexcon.update_all_accessible_body_zones()
	for(var/action_type in GLOB.sex_actions)
		var/datum/sex_action/action = SEX_ACTION(action_type)
		if(!(action_category&action.category))
			continue
		if(!action.shows_on_menu(user, target))
			continue
		dat += "<td>"
		var/link = ""
		if(!can_perform_action(action_type, user_is_incapacitated))
			link = "linkOff"
		if(current_action == action_type)
			link = "linkOn"
		dat += "<center><a class='[link]' href='?src=[REF(src)];task=action;action_type=[action_type]'>[action.name]</a></center>"
		dat += "</td>"
		i++
		if(i >= 2)
			i = 0
			dat += "</tr><tr>"

	dat += "</tr></table>"
	var/datum/browser/popup = new(user, "sexcon", "<center>Утолить желания</center>", 500, 550)
	popup.set_content(dat.Join())
	popup.open()
	return

/datum/sex_controller/Topic(href, href_list)
	if(usr != user)
		return
	switch(href_list["task"])
		if("action")
			var/action_path = text2path(href_list["action_type"])
			var/datum/sex_action/action = SEX_ACTION(action_path)
			if(!action)
				return
			try_start_action(action_path)
		if("stop")
			try_stop_current_action()
		if("speed_up")
			adjust_speed(1)
		if("speed_down")
			adjust_speed(-1)
		if("force_up")
			adjust_force(1)
		if("force_down")
			adjust_force(-1)
		if("manual_arousal_up")
			adjust_arousal_manual(1)
		if("manual_arousal_down")
			adjust_arousal_manual(-1)
		if("toggle_finished")
			do_until_finished = !do_until_finished
		if("set_arousal")
			var/amount = input(user, "Значение выше 120 приведет к немедленному экстазу!", "Задать возбуждение", arousal) as num
			if(aphrodisiac > 1 && amount > 0)
				set_arousal(amount * aphrodisiac)
			else
				set_arousal(amount)
		if("freeze_arousal")
			if(aphrodisiac == 1)
				arousal_frozen = !arousal_frozen
		if("category_misc")
			action_category = SEX_CATEGORY_MISC
		if("category_hands")
			action_category = SEX_CATEGORY_HANDS
		if("category_penetrate")
			action_category = SEX_CATEGORY_PENETRATE
		if("toggle_knot")
			do_knot_action = !do_knot_action
	show_ui()

/datum/sex_controller/proc/try_stop_current_action()
	if(!current_action)
		return
	desire_stop = TRUE
	user.doing = FALSE

/datum/sex_controller/proc/stop_current_action()
	if(!current_action)
		return
	var/datum/sex_action/action = SEX_ACTION(current_action)
	if(!user.sexcon.knotted_status) // never show the remove message, unless unknotted
		action.on_finish(user, target)
	desire_stop = FALSE
	user.doing = FALSE
	current_action = null
	using_zones = list()

/datum/sex_controller/proc/try_start_action(action_type)
	if(action_type == current_action)
		try_stop_current_action()
		return
	if(current_action != null)
		try_stop_current_action()
		return
	if(!action_type)
		return
	if(!can_perform_action(action_type, user.incapacitated()))
		return
	knot_check_remove(action_type)
	// Set vars
	desire_stop = FALSE
	current_action = action_type
	var/datum/sex_action/action = SEX_ACTION(current_action)
	log_combat(user, target, "Started sex action: [action.name]")
	INVOKE_ASYNC(src, PROC_REF(sex_action_loop))

/datum/sex_controller/proc/sex_action_loop()
	// Do action loop
	var/performed_action_type = current_action
	var/datum/sex_action/action = SEX_ACTION(current_action)
	show_progress = 1
	action.on_start(user, target)
	while(TRUE)
		if(!isnull(target.client) && target.client.prefs.sexable == FALSE) //Vrell - Needs changed to let me test sex mechanics solo
			break
		if(!user.stamina_add(action.stamina_cost * get_stamina_cost_multiplier()))
			break
		if(!do_after(user, (action.do_time / get_speed_multiplier()), target = target, progress = show_progress))
			break
		if(current_action == null || performed_action_type != current_action)
			break
		if(!can_perform_action(current_action, user.incapacitated()))
			break
		if(action.is_finished(user, target))
			break
		if(desire_stop)
			break
		action.on_perform(user, target)
		// It could want to finish afterwards the performed action
		if(action.is_finished(user, target))
			break
		if(!action.continous)
			break
	stop_current_action()

/datum/sex_controller/proc/can_perform_action(action_type, incapacitated)
	if(!action_type)
		return FALSE
	var/datum/sex_action/action = SEX_ACTION(action_type)
	if(!inherent_perform_check(action_type, incapacitated))
		return FALSE
	if(!action.can_perform(user, target))
		return FALSE
	return TRUE

/datum/sex_controller/proc/inherent_perform_check(action_type, incapacitated)
	var/datum/sex_action/action = SEX_ACTION(action_type)
	if(!target)
		return FALSE
	if(user.stat != CONSCIOUS)
		return FALSE
	if(action.check_incapacitated && incapacitated)
		return FALSE
	return TRUE

/*
/datum/sex_controller/proc/remove_from_target_receiving()
	if(!target)
		return
	var/datum/sex_controller/target_con = target.sexcon
	if (user in target_con.receiving)
		target_con.receiving -= user
*/

/datum/sex_controller/proc/set_target(mob/living/carbon/human/new_target)
	//remove_from_target_receiving()
	target = new_target
	//var/datum/sex_controller/target_con = new_target.sexcon
	//target_con.receiving += user

/datum/sex_controller/proc/get_speed_multiplier()
	switch(speed)
		if(SEX_SPEED_LOW)
			return 1.0
		if(SEX_SPEED_MID)
			return 1.5
		if(SEX_SPEED_HIGH)
			return 2.0
		if(SEX_SPEED_EXTREME)
			return 2.5

/datum/sex_controller/proc/get_stamina_cost_multiplier()
	switch(force)
		if(SEX_FORCE_LOW)
			return 1.0
		if(SEX_FORCE_MID)
			return 1.5
		if(SEX_FORCE_HIGH)
			return 2.0
		if(SEX_SPEED_EXTREME)
			return 2.5

/datum/sex_controller/proc/get_force_pleasure_multiplier(passed_force, giving)
	switch(passed_force)
		if(SEX_FORCE_LOW)
			if(giving)
				return 0.8
			else
				return 0.8
		if(SEX_FORCE_MID)
			if(giving)
				return 1.2
			else
				return 1.2
		if(SEX_FORCE_HIGH)
			if(giving)
				return 1.6
			else
				return 1.2
		if(SEX_FORCE_EXTREME)
			if(giving)
				return 2.0
			else
				return 0.8

/datum/sex_controller/proc/get_force_pain_multiplier(passed_force)
	switch(passed_force)
		if(SEX_FORCE_LOW)
			return 0.5
		if(SEX_FORCE_MID)
			return 1.0
		if(SEX_FORCE_HIGH)
			return 2.0
		if(SEX_FORCE_EXTREME)
			return 3.0

/datum/sex_controller/proc/get_speed_pain_multiplier(passed_speed)
	switch(passed_speed)
		if(SEX_SPEED_LOW)
			return 0.8
		if(SEX_SPEED_MID)
			return 1.0
		if(SEX_SPEED_HIGH)
			return 1.2
		if(SEX_SPEED_EXTREME)
			return 1.4

/datum/sex_controller/proc/get_force_string()
	switch(force)
		if(SEX_FORCE_LOW)
			return "<font color='#eac8de'>НЕЖНО</font>"
		if(SEX_FORCE_MID)
			return "<font color='#e9a8d1'>НАСТОЙЧИВО</font>"
		if(SEX_FORCE_HIGH)
			return "<font color='#f05ee1'>ГРУБО</font>"
		if(SEX_FORCE_EXTREME)
			return "<font color='#d146f5'>ЖЕСТОКО</font>"

/datum/sex_controller/proc/get_speed_string()
	switch(speed)
		if(SEX_SPEED_LOW)
			return "<font color='#eac8de'>МЕДЛЕННО</font>"
		if(SEX_SPEED_MID)
			return "<font color='#e9a8d1'>ПОСТЕПЕННО</font>"
		if(SEX_SPEED_HIGH)
			return "<font color='#f05ee1'>БЫСТРО</font>"
		if(SEX_SPEED_EXTREME)
			return "<font color='#d146f5'>НЕУМОЛИМО</font>"

/datum/sex_controller/proc/get_manual_arousal_string()
	switch(manual_arousal)
		if(SEX_MANUAL_AROUSAL_DEFAULT)
			return "<font color='#eac8de'>ПЕРЕМЕННАЯ ЭРЕКЦИЯ</font>" // влияет на спрайт
		if(SEX_MANUAL_AROUSAL_UNAROUSED)
			return "<font color='#e9a8d1'>СЛАБАЯ ЭРЕКЦИЯ</font>"
		if(SEX_MANUAL_AROUSAL_PARTIAL)
			return "<font color='#f05ee1'>НОРМАЛЬНАЯ ЭРЕКЦИЯ</font>"
		if(SEX_MANUAL_AROUSAL_FULL)
			return "<font color='#d146f5'>СИЛЬНАЯ ЭРЕКЦИЯ</font>"

/datum/sex_controller/proc/get_generic_force_adjective()
	switch(force)
		if(SEX_FORCE_LOW)
			return pick(list("нежно", "заботливо", "ласково", "мягко", "осторожно", "неторопливо"))
		if(SEX_FORCE_MID)
			return pick(list("решительно", "энергично", "страстно", "уверенно", "увлеченно"))
		if(SEX_FORCE_HIGH)
			return pick(list("грубо", "небрежно", "жестко", "пылко", "свирепо"))
		if(SEX_FORCE_EXTREME)
			return pick(list("жестоко", "неистово", "неумолимо", "свирепо", "безжалостно"))

/datum/sex_controller/proc/spanify_force(string)
	switch(force)
		if(SEX_FORCE_LOW)
			return "<span class='love_low'>[string]</span>"
		if(SEX_FORCE_MID)
			return "<span class='love_mid'>[string]</span>"
		if(SEX_FORCE_HIGH)
			return "<span class='love_high'>[string]</span>"
		if(SEX_FORCE_EXTREME)
			return "<span class='love_extreme'>[string]</span>"

/datum/sex_controller/proc/can_zodomize()
	//Only thing we're currently checking for.
	var/obj/item/organ/vagina/vag = user.getorganslot(ORGAN_SLOT_VAGINA)
	if(vag && vag.monohole)
		return FALSE
	if(user.construct && !user.getorganslot(ORGAN_SLOT_VAGINA) && !user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

#undef SEX_ZONE_NULL
#undef SEX_ZONE_GROIN
#undef SEX_ZONE_GROIN_GRAB
#undef SEX_ZONE_L_FOOT
#undef SEX_ZONE_R_FOOT
#undef SEX_ZONE_MOUTH
#undef SEX_ZONE_CHEST
#undef SEX_ZONE_CHEST_GRAB
