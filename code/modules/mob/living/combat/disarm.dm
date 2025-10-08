/mob/living/proc/attempt_disarm(mob/living/user, obj/item/O) //this is SPECIFICALLY for weapon-intent disarms
	var/skill_diff = 0
	var/obj/item/I
	if(user.zone_selected == BODY_ZONE_PRECISE_L_HAND && active_hand_index == 1)
		I = get_active_held_item()
	else
		if(user.zone_selected == BODY_ZONE_PRECISE_R_HAND && active_hand_index == 2)
			I = get_active_held_item()
		else
			I = get_inactive_held_item()
	if((user.mind))
		skill_diff += (user.get_skill_level(O.associated_skill))	//You check your sword skill
	if(mind)
		skill_diff -= (get_skill_level(/datum/skill/combat/wrestling))	//They check their wrestling skill to stop the weapon from being pulled.
	user.stamina_add(rand(3,8))
	var/probby = clamp((((3 + (((user.STASTR - STASTR)/4) + skill_diff)) * 10)), 5, 95)
	if(I)
		if(mind)
			if(!isliving(src))
				to_chat(user, span_warning("You cannot disarm this enemy!"))
				return
			if(I.associated_skill)
				probby -= get_skill_level(I.associated_skill) * 5
			if(!O.wielded)
				var/obj/item/offhand = user.get_inactive_held_item()
				if(HAS_TRAIT(src, TRAIT_DUALWIELDER) && istype(offhand, O))
					probby += 20	//We give notable bonus to dual-wielders who use two hooked swords.
			if(prob(probby))
				dropItemToGround(I, force = FALSE, silent = FALSE)
				user.stop_pulling()
				user.put_in_inactive_hand(I)
				visible_message(span_danger("[user] takes [I] from [src]'s hand!"), \
				span_userdanger("[user] takes [I] from my hand!"), span_hear("I hear a sickening sound of pugilism!"), COMBAT_MESSAGE_RANGE)
				user.changeNext_move(12)//avoids instantly attacking with the new weapon
				playsound(loc, 'sound/combat/weaponr1.ogg', 100, FALSE, -1) //sound queue to let them know that they got disarmed
				if(!mind)	//If you hit an NPC - they pick up weapons instantly. So, we do more stuff.
					Stun(10)
				return
			else
				probby += 20
				if(prob(probby))
					dropItemToGround(I, force = FALSE, silent = FALSE)
					visible_message(span_danger("[user] disarms [src] of [I]!"), \
					span_userdanger("[user] disarms me of [I]!"), span_hear("I hear a sickening sound of pugilism!"), COMBAT_MESSAGE_RANGE)
					if(!mind)
						Stun(20)	//high delay to pick up weapon
					else
						Stun(6)	//slight delay to pick up the weapon
				else
					user.Immobilize(10)
					Immobilize(10)
					visible_message(span_notice("[user.name] struggles to disarm [src.name]!"))
					playsound(loc, 'sound/foley/struggle.ogg', 100, FALSE, -1)
	else
		to_chat(user, span_warning("They aren't holding anything on that hand!"))
		return
