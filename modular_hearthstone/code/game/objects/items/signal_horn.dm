/obj/item/signal_horn
	name = "signal horn"
	desc = "Used to sound the alarm."
	icon = 'modular_hearthstone/icons/obj/items/signalhorn.dmi'
	icon_state = "signalhorn"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_NORMAL
	grid_height = 32
	grid_width = 64

/obj/item/signal_horn/attack_self(mob/living/user)
	. = ..()
	user.visible_message(span_warning("[user] is about to sound the [src]!"))
	if(do_after(user, 15))
		sound_horn(user)

/obj/item/signal_horn/proc/sound_horn(mob/living/user)
	user.visible_message(span_warning("[user] sounds the alarm!"))
	switch(user.job)
		if("Warden")
			playsound(src, 'modular_hearthstone/sound/items/bogguardhorn.ogg', 100, TRUE)
		if("Town Sheriff", "Watchman", "Sergeant", "Man at Arms")
			playsound(src, 'modular_hearthstone/sound/items/watchhorn.ogg', 100, TRUE)
		if("Knight Captain", "Royal Guard")
			playsound(src, 'modular_hearthstone/sound/items/rghorn.ogg', 100, TRUE)
		else
			playsound(src, 'modular_hearthstone/sound/items/signalhorn.ogg', 100, TRUE)

	var/turf/origin_turf = get_turf(src)

	for(var/mob/living/player in GLOB.player_list)
		if(player.stat == DEAD)
			continue
		if(isbrain(player))
			continue

		var/distance = get_dist(player, origin_turf)
		if(distance <= 7)
			continue
		var/dirtext = " to the "
		var/direction = get_dir(player, origin_turf)
		switch(direction)
			if(NORTH)
				dirtext += "north"
			if(SOUTH)
				dirtext += "south"
			if(EAST)
				dirtext += "east"
			if(WEST)
				dirtext += "west"
			if(NORTHWEST)
				dirtext += "northwest"
			if(NORTHEAST)
				dirtext += "northeast"
			if(SOUTHWEST)
				dirtext += "southwest"
			if(SOUTHEAST)
				dirtext += "southeast"
			else //Where ARE you.
				dirtext = "although I cannot make out an exact direction"

		var/disttext
		switch(distance)
			if(0 to 20)
				disttext = " within 20 paces"
			if(20 to 40)
				disttext = " 20 to 40 paces away"
			if(40 to 80)
				disttext = " 40 to 80 paces away"
			if(80 to 160)
				disttext = " far"
			else
				disttext = " very far" 
		
		var/placetext
		var/area/localarea = get_area_name(src)
		switch(localarea)
			if("mountains")
				placetext = " In the Mountains!"
			if("mt decapitation")
				placetext = " from Mt Decapitation!"
			if("azure basin")
				placetext = " in the The Azure Basin!"
			if("wilderness")
				placetext = " in the The Azure Grove!"
			if("bog", "dense bog")
				placetext = " in SYON'S Rest!"
			if("coast", "coastforest")
				placetext = " on the Azure Coast!"
			if("indoors", "Shop", "Physician", "outdoors", "roofs")
				placetext = " somewhere in town!"
			if("Manor", "Wizard's Tower")
				placetext = " from the Keep!"
			if("Garrison", "dungeon cell")
				placetext = " from the Garrison!"
			if("Baths", "tavern")
				placetext = " from the Inn!"
			if("church")
				placetext = " from the Church!"
			else
				placetext = " I cannot discern where it came from exactly!"

		//sound played for other players
		switch(user.job)
			if("Warden")
				player.playsound_local(get_turf(player), 'modular_hearthstone/sound/items/bogguardhorn.ogg', 35, FALSE, pressure_affected = FALSE)
				to_chat(player, span_warning("I hear the horn of the Wardens somewhere[disttext],[dirtext],[placetext]"))
			if("Marshall", "Watchman", "Sergeant", "Man at Arms")
				player.playsound_local(get_turf(player), 'modular_hearthstone/sound/items/watchhorn.ogg', 35, FALSE, pressure_affected = FALSE)
				to_chat(player, span_warning("I hear the horn of the Garrison somewhere[disttext],[dirtext],[placetext]"))
			if("Knight Captain", "Knight")
				player.playsound_local(get_turf(player), 'modular_hearthstone/sound/items/rghorn.ogg', 35, FALSE, pressure_affected = FALSE)
				to_chat(player, span_warning("I hear the horn of the Royal Guard somewhere[disttext],[dirtext],[placetext]"))
			else
				player.playsound_local(get_turf(player), 'modular_hearthstone/sound/items/signalhorn.ogg', 35, FALSE, pressure_affected = FALSE)
				to_chat(player, span_warning("I hear the signal horn somewhere[disttext], [dirtext],[placetext]"))
