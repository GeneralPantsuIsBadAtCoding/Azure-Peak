/datum/rmb_intent
	var/name = "intent"
	var/desc = ""
	var/icon_state = ""
	/// Whether this intent requires user to be adjacent to their target or not
	var/adjacency = TRUE
	/// Determines whether this intent can be used during click cd
	var/bypasses_click_cd = FALSE

/mob/living/carbon/human/on_cmode()
	if(!cmode)	//We just toggled it off.
		addtimer(CALLBACK(src, PROC_REF(purge_bait)), 30 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)
		addtimer(CALLBACK(src, PROC_REF(expire_peel)), 60 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)
	if(!HAS_TRAIT(src, TRAIT_DECEIVING_MEEKNESS))
		filtered_balloon_alert(TRAIT_COMBAT_AWARE, (cmode ? ("<i><font color = '#831414'>Tense</font></i>") : ("<i><font color = '#c7c6c6'>Relaxed</font></i>")), y_offset = 32)

/datum/rmb_intent/proc/special_attack(mob/living/user, atom/target)
	return

/datum/rmb_intent/aimed
	name = "aimed"
	desc = "Your attacks are more precise but have a longer recovery time. Higher critrate with precise attacks.\n(TIP HERE FOR AIMED RCLICK)."
	icon_state = "rmbaimed"
	adjacency = FALSE
	bypasses_click_cd = FALSE

/datum/rmb_intent/aimed/special_attack(mob/living/user, atom/target)
	if(user.has_status_effect(/datum/status_effect/debuff/strikecd))
		return
	if(!user)
		return
	if(user.incapacitated())
		return
	if(!ishuman(user))
		return
	if(!user.get_active_held_item()) //Nothing in our hand to strike with.
		return 
	if(!user.cmode)
		return
	if(user.has_status_effect(/datum/status_effect/buff/clash) || user.has_status_effect(/datum/status_effect/buff/clash/limbguard))	//No stacking these!
		return
	
	user.apply_status_effect(/datum/status_effect/buff/precise_strike)

/datum/rmb_intent/strong
	name = "strong"
	desc = "Your attacks have +1 strength but use more stamina. Higher critrate with brutal attacks. Intentionally fails surgery steps."
	icon_state = "rmbstrong"
	adjacency = FALSE

/datum/rmb_intent/strong/special_attack(mob/living/user, atom/target)
	var/obj/item/rogueweapon/W = user.get_active_held_item()
	to_chat(world, "[W] is of type [W.type] and special is: [W.special]")
	if(istype(W, /obj/item/rogueweapon) && W.special)
		W.special.deploy(user, W)

/datum/rmb_intent/swift
	name = "swift"
	desc = "Your attacks have less recovery time but are less accurate."
	icon_state = "rmbswift"

/datum/rmb_intent/special
	name = "special"
	desc = "A special attack that depends on the type of weapon you are using."
	icon_state = "rmbspecial"

/datum/rmb_intent/feint
	name = "feint"
	desc = "(RMB WHILE DEFENSE IS ACTIVE) A deceptive half-attack with no follow-through, meant to force your opponent to open their guard. Useless against someone who is dodging."
	icon_state = "rmbfeint"


#define FEINT_INT_DIFF_THRESHOLD 7	
#define FEINT_STATUS_NORMAL	1
#define FEINT_STATUS_STUPIDVSSMART 2	//Set if our INTdiff matches the DIFF_THRESHOLD. Gives the low INT person an advantage, in general.
#define FEINT_STATUS_5HEAD_ONLY	3	//Both people are at 14 or above INT. Makes feint generally unreliable to both.
#define FEINT_STATUS_2HEAD_ONLY 4	//Both people are at <10 INT. Complete chaos.

#define FEINT_STANCE_BONUS -30
#define DEFEND_STANCE_BONUS 20
#define STATUS_CD_BONUS 10

/datum/rmb_intent/feint/special_attack(mob/living/user, atom/target)
	if(!isliving(target))
		return

	var/mob/living/L = target

	if(!user)
		return

	if(user.incapacitated())
		return

	if(!user.mind)
		return

	if(user.has_status_effect(/datum/status_effect/debuff/feintcd))
		return

	if(user.has_status_effect(/datum/status_effect/buff/precise_strike))
		return
	
	if(L.has_status_effect(/datum/status_effect/debuff/exposed))
		to_chat(user, span_info("They're already exposed!"))
		return
	
	var/datum/status_effect/buff/clash/limbguard/lg_target = L.has_status_effect(/datum/status_effect/buff/clash/limbguard)
	var/datum/status_effect/buff/clash/limbguard/lg_user = user.has_status_effect(/datum/status_effect/buff/clash/limbguard)

	//Limbguard Bait interaction, essentially a guaranteed override.
	if(lg_target || lg_user)
		var/user_zone = check_zone(user.zone_selected)
		var/target_zone = check_zone(L.zone_selected)
		var/successful_bait

		if(lg_target?.protected_zone == user_zone)	//We feinted their protected limb.
			apply_limbguard_bait(user, L)
			successful_bait = TRUE
		else if(lg_user?.protected_zone == target_zone)	//We have LG and they were targeting our limb.
			apply_limbguard_bait(user, L)
			successful_bait = TRUE

		if(!successful_bait && lg_user)
			var/mob/living/carbon/human/H = user
			H.bad_guard(span_warning("My bait failed! I lost my focus!"))
			L.play_overhead_indicator_simple('icons/mob/mob_effects.dmi', "eff_feint_fail", 1.5 SECONDS, MOB_EFFECT_LAYER_FEINT, y_offset = 3)
		
		user.apply_status_effect(/datum/status_effect/debuff/feintcd)
		return

	//--Normal Feint starts here--

	var/perc = 0
	var/ourskill
	var/obj/item/I = user.get_active_held_item()
	if(I)
		if(I.associated_skill)
			ourskill = user.get_skill_level(I.associated_skill)

	//We determine the special status of feint, if applicable.
	var/status = FEINT_STATUS_NORMAL
	var/intdiff = abs(user.STAINT - L.STAINT)	//<-- This is the actual key to Feint.
	if(intdiff >= 7 && (user.STAINT < 10 || L.STAINT < 10) && (user.STAINT > 14 || L.STAINT > 14))
		status = FEINT_STATUS_STUPIDVSSMART
	else if(user.STAINT < 10 && L.STAINT < 10)
		status = FEINT_STATUS_2HEAD_ONLY
	else if(user.STAINT >= 14 && L.STAINT >= 14)
		status = FEINT_STATUS_5HEAD_ONLY

	if(!user.mind)	//Let's not goof around with AI, it'll just be annoying.
		status = FEINT_STATUS_NORMAL

	perc += ourskill * 10
	if(!istype(L.rmb_intent, /datum/rmb_intent/feint) && L.mind)
		perc += max((user.STAINT - 10) * 5, 0)	//Prob never -goes down- due to INT diff. 

	//Easier to feint someone on defend intent, harder if they're also aiming to feint.
	if(istype(L.rmb_intent, /datum/rmb_intent/riposte) || !L.mind)
		perc += DEFEND_STANCE_BONUS
	else if(istype(L.rmb_intent, /datum/rmb_intent/feint) && L.mind)
		perc += FEINT_STANCE_BONUS

	//Having used the rclicks increases the chances.
	if(L.has_status_effect(/datum/status_effect/debuff/feintcd))
		perc += STATUS_CD_BONUS
	
	if(L.has_status_effect(/datum/status_effect/debuff/clashcd))
		perc += STATUS_CD_BONUS

	if(L.has_status_effect(/datum/status_effect/debuff/strikecd))
		perc += STATUS_CD_BONUS
	
	perc = CLAMP(perc, 0, 90)

	if(user == target)
		perc = 100

	process_feint(user, L, perc, intdiff, status)

/datum/rmb_intent/feint/proc/apply_limbguard_bait(mob/living/user, mob/living/target)
	to_chat(user, span_notice("[target.p_they(TRUE)] fell for my bait <b>perfectly</b>! They're off-balanced!"))
	to_chat(target, span_danger("I fall for [user.p_their()]'s bait <b>perfectly</b>! I lost my footing!"))
	target.play_overhead_indicator_simple('icons/mob/mob_effects.dmi', "eff_feint_bait", 1.5 SECONDS, MOB_EFFECT_LAYER_FEINT, y_offset = 3)
	target.stamina_add(target.max_stamina / 5)
	target.apply_status_effect(/datum/status_effect/debuff/exposed, 3.5 SECONDS)
	target.emote("gasp")
	target.OffBalance(2.5 SECONDS)
	target.Immobilize(2.5 SECONDS)

///Needlessly over-engineered proc that accommodates the goofy extremes. Primary usecase is going to be "FEINT_STATUS_NORMAL"
/datum/rmb_intent/feint/proc/process_feint(mob/living/user, mob/living/target, perc as num, intdiff as num, status)
	var/vismsg = span_danger("[user] feints an attack at [target]!")
	var/iconpath = 'icons/mob/mob_effects.dmi'
	var/iconstate
	var/dur = 2 SECONDS
	var/success
	var/mob/living/L = target

	if(prob(perc))
		success = TRUE

	//Failure return
	if(!success)
		playsound(user, 'sound/combat/feint.ogg', 100, TRUE)
		if(user.client?.prefs.showrolls)
			to_chat(user, span_warning("[L.p_they(TRUE)] did not fall for my feint... [perc]%"))
		vismsg = span_danger("[user] fails to feint an attack at [target]!")
		iconstate = "eff_feint_fail"
		target.play_overhead_indicator_simple(iconpath, iconstate, dur, MOB_EFFECT_LAYER_FEINT, y_offset = 3)
		user.apply_status_effect(/datum/status_effect/debuff/feintcd)
		user.visible_message(vismsg)
		return

	if(L.has_status_effect(/datum/status_effect/buff/clash))
		L.remove_status_effect(/datum/status_effect/buff/clash)
		to_chat(user, span_notice("[L.p_their(TRUE)] Guard was disrupted!"))


	var/cdmod = 0
	switch(status)
		if(FEINT_STATUS_NORMAL)
			iconstate = "eff_feint_success"
			if(user.STAINT < target.STAINT)
				intdiff = 0
			L.apply_status_effect(/datum/status_effect/debuff/exposed, min((2 + intdiff), 4 SECONDS))
			L.apply_status_effect(/datum/status_effect/debuff/clickcd, min((1 SECONDS + (intdiff * 0.3)), 3 SECONDS))
			if(intdiff >= 3)
				L.Immobilize(1.5 SECONDS)
				if(L.pulling && prob(intdiff * 5))
					L.stop_pulling()
				cdmod += 8 SECONDS
			if(intdiff >= 6)	//Right on the edge of disaster.
				if(L.pulling)
					L.stop_pulling()
				L.Slowdown(4)
				cdmod += 8 SECONDS
		if(FEINT_STATUS_STUPIDVSSMART)	//In essence, this makes feinting a very dumb (relative to user) person harder. The dumb person won't be able to feint them any better, either.
			iconstate = "eff_feint_wtf"
			if(user.STAINT > target.STAINT)	//Smart person feinting a stupid one
				var/silly_outcome = rand(1,5)
				switch(silly_outcome)
					if(1)	//Feints back
						user.visible_message(span_warning("<i>[L] feints back?</i>"))
						process_feint(target, user, perc, intdiff, status)
					if(2)	//Doesn't understand there was a feint at all (ignores it)
						vismsg = span_info("<i>[L] doesn't seem to acknowledge there was a feint at all?</i>")
						L.emote("huh")
						if(L.pulling)
							L.stop_pulling()
					if(3)	//Mutual feint
						user.visible_message(span_warning("<i>[L] feint back in perfect sync! A savant! They're both feinted!</i>"))
						L.apply_status_effect(/datum/status_effect/debuff/exposed, 2.5 SECONDS)
						L.apply_status_effect(/datum/status_effect/debuff/clickcd, 1.5 SECONDS)
						L.apply_status_effect(/datum/status_effect/debuff/feintcd, (15 SECONDS + cdmod))

						user.apply_status_effect(/datum/status_effect/debuff/exposed, 2.5 SECONDS)
						user.apply_status_effect(/datum/status_effect/debuff/clickcd, 1.5 SECONDS)
						user.apply_status_effect(/datum/status_effect/debuff/feintcd, (15 SECONDS + cdmod))
						return
					if(4)	//Gets knocked down
						vismsg = span_warning("<i>[L] gets scared and falls over!</i>")
						L.Knockdown(1 SECONDS)
						if(L.pulling)
							L.stop_pulling()
					if(5)	//A normal feint that goes through without any bells or whistles
						L.apply_status_effect(/datum/status_effect/debuff/exposed, 2.5 SECONDS)
						L.apply_status_effect(/datum/status_effect/debuff/clickcd, 1.5 SECONDS)
			else
				if(prob((user.STALUC - 10) * 10))
					L.apply_status_effect(/datum/status_effect/debuff/exposed, 2.5 SECONDS)
					L.apply_status_effect(/datum/status_effect/debuff/clickcd, 1.5 SECONDS)
			playsound(user, 'sound/combat/weird_feint.ogg', 100, TRUE)
		if(FEINT_STATUS_5HEAD_ONLY, FEINT_STATUS_2HEAD_ONLY)	//Mostly for humor. The thresholds may be too low for this to be a very "exclusive" experience, however.
			iconstate = "eff_feint_wtf"
			intdiff += rand(0, 1)
			var/mob/living/last_to_feint = L
			var/mob/living/next_to_feint = user
			for(var/i in 1 to intdiff)
				var/counter_count
				for(var/j in 1 to i)
					counter_count += "counter-"
				user.visible_message(span_warning("<i>[last_to_feint] [counter_count]feints!</i>"))
				if(prob(i * 10))
					user.visible_message(span_warning("<i>[next_to_feint] gives up!</i>"))
					break
				if(i < intdiff)
					var/ref_holder = next_to_feint
					next_to_feint = last_to_feint
					last_to_feint = ref_holder
			next_to_feint.apply_status_effect(/datum/status_effect/debuff/clickcd, 1.5 SECONDS)
			next_to_feint.apply_status_effect(/datum/status_effect/debuff/feintcd, (15 SECONDS + cdmod))
			vismsg = span_danger("[last_to_feint] feints an attack at [next_to_feint]!")
			playsound(user, 'sound/combat/weird_feint.ogg', 100, TRUE)

	user.apply_status_effect(/datum/status_effect/debuff/feintcd, (15 SECONDS + cdmod))
	user.visible_message(vismsg)
	L.play_overhead_indicator_simple(iconpath, iconstate, dur, MOB_EFFECT_LAYER_FEINT, y_offset = 3)
	playsound(user, 'sound/combat/riposte.ogg', 100, TRUE)

/datum/rmb_intent/riposte
	name = "defend"
	desc = "No delay between dodge and parry rolls.\n(RMB WHILE NOT GRABBING ANYTHING AND HOLDING A WEAPON)\nEnter a defensive stance, guaranteeing the next hit is defended against.\nTwo people who hit each other with the Guard up will have their weapons Clash, potentially disarming them.\nLetting it expire or hitting someone with it who has no Guard up is tiresome."
	icon_state = "rmbdef"
	adjacency = FALSE
	bypasses_click_cd = TRUE

/datum/rmb_intent/riposte/special_attack(mob/living/user, atom/target)

	//First thing we check is if we already have Limbguard on, to toggle it off.
	var/datum/status_effect/buff/clash/limbguard/LG = user.has_status_effect(/datum/status_effect/buff/clash/limbguard)
	if(LG)
		LG.remove_self()
		return

	if(!user.has_status_effect(/datum/status_effect/buff/clash) && !user.has_status_effect(/datum/status_effect/debuff/clashcd) && !user.has_status_effect(/datum/status_effect/buff/clash/limbguard))
		if(!user.get_active_held_item()) //Nothing in our hand to Guard with.
			return 
		if(user.r_grab || user.l_grab || length(user.grabbedby)) //Not usable while grabs are in play.
			return
		if(!(user.mobility_flags & MOBILITY_STAND) || user.IsImmobilized() || user.IsOffBalanced()) //Not usable while we're offbalanced, immobilized or on the ground.
			return
		if(user.m_intent == MOVE_INTENT_RUN)
			to_chat(user, span_warning("I can't focus on this while running."))
			return
		if(user.magearmor == FALSE && HAS_TRAIT(user, TRAIT_MAGEARMOR))	//The magearmor is ACTIVE, so we can't Guard. (Yes, it's active while FALSE / 0.)
			to_chat(user, span_warning("I'm already focusing on my mage armor!"))
			return
		var/zone = check_zone(user.zone_selected)
		if(zone == BODY_ZONE_CHEST)
			user.apply_status_effect(/datum/status_effect/buff/clash)
		else
			user.apply_status_effect(/datum/status_effect/buff/clash/limbguard, zone)

/datum/rmb_intent/guard
	name = "guarde"
	desc = "(RMB WHILE DEFENSE IS ACTIVE) Raise your weapon, ready to attack any creature who moves onto the space you are guarding."
	icon_state = "rmbguard"

/datum/rmb_intent/weak
	name = "weak"
	desc = "Your attacks have -1 strength and will never critically-hit. Useful for longer punishments, play-fighting, and bloodletting."
	icon_state = "rmbweak"
