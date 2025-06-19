/particles/hotspring_steam
	icon = 'icons/effects/particles/smoke.dmi'
	icon_state	= list("steam_cloud_1"=5, "steam_cloud_2"=5, "steam_cloud_3"=5, "steam_cloud_4"=5, "steam_cloud_5"=5)
	color = "#FFFFFF8A"
	count = 2
	spawning = 0.3
	lifespan = 3 SECONDS
	fade = 1.2 SECONDS
	fadein = 0.4 SECONDS
	position = generator(GEN_BOX, list(-17,-15,0), list(24,15,0), NORMAL_RAND)
	scale = generator(GEN_VECTOR, list(0.9,0.9), list(1.1,1.1), NORMAL_RAND)
	drift = generator(GEN_SPHERE, list(-0.01,0), list(0.01,0.01), UNIFORM_RAND)
	spin = generator(GEN_NUM, list(-2,2), NORMAL_RAND)
	gravity = list(0.05, 0.28)
	friction = 0.3
	grow = 0.037

/obj/effect/overlay/water
	icon = 'icons/turf/newwater.dmi'
	icon_state = "springbottom"
	density = 0
	mouse_opacity = 0
	layer = BELOW_MOB_LAYER
	anchored = TRUE

/obj/effect/overlay/water/top
	icon_state = "springtop"
	layer = BELOW_MOB_LAYER

///these were unfortunately requested to not be smoothed. I will likely create a smooth helper version aswell though
///the issue is they would need atleast a 2x2 to smooth proper.
/turf/open/hotspring
	nomouseover = TRUE
	icon = 'icons/obj/structures/hotspring.dmi'
	icon_state = "hotspring"
	slowdown = 5
	var/obj/effect/abstract/particle_holder/cached/particle_effect
	var/obj/effect/overlay/water/water_overlay
	var/obj/effect/overlay/water/top/water_top_overlay

/turf/open/hotspring/Initialize()
	. = ..()
	particle_effect = new(src, /particles/hotspring_steam, 6)
	//render the steam over mobs and objects on the game plane
	particle_effect.vis_flags &= ~VIS_INHERIT_PLANE
	water_overlay = new(src)
	water_top_overlay = new(src)
	update_icon()

/turf/open/hotspring/update_icon()
	if(water_overlay)
		water_overlay.icon_state = "springbottom"
	if(water_top_overlay)
		water_top_overlay.icon_state = "springtop"

/turf/open/hotspring/Entered(atom/movable/AM, atom/oldLoc)
	. = ..()
	for(var/obj/structure/S in src)
		if(S.obj_flags & BLOCK_Z_OUT_DOWN)
			return
	if(isliving(AM) && !AM.throwing)
		var/mob/living/L = AM
		if(!(L.mobility_flags & MOBILITY_STAND))
			L.SoakMob(BELOW_CHEST)
		if(water_overlay)
			if(!istype(oldLoc, type))
				playsound(AM, 'sound/foley/waterenter.ogg', 100, FALSE)
			else
				playsound(AM, pick('sound/foley/watermove (1).ogg','sound/foley/watermove (2).ogg'), 100, FALSE)
			if(istype(oldLoc, type) && (get_dir(src, oldLoc) != SOUTH))
				water_overlay.layer = ABOVE_MOB_LAYER
				water_overlay.plane = GAME_PLANE_UPPER
			else
				spawn(6)
					if(AM.loc == src)
						water_overlay.layer = ABOVE_MOB_LAYER
						water_overlay.plane = GAME_PLANE_UPPER

/turf/open/hotspring/Exited(atom/movable/AM, atom/newloc)
	. = ..()
	for(var/obj/structure/S in src)
		if(S.obj_flags & BLOCK_Z_OUT_DOWN)
			return
	if(isliving(AM) && !AM.throwing)
		if(water_overlay)
			if((get_dir(src, newloc) == SOUTH))
				water_overlay.layer = BELOW_MOB_LAYER
				water_overlay.plane = GAME_PLANE
			else
				spawn(6)
					if(!locate(/mob/living) in src)
						water_overlay.layer = BELOW_MOB_LAYER
						water_overlay.plane = GAME_PLANE
		for(var/D in GLOB.cardinals) //adjacent to a floor to hold onto
			if(istype(get_step(newloc, D), /turf/open/floor))
				return

/turf/open/hotspring/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum, damage_flag = "blunt")
	..()
	playsound(src, pick('sound/foley/water_land1.ogg','sound/foley/water_land2.ogg','sound/foley/water_land3.ogg'), 100, FALSE)

/turf/open/hotspring/Destroy()
	. = ..()
	if(water_overlay)
		QDEL_NULL(water_overlay)
	if(water_top_overlay)
		QDEL_NULL(water_top_overlay)

/obj/structure/hotspring/border/Initialize()
	. = ..()
	particle_effect = new(src, /particles/hotspring_steam, 6)
	particle_effect.vis_flags &= ~VIS_INHERIT_PLANE

/obj/structure/hotspring/border/Crossed(atom/movable/AM)
	. = ..()
	for(var/obj/structure/S in get_turf(src))
		if(S.obj_flags & BLOCK_Z_OUT_DOWN)
			return

	if(!edge)
		playsound(AM, pick('sound/foley/watermove (1).ogg','sound/foley/watermove (2).ogg'), 40, FALSE)

/obj/structure/hotspring/border
	name = "hotspring border"
	icon = 'icons/obj/structures/hotspring.dmi'
	icon_state = "hotspring_border_1"
	object_slowdown = 0
	var/obj/effect/abstract/particle_holder/cached/particle_effect
	var/edge = TRUE

/obj/structure/hotspring/border/two
	icon_state = "hotspring_border_2"
	object_slowdown = 5
	edge = FALSE

/obj/structure/hotspring/border/three
	icon_state = "hotspring_border_3"
	object_slowdown = 0
	edge = TRUE

/obj/structure/hotspring/border/four
	icon_state = "hotspring_border_4"
	object_slowdown = 5
	edge = FALSE

/obj/structure/hotspring/border/five
	icon_state = "hotspring_border_5"
	object_slowdown = 5
	edge = FALSE

/obj/structure/hotspring/border/six
	icon_state = "hotspring_border_6"
	object_slowdown = 5
	edge = FALSE

/obj/structure/hotspring/border/seven
	icon_state = "hotspring_border_7"
	object_slowdown = 5
	edge = FALSE

/obj/structure/hotspring/border/eight
	icon_state = "hotspring_border_8"
	object_slowdown = 5
	edge = FALSE

/obj/structure/hotspring/border/nine
	icon_state = "hotspring_border_9"
	object_slowdown = 5
	edge = FALSE

/obj/structure/hotspring/border/ten
	icon_state = "hotspring_border_10"
	object_slowdown = 5
	edge = FALSE

/obj/structure/hotspring/border/eleven
	icon_state = "hotspring_border_11"
	object_slowdown = 5
	edge = FALSE

/obj/structure/hotspring/border/twelve
	icon_state = "hotspring_border_12"
	object_slowdown = 5
	edge = FALSE

/obj/structure/hotspring/border/thirteen
	icon_state = "hotspring_border_13"
	object_slowdown = 0
	edge = TRUE

/obj/structure/hotspring/border/fourteen
	icon_state = "hotspring_border_14"
	object_slowdown = 0
	edge = TRUE

/obj/structure/flora/hotspring_rocks
	name = "large rock"

	icon = 'icons/obj/structures/hotspring.dmi'
	icon_state = "bigrock"
	obj_flags = CAN_BE_HIT | IGNORE_SINK
	density = TRUE

/obj/structure/flora/hotspring_rocks/grassy
	name = "grassy large rock"
	icon_state = "bigrock_grass"

/obj/structure/flora/hotspring_rocks/small
	name = "small rock"
	density = FALSE
	icon_state = "stones_1"

/obj/structure/flora/hotspring_rocks/small/two
	icon_state = "stones_2"

/obj/structure/flora/hotspring_rocks/small/three
	icon_state = "stones_3"

/obj/structure/flora/hotspring_rocks/small/four
	icon_state = "stones_4"

/obj/structure/flora/hotspring_rocks/small/five
	icon_state = "stones_5"

/obj/machinery/light/rogue/torchholder/hotspring
	name = "stone lantern"
	desc = "A stone lantern, built in Kazengunese style. It is believed these lanterns attracts spirits and guide their way."
	icon = 'icons/obj/structures/hotspring.dmi'
	icon_state = "stonelantern1"
	torch_off_state = "stonelantern0"
	base_state = "stonelantern"

/obj/machinery/light/rogue/torchholder/hotspring/standing
	name = "standing stone lantern"
	icon_state = "stonelantern_standing1"
	torch_off_state = "stonelantern_standing0"
	base_state = "stonelantern_standing"

/obj/effect/lily_petal
	name = "lily petals"
	icon = 'icons/obj/structures/hotspring.dmi'
	icon_state = "lilypetals1"
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE_UPPER

/obj/effect/lily_petal/two
	icon_state = "lilypetals2"

/obj/effect/lily_petal/three
	icon_state = "lilypetals3"

/obj/structure/chair/hotspring_bench
	name = "park bench"
	icon_state = "parkbench_sofamiddle"
	icon = 'icons/obj/structures/hotspring.dmi'
	buildstackamount = 1
	item_chair = null

/obj/structure/chair/hotspring_bench/left
	icon_state = "parkbench_sofaend_left"

/obj/structure/chair/hotspring_bench/right
	icon_state = "parkbench_sofaend_right"

/obj/structure/chair/hotspring_bench/corner
	icon_state = "parkbench_corner"

/obj/structure/flora/sakura
	name = "cherry blossom tree"
	desc = "A tree that has been introduced from the far east. A symbol of the transience of life. In the islands of Kazengun,\
	it is strongly associated with both romance and death. On the mainland, it is known as a representation of brotherhood.\ "
	icon = 'icons/obj/structures/sakura_tree.dmi'
	icon_state = "sakura_tree"
	obj_flags = CAN_BE_HIT | IGNORE_SINK
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE_UPPER

	bound_height = 128
	bound_width = 128
