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
	if(!user.mind)
		return
	var/mob/living/L = target
	user.changeNext_move(CLICK_CD_RAPID)
	user.visible_message(span_danger("[user] feints an attack at [target]!"))
	var/perc = 50
	var/obj/item/I = user.get_active_held_item()
	var/ourskill = 0
	var/theirskill = 0
	var/skill_factor = 0
	if(I)
		if(I.associated_skill)
			ourskill = user.mind.get_skill_level(I.associated_skill)
		if(L.mind)
			I = L.get_active_held_item()
			if(I?.associated_skill)
				theirskill = L.mind.get_skill_level(I.associated_skill)
	perc += (ourskill - theirskill)*15 	//skill is of the essence
	perc += (user.STAINT - L.STAINT)*10	//but it's also mostly a mindgame
	skill_factor = (ourskill - theirskill)/2

	if(L.has_status_effect(/datum/status_effect/debuff/exposed))
		perc = 0

	if(user.has_status_effect(/datum/status_effect/debuff/feintcd))
		to_chat(user, span_danger("[L] is too on guard for another so soon!"))
		return

	if(HAS_TRAIT(L,TRAIT_DECEIVING_MEEKNESS))
		perc -= 30
	if(HAS_TRAIT(user,TRAIT_DECEIVING_MEEKNESS))
		perc = max(perc, 65)

	user.apply_status_effect(/datum/status_effect/debuff/feintcd)
	perc = CLAMP(perc, 0, 90)

	if(!prob(perc)) //feint intent increases the immobilize duration significantly
		playsound(user, 'sound/combat/feint.ogg', 100, TRUE)
		if(user.client?.prefs.showrolls)
			to_chat(user, span_warning("[L] did not fall for my feint... [perc]%"))
		return
	if(!istype(user.rmb_intent, /datum/rmb_intent/feint))
		L.apply_status_effect(/datum/status_effect/debuff/exposed)
		L.changeNext_move(0.8 SECONDS)
		L.Immobilize(0.5 SECONDS)
		to_chat(user, span_notice("[L] fell for my feint attack!"))
		to_chat(L, span_danger("I fall for [user]'s feint attack!"))
		return

	L.apply_status_effect(/datum/status_effect/debuff/exposed)
	L.changeNext_move(max(1.5 SECONDS + skill_factor, 2.5 SECONDS))
	L.Immobilize(0.5 SECONDS)
	L.rogfat_add(L.rogfat * 0.1)
	to_chat(user, span_notice("[L] fell for my feint attack!"))
	to_chat(L, span_danger("I fall for [user]'s feint attack!"))
	playsound(user, 'sound/combat/riposte.ogg', 100, TRUE)

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
	desc = "(RMB OFF DEFENSE) A deceptive half-attack with no follow-through, meant to force your opponent to open their guard."
	icon_state = "rmbfeint"

/datum/status_effect/debuff/exposed
	id = "nofeint"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/exposed
	duration = 7.5 SECONDS

/atom/movable/screen/alert/status_effect/debuff/exposed
	name = "Exposed"
	desc = "My defenses are exposed. I can be hit through my parry and dodge!"
	icon_state = "exposed"

/datum/status_effect/debuff/feintcd
	id = "feintcd"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/feintcd
	duration = 15 SECONDS

/atom/movable/screen/alert/status_effect/debuff/feintcd
	name = "Feint Cooldown"
	desc = "I cannot feint again for some time."

/datum/status_effect/debuff/riposted
	id = "riposted"
	duration = 3 SECONDS


/datum/rmb_intent/riposte
	name = "defend"
	desc = "No delay between dodge and parry rolls.\n(RMB WHILE COMBAT MODE IS ACTIVE) Bait out your targeted limb to the enemy. If it matches where they're aiming, they will be thrown off balance."
	icon_state = "rmbdef"

/datum/rmb_intent/guard
	name = "guarde"
	desc = "(RMB WHILE DEFENSE IS ACTIVE) Raise your weapon, ready to attack any creature who moves onto the space you are guarding."
	icon_state = "rmbguard"

/datum/rmb_intent/weak
	name = "weak"
	desc = "Your attacks have -1 strength and will never critically-hit. Useful for longer punishments, play-fighting, and bloodletting."
	icon_state = "rmbweak"

/datum/rmb_intent/riposte/special_attack(mob/living/user, atom/target)
	if(!user)
		return
	if(user.incapacitated())
		return
	if(!ishuman(user))
		return
	if(!ishuman(target))
		return
	if(user == target)
		return
	
	var/mob/living/carbon/human/HT = target
	var/mob/living/carbon/human/HU = user
	var/target_zone = HT.zone_selected
	var/user_zone = HU.zone_selected

	if(HT.has_status_effect(/datum/status_effect/debuff/baited) && user.has_status_effect(/datum/status_effect/debuff/baitcd))
		return	//We don't do anything if either of us is affected by bait statuses

	user.visible_message(span_danger("[user] baits an attack from [target]!"))
	user.apply_status_effect(/datum/status_effect/debuff/baitcd)

	if((target_zone != user_zone) || ((target_zone == BODY_ZONE_CHEST) || (user_zone == BODY_ZONE_CHEST))) //Our zones match and it's not the chest//Our zones do not match, or we were targeting chest
		var/probbait = 40

		//We take the highest and the lowest stats, clamped to 14.
		var/max_target = min(max(HT.STASTR, HT.STACON, HT.STAEND, HT.STAINT, HT.STAPER, HT.STASPD), 14)
		var/min_target = min(HT.STASTR, HT.STACON, HT.STAEND, HT.STAINT, HT.STAPER, HT.STASPD)
		var/max_user = min(max(HU.STASTR, HU.STACON, HU.STAEND, HU.STAINT, HU.STAPER, HU.STASPD), 14)
		var/min_user = min(HU.STASTR, HU.STACON, HU.STAEND, HU.STAINT, HU.STAPER, HU.STASPD)
		
		if(max_target > max_user)
			probbait -= max_target
		if(min_target > min_user)
			probbait -= 3 * min_target
		
		if(max_target < max_user)
			probbait += max_user
		if(min_target < min_user)
			probbait += 3 * min_user

		probbait = clamp(probbait, 5, 75)

		if(HU.STALUC > HT.STALUC)
			probbait += rand(1, rand(1,25))	//good luck mathing this out, code divers
		if(HU.STALUC < HT.STALUC)
			probbait -= rand(1, rand(1,25))

		if(!prob(probbait))
			to_chat(user, span_notice("[HT] did not fall for my bait!"))
			to_chat(HT, span_notice("I saw through the bait!"))
			user.changeNext_move(1 SECONDS)
			user.rogfat_add(10)
			return

		HT.changeNext_move(1 SECONDS)
		to_chat(user, span_notice("[HT] fell for my bait!"))
		to_chat(HT, span_danger("I fall for [user]'s bait!"))
		HT.rogfat_add(10)
		HT.emote("huh")
		return

	HT.apply_status_effect(/datum/status_effect/debuff/baited)
	HT.apply_status_effect(/datum/status_effect/debuff/exposed)
	HT.changeNext_move(2 SECONDS)
	HT.Immobilize(2 SECONDS)
	HT.rogfat_add(HT.maxrogfat / 5)
	HT.OffBalance(2.2 SECONDS)
	HT.emote("gasp")
	HU.changeNext_move(0.1 SECONDS)
	to_chat(user, span_notice("[HT] fell for my bait <b>perfectly</b>!"))
	to_chat(HT, span_danger("I fall for [user]'s bait <b>perfectly</b>!"))

	if(!HT.pulling)
		return

	HT.stop_pulling()
	to_chat(user, span_notice("[HT] fell for my dirty trick! I am loose!"))
	to_chat(HT, span_danger("I fall for [user]'s dirty trick! My hold is broken!"))
	user.OffBalance(2.2 SECONDS)
	playsound(user, 'sound/combat/riposte.ogg', 100, TRUE)

/datum/status_effect/debuff/baited
	id = "bait"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/baited
	duration = 200

/atom/movable/screen/alert/status_effect/debuff/baited
	name = "Baited"
	desc = "I fell for it. I'm exposed. I won't fall for it again. For now."
	icon_state = "bait"

/atom/movable/screen/alert/status_effect/debuff/baitedcd
	name = "Bait Cooldown"
	desc = "I used it. I must wait."
	icon_state = "effectcd"

/datum/status_effect/debuff/baitcd
	id = "baitcd"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/baitedcd
	duration = 200

/atom/movable/screen/alert/status_effect/debuff/feintcd
	name = "Feint Cooldown"
	desc = "I used it. I must wait, or risk a lower chance of success."
	icon_state = "effectcd"
