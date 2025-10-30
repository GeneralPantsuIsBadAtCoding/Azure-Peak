/obj/effect/proc_holder/spell/invoked/fireresist
	name = "Fireresist"
	overlay_state = "stoneskin"
	desc = "Harden the target's skin like stone. (+5 Constitution)"
	cost = 2
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 1 SECONDS
	recharge_time = 2 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	spell_tier = 2
	invocations = list("Perstare Sicut Saxum.") // Endure like Stone
	invocation_type = "whisper"
	glow_color = GLOW_COLOR_BUFF
	glow_intensity = GLOW_INTENSITY_LOW
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	range = 7

/obj/effect/proc_holder/spell/invoked/fireresist/cast(list/targets, mob/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	if(spelltarget != user)
		user.visible_message("[user] mutters an incantation and [spelltarget] 's skin hardens like coal.")
		to_chat(user, span_notice("With another person as a conduit, my spell's duration is doubled."))
		spelltarget.apply_status_effect(/datum/status_effect/buff/dragonhide/fireresist/other)
	else
		if(spelltarget.has_status_effect(/datum/status_effect/buff/dragonhide/fireresist))
			spelltarget.remove_status_effect(/datum/status_effect/buff/dragonhide/fireresist)
		else
			user.visible_message("[user] mutters an incantation and their skin hardens.")
			spelltarget.apply_status_effect(/datum/status_effect/buff/dragonhide/fireresist)

	return TRUE

//VVV Just rename this shit. VVV

/datum/status_effect/buff/dragonhide/fireresist
	id = "fireresist"
	alert_type = /atom/movable/screen/alert/status_effect/buff/dragonhide/fireresist
	examine_text = "<font color='red'>Im a fireresistance!"

/atom/movable/screen/alert/status_effect/buff/dragonhide/fireresist
	name = "Fireresistance"
	desc = "Flames dance at my heels, yet do not sting!"
	effectedstats = list(STATKEY_CON = -2) //Your body loosing CON, but getting fireresist.

/datum/status_effect/buff/dragonhide/fireresist/other
	duration = 2 MINUTES