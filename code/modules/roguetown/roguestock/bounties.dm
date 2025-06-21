/datum/roguestock/bounty/treasure
	name = "Collectable Treasures"
	desc = "Treasures are minted for 80% of its value, which is deposited into the treasury\
	Weapons, ores and clothings are excluded.\
	Any item worth more than 30 mammons is accepted,\
	and statues, cups, rings, platters, and candlesticks are always accepted\
	regardless of value."
	item_type = /obj
	payout_price = 70
	mint_item = TRUE
	percent_bounty = TRUE

/datum/roguestock/bounty/treasure/get_payout_price(obj/item/I)
	if(!I)
		return ..()
	var/bounty_percent = (payout_price/100) * I.get_real_price()
	bounty_percent = round(bounty_percent)
	if(bounty_percent < 1)
		return 0
	return bounty_percent

/* Non-Ideal but a way to replicate old vault mechanics:
	- Ore are not accepted
	- Items that are important are not accepted. 
	- Statue, cups, ring, platter and candles  will always be allowed
	- Otherwise, anything above 30 value can get eaten. 
*/
/datum/roguestock/bounty/treasure/check_item(obj/I)
	if(!I)
		return
	if(istype(I, /obj/item))
		var/obj/item/W = I
		if(W.is_important)
			return FALSE
	if(istype(I, /obj/item/rogueore))
		return FALSE
	if(istype(I, /obj/item/bodypart/head))
		return FALSE // Thats the HEADEATER's job
	if(istype(I, /obj/item/natural/head))
		return FALSE  // Thats the HEADEATER's job
	if(I.get_real_price() > 0)
		if(istype(I, /obj/item/roguestatue))
			return TRUE
		if(istype(I, /obj/item/reagent_containers/glass/cup))
			return TRUE
		if(istype(I, /obj/item/roguegem))
			return TRUE
		if(istype(I, /obj/item/cooking/platter))
			return TRUE
		if(istype(I, /obj/item/candle))
			return TRUE
	if(I.get_real_price() >= 30)
		return TRUE
