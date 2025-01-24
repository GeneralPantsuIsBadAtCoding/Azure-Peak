//separate dm since hydro is getting bloated already

/obj/structure/glowshroom
	name = "kneestingers"
	desc = ""
	anchored = TRUE
	opacity = 0
	density = FALSE
	icon = 'icons/roguetown/misc/foliage.dmi'
	icon_state = "glowshroom1" //replaced in New
	layer = ABOVE_NORMAL_TURF_LAYER
	max_integrity = 30
	blade_dulling = DULLING_CUT
	resistance_flags = FLAMMABLE

/obj/structure/glowshroom/fire_act(added, maxstacks)
	visible_message(span_warning("[src] catches fire!"))
	var/turf/T = get_turf(src)
	qdel(src)
	new /obj/effect/hotspot(T)

/obj/structure/glowshroom/CanPass(atom/movable/mover, turf/target)
	if(isliving(mover) && mover.z == z)
//		var/throwdir = get_dir(src, mover)
		var/mob/living/L = mover

		if(HAS_TRAIT(L, TRAIT_KNEESTINGER_IMMUNITY)) //Dendor kneestinger immunity
			return TRUE

		if(L.electrocute_act(30, src))
			L.consider_ambush()
			if(L.throwing)
				L.throwing.finalize(FALSE)
//			if(mover.loc != loc && L.stat == CONSCIOUS)
//				L.throw_at(get_step(L, throwdir), 1, 1, L, spin = FALSE)
			return FALSE
	. = ..()

/obj/structure/glowshroom/Crossed(AM as mob|obj)
	if(isliving(AM))
		var/mob/living/L = AM
		if(L.z == z)
			if(!HAS_TRAIT(L, TRAIT_KNEESTINGER_IMMUNITY))
				if(L.electrocute_act(30, src))
					L.emote("painscream")
					L.update_sneak_invis(TRUE)
					L.consider_ambush()
	. = ..()

/obj/structure/glowshroom/attackby(obj/item/W, mob/user, params)
	if(isliving(user) && W && user.z == z)
		if(W.flags_1 & CONDUCT_1)
			var/mob/living/L = user
			if(L.electrocute_act(30, src)) // The kneestingers will let you pass if you worship dendor, but they won't take your stupid ass hitting them.
				L.emote("painscream")
				L.consider_ambush()
				if(L.throwing)
					L.throwing.finalize(FALSE)
				return FALSE
	..()


/obj/structure/glowshroom/New(loc, obj/item/seeds/newseed, mutate_stats)
	..()
	set_light(1.5, 1.5, 1.5, l_color ="#d4fcac")

	icon_state = "glowshroom[rand(1,3)]"

	pixel_x = rand(-4, 4)
	pixel_y = rand(0,5)


/obj/structure/glowshroom/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	if(damage_type == BURN && damage_amount)
		playsound(src.loc, 'sound/blank.ogg', 100, TRUE)

/obj/structure/glowshroom/temperature_expose(exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		take_damage(5, BURN, 0, 0)

/obj/structure/glowshroom/acid_act(acidpwr, acid_volume)
	. = 1
	visible_message(span_danger("[src] melts away!"))
	var/obj/effect/decal/cleanable/molten_object/I = new (get_turf(src))
	I.desc = ""
	qdel(src)
