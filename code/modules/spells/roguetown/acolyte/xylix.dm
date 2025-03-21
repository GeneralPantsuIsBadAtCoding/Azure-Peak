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

/obj/effect/proc_holder/spell/invoked/curse_of_woe
	name = "Curse of Woe"
	desc = "A powerful curse that makes the target vulnerable to ambushes anywhere they go. The curse is lifted once an ambush successfully triggers."
	releasedrain = 100
	chargedrain = 0
	chargetime = 5
	range = 5
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	sound = 'sound/misc/letsgogambling.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 1 MINUTES
	devotion_cost = 90 // Added devotion cost

/obj/effect/proc_holder/spell/invoked/curse_of_woe/cast(list/targets, mob/user = usr)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			to_chat(user, span_warning("The target is protected from your magic!"))
			return FALSE
		
		// Apply the curse status effect
		var/datum/status_effect/debuff/curse_of_woe/curse = target.apply_status_effect(/datum/status_effect/debuff/curse_of_woe)
		if(!curse)
			to_chat(user, span_warning("The curse failed to take hold!"))
			return FALSE
			
		user.visible_message(span_warning("[user] points at [target], cursing them with Xylix's Woe!"), 
							span_notice("You curse [target] with Xylix's Woe. They will be hunted wherever they go."))
		
		// Visual effects
		var/obj/effect/temp_visual/curse_visuals = new /obj/effect/temp_visual/curse(get_turf(target))
		curse_visuals.color = "#800080" // Purple for Xylix
		
		// Force an ambush check soon after being cursed
		addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living, consider_ambush)), rand(50, 150))
		
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/curse_of_woe/invocation(mob/user = usr)
	if(ishuman(user))
		user.say("By Xylix's whim, I curse thee to be hunted! The Laughing God's woe be upon you!", forced = "spell")

/datum/status_effect/debuff/curse_of_woe
	id = "curse_of_woe"
	status_type = STATUS_EFFECT_UNIQUE
	duration = -1 // Infinite duration until removed
	alert_type = /atom/movable/screen/alert/status_effect/debuff/curse_of_woe
	
/datum/status_effect/debuff/curse_of_woe/on_apply()
	if(!isliving(owner))
		return FALSE
	to_chat(owner, span_danger("<b>You feel a shiver running down your spine. Something is watching you...</b>"))
	owner.visible_message(span_warning("A dark aura briefly flashes around [owner]!"))
	playsound(owner, 'sound/misc/letsgogambling.ogg', 50, TRUE)
	
	// Add a visual effect to the cursed character
	owner.add_filter("curse_outline", 2, list("type" = "outline", "color" = "#800080", "size" = 1))
	
	// Set ambushable to 1 for NPCs that might not have it set
	if(istype(owner, /mob/living))
		owner.ambushable = 1
	
	// Periodically check for ambushes
	addtimer(CALLBACK(src, PROC_REF(periodic_ambush_check)), rand(100, 300))
	
	return TRUE
	
/datum/status_effect/debuff/curse_of_woe/on_remove()
	to_chat(owner, span_notice("You feel the weight of Xylix's curse lift from your shoulders."))
	owner.visible_message(span_notice("The dark aura around [owner] fades away!"))
	
	// Remove the visual effect
	owner.remove_filter("curse_outline")

/datum/status_effect/debuff/curse_of_woe/proc/periodic_ambush_check()
	if(!owner || QDELETED(src))
		return
	
	// For NPCs, we need to be more aggressive with ambush checks
	if(!ishuman(owner) && prob(40))
		trigger_npc_ambush()
		return
		
	// For players, we'll use a modified version of the ambush system
	if(ishuman(owner) && prob(40))
		trigger_player_ambush()
	else
		// Force a regular ambush check as fallback
		owner.consider_ambush()
	
	// Schedule the next check
	addtimer(CALLBACK(src, PROC_REF(periodic_ambush_check)), rand(300, 600))
	
/datum/status_effect/debuff/curse_of_woe/proc/trigger_npc_ambush()
	if(!owner || QDELETED(src))
		return
		
	var/turf/T = get_turf(owner)
	if(!T)
		return
		
	// Create a list of possible spawn points
	var/list/possible_targets = list()
	for(var/turf/F in view(7, owner))
		if(F != T) // Don't spawn on the target's tile
			possible_targets += F
			
	if(length(possible_targets))
		// Set the ambush cooldown
		owner.mob_timers["ambushlast"] = world.time
		
		// Spawn 2-3 jester raiders
		var/spawn_count = rand(2, 3)
		
		for(var/i in 1 to spawn_count)
			var/spawnloc = pick(possible_targets)
			if(spawnloc)
				var/mob/living/carbon/human/species/human/northern/jester_raider/jester = new(spawnloc)
				jester.is_silent = FALSE // Allow them to speak their lines
				jester.target = owner
				jester.mode = AI_HUNT
				jester.aggressive = 1
				jester.wander = TRUE
				
				// Make them say something when they spawn
				addtimer(CALLBACK(jester, TYPE_PROC_REF(/mob/living/carbon/human/species/human/northern/jester_raider, retaliate), owner), 5)
		
		// Special effects
		owner.visible_message(span_warning("Cackling jesters emerge from the shadows to attack [owner]!"))
		playsound(owner, pick('sound/vo/male/jester/laugh (1).ogg','sound/vo/male/jester/laugh (2).ogg','sound/vo/male/jester/laugh (3).ogg'), 100, vary = TRUE)
		
		// Remove the curse after a successful ambush
		owner.remove_status_effect(/datum/status_effect/debuff/curse_of_woe)

/datum/status_effect/debuff/curse_of_woe/proc/trigger_player_ambush()
	if(!owner || QDELETED(src))
		return
		
	var/turf/T = get_turf(owner)
	if(!T)
		return
		
	// Create a list of possible spawn points
	var/list/possible_targets = list()
	for(var/turf/F in view(7, owner))
		if(F != T) // Don't spawn on the target's tile
			possible_targets += F
			
	if(length(possible_targets))
		// Set the ambush cooldown
		owner.mob_timers["ambushlast"] = world.time
		
		// Spawn 2-4 jester raiders
		var/spawn_count = rand(2, 4)
		
		for(var/i in 1 to spawn_count)
			var/spawnloc = pick(possible_targets)
			if(spawnloc)
				var/mob/living/carbon/human/species/human/northern/jester_raider/jester = new(spawnloc)
				jester.is_silent = FALSE // Allow them to speak their lines
				jester.target = owner
				jester.mode = AI_HUNT
				jester.aggressive = 1
				jester.wander = TRUE
				
				// Make them say something when they spawn
				addtimer(CALLBACK(jester, TYPE_PROC_REF(/mob/living/carbon/human/species/human/northern/jester_raider, retaliate), owner), 5)
		
		// Special effects
		to_chat(owner, span_warning("<b>Xylix's jesters emerge to claim you!</b>"))
		owner.visible_message(span_warning("Cackling jesters emerge from the shadows to attack [owner]!"))
		playsound(owner, pick('sound/vo/male/jester/laugh (1).ogg','sound/vo/male/jester/laugh (2).ogg','sound/vo/male/jester/laugh (3).ogg'), 100, vary = TRUE)
		shake_camera(owner, 2, 2)
		
		// Remove the curse after a successful ambush
		owner.remove_status_effect(/datum/status_effect/debuff/curse_of_woe)
		return TRUE
	
	return FALSE

/atom/movable/screen/alert/status_effect/debuff/curse_of_woe
	name = "Curse of Woe"
	desc = "I am Xylix's plaything. Ambushes can find me anywhere I go."
	icon_state = "curse"

// Hook into the ambush system to remove the curse when an ambush triggers
// This will be called from the ambush code when an ambush successfully triggers
/mob/living/proc/check_curse_of_woe_ambush()
	if(has_status_effect(/datum/status_effect/debuff/curse_of_woe))
		remove_status_effect(/datum/status_effect/debuff/curse_of_woe)
		visible_message(span_warning("The curse upon [src] seems to fade away!"))
		return TRUE
	return FALSE
