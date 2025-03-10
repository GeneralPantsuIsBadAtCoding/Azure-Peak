#define UPGRADE_NOTAX		(1<<0)
#define UPGRADE_DRUGS   (1<<1)

/obj/structure/roguemachine/bathvend
	name = "BRASSFACE"
	desc = "Sweet, sweet, addiction. Love in the veins, comfort in my heart."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "streetvendor1"
	density = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	var/list/held_items = list()
	var/locked = FALSE
	var/budget = 0
	var/upgrade_flags
	var/current_cat = "1"
	var/lockid = "nightman"

/obj/structure/roguemachine/bathvend/Initialize()
	. = ..()
	update_icon()

/obj/structure/roguemachine/bathvend/update_icon()
	cut_overlays()
	if(obj_broken)
		set_light(0)
		return
	set_light(1, 1, 1, l_color = "#1b7bf1")
	add_overlay(mutable_appearance(icon, "vendor-merch"))


/obj/structure/roguemachine/bathvend/attackby(obj/item/P, mob/user, params)
	if(istype(P, /obj/item/roguekey))
		var/obj/item/roguekey/K = P
		if(K.lockid == lockid)
			locked = !locked
			playsound(loc, 'sound/misc/gold_misc.ogg', 100, FALSE, -1)
			update_icon()
			return attack_hand(user)
		else
			to_chat(user, span_warning("Wrong key."))
			return
	if(istype(P, /obj/item/storage/keyring))
		var/obj/item/storage/keyring/K = P
		for(var/obj/item/roguekey/KE in K.keys)
			if(KE.lockid == lockid)
				locked = !locked
				playsound(loc, 'sound/misc/gold_misc.ogg', 100, FALSE, -1)
				update_icon()
				return attack_hand(user)
	if(istype(P, /obj/item/roguecoin))
		budget += P.get_real_price()
		qdel(P)
		update_icon()
		playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)
		return attack_hand(user)
	..()

/obj/structure/roguemachine/bathvend/Topic(href, href_list)
	. = ..()
	if(!ishuman(usr))
		return
	if(!usr.canUseTopic(src, BE_CLOSE) || locked)
		return
	if(href_list["buy"])
		var/mob/M = usr
		var/path = text2path(href_list["buy"])
		if(!ispath(path, /datum/supply_pack))
			message_admins("silly MOTHERFUCKER [usr.key] IS TRYING TO BUY A [path] WITH THE BRASSFACE")
			return
		var/datum/supply_pack/PA = SSmerchant.supply_packs[path]
		var/cost = PA.cost
		var/tax_amt=round(SStreasury.tax_value * cost)
		cost=cost+tax_amt
		if(upgrade_flags & UPGRADE_NOTAX)
			cost = PA.cost
		if(budget >= cost)
			budget -= cost
			if(!(upgrade_flags & UPGRADE_NOTAX))
				SStreasury.give_money_treasury(tax_amt, "brassface import tax")
		else
			say("Not enough!")
			return
		var/shoplength = PA.contains.len
		var/l
		for(l=1,l<=shoplength,l++)
			var/pathi = pick(PA.contains)
			new pathi(get_turf(M))
	if(href_list["change"])
		if(budget > 0)
			budget2change(budget, usr)
			budget = 0
	if(href_list["changecat"])
		current_cat = href_list["changecat"]
	if(href_list["secrets"])
		var/list/options = list()
		if(upgrade_flags & UPGRADE_NOTAX)
			options += "Enable Paying Taxes"
		else
			options += "Stop Paying Taxes"
		if(!(upgrade_flags & UPGRADE_DRUGS))
			options += "Access Smuggler Lines (50)"
		var/select = input(usr, "Please select an option.", "", null) as null|anything in options
		if(!select)
			return
		if(!usr.canUseTopic(src, BE_CLOSE) || locked)
			return
		switch(select)
			if("Enable Paying Taxes")
				upgrade_flags &= ~UPGRADE_NOTAX
				playsound(loc, 'sound/misc/gold_misc.ogg', 100, FALSE, -1)
			if("Stop Paying Taxes")
				upgrade_flags |= UPGRADE_NOTAX
				playsound(loc, 'sound/misc/gold_misc.ogg', 100, FALSE, -1)
				playsound(loc, 'sound/misc/gold_license.ogg', 100, FALSE, -1)
			if("Access Smuggler Lines (50)")
				if(upgrade_flags & UPGRADE_DRUGS)
					return
				if(budget < 50)
					say("Ask again when you're serious.")
					playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
					return
				budget -= 50
				upgrade_flags |= UPGRADE_DRUGS
				playsound(loc, 'sound/misc/gold_license.ogg', 100, FALSE, -1)
	return attack_hand(usr)

/obj/structure/roguemachine/bathvend/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return
	if(locked)
		to_chat(user, span_warning("It's locked. Of course."))
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/gold_menu.ogg', 100, FALSE, -1)
	var/canread = user.can_read(src, TRUE)
	var/contents
	contents = "<center>BRASSFACE - Sweet Dreams for Cheap<BR>"
	contents += "<a href='?src=[REF(src)];change=1'>MAMMON LOADED:</a> [budget]<BR>"

	var/mob/living/carbon/human/H = user
	if(H.job in list("Bathmaster","Bathhouse Attendant"))
		if(canread)
			contents += "<a href='?src=[REF(src)];secrets=1'>Secrets</a>"
		else
			contents += "<a href='?src=[REF(src)];secrets=1'>[stars("Secrets")]</a>"

	contents += "</center><BR>"

	var/list/unlocked_cats = list("Alcohols","Bulk")
	if(upgrade_flags & UPGRADE_DRUGS)
		unlocked_cats+="Drugs"

	if(current_cat == "1")
		contents += "<center>"
		for(var/X in unlocked_cats)
			contents += "<a href='?src=[REF(src)];changecat=[X]'>[X]</a><BR>"
		contents += "</center>"
	else
		contents += "<center>[current_cat]<BR></center>"
		contents += "<center><a href='?src=[REF(src)];changecat=1'>\[RETURN\]</a><BR><BR></center>"
		var/list/pax = list()
		for(var/pack in SSmerchant.supply_packs)
			var/datum/supply_pack/PA = SSmerchant.supply_packs[pack]
			if(PA.group == current_cat)
				pax += PA
		for(var/datum/supply_pack/PA in sortList(pax))
			var/costy = PA.cost
			if(!(upgrade_flags & UPGRADE_NOTAX))
				costy=round(costy+(SStreasury.tax_value * costy))
			contents += "[PA.name] [PA.contains.len > 1?"x[PA.contains.len]":""] - ([costy])<a href='?src=[REF(src)];buy=[PA.type]'>BUY</a><BR>"

	if(!canread)
		contents = stars(contents)

	var/datum/browser/popup = new(user, "VENDORTHING", "", 370, 600)
	popup.set_content(contents)
	popup.open()

/obj/structure/roguemachine/bathvend/obj_break(damage_flag)
	..()
	budget2change(budget)
	set_light(0)
	update_icon()
	icon_state = "goldvendor0"

/obj/structure/roguemachine/bathvend/Destroy()
	set_light(0)
	return ..()

/obj/structure/roguemachine/bathvend/Initialize()
	. = ..()
	update_icon()
//	held_items[/obj/item/reagent_containers/glass/bottle/rogue/wine] = list("PRICE" = rand(23,33),"NAME" = "vino")
//	held_items[/obj/item/dmusicbox] = list("PRICE" = rand(444,777),"NAME" = "Music Box")

#undef UPGRADE_NOTAX

SUBSYSTEM_DEF(BMtreasury)
	name = "BMtreasury"
	wait = 1
	priority = FIRE_PRIORITY_WATER_LEVEL
	var/treasury_value = 0
	var/multiple_item_penalty = 0.66
	var/interest_rate = 0.30 // double the interest, since it's gonna be much harder for the BMaster to get valuables.
	var/next_treasury_check = 0
	var/list/vault_accounting = list()

/datum/controller/subsystem/BMtreasury/proc/add_to_vault(var/obj/item/I)
	if(I.get_real_price() <= 0 || istype(I, /obj/item/roguecoin))
		return
	if(!I.submitted_to_stockpile)
		I.submitted_to_stockpile = TRUE
	if(I.type in vault_accounting)
		vault_accounting[I.type] *= multiple_item_penalty
	else
		vault_accounting[I.type] = I.get_real_price()
	return (vault_accounting[I.type]*interest_rate)

/datum/controller/subsystem/BMtreasury/fire(resumed = 0)
	if(world.time > next_treasury_check)
		next_treasury_check = world.time + rand(5 MINUTES, 8 MINUTES)
		vault_accounting = list()
		var/area/A = GLOB.areas_by_type[/area/rogue/outdoors/exposed/bath/vault]
		var/amt_to_generate = 0
		for(var/obj/item/I in A)
			if(!isturf(I.loc))
				continue
			amt_to_generate += add_to_vault(I)
		for(var/obj/structure/closet/C in A)
			for(var/obj/item/I in C.contents)
				amt_to_generate += add_to_vault(I)
		amt_to_generate = round(amt_to_generate)
		for(var/obj/structure/roguemachine/bathvend/brassface)
			brassface.budget += amt_to_generate // goes directly into BRASSFACE rather than into any account.
		send_ooc_note("Income from smuggling hoard to the BRASSFACE: +[amt_to_generate]", job = list("Bathmaster"))
