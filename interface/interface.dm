//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
/client/verb/tgwiki(query as text)
	set name = "tgwiki"
	set desc = "Type what you want to know about.  This will open the wiki in your web browser. Type nothing to go to the main page."
	set hidden = 1
	SEND_SOUND(usr, sound('sound/machines/button4.ogg', repeat = 0, wait = 0, volume = 100, channel = 512))
	var/wikiurltg = CONFIG_GET(string/wikiurltg)
	if(wikiurltg)
		if(query)
			var/output = wikiurltg + "?search=" + query
			src << link(output)
			output = wikiurltg + "/index.php?title=Special%3ASearch&profile=default&search=" + query
			src << link(output)
		else if (query != null)
			src << link(wikiurltg)
	else
		to_chat(src, span_danger("The wiki URL is not set in the server configuration."))
	return

/client/verb/discord()
	set name = "discord"
	set desc = "Visit the Discord."
	set hidden = 1
	SEND_SOUND(usr, sound('sound/machines/button4.ogg', repeat = 0, wait = 0, volume = 100, channel = 512))
	var/discordurl = CONFIG_GET(string/discordurl)
	if(discordurl)
		if(alert("This will open the Discord in your browser. Are you sure?",,"Yes","No")!="Yes")
			return
		src << link(discordurl)
	else
		to_chat(src, span_danger("The discord URL is not set in the server configuration."))
	return

/client/verb/github()
	set name = "github"
	set desc = "Visit Github"
	set hidden = 1
	SEND_SOUND(usr, sound('sound/machines/button4.ogg', repeat = 0, wait = 0, volume = 100, channel = 512))
	var/githuburl = CONFIG_GET(string/githuburl) 
	if(githuburl)
		if(alert("This will open the Github repository in your browser. Are you sure?",,"Yes","No")!="Yes")
			return
		src << link(githuburl)
	else
		to_chat(src, span_danger("The Github URL is not set in the server configuration."))
	return

/client/verb/reportissue()
	set name = "report-issue"
	set desc = "Report an issue"
	set hidden = 1
	SEND_SOUND(usr, sound('sound/machines/button4.ogg', repeat = 0, wait = 0, volume = 100, channel = 512))
	var/githuburl = CONFIG_GET(string/githuburl)
	if(githuburl)
		var/message = "This will open the Github issue reporter in your browser. Are you sure?"
		if(GLOB.revdata.testmerge.len)
			message += "<br>The following experimental changes are active and are probably the cause of any new or sudden issues you may experience. If possible, please try to find a specific thread for your issue instead of posting to the general issue tracker:<br>"
			message += GLOB.revdata.GetTestMergeInfo(FALSE)
		if(tgalert(src, message, "Report Issue","Yes","No")!="Yes")
			return
		var/static/issue_template = file2text(".github/ISSUE_TEMPLATE.md")
		var/servername = CONFIG_GET(string/servername)
		var/url_params = "Reporting client version: [byond_version].[byond_build]\n\n[issue_template]"
		if(GLOB.round_id || servername)
			url_params = "Issue reported from [GLOB.round_id ? " Round ID: [GLOB.round_id][servername ? " ([servername])" : ""]" : servername]\n\n[url_params]"
		DIRECT_OUTPUT(src, link("[githuburl]/issues/new?body=[url_encode(url_params)]"))
	else
		to_chat(src, span_danger("The Github URL is not set in the server configuration."))
	return

/client/verb/changelog()
	set name = "Changelog"
	set category = "OOC"
	if(!GLOB.changelog_tgui)
		GLOB.changelog_tgui = new /datum/changelog()

	GLOB.changelog_tgui.ui_interact(mob)
	if(prefs.lastchangelog != GLOB.changelog_hash)
		prefs.lastchangelog = GLOB.changelog_hash
		prefs.save_preferences()
		winset(src, "infowindow.changelog", "font-style=;")

///////////////////
// Coyote Buttons//
///////////////////

/client/verb/powerbutton()
	set name = "Powerbutton"
	set desc = "Closes the char gen window"
	set hidden = 1// This hides the actual verb from the verb menu so you can just trigger this when you click a button)
	SEND_SOUND(usr, sound('sound/machines/button4.ogg', repeat = 0, wait = 0, volume = 100, channel = 512))
	sleep(1)
	src << browse(null, "window=preferences_window")

/client/verb/setoocstatus()
	set name = "setoocstatus"
	set desc = "Closes the char gen window"
	set hidden = 1// This hides the actual verb from the verb menu so you can just trigger this when you click a button)
	SEND_SOUND(usr, sound('sound/machines/button4.ogg', repeat = 0, wait = 0, volume = 100, channel = 512))
	var/client/C = src
	var/mob/M = C.mob
	if(!M) // if they aren't a mob, stop the function, before shit breaks.
		return
	M.SetStatusMsg() // Call the verb for them <3
