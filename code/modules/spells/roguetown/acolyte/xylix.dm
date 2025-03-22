/obj/effect/proc_holder/spell/invoked/wheel
	name = "The Wheel"
	releasedrain = 10
	chargedrain = 0
	chargetime = 3
	range = 1
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	sound = 'sound/misc/letsgogambling.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 5 MINUTES
	
/obj/effect/proc_holder/spell/invoked/wheel/cast(list/targets, mob/user = usr)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.apply_status_effect(/datum/status_effect/wheel)		
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/mockery
	name = "Vicious Mockery"
	releasedrain = 50
	associated_skill = /datum/skill/misc/music
	charge_max = 2 MINUTES
	range = 7

/obj/effect/proc_holder/spell/invoked/mockery/cast(list/targets, mob/user = usr)
	playsound(get_turf(user), 'sound/magic/mockery.ogg', 40, FALSE)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		if(!target.can_hear()) // Vicious mockery requires people to be able to hear you.
			revert_cast()
			return FALSE
		target.apply_status_effect(/datum/status_effect/debuff/viciousmockery)	
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/mockery/invocation(mob/user = usr)
	if(ishuman(user))
		switch(pick(1,2,3,4,5,6,7,8,9,10,11,12,13))
			if(1)
				user.say("Your mother was a Rous, and your father smelled of jacksberries!", forced = "spell")
			if(2)
				user.say("What are you going to do for a face when the Archdevil wants his arse back?!", forced = "spell")
			if(3)
				user.say("Wandought thine blades stand, much like thine loving parts!", forced = "spell")
			if(4)
				user.say("That's a face not even Eora could love!", forced = "spell")
			if(5)
				user.say("Your breath smells like raw butter and cheap beer!.", forced = "spell")
			if(6)
				user.say("I bite mine thumb, ser!", forced = "spell")
			if(7)
				user.say("But enough talk- have at thee!", forced = "spell")
			if(8)
				user.say("My grandmother fights better than you!", forced = "spell")
			if(9)
				user.say("Need you borrow mine spectacles? Come get them!", forced = "spell")
			if(10)
				user.say("How much sparring did it take to become this awful?!", forced = "spell")
			if(11)
				user.say("You may need a smith- for you seem ill-equipped for a battle of wits!", forced = "spell")
			if(12)
				user.say("Looks as if thou art PSY-DONE! No? Too soon? Alright.", forced = "spell")
			if(13)
				user.say("Ravox bring justice to your useless mentor, ser!", forced = "spell")

/datum/status_effect/debuff/viciousmockery
	id = "viciousmockery"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/viciousmockery
	duration = 600 // One minute
	effectedstats = list("strength" = -1, "speed" = -1,"endurance" = -1, "intelligence" = -3)

/atom/movable/screen/alert/status_effect/debuff/viciousmockery
	name = "Vicious Mockery"
	desc = "<span class='warning'>THAT ARROGANT BARD! ARGH!</span>\n"
	icon_state = "muscles"

/obj/effect/proc_holder/spell/invoked/slick_trick
	name = "Slick Trick"
	releasedrain = 30
	chargedrain = 0
	chargetime = 2
	range = 12
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	sound = 'sound/magic/antimagic.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 45 SECONDS

/obj/effect/proc_holder/spell/invoked/slick_trick/cast(list/targets, mob/user = usr)
	var/turf/T = get_turf(targets[1])
	
	// Get all turfs in a 3x3 area
	var/list/affected_turfs = list()
	for(var/turf/open/O in range(1, T))
		affected_turfs += O
	
	if(affected_turfs.len)
		user.visible_message("<span class='warning'>[user] creates slick patches on the floor!</span>")
		
		// Apply effect to all open turfs in range
		for(var/turf/open/O in affected_turfs)
			playsound(O, 'sound/foley/waterenter.ogg', 25, TRUE)
			
			// First, clear any existing wet floor
			O.ClearWet()
			
			// Create a new one with our custom callback for slipping
			O.AddComponent(/datum/component/wet_floor, TURF_WET_LUBE, 15 SECONDS, 0, 120 SECONDS, FALSE)
			
			// Replace the slippery component with our own that has a custom callback
			var/datum/component/slippery/S = O.GetComponent(/datum/component/slippery)
			if(S)
				qdel(S)
			O.LoadComponent(/datum/component/slippery, 80, SLIDE | GALOSHES_DONT_HELP, CALLBACK(src, PROC_REF(after_slip)))
			
			// Create a visual indicator
			new /obj/effect/temp_visual/slick_warning(O)
		
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/slick_trick/proc/after_slip(mob/living/L)
	if(istype(L))
		L.visible_message("<span class='warning'>[L] slips on the slick surface!</span>",
						  "<span class='warning'>You slip on a magically slick surface!</span>")
		
		// Play various laughter sounds from Xylix the trickster god
		var/list/laugh_sounds = list(
			'sound/vo/male/jester/laugh (1).ogg',
			'sound/vo/male/jester/laugh (2).ogg',
			'sound/vo/male/jester/laugh (3).ogg',
			'sound/vo/male/evil/laugh (1).ogg',
			'sound/vo/male/evil/laugh (2).ogg'
		)
		
		// Play all laughter sounds at the same time for a chorus of laughter
		var/turf/T = get_turf(L)
		for(var/sound_file in laugh_sounds)
			playsound(T, sound_file, 50, TRUE, -1) // Lower volume to avoid being too loud
			
		return TRUE
	return FALSE

/obj/effect/temp_visual/slick_warning
	name = "slippery patch"
	desc = "Watch your step!"
	icon = 'icons/effects/effects.dmi'
	icon_state = "purplesparkles"
	color = "#0099FF" // Blue tint for water-like appearance
	randomdir = FALSE
	duration = 15 SECONDS
	layer = MASSIVE_OBJ_LAYER
	
	// Override the Initialize to ensure it stays visible for exactly the same duration as the slip effect
/obj/effect/temp_visual/slick_warning/Initialize()
	. = ..()
	// Clear any existing timer and set our own to exactly match the wet floor duration
	deltimer(timerid)
	timerid = QDEL_IN(src, 15 SECONDS)
