/obj/structure/roguemachine/potionseller
	name = "POTION SELLER"
	desc = "The stomach of this thing can been stuffed with fluids for you to buy."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "streetvendor1"
	density = TRUE
	blade_dulling = DULLING_BASH
	integrity_failure = 0.1
	max_integrity = 0
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	var/list/held_items = list()
	var/locked = TRUE
	var/budget = 0
	var/wgain = 0
	var/keycontrol = "merchant"
	var/obj/item/reagent_containers/glass/bottle/inserted

/obj/structure/roguemachine/potionseller/Initialize()
	. = ..()
	if(!reagents)
		create_reagents(200*3)
		reagents.flags |= NO_REACT
		reagents.flags &= ~OPENCONTAINER
	update_icon()

/obj/structure/roguemachine/potionseller/Destroy()
	if(reagents)
		qdel(reagents)
		reagents = null
	if(inserted)
		inserted.forceMove(drop_location())
	set_light(0)
	return ..()

/obj/structure/roguemachine/potionseller/proc/insert(obj/item/P, mob/living/user)
	if(!istype(P, /obj/item/reagent_containers/glass/bottle))
		to_chat(user, span_warning("Not a container."))
		return
	var/obj/item/reagent_containers/glass/bottle/B = P
	if(!B.reagents.total_volume)
		to_chat(user, span_warning("Nothing to add."))
		return
	if(reagents.maximum_volume < B.reagents.total_volume + reagents.total_volume)
		to_chat(user, span_warning("Machine is filled to the lid."))
		return
	testing("startadd")
	for(var/datum/reagent/to_add in B.reagents.reagent_list)
		var/already_exists = FALSE
		for(var/datum/reagent/existing in reagents.reagent_list)
			if(to_add == existing)
				already_exists = TRUE
				break
		if(!already_exists)
			held_items[to_add.type] = list()
			held_items[to_add.type]["NAME"] = to_add.name
			held_items[to_add.type]["PRICE"] = 0
		B.reagents.trans_to(src, B.reagents.total_volume, transfered_by = user)
		playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)
		return attack_hand(user)

/obj/structure/roguemachine/potionseller/attackby(obj/item/P, mob/user, params)
	if(istype(P, /obj/item/roguecoin/aalloy))
		return
	if(istype(P, /obj/item/roguecoin/inqcoin))	
		return
	if(istype(P, /obj/item/roguecoin))
		budget += P.get_real_price()
		qdel(P)
		update_icon()
		playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)
		return attack_hand(user)
	if(istype(P, /obj/item/roguekey))
		var/obj/item/roguekey/K = P
		if(K.lockid == keycontrol)
			locked = !locked
			playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
			update_icon()
			return attack_hand(user)
		else
			if(!locked)
				insert(P, user)
			else	
				to_chat(user, span_warning("Wrong key."))
				return
	if(istype(P, /obj/item/storage/keyring))
		var/obj/item/storage/keyring/K = P
		for(var/obj/item/roguekey/KE in K.keys)
			if(KE.lockid == keycontrol)
				locked = !locked
				playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
				update_icon()
				return attack_hand(user)
	if(!locked)
		insert(P, user)
	else if(inserted)
		to_chat(user, span_warning("Something is already inside!"))
	else if(istype(P, /obj/item/reagent_containers/glass/bottle))
		if(user.transferItemToLoc(P, src))
			inserted = P
			return attack_hand(user)
		to_chat(user, span_warning("[P] is stuck to your hand!"))
	..()

/obj/structure/roguemachine/potionseller/Topic(href, href_list)
	. = ..()
	if(href_list["buy"])
		var/datum/reagent/R = locate(href_list["buy"]) in held_items
		if(!R || !ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE) || !locked)
			return
		var/price = held_items[R.type]["PRICE"]
		if(!inserted)
			say(!price ? "INSERT A BOTTLE BEFORE 'YA TAKE" : "INSERT A BOTTLE BEFORE 'YA BUY")
			return
		if(price > budget)
			say(pick("NO MONEY NO HONEY!","OI, GET SOME DOSH OR +FUCK+ OFF!","DO SOME TEN O'CLOCK WORK AND COME BACK","EVERYBODY LAUGH AT YE POOR POCKETS"))
			return
		var/quantity = 0
		var/volume = reagents.get_reagent_amount(R)
		var/buyer_volume = inserted.reagents.maximum_volume
		var/vol_rounded = round(min(buyer_volume,volume) / 3, 0.1)
		if(volume < 3) // do not let user buy reagants less than 3 oz due to coin rounding
			return
		if(price > 0)
			quantity = input(usr, "How much to pour into \the [inserted] ([vol_rounded] oz)? ([price] mammons per oz)", "\The [held_items[R.type]["NAME"]]") as num|null
		else
			quantity = input(usr, "How much to pour into \the [inserted] ([vol_rounded] oz)?", "\The [held_items[R.type]["NAME"]]") as num|null
		quantity = round(quantity)
		if(quantity <= 0 || !usr.Adjacent(src))
			return
		quantity *= 3
		if(quantity > buyer_volume)
			quantity = buyer_volume
		if(quantity > volume)
			quantity = volume
		if(price > 0)
			price = round(price*(quantity/3))
			if(budget >= price)
				budget -= price
				wgain += price
			else
				say("NOT ENOUGH COINS")
				return
		record_round_statistic(STATS_PEDDLER_REVENUE, price)
		inserted.reagents.add_reagent(R.type, quantity)
		reagents.remove_reagent(R.type, quantity, FALSE)
		if(volume - quantity < 1)
			reagents.del_reagent(R.type)
			held_items -= R.type
			update_icon()
		playsound(loc, 'sound/misc/potionseller.ogg', 100, TRUE, -1)
	if(href_list["retrieve"])
		var/datum/reagent/R = locate(href_list["retrieve"]) in held_items
		if(!R || !ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE) || locked)
			return
		var/obj/item/reagent_containers/glass/bottle/alchemical/sold_bottle = new /obj/item/reagent_containers/glass/bottle/alchemical(get_turf(src))
		var/quantity = 0
		var/volume = reagents.get_reagent_amount(R)
		var/buyer_volume = sold_bottle.reagents.maximum_volume
		var/vol_rounded = round(min(buyer_volume,volume) / 3, 0.1)
		quantity = input(usr, "How much to pour into \the [sold_bottle] ([vol_rounded] oz)?", "\The [held_items[R.type]["NAME"]]") as num|null
		quantity = round(text2num(quantity))
		if(quantity <= 0 || !usr.Adjacent(src))
			return
		quantity *= 3
		if(quantity > buyer_volume)
			quantity = buyer_volume
		if(quantity > volume)
			quantity = volume
		sold_bottle.reagents.add_reagent(R.type, quantity)
		reagents.remove_reagent(R.type, quantity, FALSE)
		if(volume - quantity < 1)
			reagents.del_reagent(R.type)
			held_items -= R.type
			update_icon()
		if(!usr.put_in_hands(sold_bottle))
			sold_bottle.forceMove(get_turf(src))
		playsound(loc, 'sound/misc/potionseller.ogg', 100, TRUE, -1)
	if(href_list["change"])
		if(!usr.canUseTopic(src, BE_CLOSE) || !locked)
			return
		if(ishuman(usr))
			if(budget > 0)
				budget2change(budget, usr)
				budget = 0
	if(href_list["withdrawgain"])
		if(!usr.canUseTopic(src, BE_CLOSE) || locked)
			return
		if(ishuman(usr))
			if(wgain > 0)
				budget2change(wgain, usr)
				wgain = 0
	if(href_list["setname"])
		var/datum/reagent/R = locate(href_list["setname"]) in held_items
		if(!R || !usr.canUseTopic(src, BE_CLOSE) || locked)
			return
		if(ishuman(usr))
			var/prename
			if(held_items[R.type]["NAME"])
				prename = held_items[R.type]["NAME"]
			var/newname = input(usr, "SET A NEW NAME FOR THIS POTION", src, prename)
			if(newname)
				held_items[R.type]["NAME"] = newname
	if(href_list["setprice"])
		var/datum/reagent/R = locate(href_list["setprice"]) in held_items
		if(!R || !usr.canUseTopic(src, BE_CLOSE) || locked)
			return
		if(ishuman(usr))
			var/preprice
			if(held_items[R]["PRICE"])
				preprice = held_items[R]["PRICE"]
			var/newprice = input(usr, "SET A NEW PRICE FOR THIS POTION PER OZ (0 IS FREE)", src, preprice) as null|num
			if(newprice)
				if(newprice < 0)
					return attack_hand(usr)
				if(findtext(num2text(newprice), "."))
					return attack_hand(usr)
				held_items[R]["PRICE"] = newprice
			else if(text2num(newprice) == 0)
				held_items[R]["PRICE"] = 0 // free!
	if(href_list["eject"])
		if(!inserted)
			return
		inserted.forceMove(drop_location())
		inserted = null
	return attack_hand(usr)

/obj/structure/roguemachine/potionseller/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	var/canread = user.can_read(src, TRUE)
	var/contents
	if(canread)
		contents = "<center>POTION SELLER, FIRST ITERATION<BR>"
		if(!locked)
			contents += "UNLOCKED<HR>"
		else if(!inserted)
			contents += "No item inserted<HR>"
		else
			contents += "Item inserted: <a href='?src=[REF(src)];eject=1'>[inserted]</a> ([round(inserted.reagents.total_volume / 3, 0.1)]/[round(inserted.reagents.maximum_volume / 3, 0.1)] oz)<HR>"
		if(locked)
			contents += "<a href='?src=[REF(src)];change=1'>Stored Mammon:</a> [budget]<BR>"
		else
			contents += "<a href='?src=[REF(src)];withdrawgain=1'>Stored Profits:</a> [wgain]<BR>"
	else
		contents = "<center>[stars("POTION SELLER, FIRST ITERATION")]<BR>"
		if(!locked)
			contents += "[stars("UNLOCKED")]<HR>"
		else if(!inserted)
			contents += "[stars("No item inserted")]<HR>"
		else
			contents += "[stars("Item inserted")]: <a href='?src=[REF(src)];eject=1'>[inserted]</a> ([round(inserted.reagents.total_volume / 3, 0.1)]/[round(inserted.reagents.maximum_volume / 3, 0.1)] oz)<HR>"
		if(locked)
			contents += "<a href='?src=[REF(src)];change=1'>[stars("Stored Mammon:")]</a> [budget]<BR>"
		else
			contents += "<a href='?src=[REF(src)];withdrawgain=1'>[stars("Stored Profits:")]</a> [wgain]<BR>"

	contents += "</center>"

	for(var/I in held_items)
		var/price = held_items[I]["PRICE"]
		var/namer = held_items[I]["NAME"]
		var/volume = reagents.get_reagent_amount(I)
		volume = round(volume / 3, 0.1)
		if(volume < 1) // do not sell reagents less than 1 oz
			continue
		if(!namer)
			held_items[I]["NAME"] = "thing"
			namer = "thing"
		if(locked)
			var/buy = !price ? "TAKE" : "BUY"
			price = !price ? "FREE" : "[price] per oz"
			if(canread)
				contents += "[namer] ([volume] oz) - [price] <a href='?src=[REF(src)];buy=[REF(I)]'>[buy]</a>"
			else
				contents += "[stars(namer)] - [stars(price)] <a href='?src=[REF(src)];buy=[REF(I)]'>[stars("[buy]")]</a>"
		else
			if(canread)
				contents += "<a href='?src=[REF(src)];setname=[REF(I)]'>[namer]</a> ([volume] oz) - <a href='?src=[REF(src)];setprice=[REF(I)]'>[price] per oz</a> <a href='?src=[REF(src)];retrieve=[REF(I)]'>TAKE</a>"
			else
				contents += "<a href='?src=[REF(src)];setname=[REF(I)]'>[stars(namer)]</a> - <a href='?src=[REF(src)];setprice=[REF(I)]'>[stars(price)]</a> <a href='?src=[REF(src)];retrieve=[REF(I)]'>[stars("TAKE")]</a>"
		contents += "<BR>"

	var/datum/browser/popup = new(user, "VENDORTHING", "", 370, 300)
	popup.set_content(contents)
	popup.open()

/obj/structure/roguemachine/potionseller/obj_break(damage_flag)
	..()
	held_items = list()
	reagents.clear_reagents()
	budget2change(budget)
	set_light(0)
	update_icon()
	icon_state = "streetvendor0"

/obj/structure/roguemachine/potionseller/update_icon()
	cut_overlays()
	if(obj_broken)
		set_light(0)
		return
	if(!locked)
		icon_state = "streetvendor0"
		return
	else
		icon_state = "streetvendor1"
	if(held_items.len)
		set_light(1, 1, 1, l_color = "#1b7bf1")
		add_overlay(mutable_appearance(icon, "vendor-gen"))
