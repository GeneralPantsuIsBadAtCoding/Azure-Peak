/obj/effect/proc_holder/spell/invoked/frostarmor
	name = "Frost armor"
	overlay_state = "stoneskin"
	desc = "Harden the target's skin like stone. (+5 Constitution)"
	cost = 3
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 1 SECONDS
	recharge_time = 10 SECONDS
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
		spelltarget.remove_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	else
		spelltarget.visible_message("[user] mutters an incantation and their skin hardens.")
		spelltarget.apply_status_effect(/datum/status_effect/buff/frostarmor)
		spelltarget.add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)

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
	effectedstats = list(STATKEY_CON = 5, STATKEY_WIL = 3, STATKEY_SPD = -2)
	duration = 30 MINUTES

/datum/status_effect/buff/stoneskin/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.update_vision_cone()
	var/filter = owner.get_filter(FROSTARMOR_FILTER)
	if (!filter)
		owner.add_filter(FROSTARMOR_FILTER, 1, list("type" = "outline", "color" = outline_colour, "alpha" = 50, "size" = 1))
	target.add_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, update=TRUE, priority=100, multiplicative_slowdown=4, movetypes=GROUND)
	target.stamina_add(25)
	to_chat(owner, span_warning("My skin hardens like ice."))

/datum/status_effect/buff/stoneskin/on_remove()
	. = ..()
	to_chat(owner, span_warning("The ice shell cracks away."))
	owner.remove_filter(FROSTARMOR_FILTER)
	target.update_vision_cone()
	target.remove_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, TRUE)

#undef FROSTARMOR_FILTER