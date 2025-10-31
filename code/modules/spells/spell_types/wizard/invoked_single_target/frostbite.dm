/obj/effect/proc_holder/spell/invoked/frostbite
	name = "Frostbite"
	desc = "Freeze your enemy with an icy blast that does low damage, but reduces the target's Speed for a considerable length of time."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 8
	recharge_time = 25 SECONDS
	range = 7
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	gesture_required = TRUE
	associated_skill = /datum/skill/magic/arcane
	spell_tier = 2
	invocations = list("Congelationis!")
	invocation_type = "shout"
	glow_color = GLOW_COLOR_ICE
	glow_intensity = GLOW_INTENSITY_LOW
	cost = 3

/obj/effect/proc_holder/spell/invoked/frostbite/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/L = targets[1]
		L.adjustFireLoss(12)
		L.adjustBruteLoss(12)
		if(L.has_status_effect(/datum/status_effect/buff/frostbite))
			return
		else
			if(L.has_status_effect(/datum/status_effect/buff/frost))
				playsound(get_turf(L), 'sound/combat/fracture/fracturedry (1).ogg', 80, TRUE, soundping = TRUE)
				L.remove_status_effect(/datum/status_effect/buff/frost)
				L.apply_status_effect(/datum/status_effect/buff/frostbite)
			else
				L.apply_status_effect(/datum/status_effect/buff/frost)
		new /obj/effect/temp_visual/snap_freeze(get_turf(L))
