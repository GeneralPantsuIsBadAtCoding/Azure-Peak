/client/proc/view_rogue_manifest()
	var/dat
	dat += "<h3>Round ID: [GLOB.rogue_round_id]</h1>"
	for(var/X in GLOB.character_list)
		dat += "[GLOB.character_list[X]]"

	var/datum/browser/popup = new(src, "actors", "<center>Inhabitants of Twilight Axis</center>", 387, 420)
	popup.set_content(dat)
	popup.open(FALSE)

/client/proc/view_actors_manifest()
	var/dat
	for(var/X in GLOB.actors_list)
		dat += "[GLOB.actors_list[X]]"

	var/datum/browser/popup = new(src, "actors", "<center>This Story's Actors</center>", 387, 420)
	popup.set_content(dat)
	popup.open(FALSE)

/client/proc/view_roleplay_ads()
	var/dat
	for(var/X in GLOB.roleplay_ads)
		dat += "[GLOB.roleplay_ads[X]]"

	var/datum/browser/popup = new(src, "actors", "<center>Roleplay Ads</center>", 500, 600)
	popup.set_content(dat)
	popup.open(FALSE)
