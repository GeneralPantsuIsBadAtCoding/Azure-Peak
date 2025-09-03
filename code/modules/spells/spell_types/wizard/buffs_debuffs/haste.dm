/obj/effect/proc_holder/spell/invoked/haste
	name = "Haste"
	desc = "Cause a target to be magically hastened. (+5 Speed, 0.85 x Action Cooldown)"
	cost = 4
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 1 SECONDS
	recharge_time = 2 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	overlay_state = "haste" // Temporary icon from RW
	spell_tier = 2
	invocations = list("Festinatio!")
	invocation_type = "shout" // I mean, it is fast
	glow_color = GLOW_COLOR_BUFF
	glow_intensity = GLOW_INTENSITY_MEDIUM
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane

/obj/effect/proc_holder/spell/invoked/haste/cast(list/targets, mob/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	if(spelltarget != user)
		user.visible_message("[user] mutters an incantation and [spelltarget] briefly shines yellow.")
		spelltarget.apply_status_effect(/datum/status_effect/buff/haste, 2 MINUTES)
		to_chat(user, span_notice("With another person as a conduit, my spell's duration is doubled."))
	else
		user.visible_message("[user] mutters an incantation and they briefly shine yellow.")
		spelltarget.apply_status_effect(/datum/status_effect/buff/haste, 1 MINUTES)

	return TRUE
	