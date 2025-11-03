/**
 * UI holder for interacting wtih SStreasury's tax values
 */

/// Since duke/steward have different announcements
/datum/taxsetter/var/good_announcement_text = "The Generous Lord Decrees"
/datum/taxsetter/var/bad_announcement_text = "The Tyrannical Lord Dictates"

/datum/taxsetter/New(good_announcement_text = null, bad_announcement_text = null)
	. = ..()
	if(good_announcement_text)
		src.good_announcement_text = good_announcement_text
	if(bad_announcement_text)
		src.bad_announcement_text = bad_announcement_text

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
				good_announcement_text,
				bad_announcement_text
			)

/datum/taxsetter/ui_state(mob/user)
	return GLOB.conscious_state
