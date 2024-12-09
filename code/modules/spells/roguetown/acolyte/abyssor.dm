//t1, the bends
/obj/effect/proc_holder/spell/invoked/abyssor_bends
	name = "Depth Bends"
	overlay_state = "thebends"
	releasedrain = 15
	chargedrain = 0
	chargetime = 2 SECONDS
	range = 15
	movement_interrupt = FALSE
	chargedloop = null
	sound = 'sound/foley/bubb (5).ogg'
	invocation = "Weight of the deep, crush!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 20 SECONDS
	miracle = TRUE
	devotion_cost = 15

/obj/effect/proc_holder/spell/invoked/abyssor_bends/cast(list/targets, mob/user = usr)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		user.visible_message("<font color='yellow'>[user] makes a fist at [target]!</font>")
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.adjustStaminaLoss(125)
		target.Dizzy(10)
		target.blur_eyes(20)
		target.emote("drown")
		return TRUE
	revert_cast()
	return FALSE
//T2, Abyssal Healing. Totally stole most of this from lesser heal.
/obj/effect/proc_holder/spell/invoked/abyssheal
	name = "Abyssal Healing"
	overlay_state = "thebends"
	releasedrain = 50
	chargedrain = 0
	chargetime = 1 SECONDS
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/foley/waterenter.ogg'
	invocation = "Healing waters, come forth!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 10 SECONDS
	miracle = TRUE
	devotion_cost = 50

/obj/effect/proc_holder/spell/invoked/abyssheal/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(user.patron?.undead_hater && (target.mob_biotypes & MOB_UNDEAD)) //THE DEEP CALLS- sorry, the pressure of the deep falls upon those of the undead ilk
			target.visible_message(span_danger("[target] is crushed by divine pressure!"), span_userdanger("I'm crushed by divine pressure!"))
			target.adjustBruteLoss(30)			
			return TRUE
		var/conditional_buff = FALSE
		var/situational_bonus = 1
		target.visible_message(span_info("A wave of divine energy crashes over [target]!"), span_notice("I'm crushed by healing energies!"))
		var/list/water = list(/turf/open/water/bath, /turf/open/water/ocean, /turf/open/water/cleanshallow, /turf/open/water/swamp, /turf/open/water/swamp/deep, /turf/open/water/pond, /turf/open/water/river)
		situational_bonus = 0
		// the more warter around us, the more we heal
		for (var/turf/O in oview(3, user))
			if (O in water)
				situational_bonus = min(situational_bonus + 0.1, 2)
		for (var/turf/open/water/ocean/deep/O in oview(3, user))
			situational_bonus += 0.5
		// Healing by the deep sea gives an extra boost.
		if (situational_bonus > 0)
			conditional_buff = TRUE
		var/healing = 6.5
		target.adjustFireLoss(-80)
		if (conditional_buff)
			to_chat(user, "Calling upon Abyssor's power is easier in these conditions!")
			healing += situational_bonus
			target.adjustFireLoss(-40)
		target.apply_status_effect(/datum/status_effect/buff/healing, healing)
		return TRUE
	revert_cast()
	return FALSE
//t3 alt, land surf, i just removed it but if this idea is like better... we'll see

//t3, possible t4 if I put in land surf, summon mossback
/obj/effect/proc_holder/spell/invoked/call_mossback
	name = "Call Mossback"
	overlay_state = "thebends"
	range = 7
	no_early_release = TRUE
	charging_slowdown = 1
	releasedrain = 100
	chargedrain = 0
	chargetime = 2 SECONDS
	chargedloop = null
	sound = 'sound/foley/bubb (1).ogg'
	invocation = "From the abyss, rise!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 180 SECONDS
	miracle = TRUE
	devotion_cost = 100
	var/townercrab = FALSE
/obj/effect/proc_holder/spell/invoked/call_mossback/cast(list/targets, mob/living/user)
	. = ..()
	var/turf/T = get_turf(targets[1])
	if(isopenturf(T))
		new /mob/living/simple_animal/hostile/retaliate/rogue/mossback(T, user, townercrab)
		return TRUE
	else
		to_chat(user, span_warning("The targeted location is blocked. My call fails to draw a mossback."))
		return FALSE