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

/datum/taxsetter/ui_data(mob/user)
	var/list/data = list(
		"nobleTax" = SStreasury.noble_tax_value,
		"nobleFine" = SStreasury.noble_fine_exemption,
		"churchTax" = SStreasury.church_tax_value,
		"churchFine" = SStreasury.church_fine_exemption,
		"yeomenTax" = SStreasury.yeomen_tax_value,
		"yeomenFine" = SStreasury.yeomen_fine_exemption,
		"peasantTax" = SStreasury.peasant_tax_value,
		"peasantFine" = SStreasury.peasant_fine_exemption,
	)
	return data

/datum/taxsetter/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return TRUE

	switch(action)
		if("set_taxes")
			SStreasury.set_taxes(
				params["nobleTax"],
				params["nobleFine"],
				params["yeomenTax"],
				params["yeomenFine"],
				params["churchTax"],
				params["churchFine"],
				params["peasantTax"],
				params["peasantFine"],
				announcement_text
			)

/datum/taxsetter/ui_state(mob/user)
	return GLOB.conscious_state
