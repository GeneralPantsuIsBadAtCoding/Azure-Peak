/mob/living/proc/hasPenis()
	return gender == MALE

/mob/living/proc/hasTesticles()
	return gender == MALE

/mob/living/proc/hasVagina()
	return gender == FEMALE

/mob/living/proc/hasBreasts()
	return gender == FEMALE

/mob/living/carbon/human/hasPenis()
	return getorganslot(ORGAN_SLOT_PENIS)

/mob/living/carbon/human/hasTesticles()
	return getorganslot(ORGAN_SLOT_TESTICLES)

/mob/living/carbon/human/hasVagina()
	return getorganslot(ORGAN_SLOT_VAGINA)

/mob/living/carbon/human/hasBreasts()
	return getorganslot(ORGAN_SLOT_BREASTS)

/datum/sex_controller
	var/mob/living/owner
	//intruders
	var/mob/living/inpussy
	var/mob/living/inmouth
	var/mob/living/inass
	var/mob/living/eatingus //eating is someone else sucking, we are not forcing them to
	var/mob/living/ontits
	var/obj/item/grabbing/fapping
	var/lastfap
	var/fapspeed = 12
	var/is_fingering
	var/is_sucking
	//ours
	var/mob/living/fucking //what we are inside of
	var/fuckspeed = 12
	var/lastfuck
	var/mob/living/weeating
	var/eatspeed = 12
	var/lasteat
	var/mob/living/riding
	var/horny
	var/maxhorny
	var/lasthorny
	var/draining
	var/blueballs
	var/gender = MALE
	var/last_clothing_check
	var/last_silence_check
	var/curplaying
	var/datum/looping_sound/femmoans

/datum/sex_controller/New(Target)
	. = ..()
	if(ismob(Target))
		owner = Target

/datum/sex_controller/Destroy()
	..()
	cancel_all_sex()

/datum/sex_controller/male
	gender = MALE

/datum/sex_controller/female
	gender = FEMALE

/mob
	var/can_do_sex = 2

/mob/proc/can_do_sex()
	if(can_do_sex != 2)
		return can_do_sex
	if(!client)
		return FALSE
	if(get_playerquality(client.ckey) <= -10)
		return FALSE
//	if(!client.whitelisted())
//		if(!client.patreonlevel())
//			can_do_sex = 0
//			return can_do_sex
	if(client.blacklisted())
		can_do_sex = 0
		return can_do_sex
	can_do_sex = 1
	return can_do_sex

/mob/living/carbon/MiddleMouseDrop_T(mob/living/target, mob/living/user)
	if(user.mmb_intent)
		return ..()
	if(!istype(target))
		return
	if(!user.can_do_sex())
		to_chat(user, "<span class='warning'>I can't do this.</span>")
		return
	if(!can_do_sex())
//		to_chat(user, "<span class='warning'>I can't do this.</span>")
		return
	var/ourgroin = TRUE
	var/ourmouth = TRUE
	var/ourpenis = user.hasPenis()
	var/ourvagina = user.hasVagina()
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_MOUTH))
		ourmouth = FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		ourgroin = FALSE
	// SELF ONTO SELF
	if(target == src && src == user) //drag us onto ourselves
		var/obj/item/bodypart/chest = get_bodypart(BODY_ZONE_CHEST)
		for(var/obj/item/grabbing/G in grabbedby)
			if(G.limb_grabbed == chest)
				if(G.grabbee == user)
					if(G.sublimb_grabbed == BODY_ZONE_PRECISE_GROIN)
						var/yea = list("fap")
						var/td = input(user, "pleasures","") as null|anything in yea
						if(td == "fap")
							sexcon.begin_fapping(G, user)
	//US ONTO VICTIM
	if(src != target && target == user)
		log_combat(user, target, "attempted to begin mechanical ERP between", src)
		var/what2do = list()
		var/theirgroin = TRUE
		var/theirmouth = TRUE
		var/theirchest = TRUE
		var/theirvagina = src.hasVagina()
		var/theirpenis = src.hasPenis()
		var/theirbreasts = src.hasBreasts()
		if(!get_location_accessible(src, BODY_ZONE_PRECISE_MOUTH))
			theirmouth = FALSE
		if(!get_location_accessible(src, BODY_ZONE_PRECISE_GROIN))
			theirgroin = FALSE
		if(!get_location_accessible(src, BODY_ZONE_CHEST))
			theirchest = FALSE

		if(ourgroin)
			if(ourpenis)
				if(theirgroin)
					what2do += "zodomy"
					if(theirvagina)
						what2do += "love"
				if(theirmouth)
					what2do += "mouth feed"
				if(theirchest)
					if(theirbreasts)
						what2do += "use chest"
			if(ourvagina)
				if(!user.lying && src.lying)
					if(theirgroin)
						if(theirpenis)
							what2do += "ride"
					if(theirmouth)
						what2do += "mouth ride"
		if(ourmouth)
			if(theirgroin)
				if(theirvagina)
					what2do += "eat front"
				if(theirpenis)
					what2do += "suck"
		var/obj/item/bodypart/chest = get_bodypart(BODY_ZONE_CHEST)
		var/obj/G
		for(var/obj/item/grabbing/A in grabbedby)
			if(A.limb_grabbed == chest)
				if(A.grabbee == user)
					if(A.sublimb_grabbed == BODY_ZONE_PRECISE_GROIN)
						G = A
						if(theirpenis)
							what2do += "jerk"
						if(theirvagina)
							what2do += "finger"
		var/td = input(user, "pleasures","") as null|anything in what2do
		switch(td)
			if("eat front")
				user.sexcon.begin_eating(src)
			if("suck")
				user.sexcon.begin_sucking(src)
			if("ride")
				user.sexcon.begin_riding(src)
			if("mouth feed")
				user.sexcon.begin_mouthfuck(src)
			if("mouth ride")
				user.sexcon.begin_mouthride(src)
			if("use chest")
				user.sexcon.begin_titfuck(src)
			if("zodomy")
				user.sexcon.begin_assfuck(src)
			if("love")
				user.sexcon.begin_fuck(src)
			if("jerk")
				if(G) //Vrell - sadly this goes inside due to not defined errors otherwise.
					src.sexcon.begin_fapping(G, user)
			if("finger")
				if(G)
					src.sexcon.begin_fingering(G, user)


/datum/sex_controller/proc/begin_fuck(mob/living/user)
	testing("fuckstart")
	if(!user)
		testing("fuckfail")
		return
	if(!owner.hasPenis())
		testing("fuckfail2")
		return
	if(user.loc != owner.loc)
		testing("fuckfailloc")
		return
	if(!get_location_accessible(owner, BODY_ZONE_PRECISE_GROIN))
		testing("fuckfail3")
		return
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		testing("fuckfail4")
		return
	if(HAS_TRAIT(owner, TRAIT_LIMPDICK))
		to_chat(owner, "<span class='warning'>My soldier won't stand up for me.</span>")
		return
	if(user.sexcon.inpussy)
		if(user.sexcon.inpussy != owner)
			testing("fuckfail5")
			return
	if(eatingus)
		testing("fuckfail6")
		return
	if(fucking)
		if(fucking == user)
			if(fucking.sexcon.riding == owner)
				testing("fuckfail7")
				fucking.sexcon.stop_riding()
	if(fucking)
		if(fucking == user)
			if(fuckspeed == initial(fuckspeed))
				fuckspeed = max(round(fuckspeed / 2), 1)
				to_chat(owner, "<span class='info'>I speed up.</span>")
			else
				fuckspeed = initial(fuckspeed)
				to_chat(owner, "<span class='info'>I slow down.</span>")
		else
			stop_fucking()
		return
	if(horny < 0)
		to_chat(owner, "<span class='warning'>I'm spent.</span>")
		return
	fuckspeed = initial(fuckspeed)
	lastfuck = world.time
	fucking = user
	user.sexcon.inpussy = owner
	if(user.cmode)
		user.emote("embed", forced = TRUE)
	playsound(owner, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)
	owner.visible_message("<span class='[!user.cmode ? "love" : "warning"]'>[owner] taffs [user].</span>")
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.virginity)
			user.visible_message("<span class='warning'>[user] loses [user.p_their()] purity!</span>")
			H.flash_fullscreen("redflash3")
			H.on_virgin_loss()
			log_combat(user, owner, "deflowered(ERP)", src)
	START_PROCESSING(SSsex, user.sexcon)
	START_PROCESSING(SSsex, src)

/mob/living/carbon/human
	var/virginity = FALSE

/mob/living/carbon/human/proc/on_virgin_loss()
	virginity = FALSE
	if(mind)
		switch(mind.assigned_role)
			if("Priest")
				add_stress(/datum/stressevent/virginchurch)
				// adjust_triumphs(-2)
			if("Acolyte")
				add_stress(/datum/stressevent/virginchurch)
				// adjust_triumphs(-3)
			if("Cleric")
				add_stress(/datum/stressevent/virginchurch)
				// adjust_triumphs(-2)

/datum/sex_controller/proc/begin_assfuck(mob/living/user)
	if(!user)
		return
	if(!get_location_accessible(owner, BODY_ZONE_PRECISE_GROIN))
		return
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return
	if(user.sexcon.inass)
		if(user.sexcon.inass != owner)
			return
	if(!owner.hasPenis())
		testing("fuckfail2")
		return
	if(eatingus)
		return
	if(HAS_TRAIT(owner, TRAIT_LIMPDICK))
		to_chat(owner, "<span class='warning'>My soldier won't stand up for me.</span>")
		return
	if(user.loc != owner.loc)
		return
	if(fucking)
		if(fucking == user)
			if(fucking.sexcon.riding == owner)
				fucking.sexcon.stop_riding()
	if(fucking)
		if(fucking == user)
			if(fuckspeed == initial(fuckspeed))
				fuckspeed = max(round(fuckspeed / 2), 1)
				to_chat(owner, "<span class='info'>I speed up.</span>")
			else
				fuckspeed = initial(fuckspeed)
				to_chat(owner, "<span class='info'>I slow down.</span>")
		else
			stop_fucking()
		return
	if(horny < 0)
		to_chat(owner, "<span class='warning'>I'm spent.</span>")
		return
	fuckspeed = initial(fuckspeed)
	lastfuck = world.time
	fucking = user
	user.sexcon.inass = owner
	if(user.cmode)
		user.emote("embed", forced = TRUE)
	playsound(owner, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)
	owner.visible_message("<span class='[!user.cmode ? "love" : "warning"]'>[owner] zodomizes [user].</span>")
	log_combat(owner, user, "initiated sodomy(ERP)", src)
	START_PROCESSING(SSsex, user.sexcon)
	START_PROCESSING(SSsex, src)

/datum/sex_controller/proc/begin_titfuck(mob/living/user)
	if(!user)
		return
	if(!get_location_accessible(owner, BODY_ZONE_PRECISE_GROIN))
		return
	if(!get_location_accessible(user, BODY_ZONE_CHEST))
		return
	if(!user.hasBreasts() || !owner.hasPenis())
		return
	if(user.sexcon.ontits)
		if(user.sexcon.ontits != owner)
			testing("tfuckfail")
			return
	if(eatingus)
		testing("tfuckfail2")
		return
	if(HAS_TRAIT(owner, TRAIT_LIMPDICK))
		to_chat(owner, "<span class='warning'>My soldier won't stand up for me.</span>")
		return
	if(!user.lying && !user.wallpressed && !owner.wallpressed && !owner.lying)
		return
	if(user.loc != owner.loc)
		return
	if(fucking)
		if(fucking == user)
			if(fucking.sexcon.riding == owner)
				fucking.sexcon.stop_riding()
	if(fucking)
		if(fucking == user)
			if(fuckspeed == initial(fuckspeed))
				fuckspeed = max(round(fuckspeed / 2), 1)
				to_chat(owner, "<span class='info'>I speed up.</span>")
			else
				fuckspeed = initial(fuckspeed)
				to_chat(owner, "<span class='info'>I slow down.</span>")
		else
			stop_fucking()
		return
	if(horny < 0)
		to_chat(owner, "<span class='warning'>I'm spent.</span>")
		return
	fuckspeed = initial(fuckspeed)
	lastfuck = world.time
	fucking = user
	user.sexcon.ontits = owner
	owner.visible_message("<span class='[!user.cmode ? "love" : "warning"]'>[owner] uses [user]'s chest.</span>")
	START_PROCESSING(SSsex, user.sexcon)
	START_PROCESSING(SSsex, src)

/datum/sex_controller/proc/begin_mouthfuck(mob/living/user)
	if(!user)
		testing("mfuckfail")
		return
	if(!get_location_accessible(owner, BODY_ZONE_PRECISE_GROIN))
		return
	if(!get_location_accessible(owner, BODY_ZONE_PRECISE_MOUTH))
		return
	if(user.sexcon.inmouth)
		if(user.sexcon.inmouth != owner)
			testing("mfuckfail2")
			return
	if(user.cmode)
		if(!user.stat)
			to_chat(owner, "<span class='warning'>Not through clenched teeth.</span>")
			return
	if(user.sexcon.weeating)
		testing("mfuckfail3")
		if(user.sexcon.weeating != owner)
			return
		else
			user.sexcon.stop_eating()
	if(user.loc != owner.loc)
		return
	if(HAS_TRAIT(owner, TRAIT_LIMPDICK))
		to_chat(owner, "<span class='warning'>My soldier won't stand up for me.</span>")
		return
	if(!owner.hasPenis())
		return
	if(fucking)
		testing("mfuckfail4")
		if(fucking == user)
			if(fuckspeed == initial(fuckspeed))
				fuckspeed = max(round(fuckspeed / 2), 1)
				to_chat(owner, "<span class='info'>I speed up.</span>")
			else
				fuckspeed = initial(fuckspeed)
				to_chat(owner, "<span class='info'>I slow down.</span>")
		else
			stop_fucking()
		return
	if(horny < 0)
		to_chat(owner, "<span class='warning'>I'm spent.</span>")
		return
	fuckspeed = initial(fuckspeed)
	lastfuck = world.time
	fucking = user
	user.sexcon.inmouth = owner
	playsound(owner, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)
	owner.visible_message("<span class='[!user.cmode ? "love" : "warning"]'>[owner] feeds [user].</span>")
	START_PROCESSING(SSsex, user.sexcon)
	START_PROCESSING(SSsex, src)

/datum/sex_controller/proc/begin_mouthride(mob/living/user)
	if(!user)
		testing("mridefail")
		return
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_MOUTH))
		return
	if(!get_location_accessible(owner, BODY_ZONE_PRECISE_GROIN))
		return
	if(!owner.hasVagina())
		return
	if(user.loc != owner.loc)
		return
	if(!user.lying || owner.lying)
		return
	if(inpussy)
		testing("mridefail2")
		return
	if(eatingus)
		testing("mridefail3")
		if(eatingus != user) //someone is eating us already that isnt the user so we cant change
			testing("mridefail4")
			return
		else
			testing("mridefail5")
			stop_eating_us()
	if(user.sexcon.weeating)
		if(user.sexcon.weeating != owner) //they are eating someone else
			testing("mridefail6")
			return
		else
			user.sexcon.stop_eating()
	if(riding)
		testing("mridefail7")
		if(riding == user)
			if(user.sexcon.eatspeed == initial(user.sexcon.eatspeed))
				user.sexcon.eatspeed = max(round(user.sexcon.eatspeed / 2), 1)
				to_chat(owner, "<span class='info'>I speed up.</span>")
			else
				user.sexcon.eatspeed = initial(user.sexcon.eatspeed)
				to_chat(owner, "<span class='info'>I slow down.</span>")
		else
			stop_riding()
		return
	if(horny < 0)
		to_chat(owner, "<span class='warning'>I'm spent.</span>")
		return
	user.sexcon.eatspeed = initial(user.sexcon.eatspeed)
	user.sexcon.lasteat = world.time
	user.sexcon.weeating = owner
	riding = user
	owner.visible_message("<span class='[!user.cmode ? "love" : "warning"]'>[owner] rides [riding]'s face.</span>")
	START_PROCESSING(SSsex, user.sexcon)
	START_PROCESSING(SSsex, src)

//basically fucking but we can control the speed too
/datum/sex_controller/proc/begin_riding(mob/living/user)
	if(!user)
		testing("ridefail")
		return
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		testing("ridefail2")
		return
	if(!get_location_accessible(owner, BODY_ZONE_PRECISE_GROIN))
		testing("ridefail3")
		return
	if(!user.lying || owner.lying)
		return
	if(!user.hasPenis())
		testing("ridefail4")
		return
	if(!owner.hasVagina())
		testing("ridefail5")
		return
	if(HAS_TRAIT(user, TRAIT_LIMPDICK))
		to_chat(owner, "<span class='warning'>The soldier won't stand up for me.</span>")
		return
	if(inpussy && !riding)
		if(inpussy != user)
			return
		else
			user.sexcon.stop_fucking() //start riding instead
	if(eatingus)
		testing("ridefail6")
		return
	if(riding)
		testing("ridefail7")
		if(riding == user)
			if(riding.sexcon.weeating != owner)
				testing("ridefail8")
				if(user.sexcon.fuckspeed == initial(user.sexcon.fuckspeed))
					user.sexcon.fuckspeed = max(round(user.sexcon.fuckspeed / 2), 1)
					to_chat(owner, "<span class='info'>I speed up.</span>")
				else
					user.sexcon.fuckspeed = initial(user.sexcon.fuckspeed)
					to_chat(owner, "<span class='info'>I slow down.</span>")
			else
				stop_riding()
		else
			stop_riding()
		return
//	if(horny < 0)
//		to_chat(owner, "<span class='warning'>I'm spent.</span>")
//		return
	user.sexcon.fuckspeed = initial(user.sexcon.fuckspeed)
	user.sexcon.fucking = owner
	user.sexcon.lastfuck = world.time
	riding = user
	inpussy = user
	playsound(owner, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)
	owner.visible_message("<span class='[!user.cmode ? "love" : "warning"]'>[owner] rides [riding].</span>")
	START_PROCESSING(SSsex, user.sexcon)
	START_PROCESSING(SSsex, src)

/datum/sex_controller/proc/begin_eating(mob/living/user)
	if(!user)
		testing("eatfail1")
		return
	if(!get_location_accessible(owner, BODY_ZONE_PRECISE_MOUTH))
		testing("eatfail12")
		return
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		testing("eatfail13")
		return
	if(eatingus)
		if(eatingus == user)
			if(!(user.lying && owner.lying))
				testing("eatfail1lyy")
				return
	if(user.sexcon.eatingus) //someone else eating us
		testing("eatfail14")
		if(user.sexcon.eatingus != owner)
			testing("eatfail5")
			return
		else if(user.sexcon.riding == owner) //start eating instead
			testing("eatfail6")
			user.sexcon.stop_riding()
	if(!user.hasVagina()) //start sucking instead
		return
	if(weeating)
		testing("sp1")
		if(weeating == user)
			if(eatspeed == initial(eatspeed))
				eatspeed = max(round(eatspeed / 2), 1)
				to_chat(owner, "<span class='info'>I speed up.</span>")
			else
				eatspeed = initial(eatspeed)
				to_chat(owner, "<span class='info'>I slow down.</span>")
		else
			stop_eating()
		return
	eatspeed = initial(eatspeed)
	weeating = user
	user.sexcon.lasteat = world.time
	user.sexcon.eatingus = owner
	owner.visible_message("<span class='[!weeating.cmode ? "love" : "warning"]'>[owner] eats [weeating].</span>")
	user.sexcon.is_sucking = FALSE
	START_PROCESSING(SSsex, user.sexcon)
	START_PROCESSING(SSsex, src)

/datum/sex_controller/proc/begin_sucking(mob/living/user)
	if(!user)
		testing("eatfail1")
		return
	if(!get_location_accessible(owner, BODY_ZONE_PRECISE_MOUTH))
		testing("eatfail12")
		return
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		testing("eatfail13")
		return
	if(eatingus)
		if(eatingus == user)
			if(!(user.lying && owner.lying))
				testing("eatfail1lyy")
				return
	if(user.sexcon.eatingus) //someone else eating us
		testing("eatfail14")
		if(user.sexcon.eatingus != owner)
			testing("eatfail5")
			return
		else if(user.sexcon.riding == owner) //start eating instead
			testing("eatfail6")
			user.sexcon.stop_riding()
	if(!user.hasPenis()) //start sucking instead
		return
	if(weeating)
		testing("sp1")
		if(weeating == user)
			if(eatspeed == initial(eatspeed))
				eatspeed = max(round(eatspeed / 2), 1)
				to_chat(owner, "<span class='info'>I speed up.</span>")
			else
				eatspeed = initial(eatspeed)
				to_chat(owner, "<span class='info'>I slow down.</span>")
		else
			stop_eating()
		return
	eatspeed = initial(eatspeed)
	weeating = user
	user.sexcon.lasteat = world.time
	user.sexcon.eatingus = owner
	owner.visible_message("<span class='[!weeating.cmode ? "love" : "warning"]'>[owner] sucks [weeating].</span>")
	user.sexcon.is_sucking = TRUE
	START_PROCESSING(SSsex, user.sexcon)
	START_PROCESSING(SSsex, src)

/datum/sex_controller/proc/begin_fapping(obj/item/grabbing/G, mob/living/user)
	if(!G)
		testing("fapfail1")
		return
	if(fucking)
		testing("fapfail2")
		return
	if(eatingus)
		testing("fapfail3")
		return
	if(!get_location_accessible(owner, BODY_ZONE_PRECISE_GROIN))
		testing("fapfail4")
		return
	if(HAS_TRAIT(owner, TRAIT_LIMPDICK))
		to_chat(user, "<span class='warning'>The soldier won't stand up for me.</span>")
		return
	if(fapping)
		testing("fapfail6")
		if(fapping == G)
			testing("fapfail7")
			if(fapspeed == initial(fapspeed))
				fapspeed = max(round(fapspeed / 2), 1)
				to_chat(user, "<span class='info'>I speed up.</span>")
			else
				fapspeed = initial(fapspeed)
				to_chat(user, "<span class='info'>I slow down.</span>")
		return
	if(user == owner)
		owner.visible_message("<span class='love'>[owner] faps.</span>")
		if(horny < 0)
			to_chat(owner, "<span class='warning'>I'm spent.</span>")
			return
	fapspeed = initial(fapspeed)
	lastfap = world.time
	fapping = G
	G.handaction = "fapping"
	if(user != owner)
		owner.visible_message("<span class='[!owner.cmode ? "love" : "warning"]'>[fapping.grabbee] jerks [owner].</span>")
	G.dependents += src
	is_fingering = FALSE
	START_PROCESSING(SSsex, user.sexcon)
	START_PROCESSING(SSsex, src)

/datum/sex_controller/proc/begin_fingering(obj/item/grabbing/G, mob/living/user)
	if(!G)
		testing("fapfail1")
		return
	if(fucking)
		testing("fapfail2")
		return
	if(eatingus)
		testing("fapfail3")
		return
	if(!get_location_accessible(owner, BODY_ZONE_PRECISE_GROIN))
		testing("fapfail4")
		return
	if(HAS_TRAIT(owner, TRAIT_LIMPDICK))
		to_chat(user, "<span class='warning'>The soldier won't stand up for me.</span>")
		return
	if(fapping)
		testing("fapfail6")
		if(fapping == G)
			testing("fapfail7")
			if(fapspeed == initial(fapspeed))
				fapspeed = max(round(fapspeed / 2), 1)
				to_chat(user, "<span class='info'>I speed up.</span>")
			else
				fapspeed = initial(fapspeed)
				to_chat(user, "<span class='info'>I slow down.</span>")
		return
	if(user == owner)
		owner.visible_message("<span class='love'>[owner] masturbates.</span>")		//Different masturbation start - by Gardelin0
		if(horny < 0)
			to_chat(owner, "<span class='warning'>I'm spent.</span>")
			return
	fapspeed = initial(fapspeed)
	lastfap = world.time
	fapping = G
	G.handaction = "fapping"
	if(user != owner)
		owner.visible_message("<span class='[!owner.cmode ? "love" : "warning"]'>[fapping.grabbee] rubs [owner].</span>")
	G.dependents += src
	is_fingering = FALSE
	START_PROCESSING(SSsex, user.sexcon)
	START_PROCESSING(SSsex, src)

/datum/sex_controller/grabdropped(var/obj/item/grabbing/G)
	..()
	if(fapping == G)
		if(G.grabbee == owner)
			stop_fapping()
		else
			stop_fapping_us()

/datum/sex_controller/proc/mob_moved()
	cancel_others_actions()
	cancel_our_actions(TRUE)

/datum/sex_controller/proc/cancel_all_sex()
	cancel_others_actions()
	cancel_our_actions()

/datum/sex_controller/proc/cancel_others_actions()
	var/datum/sex_controller/D
	if(fapping)
		stop_fapping_us()
	if(eatingus)
		D = eatingus.sexcon
		if(D.weeating == owner)
			D.stop_eating()
	if(ontits)
		D = ontits.sexcon
		if(D.fucking == owner)
			D.stop_fucking()
	if(inmouth)
		D = inmouth.sexcon
		if(D.fucking == owner)
			D.stop_fucking()
	if(inass)
		D = inass.sexcon
		if(D.fucking == owner)
			D.stop_fucking()
	if(inpussy)
		D = inpussy.sexcon
		if(D.fucking == owner)
			D.stop_fucking()
	if(fucking)
		D = fucking.sexcon
		if(D.riding == owner)
			D.stop_riding()

/datum/sex_controller/proc/cancel_our_actions(checkfap)
	var/cancelled
	var/datum/sex_controller/D
	if(!checkfap)
		if(fapping)
			cancelled = TRUE
			stop_fapping()
	if(riding)
		stop_riding()
	if(fucking)
		stop_fucking()
	if(weeating)
		D = weeating.sexcon
		if(D.eatingus == owner)
			D.eatingus = null
			weeating = null
			cancelled = TRUE
	if(cancelled)
		return TRUE

/datum/sex_controller/proc/can_change_dir()
	if(fucking)
		return FALSE
	if(inass)
		return FALSE
	if(inpussy)
		return FALSE
	if(ontits)
		return FALSE
	if(inmouth)
		return FALSE
	if(weeating)
		return FALSE
	if(riding)
		return FALSE
	if(fapping && fapping.grabbee != owner)
		return FALSE
	return TRUE

/datum/sex_controller/proc/stop_fucking()
	if(fucking)
		var/datum/sex_controller/D = fucking.sexcon
		var/stopped = TRUE
		if(D.inass == owner)
			D.inass = null
		if(D.ontits == owner)
			D.ontits = null
		if(D.inmouth == owner)
			D.inmouth = null
		if(D.riding == owner) //we didn't truly stop fucking
			stopped = FALSE
		else if(D.inpussy == owner)
			D.inpussy = null
		if(stopped)
			fucking = null

/datum/sex_controller/proc/stop_riding()
	if(riding && riding.sexcon.fucking == owner)
		riding.sexcon.fucking = null
		riding = null
		inpussy = null
	if(riding && riding.sexcon.weeating == owner)
		riding.sexcon.weeating = null
		riding = null

/datum/sex_controller/proc/stop_eating_us()
	testing("stopeatingus")
	if(eatingus && eatingus.sexcon.weeating == owner)
		eatingus.sexcon.weeating = null
		eatingus = null

/datum/sex_controller/proc/stop_eating()
	if(weeating && weeating.sexcon.eatingus == owner)
		weeating.sexcon.eatingus = null
		weeating = null

/datum/sex_controller/proc/stop_fapping_us()
	testing("fapping us")
	if(fapping && fapping.grabbee != owner)
		fapping.handaction = null
		fapping = null

/datum/sex_controller/proc/stop_fapping()
	testing("fapping st")
	if(fapping && fapping.grabbee == owner)
		fapping.handaction = null
		fapping = null

/datum/sex_controller/process()
	if(!owner)
		STOP_PROCESSING(SSsex, src)
		return

	var/doing
	if(eatingus || fapping || fucking)
		if(world.time > last_clothing_check + 8 SECONDS)
			last_clothing_check = world.time
			if(!get_location_accessible(owner, BODY_ZONE_PRECISE_GROIN))
				if(fucking)
					stop_fucking()
				if(fapping)
					stop_fapping()
					stop_fapping_us()
				if(riding)
					stop_riding()
				if(eatingus)
					stop_eating_us()
	if(fucking)
		var/datum/sex_controller/D = fucking.sexcon
		if(D)
			doing = TRUE
			if(world.time > lastfuck + max(fuckspeed + rand(-3,3), 1))
				lastfuck = world.time
				if(D.riding == owner)
					if(fuckspeed != initial(fuckspeed))
						if(!D.owner.stamina_add(2))
							D.stop_riding()
					if(fucking)
						playsound(owner, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
						if(prob(33))
							fucking.visible_message("<span class='[!owner.cmode ? "love" : "warning"]'>[fucking] rides [owner].</span>")
						var/usedsource = "insidepussy"
						if(D.owner.stat == DEAD)
							usedsource = "fuckcorpse"
							stop_fucking()
						D.adjust_horny(4, "pussyfucked")
						if(adjust_horny(3, usedsource))
							D.adjust_horny(50, "pussyfucked")
							D.stop_riding()
				else if(D.inpussy == owner)
					if(fuckspeed != initial(fuckspeed))
						if(!owner.stamina_add(2))
							stop_fucking()
					if(fucking)
						playsound(owner, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
						if(prob(33))
							fucking.visible_message("<span class='[!D.owner.cmode ? "love" : "warning"]'>[owner] taffs [fucking].</span>")
						var/usedsource = "insidepussy"
						if(D.owner.stat == DEAD)
							usedsource = "fuckcorpse"
							stop_fucking()
						else
							if(!D.owner.client)
								usedsource = "sleepingbeauty"
						if(D.owner.cmode)
							D.owner.flash_fullscreen("redflash1")
						D.adjust_horny(4, "pussyfucked")
						if(adjust_horny(3, usedsource))
							if(!D.owner.cmode)
								D.adjust_horny(50, "pussyfucked")
							stop_fucking()
				if(D.inass == owner)
					if(fuckspeed != initial(fuckspeed))
						if(!owner.stamina_add(2))
							stop_fucking()
					if(fucking)
						playsound(owner, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
						if(prob(33))
							fucking.visible_message("<span class='[!D.owner.cmode ? "love" : "warning"]'>[owner] zodomizes [fucking].</span>")
//						D.owner.Immobilize(10)
						var/usedsource = "insideass"
						if(D.owner.stat == DEAD)
							usedsource = "fuckcorpse"
							stop_fucking()
						if(D.owner.cmode)
							D.owner.flash_fullscreen("redflash1")
						if(D.owner.cmode)
							D.adjust_horny(1, "assfucked")
						else
							D.adjust_horny(2, "assfucked")
						if(adjust_horny(2, usedsource))
							if(!D.owner.cmode)
								D.adjust_horny(50, "assfucked")
							stop_fucking()
				if(D.ontits == owner)
					if(fuckspeed != initial(fuckspeed))
						if(!owner.stamina_add(2))
							stop_fucking()
					if(fucking)
						playsound(owner, 'sound/misc/mat/fap.ogg', 30, TRUE, -2, ignore_walls = FALSE)
						if(prob(33))
							fucking.visible_message("<span class='[!D.owner.cmode ? "love" : "warning"]'>[owner] uses [fucking]'s chest.</span>")
						var/usedsource = "ontits"
						if(D.owner.stat == DEAD)
							usedsource = "fuckcorpse"
							stop_fucking()
						if(adjust_horny(2, usedsource))
							stop_fucking()
//						D.owner.Immobilize(10)
				if(D.inmouth == owner)

					if(fuckspeed != initial(fuckspeed))
						if(!owner.stamina_add(2))
							stop_fucking()
						if(!fucking.stamina_add(3, "gag", FALSE))
							stop_fucking()
					if(fucking)
						if(gender == FEMALE)
							playsound(fucking, pick('sound/misc/mat/girlmouth (1).ogg','sound/misc/mat/girlmouth (2).ogg'), 10, TRUE, ignore_walls = FALSE)
						else
							playsound(fucking, pick('sound/misc/mat/guymouth (1).ogg','sound/misc/mat/guymouth (2).ogg','sound/misc/mat/guymouth (3).ogg','sound/misc/mat/guymouth (4).ogg','sound/misc/mat/guymouth (5).ogg'), 20, TRUE, ignore_walls = FALSE)
						if(prob(33))
							fucking.visible_message("<span class='[!D.owner.cmode ? "love" : "warning"]'>[owner] feeds [fucking].</span>")
//						D.owner.Immobilize(10)
						var/usedsource = "fuckmouth"
						if(D.owner.stat == DEAD)
							usedsource = "fuckcorpse"
							stop_fucking()
						if(adjust_horny(3, usedsource))
							stop_fucking()
	if(riding)
		if(riding.sexcon.weeating == owner)
			var/datum/sex_controller/D = riding.sexcon
			doing = TRUE
			if(world.time > D.lasteat + max(D.eatspeed + rand(-3,3), 1))
				D.lasteat = world.time
				if(D.eatspeed != initial(D.eatspeed))
					if(!riding.stamina_add(1, "gag", FALSE))
						stop_riding()
				playsound(D.owner, pick('sound/misc/mat/girlmouth (1).ogg','sound/misc/mat/girlmouth (2).ogg'), 100, TRUE, -2, ignore_walls = FALSE)
				if(prob(33))
					owner.visible_message("<span class='[!owner.cmode ? "love" : "warning"]'>[owner] rides [riding]'s face.</span>")
				if(adjust_horny(3, "suckedoff"))
					stop_riding()
	if(eatingus)
		if(eatingus.sexcon.weeating != owner)
			eatingus = null
		if(eatingus)
			doing = TRUE
			if(world.time > eatingus.sexcon.lasteat + max(eatingus.sexcon.eatspeed + rand(-3,3), 1))
				eatingus.sexcon.lasteat = world.time
				if(eatingus.sexcon.eatspeed != initial(eatingus.sexcon.eatspeed))
					if(!eatingus.stamina_add(1, "gag", FALSE))
						stop_eating_us()
				if(gender == FEMALE)
					playsound(eatingus, pick('sound/misc/mat/girlmouth (1).ogg','sound/misc/mat/girlmouth (2).ogg'), 100, TRUE, -2, ignore_walls = FALSE)
				else
					playsound(eatingus, pick('sound/misc/mat/guymouth (1).ogg','sound/misc/mat/guymouth (2).ogg','sound/misc/mat/guymouth (3).ogg','sound/misc/mat/guymouth (4).ogg','sound/misc/mat/guymouth (5).ogg'), 100, TRUE, -2, ignore_walls = FALSE)
				if(prob(33))
					if(is_sucking)
						owner.visible_message("<span class='[!owner.cmode ? "love" : "warning"]'>[eatingus] sucks [owner].</span>")
					else
						owner.visible_message("<span class='[!owner.cmode ? "love" : "warning"]'>[eatingus] eats [owner].</span>")
				if(adjust_horny(3, "suckedoff"))
					stop_eating_us()
	if(fapping)
		if(!fapping.grabbee)
			fapping = null
		if(fapping)
			doing = TRUE
			if(world.time > lastfap + max(fapspeed + rand(-3,3), 1))
				lastfap = world.time
				if(fapping.grabbee == owner)
					if(fapspeed != initial(fapspeed))
						if(!owner.stamina_add(3))
							stop_fapping()
					if(fapping)
						if(gender == MALE)
							playsound(owner, 'sound/misc/mat/fap.ogg', 30, TRUE, -2, ignore_walls = FALSE)
						else
							playsound(owner, 'modular/sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)	//Different masturbation sounds - by Gardelin0
						if(prob(33))
							if(!is_fingering)
								owner.visible_message("<span class='[!owner.cmode ? "love" : "warning"]'>[owner] faps.</span>")
							else
								owner.visible_message("<span class='[!owner.cmode ? "love" : "warning"]'>[owner] masturbates.</span>")	//Slight diffirence - by Gardelin0
						if(adjust_horny(1, "fapself"))
							stop_fapping()
				else
					if(fapspeed != initial(fapspeed))
						if(!fapping.grabbee.stamina_add(1))
							stop_fapping_us()
					if(fapping)
						if(gender == MALE)
							playsound(owner, 'sound/misc/mat/fap.ogg', 30, TRUE, -2, ignore_walls = FALSE)
						else
							playsound(owner, 'modular/sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)	//Different masturbation sounds - by Gardelin0
						if(prob(33))
							if(!is_fingering)
								fapping.grabbee.visible_message("<span class='[!owner.cmode ? "love" : "warning"]'>[fapping.grabbee] jerks [owner].</span>")
							else
								fapping.grabbee.visible_message("<span class='[!owner.cmode ? "love" : "warning"]'>[fapping.grabbee] rubs [owner].</span>")
						if(adjust_horny(2, "otherfapping"))
							stop_fapping_us()
	if(!doing)
		STOP_PROCESSING(SSsex, src)

/datum/sex_controller/proc/handle_sex()
	if(!draining)
		if(world.time > lasthorny + 3 SECONDS)
			draining = TRUE

		var/severity = 0
		switch(horny)
			if(150 to 160)
				severity = 1
			if(160 to 170)
				severity = 2
			if(170 to 180)
				severity = 3
			if(180 to 190)
				severity = 4
			if(190 to 200)
				severity = 5
			if(200 to 210)
				severity = 6
			if(210 to 220)
				severity = 7
			if(220 to 230)
				severity = 8
			if(230 to 240)
				severity = 9
			if(240 to 300)
				severity = 10
		owner.overlay_fullscreen("horny", /atom/movable/screen/fullscreen/love, severity)
	else
		owner.clear_fullscreen("horny")

		if(horny > 0)
			adjust_horny(-1)
		else if(horny < 0)
			adjust_horny(1)

	if(owner.stat != CONSCIOUS)
		cancel_our_actions()

	if(owner.hasTesticles())
		if(horny > 30 && !blueballs)
			blueballs = TRUE

/datum/sex_controller/proc/adjust_horny(amt, source)
	var/oldhorny = horny
	if(owner.mind)
		if(owner.mind.has_antag_datum(/datum/antagonist/obsessed))
			return
	if(!amt)
		return
	if(!owner)
		return
	if(owner.stat == DEAD)
		return
	if(amt < 0)
		lasthorny = 0
		draining = TRUE
//		cancel_our_actions()
	if(amt > 0)
		if(owner.cmode)
			amt = round(amt/2)
		amt = max(amt + rand(-1,1), 1)
		if(source != "otherfapping")
			owner.AdjustSleeping(-50)
	horny = clamp(horny + amt, -100, 250)
//	owner.update_horny_hud()
	if(amt > 0)
		lasthorny = world.time
		draining = FALSE
	if(horny >= 250)
		cum(source)
		owner.playsound_local(owner, 'sound/misc/mat/end.ogg', 100)
		return TRUE

	if(owner.hasTesticles())
		if(horny <= 0 && oldhorny > 0 && blueballs && !source)
			owner.add_stress(/datum/stressevent/blueb)
			horny = clamp(horny - 80, -100, 250)

/datum/sex_controller/proc/cum(source)
	if(!owner)
		return
	if(owner.mind)
		if(owner.mind.has_antag_datum(/datum/antagonist/obsessed))
			return
	record_round_statistic(STATS_PLEASURES)
	blueballs = FALSE
	adjust_horny(-350)
	switch(source)
		if("fapself")
			if(owner.has_flaw(/datum/charflaw/addiction/lovefiend))
				owner.sate_addiction()
			owner.add_stress(/datum/stressevent/cumok)
		if("otherfapping")
			if(owner.has_flaw(/datum/charflaw/addiction/lovefiend))
				owner.sate_addiction()
			owner.add_stress(/datum/stressevent/cumok)
		if("assfucked")
			if(owner.has_flaw(/datum/charflaw/addiction/lovefiend))
				owner.sate_addiction()
			if(!owner.cmode)
				owner.add_stress(/datum/stressevent/cumok)
			else
				owner.add_stress(/datum/stressevent/cumbad)
		if("fuckcorpse")
			owner.add_stress(/datum/stressevent/cumcorpse)
			owner.freak_out()

		if("dildo")	//For dildos - by Gardelin0
			if(owner.has_flaw(/datum/charflaw/addiction/lovefiend))
				owner.sate_addiction()
			owner.add_stress(/datum/stressevent/cumok)
		if("ontits")
			if(owner.has_flaw(/datum/charflaw/addiction/lovefiend))
				owner.sate_addiction()
			owner.add_stress(/datum/stressevent/cumok)
			playsound(owner, 'sound/misc/mat/endout.ogg', 1, TRUE, ignore_walls = FALSE)
			owner.visible_message("<span class='notice'>[owner] paints [fucking]!</span>")
			add_cum_floor(get_turf(fucking))
		if("suckedoff")
			if(owner.has_flaw(/datum/charflaw/addiction/lovefiend))
				owner.sate_addiction()
			owner.add_stress(/datum/stressevent/cumgood)
			owner.visible_message("<span class='notice'>[owner] feeds [fucking]!</span>")
			playsound(owner, pick('sound/misc/mat/mouthend (1).ogg','sound/misc/mat/mouthend (2).ogg'), 100, FALSE, ignore_walls = FALSE)
			add_cum_floor(get_turf(fucking))
		if("fuckmouth")
			if(owner.has_flaw(/datum/charflaw/addiction/lovefiend))
				owner.sate_addiction()
			owner.add_stress(/datum/stressevent/cummid)
			playsound(owner, pick('sound/misc/mat/mouthend (1).ogg','sound/misc/mat/mouthend (2).ogg'), 100, FALSE, ignore_walls = FALSE)
			owner.visible_message("<span class='notice'>[owner] feeds [fucking]!</span>")
			add_cum_floor(get_turf(fucking))
			if(fucking && fucking.sexcon.weeating == owner)
				if(fucking.cmode)
					if(ishuman(owner))
						var/mob/living/carbon/human/H = owner
						var/wuzantag
						if(H.mind)
							if(H.mind.antag_datums)
								if(H.mind.antag_datums.len)
									wuzantag = TRUE
						if(!wuzantag)
							adjust_playerquality(-2, H.ckey, reason="Raped as a non villain.")
					addtimer(CALLBACK(eatingus, /mob/.proc/emote, "gag"), rand(10,20))
		if("insideass")
			if(owner.has_flaw(/datum/charflaw/addiction/lovefiend))
				owner.sate_addiction()
			if(ishuman(owner))
				var/mob/living/carbon/human/H = owner
				if(H.virginity)
					H.on_virgin_loss()
				if(fucking && fucking.cmode)
					var/wuzantag
					if(H.mind)
						if(H.mind.antag_datums)
							if(H.mind.antag_datums.len)
								wuzantag = TRUE
					if(!wuzantag)
						adjust_playerquality(-2, H.ckey, reason="Raped as a non villain.")
			owner.add_stress(/datum/stressevent/cumok)
			owner.visible_message("<span class='notice'>[owner] tightens in ecstasy!</span>")
			playsound(owner, 'sound/misc/mat/endin.ogg', 100, TRUE, ignore_walls = FALSE)
			add_cum_floor(get_turf(fucking))
			try_award_triumph(fucking)
		if("insidepussy")
			if(owner.has_flaw(/datum/charflaw/addiction/lovefiend))
				owner.sate_addiction()

			if(ishuman(owner))
				var/mob/living/carbon/human/H = owner
				if(H.virginity)
					H.on_virgin_loss()
			var/husbando
			if(fucking && !fucking.cmode)
				var/yee
				if(ishuman(owner) && ishuman(fucking))
					var/mob/living/carbon/human/H = owner
					var/mob/living/carbon/human/F = fucking
					if(F.marriedto)
						if(F.marriedto != H.real_name)
							if(SSticker.cuckers)
								SSticker.cuckers += ", [F.real_name] (with [H.real_name])"
							else
								SSticker.cuckers += "[F.real_name] (with [H.real_name])"
					if(H.marriedto)
						if(H.marriedto != F.real_name)
							if(SSticker.cuckers)
								SSticker.cuckers += ", [H.real_name] (with [F.real_name])"
							else
								SSticker.cuckers += "[H.real_name] (with [F.real_name])"
					if(H.marriedto == F.real_name)
						yee = 1
						husbando = 1
						owner.add_stress(/datum/stressevent/cumlove)
				if(!yee)
					owner.add_stress(/datum/stressevent/cummax)
			else
				owner.add_stress(/datum/stressevent/cumok)
				var/mob/living/M = owner
				var/wuzantag
				if(M.mind)
					if(M.mind.antag_datums)
						if(M.mind.antag_datums.len)
							wuzantag = TRUE
				if(!wuzantag)
					adjust_playerquality(-2, M.ckey, reason="Raped as a non villain.")
			if(owner.hasTesticles() && prob(20))
				if(!fucking.mob_timers["preggo"])
					fucking.mob_timers["preggo"] = world.time
					addtimer(CALLBACK(fucking, /mob/living/carbon/human/.proc/become_pregnant, husbando), rand(3 MINUTES, 13 MINUTES))
			playsound(fucking, 'sound/misc/mat/endin.ogg', 100, TRUE, ignore_walls = FALSE)
			owner.visible_message("<span class='notice'>[owner] tightens in ecstasy!</span>")
			add_cum_floor(get_turf(fucking))
			try_award_triumph(fucking)

		if("sleepingbeauty")
			if(owner.has_flaw(/datum/charflaw/addiction/lovefiend))
				owner.sate_addiction()
			if(ishuman(owner))
				var/mob/living/carbon/human/H = owner
				if(H.virginity)
					H.on_virgin_loss()
				if(fucking)
					var/wuzantag
					if(H.mind)
						if(H.mind.antag_datums)
							if(H.mind.antag_datums.len)
								wuzantag = TRUE
					if(!wuzantag)
						adjust_playerquality(-1, H.ckey, reason="Fucked an AFK player as a non-villain.")
			owner.add_stress(/datum/stressevent/cumok)
			playsound(fucking, 'sound/misc/mat/endin.ogg', 100, TRUE, ignore_walls = FALSE)
			add_cum_floor(get_turf(fucking))
			owner.visible_message("<span class='notice'>[owner] tightens in ecstasy!</span>")

		if("fapself")
			add_cum_floor(get_turf(owner))
			owner.visible_message("<span class='notice'>[owner] spills something on the floor!</span>")
			playsound(owner, 'sound/misc/mat/endout.ogg', 100, TRUE, ignore_walls = FALSE)
		if("otherfapping")
			add_cum_floor(get_turf(fapping.grabbee))
			owner.visible_message("<span class='notice'>[owner] spills something on the floor!</span>")
			playsound(owner, 'sound/misc/mat/endout.ogg', 100, TRUE, ignore_walls = FALSE)
		if("assfucked")
			add_cum_floor(get_turf(owner))
			owner.visible_message("<span class='notice'>[owner] spills something on the floor!</span>")
			playsound(owner, 'sound/misc/mat/endout.ogg', 100, TRUE, ignore_walls = FALSE)
			try_award_triumph(fucking)
		if("pussyfucked")
			if(owner.has_flaw(/datum/charflaw/addiction/lovefiend))
				owner.sate_addiction()
			if(!owner.cmode)
				if(inpussy && !inpussy.cmode)
					var/yee
					if(ishuman(owner) && ishuman(inpussy))
						var/mob/living/carbon/human/H = inpussy
						var/mob/living/carbon/human/F = owner
						if(H.marriedto == F.real_name)
							yee = 1
							owner.add_stress(/datum/stressevent/cumlove)
					if(!yee)
						owner.add_stress(/datum/stressevent/cummax)
				else
					owner.add_stress(/datum/stressevent/cummid)
			else
				owner.add_stress(/datum/stressevent/cumbad)
	if(owner.hasVagina())
		if(!owner.cmode)
			owner.visible_message("<span class='notice'>[owner] tightens in pleasure!</span>")
		else
			owner.visible_message("<span class='notice'>[owner] tightens in release!</span>")
	if(gender == FEMALE)
		if(curplaying)
			curplaying = null
			if(femmoans)
				femmoans.stop()

// Tries to award triumphs, giving the target one if the owner has TRAIT_GOODLOVER, and vice versa, but only once per person per round
/datum/sex_controller/proc/try_award_triumph(mob/living/target)
	if(!target)
		return
	if(HAS_TRAIT(target, TRAIT_GOODLOVER))
		if(!owner.mob_timers["cumtri"])
			owner.mob_timers["cumtri"] = world.time
			owner.adjust_triumphs(1)
			to_chat(owner, span_love("Our loving is a true TRIUMPH!"))
	if(HAS_TRAIT(owner, TRAIT_GOODLOVER))
		if(!target.mob_timers["cumtri"])
			target.mob_timers["cumtri"] = world.time
			target.adjust_triumphs(1)
			to_chat(target, span_love("Our loving is a true TRIUMPH!"))

/datum/sex_controller/female/adjust_horny(amt, source) //Vrell - sound effect, leaving them gendered for now.
	. = ..()
	if((amt > 0) && prob(80))
		switch(source)
			if("pussyfucked")
				if(!owner.cmode)
					owner.emote("sexmoanhvy")
				else
					owner.emote("sexmoanlight")
			if("assfucked")
				if(!owner.cmode)
					owner.emote("sexmoanlight")
			if("otherfapping")
				if(prob(23))
					owner.emote("sexmoanlight")
			if("suckedoff")
				owner.emote("sexmoanlight")

			if("fapping")	//Moaning when masturbating - by Gardelin0
				if(prob(10))
					owner.emote("sexmoanlight")

			if("dildo")	//For dildos - by Gardelin0
				if(!owner.cmode)
					owner.emote("sexmoanhvy")

/mob/living/carbon/human/proc/become_pregnant(husband)
	if(QDELETED(src))
		return
	if(!hasVagina())
		return
	if(stat == DEAD)
		return

	to_chat(src, "<span class='warning'>I don't feel so good...I'm definetly pregnant!</span>")	//Some kind of a notification - by Gardelin0
//	add_nausea(101)	Stop throwing up after sex - by Gardelin0

/datum/sex_controller/proc/add_cum_floor(turfu)
	if(!turfu || !isturf(turfu))
		return
	var/turf/T = turfu
	new /obj/effect/decal/cleanable/coom(T)

/datum/looping_sound/femhornylite
	mid_sounds = list('sound/vo/female/gen/se/horny1loop (1).ogg')
	mid_length = 470
	volume = 20
	extra_range = -4

/datum/looping_sound/femhornylitealt
	mid_sounds = list('sound/vo/female/gen/se/horny1loop (2).ogg')
	mid_length = 360
	volume = 20
	extra_range = -4

/datum/looping_sound/femhornymed
	mid_sounds = list('sound/vo/female/gen/se/horny2loop (1).ogg')
	mid_length = 420
	volume = 20
	extra_range = -4

/datum/looping_sound/femhornymedalt
	mid_sounds = list('sound/vo/female/gen/se/horny2loop (2).ogg')
	mid_length = 350
	volume = 20
	extra_range = -4

/datum/looping_sound/femhornyhvy
	mid_sounds = list('sound/vo/female/gen/se/horny3loop (1).ogg')
	mid_length = 440
	volume = 20
	extra_range = -4

/datum/looping_sound/femhornyhvyalt
	mid_sounds = list('sound/vo/female/gen/se/horny3loop (2).ogg')
	mid_length = 390
	volume = 20
	extra_range = -4
