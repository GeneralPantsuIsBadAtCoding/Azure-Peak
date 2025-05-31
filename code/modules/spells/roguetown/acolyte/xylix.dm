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
	recharge_time = 5 MINUTES
	
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
	recharge_time = 2 MINUTES
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
		SEND_SIGNAL(user, COMSIG_VICIOUSLY_MOCKED, target)
		GLOB.azure_round_stats[STATS_PEOPLE_MOCKED]++
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
