////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////
/*
	a treaty's "first party" and "second party" are just flavor. it's possible that none of the listed terms could apply to either of them




*/





//////////// TERMS
/datum/treaty/terms
	var/name
	var/desc
	var/target	 				// who suffers from the exchange
	var/authorities				// if a character's listed on a term as an authority, their signature is required. only one signature is required per term
	var/hint					// when someone without Law Expert examines a treaty, they'll only get a vague idea about the terms involved
	var/warbandlock 			// certain terms can only be demanded by certain warbands
	var/signed = FALSE			// if a term has been signed




//////////// CATEGORY: LAW
//////////////////////////
/datum/treaty/terms/codify_law
	name = "Codify Law"
	authorities = list("Grand Duke", "Hand", "Marshal")
	desc = "A codified law cannot be removed."
	hint = "...something about codifying a law..."

/datum/treaty/terms/remove_law
	name = "Abolish Law"
	authorities = list("Grand Duke", "Hand", "Marshal")
	desc = ""
	hint = "...something about abolishing a law..."

//////////// CATEGORY: TAX
//////////////////////////
/datum/treaty/terms/set_tax/noble
	name = "Adjust Noble Tax"
	desc = "A tax rate established here shall remain for yils."
	authorities = "Grand Duke"
	hint = "...something about taxes and the Nobility..."

/datum/treaty/terms/set_tax/yeoman
	name = "Adjust Yeoman Tax"
	desc = "A tax rate established here shall remain for yils."
	authorities = "Grand Duke"
	hint = "...something about Yeomen and taxes..."

/datum/treaty/terms/set_tax/peasant
	name = "Adjust Peasantry Tax"
	desc = "A tax rate established here shall remain for yils."
	authorities = "Grand Duke"
	hint = "...something about the peasantry's tax rate..."

/datum/treaty/terms/set_tax/church
	name = "Adjust Church Tax"
	desc = "A tax rate established here shall remain for yils."
	authorities = "Grand Duke"
	hint = "...something about taxes and the Church..."

//////////// CATEGORY: COIN & TERRITORY
///////////////////////////////////////
/datum/treaty/terms/territory_loss
	name = "Cede Territory"
	desc = "Cede an entire territory"

	hint = "...something about ceding some territory."
	// authorities = target

/datum/treaty/terms/cointribute
	name = "Mammon"
	desc = "An individual's coin is taken from their MEISTER. A territory's coin is taken from its vault. Territories may promise an excess \
	of the coin beyond what they truly possess, at penalty of debt."
	hint = "...there's a few details about an exchange of mammon..."

//////////// CATEGORY: MISC
///////////////////////////
/datum/treaty/terms/exile
	name = "Exile"
	authorities = "target"
	desc = "Should daelight find the Exile within the city limits, they'll be lit ablaze."
	hint = "...something regarding someone's exile..."



/datum/treaty/terms/unique/wizard
	name = "Acknowledge Superior Wizard"
	desc = "Admit the arcane superiority of the SORCERER-KING, henceforth and forever."
	warbandlock = /datum/warbands/storyteller/wizard
	authorities = "Court Wizard"
	hint = "...every other sentence is about how magnificent some wizard is.."


/datum/treaty/terms/freeform
	name = "Freeform"
	desc = ""
	hint = "...one I truly can't make heads or tails of..."

//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////


/obj/item/treaty
	name = "treaty"
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "scroll_closed"
	screen_loc = "7.3,8"


	var/finished = FALSE						// when all terms on a treaty are signed, the treaty is considered finished. adding a new term will revert this
	var/firstparty								// the first party in the treaty
	var/secondparty								// the second party in the treaty
												// both the first & second party are purely favor and have no real bearing on the terms
	var/list/terms
	var/occupied								// an occupied scroll can't be modified



/obj/item/treaty/Initialize()
	..()
	// for(var/territory_type in fiefs)
	// 	var/datum/territory/added_territory = new territory_type() 
	// 	src.warbands += added_territory


/obj/item/treaty/attack_self(mob/user)
	src.ui_interact(user)

/obj/item/treaty/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/treaty_icons)
	)


/obj/item/treaty/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TreatyMenu")
		ui.open()

/obj/item/treaty/ui_data(mob/user)
	var/list/data = ..()
	var/user_role = user.job
	var/list/known_people_list = user.mind?.known_people

	data["user_role"] = user_role


	for(var/name in known_people_list)
		var/list/person = known_people_list[name]
		UNTYPED_LIST_ADD(known_people_list, list(
			"name" = name,
			"job" = person["FJOB"],
		))
	data["backend_knownpeople"] = known_people_list



	return data


/obj/item/treaty/ui_static_data(mob/user)
	var/list/data = ..()

	var/list/land_list = list()
	var/list/faction_list = list()
	var/datum/asset/spritesheet/spritesheet = get_asset_datum(/datum/asset/spritesheet/treaty_icons)

	for(var/datum/territory/land in SSwarbands.fiefs)
		UNTYPED_LIST_ADD(land_list, list(
			"name" = land.name,
			"desc" = land.desc,
			"vault" = land.vault,
			"prized_good" = land.vault,
			"authorities" = land.job_owner,
			"type" = land.type

		))
	data["backend_territories"] = land_list

	for(var/datum/territory_faction/faction in SSwarbands.territory_factions)
		UNTYPED_LIST_ADD(faction_list, list(
			"name" = faction.name,
			"desc" = faction.desc,
			"vault" = faction.territories,
			"owner" = faction.owner,
			"type" = faction.type,
			"icon" = spritesheet.icon_class_name(sanitize_css_class_name("factionicon_[REF(faction)]"))			
		))
	data["backend_factions"] = faction_list

	return data



///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////// TREATY SUBMISSION
/*
	every term loaded onto a treaty takes effect

*/
/obj/item/treaty/proc/treaty_submission()
	if(!finished)
		return
