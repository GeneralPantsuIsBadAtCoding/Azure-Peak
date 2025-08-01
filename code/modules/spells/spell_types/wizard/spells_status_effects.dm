// Folder for any status effects that is shared between more than one spell. For now, just Frostbite
/datum/status_effect/buff/frostbite
	id = "frostbite"
	alert_type = /atom/movable/screen/alert/status_effect/buff/frostbite
	duration = 20 SECONDS
	effectedstats = list("speed" = -2)

/atom/movable/screen/alert/status_effect/buff/frostbite
	name = "Frostbite"
	desc = "I can feel myself slowing down."
	icon_state = "debuff"
	color = "#00fffb" //talk about a coder sprite

/datum/status_effect/buff/frostbite/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.update_vision_cone()
	var/newcolor = rgb(136, 191, 255)
	target.add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/atom, remove_atom_colour), TEMPORARY_COLOUR_PRIORITY, newcolor), 20 SECONDS)
	target.add_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, update=TRUE, priority=100, multiplicative_slowdown=4, movetypes=GROUND)

/datum/status_effect/buff/frostbite/on_remove()
	var/mob/living/target = owner
	target.update_vision_cone()
	target.remove_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, TRUE)
	. = ..()

/datum/status_effect/buff/witherd
	id = "withered"
	alert_type = /atom/movable/screen/alert/status_effect/buff/witherd
	duration = 30 SECONDS
	effectedstats = list("speed" = -2,"strength" = -2,"constitution"= -2,"endurance" = -2)

/atom/movable/screen/alert/status_effect/buff/witherd
	name = "Withering"
	desc = "I can feel my physical prowess waning."
	icon_state = "debuff"
	color = "#b884f8" //talk about a coder sprite x2


/datum/status_effect/buff/witherd/on_apply()
	. = ..()
	to_chat(owner, span_warning("I feel sapped of vitality!"))
	var/mob/living/target = owner
	target.update_vision_cone()
	var/newcolor = rgb(207, 135, 255)
	target.add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/atom, remove_atom_colour), TEMPORARY_COLOUR_PRIORITY, newcolor), 30 SECONDS)

/datum/status_effect/buff/witherd/on_remove()
	. = ..()
	to_chat(owner, span_warning("I feel my physical prowess returning."))

/datum/status_effect/buff/lightningstruck
	id = "lightningstruck"
	alert_type = /atom/movable/screen/alert/status_effect/buff/lightningstruck
	duration = 6 SECONDS
	effectedstats = list("speed" = -2)

/atom/movable/screen/alert/status_effect/buff/lightningstruck
	name = "Lightning Struck"
	desc = "I can feel the electricity coursing through me."
	icon_state = "debuff"
	color = "#ffff00"

/datum/status_effect/buff/lightningstruck/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.update_vision_cone()
	target.add_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, update=TRUE, priority=100, multiplicative_slowdown=4, movetypes=GROUND)

/datum/status_effect/buff/lightningstruck/on_remove()
	. = ..()
	var/mob/living/target = owner
	target.update_vision_cone()
	target.remove_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, TRUE)
