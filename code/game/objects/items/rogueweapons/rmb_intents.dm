/datum/rmb_intent
	var/name = "intent"
	var/desc = ""
	var/icon_state = ""

/datum/rmb_intent/proc/special_attack(mob/living/user, atom/target)
	if(!isliving(target))
		return
	if(!user)
		return
	if(user.incapacitated())
		return
	var/mob/living/L = target
	user.changeNext_move(CLICK_CD_RAPID)
	user.visible_message(span_danger("[user] feints an attack at [target]!"))
	var/perc = 50
	if(user.mind)
		var/obj/item/I = user.get_active_held_item()
		var/ourskill = 0
		var/theirskill = 0
		if(I)
			if(I.associated_skill)
				ourskill = user.mind.get_skill_level(I.associated_skill)
			if(L.mind)
				I = L.get_active_held_item()
				if(I?.associated_skill)
					theirskill = L.mind.get_skill_level(I.associated_skill)
		perc += (ourskill - theirskill)*15 	//skill is of the essence
		perc += (user.STAINT - L.STAINT)*10	//but it's also mostly a mindgame
	if(L.has_status_effect(/datum/status_effect/debuff/feinted))
		perc = 0
	if(user.has_status_effect(/datum/status_effect/debuff/feintcd))
		to_chat(user, span_danger("[L] is too on guard for another so soon!"))
		return
	if(HAS_TRAIT(L,TRAIT_DECEIVING_MEEKNESS))
		perc -= 30
	if(HAS_TRAIT(user,TRAIT_DECEIVING_MEEKNESS))
		perc += 15
	user.apply_status_effect(/datum/status_effect/debuff/feintcd)
	perc = CLAMP(perc, 0, 90)
	if(prob(perc)) //feint intent increases the immobilize duration significantly
		if(istype(user.rmb_intent, /datum/rmb_intent/feint))
			L.apply_status_effect(/datum/status_effect/debuff/feinted)
			L.changeNext_move(20)
			L.Immobilize(30)
			if(L.pulling)
				L.changeNext_move(CLICK_CD_GRABBING)
				L.stop_pulling()
			to_chat(user, span_notice("[L] fell for my feint attack!"))
			to_chat(L, span_danger("I fall for [user]'s feint attack!"))
			playsound(user, 'sound/combat/riposte.ogg', 100, TRUE)
		else
			L.apply_status_effect(/datum/status_effect/debuff/feinted)
			L.changeNext_move(10)
			L.Immobilize(15)
			if(L.pulling)
				L.changeNext_move(CLICK_CD_GRABBING)
				L.stop_pulling()
			to_chat(user, span_notice("[L] fell for my feint attack!"))
			to_chat(L, span_danger("I fall for [user]'s feint attack!"))
			playsound(user, 'sound/combat/riposte.ogg', 100, TRUE)
	else
		if(user.client?.prefs.showrolls)
			playsound(user, 'sound/combat/feint.ogg', 100, TRUE)
			to_chat(user, span_warning("[L] did not fall for my feint... [perc]%"))

/datum/rmb_intent/aimed
	name = "aimed"
	desc = "Your attacks are more precise but have a longer recovery time. Higher critrate with precise attacks."
	icon_state = "rmbaimed"

/datum/rmb_intent/strong
	name = "strong"
	desc = "Your attacks have +1 strength but use more stamina. Higher critrate with brutal attacks. Intentionally fails surgery steps."
	icon_state = "rmbstrong"

/datum/rmb_intent/swift
	name = "swift"
	desc = "Your attacks have less recovery time but are less accurate."
	icon_state = "rmbswift"

/datum/rmb_intent/special
	name = "special"
	desc = "(RMB WHILE DEFENSE IS ACTIVE) A special attack that depends on the type of weapon you are using."
	icon_state = "rmbspecial"

/datum/rmb_intent/feint
	name = "feint"
	desc = "(RMB WHILE DEFENSE IS ACTIVE) A deceptive half-attack with no follow-through, meant to force your opponent to open their guard."
	icon_state = "rmbfeint"

/datum/status_effect/debuff/feinted
	id = "nofeint"
	duration = 10 SECONDS

/datum/status_effect/debuff/feintcd
	id = "feintcd"
	duration = 30 SECONDS

/datum/status_effect/debuff/riposted
	id = "riposted"
	duration = 30

/datum/rmb_intent/riposte
	name = "defend"
	desc = "No delay between dodge and parry rolls."
	icon_state = "rmbdef"

/datum/rmb_intent/guard
	name = "guarde"
	desc = "(RMB WHILE DEFENSE IS ACTIVE) Raise your weapon, ready to attack any creature who moves onto the space you are guarding."
	icon_state = "rmbguard"

/datum/rmb_intent/weak
	name = "weak"
	desc = "Your attacks have -1 strength and will never critically-hit. Useful for longer punishments, play-fighting, and bloodletting."
	icon_state = "rmbweak"
