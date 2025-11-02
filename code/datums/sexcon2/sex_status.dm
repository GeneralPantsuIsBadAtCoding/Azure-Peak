/datum/status_effect/knot_tied
	id = "knot_tied"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/knot_tied
	effectedstats = list(STATKEY_STR = -1, STATKEY_WIL = -2, STATKEY_SPD = -2, STATKEY_INT = -3)

/atom/movable/screen/alert/status_effect/knot_tied
	name = "Knotted"

/datum/status_effect/knot_fucked_stupid
	id = "knot_fucked_stupid"
	duration = 2 MINUTES
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/knot_fucked_stupid
	effectedstats = list(STATKEY_INT = -10)

/atom/movable/screen/alert/status_effect/knot_fucked_stupid
	name = "Fucked Stupid"
	desc = "Mmmph I can't think straight..."

/datum/status_effect/knot_gaped
	id = "knot_gaped"
	duration = 60 SECONDS
	tick_interval = 10 SECONDS
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/knot_gaped
	effectedstats = list(STATKEY_STR = -1, STATKEY_SPD = -2, STATKEY_INT = -1)
	var/last_loc

/datum/status_effect/knot_gaped/on_apply()
	last_loc = get_turf(owner)
	return ..()

/datum/status_effect/knot_gaped/tick()
	var/cur_loc = get_turf(owner)
	if(get_dist(cur_loc, last_loc) <= 5) // too close, don't spawn a puddle
		return
	var/turf/turf = get_turf(owner)
	new /obj/effect/decal/cleanable/coom(turf)
	playsound(owner, pick('sound/misc/bleed (1).ogg', 'sound/misc/bleed (2).ogg', 'sound/misc/bleed (3).ogg'), 50, TRUE, -2, ignore_walls = FALSE)
	last_loc = cur_loc

/atom/movable/screen/alert/status_effect/knot_gaped
	name = "Gaped"
	desc = "You were forcefully withdrawn from. Warmth runs freely down your thighs..."

/datum/status_effect/knotted
	id = "knotted"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/knotted

/atom/movable/screen/alert/status_effect/knotted
	name = "Knotted"
	desc = "I have to be careful where I step..."
