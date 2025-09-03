///////////////////////////
// Antag Related Debuffs //
///////////////////////////

//If a debuff is directly tied to an antag, it should be here, giving or recieving. 
//Try to keep things related to gods in miracles for now.

/datum/status_effect/debuff/ritualdefiled
	id = "ritualdefiled"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/ritualdefiled
	effectedstats = list("strength" = -1, "endurance" = -1, "constitution" = -1, "speed" = -1, "fortune" = -1)
	duration = 1 HOURS // Punishing AS FUCK, but not as punishing as being dead.

/atom/movable/screen/alert/status_effect/debuff/ritualdefiled
	name = "Tainted Lux"
	desc = "My Lux has been tainted in a vile heretic ritual."

/datum/status_effect/debuff/vamp_dreams
	id = "sleepytime"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/vamp_dreams

/atom/movable/screen/alert/status_effect/debuff/vamp_dreams
	name = "Insight"
	desc = "With some sleep in a coffin I feel like I could become better."
	icon_state = "sleepy"
