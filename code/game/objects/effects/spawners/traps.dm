/obj/effect/spawner/trap
	name = "random trap"
	icon = 'icons/obj/hand_of_god_structures.dmi'
	icon_state = "trap_rand"

/obj/effect/spawner/trap/Initialize(mapload)
	..()
	var/booly = pick(1,2) //50% chance to spawn a trap or nothing at all, intended to keep people guessing.
	if(booly == 1)
		var/new_trap = pick(/obj/structure/trap/curse,
							/obj/structure/trap/flame,
							/obj/structure/trap/shock,
							/obj/structure/trap/bomb,
							/obj/structure/trap/rock_fall,
							/obj/structure/trap/saw_blades,
							/obj/structure/trap/wall_projectile,
							/obj/structure/trap/wall_projectile/acidsplash,
							/obj/structure/trap/wall_projectile/frostbolt,
							/obj/structure/trap/curse/hidden,
							/obj/structure/trap/curse,
							/obj/structure/trap/water)
		new new_trap(get_turf(src))
	return INITIALIZE_HINT_QDEL
