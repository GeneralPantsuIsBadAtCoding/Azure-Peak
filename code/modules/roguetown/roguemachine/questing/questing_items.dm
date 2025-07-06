/obj/item/paper/scroll/quest
	name = "enchanted quest scroll"
	desc = "A weathered scroll enchanted to list the active quests from the Adventurers' Guild. The magical protections make it resistant to damage and tampering."
	icon = 'code/modules/roguetown/roguemachine/questing/questing.dmi'
	icon_state = "scroll_quest"
	var/base_icon_state = "scroll_quest"
	var/datum/quest/assigned_quest
	var/last_compass_direction = ""
	var/last_z_level_hint = ""
	resistance_flags = FIRE_PROOF | LAVA_PROOF | INDESTRUCTIBLE | UNACIDABLE
	max_integrity = 1000
	armor = list("blunt" = 100, "slash" = 100, "stab" = 100, "piercing" = 100, "fire" = 100, "acid" = 100)

/obj/item/paper/scroll/quest/Initialize()
	. = ..()
	if(assigned_quest)
		assigned_quest.quest_scroll = src 
	update_quest_text()

/obj/item/paper/scroll/quest/Destroy()
	if(assigned_quest)
		// Return deposit if scroll is destroyed before completion
		if(!assigned_quest.complete)
			var/refund = assigned_quest.quest_difficulty == "Easy" ? 5 : \
						assigned_quest.quest_difficulty == "Medium" ? 10 : 20
			
			// First try to return to quest giver if available
			var/mob/giver = assigned_quest.quest_giver_reference?.resolve()
			if(giver && (giver in SStreasury.bank_accounts))
				SStreasury.bank_accounts[giver] += refund
				SStreasury.treasury_value -= refund
				SStreasury.log_entries += "-[refund] from treasury (quest scroll destroyed refund to giver [giver.real_name])"
			// Otherwise try quest receiver
			else if(assigned_quest.quest_receiver_reference)
				var/mob/receiver = assigned_quest.quest_receiver_reference.resolve()
				if(receiver && (receiver in SStreasury.bank_accounts))
					SStreasury.bank_accounts[receiver] += refund
					SStreasury.treasury_value -= refund
					SStreasury.log_entries += "-[refund] from treasury (quest scroll destroyed refund to receiver [receiver.real_name])"
		
		// Clean up the quest
		qdel(assigned_quest)
		assigned_quest = null
	
	return ..()

/obj/item/paper/scroll/quest/update_icon_state()
	if(open)
		icon_state = info ? "[base_icon_state]_info" : "[base_icon_state]"
	else
		icon_state = "[base_icon_state]_closed"

/obj/item/paper/scroll/quest/examine(mob/user)
	. = ..()
	if(!assigned_quest)
		return
	if(!assigned_quest.quest_receiver_reference)
		. += span_notice("This quest hasn't been claimed yet. Open it to claim it for yourself!")
	else if(assigned_quest.complete)
		. += span_notice("\nThis quest is complete! Return it to the Quest Book to claim your reward.")
		. += span_info("\nPlace it on the marked area next to the book.")
	else
		. += span_notice("\nThis quest is still in progress.")

/obj/item/paper/scroll/quest/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(P.get_sharpness())
		to_chat(user, span_warning("The enchanted scroll resists your attempts to tear it."))
		return
	if(istype(P, /obj/item/paper)) // Prevent merging with other papers/scrolls
		to_chat(user, span_warning("The magical energies prevent you from combining this with other scrolls."))
		return
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(!open)
			to_chat(user, span_warning("You need to open the scroll first."))
			return
		if(!assigned_quest)
			to_chat(user, span_warning("This quest scroll doesn't accept modifications."))
			return
	..()

/obj/item/paper/scroll/quest/fire_act(exposed_temperature, exposed_volume)
	return // Immune to fire

/obj/item/paper/scroll/quest/extinguish()
	return // No fire to extinguish

/obj/item/paper/scroll/quest/attack_self(mob/user)
	. = ..()
	if(.)
		return

	// Always refresh compass when opened
	refresh_compass(user)

	// Only do claim logic if unclaimed
	if(!assigned_quest || assigned_quest.quest_receiver_reference)
		return TRUE

	assigned_quest.quest_receiver_reference = WEAKREF(user)
	assigned_quest.quest_receiver_name = user.real_name

	to_chat(user, span_notice("You claim this quest for yourself!"))
	update_quest_text()
	return TRUE

/obj/item/paper/scroll/quest/proc/update_quest_text()
	if(!assigned_quest)
		return

	var/scroll_text = "<center>HELP NEEDED</center><br>"
	scroll_text += "<center><b>[assigned_quest.title]</b></center><br><br>"
	scroll_text += "<b>Issued by:</b> [assigned_quest.quest_giver_name ? "Guild Handler [assigned_quest.quest_giver_name]" : "The Adventurer's Guild"].<br>"
	scroll_text += "<b>Issued to:</b> [assigned_quest.quest_receiver_name ? assigned_quest.quest_receiver_name : "whoever it may concern"].<br>"
	scroll_text += "<b>Type:</b> [assigned_quest.quest_type] quest.<br>"
	scroll_text += "<b>Difficulty:</b> [assigned_quest.quest_difficulty].<br><br>"

	if(last_compass_direction)
		scroll_text += "<b>Direction:</b> [last_compass_direction].<br>"
		if(last_z_level_hint)
			scroll_text += " ([last_z_level_hint])"

	switch(assigned_quest.quest_type)
		if("Fetch")
			scroll_text += "<b>Objective:</b> Retrieve [assigned_quest.target_amount] [initial(assigned_quest.target_item_type.name)].<br>"
			scroll_text += "<b>Last Seen Location:</b> Reported sighting in [assigned_quest.target_spawn_area] region.<br>"
		if("Kill", "Miniboss")
			scroll_text += "<b>Objective:</b> Slay [assigned_quest.target_amount] [initial(assigned_quest.target_mob_type.name)].<br>"
			scroll_text += "<b>Last Seen Location:</b> [assigned_quest.target_spawn_area ? "Reported sighting in [assigned_quest.target_spawn_area] region." : "Reported sighting in Sunmarch region."]<br>"
		if("Clear Out")
			scroll_text += "<b>Objective:</b> Eliminate [assigned_quest.target_amount] [initial(assigned_quest.target_mob_type.name)].<br>"
			scroll_text += "<b>Infestation Location:</b> [assigned_quest.target_spawn_area ? "Reported sighting in [assigned_quest.target_spawn_area] region." : "Reported infestations in Sunmarch region."]<br>"
		if("Courier")
			scroll_text += "<b>Objective:</b> Deliver [initial(assigned_quest.target_delivery_item.name)] to [initial(assigned_quest.target_delivery_location.name)].<br>"
			scroll_text += "<b>Delivery Instructions:</b> Package must remain intact and be delivered directly to the recipient.<br>"
			scroll_text += "<b>Destination Description:</b> [initial(assigned_quest.target_delivery_location.name)].<br>" // TODO: brief_descriptor

	scroll_text += "<br><b>Reward:</b> [assigned_quest.reward_amount] mammon upon completion<br>"
	
	if(assigned_quest.complete)
		scroll_text += "<br><center><b>QUEST COMPLETE</b></center>"
		scroll_text += "<br><b>Return this scroll to the Quest Book to claim your reward!</b>"
		scroll_text += "<br><i>Place it on the marked area next to the book.</i>"
	else
		scroll_text += "<br><i>The magic in this scroll will update as you progress.</i>"
	
	info = scroll_text
	update_icon()

/obj/item/paper/scroll/quest/proc/refresh_compass(mob/user)
	if(!assigned_quest || assigned_quest.complete)
		return FALSE
	
	// Update compass with precise directions
	update_compass(user)
	
	// Only update text if we have a valid direction
	if(last_compass_direction)
		update_quest_text()
		return TRUE
	
	return FALSE

/obj/item/paper/scroll/quest/proc/update_compass(mob/user)
	if(!assigned_quest || assigned_quest.complete)
		return

	var/turf/user_turf = user ? get_turf(user) : get_turf(src)
	if(!user_turf)
		last_compass_direction = "No signal detected"
		last_z_level_hint = ""
		return

	// Reset compass values
	last_compass_direction = "Searching for target..."
	last_z_level_hint = ""

	var/atom/target
	var/turf/target_turf
	var/min_distance = INFINITY

	// Find the appropriate target based on quest type
	switch(assigned_quest.quest_type)
		if("Fetch")
			// Find the closest fetch item
			for(var/obj/item/I in world)
				if(istype(I, assigned_quest.target_item_type))
					var/datum/component/quest_object/Q = I.GetComponent(/datum/component/quest_object)
					if(Q && Q.quest_ref?.resolve() == assigned_quest)
						var/dist = get_dist(user_turf, I)
						if(!target || dist < min_distance)
							target = I
							min_distance = dist
		if("Courier")
			// Find the delivery location area
			var/area/target_area = assigned_quest.target_delivery_location
			if(target_area)
				var/list/area_turfs = get_area_turfs(target_area)
				if(length(area_turfs))
					var/turf/center_turf = locate(world.maxx/2, world.maxy/2, user_turf.z)
					min_distance = get_dist(user_turf, center_turf)
					target = center_turf
		if("Kill", "Clear Out", "Miniboss")
			// Find the closest target mob
			for(var/mob/living/M in world)
				if(istype(M, assigned_quest.target_mob_type))
					var/datum/component/quest_object/Q = M.GetComponent(/datum/component/quest_object)
					if(Q && Q.quest_ref?.resolve() == assigned_quest)
						var/dist = get_dist(user_turf, M)
						if(!target || dist < min_distance)
							target = M
							min_distance = dist

	if(!target || !(target_turf = get_turf(target)))
		last_compass_direction = "Target location unknown"
		last_z_level_hint = ""
		return

	// Handle Z-level differences first
	if(target_turf.z != user_turf.z)
		var/z_diff = abs(target_turf.z - user_turf.z)
		last_compass_direction = "Target is on another level"
		last_z_level_hint = target_turf.z > user_turf.z ? \
			"[z_diff] level\s above you" : \
			"[z_diff] level\s below you"
		return

	// Calculate direction from user to target
	var/dx = target_turf.x - user_turf.x
	var/dy = target_turf.y - user_turf.y
	var/distance = sqrt(dx*dx + dy*dy)

	// If very close, don't show direction
	if(distance <= 7)
		last_compass_direction = "Target is nearby"
		last_z_level_hint = ""
		return

	// Calculate angle in degrees (0 = north, 90 = east)
	// Note: Using ATAN2(dx, dy) gives correct cardinal directions
	var/angle = ATAN2(dx, dy)
	if(angle < 0)
		angle += 360

	// Get precise direction text
	var/direction_text = get_precise_direction_from_angle(angle)

	// Determine distance description
	var/distance_text
	switch(distance)
		if(0 to 14)
			distance_text = "very close"
		if(15 to 40)
			distance_text = "close"
		if(41 to 100)
			distance_text = ""
		if(101 to INFINITY)
			distance_text = "far away"

	last_compass_direction = "Target is [distance_text] to the [direction_text]"
	last_z_level_hint = "on this level"

/obj/item/paper/scroll/quest/proc/get_precise_direction_from_angle(angle)
	// Secondary intercardinal directions with 22.5° resolution
	switch(angle)
		if(0 to 22.5)
			return "north"
		if(22.5 to 45)
			return "north-northeast"
		if(45 to 67.5)
			return "northeast"
		if(67.5 to 90)
			return "east-northeast"
		if(90 to 112.5)
			return "east"
		if(112.5 to 135)
			return "east-southeast"
		if(135 to 157.5)
			return "southeast"
		if(157.5 to 180)
			return "south-southeast"
		if(180 to 202.5)
			return "south"
		if(202.5 to 225)
			return "south-southwest"
		if(225 to 247.5)
			return "southwest"
		if(247.5 to 270)
			return "west-southwest"
		if(270 to 292.5)
			return "west"
		if(292.5 to 315)
			return "west-northwest"
		if(315 to 337.5)
			return "northwest"
		if(337.5 to 360)
			return "north-northwest"

/obj/item/parcel
	name = "parcel wrapping paper"
	desc = "A sturdy piece of paper used to wrap items for secure delivery. The final size of the parcel depends on the size of the original item."
	icon = 'modular/Neu_Food/icons/cookware/ration.dmi'
	icon_state = "ration_wrapper"
	w_class = WEIGHT_CLASS_TINY
	grid_height = 32
	grid_width = 32
	dropshrink = 0.6
	var/obj/item/contained_item = null
	var/list/allowed_jobs = list()
	var/delivery_area_type

/obj/item/parcel/Initialize(mapload)
	. = ..()
	var/datum/component/quest_object/courier_quest = GetComponent(/datum/component/quest_object)
	if(courier_quest)
		var/datum/quest/quest = courier_quest.quest_ref?.resolve()
		if(quest && quest.quest_type == "Courier" && quest.target_delivery_location)
			delivery_area_type = quest.target_delivery_location
			allowed_jobs = get_area_jobs(delivery_area_type)
			RegisterSignal(courier_quest, COMSIG_PARENT_QDELETING, PROC_REF(on_quest_component_deleted))

/obj/item/parcel/proc/get_area_jobs(area_type)
	var/static/list/area_jobs = list(
		/area/rogue/indoors/town/tavern = list("Guild Handler", "Innkeeper", "Tapster"),
		/area/rogue/indoors/town/church = list("Guild Handler", "Priest", "Acolyte", "Templar", "Churchling"),
		/area/rogue/indoors/town/dwarfin = list("Guild Handler", "Blacksmith"),
		/area/rogue/indoors/town/shop = list("Guild Handler", "Merchant", "Shophand"),
		/area/rogue/indoors/town/manor = list("Guild Handler", "Nobleman", "Hand", "Knight Captain", "Marshal", "Steward", "Clerk", "Head Mage", "Duke"),
		/area/rogue/indoors/town/magician = list("Guild Handler", "Head Mage", "Archivist", "Artificer", "Apothicant Apprentice", "Apprentice Magician"),
		/area/rogue/indoors/town = list("Guild Handler")
	)
	return area_jobs[area_type] || list("Guild Handler")

/obj/item/parcel/proc/on_quest_component_deleted(datum/source)
	SIGNAL_HANDLER
	return

/obj/item/parcel/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/parcel) || I.w_class > WEIGHT_CLASS_BULKY || contained_item)
		to_chat(user, span_warning("You can't wrap this in [src]."))
		return

	if(do_after(user, 2 SECONDS, target = src))
		user.transferItemToLoc(I, src)
		contained_item = I
		name = "parcel ([I.name])"
		desc = "A securely wrapped parcel containing [I.name]."
		icon_state = I.w_class >= WEIGHT_CLASS_NORMAL ? "ration_large" : "ration_small"
		dropshrink = 1
		update_icon()
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		to_chat(user, span_notice("You wrap [I] in the parcel wrapper."))

/obj/item/parcel/attack_self(mob/user)
	if(!contained_item)
		return

	if(delivery_area_type)
		var/area/quest_area = delivery_area_type
		if(ispath(quest_area, /area) && !(user.job in allowed_jobs))
			to_chat(user, span_warning("This parcel is sealed for delivery to [initial(quest_area.name)] and can only be opened by: [english_list(allowed_jobs)]!"))
			return FALSE

	if(do_after(user, 2 SECONDS, target = src))
		to_chat(user, span_notice("You unwrap [contained_item] from the parcel."))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		user.put_in_hands(contained_item)
		contained_item.update_icon()
		contained_item = null
		qdel(src)

/obj/item/parcel/examine(mob/user)
	. = ..()
	if(!delivery_area_type)
		return

	var/area/delivery_area = delivery_area_type
	if(!ispath(delivery_area, /area))
		return

	. += span_info("This parcel is addressed to [initial(delivery_area.name)].")
	. += (user.job in allowed_jobs) ? \
		span_notice("As [user.job], you're authorized to open this.") : \
		span_warning("It's sealed with an official guild mark - only authorized personnel should open this!")
