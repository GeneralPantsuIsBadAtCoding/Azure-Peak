/client/proc/mass_direct()
	set name = "Direct Mobs"
	set category = "GameMaster"
	if(holder)
		holder.mass_direct_mobs()

/datum/admins/proc/mass_direct_mobs(radius = 20, faction = null)
	if(!check_rights(R_ADMIN))
		return
	
	var/list/valid_factions = list(
		"orcs",
		"undead",
		"caves"
	)
	
	var/faction_options = ""
	for(var/F in valid_factions)
		faction_options += "<option value='[F]' [F == faction ? "selected" : ""]>[F]</option>"
	
	var/dat = {"
		<center><B>Mass Direct Mobs</B></center><hr>
		<B>Current Settings:</B><br>
		Radius: [radius]<br>
		<A href='?src=[REF(src)];[HrefToken()];mass_direct=set_radius;current_radius=[radius];faction=[faction]'>Set Radius</A><br>
		<br>
		Faction: <select onchange="window.location='?src=[REF(src)];[HrefToken()];mass_direct=set_faction;radius=[radius];faction=' + this.value">
			<option value=''>Select Faction</option>
			[faction_options]
		</select><br>
		<br>
		"}

	if(faction)
		dat += {"
			<br>
			<A href='?src=[REF(src)];[HrefToken()];mass_direct=begin_targeting;radius=[radius];faction=[faction]'>Begin Directing Mobs</A><br>
			"}
	
	usr << browse(dat, "window=mass_direct;size=300x400")

/datum/admins/Topic(href, href_list)
	. = ..()
	if(.)
		return
	
	if(!check_rights(R_ADMIN))
		return
	
	if(!href_list["mass_direct"])
		return
	
	var/radius = text2num(href_list["radius"]) || text2num(href_list["current_radius"]) || 20
	var/faction = href_list["faction"]
	
	switch(href_list["mass_direct"])
		if("set_radius")
			var/new_radius = input("Enter new radius (1-50):", "Set Radius", radius) as num|null
			if(new_radius)
				radius = clamp(new_radius, 1, 50)
		
		if("set_faction")
			faction = href_list["faction"]
		
		if("begin_targeting")
			if(!faction)
				to_chat(usr, span_warning("No faction selected!"))
				return
				
			to_chat(usr, span_notice("Click on locations to direct mobs. Right click to stop directing."))
			var/datum/mass_direct_click_intercept/click_handler = new(usr.client, src, radius, faction)
			usr.client.click_intercept = click_handler
			return
	
	mass_direct_mobs(radius, faction)

/datum/mass_direct_click_intercept
	var/client/owner
	var/datum/admins/admin_datum
	var/radius
	var/faction

/datum/mass_direct_click_intercept/New(client/C, datum/admins/A, R, F)
	owner = C
	admin_datum = A
	radius = R
	faction = F
	owner.mouse_pointer_icon = 'icons/effects/supplypod_target.dmi'

/datum/mass_direct_click_intercept/proc/InterceptClickOn(user, params, atom/target)
	var/list/modifiers = params2list(params)
	if(modifiers["right"])
		cleanup()
		return TRUE
	
	if(istype(target, /atom/movable/screen))
		return FALSE
	
	var/turf/T = get_turf(target)
	if(!T)
		return TRUE
		
	var/count = 0
	for(var/mob/living/simple_animal/M in range(radius, user))
		if(M.client) // Skip player-controlled mobs
			continue
		
		if(!(M.faction.Find(faction))) // Skip mobs not in selected faction
			continue
		
		var/datum/ai_controller/ai = M.ai_controller
		if(!ai)
			continue
		
		ai.clear_blackboard_key(BB_TRAVEL_DESTINATION)
		ai.set_blackboard_key(BB_TRAVEL_DESTINATION, T)
		count++
	
	to_chat(user, span_notice("Directed [count] [faction] mobs towards ([T.x], [T.y], [T.z])."))
	//message_admins("[key_name_admin(user)] has directed [count] [faction] mobs towards [ADMIN_VERBOSEJMP(T)]")
	log_admin("[key_name(user)] has directed [count] [faction] mobs towards [AREACOORD(T)]")
	
	return TRUE

/datum/mass_direct_click_intercept/proc/cleanup()
	if(owner)
		owner.click_intercept = null
		owner.mouse_pointer_icon = null
		owner.mob.update_mouse_pointer()
