
/obj/item/bomb
	name = "bottle bomb"
	desc = "A fiery explosion waiting to be coaxed from its glass prison."
	icon_state = "bbomb"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	var/fuze = null
	var/lit = FALSE
	var/prob2fail = 5
	grid_width = 32
	grid_height = 64

/obj/item/bomb/Initialize()
	..()
	fuze = rand(40,60)

/obj/item/bomb/spark_act()
	light()

/obj/item/bomb/fire_act()
	light()

/obj/item/bomb/ex_act()
	if(!QDELETED(src))
		lit = TRUE
		explode(TRUE)

/obj/item/bomb/proc/light()
	if(lit)
		return
	START_PROCESSING(SSfastprocess, src)
	icon_state += "-lit"
	lit = TRUE
	playsound(loc, 'sound/items/firelight.ogg', 100)
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()

/obj/item/bomb/extinguish()
	snuff()

/obj/item/bomb/proc/snuff()
	if(!lit)
		return
	lit = FALSE
	STOP_PROCESSING(SSfastprocess, src)
	playsound(loc, 'sound/items/firesnuff.ogg', 100)
	icon_state = "bbomb"
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()

/obj/item/bomb/proc/explode(skipprob)
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE
	if(!skipprob && prob(prob2fail))
		snuff()
		return FALSE
	qdel(src)
	playsound(T, 'sound/items/firesnuff.ogg', 100)
	new /obj/item/natural/glass_shard(T)
	explosion(T, light_impact_range = 1, flame_range = 2, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
	return TRUE

/obj/item/bomb/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	explode()

/obj/item/bomb/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)

/obj/item/bomb/attackby(obj/item/I, mob/user, params)
	..()

	if(!istype(I, /obj/item/natural/fibers))
		return
	
	I.visible_message(
		span_warning("[user] begins to prepare [src].."),
		span_notice("I begin to set-up [src] with [I].")
	)

	qdel(I)

	if(!do_after(user, 7 SECONDS - user.get_skill_level(/datum/skill/craft/traps), TRUE, src))
		to_chat(user, span_warning("I stop preparing [src]."))
		new /obj/item/natural/fibers(user.loc)
		if(prob(10))
			to_chat(user, span_warningbig("Uh oh."))
			light()
		return
	
	var/obj/item/bomb/tripbomb/trip = new /obj/item/bomb/tripbomb(get_turf(src))
	trip.b_type = type
	trip.icon_state = icon_state
	trip.add_overlay("tripbomb")
	trip.update_icon()
	trip.prob2fail = prob2fail

	var/obj/item/tripwire/wire = new /obj/item/tripwire(get_turf(user))
	wire.dir = get_dir(loc, user)
	to_chat(user, get_dir(loc, user))
	wire.payload = trip

	trip.wire_trigger.Add(wire)

	qdel(src)

	I.visible_message(
		span_warning("[user] finishes setting up [trip]."),
		span_notice("I finish setting up [trip]. I can extend it by one step longer.")
	)
	return

/obj/item/bomb/tripbomb
	name = "trip bomb"
	desc = "A detonation waiting to be coaxed from its glass prison. This one lies in wait."
	icon_state = "bbomb"
	w_class = WEIGHT_CLASS_NORMAL
	anchored = TRUE
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	fuze = 2 SECONDS
	grid_width = 32
	grid_height = 64
	var/obj/item/bomb/b_type
	var/list/obj/item/tripwire/wire_trigger = list()

/obj/item/bomb/tripbomb/Initialize()
	..()
	
/obj/item/bomb/tripbomb/Destroy()
	..()

	if(wire_trigger.len)
		for(var/list/obj/item/tripwire/wire in wire_trigger)
			QDEL_NULL(wire)

/obj/item/bomb/tripbomb/light()
	var/obj/item/bomb/bomb = new b_type (loc)
	bomb.fuze = 1 SECONDS
	QDEL_NULL(src)
	bomb.light()

/obj/item/tripwire
	name = "fibre tripwire"
	desc = "You almost missed it - phew. Best cut it with a blade to disarm it."
	icon = 'icons/roguetown/items/misc.dmi'	
	icon_state = "wire"
	anchored = TRUE
	var/obj/item/bomb/tripbomb/payload

/obj/item/tripwire/Destroy()
	..()
	new /obj/item/natural/fibers(loc)

/obj/item/tripwire/attackby(obj/item/I, mob/user, params)
	if(user.used_intent.blade_class == BCLASS_CUT && I.wlength == WLENGTH_SHORT)
		if(!do_after(user, 7 SECONDS - user.get_skill_level(/datum/skill/craft/traps), TRUE, src))
			to_chat(user, span_warning("I stop slicing [src]."))
			if(!prob(user.get_skill_level(/datum/skill/craft/traps) * 10))
				to_chat(user, span_warningbig("Oh no."))
				payload.light()

		for(var/list/obj/item/tripwire/t_wire in payload.wire_trigger)
			QDEL_NULL(t_wire)
		new payload.b_type(payload.loc)
		QDEL_NULL(payload)
		return ..()
	
	if(istype(I, /obj/item/natural/fibers))
		if(payload.wire_trigger.len == 2)
			to_chat(span_warning("I can not extend [src] anymore."))
			return ..()
		if(!do_after(user, 7 SECONDS - user.get_skill_level(/datum/skill/craft/traps), TRUE, src))
			to_chat(user, span_warning("I stop extending [src]."))
			return ..()

		var/obj/item/tripwire/wire = new /obj/item/tripwire(get_ranged_target_turf(src, dir, 1))
		wire.dir = dir
		wire.payload = payload

		payload.wire_trigger.Add(wire)
		qdel(I)

	..()

/obj/item/tripwire/Crossed(atom/movable/O)
	..()

	if(!isliving(O))
		return
	var/mob/living/carbon/human/victim = O
	if(victim.STALUC >= 10)
		if(prob((victim.STALUC - 10) * 10))
			to_chat(victim, span_warning("Your foot narrowly misses [src]. Be careful!"))
			return
	playsound(victim, 'sound/items/knife_open.ogg', 100, TRUE)
	victim.visible_message(
		span_warningbig("[victim] steps on [src]!"),
		span_warningbig("I feel the snapping of twine under my boot!")
	)
	payload.light()
	for(var/list/obj/item/tripwire/t_wire in payload.wire_trigger)
		QDEL_NULL(t_wire)


/obj/item/bomb/smoke
	name = "smoke bomb"
	desc = "A soft sphere with an alchemical mixture and a dispersion mechanism hidden inside. Any pressure will detonate it."
	icon_state = "smokebomb"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	grid_width = 32
	grid_height = 64
	fuze = 0 SECONDS
	var/radius = 3

/obj/item/bomb/smoke/attack_self(mob/user)
    ..()
    light()

/obj/item/bomb/smoke/ex_act()
	if(!QDELETED(src))
		..()
	light()

/obj/item/bomb/smoke/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	light()

/obj/item/bomb/smoke/spark_act()
	return

/obj/item/bomb/smoke/fire_act()
	return

/obj/item/bomb/smoke/light()
	explode()

/obj/item/bomb/smoke/explode()
	var/turf/T = get_turf(src)
	if(!T) 
		return FALSE
	playsound(loc, 'sound/items/smokebomb.ogg', 50)
	var/datum/effect_system/smoke_spread/smoke = new /datum/effect_system/smoke_spread
	smoke.set_up(radius, T)
	smoke.start()
	new /obj/item/ash(T)
	qdel(src)
