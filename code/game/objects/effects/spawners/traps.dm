/obj/effect/spawner/trap
	name = "random trap"
	icon = 'icons/obj/hand_of_god_structures.dmi'
	icon_state = "trap_rand"

/obj/effect/spawner/trap/Initialize(mapload)
	..()
	var/booly = pick(1,2) //50% chance to spawn a trap or nothing at all, intended to keep people guessing.
	if(booly == 1)
		var/new_type = pick(subtypesof(/obj/structure/trap))
		new new_type(get_turf(src))
	return INITIALIZE_HINT_QDEL
