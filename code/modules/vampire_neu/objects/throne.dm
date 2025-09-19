/obj/structure/vampthrone
	name = "The Blood Throne"
	desc = "A big ominous throne."
	icon = 'icons/roguetown/misc/vthrone.dmi'
	icon_state = "throne"
	density = FALSE
	can_buckle = TRUE
	pixel_x = -32
	max_integrity = 999999
	buckle_lying = FALSE
	obj_flags = NONE

/obj/structure/roguethrone/post_buckle_mob(mob/living/M)
	..()
	density = TRUE
	M.set_mob_offsets("bed_buckle", _x = 0, _y = 8)

/obj/structure/roguethrone/post_unbuckle_mob(mob/living/M)
	..()
	density = FALSE
	M.reset_offsets("bed_buckle")
