// Get the display names of the underlying TGUI themes
/datum/preferences/proc/get_tgui_theme_display_name()
    var/static/list/theme_names = list(
        "azure_default" = "Ascendant",
        "azure_green" = "Undivided",
		"azure_lane" = "Azuria",
		// "azure_gold" = "Lirvas",
		"azure_purple" = "Raneshen",
		// "azure_gilbranze" = "Gilbranze", - Coming soon :tm:
		"trey_liam" = "Trey Liam"
    )
    return theme_names[tgui_theme] || tgui_theme

// Cycle through TGUI styles
/datum/preferences/proc/setTguiStyle(mob/user)
    var/static/list/styles = list("azure_default", "azure_green", "azure_lane", "azure_purple", "trey_liam")
    var/current_index = styles.Find(tgui_theme)
    if(!current_index)
        current_index = 1
    var/next_index = (current_index % styles.len) + 1
    tgui_theme = styles[next_index]
    to_chat(usr, "<span class='notice'>TGUI style set to [get_tgui_theme_display_name()].</span>")
    save_preferences()
	