///T3 Enchantmentsdatum
/datum/magic_item/greater/lifesteal
	name = "life steal"
	description = "It seems bloodthirsty."
	var/last_used
	var/flat_heal = 10
	var/static/list/damage_heal_order = list(BRUTE, BURN, OXY)
	var/warned = FALSE

/datum/magic_item/greater/lifesteal/projectile_hit(atom/fired_from, atom/movable/firer, atom/target, Angle)
	if(world.time < src.last_used + 100)
		to_chat(firer, span_notice("[fired_from] is not yet hungry for more life!"))
		return
	if(isliving(firer) && isliving(target))
		var/mob/living/healing = firer
		var/mob/living/damaging = target
		if(damaging.stat != DEAD)
			healing.heal_ordered_damage(flat_heal, damage_heal_order)
			firer.visible_message(span_danger("[fired_from] drains life from [target]!"))
			src.last_used = world.time

/datum/magic_item/greater/lifesteal/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(world.time < src.last_used + 100)
		if(!warned)
			to_chat(user, span_notice("[source] is not yet hungry for more life!"))
			warned = TRUE
		return
	if(isliving(user) && isliving(target))
		var/mob/living/healing = user
		var/mob/living/damaging = target
		if(damaging.stat != DEAD)
			healing.heal_ordered_damage(flat_heal, damage_heal_order)
			user.visible_message(span_danger("[source] drains life from [target]!"))
			warned = FALSE
			src.last_used = world.time

/datum/magic_item/greater/frostveil
	name = "frostveil"
	description = "It feels rather cold."
	var/last_used

/datum/magic_item/greater/frostveil/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(world.time < src.last_used + 100)
		return
	if(isliving(target))
		var/mob/living/targeted = target
		targeted.apply_status_effect(/datum/status_effect/debuff/cold)
		targeted.visible_message(span_danger("[source] chills [targeted]!"))
		src.last_used = world.time

/datum/magic_item/greater/frostveil/on_hit_response(var/obj/item/I, var/mob/living/carbon/human/owner, var/mob/living/carbon/human/attacker)
	if(world.time < src.last_used + 100)
		return
	if(isliving(attacker) && attacker != owner)
		attacker.apply_status_effect(/datum/status_effect/debuff/cold)
		attacker.visible_message(span_danger("[I] chills [attacker]!"))
		src.last_used = world.time

/datum/magic_item/greater/returningweapon
	name = "returning weapon"
	description = "It glows with arcane sigils."
	var/active_item = FALSE

/datum/magic_item/greater/returningweapon/on_equip(var/obj/item/i, var/mob/living/user, slot)
	if(slot == ITEM_SLOT_HANDS)
		return
	if(active_item)
		return
	else
		active_item = TRUE
		user.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/summonweapon)
		to_chat(user, span_notice("I feel the magick within [i] resonate with my own."))

/datum/magic_item/greater/returningweapon/on_drop(var/obj/item/i, var/mob/living/user)
	if(active_item)
		user.mind.RemoveSpell(/obj/effect/proc_holder/spell/targeted/summonweapon)
		to_chat(user, span_notice("the warmth of [i] fades away."))
		active_item = FALSE

/datum/magic_item/greater/archery
	name = "archery"
	description = "It has the imprint of a bowstring."
	var/active_item = FALSE
	var/masterbow = FALSE
	var/legendbow = FALSE
	var/mastercrossbow = FALSE
	var/legendcrossbow = FALSE
	var/mastersling = FALSE
	var/legendsling = FALSE

/datum/magic_item/greater/archery/on_equip(var/obj/item/i, var/mob/living/user, slot)
	if(slot == ITEM_SLOT_HANDS)
		return
	if(active_item)
		return
	else
		//stat boost
		user.change_stat("perception", 2)

		//Bow boost
		if (user.get_skill_level(/datum/skill/combat/bows) == 6)
			legendbow = TRUE
			masterbow = FALSE
		else
			if (user.get_skill_level(/datum/skill/combat/bows) == 5)
				user.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
				masterbow = TRUE
			else
				user.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)

		//crossbow boost
		if (user.get_skill_level(/datum/skill/combat/crossbows) == 6)
			legendcrossbow = TRUE
			mastercrossbow = FALSE
		else
			if (user.get_skill_level(/datum/skill/combat/crossbows) == 5)
				user.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
				mastercrossbow = TRUE
			else
				user.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)

		//sling boost
		if (user.get_skill_level(/datum/skill/combat/slings) == 6)
			legendsling = TRUE
			mastersling = FALSE
		else
			if (user.get_skill_level(/datum/skill/combat/slings) == 5)
				user.adjust_skillrank(/datum/skill/combat/slings, 1, TRUE)
				mastersling = TRUE
			else
				user.adjust_skillrank(/datum/skill/combat/slings, 2, TRUE)

		to_chat(user, span_notice("I feel more dexterious!"))
		active_item = TRUE

/datum/magic_item/greater/archery/on_drop(var/obj/item/i, var/mob/living/user)
	if(active_item)
		active_item = FALSE
		user.change_stat("perception", -2)
		//correct bows
		if (!legendbow)
			if (masterbow)
				user.adjust_skillrank(/datum/skill/combat/bows -1, TRUE)
			else
				user.adjust_skillrank(/datum/skill/combat/bows, -2, TRUE)

		//correct crossbows
		if (!legendcrossbow)
			if (mastercrossbow)
				user.adjust_skillrank(/datum/skill/combat/crossbows -1, TRUE)
			else
				user.adjust_skillrank(/datum/skill/combat/crossbows, -2, TRUE)

		//correct slings
		if (!legendsling)
			if (mastersling)
				user.adjust_skillrank(/datum/skill/combat/slings -1, TRUE)
			else
				user.adjust_skillrank(/datum/skill/combat/slings, -2, TRUE)

		to_chat(user, span_notice("I feel mundane once more"))
