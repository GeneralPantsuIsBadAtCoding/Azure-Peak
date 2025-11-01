/obj/effect/proc_holder/spell/invoked/pyro/fireresist
	name = "Fireresist"
	overlay_state = "fireresist"
	desc = "Weaken your body to grant fireresistance to anyone or yourself! \n\
	You can re-cast the spell on the target to prematurely remove it and get rid of your weakening."
	cost = 2
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 5 SECONDS
	recharge_time = 30 SECONDS
	warnie = "spellwarning"
	school = "transmutation"
	spell_tier = 2
	invocations = list("Accincti flammis.")
	invocation_type = "whisper"
	glow_color = GLOW_COLOR_FIRE
	glow_intensity = GLOW_INTENSITY_LOW
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	range = 7

/obj/effect/proc_holder/spell/invoked/pyro/fireresist/cast(list/targets, mob/living/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	if(spelltarget != user)
		if(spelltarget.has_status_effect(/datum/status_effect/buff/dragonhide/fireresist))
			spelltarget.visible_message("[user] mutters an incantation and [spelltarget] 's coal shell fades away.")
			spelltarget.remove_status_effect(/datum/status_effect/buff/dragonhide/fireresist)
			user.remove_status_effect(/datum/status_effect/buff/fireresistdebuff)
		else
			user.visible_message("[user] mutters an incantation and [spelltarget] 's skin hardens like coal.")
			spelltarget.apply_status_effect(/datum/status_effect/buff/dragonhide/fireresist)
			user.apply_status_effect(/datum/status_effect/buff/fireresistdebuff)
	else
		if(spelltarget.has_status_effect(/datum/status_effect/buff/dragonhide/fireresist))
			spelltarget.remove_status_effect(/datum/status_effect/buff/dragonhide/fireresist)
			spelltarget.remove_status_effect(/datum/status_effect/buff/fireresistdebuff)
		else
			user.visible_message("[user] mutters an incantation and their skin hardens like coal.")
			spelltarget.apply_status_effect(/datum/status_effect/buff/dragonhide/fireresist)
			spelltarget.apply_status_effect(/datum/status_effect/buff/fireresistdebuff)

	return TRUE

//VVV Just rename this shit. VVV

/atom/movable/screen/alert/status_effect/buff/dragonhide/fireresist
	name = "Fireresistance"
	desc = "Flames dance at my heels, yet do not sting!"
	icon_state = "fire"

/datum/status_effect/buff/dragonhide/fireresist
	id = "fireresist"
	examine_text = "<font color='red'>A fireresistance!"
	alert_type = /atom/movable/screen/alert/status_effect/buff/dragonhide/fireresist
	effectedstats = list(STATKEY_CON = -2) //Target body loosing CON, but getting fireresist.
	duration = 2 MINUTES

/atom/movable/screen/alert/status_effect/buff/fireresistdebuff
	name = "Fireresistance"
	desc = "Flames dance at my heels, yet do not sting!"
	icon_state = "fire"

/datum/status_effect/buff/fireresistdebuff
	id = "fireresist"
	examine_text = "<font color='red'>A fireresistance!"
	alert_type = /atom/movable/screen/alert/status_effect/buff/fireresistdebuff
	effectedstats = list(STATKEY_CON = -2) //Target body loosing CON, but getting fireresist.
	duration = 2 MINUTES