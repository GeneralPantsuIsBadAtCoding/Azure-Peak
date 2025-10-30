/obj/effect/proc_holder/spell/invoked/fireaura
	name = "Fireaura"
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

/obj/effect/proc_holder/spell/invoked/fireaura/cast(mob/user)
	var/atom/A = user
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	if(spelltarget.has_status_effect(/datum/status_effect/buff/fireaura))
		remove_status_effect(/datum/status_effect/buff/fireaura)
	else
		spelltarget.visible_message("[user] mutters an incantation and their skin hardens.")
		spelltarget.apply_status_effect(/datum/status_effect/buff/fireaura)

	return TRUE

#define FIREAURA_FILTER "fireaura_glow"

/datum/status_effect/buff/fireaura
	id = "fireraura"
	alert_type = /atom/movable/screen/alert/status_effect/buff/fireaura
	examine_text = "<font color='red'>Im a fireresistance!"

/atom/movable/screen/alert/status_effect/buff/fireaura
	name = "Fire Aura"
	desc = "Flames dance at my heels, yet do not sting!"
	effectedstats = list(STATKEY_WIL = -2)
	duration = 2 MINUTES
	var/outline_colour ="#e98e2dff"

/datum/status_effect/buff/stoneskin/on_apply()
	. = ..()
	var/filter = owner.get_filter(FIREAURA_FILTER)
	if (!filter)
		owner.add_filter(FIREAURA_FILTER, 1, list("type" = "outline", "color" = outline_colour, "alpha" = 50, "size" = 1))
	to_chat(owner, span_warning("My skin hardens like ice."))

/datum/status_effect/buff/stoneskin/on_remove()
	. = ..()
	to_chat(owner, span_warning("The ice shell cracks away."))
	owner.remove_filter(FIREAURA_FILTER)

/datum/status_effect/buff/barkeepbuff/tick(var/mob/user, var/mob/living/M)
	.=..()
	for(M in range(5, get_turf(user))) //apply damage over time to mobs
		if(M == user)
			continue
		M.adjustFireLoss(5)
		if(prob(50))
			M.adjust_fire_stacks(1)
			M.ignite_mob()

#undef FIREAURA_FILTER