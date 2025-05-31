/datum/crafting_recipe/roguetown/gravemarker
	name = "grave marker"
	result = /obj/structure/gravemarker
	reqs = list(/obj/item/grown/log/tree/stick = 1)
	time = 10 SECONDS
	verbage_simple = "tie together"
	verbage = "ties together"
	craftsound = 'sound/foley/Building-01.ogg'
	structurecraft = /obj/structure/closet/dirthole
	craftdiff = 0

/datum/crafting_recipe/roguetown/gravemarker/TurfCheck(mob/user, turf/T)
	if(!(locate(/obj/structure/closet/dirthole) in T))
		to_chat(user, span_warning("There is no grave here."))
		return FALSE
	for(var/obj/structure/closet/dirthole/D in T)
		if(D.stage != 4)
			to_chat(user, span_warning("The grave isn't covered."))
			return FALSE
	if(locate(/obj/structure/gravemarker) in T)
		to_chat(user, span_warning("This grave is already hallowed."))
		return FALSE
	return TRUE

/obj/structure/gravemarker
	name = "grave marker"
	desc = "A simple marker honouring the departed.."
	icon = 'icons/turf/roguefloor.dmi'
	icon_state = "gravemarker1"
	density = FALSE
	max_integrity = 0
	static_debris = list(/obj/item/grown/log/tree/stick = 1)
	anchored = TRUE
	layer = 2.91

/obj/structure/gravemarker/Destroy()
	var/turf/T = get_turf(src)
	if(T)
		new /obj/item/grown/log/tree/stick(T)
	..()

/mob/dead/new_player/proc/reducespawntime(amt)
	if(ckey)
		if(amt)
			if(GLOB.respawntimes[ckey])
				GLOB.respawntimes[ckey] = GLOB.respawntimes[ckey] + amt

/obj/structure/gravemarker/OnCrafted(dir, mob/user)
	icon_state = "gravemarker[rand(1,3)]"
	for(var/obj/structure/closet/dirthole/hole in loc)
		if(pacify_coffin(hole, user))
			to_chat(user, span_notice("I feel their soul finding peace..."))
			SEND_SIGNAL(user, COMSIG_GRAVE_CONSECRATED, hole)
	return ..()
