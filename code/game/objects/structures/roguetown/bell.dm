/obj/structure/boatbell
	name = "bell"
	desc = "This is the doomspeller of Roguetown."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "bell"
	density = FALSE
	max_integrity = 0
	anchored = TRUE
	var/last_ring
	var/datum/looping_sound/boatloop/soundloop

/obj/structure/boatbell/Initialize()
	soundloop = new(src, FALSE)
	soundloop.start()
	. = ..()

/obj/structure/boatbell/attack_hand(mob/user)
	if(world.time < last_ring + 50)
		return
	user.visible_message(span_info("[user] rings the bell."))
	playsound(src, 'sound/misc/boatbell.ogg', 100, extrarange = 5)
	last_ring = world.time

/obj/structure/boatbell/fluff/attack_hand(mob/user)
	if(world.time < last_ring + 50)
		return
	user.visible_message(span_info("[user] rings the bell."))
	playsound(src, 'sound/misc/boatbell.ogg', 100, extrarange = 5)
	last_ring = world.time

/obj/structure/standingbell
	name = "service bell"
	desc = "A small mana-infused bell that carries its chime across the city to a select few ears. Use this to call for service."
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "standingbell"
	density = FALSE
	max_integrity = 0
	anchored = TRUE
	var/cooldown = 10 MINUTES
	var/on_cooldown = FALSE
	var/area/localarea

/obj/structure/standingbell/Initialize()
	. = ..()
	localarea = get_area_name(src)


/obj/structure/standingbell/attack_hand(mob/living/user)
	if(on_cooldown)
		to_chat(user, span_warning("The bell has already been rung recently."))
	else
		user.changeNext_move(CLICK_CD_INTENTCAP)
		user.visible_message(span_warning("[user] begins to ring [src]"))
		if(do_after(user, 10 SECONDS))
			on_cooldown = TRUE
			user.visible_message(span_info("[user] rings [src]"))
			playsound(src, 'sound/misc/bell.ogg', 100, extrarange = 5)
			addtimer(CALLBACK(src, PROC_REF(reset_cooldown)), cooldown)
			var/list/rolestonotify = list()
			switch(localarea)
				if("church")
					rolestonotify = list("Bishop", "Acolyte", "Druid", "Martyr", "Templar", "Churchling")
				if("Shop")
					rolestonotify = list("Merchant", "Shophand")
				if("Physician")
					rolestonotify = list("Head Physician", "Apothecary")
				if("The Guild of Craft")
					rolestonotify = list("Guildmaster", "Guildsman")
				if("Steward")
					rolestonotify = list("Steward", "Clerk")
				if("Baths")
					rolestonotify = list("Bathmaster", "Bathhouse Attendant")
				if("The Inquisition")
					rolestonotify = list("Inquisitor", "Orthodoxist", "Absolver")
				if("Garrison")
					rolestonotify = list("Man at Arms", "Sergeant", "Dungeoneer", "Watchman")
			send_ooc_note(("I hear the distant sounds of [src] ringing. I'm being called to the [localarea]."), job = rolestonotify)

/obj/structure/standingbell/proc/reset_cooldown()
	visible_message(span_notice ("[src] is ready for use again."))
	on_cooldown = FALSE
