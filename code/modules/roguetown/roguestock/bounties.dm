/datum/roguestock/bounty/treasure
	name = "Collectable Treasures"
	desc = "Treasures are minted for 80% of its value, which is deposited into the treasury\
	Weapons, ores and clothings are excluded.\
	Any item worth more than 30 mammons is accepted,\
	and statues, cups, rings, platters, and candlesticks are always accepted\
	regardless of value."
	item_type = /obj/item
	payout_price = 10
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
	- Weapons, Ore and Clothing are always not accepted as a lot of them are
	  key items. 
	- Statue, cups, ring, platter and candlesticks will always be allowed
	- Otherwise, anything above 30 value can get eaten. 
*/
/datum/roguestock/bounty/treasure/check_item(obj/item/I)
	if(!I)
		return
	if(istype(I, /obj/item/rogueweapon))
		return FALSE
	if(istype(I, /obj/item/rogueore))
		return FALSE
	if(I.get_real_price() > 0)
		if(istype(I, /obj/item/roguestatue))
			return TRUE
		if(istype(I, /obj/item/reagent_containers/glass/cup))
			return TRUE
		if(istype(I, /obj/item/roguegem))
			return TRUE
		if(istype(I, /obj/item/clothing/ring))
			return TRUE
		if(istype(I, /obj/item/cooking/platter))
			return TRUE
		if(istype(I, /obj/item/candle/candlestick))
			return TRUE
	// Gotta put it here so that ring go later lol
	if(istype(I, /obj/item/clothing))
		return FALSE
	if(I.get_real_price() >= 30)
		return TRUE
