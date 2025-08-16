// Lesser miracle
/obj/effect/proc_holder/spell/invoked/lesser_heal
	name = "Miracle"
	desc = "Heals target over time, causes damage if something is embedded in target. Burns undead instead of healing them if you worship the Ten.<br>Does not work on those worshipping the dead god."
	overlay_state = "lesserheal"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 4
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/heal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 10 SECONDS
	miracle = TRUE
	devotion_cost = 10

/obj/effect/proc_holder/spell/invoked/lesser_heal/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(HAS_TRAIT(target, TRAIT_PSYDONITE))
			target.visible_message(span_info("[target] stirs for a moment, the miracle dissipates."), span_notice("A dull warmth swells in your heart, only to fade as quickly as it arrived."))
			user.playsound_local(user, 'sound/magic/PSY.ogg', 100, FALSE, -1)
			playsound(target, 'sound/magic/PSY.ogg', 100, FALSE, -1)
			return FALSE
		if(user.patron?.undead_hater && (target.mob_biotypes & MOB_UNDEAD)) //positive energy harms the undead
			target.visible_message(span_danger("[target] is burned by holy light!"), span_userdanger("I'm burned by holy light!"))
			target.adjustFireLoss(10)
			target.fire_act(1,10)
			return TRUE
		if(target.has_status_effect(/datum/status_effect/buff/healing))
			to_chat(user, span_warning("They are already under the effects of a healing aura!"))
			revert_cast()
			return FALSE
		var/conditional_buff = FALSE
		var/situational_bonus = 1
		var/message_out
		var/message_self
		//this if chain is stupid, replace with variables on /datum/patron when possible?
		switch(user.patron.type)
			if(/datum/patron/divine/astrata)
				message_out = span_info("A wreath of gentle light passes over [target]!")
				message_self = ("I'm bathed in holy light!")
				// during the day, heal 1 more (basic as fuck)
				if (GLOB.tod == "day")
					conditional_buff = TRUE
					situational_bonus = 2
				// Day is 1/4th as long as night. Noc priests get a bonus for four times as long and during peak conflict hours, thus Astratans should have more powerful heals
			if(/datum/patron/divine/noc)
				message_out = span_info("A shroud of soft moonlight falls upon [target]!")
				message_self = span_notice("I'm shrouded in gentle moonlight!")
				// during the night, heal 1 more (i wish this was more interesting but they're twins so whatever)
				if (GLOB.tod == "night")
					conditional_buff = TRUE
			if(/datum/patron/divine/dendor)
				message_out = span_info("A rush of primal energy spirals about [target]!")
				message_self = span_notice("I'm infused with primal energies!")
				var/list/natural_stuff = list(/obj/structure/flora/roguegrass, /obj/structure/flora/roguetree, /obj/structure/flora/rogueshroom, /obj/structure/soil, /obj/structure/flora/newtree, /obj/structure/flora/tree, /obj/structure/glowshroom)
				situational_bonus = 0
				// the more natural stuff around US, the more we heal
				for (var/obj/O in oview(5, user))
					if (O in natural_stuff)
						situational_bonus = min(situational_bonus + 0.1, 2)
				for (var/obj/structure/flora/roguetree/wise/O in oview(5, user))
					situational_bonus += 1.5
				// Healing before the oaken avatar of Dendor in the Druid Grove (exceptionally rare otherwise) supercharges their healing
				if (situational_bonus > 0)
					conditional_buff = TRUE
			if(/datum/patron/divine/abyssor)
				message_out = span_info("A mist of salt-scented vapour settles on [target]!")
				message_self = span_notice("I'm invigorated by healing vapours!")
				// if our target is standing in water, heal a flat amount extra
				if (istype(get_turf(target), /turf/open/water))
					conditional_buff = TRUE
					situational_bonus = 1.5
			if(/datum/patron/divine/ravox)
				message_out = span_info("An air of righteous defiance rises near [target]!")
				message_self = span_notice("I'm filled with an urge to fight on!")
				situational_bonus = 0
				// the bloodier the area around our target is, the more we heal
				for (var/obj/effect/decal/cleanable/blood/O in oview(5, target))
					situational_bonus = min(situational_bonus + 0.1, 2)
				conditional_buff = TRUE
			if(/datum/patron/divine/necra)
				message_out = span_info("A sense of quiet respite radiates from [target]!")
				message_self = span_notice("I feel the Undermaiden's gaze turn from me for now!")
				if (iscarbon(target))
					var/mob/living/carbon/C = target
					// if the target is "close to death" (at or below 25% health)
					if (C.health <= (C.maxHealth * 0.25))
						conditional_buff = TRUE
						situational_bonus = 2.5
			if(/datum/patron/divine/xylix)
				message_out = span_info("A fugue seems to manifest briefly across [target]!")
				message_self = span_notice("My wounds vanish as if they had never been there! ")
				// half of the time, heal a little (or a lot) more - flip the coin
				if (prob(50))
					conditional_buff = TRUE
					situational_bonus = rand(1, 2.5)
			if(/datum/patron/divine/pestra)
				message_out = span_info("An aura of clinical care encompasses [target]!")
				message_self = span_notice("I'm sewn back together by sacred medicine!")
				// pestra always heals a little more toxin damage and restores a bit more blood
				target.adjustToxLoss(-situational_bonus)
				target.blood_volume += BLOOD_VOLUME_SURVIVE/3
			if(/datum/patron/divine/malum)
				message_out = span_info("A tempering heat is discharged out of [target]!")
				message_self = span_info("I feel the heat of a forge soothing my pains!")
				var/list/firey_stuff = list(/obj/machinery/light/rogue/torchholder, /obj/machinery/light/rogue/campfire, /obj/machinery/light/rogue/hearth, /obj/machinery/light/rogue/wallfire, /obj/machinery/light/rogue/wallfire/candle, /obj/machinery/light/rogue/forge)
				// extra healing for every source of fire/light near us
				situational_bonus = 0
				for (var/obj/O in oview(5, user))
					if (O.type in firey_stuff)
						situational_bonus = min(situational_bonus + 0.5, 2.5)
				if (situational_bonus > 0)
					conditional_buff = TRUE
			if(/datum/patron/divine/eora)
				message_out = span_info("An emanance of love blossoms around [target]!")
				message_self = span_notice("I'm filled with the restorative warmth of love!")
				// if they're wearing an eoran bud (or are a pacifist), pretty much double the healing. if we're also wearing a bud at any point or a pacifist from any other source, apply another +15 bonus
				situational_bonus = 0
				if (HAS_TRAIT(target, TRAIT_PACIFISM))
					conditional_buff = TRUE
					situational_bonus = 2.5
				if (HAS_TRAIT(user, TRAIT_PACIFISM))
					conditional_buff = TRUE
					situational_bonus += 1.5
			if(/datum/patron/inhumen/zizo)
				message_out = span_info("Vital energies are sapped towards [target]!")
				message_self = span_notice("The life around me pales as I am restored!")
				// set up a ritual pile of bones (or just cast near a stack of bones whatever) around us for massive bonuses, cap at 50 for 75 healing total (wowie)
				situational_bonus = 0
				for (var/obj/item/natural/bone/O in oview(5, user))
					situational_bonus += (0.5)
				for (var/obj/item/natural/bundle/bone/S in oview(5, user))
					situational_bonus += (S.amount * 0.5)
				if (situational_bonus > 0)
					conditional_buff = TRUE
					situational_bonus = min(situational_bonus, 5)
			if(/datum/patron/inhumen/graggar)
				message_out = span_info("Foul fumes billow outward as [target] is restored!")
				message_self = span_notice("A noxious scent burns my nostrils, but I feel better!")
				// if you've got lingering toxin damage, you get healed more, but your bonus healing doesn't affect toxin
				var/toxloss = target.getToxLoss()
				if (toxloss >= 10)
					conditional_buff = TRUE
					situational_bonus = 2.5
					target.adjustToxLoss(situational_bonus) // remember we do a global toxloss adjust down below so this is okay
			if(/datum/patron/inhumen/matthios)
				message_out = span_info("A wreath of... strange light passes over [target]?")
				message_self = span_notice("I'm bathed in a... strange holy light?")
				// COMRADES! WE MUST BAND TOGETHER!
				if (HAS_TRAIT(target, TRAIT_COMMIE))
					conditional_buff = TRUE
					situational_bonus = 2.5
			if(/datum/patron/inhumen/baotha)
				message_out = span_info("Hedonistic impulses and emotions throb all about from [target].")
				message_self = span_notice("An intoxicating rush of narcotic delight wipes away my pains!")
				// i wanted to do something with pain here but it doesn't seem like pain is actually parameterized anywhere so... better necra it is - if they're below 50% health, they get 25 extra healing
				if (iscarbon(target))
					var/mob/living/carbon/C = target
					if (C.health <= (C.maxHealth * 0.5))
						conditional_buff = TRUE
						situational_bonus = 2.5
			if(/datum/patron/godless)
				message_out = span_info("Without any particular cause or reason, [target] is healed!")
				message_self = span_notice("My wounds close without cause.")
			else
				message_out = span_info("A choral sound comes from above and [target] is healed!")
				message_self = span_notice("I am bathed in healing choral hymns!")

		var/healing = 2.5
		if (conditional_buff)
			to_chat(user, "Channeling my patron's power is easier in these conditions!")
			healing += situational_bonus

		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			var/no_embeds = TRUE
			var/list/embeds = H.get_embedded_objects()
			if(length(embeds))
				for(var/object in embeds)
					if(!istype(object, /obj/item/natural/worms/leech))	//Leeches and surgical cheeles are made an exception.
						no_embeds = FALSE
			else
				no_embeds = TRUE
			if(no_embeds)
				target.apply_status_effect(/datum/status_effect/buff/healing, healing)
			else
				message_out = span_warning("The wounds tear and rip around the embedded objects!")
				message_self = span_warning("Agonising pain shoots through your body as magycks try to sew around the embedded objects!")
				H.adjustBruteLoss(20)
				playsound(target, 'sound/combat/dismemberment/dismem (2).ogg', 100)
				H.emote("agony")
		else
			target.apply_status_effect(/datum/status_effect/buff/healing, healing)
		target.visible_message(message_out, message_self)
		return TRUE
	revert_cast()
	return FALSE

// Miracle
/obj/effect/proc_holder/spell/invoked/heal
	name = "Fortify"
	desc = "Improves the targets ability to receive healing, buffing all healing done on them by 50%<br>Burns undead instead of healing them if you worship the Ten."
	overlay_state = "astrata"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 4
	warnie = "sydwarning"
	movement_interrupt = FALSE
//	chargedloop = /datum/looping_sound/invokeholy
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/heal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 20 SECONDS
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/invoked/heal/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(HAS_TRAIT(target, TRAIT_PSYDONITE))
			target.visible_message(span_info("[target] stirs for a moment, the miracle dissipates."), span_notice("A dull warmth swells in your heart, only to fade as quickly as it arrived."))
			user.playsound_local(user, 'sound/magic/PSY.ogg', 100, FALSE, -1)
			playsound(target, 'sound/magic/PSY.ogg', 100, FALSE, -1)
			return FALSE
		if(user.patron?.undead_hater && (target.mob_biotypes & MOB_UNDEAD)) //positive energy harms the undead
			target.visible_message(span_danger("[target] is burned by holy light!"), span_userdanger("I'm burned by holy light!"))
			target.adjustFireLoss(25)
			target.fire_act(1,10)
			return TRUE
		target.visible_message(span_info("A wreath of gentle light passes over [target]!"), span_notice("I'm bathed in holy light!"))
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			C.apply_status_effect(/datum/status_effect/buff/fortify)
		else
			target.adjustBruteLoss(-50)
			target.adjustFireLoss(-50)
		return TRUE
	revert_cast()
	return FALSE

//Universal miracle T3 miracle.
//Instantly heals all wounds & damage on a selected limb.
//Long CD (so a Medical class would still outpace this if there's more than one patient to heal)
/obj/effect/proc_holder/spell/invoked/wound_heal
	name = "Wound Miracle"
	desc = "Heals all wounds on a targeted limb."
	overlay_icon = 'icons/mob/actions/genericmiracles.dmi'
	overlay_state = "woundheal"
	action_icon_state = "woundheal"
	action_icon = 'icons/mob/actions/genericmiracles.dmi'
	releasedrain = 15
	chargedrain = 0
	chargetime = 15
	range = 1
	ignore_los = FALSE
	warnie = "sydwarning"
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	sound = 'sound/magic/woundheal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 2 MINUTES
	miracle = TRUE
	devotion_cost = 100

/obj/effect/proc_holder/spell/invoked/wound_heal/cast(list/targets, mob/user = usr)
	if(ishuman(targets[1]))
		var/mob/living/carbon/human/target = targets[1]
		var/def_zone = check_zone(user.zone_selected)
		var/obj/item/bodypart/affecting = target.get_bodypart(def_zone)
		if(!affecting)
			revert_cast()
			return FALSE
		var/foundwound = FALSE
		if(length(affecting.wounds))
			for(var/datum/wound/wound in affecting.wounds)
				if(!isnull(wound))
					wound.heal_wound(wound.whp)
					foundwound = TRUE
					user.visible_message(("<font color = '#488f33'>[capitalize(wound.name)] oozes a clear fluid and closes shut!</font>"))
			if(foundwound)
				playsound(target, 'sound/magic/woundheal_crunch.ogg', 100, TRUE)
			affecting.change_bodypart_status(heal_limb = TRUE)
			affecting.update_disabled()
			return TRUE
		else
			to_chat(user, span_warning("The limb is free of wounds."))
			revert_cast()
			return FALSE
			

/obj/effect/proc_holder/spell/invoked/blood_heal
	name = "Bloodheal Miracle"
	desc = "Restores the blood of the target with divine magycks. Scales with holy skill."
	overlay_icon = 'icons/mob/actions/genericmiracles.dmi'
	overlay_state = "bloodheal"
	action_icon_state = "bloodheal"
	action_icon = 'icons/mob/actions/genericmiracles.dmi'
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 1
	ignore_los = FALSE
	warnie = "sydwarning"
	movement_interrupt = TRUE
	sound = 'sound/magic/bloodheal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 30 SECONDS
	miracle = TRUE
	devotion_cost = 80

/obj/effect/proc_holder/spell/invoked/blood_heal/cast(list/targets, mob/user = usr)
	if(ishuman(targets[1]))
		var/mob/living/carbon/human/target = targets[1]
		var/mob/living/L = user
		target.apply_status_effect(/datum/status_effect/buff/bloodheal, L.get_skill_level(associated_skill))
		return TRUE
	else
		revert_cast()
		return FALSE
