/obj/effect/proc_holder/spell/invoked/frostarmor
	name = "Frost armor"
	overlay_state = "stoneskin"
	desc = "Harden the target's skin like stone. (+5 Constitution)"
	cost = 3
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 1 SECONDS
	recharge_time = 30 SECONDS
	warnie = "spellwarning"
	school = "transmutation"
	spell_tier = 3
	invocations = list("Perstare Sicut Saxum.") // Endure like Stone
	invocation_type = "whisper"
	glow_color = GLOW_COLOR_ICE
	glow_intensity = GLOW_INTENSITY_LOW
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	var/newcolor = rgb(136, 191, 255)

/obj/effect/proc_holder/spell/invoked/frostarmor/cast(mob/user)
	var/atom/A = user
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	new /obj/effect/temp_visual/snap_freeze(get_turf(user))

	if(spelltarget.has_status_effect(/datum/status_effect/buff/frostbite/frostarmor) && spelltarget.has_status_effect(/datum/status_effect/buff/frostarmor))
		spelltarget.remove_status_effect(/datum/status_effect/buff/frostarmor)
		spelltarget.remove_status_effect(/datum/status_effect/buff/frostbite/frostarmor)
		target.remove_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	else
		spelltarget.visible_message("[user] mutters an incantation and their skin hardens.")
		spelltarget.apply_status_effect(/datum/status_effect/buff/frostarmor)
		spelltarget.apply_status_effect(/datum/status_effect/buff/frostbite/frostarmor)
		target.add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)

	return TRUE

#define FROSTARMOR_FILTER "frostarmor_glow"

/atom/movable/screen/alert/status_effect/buff/frostarmor
	name = "Frost armor"
	desc = "My skin is hardened like ice."
	icon_state = "buff"

/datum/status_effect/buff/frostarmor
	var/outline_colour ="#2dade9ff"
	id = "frostarmor"
	alert_type = /atom/movable/screen/alert/status_effect/buff/frostarmor
	effectedstats = list(STATKEY_CON = 5, STATKEY_WIL = 3)
	duration = 30 MINUTES

/datum/status_effect/buff/stoneskin/on_apply()
	. = ..()
	var/filter = owner.get_filter(FROSTARMOR_FILTER)
	if (!filter)
		owner.add_filter(FROSTARMOR_FILTER, 1, list("type" = "outline", "color" = outline_colour, "alpha" = 50, "size" = 1))
	to_chat(owner, span_warning("My skin hardens like ice."))

/datum/status_effect/buff/stoneskin/on_remove()
	. = ..()
	to_chat(owner, span_warning("The ice shell cracks away."))
	owner.remove_filter(FROSTARMOR_FILTER)

#undef FROSTARMOR_FILTER

/datum/status_effect/buff/frostbite/frostarmor
	duration = 30 MINUTES

/datum/status_effect/buff/frostbite/frostarmor/tick()