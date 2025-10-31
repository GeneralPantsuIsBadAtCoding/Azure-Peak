/obj/effect/proc_holder/spell/invoked/pyro/fireaura
	name = "Fire Aura"
	overlay_state = "fireaura"
	desc = "Subdue the fire and make it dance around you! \n\
	Any living creatures near you will take damage within a short distance, \n\
	and they also have a chance to catch fire every second!"
	cost = 3
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 5 SECONDS
	recharge_time = 10 SECONDS
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

/obj/effect/proc_holder/spell/invoked/pyro/fireaura/cast(mob/user)
	var/atom/A = user
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	if(spelltarget.has_status_effect(/datum/status_effect/buff/fireaura))
		spelltarget.remove_status_effect(/datum/status_effect/buff/fireaura)
	else
		spelltarget.visible_message("[user] makes his own body burn with a bright, burning fire!")
		spelltarget.apply_status_effect(/datum/status_effect/buff/fireaura)

	return TRUE

#define FIREAURA_FILTER "fireaura_glow"

/atom/movable/screen/alert/status_effect/buff/fireaura
	name = "Fire Aura"
	desc = "Flames dancing around me while all living things are burning nearby!"
	icon_state = "fire"

/datum/status_effect/buff/fireaura
	id = "fireaura"
	alert_type = /atom/movable/screen/alert/status_effect/buff/fireaura
	effectedstats = list(STATKEY_WIL = -2)
	examine_text = "<font color='red'>Emit Fire Aura!"
	duration = 1 MINUTES
	var/outline_colour ="#e98e2dff"

/datum/status_effect/buff/fireaura/on_apply()
	. = ..()
	var/filter = owner.get_filter(FIREAURA_FILTER)
	if (!filter)
		owner.add_filter(FIREAURA_FILTER, 1, list("type" = "outline", "color" = outline_colour, "alpha" = 50, "size" = 1))
	to_chat(owner, span_warning("My skin heat like fire."))

/datum/status_effect/buff/fireaura/tick()
	var/mob/living/user = owner
	user.adjustFireLoss(1)
	for(var/mob/living/L in view(3, get_turf(user)))
		if(L.stat == DEAD || L.stat != CONSCIOUS || get_dist(L, user) > 3)
			L.remove_status_effect(/datum/status_effect/buff/fireaurabad)
			return FALSE
		if(L == user)
			continue
		L.apply_status_effect(/datum/status_effect/buff/fireaurabad)

/datum/status_effect/buff/fireaura/on_remove()
	. = ..()
	to_chat(owner, span_warning("The flame shell fades away."))
	owner.remove_filter(FIREAURA_FILTER)

/datum/status_effect/buff/fireaurabad
	id = "fireaurabad"
	duration = 10 SECONDS
	effectedstats = list(STATKEY_CON = -1)
	alert_type = /atom/movable/screen/alert/status_effect/fireaurabad

/atom/movable/screen/alert/status_effect/fireaurabad
	name = "Magical Flame"
	desc = "A magical flame is devouring my body! We need to move away from the source!"
	icon_state = "fire"

/datum/status_effect/buff/fireaura/on_apply()
	. = ..()
	to_chat(owner, span_warning("A magical flame is devouring my body! We need to move away from the source!"))

/datum/status_effect/buff/fireaurabad/tick()
	var/mob/living/target = owner
	target.adjustFireLoss(5)
	if(prob(25))
		target.adjust_fire_stacks(1)
		target.ignite_mob()

#undef FIREAURA_FILTER