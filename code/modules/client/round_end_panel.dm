/// Shows round end popup with all kind of statistics
/client/proc/show_round_stats(featured_stat)
	if(SSticker.current_state != GAME_STATE_FINISHED && !check_rights(R_ADMIN))
		return

	var/list/data = list()

	// Navigation buttons
	data += "<div style='width: 100%; text-align: center; margin: 15px 0;'>"
	data += "<a href='byond://?src=[REF(src)];viewstats=1' style='display: inline-block; width: 120px; padding: 8px 12px; margin: 0 10px; background: #2a2a2a; border: 1px solid #444; color: #ddd; font-weight: bold; text-decoration: none; border-radius: 3px; font-size: 0.9em;'>STATISTICS</a>"
	data += "<a href='byond://?src=[REF(src)];viewinfluences=1' style='display: inline-block; width: 120px; padding: 8px 12px; margin: 0 10px; background: #2a2a2a; border: 1px solid #444; color: #ddd; font-weight: bold; text-decoration: none; border-radius: 3px; font-size: 0.9em;'>INFLUENCES</a>"
	data += "</div>"

	// Featured stat setup
	var/current_featured = featured_stat
	if(!current_featured || !(current_featured in GLOB.featured_stats))
		current_featured = pick(GLOB.featured_stats)
	var/list/stat_keys = GLOB.featured_stats
	var/current_index = stat_keys.Find(current_featured)
	var/next_stat = stat_keys[(current_index % length(stat_keys)) + 1]
	var/prev_stat = stat_keys[current_index == 1 ? length(stat_keys) : (current_index - 1)]

	// Influential deities section
	var/max_influence = -INFINITY
	var/max_chosen = 0
	var/datum/storyteller/most_influential
	var/datum/storyteller/most_frequent

	for(var/storyteller_name in SSgamemode.storytellers)
		var/datum/storyteller/initialized_storyteller = SSgamemode.storytellers[storyteller_name]
		if(!initialized_storyteller)
			continue

		var/influence = SSgamemode.calculate_storyteller_influence(initialized_storyteller.type)
		if(influence > max_influence)
			max_influence = influence
			most_influential = initialized_storyteller

		if(initialized_storyteller.times_chosen > max_chosen)
			max_chosen = initialized_storyteller.times_chosen
			most_frequent = initialized_storyteller
		else if(initialized_storyteller.times_chosen == max_chosen)
			if(!most_frequent || influence > SSgamemode.calculate_storyteller_influence(most_frequent.type))
				most_frequent = initialized_storyteller
			else if(influence == SSgamemode.calculate_storyteller_influence(most_frequent.type) && prob(50))
				most_frequent = initialized_storyteller

	// Gods display
	data += "<div style='text-align: center; margin: 25px auto; width: 80%; max-width: 800px;'>"

	if(max_influence <= 0 && max_chosen <= 0)
		data += "<div style='font-size: 1.2em; font-weight: bold; margin-bottom: 12px;'>"
		data += "No <span style='color: #bd1717;'>Gods</span>, No <span style='color: #bd1717;'>Masters</span>"
		data += "</div>"
	else
		if(most_influential == most_frequent && max_influence > 0)
			data += "<div style='font-size: 1.2em; font-weight: bold; margin-bottom: 12px;'>"
			data += "The most dominant God was <span style='color:[most_influential.color_theme];'>[most_influential.name]</span>"
			data += "</div>"
		else
			if(max_influence > 0)
				data += "<div style='font-size: 1.2em; font-weight: bold; margin-bottom: 12px;'>"
				data += "The most influential God is <span style='color:[most_influential.color_theme];'>[most_influential.name]</span>"
				data += "</div>"
			if(max_chosen > 0)
				data += "<div style='font-size: 1.2em; font-weight: bold; margin-bottom: 12px;'>"
				data += "The longest reigning God was <span style='color:[most_frequent.color_theme];'>[most_frequent.name]</span>"
				data += "</div>"

	data += "<div style='border-top: 1.5px solid #444; margin: 15px auto; width: 100%;'></div>"
	data += "</div>"

	// Main stats container
	data += "<div style='display: table; width: 100%; border-spacing: 0; table-layout: fixed;'>"
	data += "<div style='display: table-row;'>"

	// Featured Statistics Column (30%)
	data += "<div style='display: table-cell; width: 30%; vertical-align: top; padding-right: 15px;'>"
	data += "<div style='height: 38px; text-align: center;'>"
	data += "<a href='byond://?src=[REF(src)];viewstats=1;featured_stat=[prev_stat]' style='color: #e6b327; text-decoration: none; font-weight: bold; margin-right: 10px; font-size: 1.2em;'>&#9664;</a>"
	data += "<span style='font-weight: bold; color: #bd1717;'>Featured Statistics</span>"
	data += "<a href='byond://?src=[REF(src)];viewstats=1;featured_stat=[next_stat]' style='color: #e6b327; text-decoration: none; font-weight: bold; margin-left: 10px; font-size: 1.2em;'>&#9654;</a>"
	data += "</div>"
	data += "<div style='border-top: 1px solid #444; width: 80%; margin: 0 auto 15px auto;'></div>"
	data += "<div style='text-align: center; margin-bottom: 5px;'>"
	data += "<font color='[GLOB.featured_stats[current_featured]["color"]]'><span class='bold'>[GLOB.featured_stats[current_featured]["name"]]</span></font>"
	data += "</div>"

	// Centered container with left-aligned content
	data += "<div style='text-align: center;'>"
	data += "<div style='display: inline-block; text-align: left; margin-left: auto; margin-right: auto;'>"
	
	var/stat_is_object = GLOB.featured_stats[current_featured]["object_stat"]
	var/has_entries = length(GLOB.featured_stats[current_featured]["entries"])

	if(has_entries)
		if(stat_is_object)
			data += format_top_stats_objects(current_featured)
		else
			data += format_top_stats(current_featured)
	else
		data += "<div style='margin-top: 20px;'>[stat_is_object ? "None" : "Nobody"]</div>"
	
	data += "</div>"
	data += "</div>"
	data += "</div>"

	// General Statistics Section (37%)
	data += "<div style='display: table-cell; width: 37%; vertical-align: top;'>"
	data += "<div style='height: 38px; text-align: center;'>"
	data += "<span style='font-weight: bold; color: #bd1717;'>General Statistics</span>"
	data += "</div>"
	data += "<div style='border-top: 1px solid #444; width: 80%; margin: 0 auto 15px auto;'></div>"
	data += "<div style='display: table; width: 100%;'>"

	// Left column
	data += "<div style='display: table-cell; width: 50%; vertical-align: top; border-left: 1px solid #444; padding: 0 10px;'>"
	data += "<font color='#9b6937'><span class='bold'>Total Deaths:</span></font> [GLOB.azure_round_stats[STATS_DEATHS]]<br>"
	data += "<font color='#6b5ba1'><span class='bold'>Noble Deaths:</span></font> [GLOB.azure_round_stats[STATS_NOBLE_DEATHS]]<br>"
	data += "<font color='#e6b327'><span class='bold'>Revivals:</span></font> [GLOB.azure_round_stats[STATS_ASTRATA_REVIVALS]]<br>"
	data += "<font color='#2dc5bd'><span class='bold'>Lux Revivals:</span></font> [GLOB.azure_round_stats[STATS_LUX_REVIVALS]]<br>"
	data += "<font color='#825b1c'><span class='bold'>Moat Fallers:</span></font> [GLOB.azure_round_stats[STATS_MOAT_FALLERS]]<br>"
	data += "<font color='#ac5d5d'><span class='bold'>Ankles Broken:</span></font> [GLOB.azure_round_stats[STATS_ANKLES_BROKEN]]<br>"
	data += "<font color='#e6d927'><span class='bold'>People Smitten:</span></font> [GLOB.azure_round_stats[STATS_PEOPLE_SMITTEN]]<br>"
	data += "<font color='#50aeb4'><span class='bold'>People Drowned:</span></font> [GLOB.azure_round_stats[STATS_PEOPLE_DROWNED]]<br>"
	data += "<font color='#8f816b'><span class='bold'>Items Stolen:</span></font> [GLOB.azure_round_stats[STATS_ITEMS_PICKPOCKETED]]<br>"
	data += "<font color='#c24bc2'><span class='bold'>Drugs Snorted:</span></font> [GLOB.azure_round_stats[STATS_DRUGS_SNORTED]]<br>"
	data += "<font color='#90a037'><span class='bold'>Laughs Had:</span></font> [GLOB.azure_round_stats[STATS_LAUGHS_MADE]]<br>"
	data += "<font color='#f5c02e'><span class='bold'>Taxes Collected:</span></font> [GLOB.azure_round_stats[STATS_TAXES_COLLECTED]]<br>"
	data += "</div>"

	// Right column
	data += "<div style='display: table-cell; width: 50%; vertical-align: top; padding: 0 10px;'>"
	data += "<font color='#36959c'><span class='bold'>Triumphs Awarded:</span></font> [GLOB.azure_round_stats[STATS_TRIUMPHS_AWARDED]]<br>"
	data += "<font color='#a02fa4'><span class='bold'>Triumphs Stolen:</span></font> [GLOB.azure_round_stats[STATS_TRIUMPHS_STOLEN] * -1]<br>"
	data += "<font color='#d7da2f'><span class='bold'>Prayers Made:</span></font> [GLOB.azure_round_stats[STATS_PRAYERS_MADE]]<br>"
	data += "<font color='#bacfd6'><span class='bold'>Graves Consecrated:</span></font> [GLOB.azure_round_stats[STATS_GRAVES_CONSECRATED]]<br>"
	data += "<font color='#9c3e46'><span class='bold'>Active Deadites:</span></font> [GLOB.azure_round_stats[STATS_DEADITES_ALIVE]]<br>"
	data += "<font color='#0f555c'><span class='bold'>Beards Shaved:</span></font> [GLOB.azure_round_stats[STATS_BEARDS_SHAVED]]<br>"
	data += "<font color='#6e7c81'><span class='bold'>Skills Learned:</span></font> [GLOB.azure_round_stats[STATS_SKILLS_LEARNED]]<br>"
	data += "<font color='#23af4d'><span class='bold'>Plants Harvested:</span></font> [GLOB.azure_round_stats[STATS_PLANTS_HARVESTED]]<br>"
	data += "<font color='#4492a5'><span class='bold'>Fish Caught:</span></font> [GLOB.azure_round_stats[STATS_FISH_CAUGHT]]<br>"
	data += "<font color='#836033'><span class='bold'>Trees Felled:</span></font> [GLOB.azure_round_stats[STATS_TREES_CUT]]<br>"
	data += "<font color='#af2323'><span class='bold'>Organs Eaten:</span></font> [GLOB.azure_round_stats[STATS_ORGANS_EATEN]]<br>"
	data += "<font color='#afa623'><span class='bold'>Locks Picked:</span></font> [GLOB.azure_round_stats[STATS_LOCKS_PICKED]]<br>"
	data += "<font color='#af2379'><span class='bold'>Kisses Made:</span></font> [GLOB.azure_round_stats[STATS_KISSES_MADE]]<br>"
	data += "</div>"
	data += "</div></div>"
	data += "</div>"

	// Census Section (33%)
	data += "<div style='display: table-cell; width: 33%; vertical-align: top;'>"
	data += "<div style='height: 38px; text-align: center;'>"
	data += "<span style='font-weight: bold; color: #bd1717;'>Census</span>"
	data += "</div>"
	data += "<div style='border-top: 1px solid #444; width: 80%; margin: 0 auto 15px auto;'></div>"
	data += "<div style='display: table; width: 100%;'>"
	data += "<div style='display: table-row;'>"

	// Left column
	data += "<div style='display: table-cell; width: 50%; vertical-align: top; border-left: 1px solid #444; padding: 0 10px;'>"
	data += "<font color='#8f1dc0'<span class='bold'>Ruler's Patron:</span></font> [GLOB.azure_round_stats[STATS_MONARCH_PATRON]]<br>"
	data += "<font color='#4682B4'><span class='bold'>Total Populace:</span></font> [GLOB.azure_round_stats[STATS_TOTAL_POPULATION]]<br>"
	data += "<font color='#ce4646'><span class='bold'>Nobility:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_NOBLES]]<br>"
	data += "<font color='#556B2F'><span class='bold'>Garrison:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_GARRISON]]<br>"
	data += "<font color='#DAA520'><span class='bold'>Clergy:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_CLERGY]]<br>"
	data += "<font color='#D2691E'><span class='bold'>Tradesmen:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_TRADESMEN]]<br>"
	data += "<font color='#8B4513'><span class='bold'>Humens:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_NORTHERN_HUMANS]]<br>"	//Here to save space, should be other column
	data += "<font color='#6b89e0'><span class='bold'>Males:</span></font> [GLOB.azure_round_stats[STATS_MALE_POPULATION]]<br>"
	data += "<font color='#d67daa'><span class='bold'>Females:</span></font> [GLOB.azure_round_stats[STATS_FEMALE_POPULATION]]<br>"
	data += "<font color='#77d0cd'><span class='bold'>Non-binary:</span></font> [GLOB.azure_round_stats[STATS_OTHER_GENDER]]<br>"
	data += "<font color='#d0d67c'><span class='bold'>Adults:</span></font> [GLOB.azure_round_stats[STATS_ADULT_POPULATION]]<br>"
	data += "<font color='#FFD700'><span class='bold'>Middle-Aged:</span></font> [GLOB.azure_round_stats[STATS_MIDDLEAGED_POPULATION]]<br>"
	data += "<font color='#C0C0C0'><span class='bold'>Elderly:</span></font> [GLOB.azure_round_stats[STATS_ELDERLY_POPULATION]]<br>"
	data += "</div>"

	// Right column	- Way too many races, so they've been thrown together.
	data += "<div style='display: table-cell; width: 50%; vertical-align: top; padding: 0 10px;'>"
	data += "<font color='#808080'><span class='bold'>Dwarves:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_DWARVES]]<br>"
	data += "<font color='#87CEEB'><span class='bold'>Pure & Half-Elves:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_WOOD_ELVES] + GLOB.azure_round_stats[STATS_ALIVE_HALF_ELVES]]<br>"
	data += "<font color='#7729af'><span class='bold'>Dark Elves:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_DARK_ELVES]]<br>"
	data += "<font color='#e7e3d9'><span class='bold'>Aasimars:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_AASIMAR]]<br>"
	data += "<font color='#DC143C'><span class='bold'>Tieflings:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_TIEFLINGS]]<br>"
	data += "<font color='#228B22'><span class='bold'>Half-Orcs & Goblins:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_HALF_ORCS] + GLOB.azure_round_stats[STATS_ALIVE_GOBLINS]]<br>"
	data += "<font color='#CD853F'><span class='bold'>Kobolds & Verminvolk:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_KOBOLDS] + GLOB.azure_round_stats[STATS_ALIVE_VERMINFOLK]]<br>"
	data += "<font color='#FFD700'><span class='bold'>Zardmen & Dracon:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_LIZARDS] + GLOB.azure_round_stats[STATS_ALIVE_DRACON]]<br>"
	data += "<font color='#d49d7c'><span class='bold'>Half & Wildkins:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_HALFKIN] + GLOB.azure_round_stats[STATS_ALIVE_WILDKIN]]<br>"
	data += "<font color='#99dfd5'><span class='bold'>Lupians/Venardines & Tabaxi:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_LUPIANS] + GLOB.azure_round_stats[STATS_ALIVE_VULPS] + GLOB.azure_round_stats[STATS_ALIVE_TABAXI]]<br>"
	data += "<font color='#c0c6c7'><span class='bold'>Constructs:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_CONSTRUCTS]]<br>"
	data += "<font color='#9ACD32'><span class='bold'>Fluvian & Axians:</span></font> [GLOB.azure_round_stats[STATS_ALIVE_MOTHS] + GLOB.azure_round_stats[STATS_ALIVE_AXIAN]]<br>"
	data += "</div>"

	data += "</div></div>"
	data += "</div>"

	data += "</div></div>"

	// Confessions section
	data += "<div style='text-align: center; margin: 25px auto; padding: 15px 0; border-top: 1.5px solid #444; width: 80%; max-width: 800px;'>"
	if(GLOB.confessors.len)
		data += "<font color='#93cac7'><span class='bold'>Confessions:</span></font> "
		for(var/x in GLOB.confessors)
			data += "[x]"
	else
		data += "<font color='#93cac7'><span class='bold'>No confessions!</span></font>"
	data += "</div>"

	src.mob << browse(null, "window=vanderlin_influences")
	var/datum/browser/popup = new(src.mob, "vanderlin_stats", "<center>End Round Statistics</center>", 1050, 725)
	popup.set_content(data.Join())
	popup.open()

/// Shows Gods influences menu
/client/proc/show_influences(debug = FALSE)
	if(SSticker.current_state != GAME_STATE_FINISHED && !check_rights(R_ADMIN|R_DEBUG))
		return

	var/list/data = list()

	// Navigation buttons
	data += "<div style='width: 91.5%; margin: 0 auto 30px; display: flex; justify-content: center; gap: 20px;'>"
	data += "<a href='byond://?src=[REF(src)];viewstats=1' style='padding: 12px 24px; background: #282828; border: 2px solid #404040; color: #d0d0d0; font-weight: bold; text-decoration: none; border-radius: 4px;'>STATISTICS</a>"
	data += "<a href='byond://?src=[REF(src)];viewinfluences=1' style='padding: 12px 24px; background: #282828; border: 2px solid #404040; color: #d0d0d0; font-weight: bold; text-decoration: none; border-radius: 4px;'>INFLUENCES</a>"
	data += "</div>"

	if(debug && check_rights(R_DEBUG))
		data += "<div style='text-align: center; margin: 10px 0;'>"
		data += "<a href='byond://?src=[REF(src)];viewinfluences=1;debug=[!debug]' style='color: [debug ? "#00FF00" : "#FF0000"];'>[debug ? "DEBUG MODE ON" : "DEBUG MODE OFF"]</a>"
		data += "</div>"

	// Psydon Section
	var/psydonite_user = FALSE
	if(src.mob)
		if(isliving(src.mob))
			var/mob/living/living_user_mob = src.mob
			if(istype(living_user_mob.patron, /datum/patron/old_god))
				psydonite_user = TRUE

	var/psydon_followers = GLOB.patron_follower_counts["Psydon"] || 0
	var/largest_religion = (psydon_followers > 0)
	if(largest_religion)
		for(var/patron in GLOB.patron_follower_counts)
			if(patron == "Psydon")
				continue
			if(GLOB.patron_follower_counts[patron] >= psydon_followers)
				largest_religion = FALSE
				break
	var/apostasy_followers = GLOB.patron_follower_counts["Godless"] || 0
	var/psydonite_monarch = GLOB.azure_round_stats[STATS_MONARCH_PATRON] == "Psydon" ? TRUE : FALSE
	var/psydon_influence = (psydon_followers * 20) + (GLOB.confessors.len * 20) + (GLOB.azure_round_stats[STATS_HUMEN_DEATHS] * -10) + (GLOB.azure_round_stats[STATS_ALIVE_TIEFLINGS] * -20) + (psydonite_monarch ? (psydonite_monarch * 500) : -250) + (largest_religion? (largest_religion * 500) : -250) + (GLOB.azure_round_stats[STATS_PSYCROSS_USERS] * 10) + (apostasy_followers * -20) + (GLOB.azure_round_stats[STATS_LUX_HARVESTED] * -50) + (psydonite_user ? 10000 : -10000)

	data += "<div style='width: 42.5%; margin: 0 auto 30px; border: 2px solid #99b2b1; background: #47636d; color: #d0d0d0; max-height: 420px;'>"
	data += "<div style='text-align: center; font-size: 1.3em; padding: 12px;'><b>PSYDON</b></div>"
	data += "<div style='padding: 0 15px 15px 15px;'>"
	data += "<div style='background: #1b1b2a; border-radius: 4px; padding: 12px;'>"
	data += "<div style='display: flex;'>"

	data += "<div style='flex: 1; padding-right: 10px;'>"
	data += "Number of followers: [psydon_followers] ([get_colored_influence_value(psydon_followers * 20)])<br>"
	data += "People wearing psycross: [GLOB.azure_round_stats[STATS_PSYCROSS_USERS]] ([get_colored_influence_value(GLOB.azure_round_stats[STATS_PSYCROSS_USERS] * 10)])<br>"
	data += "Number of confessions: [GLOB.confessors.len] ([get_colored_influence_value(GLOB.confessors.len * 20)])<br>"
	data += "Largest faith: [largest_religion ? "YES" : "NO"] ([get_colored_influence_value(largest_religion ? 500 : -250)])<br>"
	data += "Psydonite monarch: [psydonite_monarch ? "YES" : "NO"] ([get_colored_influence_value((psydonite_monarch ? (psydonite_monarch * 500) : -250))])<br>"
	data += "</div>"

	data += "<div style='flex: 1; padding-left: 60px;'>"
	data += "Number of apostates: [apostasy_followers] ([get_colored_influence_value(apostasy_followers * -20)])<br>"
	data += "Humen deaths: [GLOB.azure_round_stats[STATS_HUMEN_DEATHS]] ([get_colored_influence_value(GLOB.azure_round_stats[STATS_HUMEN_DEATHS] * -10)])<br>"
	data += "Largest faith: [largest_religion ? "YES" : "NO"] ([get_colored_influence_value(largest_religion ? 500 : -250)])<br>"
	data += "Lux harvested: [GLOB.azure_round_stats[STATS_LUX_HARVESTED]] ([get_colored_influence_value(GLOB.azure_round_stats[STATS_LUX_HARVESTED] * -50)])<br>"
	data += "God's status: [psydonite_user ? "ALIVE" : "DEAD"] ([get_colored_influence_value(psydonite_user ? 10000 : -10000)])<br>"
	data += "</div>"

	data += "</div>"

	data += "<div style='border-top: 1px solid #444; margin: 12px 0 8px 0;'></div>"
	data += "<div style='text-align: center;'>Total Influence: [get_colored_influence_value(psydon_influence)]</div>"
	data += "</div></div></div>"

	// The Ten Section

	data += "<div style='text-align: center; font-size: 1.3em; color: #c0a828; margin: 20px 0 10px 0;'><b>THE TEN</b></div>"
	data += "<div style='border-top: 3px solid #404040; margin: 0 auto 30px; width: 91.5%;'></div>"

	data += "<div style='width: 91.5%; margin: 0 auto 40px;'>"
	data += "<div style='display: grid; grid-template-columns: repeat(5, 1fr); gap: 20px; margin-bottom: 30px;'>"

	// Astrata
	data += god_ui_block("ASTRATA", "#e7a962", "#642705", /datum/storyteller/astrata, debug)

	// Dendor
	data += god_ui_block("DENDOR", "#412938", "#66745c", /datum/storyteller/dendor, debug)

	// Ravox
	data += god_ui_block("RAVOX", "#2c232d", "#710f0f", /datum/storyteller/ravox, debug)

	// Eora
	data += god_ui_block("EORA", "#a95063", "#e7c3da", /datum/storyteller/eora, debug)

	// Necra
	data += god_ui_block("NECRA", "#2a2459", "#4c82a8", /datum/storyteller/necra, debug)

	data += "</div>"

	data += "<div style='display: grid; grid-template-columns: repeat(5, 1fr); gap: 20px;'>"

	// Noc
	data += god_ui_block("NOC", "#4e72a1", "#282137", /datum/storyteller/noc, debug)

	// Abyssor
	data += god_ui_block("ABYSSOR", "#50090f", "#bbace0", /datum/storyteller/abyssor, debug)

	// Malum
	data += god_ui_block("MALUM", "#3d4139", "#955454", /datum/storyteller/malum, debug)

	// Xylix
	data += god_ui_block("XYLIX", "#7e632c", "#f6feff", /datum/storyteller/xylix, debug)

	// Pestra
	data += god_ui_block("PESTRA", "#517b27", "#1b2a2a", /datum/storyteller/pestra, debug)

	data += "</div></div>"

	// Inhumen Gods Section

	data += "<div style='text-align: center; font-size: 1.3em; color: #AA0000; margin: 20px 0 10px 0;'><b>INHUMEN GODS</b></div>"
	data += "<div style='border-top: 3px solid #404040; margin: 0 auto 30px; width: 91.5%;'></div>"

	data += "<div style='width: 91.5%; margin: 0 auto;'>"
	data += "<div style='display: grid; grid-template-columns: repeat(4, 1fr); grid-auto-rows: 1fr; gap: 20px; margin-bottom: 20px;'>"

	// Matthios
	data += god_ui_block("MATTHIOS", "#20202e", "#99b2b1", /datum/storyteller/matthios, debug)

	// Baotha
	data += god_ui_block("BAOTHA", "#46254a", "#e2abee", /datum/storyteller/baotha, debug)

	// Graggar
	data += god_ui_block("GRAGGAR", "#3b5e51", "#99bbc7", /datum/storyteller/graggar, debug)

	// Zizo
	data += god_ui_block("ZIZO", "#661239", "#ed9da3", /datum/storyteller/zizo, debug)

	data += "</div></div>"

	src.mob << browse(null, "window=vanderlin_stats")
	var/datum/browser/popup = new(src.mob, "vanderlin_influences", "<center>Gods influences</center>", 1325, 875)
	popup.set_content(data.Join())
	popup.open()

/// UI block to format information about storyteller god and his influences
/proc/god_ui_block(name, bg_color, title_color, datum/storyteller/storyteller, debug = FALSE)
	var/total_influence = SSgamemode.calculate_storyteller_influence(storyteller)
	var/datum/storyteller/initialized_storyteller = SSgamemode.storytellers[storyteller]
	if(!initialized_storyteller)
		return

	var/dynamic_content = ""
	var/followers = GLOB.patron_follower_counts[initialized_storyteller.name] || 0

	if(!debug)
		dynamic_content += "Number of followers: [followers] ([get_colored_influence_value(SSgamemode.get_follower_influence(storyteller))])<br>"
		for(var/stat in initialized_storyteller.influence_factors)
			var/list/stat_data = initialized_storyteller.influence_factors[stat]
			var/stat_value = GLOB.azure_round_stats[stat] || 0

			dynamic_content += "[stat_data["name"]] [round(stat_value)] ([get_colored_influence_value(SSgamemode.calculate_specific_influence(storyteller, stat))])<br>"
	else
		dynamic_content += "<div style='color: #FFFF00;'><b>DEBUG MODE</b></div>"
		dynamic_content += "Total reigns: [initialized_storyteller.times_chosen]<br>"
		dynamic_content += "Number of followers: [followers] ([get_colored_influence_value(SSgamemode.get_follower_influence(storyteller))])<br>"

		var/datum/storyteller/prototype = new storyteller
		for(var/set_name in prototype.influence_sets)
			var/list/current_set = prototype.influence_sets[set_name]
			for(var/stat in current_set)
				var/list/stat_data = current_set[stat]
				var/stat_value = GLOB.azure_round_stats[stat] || 0
				var/influence_value = stat_value * stat_data["points"]
				var/is_active = (stat in initialized_storyteller.influence_factors)

				dynamic_content += "<span style='color: [is_active ? "#88f088" : "#f79090"];'>"
				dynamic_content += "[stat_data["name"]] [round(stat_value)] ([get_colored_influence_value(influence_value)])</span><br>"
		qdel(prototype)

	var/suffix = initialized_storyteller.bonus_points >= 0 ? "from wanting to rule" : "from long reign exhaustion"
	var/bonus_display = "<div>([get_colored_influence_value(round(initialized_storyteller.bonus_points))] [suffix])</div>"

	return {"
	<div style='border:6px solid [bg_color]; background:[bg_color]; border-radius:6px; height:100%';>
		<div style='font-weight:bold; font-size:1.2em; padding:8px; color:[title_color]'>[name]</div>
		<div style='padding:8px; background:#111; border-radius:0 0 4px 4px;'>
			<div style='margin-bottom:8px;'>[dynamic_content]</div>
			<div style='border-top:1px solid #444; padding-top:6px;'>
				<div>Total Influence: [get_colored_influence_value(total_influence)]</div>
				[bonus_display]
			</div>
		</div>
	</div>
	"}

/// Colors resulting number depending on its value, with the operator attached
/proc/get_colored_influence_value(num)
	var/color
	var/display_num
	if(num > 0)
		color = "#00ff00"
		display_num = "+[round(num, 0.1)]"
	else if(num < 0)
		color = "#ff0000"
		display_num = "[round(num, 0.1)]"
	else
		color = "#ffff00"
		display_num = "+0"
	return "<font color='[color]'>[display_num]</font>"

/// Global proc to show debug version of gods influences
/client/proc/debug_influences()
	set name = "Debug Gods' Influences"
	set category = "Debug"

	show_influences()
