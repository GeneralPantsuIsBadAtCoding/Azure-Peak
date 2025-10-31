/obj/effect/proc_holder/spell/invoked/firewalk
	name = "Firewalker"
	overlay_state = "justflame"
	desc = "Harden the target's skin like stone. (+5 Constitution)"
	cost = 4
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 0.5 SECONDS
	recharge_time = 2 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	spell_tier = 3
	invocations = list("Perstare Sicut Saxum.") // Endure like Stone
	invocation_type = "whisper"
	glow_color = GLOW_COLOR_FIRE
	glow_intensity = GLOW_INTENSITY_HIGH
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane

/obj/effect/proc_holder/spell/invoked/firewalk/cast(mob/user)
	var/atom/A = user
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	spelltarget.visible_message("[user] mutters an incantation and their skin hardens.")
	spelltarget.apply_status_effect(/datum/status_effect/buff/firewalker)

	return TRUE

#define FIREWALKER_FILTER "firewalker_glow"

/atom/movable/screen/alert/status_effect/buff/firewalker
	name = "Fire Aura"
	desc = "Flames dance at my heels, yet do not sting!"
	icon_state = "fire"

/datum/status_effect/buff/firewalker
	id = "fireaura"
	alert_type = /atom/movable/screen/alert/status_effect/buff/firewalker
	effectedstats = list(STATKEY_SPD = -2)
	examine_text = "<font color='red'>Emit fireaura!"
	duration = 30 SECONDS
	var/outline_colour ="#f96d1bff"

/datum/status_effect/buff/firewalker/on_apply()
	. = ..()
	var/filter = owner.get_filter(FIREWALKER_FILTER)
	if (!filter)
		owner.add_filter(FIREWALKER_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 80, "size" = 1))
	to_chat(owner, span_warning("My skin heat like fire."))

/datum/status_effect/buff/fireaura/tick()
	var/mob/living/user = owner
	if(owner.stat == DEAD || owner.stat != CONSCIOUS)
		owner.remove_status_effect(/datum/status_effect/buff/firewalker)
		return FALSE
	new /obj/effect/hotspot(get_turf(user))

/datum/status_effect/buff/fireaura/on_remove()
	. = ..()
	to_chat(owner, span_warning("The flame shell cracks away."))
	owner.remove_filter(FIREWALKER_FILTER)

#define FIREWALKER_FILTER