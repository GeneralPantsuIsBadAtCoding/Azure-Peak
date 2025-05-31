/obj/item/paper/scroll
	name = "papyrus"
	icon_state = "scroll"
	var/open = FALSE
	slot_flags = null
	dropshrink = 0.6
	firefuel = 30 SECONDS
	sellprice = 2
	textper = 108
	maxlen = 5000
	throw_range = 3


/obj/item/paper/scroll/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(!open)
			to_chat(user, span_warning("Open me."))
			return
	if(P.get_sharpness())
		to_chat(user, span_warning("[user] tears [src]."))
		new /obj/item/paper(get_turf(src))
		new /obj/item/paper(get_turf(src))
		qdel(src)
		return
	..()

/obj/item/paper/scroll/getonmobprop(tag)
	. = ..()
	if(tag)
		if(open)
			switch(tag)
				if("gen")
					return list("shrink" = 0.3,"sx" = 0,"sy" = -1,"nx" = 13,"ny" = -1,"wx" = 4,"wy" = 0,"ex" = 7,"ey" = -1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 2,"sflip" = 0,"wflip" = 0,"eflip" = 8)
				if("onbelt")
					return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
		else
			switch(tag)
				if("gen")
					return list("shrink" = 0.4,"sx" = 0,"sy" = 0,"nx" = 13,"ny" = 1,"wx" = 0,"wy" = 2,"ex" = 5,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 63,"wturn" = -27,"eturn" = 63,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
				if("onbelt")
					return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/paper/scroll/attack_self(mob/user)
	if(mailer)
		user.visible_message(span_notice("[user] opens the missive from [mailer]."))
		mailer = null
		mailedto = null
		update_icon()
		return
	if(!open)
		attack_right(user)
		return
	..()
	user.update_inv_hands()

/obj/item/paper/scroll/read(mob/user)
	if(!open)
		to_chat(user, span_info("Open me."))
		return
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		return
	/*font-size: 125%;*/
	if(in_range(user, src) || isobserver(user))
		user.hud_used.reads.icon_state = "scroll"
		user.hud_used.reads.show()
		var/dat = {"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">
			<html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"><style type=\"text/css\">
					body { background-image:url('book.png');background-repeat: repeat; }</style></head><body scroll=yes>"}
		dat += "[info]<br>"
		dat += "<a href='?src=[REF(src)];close=1' style='position:absolute;right:50px'>Close</a>"
		dat += "</body></html>"
		user << browse(dat, "window=reading;size=460x300;can_close=0;can_minimize=0;can_maximize=0;can_resize=0;titlebar=0")
		onclose(user, "reading", src)
	else
		return span_warning("I'm too far away to read it.")

/obj/item/paper/scroll/Initialize()
	open = FALSE
	update_icon_state()
	..()

/obj/item/paper/scroll/rmb_self(mob/user)
	attack_right(user)
	return

/obj/item/paper/scroll/attack_right(mob/user)
	if(open)
		slot_flags |= ITEM_SLOT_HIP
		open = FALSE
		playsound(src, 'sound/items/scroll_close.ogg', 100, FALSE)
	else
		slot_flags &= ~ITEM_SLOT_HIP
		open = TRUE
		playsound(src, 'sound/items/scroll_open.ogg', 100, FALSE)
	update_icon_state()
	user.update_inv_hands()

/obj/item/paper/scroll/update_icon_state()
	if(mailer)
		icon_state = "scroll_prep"
		open = FALSE
		name = "missive"
		slot_flags |= ITEM_SLOT_HIP
		throw_range = 7
		return
	throw_range = initial(throw_range)
	if(open)
		if(info)
			icon_state = "scrollwrite"
		else
			icon_state = "scroll"
		name = initial(name)
	else
		icon_state = "scroll_closed"
		name = "scroll"

//Fake reskin of a scroll for the dwarf mercs -- just a fluffy toy
/obj/item/paper/scroll/grudge
	name = "Book of Grudges"
	desc = "A copy you've taken with you. Unfortunately the dampness of Azuria made it unreadable. You can still add new entries, however. It looks bulky enough to act as a mild blunt weapon."
	icon_state ="grudge_closed"
	drop_sound = 'sound/foley/dropsound/book_drop.ogg'
	grid_width = 32
	grid_height = 32
	force = 10
	possible_item_intents = list(/datum/intent/mace/strike)

/obj/item/paper/scroll/grudge/update_icon_state()
	if(open)
		if(info)
			icon_state = "grudgewrite"
		else
			icon_state = "grudge"
	else
		icon_state = "grudge_closed"

/obj/item/paper/scroll/grudge/attack_right(mob/user)
	if(!open)
		slot_flags &= ~ITEM_SLOT_HIP
		open = TRUE
		playsound(loc, 'sound/items/book_open.ogg', 100, FALSE, -1)
	else
		slot_flags |= ITEM_SLOT_HIP
		open = FALSE
		playsound(loc, 'sound/items/book_close.ogg', 100, FALSE, -1)
	update_icon_state()
	user.update_inv_hands()


/obj/item/paper/scroll/cargo
	name = "shipping order"
	icon_state = "contractunsigned"
	var/signedname
	var/signedjob
	var/list/orders = list()
	open = TRUE
	textper = 150

/obj/item/paper/scroll/cargo/Destroy()
	for(var/datum/supply_pack/SO in orders)
		orders -= SO
	return ..()

/obj/item/paper/scroll/cargo/examine(mob/user)
	. = ..()
//	if(signedname)
//		. += "It was signed by [signedname] the [signedjob]."

	//for each order, add up total price and display orders

/obj/item/paper/scroll/cargo/update_icon_state()
	if(open)
		if(signedname)
			icon_state = "contractsigned"
		else
			icon_state = "contractunsigned"
		name = initial(name)
	else
		icon_state = "scroll_closed"
		name = "scroll"


/obj/item/paper/scroll/cargo/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(istype(P, /obj/item/natural/feather))
		if(user.is_literate() && open)
			if(signedname)
				to_chat(user, span_warning("[signedname]"))
				return
			switch(alert("Sign your name?",,"Yes","No"))
				if("Yes")
					if(user.mind && user.mind.assigned_role)
						if(do_after(user, 20, target = src))
							signedname = user.real_name
							signedjob = user.mind.assigned_role
							icon_state = "contractsigned"
							user.visible_message(span_notice("[user] signs the [src]."))
							update_icon_state()
							playsound(src, 'sound/items/write.ogg', 100, FALSE)
							rebuild_info()
				if("No")
					return

/obj/item/paper/scroll/cargo/proc/rebuild_info()
	info = null
	info += "<h2>Shipping Order</h2>"
	info += "<hr/>"

	if(orders.len)
		info += "Orders: <br/>"
		info += "<ul>"
		for(var/datum/supply_pack/A in orders)
			info += "<li>[A.name]</li><br/>"
		info += "</ul>"

	info += "<br/></font>"

	if(signedname)
		info += "SIGNED,<br/>"
		info += "<font face=\"[FOUNTAIN_PEN_FONT]\" color=#27293f>[signedname] the [signedjob] of Azure Peak</font>"

/obj/item/paper/confession
	name = "confession"
	icon_state = "confession"
	info = "THE GUILTY PARTY ADMITS THEIR SIN AND THE WEAKENING OF PSYDON'S HOLY FLOCK. THEY WILL REPENT AND SUBMIT TO ANY PUNISHMENT THE CLERGY DEEMS APPROPRIATE, OR BE RELEASED IMMEDIATELY. LET THIS RECORD OF THEIR SIN WEIGH ON THE ANGEL GABRIEL'S JUDGEMENT AT THE MANY-SPIKED GATES OF HEAVEN.<br/><br/>SIGNED,"
	var/signed = FALSE
	textper = 150

/obj/item/paper/confession/update_icon_state()
	if(mailer)
		icon_state = "paper_prep"
		name = "letter"
		throw_range = 7
		return
	name = initial(name)
	throw_range = initial(throw_range)
	if(signed)
		icon_state = "confessionsigned"
		return
	icon_state = "confession"

/obj/item/paper/confession/attack(mob/living/carbon/human/M, mob/user)
	if(signed)
		return ..()
	if(!M.get_bleed_rate())
		to_chat(user, span_warning("No. The sinner must be bleeding."))
		return
	if(!M.stat)
		to_chat(user, span_info("I courteously offer the confession to [M]."))
		if(alert(M, "Sign the confession with your blood?", "CONFESSION OF SIN", "Yes", "No") != "Yes")
			return
		if(M.stat)
			return
		if(signed)
			return
		if(M.has_flaw(/datum/charflaw/addiction/godfearing))
			M.add_stress(/datum/stressevent/confessedgood)
		else
			M.add_stress(/datum/stressevent/confessed)
		M.add_stress(/datum/stressevent/confessed)
		signed = M.real_name
		info = "THE GUILTY PARTY ADMITS THEIR SIN AND THE WEAKENING OF PSYDON'S HOLY FLOCK. THEY WILL REPENT AND SUBMIT TO ANY PUNISHMENT THE CLERGY DEEMS APPROPRIATE, OR BE RELEASED IMMEDIATELY. LET THIS RECORD OF THEIR SIN WEIGH ON THE ANGEL GABRIEL'S JUDGEMENT AT THE MANY-SPIKED GATES OF HEAVEN.<br/><br/>SIGNED,<br/><font color='red'>[signed]</font>"

/obj/item/paper/scroll/sell_price_changes
	name = "updated purchasing prices"
	icon_state = "contractsigned"

	var/list/sell_prices
	var/writers_name
	var/faction

/obj/item/paper/scroll/sell_price_changes/New(loc, list/prices, faction_name)
	. = ..()

	faction = faction_name
	if(!faction)
		faction = pick("Heartfelt", "Hammerhold", "Grenzelhoft", "Kingsfield")		//add more as time goes, idk

	sell_prices = prices
	if(!length(sell_prices))
		sell_prices = generated_test_data()
	writers_name = pick( world.file2list("strings/rt/names/human/humnorm.txt") )
	rebuild_info()

/obj/item/paper/scroll/sell_price_changes/update_icon_state()
	if(open)
		icon_state = "contractsigned"
		name = initial(name)
	else
		icon_state = "scroll_closed"
		name = "scroll"


/obj/item/paper/scroll/sell_price_changes/proc/rebuild_info()
	info = null
	info += "<div style='vertical-align:top'>"
	info += "<h2 style='color:#06080F;font-family:\"Segoe Script\"'>Purchasing Prices</h2>"
	info += "<hr/>"

	if(sell_prices.len)
		info += "<ul>"
		for(var/atom/type_path as anything in sell_prices)
			var/list/prices = sell_prices[type_path]
			info += "<li style='color:#06080F;font-size:9px;font-family:\"Segoe Script\"'>[initial(type_path.name)] [prices[1]] > [prices[2]] mammons</li><br/>"
		info += "</ul>"

	info += "<br/></font>"

	info += "<font size=\"2\" face=\"[FOUNTAIN_PEN_FONT]\" color=#27293f>[writers_name] Shipwright of [faction]</font>"

	info += "</div>"

/obj/item/paper/scroll/sell_price_changes/proc/generated_test_data()

	var/list/prices = list()
	for(var/i = 1 to rand(2, 4))
		var/datum/supply_pack/pack = pick(SSmerchant.supply_packs)
		if(islist(pack.contains))
			continue
		var/path = pack.contains
		if(!path)
			continue
		prices |= path
		var/starting_rand  = rand(100, 50)
		prices[path] = list("[starting_rand]", "[round(starting_rand * 0.5, 1)]")
	sell_prices = prices
