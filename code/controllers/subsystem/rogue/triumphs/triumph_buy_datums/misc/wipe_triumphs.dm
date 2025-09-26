/datum/triumph_buy/wipe_triumphs
	triumph_buy_id = "WipeTriumphs"
	desc = "Burn down the hall of triumphs! Bring everyone back to ZERO!"
	triumph_cost = 180
	triumph_buy_id = TRIUMPH_BUY_WIPE_TRIUMPHS
	category = TRIUMPH_CAT_MISC
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

// We fire this on activate
/datum/triumph_buy/wipe_triumphs/on_activate()
	SStriumphs.wipe_all_triumphs(ckey_of_buyer) // ha haha .... woops guys
	to_chat(world, span_redtext("[ckey_of_buyer] burns the hall of triumphs to the ground!"))
