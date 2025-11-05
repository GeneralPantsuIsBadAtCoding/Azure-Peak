///////////////////////////////////////////////////////
///////////////////////////////////////////////// VERBS
/*
	something labelled with (F) is Fucked & Nonfunctional
	1 - Abandon Envoy			// returns an envoy's client to their original character
	2 - Communicate				// warband comms
	3 - Extend Invitation 	(F)	// invite other warband members to a new warband
	4 - Abandon Warband			// desertion mechanic for Lieutenants 
	5 - Take Shortcut		(F)	// allows for a quick teleport over to the warcamp
	6 - Connect Warcamp			// connects the Warcamp Z-Level to the main map

*/


// 1
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////// ABANDON ENVOY
/* 1
	a verb to manually perform the return_envoy proc in emergencies
	abandons a character's envoy & sends them back to their stored character w/return_envoy
*/
/mob/living/carbon/human/proc/abandon_envoy()
	set name = "ABANDON ENVOY"
	set category = "Warband"


	var/list/style_options = list()
	
	if(src.mind.warband_manager.selected_warband?.title == "SORCERER-KING")
		style_options += "BLOW UP HEAD"
	if(src.mind.warband_manager.selected_subtype?.title == "ASCENDANT")
		style_options += "DEADITE"

	style_options += "POISON TOOTH"

	var/style_choice = input(src, "How should they go out?", "ABANDON SHIP") as null|anything in style_options


	switch(style_choice)
		if("POISON TOOTH")
			ADD_TRAIT(src, TRAIT_NOSSDINDICATOR, TRAIT_GENERIC)
			src.visible_message(span_boldred("[src] suddenly seizes up, blood-laced foam bubbling from the corners of their mouth!"))
			src.mind.warband_manager.return_envoy(src, abandoned = TRUE)
			src.adjustOxyLoss(200)
			src.adjustToxLoss(200)
			return TRUE
		if("DEADITE")
			if(prob(90))
				ADD_TRAIT(src, TRAIT_NOSSDINDICATOR, TRAIT_GENERIC)
				src.emote("agony", forced = TRUE)
				src.visible_message(span_boldred("[src] digs their nails into their flesh. Once they have a solid grip, they yank themselves free!"))
				src.mind.warband_manager.return_envoy(src, abandoned = TRUE)
				addtimer(CALLBACK(src, PROC_REF(abandon_followup), 1), 3 SECONDS)
				return TRUE
			else
				ADD_TRAIT(src, TRAIT_NOSSDINDICATOR, TRAIT_GENERIC)
				src.emote("agony", forced = TRUE)
				src.visible_message(span_boldred("[src] contorts in agony as wisps of a dark, terrible energy rise from their screaming lips and bleeding ears. Something wicked is coming..."))
				src.mind.warband_manager.return_envoy(src, abandoned = TRUE)
				addtimer(CALLBACK(src, PROC_REF(abandon_followup), 2), 3 SECONDS)
				return TRUE

		if("BLOW UP HEAD")
			ADD_TRAIT(src, TRAIT_NOSSDINDICATOR, TRAIT_GENERIC)
			src.visible_message(span_boldred("[src]'s skull hums with a swelling, arcane force! Holy shit! They're gonna blow!"))
			src.flash_fullscreen("redflash3")
			src.emote("agony", forced = TRUE)			
			src.mind.warband_manager.return_envoy(src, abandoned = TRUE)
			addtimer(CALLBACK(src, PROC_REF(abandon_followup), 3), 3 SECONDS)
			return TRUE
	return TRUE


/mob/living/carbon/human/proc/abandon_followup(event)
	if(event == 1)
		var/deathloc = src.loc
		var/mob/living/carbon/human/species/skeleton/npc/no_equipment/skeleton = new /mob/living/carbon/human/species/skeleton/npc/no_equipment(deathloc)
		skeleton.emote("laugh", forced = TRUE)
		src.gib()
		return TRUE

	if(event == 2)
		var/deathloc = src.loc
		src.gib()
		new /mob/living/simple_animal/hostile/rogue/haunt/omen(deathloc)
		return TRUE

	if(event == 3)
		src.mind = null
		var/obj/item/bodypart/head = src.get_bodypart(BODY_ZONE_HEAD)
		if(head)
			explosion(src, light_impact_range = 4,  smoke = TRUE)
			head.drop_limb()
			qdel(head)
		return TRUE

// 2
/////////////////////////////////////////////////////////////
///////////////////////////////////////////////// COMMUNICATE
/* 2
	cross-map communication for warband characters
*/
/mob/living/carbon/human/proc/communicate()
	set name = "COMMUNICATE"
	set category = "Warband"

	if(src.mind.warband_manager.disorder >= 8)
		to_chat(src, span_bold("I call, but no Carrier Zad heeds me. It's likely disturbed by the disorder in our Warband."))
		return

	if(istype(src.loc.loc, /area/rogue/outdoors))
		var/input_text = input(src, "Enter your message", "Message")
		if(input_text)
			var/sanitized_text = html_encode(input_text)

			src.visible_message(span_boldred("[src] begins binding a sealed letter to a zad's leg..."))
			if(do_after(src, 100, FALSE, src))
				if(istype(src.loc.loc, /area/rogue/outdoors)) // another area check, in case someone starts the prompt outside and moves back inside for the doafter
					src.visible_message(span_boldred("[src] releases a carrier zad!"))
					playsound(src, 'sound/vo/mobs/bird/birdfly.ogg', 100, TRUE, -1)
					for(var/mob/warband_member in src.mind.warband_manager.members)
						if(isliving(warband_member))
							if(istype(warband_member.loc.loc, /area/rogue/outdoors))
								to_chat(warband_member, span_boldred("A zad-bound message arrives with the seal of the [src.job]: <span style='color:#[src.voice_color]'>''[sanitized_text]''</span> - [src.real_name]"))
							else
								to_chat(warband_member, span_boldred("Beyond the walls, I faintly hear a carrier zad cawing in mimicry: <span style='color:#[src.voice_color]'>''[sanitized_text]''</span>"))
	else
		to_chat(src, span_bold("I'll need to be outside."))


// 3
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////// EXTEND INVITATION
/* 3
	FIXNOTE
	invites targeted lieutenants & grunts to a new warband
*/
/mob/living/carbon/human/proc/warband_invite()
	set name = "EXTEND INVITATION"
	set category = "Warband"



// 4
/////////////////////////////////////////////////////////////////
///////////////////////////////////////////////// ABANDON WARBAND
/* 4
	abandons the current warband & allows the character to create their own warcamp (assuming a space is open)

	both aspirant & regular lieutenants can do this - aspirant lieutenants just do so to greater effect
*/

/mob/living/carbon/human/proc/abandon_warband()
	set name = "DESERT WARBAND"
	set category = "Warband"

	if(src.stat == DEAD)
		to_chat(src, span_boldred("It's too late..."))
		return FALSE

	var/extra_item = FALSE
	var/disorder = src.mind.warband_manager.disorder

	var/troops_available = src.mind.warband_manager.spawns

	var/stolen_troop_percentage
	if(src.mind.special_role == "Aspirant Lieutenant")
		stolen_troop_percentage = 30
	else
		stolen_troop_percentage = 10

	// each point of disorder increases the number of stolen troops by 15%
	stolen_troop_percentage += (disorder * 15)

	var/stolen_troops = (troops_available * stolen_troop_percentage) / 100

	if(stolen_troops > troops_available)
		stolen_troops = troops_available


	src.mind.warband_manager.spawns = max(0, troops_available - stolen_troops)


	var/calltext = input("You are preparing to DESERT your Warband. This will be a public declaration. What will you say?", "DESERTION") as text|null
	if(!calltext)
		return FALSE
	else
	
		src.visible_message(span_boldred("[src] blows into a warhorn!"))
		priority_announce("The [src.job] has deserted the [src.mind.warband_manager.selected_warband.name] accompanied by [stolen_troops] of their rank-and-file. \
		Their words of departure are as follows:\n \n [calltext]", title = "WORD SPREADS OF DESERTION", sound = 'sound/misc/warband/exile_warhorn_altb.ogg', sender = src, receiver = /mob/living/carbon/human)
		// if this being a round-wide announcement would be too annoying, it could be restricted to only display to warband members
		// but atm i think it'd be fun to let everyone in on the drama

		var/old_faction_string = "warband_[src.mind.warband_ID]"
		var/atom/movable/screen/warband/manager/new_warband_manager
		new_warband_manager = new /atom/movable/screen/warband/manager
		new_warband_manager.schism_level = src.mind.warband_manager + 1

		src.mind.special_role = "Warlord"
		SSmapping.retainer.warlords |= src.mind	
		src.mind.warband_ID = SSwarbands.warband_managers.len + 1
		new_warband_manager.warband_ID = src.mind.warband_ID

		src.faction.Remove(old_faction_string)
		src.faction |= list("warband_[src.mind.warband_ID]")


		for(var/mob/living/grunt in src.friends)
			grunt.faction.Remove(old_faction_string)
			grunt.faction |= list("warband_[src.mind.warband_ID]")
		new_warband_manager.members += src
		SSwarbands.warband_managers += new_warband_manager

		switch(src.advjob)

			if("Preacher") // a preacher in schism creates a faithlocked sect
				new_warband_manager.selected_warband = new /datum/warbands/sect
				if(src.patron.type in ALL_DIVINE_PATRONS)
					new_warband_manager.selected_subtype = new WARBAND_SECT_TEN
				else if(src.patron.type in ALL_INHUMEN_PATRONS)
					new_warband_manager.selected_subtype = new WARBAND_SECT_FOUR
				else if(src.patron.name == "Psydon")
					new_warband_manager.selected_subtype = new WARBAND_SECT_PSYDON
				new_warband_manager.faithlocks = list(src.patron)

			if("Magician") // a magician in schism (potentially) creates a sorcerer-king
				if(src.mind.warband_manager.disorder >= 3)
					for(var/obj/item/rogueweapon/woodstaff/riddle_of_steel/rod in src.contents)
						extra_item = TRUE
						break
				if(extra_item == TRUE)
					new_warband_manager.selected_warband = new /datum/warbands/storyteller/wizard
					to_chat(src, span_boldred("I feel a shift in destiny's tides with my declaration. <span style='color:#801d1d'>The Wandering Tower calls to me.</span>"))
				else
					new_warband_manager.selected_warband = src.mind.warband_manager.selected_warband
					new_warband_manager.selected_subtype = src.mind.warband_manager.selected_subtype

			else
				new_warband_manager.selected_warband = src.mind.warband_manager.selected_warband
				new_warband_manager.selected_subtype = src.mind.warband_manager.selected_subtype

		new_warband_manager.finalized = TRUE
		src.verbs -= /mob/living/carbon/human/proc/abandon_warband
		src.verbs += /mob/living/carbon/human/proc/connect_warcamp
		src.mind.warband_manager = new_warband_manager
	return TRUE


// 5
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////// TAKE SHORTCUT
/* 5
	teleports someone to their camp's Shortcut Tile
	FAILS IF:
		they aren't near an existing travel tile. any will do
		the shortcut tile is disabled/captured FIXNOTE
		the camp hasn't been connected to the main z-level via an Envoy using a "SCOUT A PATH" verb
*/ 
/mob/living/carbon/human/proc/shortcut()
	set name = "TAKE SHORTCUT"
	set desc = "Attempt to take a shortcut to your warcamp."
	set category = "Warband"

	var/can_shortcut = FALSE


	if(!src.mind.warband_manager.outskirts_established)
		to_chat(src, span_bold("Before I can take a shortcut back to the Warcamp, an ENVOY needs to Scout a Path."))
		return TRUE

	for(var/obj/structure/object in range(1, src))
		if(istype(object, /obj/structure/fluff/traveltile) || istype(object, /obj/structure/far_travel))
			can_shortcut = TRUE
			break

	if(!can_shortcut)
		to_chat(src, span_bold("Should I find a Travel Tile of any kind, I can TAKE A SHORTCUT back to my Warcamp."))
		return TRUE

	if(do_after(src, 100, FALSE, src))
		for(var/obj/structure/fluff/warband/shortcut/warband_shortcut in SSwarbands.warband_machines)
			if(warband_shortcut.warband_ID == src.mind.warband_ID)
				if(warband_shortcut.disabled)
					to_chat(src, span_userdanger("Something's wrong. I've been cut off, and I'll need to return through the frontline."))
				else
					src.visible_message(span_bold("[src] slips somewhere beyond sight!"))
					src.loc = warband_shortcut.loc
				break 
		return TRUE



	return TRUE

// 6
/////////////////////////////////////////////////////////////////
///////////////////////////////////////////////// CONNECT WARCAMP
/* 6
	spawns a travel tile to a newly spawned set of intermission & outskirts maps, which connect to the warcamp
	the spawned maps vary depending on where the travel tile is spawned
	
	requires a rock wall nearby
	area limited

	spawns a few extra tiles near the first that will try to place themselves adjacent to a rock wall

*/
/mob/living/carbon/human/proc/connect_warcamp()
	set name = "SCOUT PATH TO WARCAMP"
	set category = "Warband"

	if(SSwarbands.warband_managers_busy == TRUE) // we don't want multiple maps getting spawned at the same time
		to_chat(src, span_userdanger("I'll need to wait for a moment."))

	var/area/zone = src.loc.loc

	var/list/allowed_area_types = list(
		/area/rogue/under/underdark,
		/area/rogue/under/cave,
		/area/rogue/under/cavewet,
		/area/rogue/outdoors/woods,
		/area/rogue/outdoors/bog,
		/area/rogue/outdoors/mountains/decap,
		/area/rogue/outdoors/beach,
		/area/rogue/outdoors/mountains
	)
	var/list/blacklisted_area_types = list(
		/area/rogue/outdoors/beach/forest/hamlet
	)

	var/is_allowed = FALSE
	for(var/type_path in allowed_area_types)
		if(istype(zone, type_path))
			is_allowed = TRUE
			break

	if(!src.mind.warband_manager.warcamp_established) // if this is being done without a warcamp, we check if there's a free space. if there isn't, we cancel this
		var/obj/effect/landmark/warcamp/found_slot
		for(var/obj/effect/landmark/warcamp/open_warcamp_slot in GLOB.landmarks_list)
			found_slot = TRUE
			break
		if(!found_slot)
			to_chat(src, span_userdanger("The entire countryside is occupied. I can't establish a Warcamp."))
			return
	if(!is_allowed)
		to_chat(src, span_userdanger("This isn't a suitable location."))        
		return


	var/has_mineral_turf = locate(/turf/closed/mineral) in range(1, src)
	if(!has_mineral_turf)
		to_chat(src, span_green("This is a good location. I should get my bearings beside a ROCK WALL before I plot a route back to camp."))		
		return


	if(is_allowed && !istype(zone, blacklisted_area_types))
		if(SSwarbands.warband_managers_busy == TRUE)	// we don't want multiple maps getting spawned at the same time
			to_chat(src, span_userdanger("I'll need to wait for a moment."))
			return
		if(src.mind.warband_manager.outskirts_established == TRUE)
			to_chat(src, span_userdanger("A path has already been scouted."))
			return
		for(var/turf/nearby_turf in range(4, src))
			if(nearby_turf.contents == /obj/structure/fluff/traveltile)
				to_chat(src, span_userdanger("I'm too close to an existing path."))				
				return
		SSwarbands.warband_managers_busy = TRUE
		src.visible_message(span_notice("[src] begins scouting for a new path..."))

		if(do_after(src, 30, target = src))
			var/chosen_outskirts_map
			var/chosen_intermission_map

			if(istype(zone, /area/rogue/under/cave) || istype(zone, /area/rogue/under/underdark) || istype(zone, /area/rogue/under/cavewet) || istype(zone, /area/rogue/indoors/cave) || istype(zone, /area/rogue/outdoors/caves))
				chosen_outskirts_map = pick(list(/datum/map_template/outskirts/cave_a))
				chosen_intermission_map = pick(list(/datum/map_template/intermission/cave_a))
			else if(istype(zone, /area/rogue/outdoors/mountains) || istype(zone, /area/rogue/outdoors/mountains/decap))
				chosen_outskirts_map = pick(list(/datum/map_template/outskirts/mountains_a))
				chosen_intermission_map = pick(list(/datum/map_template/intermission/mountains_a))
			else if(istype(zone, /area/rogue/outdoors/beach))
				chosen_outskirts_map = pick(list(/datum/map_template/outskirts/coast_a))
				chosen_intermission_map = pick(list(/datum/map_template/intermission/coast_a))
			else if(istype(zone, /area/rogue/outdoors/woods))
				chosen_outskirts_map = pick(list(/datum/map_template/outskirts/river_a))
				chosen_intermission_map = pick(list(/datum/map_template/intermission/woods_a))
			else if(istype(zone, /area/rogue/outdoors/bog))
				chosen_outskirts_map = pick(list(/datum/map_template/outskirts/bog_a))
				chosen_intermission_map = pick(list(/datum/map_template/intermission/bog_a))

			if(!chosen_outskirts_map || !chosen_intermission_map) // this shouldn't happen | if you've added a new area, make sure it's in the allowed_area_types at the start of this proc, AND the type selection above this line
				to_chat(src, span_userdanger("Something's wrong. I should attempt this somewhere else."))
				SSwarbands.warband_managers_busy = FALSE
				return
			if(src.mind.warband_manager.outskirts_established == TRUE)
				to_chat(src, span_userdanger("A path has already been scouted."))
				return
			var/outskirts_landmark_found = FALSE
			var/obj/effect/landmark/warcamp_outskirts/used_outskirts_landmark
			for(var/obj/effect/landmark/warcamp_outskirts/outskirts_landmark in GLOB.landmarks_list)
				var/datum/map_template/new_outskirts = new chosen_outskirts_map()
				new_outskirts.load(outskirts_landmark.loc, centered = TRUE)
				used_outskirts_landmark = outskirts_landmark
				outskirts_landmark_found = TRUE
				break

			if(used_outskirts_landmark)
				qdel(used_outskirts_landmark)

			var/intermission_landmark_found = FALSE
			var/obj/effect/landmark/warcamp_intermission/used_intermission_landmark
			for(var/obj/effect/landmark/warcamp_intermission/intermission_landmark in GLOB.landmarks_list)
				var/datum/map_template/new_intermission = new chosen_intermission_map()
				new_intermission.load(intermission_landmark.loc, centered = TRUE)
				used_intermission_landmark = intermission_landmark
				intermission_landmark_found = TRUE
				break

			if(used_intermission_landmark)
				qdel(used_intermission_landmark)

			// spawns the travel tiles to the intermission
			// attempts to get the spawned tiles to hug the wall
			if(outskirts_landmark_found && intermission_landmark_found)
				src.visible_message(span_info("[src] reveals a path to the Warcamp!"))
				src.mind.warband_manager.outskirts_established = TRUE
				var/obj/structure/fluff/traveltile/warband/new_path = new /obj/structure/fluff/traveltile/warband/azure_to_intermission(src.loc)
				new_path.warband_ID = src.mind.warband_ID

				var/list/spawn_locations = list()
				var/list/preferred_spawn_locations = list()
				var/turf/user_turf = src.loc

				for(var/turf/T in range(1, user_turf))
					if(istype(T, /turf/open/floor) && T != user_turf) // not the turf we're on
						spawn_locations += T
						for(var/turf/neighbor_turf in range(1, T))
							if(istype(neighbor_turf, /turf/closed/mineral))
								preferred_spawn_locations += T
								break

				// create a warcamp next, if there's an available space and no warcamp
				if(src.mind.warband_manager.warcamp_established == FALSE)
					for(var/obj/effect/landmark/warcamp/open_warcamp_slot in GLOB.landmarks_list)
						src.mind.warband_manager.choose_map(latespawn = TRUE)
						break

				var/list/final_spawn_locations
				if(preferred_spawn_locations.len >= 2)
					final_spawn_locations = preferred_spawn_locations
				else
					final_spawn_locations = spawn_locations

				final_spawn_locations = shuffle(final_spawn_locations)

				var/tiles_to_place = min(2, final_spawn_locations.len)

				for(var/i = 1, i <= tiles_to_place, i++)
					var/turf/chosen_turf = final_spawn_locations[i]
					var/obj/structure/fluff/traveltile/warband/new_tile = new /obj/structure/fluff/traveltile/warband/azure_to_intermission(chosen_turf)
					new_tile.warband_ID = src.mind.warband_ID

				src.mind.warband_manager.set_IDs()
				src.mind.warband_manager.link_portals()					
				SSwarbands.warband_managers_busy = FALSE
			else
				return
		else
			src.visible_message(span_warning("[src] halts their scouting."))
			SSwarbands.warband_managers_busy = FALSE
			return
	else
		to_chat(src, span_warning("This isn't a suitable location."))
		return

	return TRUE

