/datum/coven/celerity
	name = "Celerity"
	desc = "Boosts your speed. Violates Masquerade."
	icon_state = "celerity"
	power_type = /datum/coven_power/celerity

/datum/coven_power/celerity
	name = "Celerity power name"
	desc = "Celerity power description"
	var/multiplicative_slowdown = -0.5

/datum/coven_power/celerity/proc/celerity_visual(datum/coven_power/celerity/source, atom/newloc, dir)
	SIGNAL_HANDLER

	spawn()
		var/obj/effect/celerity/C = new(owner.loc)
		C.name = owner.name
		C.appearance = owner.appearance
		C.dir = owner.dir
		animate(C, pixel_x = rand(-16, 16), pixel_y = rand(-16, 16), alpha = 0, time = 0.5 SECONDS)
		if(owner.CheckEyewitness(owner, owner, 7, FALSE))
			owner.AdjustMasquerade(-1)

/obj/effect/celerity
	name = "Afterimage"
	desc = "..."
	anchored = TRUE

/obj/effect/celerity/Initialize()
	. = ..()
	spawn(0.5 SECONDS)
		qdel(src)

//CELERITY 1
/datum/coven_power/celerity/one
	name = "Celerity 1"
	desc = "Enhances your speed to make everything a little bit easier."

	level = 1
	research_cost = 0
	check_flags = COVEN_CHECK_LYING | COVEN_CHECK_IMMOBILE
	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/coven_power/celerity/two,
		/datum/coven_power/celerity/three,
		/datum/coven_power/celerity/four,
		/datum/coven_power/celerity/five
	)

/datum/coven_power/celerity/one/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(celerity_visual))

	owner.celerity_visual = TRUE
	owner.add_movespeed_modifier(MOVESPEED_ID_CELERITY, multiplicative_slowdown = -0.2)
	owner.apply_status_effect(/datum/status_effect/buff/celerity, level)

/datum/coven_power/celerity/one/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	owner.celerity_visual = FALSE
	owner.remove_movespeed_modifier(MOVESPEED_ID_CELERITY)

//CELERITY 2

/datum/coven_power/celerity/two
	name = "Celerity 2"
	desc = "Significantly improves your speed and reaction time."

	level = 2
	check_flags = COVEN_CHECK_LYING | COVEN_CHECK_IMMOBILE
	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/coven_power/celerity/one,
		/datum/coven_power/celerity/three,
		/datum/coven_power/celerity/four,
		/datum/coven_power/celerity/five
	)

/datum/coven_power/celerity/two/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(celerity_visual))

	owner.celerity_visual = TRUE
	owner.add_movespeed_modifier(MOVESPEED_ID_CELERITY, multiplicative_slowdown = -0.4)

/datum/coven_power/celerity/two/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	owner.celerity_visual = FALSE
	owner.remove_movespeed_modifier(MOVESPEED_ID_CELERITY)

//CELERITY 3
/datum/coven_power/celerity/three
	name = "Celerity 3"
	desc = "Move faster. React in less time. Your body is under perfect control."

	level = 3
	research_cost = 2
	check_flags = COVEN_CHECK_LYING | COVEN_CHECK_IMMOBILE
	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/coven_power/celerity/one,
		/datum/coven_power/celerity/two,
		/datum/coven_power/celerity/four,
		/datum/coven_power/celerity/five
	)

/datum/coven_power/celerity/three/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(celerity_visual))

	owner.celerity_visual = TRUE
	owner.add_movespeed_modifier(MOVESPEED_ID_CELERITY, multiplicative_slowdown = -0.5)

/datum/coven_power/celerity/three/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	owner.celerity_visual = FALSE
	owner.remove_movespeed_modifier(MOVESPEED_ID_CELERITY)

//CELERITY 4
/datum/coven_power/celerity/four
	name = "Celerity 4"
	desc = "Breach the limits of what is humanly possible. Move like a lightning bolt."

	level = 4
	research_cost = 2
	minimal_generation = GENERATION_ANCILLAE
	check_flags = COVEN_CHECK_LYING | COVEN_CHECK_IMMOBILE
	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/coven_power/celerity/one,
		/datum/coven_power/celerity/two,
		/datum/coven_power/celerity/three,
		/datum/coven_power/celerity/five
	)

/datum/coven_power/celerity/four/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(celerity_visual))

	owner.celerity_visual = TRUE
	owner.add_movespeed_modifier(MOVESPEED_ID_CELERITY, multiplicative_slowdown = -0.8)

/datum/coven_power/celerity/four/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	owner.celerity_visual = FALSE
	owner.remove_movespeed_modifier(MOVESPEED_ID_CELERITY)

//CELERITY 5
/datum/coven_power/celerity/five
	name = "Celerity 5"
	desc = "You are like light. Blaze your way through the world."

	level = 5
	minimal_generation = GENERATION_ANCILLAE
	research_cost = 3
	check_flags = COVEN_CHECK_LYING | COVEN_CHECK_IMMOBILE
	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/coven_power/celerity/one,
		/datum/coven_power/celerity/two,
		/datum/coven_power/celerity/three,
		/datum/coven_power/celerity/four
	)

/datum/coven_power/celerity/five/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(celerity_visual))

	owner.celerity_visual = TRUE
	owner.add_movespeed_modifier(MOVESPEED_ID_CELERITY, multiplicative_slowdown = -1)

/datum/coven_power/celerity/five/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	owner.celerity_visual = FALSE
	owner.remove_movespeed_modifier(MOVESPEED_ID_CELERITY)
