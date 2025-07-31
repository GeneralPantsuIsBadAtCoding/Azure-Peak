/obj/item/fishingcage
	name = "fishing cage"
	desc = "A sturdy cage used to catch shellfishes. Put a leech or worm inside and an unfortunate shellfish should be lured inside shortly."
	icon_state = "fishingcage"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 0
	slot_flags = ITEM_SLOT_BACK
	var/check_counter = 0
	var/deployed = 0
	var/obj/item/caught
	var/obj/item/bait
	var/time2catch = 40 SECONDS // RW had this at 20 seconds, but if you produce more than 3 - 4 cages you would be limited only by the rate you get worm, so a slight nerf.

/obj/item/fishingcage/attack_self(mob/user)
	. = ..()

	var/turf/T = get_step(user, user.dir)
	if(!istype(T, /turf/open/water))
		to_chat(user, span_warning("This goes into water!"))
		return // We don't need to check non water tiles.

	user.visible_message(span_notice("[user] begins deploying the fishing cage..."), \
						span_notice("I begin deploying the fishing cage..."))
	var/deploy_speed = get_skill_delay(user.get_skill_level(/datum/skill/labor/fishing), 1, slowest = 6) //in seconds

	if(!is_valid_fishing_spot(T))
		to_chat(user, span_warning("This body of water seems devoid of aquatic life..."))
		return
	
	if(istype(T, /turf/open/water))
		if(do_after(user, deploy_speed, target = src))
			user.transferItemToLoc(src, T)
			deployed = 1
			icon_state = "fishingcage_deployed"
			anchored = 1
	else
		to_chat(user, span_warning("I'm not catching anything if I don't put this on water"))
		return

/obj/item/fishingcage/attack_hand(mob/user)
	if(deployed)
		var/deploy_speed = get_skill_delay(user.get_skill_level(/datum/skill/labor/fishing), 1, slowest = 6) //in seconds
		if(caught)
			user.visible_message(span_notice("[user] begins to harvest from the cage..."), \
								span_notice("I begin harvesting the from the cage..."))
			if(do_after(user, deploy_speed, target = src))
				STOP_PROCESSING(SSobj, src)
				icon_state = "fishingcage_deployed"
				add_sleep_experience(user, /datum/skill/labor/fishing, 20)
				record_featured_stat(FEATURED_STATS_FISHERS, user)
				GLOB.azure_round_stats[STATS_FISH_CAUGHT]++
				new caught(user.loc)
				caught = null
				desc = initial(desc)
		else
			user.visible_message(span_notice("[user] begins disarming the fishing cage..."), \
								span_notice("I begin disarming the fishing cage..."))
			if(do_after(user, deploy_speed, target = src))
				STOP_PROCESSING(SSobj, src)
				deployed = 0
				QDEL_NULL(bait) //you lose the bait if you take out the cage without catching anything
				desc = initial(desc)
				icon_state = initial(icon_state)
				anchored = 0
				..()
	else
		..()

/obj/item/fishingcage/attackby(obj/item/I, mob/user, params)
	if(bait)
		to_chat(user, span_warning("There's bait already on the cage."))
		return
	if(I.baitpenalty != 100) // We use baitpenalty instead of baitchance so let's just exclude anything with 100
		user.visible_message(span_notice("[user] starts adding the bait to the fishing cage..."), \
							span_notice("I start to add [I] to the fishing cage..."))
		if(do_after(user, 3 SECONDS, target = src))
			playsound(src.loc, 'sound/foley/pierce.ogg', 50, FALSE)
			I.forceMove(src)
			bait = I
			check_counter = world.time
			time2catch = get_skill_delay(user.get_skill_level(/datum/skill/labor/fishing), 5, slowest = 40) //in seconds
			icon_state = "fishingcage_ready"
			START_PROCESSING(SSobj, src)
			return
	. = ..()

/obj/item/fishingcage/process()
	if(deployed && bait)
		if(world.time > check_counter + time2catch)
			check_counter = world.time
			caught = pickweightAllowZero(createCageFishWeightListModlist(bait.fishingMods))
			icon_state = "fishingcage_caught"
			QDEL_NULL(bait)
	..()

/obj/item/fishingcage/examine(mob/user)
	. = ..()
	if(icon_state == "fishingcage_caught")
		. += span_warning("Something seems to be inside...")
	