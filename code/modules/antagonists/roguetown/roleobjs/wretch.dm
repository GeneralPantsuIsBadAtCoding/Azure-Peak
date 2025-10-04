/datum/antagonist/wretch
	name = "Wretch"
	roundend_category = "wretches"
	antagpanel_category = "Wretches"
	show_name_in_check_antagonists = FALSE

/datum/antagonist/wretch/on_gain()
	. = ..()
	if(owner)
		owner.special_role = "Wretch"

/datum/antagonist/wretch/on_removal()
	. = ..()
	if(owner)
		owner.special_role = null