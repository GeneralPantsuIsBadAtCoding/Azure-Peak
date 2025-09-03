/obj/effect/proc_holder/spell/invoked/giants_strength
	name = "Giant's Strength"
	overlay_state = "giantsstrength"
	desc = "Strengthen the target. (+3 Strength)" // Design Note: +3 instead of +5 for direct damage stats
	cost = 4 // Direct DPS stats
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 1 SECONDS
	recharge_time = 2 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	overlay_state = "giants_strength"
	spell_tier = 2
	invocations = list("Vis Gigantis.") // Vis - Strength. Gigantis - Singular possessive form.
	invocation_type = "whisper"
	glow_color = GLOW_COLOR_BUFF
	glow_intensity = GLOW_INTENSITY_LOW
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	range = 7

/obj/effect/proc_holder/spell/invoked/giants_strength/cast(list/targets, mob/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	if(spelltarget != user)
		user.visible_message("[user] mutters an incantation and [spelltarget] 's muscles strengthen and grow.")
		to_chat(user, span_notice("With another person as a conduit, my spell's duration is doubled."))
		spelltarget.apply_status_effect(/datum/status_effect/buff/giants_strength/other)
	else
		user.visible_message("[user] mutters an incantation and their muscles strengthen and grow.")
		spelltarget.apply_status_effect(/datum/status_effect/buff/giants_strength)

	return TRUE
