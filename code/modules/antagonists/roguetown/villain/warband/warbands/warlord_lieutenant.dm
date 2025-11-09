/datum/antagonist/warlord_lieutenant
	var/aspirant = FALSE
	name = "Lieutenant"
	roundend_category = "Warlord"
	antagpanel_category = "Warlord"
	job_rank = ROLE_WARLORD_LIEUTENANT
	confess_lines = list(
		"A WAR IN THEIR NAME!",
		"I HAVE SERVED FAITHFULLY!",
		"IT WAS MY DUTY!",
	)
	rogue_enabled = TRUE


/datum/antagonist/warlord_grunt
	name = "Grunt"
	roundend_category = "Warlord"
	antagpanel_category = "Warlord"
	job_rank = ROLE_WARLORD_GRUNT
	confess_lines = list(
		"THIS LAND MUST BURN!",
		"IT IS NOT MY WILL!",
		"M'LOOOOOOOOOOOOOOOOOOOOOOOOORD!!", // why are you torturing a grunt, bro. Wtf
	)
	rogue_enabled = TRUE


/datum/antagonist/warlord_lieutenant/proc/aspirant_roll()
	var/final_aspirant_chance = 50
	if(owner.warband_manager)
		var/atom/movable/screen/warband/manager/source_warband_manager = owner.warband_manager	
		final_aspirant_chance = source_warband_manager.aspirant_chance
	if(prob(final_aspirant_chance))
		src.aspirant = TRUE
	return

/datum/antagonist/warlord_lieutenant/on_gain()
	owner.warbandsetup = TRUE
	owner.current.invisibility = INVISIBILITY_MAXIMUM
	owner.current.set_blindness(5400)
	owner.current.Stun(5400)
	aspirant_roll()
	greet()
	return

/datum/antagonist/warlord_grunt/on_gain()
	owner.warbandsetup = TRUE
	owner.current.invisibility = INVISIBILITY_MAXIMUM
	owner.current.set_blindness(5400)
	owner.current.Stun(5400)
	greet()
	return

///////////////
///////////////
///////////////
/datum/antagonist/warlord_lieutenant/greet()
	SEND_SOUND(owner.current, sound(null)) // stops the title music if we pulled them from the lobby
	if(src.aspirant)
		owner.special_role = "Aspirant Lieutenant"	
		to_chat(owner.current, span_userdanger("Again, my Warlord calls me forth. I mustn't forget: my service is simply a means to an end."))	
		var/atom/movable/screen/introtext/aspirant/intro_text = new /atom/movable/screen/introtext/aspirant
		var/list/intro_sounds = list(
			'sound/misc/warband/selection_introc.ogg',
			'sound/misc/warband/selection_introb.ogg'
		)
		var/chosen_song = pick(intro_sounds)

		owner.current.playsound_local(owner.current, chosen_song, 140, FALSE, pressure_affected = FALSE)
		owner.current.client.screen += intro_text
		animate(intro_text, alpha = 255, time = 50)
		return
	owner.special_role = name
	to_chat(owner.current, span_userdanger("My Warlord calls upon my service."))

	var/list/intro_sounds = list(
		'sound/misc/warband/selection_introc.ogg',
		'sound/misc/warband/selection_introb.ogg'
	)
	var/chosen_song = pick(intro_sounds)

	owner.current.playsound_local(owner.current, chosen_song, 140, FALSE, pressure_affected = FALSE)

	var/atom/movable/screen/introtext/lieutenant/intro_text = new /atom/movable/screen/introtext/lieutenant
	owner.current.client.screen += intro_text
	animate(intro_text, alpha = 255, time = 50)
	..()


/datum/antagonist/warlord_grunt/greet()
	SEND_SOUND(owner.current, sound(null)) // stops the title music if we pulled them from the lobby
	owner.special_role = name
	to_chat(owner.current, span_userdanger("My Lieutenant calls upon my service."))

	var/list/intro_sounds = list(
		'sound/misc/warband/selection_introc.ogg',
		'sound/misc/warband/selection_introb.ogg'
	)
	var/chosen_song = pick(intro_sounds)
	owner.current.playsound_local(owner.current, chosen_song, 140, FALSE, pressure_affected = FALSE)

	var/atom/movable/screen/introtext/veteran/intro_text = new /atom/movable/screen/introtext/veteran
	owner.current.client.screen += intro_text
	animate(intro_text, alpha = 255, time = 50)
	..()



///////////////
///////////////
///////////////
/datum/antagonist/warlord_lieutenant/proc/create_objectives()



/datum/objective/warband/aspirant/greatergood
	name = "Greater Good"
	explanation_text = "The Warlord must prevail in his objectives."

/datum/objective/warband/aspirant/standard
	name = "Term"
	explanation_text = "As an individual, I must directly benefit from a Treaty's terms at least once."

/datum/objective/warband/aspirant/disorder
	name = "Pragmatism"
	explanation_text = "We must prevail by any means necessary. My Warband must recruit 4 or more allies."

/datum/objective/warband/aspirant/order
	name = "Order"
	explanation_text = "If we are to succeed, order must be maintained. My Warband cannot have 3 or more Disorder."

/datum/objective/warband/aspirant/wormtongue
	name = "Dead Weight"
	explanation_text = "The other Lieutenants cannot be trusted. By the end of the week, I must be the last remaining Lieutenant in the Warband."

/datum/objective/warband/aspirant/coin
	name = "Mammon"
	explanation_text = "I'm in desperate need of coin, and I've been long denied it. By the week's end, I need a total of 2000 mammon on my person."

/datum/objective/warband/aspirant/command
	name = "Change Command"
	explanation_text = "If I want something done right, I must see it done myself. The Warlord must cede control of the Warband to me."





