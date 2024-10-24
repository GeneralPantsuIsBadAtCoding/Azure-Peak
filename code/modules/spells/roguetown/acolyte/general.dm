// Lesser miracle
/obj/effect/proc_holder/spell/invoked/lesser_heal
	name = "Lesser Miracle"
	overlay_state = "lesserheal"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/heal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 10 SECONDS
	miracle = TRUE
	devotion_cost = 10

/obj/effect/proc_holder/spell/invoked/lesser_heal/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(user.patron?.undead_hater && (target.mob_biotypes & MOB_UNDEAD)) //positive energy harms the undead
			target.visible_message(span_danger("[target] is burned by holy light!"), span_userdanger("I'm burned by holy light!"))
			target.adjustFireLoss(10)
			target.fire_act(1,10)
			return TRUE
		var/conditional_buff = FALSE
		var/situational_bonus = 10
		//this if chain is stupid, replace with variables on /datum/patron when possible?
		switch(user.patron.type)
			if(/datum/patron/old_god)
				target.visible_message(span_info("A strange stirring feeling pours from [target]!"), span_notice("Sentimental thoughts drive away my pains!"))
			if(/datum/patron/divine/astrata)
				target.visible_message(span_info("A wreath of gentle light passes over [target]!"), span_notice("I'm bathed in holy light!"))
				// during the day, heal 10 more (basic as fuck)
				if (GLOB.tod == "day")
					conditional_buff = TRUE
			if(/datum/patron/divine/noc)
				target.visible_message(span_info("A shroud of soft moonlight falls upon [target]!"), span_notice("I'm shrouded in gentle moonlight!"))
				// during the night, heal 10 more (i wish this was more interesting but they're twins so whatever)
				if (GLOB.tod == "day")
					conditional_buff = TRUE
			if(/datum/patron/divine/dendor)
				target.visible_message(span_info("A rush of primal energy spirals about [target]!"), span_notice("I'm infused with primal energies!"))
				var/list/natural_stuff = list(/obj/structure/flora/roguegrass, /obj/structure/flora/roguetree, /obj/structure/flora/rogueshroom, /obj/structure/soil)
				situational_bonus = 0
				// the more natural stuff around US, the more we heal
				for (var/obj/O in oview(5, user))
					if (O in natural_stuff)
						situational_bonus = min(situational_bonus + 1, 25)
				if (situational_bonus > 0)
					conditional_buff = TRUE
			if(/datum/patron/divine/abyssor)
				target.visible_message(span_info("A mist of salt-scented vapour settles on [target]!"), span_notice("I'm invigorated by healing vapours!"))
				// if our target is standing in water, heal a flat amount extra
				if (istype(get_turf(target), /turf/open/water))
					conditional_buff = TRUE
					situational_bonus = 15
			if(/datum/patron/divine/ravox)
				target.visible_message(span_info("An air of righteous defiance rises near [target]!"), span_notice("I'm filled with an urge to fight on!"))
				situational_bonus = 0
				// the bloodier the area around our target is, the more we heal
				for (var/obj/effect/decal/cleanable/blood/O in oview(5, target))
					situational_bonus = min(situational_bonus + 1, 25)
				conditional_buff = TRUE
			if(/datum/patron/divine/necra)
				target.visible_message(span_info("A sense of quiet respite radiates from [target]!"), span_notice("I feel the Undermaiden's gaze turn from me for now!"))
				if (iscarbon(target))
					var/mob/living/carbon/C = target
					// if the target is "close to death" (at or below 25% health)
					if (C.health <= (C.maxHealth * 0.25))
						conditional_buff = TRUE
						situational_bonus = 25
			if(/datum/patron/divine/xylix)
				target.visible_message(span_info("A fugue seems to manifest briefly across [target]!"), span_notice("My wounds vanish as if they had never been there! "))
				// half of the time, heal a little (or a lot) more - flip the coin
				if (prob(50))
					conditional_buff = TRUE
					situational_bonus = rand(1, 25)
			if(/datum/patron/divine/pestra)
				target.visible_message(span_info("An aura of clinical care encompasses [target]!"), span_notice("I'm sewn back together by sacred medicine!"))
				// pestra always heals a little more toxin damage and restores a bit more blood
				target.adjustToxLoss(-situational_bonus)
				target.blood_volume += BLOOD_VOLUME_SURVIVE/2
			if(/datum/patron/divine/malum)
				target.visible_message("<span class='info'>A tempering heat is discharged out of [target]!</span>", "<span class='notice'>I feel the heat of a forge soothing my pains!</span>")
				var/list/firey_stuff = list(/obj/machinery/light/rogue/torchholder, /obj/machinery/light/rogue/campfire, /obj/machinery/light/rogue/hearth, /obj/machinery/light/rogue/wallfire, /obj/machinery/light/rogue/wallfire/candle, /obj/machinery/light/rogue/forge)
				// extra healing for every source of fire/light near us
				situational_bonus = 0
				for (var/obj/O in oview(5, user))
					if (O in firey_stuff)
						situational_bonus = min(situational_bonus + 5, 25)
				if (situational_bonus > 0)
					conditional_buff = TRUE
			if(/datum/patron/divine/eora)
				target.visible_message("<span class='info'>An emanance of love blossoms around [target]!</span>", "<span class='notice'>I'm filled with the restorative warmth of love!</span>")
				// if they're wearing an eoran bud (or are a pacifist), pretty much double the healing. if we're also wearing a bud at any point or a pacifist from any other source, apply another +15 bonus
				situational_bonus = 0
				if (HAS_TRAIT(target, TRAIT_PACIFISM))
					conditional_buff = TRUE
					situational_bonus = 25
				if (HAS_TRAIT(user, TRAIT_PACIFISM))
					conditional_buff = TRUE
					situational_bonus += 15
			if(/datum/patron/inhumen/zizo)
				target.visible_message(span_info("Vital energies are sapped towards [target]!"), span_notice("The life around me pales as I am restored!"))
				// set up a ritual pile of bones (or just cast near a stack of bones whatever) around us for massive bonuses, cap at 50 for 75 healing total (wowie)
				situational_bonus = 0
				for (var/obj/item/stack/sheet/bone/O in oview(5, user))
					situational_bonus += (O.amount * 5)
				if (situational_bonus > 0)
					conditional_buff = TRUE
					situational_bonus = min(situational_bonus, 50)
			if(/datum/patron/inhumen/graggar)
				target.visible_message(span_info("Foul fumes billow outward as [target] is restored!"), span_notice("A noxious scent burns my nostrils, but I feel better!"))
				// if you've got lingering toxin damage, you get healed more, but your bonus healing doesn't affect toxin
				var/toxloss = target.getToxLoss()
				if (toxloss >= 10)
					conditional_buff = TRUE
					situational_bonus = 25
					target.adjustToxLoss(situational_bonus) // remember we do a global toxloss adjust down below so this is okay
			if(/datum/patron/inhumen/matthios)
				target.visible_message(span_info("A wreath of... strange light passes over [target]?"), span_notice("I'm bathed in a... strange holy light?"))
				// COMRADES! WE MUST BAND TOGETHER!
				if (HAS_TRAIT(target, TRAIT_COMMIE))
					conditional_buff = TRUE
					situational_bonus = 25
			if(/datum/patron/inhumen/baotha)
				target.visible_message(span_info("Hedonistic impulses and emotions throb all about from [target]."), span_notice("An intoxicating rush of narcotic delight wipes away my pains!"))
				// i wanted to do something with pain here but it doesn't seem like pain is actually parameterized anywhere so... better necra it is - if they're below 50% health, they get 25 extra healing
				if (iscarbon(target))
					var/mob/living/carbon/C = target
					if (C.health <= (C.maxHealth * 0.5))
						conditional_buff = TRUE
						situational_bonus = 25
			if(/datum/patron/godless)
				target.visible_message(span_info("Without any particular cause or reason, [target] is healed!"), span_notice("My wounds close without cause."))
			else
				target.visible_message(span_info("A choral sound comes from above and [target] is healed!"), span_notice("I am bathed in healing choral hymns!"))

		var/healing = 25
		if (conditional_buff)
			to_chat(user, "Channeling my patron's power is easier in these conditions!")
			healing += situational_bonus

		if(iscarbon(target))
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
			if(affecting)
				if(affecting.heal_damage(healing, healing))
					C.update_damage_overlays()
				if(affecting.heal_wounds(healing))
					C.update_damage_overlays()
		else
			target.adjustBruteLoss(-healing)
			target.adjustFireLoss(-healing)
		target.adjustToxLoss(-healing)
		target.adjustOxyLoss(-healing)
		return TRUE
	return FALSE

// Miracle
/obj/effect/proc_holder/spell/invoked/heal
	name = "Miracle"
	overlay_state = "astrata"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
//	chargedloop = /datum/looping_sound/invokeholy
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/heal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 20 SECONDS
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/invoked/heal/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(user.patron?.undead_hater && (target.mob_biotypes & MOB_UNDEAD)) //positive energy harms the undead
			target.visible_message(span_danger("[target] is burned by holy light!"), span_userdanger("I'm burned by holy light!"))
			target.adjustFireLoss(25)
			target.fire_act(1,10)
			return TRUE
		target.visible_message(span_info("A wreath of gentle light passes over [target]!"), span_notice("I'm bathed in holy light!"))
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
			if(affecting)
				if(affecting.heal_damage(50, 50))
					C.update_damage_overlays()
				if(affecting.heal_wounds(50))
					C.update_damage_overlays()
		else
			target.adjustBruteLoss(-50)
			target.adjustFireLoss(-50)
		target.adjustToxLoss(-50)
		target.adjustOxyLoss(-50)
		target.blood_volume += BLOOD_VOLUME_SURVIVE
		return TRUE
	return FALSE
