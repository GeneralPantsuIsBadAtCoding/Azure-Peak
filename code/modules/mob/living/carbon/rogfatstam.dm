/mob/living/proc/update_rogfat() //update hud and regen after last_fatigued delay on taking
	maxrogfat = maxrogstam / 10

	if(world.time > last_fatigued + 20) //regen fatigue
		var/added = rogstam / maxrogstam
		added = round(-10+ (added*-40))
		if(HAS_TRAIT(src, TRAIT_MISSING_NOSE))
			added = round(added * 0.5, 1)
		if(rogfat >= 1)
			rogfat_add(added)
		else
			rogfat = 0

	update_health_hud()

/mob/living/proc/update_rogstam()
	var/athletics_skill = 0
	if(mind)
		athletics_skill = mind.get_skill_level(/datum/skill/misc/athletics)
	maxrogstam = (STAEND + (athletics_skill/2 ) ) * 100
	if(cmode)
		if(!HAS_TRAIT(src, TRAIT_BREADY))
			rogstam_add(-2)

/mob/proc/rogstam_add(added as num)
	return

/mob/living/rogstam_add(added as num)
	if(HAS_TRAIT(src, TRAIT_NOROGSTAM))
		return TRUE
	if(HAS_TRAIT(src, TRAIT_NOSLEEP))
		return TRUE
	if(m_intent == MOVE_INTENT_RUN)
		mind.add_sleep_experience(/datum/skill/misc/athletics, (STAINT*0.02))
	rogstam += added
	if(rogstam > maxrogstam)
		rogstam = maxrogstam
		update_health_hud()
		return FALSE
	else
		if(rogstam <= 0)
			rogstam = 0
			if(m_intent == MOVE_INTENT_RUN) //can't sprint at zero stamina
				toggle_rogmove_intent(MOVE_INTENT_WALK)
		update_health_hud()
		return TRUE

/mob/proc/rogfat_add(added as num)
	return TRUE

/mob/living/rogfat_add(added as num, emote_override, force_emote = TRUE) //call update_rogfat here and set last_fatigued, return false when not enough fatigue left
	if(HAS_TRAIT(src, TRAIT_NOROGSTAM))
		return TRUE
	rogfat = CLAMP(rogfat+added, 0, maxrogfat)
	if(added > 0)
		rogstam_add(added * -1)
	if(added >= 5)
		if(rogstam <= 0)
			if(iscarbon(src))
				var/mob/living/carbon/C = src
				if(!HAS_TRAIT(C, TRAIT_NOHUNGER))
					if(C.nutrition <= 0)
						if(C.hydration <= 0)
							C.heart_attack()
							return FALSE
	if(rogfat >= maxrogfat)
		rogfat = maxrogfat
		update_health_hud()
		if(m_intent == MOVE_INTENT_RUN) //can't sprint at full fatigue
			toggle_rogmove_intent(MOVE_INTENT_WALK, TRUE)
		if(!emote_override)
			emote("fatigue", forced = force_emote)
		else
			emote(emote_override, forced = force_emote)
		blur_eyes(2)
		last_fatigued = world.time + 30 //extra time before fatigue regen sets in
		stop_attack()
		changeNext_move(CLICK_CD_EXHAUSTED)
		flash_fullscreen("blackflash")
		if(rogstam <= 0)
			addtimer(CALLBACK(src, PROC_REF(Knockdown), 30), 10)
		addtimer(CALLBACK(src, PROC_REF(Immobilize), 30), 10)
		if(iscarbon(src))
			var/mob/living/carbon/C = src
			if(C.get_stress_amount() >= 30)
				C.heart_attack()
			if(!HAS_TRAIT(C, TRAIT_NOHUNGER))
				if(C.nutrition <= 0)
					if(C.hydration <= 0)
						C.heart_attack()
		return FALSE
	else
		last_fatigued = world.time
		update_health_hud()
		return TRUE
/mob/living/carbon
	var/heart_attacking = FALSE

/mob/living/carbon/proc/heart_attack()
	if(HAS_TRAIT(src, TRAIT_NOROGSTAM))
		return
	if(!heart_attacking)
		var/mob/living/carbon/C = src
		set_heartattack(TRUE) // Using set_heartattack rather than heart_attack(true) since heart_attack doesn't kill you for some reason????
		C.visible_message(C, "<span class='danger'>[C] clutches at [C.p_their()] chest!</span>") // Other people know something is wrong.
		emote("breathgasp", forced = TRUE)
		shake_camera(src, 1, 3)
		blur_eyes(40)
		var/stuffy = list("ZIZO GRABS MY WEARY HEART!","ARGH! MY HEART BEATS NO MORE!","NO... MY HEART HAS BEAT IT'S LAST!","MY HEART HAS GIVEN UP!","MY HEART BETRAYS ME!","THE METRONOME OF MY LIFE STILLS!")
		to_chat(src, "<span class='userdanger'>[pick(stuffy)]</span>")
		// addtimer(CALLBACK(src, PROC_REF(adjustOxyLoss), 110), 30) This was commented out because the heart attack already kills, why put people into oxy crit instantly?

/mob/living/proc/freak_out()
	return

/mob/proc/do_freakout_scream()
	emote("scream", forced=TRUE)

/mob/living/carbon/freak_out() // currently solely used for vampire snowflake stuff
	if(mob_timers["freakout"])
		if(world.time < mob_timers["freakout"] + 10 SECONDS)
			flash_fullscreen("stressflash")
			return
	mob_timers["freakout"] = world.time
	shake_camera(src, 1, 3)
	flash_fullscreen("stressflash")
	changeNext_move(CLICK_CD_EXHAUSTED)
	add_stress(/datum/stressevent/freakout)
	emote("fatigue", forced = TRUE)
	if(hud_used)
		var/matrix/skew = matrix()
		skew.Scale(2)
		var/matrix/newmatrix = skew
		for(var/C in hud_used.plane_masters)
			var/atom/movable/screen/plane_master/whole_screen = hud_used.plane_masters[C]
			if(whole_screen.plane == HUD_PLANE)
				continue
			animate(whole_screen, transform = newmatrix, time = 1, easing = QUAD_EASING)
			animate(transform = -newmatrix, time = 30, easing = QUAD_EASING)

/mob/living/proc/rogfat_reset()
	rogfat = 0
	last_fatigued = 0
	return
