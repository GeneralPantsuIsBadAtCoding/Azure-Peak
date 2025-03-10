/datum/keybinding/admin
	category = CATEGORY_ADMIN
	weight = WEIGHT_ADMIN

/datum/keybinding/admin/admin_say
	hotkey_keys = list("F3")
	name = "admin_say"
	full_name = "Admin say"
	description = "Talk with other admins."

/datum/keybinding/admin/admin_say/down(client/user)
	user.get_admin_say()
	return TRUE

/datum/keybinding/admin/rmbcontext
	hotkey_keys = list("F4")
	name = "rmbcontext"
	full_name = "Admin RMB Context Toggle"
	description = "Toggles opening a context menu with RMB"

/datum/keybinding/admin/rmbcontext/down(client/user)
	user.set_context_menu_enabled()
	return TRUE

/datum/keybinding/admin/admin_ghost
	hotkey_keys = list("F5")
	name = "admin_ghost"
	full_name = "Aghost"
	description = "Go ghost"

/datum/keybinding/admin/admin_ghost/down(client/user)
	user.admin_ghost()
	return TRUE

/datum/keybinding/admin/player_panel_new
	hotkey_keys = list("F6")
	name = "player_panel_new"
	full_name = "Player Panel New"
	description = "Opens up the new player panel"

/datum/keybinding/admin/player_panel_new/down(client/user)
	if(!check_rights(R_ADMIN))
		to_chat(user, "<span class='warning'>You do not have permission to access the player panel.</span>")
		return
	user.holder.player_panel_new()
	return TRUE


/datum/keybinding/admin/toggle_buildmode_self
	hotkey_keys = list("F7")
	name = "toggle_buildmode_self"
	full_name = "Admin Buildmode"
	description = "Toggles Buildmode"

/datum/keybinding/admin/toggle_buildmode_self/down(client/user)
	user.togglebuildmodeself()
	return TRUE

/datum/keybinding/admin/stealthmode
	hotkey_keys = list("F8")
	name = "stealth_mode"
	full_name = "Admin Stealth mode"
	description = "Enters stealth mode (Players see you as 'Administrator' instead of your ckey)"

/datum/keybinding/admin/stealthmode/down(client/user)
	user.stealth()
	return TRUE

/* Irrelevant to RT
/datum/keybinding/admin/deadsay
	hotkey_keys = list("F9")
	name = "dsay"
	full_name = "deadsay"
	description = "Allows you to send a message to dead chat"

/datum/keybinding/admin/deadsay/down(client/user)
	user.get_dead_say()
	return TRUE


/datum/keybinding/admin/invisimin
	hotkey_keys = list("F10")
	name = "invisimin"
	full_name = "Admin invisibility"
	description = "Toggles ghost-like invisibility on your mob"

/datum/keybinding/admin/invisimin/down(client/user)
	user.invisimin()
	return TRUE
*/
