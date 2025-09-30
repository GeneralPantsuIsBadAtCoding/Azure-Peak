/**
 * UI holder for interacting wtih SStreasury's tax values
 */

/// Since duke/steward have different announcements
/datum/taxsetter/var/announcement_text = "The Generous Lord Decrees"

/datum/taxsetter/New(announcement_text = null)
	. = ..()
	if(announcement_text)
		src.announcement_text = announcement_text

/datum/taxsetter/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TaxSetter", "Set Taxes")
		ui.open()

/datum/taxsetter/ui_static_data(mob/user)
	var/list/data = list("taxCategories")
	for(var/category in SStreasury.taxation_cat_settings)
		var/list/cat = list(
			"categoryName" = category,
			"taxAmount" = SStreasury.taxation_cat_settings[category]["taxAmount"],
			"fineExemption" = SStreasury.taxation_cat_settings[category]["fineExemption"],
		)
		data["taxCategories"] += list(cat)
	return data

/datum/taxsetter/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return TRUE

	switch(action)
		if("set_taxes")
			SStreasury.set_taxes(
				params["taxationCats"],
				announcement_text
			)

/datum/taxsetter/ui_state(mob/user)
	return GLOB.conscious_state
