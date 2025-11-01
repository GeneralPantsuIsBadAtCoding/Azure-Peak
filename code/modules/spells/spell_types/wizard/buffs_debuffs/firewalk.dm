/obj/effect/proc_holder/spell/invoked/pyro/firewalk
	name = "Firewalker"
	overlay_state = "firewalk"
	desc = "Watch the fire dance and join the dance together! \n\
	The ground under your feet will burn! \n\
	You can re-cast the spell to prematurely remove it and get rid of your weakening. \n\
	don't forget to take care of fireimmunity..."
	cost = 4
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 0.5 SECONDS
	recharge_time = 2 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	spell_tier = 3
	invocations = list("Ignis Saltatio.")
	invocation_type = "whisper"
	glow_color = GLOW_COLOR_FIRE
	glow_intensity = GLOW_INTENSITY_HIGH
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane

/obj/effect/proc_holder/spell/invoked/pyro/firewalk/cast(mob/user)
	var/atom/A = user
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	spelltarget.visible_message("[user] mutters an incantation and the ground beneath his feet begins to burn!")
	spelltarget.apply_status_effect(/datum/status_effect/buff/firewalker)

	return TRUE

#define FIREWALKER_FILTER "firewalker_glow"

/atom/movable/screen/alert/status_effect/buff/firewalker
	name = "Fire Aura"
	desc = "The ground is burning under my feet!"
	icon_state = "fire"

/datum/status_effect/buff/firewalker
	id = "fireaura"
	alert_type = /atom/movable/screen/alert/status_effect/buff/firewalker
	effectedstats = list(STATKEY_SPD = -2)
	examine_text = "<font color='red'>Dancing in the fire!!"
	duration = 10 SECONDS
	var/outline_colour ="#f96d1bff"

/datum/status_effect/buff/firewalker/on_apply()
	. = ..()
	var/filter = owner.get_filter(FIREWALKER_FILTER)
	if (!filter)
		owner.add_filter(FIREWALKER_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 80, "size" = 1))

/datum/status_effect/buff/firewalker/tick()
	var/mob/living/user = owner
	var/turf/T = get_turf(user)
	if(owner.stat == DEAD || owner.stat != CONSCIOUS)
		owner.remove_status_effect(/datum/status_effect/buff/firewalker)
		return FALSE
	for(var/turf/AT in view(1, T))
		new /obj/effect/hotspot(get_turf(AT))

/datum/status_effect/buff/firewalker/on_remove()
	. = ..()
	to_chat(owner, span_warning("The flame under my feets fades away."))
	owner.remove_filter(FIREWALKER_FILTER)

#define FIREWALKER_FILTER