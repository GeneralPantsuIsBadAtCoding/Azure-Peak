/obj/structure/roguemachine/mail
	name = "HERMES"
	desc = "Carrier zads have fallen severely out of fashion ever since the advent of this hydropneumatic mail system."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "mail"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32
	var/coin_loaded = FALSE
	var/inqcoins = 0
	var/inqonly = FALSE // Has the Inquisitor locked Marque-spending for lessers?
	var/keycontrol = "puritan"
	var/cat_current = "1"
	var/list/all_category = list(
		"✤ RELIQUARY ✤",
		"✤ SUPPLIES ✤",
		"✤ ARTICLES ✤",
		"✤ EQUIPMENT ✤",
		"✤ WARDROBE ✤"
	)
	var/list/category = list(
		"✤ SUPPLIES ✤",
		"✤ ARTICLES ✤",
		"✤ EQUIPMENT ✤",
		"✤ WARDROBE ✤"
	)
	var/list/inq_category = list("✤ RELIQUARY ✤")
	var/ournum
	var/mailtag
	var/obfuscated = FALSE

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
	if(!ishuman(user))
		return	
	if(HAS_TRAIT(user, TRAIT_INQUISITION))	
		if(!coin_loaded && !inqcoins)
			to_chat(user, span_notice("It needs a Marque."))
			return
		user.changeNext_move(CLICK_CD_MELEE)
		display_marquette(usr)

/obj/structure/roguemachine/mail/examine(mob/user)
	. = ..()	
	. += span_info("Load a coin inside, then right click to send a letter.")
	. += span_info("Left click with a paper to send a prewritten letter for free.")
	if(HAS_TRAIT(user, TRAIT_INQUISITION))
		. += span_info("<br>The MARQUETTE can be accessed via a secret compartment fitted within the HERMES. Load a Marque to access it.")

		. += span_info("You can send arrival slips, accusation slips, fully loaded INDEXERs or confessions here.")
		. += span_info("Properly sign them. Include an INDEXER where needed. Stamp them for two additional Marques.")

/obj/structure/roguemachine/mail/attack_right(mob/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	if(!coin_loaded)
		to_chat(user, span_warning("The machine doesn't respond. It needs a coin."))
		return
	if(inqcoins)
		to_chat(user, span_warning("The machine doesn't respond."))
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
	if(HAS_TRAIT(user, TRAIT_INQUISITION))
		if(istype(P, /obj/item/roguekey))
			var/obj/item/roguekey/K = P
			if(K.lockid == keycontrol) // Inquisitor's Key
				playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
				for(var/obj/structure/roguemachine/mail/everyhermes in SSroguemachine.hermailers)
					everyhermes.inqlock()
				to_chat(user, span_warning("I [inqonly ? "disable" : "enable"] the Puritan's Lock."))
				return
			to_chat(user, span_warning("Wrong key."))
			return
		if(istype(P, /obj/item/storage/keyring))
			var/obj/item/storage/keyring/K = P
			if(!K.contents.len)
				return
			var/list/keysy = K.contents.Copy()
			for(var/obj/item/roguekey/KE in keysy)
				if(KE.lockid == keycontrol)
					playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
					for(var/obj/structure/roguemachine/mail/everyhermes in SSroguemachine.hermailers)
						everyhermes.inqlock()
					to_chat(user, span_warning("I [inqonly ? "disable" : "enable"] the Puritan's Lock."))
					return

	if(istype(P, /obj/item/paper/confession))
		if((HAS_TRAIT(user, TRAIT_INQUISITION) || HAS_TRAIT(user, TRAIT_PURITAN)))
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
				playsound(loc, 'sound/misc/otavanlament.ogg', 100, FALSE, -1)
				playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
		return

	if(istype(P, /obj/item/paper/inqslip/confession))
		if((HAS_TRAIT(user, TRAIT_INQUISITION) || HAS_TRAIT(user, TRAIT_PURITAN)))	
			var/obj/item/paper/inqslip/confession/I = P
			if(I.signee && I.signed)
				var/no
				var/accused
				var/indexed
				var/correct
				if(HAS_TRAIT(I.signee, TRAIT_CABAL) || HAS_TRAIT(I.signee, TRAIT_HORDE) || HAS_TRAIT(I.signee, TRAIT_DEPRAVED) || HAS_TRAIT(I.signee, TRAIT_COMMIE))
					correct = TRUE
				if(I.signee.name in GLOB.excommunicated_players)	
					correct = TRUE
				if(I.paired.subject && I.paired.full && GLOB.indexed)
					if(", [I.signee]" in GLOB.indexed)
						indexed = TRUE
					if("[I.signee]" in GLOB.indexed)
						indexed = TRUE
					if(!indexed)
						if(GLOB.indexed.len)
							GLOB.indexed += ", [I.signee]"
						else
							GLOB.indexed += "[I.signee]"
				if(GLOB.accused)
					if(", [I.signee]" in GLOB.accused)
						accused = TRUE
					if("[I.signee]" in GLOB.accused)
						accused = TRUE
					if(!accused)
						if(GLOB.accused.len)
							GLOB.accused += ", [I.signee]"
						else
							GLOB.accused += "[I.signee]"
				if(GLOB.confessors)
					if(", [I.signee]" in GLOB.confessors)
						no = TRUE
					if("[I.signee]" in GLOB.confessors)
						no = TRUE
					if(!no)
						if(GLOB.confessors.len)
							GLOB.confessors += ", [I.signee]"
						else
							GLOB.confessors += "[I.signee]"			
				if(no)		
					if(I.paired)	
						qdel(I.paired)
					qdel(I)
					visible_message(span_warning("[user] sends something."))
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
					to_chat(user, span_notice("They've already confessed."))
				else
					if(!indexed && !correct)
						budget2change(2, user, "MARQUE")
					else if(correct)	
						if(!indexed)
							I.marquevalue += 2
						if(accused)	
							I.marquevalue -= 4
						budget2change(I.marquevalue, user, "MARQUE")
					if(I.paired)	
						qdel(I.paired)
					qdel(I)
					visible_message(span_warning("[user] sends something."))
					playsound(loc, 'sound/misc/otavanlament.ogg', 100, FALSE, -1)
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
			return	

	if(istype(P, /obj/item/inqarticles/indexer))
		if((HAS_TRAIT(user, TRAIT_INQUISITION) || HAS_TRAIT(user, TRAIT_PURITAN)))	
			var/obj/item/inqarticles/indexer/I = P
			if(I.cursedblood)
				var/stopfarming
				if(GLOB.cursedsamples)
					if(", [I.subject.mind]" in GLOB.cursedsamples)
						stopfarming = TRUE
					if("[I.subject.mind]" in GLOB.cursedsamples)
						stopfarming = TRUE
					if(!stopfarming)
						if(GLOB.cursedsamples.len)
							GLOB.cursedsamples += ", [I.subject.mind]"
						else
							GLOB.cursedsamples += "[I.subject.mind]"
				if(stopfarming)		
					qdel(I)
					visible_message(span_warning("[user] sends something."))
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
					visible_message(span_warning("[user] recieves something."))
					to_chat(user, span_notice("We've already collected a sample of their accursed blood."))
					var/obj/item/inqarticles/indexer/replacement = new /obj/item/inqarticles/indexer/
					user.put_in_hands(replacement)
				else
					var/yummers = I.cursedblood * 2	+ 2
					budget2change(yummers, user, "MARQUE")
					qdel(I)
					visible_message(span_warning("[user] sends something."))
					playsound(loc, 'sound/misc/otavanlament.ogg', 100, FALSE, -1)
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
			else if(I.subject && I.full)
				var/no
				if(GLOB.indexed)
					if(", [I.subject]" in GLOB.indexed)
						no = TRUE
					if("[I.subject]" in GLOB.indexed)
						no = TRUE
					if(!no)
						if(GLOB.indexed.len)
							GLOB.indexed += ", [I.subject]"
						else
							GLOB.indexed += "[I.subject]"
				if(no)		
					qdel(I)
					visible_message(span_warning("[user] sends something."))
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
					visible_message(span_warning("[user] recieves something."))
					to_chat(user, span_notice("It appears we already had them INDEXED. I've been issued a replacement."))
					var/obj/item/inqarticles/indexer/replacement = new /obj/item/inqarticles/indexer/
					user.put_in_hands(replacement)
				else	
					budget2change(2, user, "MARQUE")
					qdel(I)
					visible_message(span_warning("[user] sends something."))
					playsound(loc, 'sound/misc/otavasent.ogg', 100, FALSE, -1)
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
			return

	if(istype(P, /obj/item/paper/inqslip/arrival))
		if((HAS_TRAIT(user, TRAIT_INQUISITION) || HAS_TRAIT(user, TRAIT_PURITAN)))	
			var/obj/item/paper/inqslip/arrival/I = P
			if(I.signee && I.signed)
				var/no
				if(GLOB.indexed)
					if(", [I.signee]" in GLOB.inqarrivals)
						no = TRUE
					if("[I.signee]" in GLOB.inqarrivals)
						no = TRUE
					if(!no)
						if(GLOB.inqarrivals.len)
							GLOB.inqarrivals += ", [I.signee]"
						else
							GLOB.inqarrivals += "[I.signee]"
				if(no)		
					qdel(I)
					visible_message(span_warning("[user] sends something."))
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
					to_chat(user, span_notice("I.. I've already arrived? Surely, it's a clerical error..."))
				else	
					budget2change(I.marquevalue, user, "MARQUE")
					qdel(I)
					visible_message(span_warning("[user] sends something."))
					playsound(loc, 'sound/misc/otavasent.ogg', 100, FALSE, -1)
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
			return				

	if(istype(P, /obj/item/paper/inqslip/accusation))
		if((HAS_TRAIT(user, TRAIT_INQUISITION) || HAS_TRAIT(user, TRAIT_PURITAN)))	
			var/obj/item/paper/inqslip/accusation/I = P
			if(I.signee && I.paired.full && I.paired.subject)
				var/no
				var/specialno
				var/indexed
				var/correct
				if(HAS_TRAIT(I.paired.subject, TRAIT_CABAL) || HAS_TRAIT(I.paired.subject, TRAIT_HORDE) || HAS_TRAIT(I.paired.subject, TRAIT_DEPRAVED) || HAS_TRAIT(I.paired.subject, TRAIT_COMMIE))
					correct = TRUE
				if(I.paired.subject.name in GLOB.excommunicated_players)	
					correct = TRUE
				if(GLOB.indexed)
					if(", [I.paired.subject]" in GLOB.indexed)
						indexed = TRUE
					if("[I.paired.subject]" in GLOB.indexed)
						indexed = TRUE
					if(!indexed)
						if(GLOB.indexed.len)
							GLOB.indexed += ", [I.paired.subject]"
						else
							GLOB.indexed += "[I.paired.subject]"
				if(GLOB.accused)
					if(", [I.paired.subject]" in GLOB.accused)
						no = TRUE
					if("[I.paired.subject]" in GLOB.accused)
						no = TRUE
					if(!no)
						if(GLOB.accused.len)
							GLOB.accused += ", [I.paired.subject]"
						else
							GLOB.accused += "[I.paired.subject]"
				if(GLOB.confessors)
					if(", [I.paired.subject]" in GLOB.confessors)
						no = TRUE
						specialno = TRUE
					if("[I.paired.subject]" in GLOB.confessors)
						no = TRUE
						specialno = TRUE
					if(!no)
						if(GLOB.confessors.len)
							GLOB.confessors += ", [I.paired.subject]"
						else
							GLOB.confessors += "[I.paired.subject]"			
				if(no)		
					qdel(I.paired)
					qdel(I)
					visible_message(span_warning("[user] sends something."))
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
					if(specialno)
						to_chat(user, span_notice("They've confessed."))
					else
						to_chat(user, span_notice("They've already been accused."))
				else
					if(!indexed && !correct)
						budget2change(2, user, "MARQUE")
					else if(correct)	
						if(!indexed)
							I.marquevalue += 2
						budget2change(I.marquevalue, user, "MARQUE")
					qdel(I.paired)
					qdel(I)
					visible_message(span_warning("[user] sends something."))
					playsound(loc, 'sound/misc/otavanlament.ogg', 100, FALSE, -1)
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
			return							
		
	if(istype(P, /obj/item/paper))
		if(inqcoins)
			to_chat(user, span_warning("The machine doesn't respond."))
			return	
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

	if(istype(P, /obj/item/roguecoin/aalloy))
		return

	if(istype(P, /obj/item/roguecoin/inqcoin))
		if(HAS_TRAIT(user, TRAIT_INQUISITION))	
			if(coin_loaded && !inqcoins)
				return
			var/obj/item/roguecoin/M = P
			coin_loaded = TRUE
			inqcoins += M.quantity
			update_icon()
			qdel(M)
			playsound(src, 'sound/misc/coininsert.ogg', 100, FALSE, -1)
			return display_marquette(usr)
		else
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

/obj/structure/roguemachine/mail/r
	pixel_y = 0
	pixel_x = 32

/obj/structure/roguemachine/mail/l
	pixel_y = 0
	pixel_x = -32

/obj/structure/roguemachine/mail/update_icon()
	cut_overlays()
	if(coin_loaded)	
		if(inqcoins > 0)
			add_overlay(mutable_appearance(icon, "mail-i"))
			set_light(1, 1, 1, l_color = "#ffffff")
		else
			add_overlay(mutable_appearance(icon, "mail-f"))
			set_light(1, 1, 1, l_color = "#1b7bf1")
	else
		add_overlay(mutable_appearance(icon, "mail-s"))
		set_light(1, 1, 1, l_color = "#ff0d0d")

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


/*
	INQUISITION INTERACTIONS - START
*/

/obj/structure/roguemachine/mail/proc/inqlock()
	inqonly = !inqonly

/obj/structure/roguemachine/mail/proc/decreaseremaining(datum/inqports/PA)
	PA.remaining -= 1
	PA.name = "[initial(PA.name)] ([PA.remaining]/[PA.maximum]) - ᛉ [PA.marquescost] ᛉ"
	if(!PA.remaining)
		PA.name = "[initial(PA.name)] (OUT OF STOCK) - ᛉ [PA.marquescost] ᛉ"
	return		

/obj/structure/roguemachine/mail/proc/display_marquette(mob/user)
	var/contents
	contents = "<center>✤ ── L'INQUISITION MARQUETTE D'OTAVA ── ✤<BR>"
	contents += "POUR L'ÉRADICATION DE L'HÉRÉSIE, TANT QUE PSYDON ENDURE.<BR>"
	if(HAS_TRAIT(user, TRAIT_PURITAN))		
		contents += "✤ ── <a href='?src=[REF(src)];locktoggle=1]'> PURITAN'S LOCK: [inqonly ? "OUI":"NON"]</a> ── ✤<BR>"
	else
		contents += "✤ ── PURITAN'S LOCK: [inqonly ? "OUI":"NON"] ── ✤<BR>"
	contents += "ᛉ <a href='?src=[REF(src)];eject=1'>MARQUES LOADED:</a> [inqcoins] ᛉ<BR>"

	if(cat_current == "1")
		contents += "<BR> <table style='width: 100%' line-height: 40px;'>"
		if(HAS_TRAIT(user, TRAIT_PURITAN))
			for(var/i = 1, i <= inq_category.len, i++)
				contents += "<tr>"
				contents += "<td style='width: 100%; text-align: center;'>\
					<a href='?src=[REF(src)];changecat=[inq_category[i]]'>[inq_category[i]]</a>\
					</td>"	
				contents += "</tr>"
		for(var/i = 1, i <= category.len, i++)
			contents += "<tr>"
			contents += "<td style='width: 100%; text-align: center;'>\
				<a href='?src=[REF(src)];changecat=[category[i]]'>[category[i]]</a>\
				</td>"	
			contents += "</tr>"
		contents += "</table>"
	else
		contents += "<center>[cat_current]<BR></center>"
		contents += "<center><a href='?src=[REF(src)];changecat=1'>\[RETURN\]</a><BR><BR></center>"			
		contents += "<center>"			
		var/list/items = list()
		for(var/pack in GLOB.inqsupplies)
			var/datum/inqports/PA = pack
			if(all_category[PA.category] == cat_current)
				items += GLOB.inqsupplies[pack]
		for(var/pack in sortNames(items, order=0))
			var/datum/inqports/PA = pack
			var/name = uppertext(PA.name)
			if(inqonly && !HAS_TRAIT(user, TRAIT_PURITAN) || (PA.maximum && !PA.remaining) || inqcoins < PA.marquescost) 
				contents += "[name]<BR>"
			else
				contents += "<a href='?src=[REF(src)];buy=[PA.type]'>[name]</a><BR>"
		contents += "</center>"			
	var/datum/browser/popup = new(user, "VENDORTHING", "", 500, 600)
	popup.set_content(contents)
	if(inqcoins == 0)
		popup.close()
		return
	else
		popup.open()

/obj/structure/roguemachine/mail/Topic(href, href_list)
	..()
	if(href_list["eject"])
		if(inqcoins <= 0)
			return
		coin_loaded = FALSE
		update_icon()	
		budget2change(inqcoins, usr, "MARQUE")
		inqcoins = 0

	if(href_list["changecat"])
		cat_current = href_list["changecat"]

	if(href_list["locktoggle"])
		playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
		for(var/obj/structure/roguemachine/mail/everyhermes in SSroguemachine.hermailers)
			everyhermes.inqlock()

	if(href_list["buy"])
		var/mob/M = usr
		var/path = text2path(href_list["buy"])
		var/datum/inqports/PA = GLOB.inqsupplies[path]

		inqcoins -= PA.marquescost
		if(PA.maximum)	
			decreaseremaining(PA)
		visible_message(span_warning("[usr] sends something."))
		playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
		var/pathi = pick(PA.item_type)
		new pathi(get_turf(M))

	return display_marquette(usr)		

/*
	INQUISITION INTERACTIONS - END
*/
