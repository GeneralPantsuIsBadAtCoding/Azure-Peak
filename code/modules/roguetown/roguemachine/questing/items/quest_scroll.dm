#define WHISPER_COOLDOWN 10 SECONDS
/obj/item/paper/scroll/quest
	name = "enchanted quest scroll"
	desc = "A weathered scroll oft known as a \"whispering scroll\". Enchanted with magicks to make it whisper to its bearer when opened the location of its target.\n\
	The magical protections make it resistant to damage and tampering. It will only whisper when carried on the person of the quest bearer."
	icon = 'code/modules/roguetown/roguemachine/questing/questing.dmi'
	icon_state = "scroll_quest"
	var/base_icon_state = "scroll_quest"
	var/datum/quest/assigned_quest
	var/last_compass_direction = ""
	var/last_z_level_hint = ""
	var/last_whisper = 0 // Last time the scroll whispered to the user
	resistance_flags = FIRE_PROOF | LAVA_PROOF | INDESTRUCTIBLE | UNACIDABLE
	max_integrity = 1000
	armor = list("blunt" = 100, "slash" = 100, "stab" = 100, "piercing" = 100, "fire" = 100, "acid" = 100)

/obj/item/paper/scroll/quest/Initialize()
	. = ..()
	if(assigned_quest)
		assigned_quest.quest_scroll = src 
	update_quest_text()
	START_PROCESSING(SSprocessing, src)

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
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/obj/item/paper/scroll/quest/update_icon_state()
	if(open)
		icon_state = info ? "[base_icon_state]_info" : "[base_icon_state]"
	else
		icon_state = "[base_icon_state]_closed"
	

/obj/item/paper/scroll/quest/process()
	if(world.time > last_whisper + WHISPER_COOLDOWN)
		last_whisper = world.time
		target_whisper()

/obj/item/paper/scroll/quest/proc/target_whisper()
	if(!assigned_quest || assigned_quest.complete || !assigned_quest.quest_receiver_reference)
		return
	var/obj/itemloc = src.loc
	var/mob/quest_bearer = assigned_quest.quest_receiver_reference?.resolve()
	// I should refactor this out at some point
	if(!istype(itemloc, /mob/living))
		while(!istype(itemloc, /mob/living))
			if(isnull(itemloc))
				return
			itemloc = itemloc.loc
			if(istype(itemloc, /turf))
				return
	if(itemloc != quest_bearer)
		return
	if(open && quest_bearer)
		update_compass(quest_bearer)
		var/message = ""
		message = "[last_compass_direction]"
		if(last_z_level_hint)
			message += " ([last_z_level_hint])"
		to_chat(quest_bearer, span_info("The scroll whispers to you, the target is [message]"))

/obj/item/paper/scroll/quest/examine(mob/user)
	. = ..()
	if(!assigned_quest)
		return
	if(!assigned_quest.quest_receiver_reference)
		. += span_notice("This quest hasn't been claimed yet. Open it to claim it for yourself!")
	else if(assigned_quest.complete)
		. += span_notice("\nThis quest is complete! Return it to the Notice Board to claim your reward.")
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

/obj/item/paper/scroll/quest/read(mob/user)
	refresh_compass(user)
	return ..()

/obj/item/paper/scroll/quest/attack_self(mob/user)
	. = ..()
	if(.)
		return

	// Only do claim logic if unclaimed
	if(!assigned_quest || assigned_quest.quest_receiver_reference)
		refresh_compass(user) // Refresh compass when opened by claimed user
		update_quest_text()
		return

	// Claim the quest
	assigned_quest.quest_receiver_reference = WEAKREF(user)
	assigned_quest.quest_receiver_name = user.real_name

	to_chat(user, span_notice("You claim this quest for yourself!"))
	update_quest_text()
	refresh_compass(user) // Update compass after claiming

/obj/item/paper/scroll/quest/proc/update_quest_text()
	if(!assigned_quest)
		return

	var/scroll_text = "<center>HELP NEEDED</center><br>"
	scroll_text += "<center><b>[assigned_quest.title]</b></center><br><br>"
	scroll_text += "<b>Issued by:</b> [assigned_quest.quest_giver_name ? "[assigned_quest.quest_giver_name]" : "The Adventurer's Guild"].<br>"
	scroll_text += "<b>Issued to:</b> [assigned_quest.quest_receiver_name ? assigned_quest.quest_receiver_name : "whoever it may concern"].<br>"
	scroll_text += "<b>Type:</b> [assigned_quest.quest_type] quest.<br>"
	scroll_text += "<b>Difficulty:</b> [assigned_quest.quest_difficulty].<br><br>"

	if(last_compass_direction)
		scroll_text += "<b>Direction:</b> The target is [last_compass_direction]. "
		if(last_z_level_hint)
			scroll_text += " ([last_z_level_hint])"
	scroll_text += "<br>"

	switch(assigned_quest.quest_type)
		if(QUEST_FETCH)
			scroll_text += "<b>Objective:</b> Retrieve [assigned_quest.target_amount] [initial(assigned_quest.target_item_type.name)].<br>"
			scroll_text += "<b>Last Seen Location:</b> Reported sighting in [assigned_quest.target_spawn_area] region.<br>"
		if(QUEST_KILL, QUEST_MINIBOSS)
			scroll_text += "<b>Objective:</b> Slay [assigned_quest.target_amount] [initial(assigned_quest.target_mob_type.name)].<br>"
			scroll_text += "<b>Last Seen Location:</b> [assigned_quest.target_spawn_area ? "Reported sighting in [assigned_quest.target_spawn_area] region." : "Reported sighting in Azuria region."]<br>"
		if(QUEST_CLEAR_OUT)
			scroll_text += "<b>Objective:</b> Eliminate [assigned_quest.target_amount] [initial(assigned_quest.target_mob_type.name)].<br>"
			scroll_text += "<b>Infestation Location:</b> [assigned_quest.target_spawn_area ? "Reported sighting in [assigned_quest.target_spawn_area] region." : "Reported infestations in Azuria region."]<br>"
		if(QUEST_COURIER)
			scroll_text += "<b>Objective:</b> Deliver [initial(assigned_quest.target_delivery_item.name)] to [initial(assigned_quest.target_delivery_location.name)].<br>"
			scroll_text += "<b>Delivery Instructions:</b> Package is hidden by a spell in the designated location. Spell will falter once this scroll is brought nearby. Package must remain intact and be delivered directly to the recipient.<br>"
			scroll_text += "<b>Pickup location:</b> Reported sighting in [assigned_quest.target_spawn_area] region.<br>"
			scroll_text += "<b>Destination Description:</b> [initial(assigned_quest.target_delivery_location.name)].<br>" // TODO: brief_descriptor

	scroll_text += "<br><b>Reward:</b> [assigned_quest.reward_amount] mammon upon completion<br>"
	
	if(assigned_quest.complete)
		scroll_text += "<br><center><b>QUEST COMPLETE</b></center>"
		scroll_text += "<br><b>Return this scroll to the Notice Board to claim your reward!</b>"
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
	for(var/datum/weakref/tracked_weakref in assigned_quest.tracked_atoms)
		var/atom/target_atom = tracked_weakref.resolve()
		if(QDELETED(target_atom))
			continue

		var/dist = get_dist(user_turf, target_atom)
		if(!target || dist < min_distance)
			target = target_atom
			min_distance = dist

	if(!target || !(target_turf = get_turf(target)))
		last_compass_direction = "location unknown"
		last_z_level_hint = ""
		return

	// We want the target to know z level differences but verticality exists
	// We don't want to frustrate player by forcing them to track on the same z level
	// Especially cuz of how many transitions exist
	if(target_turf.z != user_turf.z)
		var/z_diff = abs(target_turf.z - user_turf.z)
		last_z_level_hint = target_turf.z > user_turf.z ? \
			"[z_diff] level\s above you" : \
			"[z_diff] level\s below you"

	// Calculate direction from user to target
	var/dx = target_turf.x - user_turf.x  // EAST direction
	var/dy = target_turf.y - user_turf.y  // NORTH direction
	var/distance = sqrt(dx*dx + dy*dy)

	// If very close, don't show direction
	if(distance <= 7)
		last_compass_direction = "is nearby"
		last_z_level_hint = ""
		return

	// Calculate angle in degrees (0 = east, 90 = north)
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

	last_compass_direction = "[distance_text] to the [direction_text]"
	if(!last_z_level_hint)
		last_z_level_hint = "on this level"

/obj/item/paper/scroll/quest/proc/get_precise_direction_from_angle(angle)
	// ATAN2 gives angle from positive x-axis (east) to the vector
	// We need to:
	// 1. Convert to compass degrees (0°=north, 90°=east)
	// 2. Invert the direction (show direction TO target FROM player)

	// Normalize angle first
	angle = (angle + 360) % 360

	// Convert to compass bearing (0°=north, 90°=east)
	var/compass_angle = (450 - angle) % 360  // 450 = 360 + 90

	// Return direction based on inverted compass angle
	// Return direction based on inverted compass angle
	switch(compass_angle)
		if(348.75 to 360, 0 to 11.25)
			return "north"
		if(11.25 to 33.75)
			return "north-northeast"
		if(33.75 to 56.25)
			return "northeast"
		if(56.25 to 78.75)
			return "east-northeast"
		if(78.75 to 101.25)
			return "east"
		if(101.25 to 123.75)
			return "east-southeast"
		if(123.75 to 146.25)
			return "southeast"
		if(146.25 to 168.75)
			return "south-southeast"
		if(168.75 to 191.25)
			return "south"
		if(191.25 to 213.75)
			return "south-southwest"
		if(213.75 to 236.25)
			return "southwest"
		if(236.25 to 258.75)
			return "west-southwest"
		if(258.75 to 281.25)
			return "west"
		if(281.25 to 303.75)
			return "west-northwest"
		if(303.75 to 326.25)
			return "northwest"
		if(326.25 to 348.75)
			return "north-northwest"

#undef WHISPER_COOLDOWN
