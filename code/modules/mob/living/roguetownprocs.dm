/proc/accuracy_check(zone, mob/living/user, mob/living/target, associated_skill, datum/intent/used_intent, obj/item/I)
	if(!zone)
		return
	if(user == target)
		return zone
	if(zone == BODY_ZONE_CHEST)
		return zone
	if(HAS_TRAIT(user, TRAIT_CIVILIZEDBARBARIAN) && (zone == BODY_ZONE_L_LEG || zone == BODY_ZONE_R_LEG))
		return zone
	if(target.grabbedby == user)
		if(user.grab_state >= GRAB_AGGRESSIVE)
			return zone
	if(!(target.mobility_flags & MOBILITY_STAND))
		return zone
	// If you're floored, you will aim feet and legs easily. There's a check for whether the victim is laying down already.
	if(!(user.mobility_flags & MOBILITY_STAND) && (zone in list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)))
		return zone
	if( (target.dir == turn(get_dir(target,user), 180)))
		return zone

	var/chance2hit = 0

	if(check_zone(zone) == zone)	//Are we targeting a big limb or chest?
		chance2hit += 10

	if(user.mind)
		chance2hit += (user.mind.get_skill_level(associated_skill) * 8)

	if(used_intent)
		if(used_intent.blade_class == BCLASS_STAB)
			chance2hit += 10
		if(used_intent.blade_class == BCLASS_PEEL)
			chance2hit += 25
		if(used_intent.blade_class == BCLASS_CUT)
			chance2hit += 6
		if((used_intent.blade_class == BCLASS_BLUNT || used_intent.blade_class == BCLASS_SMASH) && check_zone(zone) != zone)	//A mace can't hit the eyes very well
			chance2hit -= 10

	if(I)
		if(I.wlength == WLENGTH_SHORT)
			chance2hit += 10

	if(user.STAPER > 10)
		chance2hit += (min((user.STAPER-10)*8, 40))

	if(user.STAPER < 10)
		chance2hit -= ((10-user.STAPER)*10)

	if(istype(user.rmb_intent, /datum/rmb_intent/aimed))
		chance2hit += 20
	if(istype(user.rmb_intent, /datum/rmb_intent/swift))
		chance2hit -= 20

	chance2hit = CLAMP(chance2hit, 5, 93)

	if(prob(chance2hit))
		return zone
	else
		if(prob(chance2hit+(user.STAPER - 10)))
			if(check_zone(zone) == zone)
				return zone
			to_chat(user, span_warning("Accuracy fail! [chance2hit]%"))
			if(user.STAPER >= 11)
				if(user.client?.prefs.showrolls)
					return check_zone(zone)
			else
				return BODY_ZONE_CHEST
		else
			if(user.client?.prefs.showrolls)
				to_chat(user, span_warning("Double accuracy fail! [chance2hit]%"))
			return BODY_ZONE_CHEST

/mob/proc/get_generic_parry_drain()
	return 30

/mob/living/proc/checkmiss(mob/living/user)
	if(user == src)
		return FALSE
	if(stat)
		return FALSE
	if(!(mobility_flags & MOBILITY_STAND))
		return FALSE
	if(user.badluck(4))
		var/list/usedp = list("Critical miss!", "Damn! Critical miss!", "No! Critical miss!", "It can't be! Critical miss!", "Xylix laughs at me! Critical miss!", "Bad luck! Critical miss!", "Curse creation! Critical miss!", "What?! Critical miss!")
		to_chat(user, span_boldwarning("[pick(usedp)]"))
		flash_fullscreen("blackflash2")
		user.aftermiss()
		return TRUE


/mob/living/proc/checkdefense(datum/intent/intenty, mob/living/user)
	testing("begin defense")
	if(!cmode)
		return FALSE
	if(stat)
		return FALSE
	if(!canparry && !candodge) //mob can do neither of these
		return FALSE
	if(!cmode)
		return FALSE
	if(user == src)
		return FALSE
	if(!(mobility_flags & MOBILITY_MOVE))
		return FALSE

	if(client && used_intent)
		if(client.charging && used_intent.tranged && !used_intent.tshield)
			return FALSE

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

	switch(d_intent)
		if(INTENT_PARRY)
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
					mainhand_defense += (H.mind ? (H.mind.get_skill_level(mainhand.associated_skill) * 20) : 20)
					mainhand_defense += (mainhand.wdefense_dynamic * 10)
			if(offhand)
				if(offhand.can_parry)
					offhand_defense += (H.mind ? (H.mind.get_skill_level(offhand.associated_skill) * 20) : 20)
					offhand_defense += (offhand.wdefense_dynamic * 10)

			if(mainhand_defense >= offhand_defense)
				highest_defense += mainhand_defense
			else
				used_weapon = offhand
				highest_defense += offhand_defense

			var/defender_skill = 0
			var/attacker_skill = 0

			if(highest_defense <= (H.mind ? (H.mind.get_skill_level(/datum/skill/combat/unarmed) * 20) : 20))
				defender_skill = H.mind?.get_skill_level(/datum/skill/combat/unarmed)
				var/obj/B = H.get_item_by_slot(SLOT_WRISTS)
				if(istype(B, /obj/item/clothing/wrists/roguetown/bracers))
					prob2defend += (defender_skill * 30)
				else
					prob2defend += (defender_skill * 10)		// no bracers gonna be butts.
				weapon_parry = FALSE
			else
				if(used_weapon)
					defender_skill = H.mind?.get_skill_level(used_weapon.associated_skill)
				else
					defender_skill = H.mind?.get_skill_level(/datum/skill/combat/unarmed)
				prob2defend += highest_defense
				weapon_parry = TRUE

			if(U.mind)
				if(intenty.masteritem)
					attacker_skill = U.mind.get_skill_level(intenty.masteritem.associated_skill)
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
					attacker_skill = U.mind.get_skill_level(/datum/skill/combat/unarmed)
					prob2defend -= (attacker_skill * 20)

			if(HAS_TRAIT(src, TRAIT_GUIDANCE))
				prob2defend += 20

			if(HAS_TRAIT(user, TRAIT_GUIDANCE))
				prob2defend -= 20

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
		if(INTENT_DODGE)
			if(pulledby || pulling)
				return FALSE
			if(world.time < last_dodge + dodgetime)
				if(!istype(rmb_intent, /datum/rmb_intent/riposte))
					return FALSE
			if(has_status_effect(/datum/status_effect/debuff/riposted))
				return FALSE
			if(has_status_effect(/datum/status_effect/debuff/exposed))
				return FALSE
			last_dodge = world.time
			if(src.loc == user.loc)
				return FALSE
			if(intenty)
				if(!intenty.candodge)
					return FALSE
			if(candodge)
				var/list/dirry = list()
				var/dx = x - user.x
				var/dy = y - user.y
				if(abs(dx) < abs(dy))
					if(dy > 0)
						dirry += NORTH
						dirry += WEST
						dirry += EAST
					else
						dirry += SOUTH
						dirry += WEST
						dirry += EAST
				else
					if(dx > 0)
						dirry += EAST
						dirry += SOUTH
						dirry += NORTH
					else
						dirry += WEST
						dirry += NORTH
						dirry += SOUTH
				var/turf/turfy
				if(fixedeye)
					var/dodgedir = turn(dir, 180)
					var/turf/turfcheck = get_step(src, dodgedir)
					if(turfcheck && !turfcheck.density)
						turfy = turfcheck
				if(!turfy)
					for(var/x in shuffle(dirry.Copy()))
						turfy = get_step(src,x)
						if(turfy)
							if(turfy.density)
								continue
							for(var/atom/movable/AM in turfy)
								if(AM.density)
									continue
							break
				if(pulledby)
					return FALSE
				if(!turfy)
					to_chat(src, span_boldwarning("There's nowhere to dodge to!"))
					return FALSE
				else
					if(do_dodge(user, turfy))
						flash_fullscreen("blackflash2")
						user.aftermiss()
						return TRUE
					else
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
			else
				return FALSE

// origin is used for multi-step dodges like jukes
/mob/living/proc/get_dodge_destinations(mob/living/attacker, atom/origin = src)
	var/dodge_dir = get_dir(attacker, origin)
	if(!dodge_dir)
		return null
	var/list/dirry = list()
	// pick a random dir
	var/list/turf/dodge_candidates = list()
	for(var/dir_to_check in dirry)
		var/turf/dodge_candidate = get_step(origin, dir_to_check)
		if(!dodge_candidate)
			continue
		if(dodge_candidate.density)
			continue
		var/has_impassable_atom = FALSE
		for(var/atom/movable/AM in dodge_candidate)
			if(!AM.CanPass(src, dodge_candidate))
				has_impassable_atom = TRUE
				break
		if(has_impassable_atom)
			continue
		dodge_candidates += dodge_candidate
	return dodge_candidates

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


/mob/proc/do_dodge(mob/user, turf/turfy)
	if(dodgecd)
		return FALSE
	var/mob/living/L = src
	var/mob/living/U = user
	var/mob/living/carbon/human/H
	var/mob/living/carbon/human/UH
	var/obj/item/I
	var/drained = 10
	var/drained_npc = 5
	if(ishuman(src))
		H = src
	if(ishuman(user))
		UH = user
		I = UH.used_intent.masteritem
	var/prob2defend = U.defprob
	if(L.stamina >= L.max_stamina)
		return FALSE
	if(L)
		if(H?.check_dodge_skill())
			prob2defend = prob2defend + (L.STASPD * 15)
		else
			prob2defend = prob2defend + (L.STASPD * 10)
	if(U)
		prob2defend = prob2defend - (U.STASPD * 10)
	if(I)
		if(I.wbalance == WBALANCE_SWIFT && U.STASPD > L.STASPD) //nme weapon is quick, so they get a bonus based on spddiff
			prob2defend = prob2defend - ( I.wbalance * ((U.STASPD - L.STASPD) * 10) )
		if(I.wbalance == WBALANCE_HEAVY && L.STASPD > U.STASPD) //nme weapon is slow, so its easier to dodge if we're faster
			prob2defend = prob2defend + ( I.wbalance * ((U.STASPD - L.STASPD) * 10) )
		if(UH?.mind)
			prob2defend = prob2defend - (UH.mind.get_skill_level(I.associated_skill) * 10)
	if(H)
		if(!H?.check_armor_skill() || H?.legcuffed)
			H.Knockdown(1)
			return FALSE
		/* Commented out due to gaping imbalance
			if(H?.check_dodge_skill())
				drained = drained - 5  commented out for being too much. It was giving effectively double stamina efficiency compared to everyone else.
			if(H.mind)
				drained = drained + max((H.checkwornweight() * 10)-(mind.get_skill_level(/datum/skill/misc/athletics) * 10),0)
			else
				drained = drained + (H.checkwornweight() * 10)
		*/
		if(I) //the enemy attacked us with a weapon
			if(!I.associated_skill) //the enemy weapon doesn't have a skill because its improvised, so penalty to attack
				prob2defend = prob2defend + 10
			else
				if(H.mind)
					prob2defend = prob2defend + (H.mind.get_skill_level(I.associated_skill) * 10)
				/* Commented out due to encumbrance being seemingly broken and nonfunctional
				var/thing = H.encumbrance
				if(thing > 0)
					drained = drained + (thing * 10)
				*/
		else //the enemy attacked us unarmed or is nonhuman
			if(UH)
				if(UH.used_intent.unarmed)
					if(UH.mind)
						prob2defend = prob2defend - (UH.mind.get_skill_level(/datum/skill/combat/unarmed) * 10)
					if(H.mind)
						prob2defend = prob2defend + (H.mind.get_skill_level(/datum/skill/combat/unarmed) * 10)

		if(HAS_TRAIT(L, TRAIT_GUIDANCE))
			prob2defend += 20

		if(HAS_TRAIT(U, TRAIT_GUIDANCE))
			prob2defend -= 20

		// dodging while knocked down sucks ass
		if(!(L.mobility_flags & MOBILITY_STAND))
			prob2defend *= 0.25

		if(HAS_TRAIT(H, TRAIT_SENTINELOFWITS))
			var/sentinel = H.calculate_sentinel_bonus()
			prob2defend += sentinel

		prob2defend = clamp(prob2defend, 5, 90)

		//------------Dual Wielding Checks------------
		var/attacker_dualw
		var/defender_dualw
		var/extraattroll
		var/extradefroll
		var/mainhand = L.get_active_held_item()
		var/offhand	= L.get_inactive_held_item()

		//Dual Wielder defense disadvantage
		if(mainhand && offhand)
			if(HAS_TRAIT(src, TRAIT_DUALWIELDER) && istype(offhand, mainhand))
				extradefroll = prob(prob2defend)
				defender_dualw = TRUE

		//dual-wielder attack advantage
		var/obj/item/mainh = U.get_active_held_item()
		var/obj/item/offh = U.get_inactive_held_item()
		if(mainh && offh && HAS_TRAIT(U, TRAIT_DUALWIELDER))
			if(istype(mainh, offh))
				extraattroll = prob(prob2defend)
				attacker_dualw = TRUE
		//----------Dual Wielding check end---------

		var/attacker_feedback 
		if(user.client?.prefs.showrolls && (attacker_dualw || defender_dualw))
			attacker_feedback = "Attacking with advantage. ([100 - ((prob2defend / 100) * (prob2defend / 100) * 100)]%)"

		if(src.client?.prefs.showrolls)
			var/text = "Roll to dodge... [prob2defend]%"
			if((defender_dualw || attacker_dualw))
				if(defender_dualw && attacker_dualw)
					text += " Our dual wielding cancels out!"
				else//If we're defending against or as a dual wielder, we roll disadv. But if we're both dual wielding it cancels out.
					text += " Twice! Disadvantage! ([(prob2defend / 100) * (prob2defend / 100) * 100]%)"
			to_chat(src, span_info("[text]"))

		var/dodge_status = FALSE
		if((!defender_dualw && !attacker_dualw) || (defender_dualw && attacker_dualw)) //They cancel each other out
			if(attacker_feedback)
				attacker_feedback = "Advantage cancelled out!"
			if(prob(prob2defend))
				dodge_status = TRUE
		else if(attacker_dualw)
			if(prob(prob2defend) && extraattroll)
				dodge_status = TRUE
		else if(defender_dualw)
			if(prob(prob2defend) && extradefroll)
				dodge_status = TRUE

		if(attacker_feedback)
			to_chat(user, span_info("[attacker_feedback]"))

		if(!dodge_status)
			return FALSE
		if(!UH?.mind) // For NPC, reduce the drained to 5 stamina
			drained = drained_npc
		if(!H.stamina_add(max(drained,5)))
			to_chat(src, span_warning("I'm too tired to dodge!"))
			return FALSE
	else //we are a non human
		prob2defend = clamp(prob2defend, 5, 90)
		if(client?.prefs.showrolls)
			to_chat(src, span_info("Roll to dodge... [prob2defend]%"))
		if(!prob(prob2defend))
			return FALSE
	dodgecd = TRUE
	playsound(src, 'sound/combat/dodge.ogg', 100, FALSE)
	throw_at(turfy, 1, 2, src, FALSE)
	if(drained > 0)
		src.visible_message(span_warning("<b>[src]</b> dodges [user]'s attack!"))
	else
		src.visible_message(span_warning("<b>[src]</b> easily dodges [user]'s attack!"))
	if(get_dist(src, user) <= user.used_intent?.reach)	//We are still in range of the attacker's weapon post-dodge
		var/probclip = 50
		var/obj/item/IS = L.get_active_held_item()
		var/obj/item/IU = U.get_active_held_item()
		if(IS)
			if(IS.wlength > WLENGTH_NORMAL)
				probclip += (IS.wlength - WLENGTH_NORMAL) * 10	//if wlength isn't standardised this might skyrocket it to >100%
			else
				probclip -= (WLENGTH_NORMAL - IS.wlength) * 10
		var/dist = (user.used_intent?.reach - get_dist(src, user)) - 1 //-1 because we already are in range and triggered this check to begin with.
		if(dist > 0)
			probclip += dist * 10
		if(L.STALUC != U.STALUC)
			var/lucmod = L.STALUC - U.STALUC
			probclip += lucmod * 10
		if(prob(probclip) && IS && IU)
			var/dam2take = round((get_complex_damage(IU, user, FALSE)/2),1)
			if(dam2take)
				if(!user.mind)
					dam2take = dam2take * 0.25
				if(dam2take > 0 && (user.used_intent.masteritem?.intdamage_factor != 1 || user.used_intent.intent_intdamage_factor != 1))
					var/higher_intfactor = max(user.used_intent.masteritem?.intdamage_factor, user.used_intent.intent_intdamage_factor)
					var/lowest_intfactor = min(user.used_intent.masteritem?.intdamage_factor, user.used_intent.intent_intdamage_factor)
					var/used_intfactor
					if(lowest_intfactor < 1)	//Our intfactor multiplier can be either 0 to 1, or 1 to whatever.
						used_intfactor = lowest_intfactor
					if(higher_intfactor > 1)	//Make sure to keep your weapon and intent intfactors consistent to avoid problems here!
						used_intfactor = higher_intfactor
					dam2take *= used_intfactor
				else
					if(istype(user, /mob/living/simple_animal))
						var/mob/living/simple_animal/SM = user
						dam2take = rand(SM.melee_damage_lower, SM.melee_damage_upper)
						dam2take *= (SM.STASTR / 10)
						dam2take *= 0.25
						switch(IS.blade_dulling)
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
				IS.take_damage(max(dam2take,1), BRUTE, IU.d_type)

			user.visible_message(span_warning("<b>[user]</b> clips [src]'s weapon!"))
			playsound(user, 'sound/misc/weapon_clip.ogg', 100)
	dodgecd = FALSE
//		if(H)
//			if(H.IsOffBalanced())
//				H.Knockdown(1)
//				to_chat(H, span_danger("I tried to dodge off-balance!"))
//		if(isturf(loc))
//			var/turf/T = loc
//			if(T.landsound)
//				playsound(T, T.landsound, 100, FALSE)
	return TRUE

/mob/proc/food_tempted(/obj/item/W, mob/user)
	return

/mob/proc/taunted(mob/user)
	return

/mob/proc/shood(mob/user)
	return

/mob/proc/beckoned(mob/user)
	return

/mob/proc/get_punch_dmg()
	return


/mob/proc/add_family_hud(antag_hud_type, antag_hud_name)
	var/datum/atom_hud/antag/hud = GLOB.huds[antag_hud_type]
	hud.join_hud(src)
	set_antag_hud(src, antag_hud_name)


/mob/proc/remove_family_hud(antag_hud_type)
	var/datum/atom_hud/antag/hud = GLOB.huds[antag_hud_type]
	hud.leave_hud(src)
	set_antag_hud(src, null)

/mob/living/carbon/human/proc/is_noble()
	var/noble = FALSE
	if (job in GLOB.noble_positions)
		noble = TRUE
	if (HAS_TRAIT(src, TRAIT_NOBLE))
		noble = TRUE

	return noble

/mob/living/carbon/human/proc/is_yeoman()
	return job in GLOB.yeoman_positions

/mob/living/carbon/human/proc/is_courtier()
	return job in GLOB.courtier_positions

/mob/living/carbon/human/proc/calculate_sentinel_bonus()
	if(STAINT > 10)
		var/fakeint = STAINT
		if(status_effects.len)
			for(var/S in status_effects)
				var/datum/status_effect/status = S
				if(status.effectedstats.len)
					if(status.effectedstats["intelligence"])
						if(status.effectedstats["intelligence"] > 0)
							fakeint -= status.effectedstats["intelligence"]
		if(fakeint > 10)
			var/bonus = round(((fakeint - 10) / 2)) * 10
			if(bonus > 0)
				if(HAS_TRAIT(src, TRAIT_HEAVYARMOR) || HAS_TRAIT(src, TRAIT_MEDIUMARMOR) || HAS_TRAIT(src, TRAIT_DODGEEXPERT) || HAS_TRAIT(src, TRAIT_CRITICAL_RESISTANCE))
					bonus = clamp(bonus, 0, 25)
				else
					bonus = clamp(bonus, 0, 50)//20-21 INT
			return bonus
		else
			return 0
	else
		return 0


/mob/living/carbon/human/proc/process_clash(mob/user, obj/item/IM, obj/item/IU)
	if(!ishuman(user))
		return
	if(user == src)
		bad_guard(span_warning("I hit myself."))
		return
	var/mob/living/carbon/human/H = user
	if(!IU)	//The opponent is trying to rawdog us with their bare hands while we have Guard up. We get a free attack on their active hand.
		var/obj/item/bodypart/affecting = H.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
		var/force = get_complex_damage(IM, src)
		var/armor_block = H.run_armor_check(BODY_ZONE_PRECISE_L_HAND, used_intent.item_d_type, armor_penetration = used_intent.penfactor, damage = force)
		if(H.apply_damage(force, IM.damtype, affecting, armor_block))
			visible_message(span_suicide("[src] gores [user]'s hands with \the [IM]!"))
			affecting.bodypart_attacked_by(used_intent.blade_class, force, crit_message = TRUE)
		else
			visible_message(span_suicide("[src] clashes into [user]'s hands with \the [IM]!"))
		playsound(src, pick(used_intent.hitsound), 80)
		remove_status_effect(/datum/status_effect/buff/clash)
		return
	if(H.has_status_effect(/datum/status_effect/buff/clash))	//They also have Clash active. It'll trigger the special event.
		clash(user, IM, IU)
	else	//Otherwise, we just riposte them.
		var/damage = get_complex_damage(IM, src, IU.blade_dulling)
		if(IM.intdamage_factor != 1 || used_intent.intent_intdamage_factor != 1)
			var/higher_intfactor = max(IM.intdamage_factor, used_intent.intent_intdamage_factor)
			var/lowest_intfactor = min(IM.intdamage_factor, used_intent.intent_intdamage_factor)
			var/used_intfactor
			if(lowest_intfactor < 1)	//Our intfactor multiplier can be either 0 to 1, or 1 to whatever.
				used_intfactor = lowest_intfactor
			if(higher_intfactor > 1)	//Make sure to keep your weapon and intent intfactors consistent to avoid problems here!
				used_intfactor = higher_intfactor
			damage *= used_intfactor
		if(IM.wbalance == WBALANCE_HEAVY)
			damage *= 1.5
		IU.take_damage(max(damage,1), BRUTE, IM.d_type)
		visible_message(span_suicide("[src] ripostes [H] with \the [IM]!"))
		playsound(src, 'sound/combat/clash_struck.ogg', 100)
		var/staminadef = (stamina * 100) / max_stamina
		var/staminaatt = (H.stamina * 100) / H.max_stamina
		if(staminadef > staminaatt) 
			H.apply_status_effect(/datum/status_effect/debuff/exposed, 2 SECONDS)
			H.apply_status_effect(/datum/status_effect/debuff/clickcd, 3 SECONDS)
			H.Slowdown(3)
			to_chat(src, span_notice("[H.p_theyre()] exposed!"))
		else
			H.changeNext_move(CLICK_CD_MELEE)
		remove_status_effect(/datum/status_effect/buff/clash)
		purge_peel(GUARD_PEEL_REDUCTION)

//This is a gargantuan, clunky proc that is meant to tally stats and weapon properties for the potential disarm.
//For future coders: Feel free to change this, just make sure someone like Struggler statpack doesn't get 3-fold advantage.
/mob/living/carbon/human/proc/clash(mob/user, obj/item/IM, obj/item/IU)
	var/mob/living/carbon/human/HU = user
	var/instantloss = FALSE
	var/instantwin = FALSE

	//Stat checks. Basic comparison.
	var/strdiff = STASTR - HU.STASTR
	var/perdiff = STAPER - HU.STAPER
	var/spddiff = STASPD - HU.STASPD
	var/fordiff = STALUC - HU.STALUC
	var/intdiff = STAINT - HU.STAINT

	var/list/statdiffs = list(strdiff, perdiff, spddiff, fordiff, intdiff)

	//Skill check, very simple. If you're more skilled with your weapon than the opponent is with theirs -> +10% to disarm or vice-versa.
	var/skilldiff
	if(IM.associated_skill)
		skilldiff = mind.get_skill_level(IM.associated_skill)
	else
		instantloss = TRUE	//We are Guarding with a book or something -- no chance for us.

	if(IU.associated_skill)
		skilldiff = skilldiff - HU.mind?.get_skill_level(IU.associated_skill)
	else
		instantwin = TRUE	//THEY are Guarding with a book or something -- no chance for them.
	
	//Weapon checks.
	var/lengthdiff = IM.wlength - IU.wlength //The longer the weapon the better.
	var/wieldeddiff = IM.wielded - IU.wielded //If ours is wielded but theirs is not.
	var/weightdiff = (IM.wbalance < IU.wbalance) //If our weapon is heavy-balanced and theirs is not.
	var/wildcard = pick(-1,0,1)

	var/list/wepdiffs = list(lengthdiff, wieldeddiff, weightdiff)

	var/prob_us = 0
	var/prob_opp = 0

	//Stat checks only matter if their difference is 2 or more.
	for(var/statdiff in statdiffs)
		if(statdiff >= 2)
			prob_us += 10
		else if(statdiff <= -2)
			prob_opp += 10
	
	for(var/wepdiff in wepdiffs)
		if(wepdiff > 0)
			prob_us += 10
		else if(wepdiff < 0)
			prob_opp += 10

	//Wildcard modifier that can go either way or to neither.
	if(wildcard > 0)
		prob_us += 10
	else if(wildcard < 0 )
		prob_opp += 10
	
	//Small bonus to the first one to strike in a Clash.
	var/initiator_bonus = rand(5, 10)
	prob_us += initiator_bonus

	if(has_duelist_ring() && HU.has_duelist_ring())
		prob_us = max(prob_us, prob_opp)
		prob_opp = max(prob_us, prob_opp)

	if((!instantloss && !instantwin) || (instantloss && instantwin))	//We are both using normal weapons OR we're both using memes. Either way, proceed as normal.
		visible_message(span_boldwarning("[src] and [HU] clash!"))
		flash_fullscreen("whiteflash")
		HU.flash_fullscreen("whiteflash")
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_step(src,src.dir)
		S.set_up(1, 1, front)
		S.start()
		var/success
		if(prob(prob_us))
			HU.remove_status_effect(/datum/status_effect/buff/clash)
			HU.play_overhead_indicator('icons/mob/overhead_effects.dmi', "clashtwo", 1 SECONDS, OBJ_LAYER, soundin = 'sound/combat/clash_disarm_us.ogg', y_offset = 24)
			disarmed(IM)
			Slowdown(5)
			success = TRUE
		if(prob(prob_opp))
			HU.disarmed(IU)
			HU.Slowdown(5)
			remove_status_effect(/datum/status_effect/buff/clash)
			play_overhead_indicator('icons/mob/overhead_effects.dmi', "clashtwo", 1 SECONDS, OBJ_LAYER, soundin = 'sound/combat/clash_disarm_opp.ogg', y_offset = 24)
			success = TRUE
		if(!success)
			to_chat(src, span_warningbig("Draw! Opponent's chances were... [prob_opp]%"))
			to_chat(HU, span_warningbig("Draw! Opponent's chances were... [prob_us]%"))
			playsound(src, 'sound/combat/clash_draw.ogg', 100, TRUE)
	else
		if(instantloss)
			disarmed(IM)
		if(instantwin)
			HU.disarmed(IU)
	
	remove_status_effect(/datum/status_effect/buff/clash)
	HU.remove_status_effect(/datum/status_effect/buff/clash)

/mob/living/carbon/human/proc/disarmed(obj/item/I)
	visible_message(span_suicide("[src] is disarmed!"), 
					span_boldwarning("I'm disarmed!"))
	var/turnangle = (prob(50) ? 270 : 90)
	var/turndir = turn(dir, turnangle)
	var/dist = rand(1, 5)
	var/current_turf = get_turf(src)
	var/target_turf = get_ranged_target_turf(current_turf, turndir, dist)
	throw_item(target_turf, FALSE)
	apply_status_effect(/datum/status_effect/debuff/clickcd, 3 SECONDS)

/mob/living/carbon/human/proc/bad_guard(msg, cheesy = FALSE)
	stamina_add(((max_stamina * BAD_GUARD_FATIGUE_DRAIN) / 100))
	if(cheesy)	//We tried to hit someone with Guard up. Unfortunately this must be super punishing to prevent cheese.
		energy_add(-((max_energy * BAD_GUARD_FATIGUE_DRAIN) / 100))
		Immobilize(2 SECONDS)
	if(msg)
		to_chat(src, msg)
		emote("strain", forced = TRUE)
	remove_status_effect(/datum/status_effect/buff/clash)

/mob/living/carbon/human/proc/purge_peel(amt)
	//Equipment slots manually picked out cus we don't have a proc for this apparently
	var/list/slots = list(wear_armor, wear_pants, wear_wrists, wear_shirt, gloves, head, shoes, wear_neck, wear_mask)
	for(var/slot in slots)
		if(isnull(slot) || !istype(slot, /obj/item/clothing))
			slots.Remove(slot)

	for(var/obj/item/clothing/C in slots)
		if(C.peel_count > 0)
			C.reduce_peel(amt)

/mob/living/carbon/human/proc/highest_ac_worn()
	var/list/slots = list(wear_armor, wear_pants, wear_wrists, wear_shirt, gloves, head, shoes, wear_neck, wear_mask)
	for(var/slot in slots)
		if(isnull(slot) || !istype(slot, /obj/item/clothing))
			slots.Remove(slot)
	
	var/highest_ac = ARMOR_CLASS_NONE

	for(var/obj/item/clothing/C in slots)
		if(C.armor_class)
			if(C.armor_class > highest_ac)
				highest_ac = C.armor_class
	
	return highest_ac

/mob/living/carbon/human/proc/has_duelist_ring()
	if(wear_ring)
		if(istype(wear_ring, /obj/item/clothing/ring/duelist))
			return TRUE
	return FALSE

/mob/living/carbon/human/proc/purge_bait()
	if(!cmode)
		if(bait_stacks > 0)
			bait_stacks = 0
			to_chat(src, span_info("My focus and balance returns. I won't lose my footing if I am baited again."))

/mob/living/carbon/human/proc/measured_statcheck(mob/living/carbon/human/HT)
	var/finalprob = 40

	//We take the highest and the lowest stats, clamped to 14.
	var/max_target = min(max(HT.STASTR, HT.STACON, HT.STAEND, HT.STAINT, HT.STAPER, HT.STASPD), 14)
	var/min_target = min(HT.STASTR, HT.STACON, HT.STAEND, HT.STAINT, HT.STAPER, HT.STASPD)
	var/max_user = min(max(STASTR, STACON, STAEND, STAINT, STAPER, STASPD), 14)
	var/min_user = min(STASTR, STACON, STAEND, STAINT, STAPER, STASPD)
	
	if(max_target > max_user)
		finalprob -= max_target
	if(min_target > min_user)
		finalprob -= 3 * min_target
	
	if(max_target < max_user)
		finalprob += max_user
	if(min_target < min_user)
		finalprob += 3 * min_user

	finalprob = clamp(finalprob, 5, 75)

	if(STALUC > HT.STALUC)
		finalprob += rand(1, rand(1,25))	//good luck mathing this out, code divers
	if(STALUC < HT.STALUC)
		finalprob -= rand(1, rand(1,25))

	return prob(finalprob)
