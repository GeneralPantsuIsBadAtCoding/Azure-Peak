/obj/structure/roguemachine/mail
	name = "HERMES"
	desc = "Carrier zads have fallen severely out of fashion ever since the advent of this hydropneumatic mail system."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "mail"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32
	var/coin_loaded = FALSE
	var/ournum
	var/mailtag
	var/obfuscated = FALSE

/obj/structure/roguemachine/mail/attack_hand(mob/user)
	if(SSroguemachine.hermailermaster && ishuman(user))
		var/obj/item/roguemachine/mastermail/M = SSroguemachine.hermailermaster
		var/mob/living/carbon/human/H = user
		var/addl_mail = FALSE
		for(var/obj/item/I in M.contents)
			if(I.mailedto == H.real_name)
				if(!addl_mail)
					I.forceMove(src.loc)
					user.put_in_hands(I)
					addl_mail = TRUE
				else
					say("You have additional mail available.")
					break
		if(!any_additional_mail(M, H.real_name))
			H.remove_status_effect(/datum/status_effect/ugotmail)

/obj/structure/roguemachine/mail/examine()
	. = ..()
	. += span_info("Load a coin inside, then right click to send a letter.")
	. += span_info("Left click with a piece of confession or paper to send a prewritten letter for free.")

/obj/structure/roguemachine/mail/attack_right(mob/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	if(!coin_loaded)
		to_chat(user, span_warning("The machine doesn't respond. It needs a coin."))
		return
	var/send2place = input(user, "Where to? (Person or #number)", "ROGUETOWN", null)
	if(!send2place)
		return
	var/sentfrom = input(user, "Who is this letter from?", "ROGUETOWN", null)
	if(!sentfrom)
		sentfrom = "Anonymous"
	var/t = stripped_multiline_input("Write Your Letter", "ROGUETOWN", no_trim=TRUE)
	if(t)
		if(length(t) > 2000)
			to_chat(user, span_warning("Too long. Try again."))
			return
	if(!coin_loaded)
		return
	if(!Adjacent(user))
		return
	var/obj/item/paper/P = new
	P.info += t
	P.mailer = sentfrom
	P.mailedto = send2place
	P.update_icon()
	if(findtext(send2place, "#"))
		var/box2find = text2num(copytext(send2place, findtext(send2place, "#")+1))
		var/found = FALSE
		for(var/obj/structure/roguemachine/mail/X in SSroguemachine.hermailers)
			if(X.ournum == box2find)
				found = TRUE
				P.mailer = sentfrom
				P.mailedto = send2place
				P.update_icon()
				P.forceMove(X.loc)
				X.say("New mail!")
				playsound(X, 'sound/misc/hiss.ogg', 100, FALSE, -1)
				break
		if(found)
			visible_message(span_warning("[user] sends something."))
			playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
			SStreasury.give_money_treasury(coin_loaded, "Mail Income")
			coin_loaded = FALSE
			update_icon()
			return
		else
			to_chat(user, span_warning("Failed to send it. Bad number?"))
	else
		if(!send2place)
			return
		if(SSroguemachine.hermailermaster)
			var/obj/item/roguemachine/mastermail/X = SSroguemachine.hermailermaster
			P.mailer = sentfrom
			P.mailedto = send2place
			P.update_icon()
			P.forceMove(X.loc)
			var/datum/component/storage/STR = X.GetComponent(/datum/component/storage)
			STR.handle_item_insertion(P, prevent_warning=TRUE)
			X.new_mail=TRUE
			X.update_icon()
			send_ooc_note("New letter from <b>[sentfrom].</b>", name = send2place)
			for(var/mob/living/carbon/human/H in GLOB.human_list)
				if(H.real_name == send2place)
					H.apply_status_effect(/datum/status_effect/ugotmail)
					H.playsound_local(H, 'sound/misc/mail.ogg', 100, FALSE, -1)
		else
			to_chat(user, span_warning("The master of mails has perished?"))
			return
		visible_message(span_warning("[user] sends something."))
		playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
		SStreasury.give_money_treasury(coin_loaded, "Mail")
		coin_loaded = FALSE
		update_icon()

/obj/structure/roguemachine/mail/attackby(obj/item/P, mob/user, params)
	if(istype(P, /obj/item/merctoken))
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(H.mind.assigned_role != "Mercenary")
				to_chat(H, "<span class='warning'>This is of no use to me - I may give this to a mercenary so they may send it themselves.</span>")
				return
			if(H.mind.assigned_role == "Mercenary")
				if(H.tokenclaimed == TRUE)
					to_chat(H, "<span class='warning'>I have already received my commendation. There's always next week to look forward to!</span>")
					return
			var/obj/item/merctoken/C = P
			if(C.signed == 1)
				qdel(C)
				visible_message("<span class='warning'>[H] sends something.</span>")
				playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
				sleep(20)
				playsound(loc, 'sound/misc/triumph.ogg', 100, FALSE, -1)
				playsound(src.loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
				H.visible_message("<span class='warning'>A trinket comes tumbling down from the machine. Proof of your distinction.</span>")
				H.adjust_triumphs(3)
				H.tokenclaimed = TRUE
				switch(H.merctype)
					if(0)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal(src.loc)
					if(1)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal/atgervi(src.loc)
					if(2)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal/blackoak(src.loc)
					if(3)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal/condottiero(src.loc)
					if(4)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal/desertrider(src.loc)
					if(5)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal/forlorn(src.loc)
					if(6)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal/freifechter(src.loc)
					if(7)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal/grenzelhoft(src.loc)
					if(8)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal/grudgebearer(src.loc)
					if(9)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal(src.loc) // NOT CURRENTLY IMPLEMENTED
					if(10)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal/routier(src.loc)
					if(11)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal/steppesman(src.loc)
					if(12)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal/underdweller(src.loc)
					if(13)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal/vaquero(src.loc)
					if(14)
						new /obj/item/clothing/neck/roguetown/luckcharm/mercmedal(src.loc) // NOT CURRENTLY IMPLEMENTED
			if(C.signed == 0)
				to_chat(H, "<span class='warning'>I cannot send an unsigned token.</span>")
				return
	if(istype(P, /obj/item/paper/confession))
		if((user.mind.assigned_role == "Confessor") || (user.mind.assigned_role == "Inquisitor"))
			var/obj/item/paper/confession/C = P
			if(C.signed)
				if(GLOB.confessors)
					var/no
					if(", [C.signed]" in GLOB.confessors)
						no = TRUE
					if("[C.signed]" in GLOB.confessors)
						no = TRUE
					if(!no)
						if(GLOB.confessors.len)
							GLOB.confessors += ", [C.signed]"
						else
							GLOB.confessors += "[C.signed]"
				qdel(C)
				visible_message(span_warning("[user] sends something."))
				send_ooc_note("Confessions: [GLOB.confessors.len]/5", job = list("confessor", "inquisitor", "priest"))
				playsound(loc, 'sound/magic/hallelujah.ogg', 100, FALSE, -1)
				playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
		return
	if(istype(P, /obj/item/paper))
		if(alert(user, "Send Mail?",,"YES","NO") == "YES")
			var/send2place = input(user, "Where to? (Person or #number)", "ROGUETOWN", null)
			var/sentfrom = input(user, "Who is this from?", "ROGUETOWN", null)
			if(!sentfrom)
				sentfrom = "Anonymous"
			if(findtext(send2place, "#"))
				var/box2find = text2num(copytext(send2place, findtext(send2place, "#")+1))
				testing("box2find [box2find]")
				var/found = FALSE
				for(var/obj/structure/roguemachine/mail/X in SSroguemachine.hermailers)
					if(X.ournum == box2find)
						found = TRUE
						P.mailer = sentfrom
						P.mailedto = send2place
						P.update_icon()
						P.forceMove(X.loc)
						X.say("New mail!")
						playsound(X, 'sound/misc/hiss.ogg', 100, FALSE, -1)
						break
				if(found)
					visible_message(span_warning("[user] sends something."))
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
					return
				else
					to_chat(user, span_warning("Cannot send it. Bad number?"))
			else
				if(!send2place)
					return
				var/findmaster
				if(SSroguemachine.hermailermaster)
					var/obj/item/roguemachine/mastermail/X = SSroguemachine.hermailermaster
					findmaster = TRUE
					P.mailer = sentfrom
					P.mailedto = send2place
					P.update_icon()
					P.forceMove(X.loc)
					var/datum/component/storage/STR = X.GetComponent(/datum/component/storage)
					STR.handle_item_insertion(P, prevent_warning=TRUE)
					X.new_mail=TRUE
					X.update_icon()
					playsound(src.loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)				
				if(!findmaster)
					to_chat(user, span_warning("The master of mails has perished?"))
				else
					visible_message(span_warning("[user] sends something."))
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
					send_ooc_note("New letter from <b>[sentfrom].</b>", name = send2place)
					for(var/mob/living/carbon/human/H in GLOB.human_list)
						if(H.real_name == send2place)
							H.apply_status_effect(/datum/status_effect/ugotmail)
							H.playsound_local(H, 'sound/misc/mail.ogg', 100, FALSE, -1)
					return
	if(istype(P, /obj/item/roguecoin))
		if(coin_loaded)
			return
		var/obj/item/roguecoin/C = P
		if(C.quantity > 1)
			return
		coin_loaded = C.get_real_price()
		qdel(C)
		playsound(src, 'sound/misc/coininsert.ogg', 100, FALSE, -1)
		update_icon()
		return
	..()

/obj/structure/roguemachine/mail/Initialize()
	. = ..()
	SSroguemachine.hermailers += src
	ournum = SSroguemachine.hermailers.len
	name = "[name] #[ournum]"
	update_icon()

/obj/structure/roguemachine/mail/Destroy()
	set_light(0)
	SSroguemachine.hermailers -= src
	return ..()

/obj/structure/roguemachine/mail/r
	pixel_y = 0
	pixel_x = 32

/obj/structure/roguemachine/mail/l
	pixel_y = 0
	pixel_x = -32

/obj/structure/roguemachine/mail/update_icon()
	cut_overlays()
	if(coin_loaded)
		add_overlay(mutable_appearance(icon, "mail-f"))
		set_light(1, 1, 1, l_color = "#ff0d0d")
	else
		add_overlay(mutable_appearance(icon, "mail-s"))
		set_light(1, 1, 1, l_color = "#1b7bf1")

/obj/structure/roguemachine/mail/examine(mob/user)
	. = ..()
	. += "<a href='?src=[REF(src)];directory=1'>Directory:</a> [mailtag]"

/obj/structure/roguemachine/mail/Topic(href, href_list)
	..()

	if(!usr)
		return

	if(href_list["directory"])
		view_directory(usr)

/obj/structure/roguemachine/mail/proc/view_directory(mob/user)
	var/dat
	for(var/obj/structure/roguemachine/mail/X in SSroguemachine.hermailers)
		if(X.obfuscated)
			continue
		if(X.mailtag)
			dat += "#[X.ournum] [X.mailtag]<br>"
		else
			dat += "#[X.ournum] [capitalize(get_area_name(X))]<br>"

	var/datum/browser/popup = new(user, "hermes_directory", "<center>HERMES DIRECTORY</center>", 387, 420)
	popup.set_content(dat)
	popup.open(FALSE)

/obj/item/roguemachine/mastermail
	name = "MASTER OF MAILS"
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "mailspecial"
	pixel_y = 32
	max_integrity = 0
	density = FALSE
	blade_dulling = DULLING_BASH
	anchored = TRUE
	w_class = WEIGHT_CLASS_GIGANTIC
	var/new_mail

/obj/item/roguemachine/mastermail/update_icon()
	cut_overlays()
	if(new_mail)
		icon_state = "mailspecial-get"
	else
		icon_state = "mailspecial"
	set_light(1, 1, 1, l_color = "#ff0d0d")

/obj/item/roguemachine/mastermail/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/roguetown/mailmaster)

/obj/item/roguemachine/mastermail/attack_hand(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		if(new_mail)
			new_mail = FALSE
			update_icon()
		CP.rmb_show(user)
		return TRUE

/obj/item/roguemachine/mastermail/Initialize()
	. = ..()
	SSroguemachine.hermailermaster = src
	update_icon()

/obj/item/roguemachine/mastermail/attackby(obj/item/P, mob/user, params)
	if(istype(P, /obj/item/paper))
		var/obj/item/paper/PA = P
		if(!PA.mailer && !PA.mailedto && PA.cached_mailer && PA.cached_mailedto)
			PA.mailer = PA.cached_mailer
			PA.mailedto = PA.cached_mailedto
			PA.cached_mailer = null
			PA.cached_mailedto = null
			PA.update_icon()
			to_chat(user, span_warning("I carefully re-seal the letter and place it back in the machine, no one will know."))
		P.forceMove(loc)
		var/datum/component/storage/STR = GetComponent(/datum/component/storage)
		STR.handle_item_insertion(P, prevent_warning=TRUE)
	..()

/obj/item/roguemachine/mastermail/Destroy()
	set_light(0)
	SSroguemachine.hermailers -= src
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))
	return ..()

/obj/structure/roguemachine/mail/proc/any_additional_mail(obj/item/roguemachine/mastermail/M, name)
	for(var/obj/item/I in M.contents)
		if(I.mailedto == name)
			return TRUE
	return FALSE
