GLOBAL_LIST_EMPTY(redstone_objs)


/obj/structure
	var/redstone_id
	var/list/redstone_attached = list()

/obj/structure/LateInitialize()
	. = ..()
	if(redstone_id)
		for(var/obj/structure/S in GLOB.redstone_objs)
			if(S.redstone_id == redstone_id)
				redstone_attached |= S
				S.redstone_attached |= src

/obj/structure/proc/redstone_triggered()
	return

/obj/structure/lever
	name = "lever"
	desc = "I want to pull it."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "leverfloor0"
	density = FALSE
	anchored = TRUE
	max_integrity = 3000
	var/toggled = FALSE

/obj/structure/lever/attack_hand(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		L.changeNext_move(CLICK_CD_MELEE)
		var/used_time = 100 - (L.STASTR * 10)
		user.visible_message(span_warning("[user] pulls the lever."))
		log_game("[key_name(user)] pulled the lever with redstone id \"[redstone_id]\"")
		if(do_after(user, used_time, target = user))
			for(var/obj/structure/O in redstone_attached)
				spawn(0) O.redstone_triggered()
			toggled = !toggled
			icon_state = "leverfloor[toggled]"
			playsound(src, 'sound/foley/lever.ogg', 100, extrarange = 3)

/obj/structure/lever/onkick(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		L.changeNext_move(CLICK_CD_MELEE)
		user.visible_message("<span class='warning'>[user] kicks the lever!</span>")
		playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
		if(prob(L.STASTR * 4))
			for(var/obj/structure/O in redstone_attached)
				spawn(0) O.redstone_triggered()
			toggled = !toggled
			icon_state = "leverfloor[toggled]"
			playsound(src, 'sound/foley/lever.ogg', 100, extrarange = 3)

/obj/structure/lever/wall
	icon_state = "leverwall0"

/obj/structure/lever/wall/attack_hand(mob/user)
	. = ..()
	icon_state = "leverwall[toggled]"

/obj/structure/lever/wall/onkick(mob/user)
	. = ..()
	icon_state = "leverwall[toggled]"

/obj/structure/pressure_plate //vanderlin port
	name = "pressure plate"
	desc = "Be careful. Stepping on this could either mean a bomb exploding or a door closing on you."
	icon = 'icons/roguetown/misc/traps.dmi'
	icon_state = "pressureplate"
	max_integrity = 45 // so it gets destroyed when used to explode a bomb
	density = FALSE
	anchored = TRUE

/obj/structure/pressure_plate/Crossed(atom/movable/AM)
	. = ..()
	if(!anchored)
		return
	if(isliving(AM))
		var/mob/living/L = AM
		to_chat(L, "<span class='info'>I feel something click beneath me.</span>")
		AM.log_message("has activated a pressure plate", LOG_GAME)
		playsound(src, 'sound/misc/pressurepad_down.ogg', 65, extrarange = 2)

/obj/structure/pressure_plate/Uncrossed(atom/movable/AM)
	. = ..()
	if(!anchored)
		return
	if(isliving(AM))
		triggerplate()

/obj/structure/pressure_plate/proc/triggerplate()
	playsound(src, 'sound/misc/pressurepad_up.ogg', 65, extrarange = 2)
	for(var/obj/structure/O in redstone_attached)
		spawn(0) O.redstone_triggered()
/*
/obj/structure/pressure_plate/attack_hand(mob/user) //commented out for now, they're stuposed to be anchored structures for dungeons. End of vanderlin traps port. Maybe an artificer subtype craft in the future.
	. = ..()
	if(user.used_intent.type == INTENT_HARM)
		playsound(loc, 'sound/combat/hits/punch/punch (1).ogg', 100, FALSE, -1)
		triggerplate()
		anchored = !anchored
*/
/obj/structure/floordoor
	name = "floorhatch"
	desc = "A handy floor hatch for people who need privacy upstairs."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "floorhatch1"
	density = FALSE
	anchored = TRUE
	layer = ABOVE_OPEN_TURF_LAYER
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP
	var/togg = FALSE
	var/base_state = "floorhatch"
	max_integrity = 0
/*
/obj/structure/floordoor/Initialize()
	AddComponent(/datum/component/squeak, list('sound/foley/footsteps/FTMET_A1.ogg','sound/foley/footsteps/FTMET_A2.ogg','sound/foley/footsteps/FTMET_A3.ogg','sound/foley/footsteps/FTMET_A4.ogg'), 100)
	return ..()
*/
/obj/structure/floordoor/obj_break(damage_flag)
	obj_flags = null
	..()

/obj/structure/floordoor/redstone_triggered()
	if(obj_broken)
		return
	togg = !togg
	if(togg)
		icon_state = "[base_state]0"
		obj_flags = null
		var/turf/T = loc
		if(istype(T))
			for(var/atom/movable/M in loc)
				T.Entered(M)
	else
		icon_state = "[base_state]1"
		obj_flags = BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP

/obj/structure/floordoor/open
		icon_state = "floorhatch0"
		base_state = "floorhatch"
		togg = TRUE
		obj_flags = null

/obj/structure/floordoor/gatehatch
	name = ""
	desc = ""
	base_state = ""
	icon_state = ""
	var/changing_state = FALSE
	var/delay2open = 0
	var/delay2close = 0
	max_integrity = 0
	nomouseover = TRUE
	mouse_opacity = 0

/obj/structure/floordoor/gatehatch/Initialize()
	AddComponent(/datum/component/squeak, list('sound/foley/footsteps/FTMET_A1.ogg','sound/foley/footsteps/FTMET_A2.ogg','sound/foley/footsteps/FTMET_A3.ogg','sound/foley/footsteps/FTMET_A4.ogg'), 40)
	return ..()

/obj/structure/floordoor/gatehatch/redstone_triggered()
	if(changing_state)
		return
	if(obj_broken)
		return
	changing_state = TRUE
	togg = !togg
	if(togg)
		sleep(delay2open)
		icon_state = "[base_state]0"
		obj_flags = null
		var/turf/T = loc
		if(istype(T))
			for(var/atom/movable/M in loc)
				T.Entered(M)
		sleep(40-delay2open)
		changing_state = FALSE
	else
		sleep(delay2close)
		icon_state = "[base_state]1"
		obj_flags = BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP
		sleep(40-delay2close)
		changing_state = FALSE

/obj/structure/floordoor/gatehatch/inner
	delay2open = 10
	delay2close = 30

/obj/structure/floordoor/gatehatch/outer
	delay2open = 30
	delay2close = 10

/obj/structure/kybraxor
	name = "Kybraxor the Devourer"
	desc = "The mad duke's hungriest pet."
	density = FALSE
	nomouseover = TRUE
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "kybraxor1"
	redstone_id = "gatelava"
	var/openn = FALSE
	var/changing_state = FALSE
	layer = ABOVE_OPEN_TURF_LAYER
	max_integrity = 0

/obj/structure/kybraxor/redstone_triggered()
	if(changing_state)
		return
	if(obj_broken)
		return
	changing_state = TRUE
	openn = !openn
	if(openn)
		playsound(src, 'sound/misc/kybraxorop.ogg', 100, FALSE)
		flick("kybraxoropening",src)
		sleep(40)
		icon_state = "kybraxor0"
		changing_state = FALSE
	else
		playsound(src, 'sound/misc/kybraxor.ogg', 100, FALSE)
		flick("kybraxorclosing",src)
		sleep(40)
		icon_state = "kybraxor1"
		changing_state = FALSE

/obj/structure/kybraxor/psy
	name = "Kybraxor the Vaultkeeper"
	redstone_id = "swamp_psy_dungeon"
