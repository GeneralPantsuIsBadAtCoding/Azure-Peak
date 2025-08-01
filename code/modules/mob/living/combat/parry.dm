/mob/living/proc/attempt_parry(datum/intent/intenty, mob/living/user)
	var/prob2defend = user.defprob
	var/mob/living/H = src
	var/mob/living/U = user
	if(H && U)
		prob2defend = 0
	
	if(!can_see_cone(user))
		if(d_intent == INTENT_PARRY)
			return FALSE
		else
			prob2defend = max(prob2defend-15,0)

//	if(!cmode) // not currently used, see cmode check above
//		prob2defend = max(prob2defend-15,0)

	if(m_intent == MOVE_INTENT_RUN)
		prob2defend = max(prob2defend-15,0)

	if(HAS_TRAIT(src, TRAIT_CHUNKYFINGERS))
		return FALSE
	if(pulledby || pulling)
		return FALSE
	if(world.time < last_parry + setparrytime)
		if(!istype(rmb_intent, /datum/rmb_intent/riposte))
			return FALSE
	if(has_status_effect(/datum/status_effect/debuff/exposed))
		return FALSE
	if(has_status_effect(/datum/status_effect/debuff/riposted))
		return FALSE
	last_parry = world.time
	if(intenty && !intenty.canparry)
		return FALSE
	var/drained = BASE_PARRY_STAMINA_DRAIN
	var/weapon_parry = FALSE
	var/offhand_defense = 0
	var/mainhand_defense = 0
	var/highest_defense = 0
	var/obj/item/mainhand = get_active_held_item()
	var/obj/item/offhand = get_inactive_held_item()
	var/obj/item/used_weapon = mainhand
	var/obj/item/rogueweapon/shield/buckler/skiller = get_inactive_held_item()  // buckler code
	var/obj/item/rogueweapon/shield/buckler/skillerbuck = get_active_held_item()

	if(istype(offhand, /obj/item/rogueweapon/shield/buckler))
		skiller.bucklerskill(H)
	if(istype(mainhand, /obj/item/rogueweapon/shield/buckler))
		skillerbuck.bucklerskill(H)  //buckler code end

	if(mainhand)
		if(mainhand.can_parry)
			mainhand_defense += (H.get_skill_level(mainhand.associated_skill) * 20)
			mainhand_defense += (mainhand.wdefense_dynamic * 10)
	if(offhand)
		if(offhand.can_parry)
			offhand_defense += (H.get_skill_level(offhand.associated_skill) * 20)
			offhand_defense += (offhand.wdefense_dynamic * 10)

	if(mainhand_defense >= offhand_defense)
		highest_defense += mainhand_defense
	else
		used_weapon = offhand
		highest_defense += offhand_defense

	var/defender_skill = 0
	var/attacker_skill = 0

	if(highest_defense <= (H.get_skill_level(/datum/skill/combat/unarmed) * 20))
		defender_skill = H.get_skill_level(/datum/skill/combat/unarmed)
		var/obj/B = H.get_item_by_slot(SLOT_WRISTS)
		if(istype(B, /obj/item/clothing/wrists/roguetown/bracers))
			prob2defend += (defender_skill * 30)
		else
			prob2defend += (defender_skill * 10)		// no bracers gonna be butts.
		weapon_parry = FALSE
	else
		if(used_weapon)
			defender_skill = H.get_skill_level(used_weapon.associated_skill)
		else
			defender_skill = H.get_skill_level(/datum/skill/combat/unarmed)
		prob2defend += highest_defense
		weapon_parry = TRUE

	if(U.mind)
		if(intenty.masteritem)
			attacker_skill = U.get_skill_level(intenty.masteritem.associated_skill)
			prob2defend -= (attacker_skill * 20)
			if((intenty.masteritem.wbalance == WBALANCE_SWIFT) && (user.STASPD > src.STASPD)) //enemy weapon is quick, so get a bonus based on spddiff
				var/spdmod = ((user.STASPD - src.STASPD) * 10)
				var/permod = ((src.STAPER - user.STAPER) * 10)
				var/intmod = ((src.STAINT - user.STAINT) * 3)
				if(mind)
					if(permod > 0)
						spdmod -= permod
					if(intmod > 0)
						spdmod -= intmod
				var/finalmod = spdmod
				if(mind)
					finalmod = clamp(spdmod, 0, 30)
				prob2defend -= finalmod
		else
			attacker_skill = U.get_skill_level(/datum/skill/combat/unarmed)
			prob2defend -= (attacker_skill * 20)

	if(HAS_TRAIT(src, TRAIT_GUIDANCE))
		prob2defend += 20

	if(HAS_TRAIT(user, TRAIT_GUIDANCE))
		prob2defend -= 20
	
	if(HAS_TRAIT(user, TRAIT_CURSE_RAVOX))
		prob2defend -= 40

	// parrying while knocked down sucks ass
	if(!(mobility_flags & MOBILITY_STAND))
		prob2defend *= 0.65

	if(HAS_TRAIT(H, TRAIT_SENTINELOFWITS))
		if(ishuman(H))
			var/mob/living/carbon/human/SH = H
			var/sentinel = SH.calculate_sentinel_bonus()
			prob2defend += sentinel

	prob2defend = clamp(prob2defend, 5, 90)
	if(HAS_TRAIT(user, TRAIT_HARDSHELL) && H.client)	//Dwarf-merc specific limitation w/ their armor on in pvp
		prob2defend = clamp(prob2defend, 5, 70)
	if(!H?.check_armor_skill())
		prob2defend = clamp(prob2defend, 5, 75)			//Caps your max parry to 75 if using armor you're not trained in. Bad dexerity.
		drained = drained + 5							//More stamina usage for not being trained in the armor you're using.

	//Dual Wielding
	var/attacker_dualw
	var/defender_dualw
	var/extraattroll
	var/extradefroll

	//Dual Wielder defense disadvantage
	if(HAS_TRAIT(src, TRAIT_DUALWIELDER) && istype(offhand, mainhand))
		extradefroll = prob(prob2defend)
		defender_dualw = TRUE

	//Dual Wielder attack advantage
	var/obj/item/mainh = user.get_active_held_item()
	var/obj/item/offh = user.get_inactive_held_item()
	if(mainh && offh && HAS_TRAIT(user, TRAIT_DUALWIELDER))
		if(istype(mainh, offh))
			extraattroll = prob(prob2defend)
			attacker_dualw = TRUE

	if(src.client?.prefs.showrolls)
		var/text = "Roll to parry... [prob2defend]%"
		if((defender_dualw || attacker_dualw))
			if(defender_dualw && attacker_dualw)
				text += " Our dual wielding cancels out!"
			else//If we're defending against or as a dual wielder, we roll disadv. But if we're both dual wielding it cancels out.
				text += " Twice! Disadvantage! ([(prob2defend / 100) * (prob2defend / 100) * 100]%)"
		to_chat(src, span_info("[text]"))
	
	var/attacker_feedback 
	if(user.client?.prefs.showrolls && (attacker_dualw || defender_dualw))
		attacker_feedback = "Attacking with advantage. ([100 - ((prob2defend / 100) * (prob2defend / 100) * 100)]%)"

	var/parry_status = FALSE
	if((defender_dualw && attacker_dualw) || (!defender_dualw && !attacker_dualw)) //They cancel each other out
		if(attacker_feedback)
			attacker_feedback = "Advantage cancelled out!"
		if(prob(prob2defend))
			parry_status = TRUE
	else if(attacker_dualw)
		if(prob(prob2defend) && extraattroll)
			parry_status = TRUE
	else if(defender_dualw)
		if(prob(prob2defend) && extradefroll)
			parry_status = TRUE

	if(attacker_feedback)
		to_chat(user, span_info("[attacker_feedback]"))

	if(parry_status)
		if(intenty.masteritem)
			if(intenty.masteritem.wbalance < 0 && user.STASTR > src.STASTR) //enemy weapon is heavy, so get a bonus scaling on strdiff
				drained = drained + ( intenty.masteritem.wbalance * ((user.STASTR - src.STASTR) * -5) )
	else
		to_chat(src, span_warning("The enemy defeated my parry!"))
		if(HAS_TRAIT(src, TRAIT_MAGEARMOR))
			if(H.magearmor == 0)
				H.magearmor = 1
				H.apply_status_effect(/datum/status_effect/buff/magearmor)
				to_chat(src, span_boldwarning("My mage armor absorbs the hit and dissipates!"))
				return TRUE
			else
				return FALSE
		else
			return FALSE

	drained = max(drained, 5)

	var/exp_multi = 1

	if(!U.mind)
		exp_multi = exp_multi/2
	if(istype(user.rmb_intent, /datum/rmb_intent/weak))
		exp_multi = exp_multi/2

	if(weapon_parry == TRUE)
		if(do_parry(used_weapon, drained, user)) //show message
			if ((mobility_flags & MOBILITY_STAND))
				var/skill_target = attacker_skill
				if(!HAS_TRAIT(U, TRAIT_GOODTRAINER))
					skill_target -= SKILL_LEVEL_NOVICE
				if (can_train_combat_skill(src, used_weapon.associated_skill, skill_target))
					mind.add_sleep_experience(used_weapon.associated_skill, max(round(STAINT*exp_multi), 0), FALSE)

			var/obj/item/AB = intenty.masteritem

			//attacker skill gain

			if(U.mind)
				var/attacker_skill_type
				if(AB)
					attacker_skill_type = AB.associated_skill
				else
					attacker_skill_type = /datum/skill/combat/unarmed
				if ((mobility_flags & MOBILITY_STAND))
					var/skill_target = defender_skill
					if(!HAS_TRAIT(src, TRAIT_GOODTRAINER))
						skill_target -= SKILL_LEVEL_NOVICE
					if (can_train_combat_skill(U, attacker_skill_type, skill_target))
						U.mind.add_sleep_experience(attacker_skill_type, max(round(STAINT*exp_multi), 0), FALSE)

			if(prob(66) && AB)
				if((used_weapon.flags_1 & CONDUCT_1) && (AB.flags_1 & CONDUCT_1))
					flash_fullscreen("whiteflash")
					user.flash_fullscreen("whiteflash")
					var/datum/effect_system/spark_spread/S = new()
					var/turf/front = get_step(src,src.dir)
					S.set_up(1, 1, front)
					S.start()
				else
					flash_fullscreen("blackflash2")
			else
				flash_fullscreen("blackflash2")

			var/dam2take = round((get_complex_damage(AB,user,used_weapon.blade_dulling)/2),1)
			if(dam2take)
				if(!user.mind)
					dam2take = dam2take * 0.25
				if(dam2take > 0 && (intenty.masteritem?.intdamage_factor != 1 || intenty.intent_intdamage_factor != 1))
					var/higher_intfactor = max(intenty.masteritem?.intdamage_factor, intenty.intent_intdamage_factor)
					var/lowest_intfactor = min(intenty.masteritem?.intdamage_factor, intenty.intent_intdamage_factor)
					var/used_intfactor
					if(lowest_intfactor < 1)	//Our intfactor multiplier can be either 0 to 1, or 1 to whatever.
						used_intfactor = lowest_intfactor
					if(higher_intfactor > 1)	//Make sure to keep your weapon and intent intfactors consistent to avoid problems here!
						used_intfactor = higher_intfactor
					dam2take *= used_intfactor
			else	//This is normally handled in get_complex_damage, but it doesn't support simple mobs... at all, so we do a clunky mini-version of it.
				if(istype(user, /mob/living/simple_animal))
					var/mob/living/simple_animal/SM = user
					dam2take = rand(SM.melee_damage_lower, SM.melee_damage_upper)
					dam2take *= (SM.STASTR / 10)
					dam2take *= 0.25
					switch(used_weapon.blade_dulling)
						if(DULLING_SHAFT_CONJURED)
							dam2take *= 1.3
						if(DULLING_SHAFT_METAL)
							switch(SM.d_type)
								if("slash")
									dam2take *= 0.5
								if("blunt")
									dam2take *= 1.5
						if(DULLING_SHAFT_WOOD)
							switch(SM.d_type)
								if("slash")
									dam2take *= 1.5
								if("blunt")
									dam2take *= 0.5
						if(DULLING_SHAFT_REINFORCED)
							switch(SM.d_type)
								if("slash")
									dam2take *= 0.75
								if("stab")
									dam2take *= 1.5
			used_weapon.take_damage(max(dam2take,1), BRUTE, used_weapon.d_type)
			return TRUE
		else
			return FALSE

	if(weapon_parry == FALSE)
		if(do_unarmed_parry(drained, user))
			if((mobility_flags & MOBILITY_STAND))
				var/skill_target = attacker_skill
				if(!HAS_TRAIT(U, TRAIT_GOODTRAINER))
					skill_target -= SKILL_LEVEL_NOVICE
				if(can_train_combat_skill(H, /datum/skill/combat/unarmed, skill_target))
					H.mind?.add_sleep_experience(/datum/skill/combat/unarmed, max(round(STAINT*exp_multi), 0), FALSE)
			flash_fullscreen("blackflash2")
			return TRUE
		else
			testing("failparry")
			return FALSE

/mob/proc/do_parry(obj/item/W, parrydrain as num, mob/living/user)
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(H.stamina_add(parrydrain))
			if(W)
				playsound(get_turf(src), pick(W.parrysound), 100, FALSE)
			if(src.client)
				GLOB.azure_round_stats[STATS_PARRIES]++
			if(istype(rmb_intent, /datum/rmb_intent/riposte))
				src.visible_message(span_boldwarning("<b>[src]</b> ripostes [user] with [W]!"))
			else
				src.visible_message(span_boldwarning("<b>[src]</b> parries [user] with [W]!"))
			return TRUE
		else
			to_chat(src, span_warning("I'm too tired to parry!"))
			return FALSE //crush through
	else
		if(W)
			playsound(get_turf(src), pick(W.parrysound), 100, FALSE)
		return TRUE

/mob/proc/do_unarmed_parry(parrydrain as num, mob/living/user)
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(H.stamina_add(parrydrain))
			playsound(get_turf(src), pick(parry_sound), 100, FALSE)
			src.visible_message(span_warning("<b>[src]</b> parries [user]!"))
			if(src.client)
				GLOB.azure_round_stats[STATS_PARRIES]++
			return TRUE
		else
			to_chat(src, span_boldwarning("I'm too tired to parry!"))
			return FALSE
	else
		if(src.client)
			GLOB.azure_round_stats[STATS_PARRIES]++
		playsound(get_turf(src), pick(parry_sound), 100, FALSE)
		return TRUE
