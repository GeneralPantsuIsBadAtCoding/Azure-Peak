GLOBAL_VAR_INIT(year, time2text(world.realtime,"YYYY"))
GLOBAL_VAR_INIT(year_integer, text2num(year)) // = 2013???

/mob/living/carbon/human/Topic(href, href_list)
	var/observer_privilege = isobserver(usr)

	if(href_list["task"] == "view_headshot")
		if(!ismob(usr))
			return
		var/mob/user = usr
		var/list/dat = list()
		if(valid_headshot_link(null, headshot_link, TRUE))
			dat += "<br>"
			dat += ("<div align='center'><img src='[headshot_link]' width='325px' height='325px'></div>")
		dat += "<br>"
		dat += "<div align='center'>[src]</div>"
		if(flavortext)
			dat += "<div align='left'>[replacetext(flavortext, "\n", "<BR>")]</div>"
		if(ooc_notes)
			dat += "<br>"
			dat += "<div align='center'><b>OOC notes</b></div>"
			dat += "<div align='left'>[replacetext(ooc_notes, "\n", "<BR>")]"
		var/datum/browser/popup = new(user, "[src]", 600, 900)
		popup.set_content(dat.Join())
		popup.open(FALSE)
		return

	if(href_list["inspect_limb"] && (observer_privilege || usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY)))
		var/list/msg = list()
		var/mob/user = usr
		var/checked_zone = check_zone(href_list["inspect_limb"])
		var/obj/item/bodypart/bodypart = get_bodypart(checked_zone)
		if(bodypart)
			var/list/bodypart_status = bodypart.inspect_limb(user)
			if(length(bodypart_status))
				msg += bodypart_status
			else
				msg += "<B>[capitalize(bodypart.name)]:</B>"
				msg += "[bodypart] is healthy."
		else
			msg += "<B>[capitalize(parse_zone(checked_zone))]:</B>"
			msg += "<span class='dead'>Limb is missing!</span>"
		to_chat(usr, "<span class='info'>[msg.Join("\n")]</span>")

	if(href_list["embedded_object"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/obj/item/bodypart/L = locate(href_list["embedded_limb"]) in bodyparts
		if(!L)
			return
		var/obj/item/I = locate(href_list["embedded_object"]) in L.embedded_objects
		if(!I) //no item, no limb, or item is not in limb or in the person anymore
			return
		var/time_taken = I.embedding.embedded_unsafe_removal_time*I.w_class
		if(usr == src)
			usr.visible_message("<span class='warning'>[usr] attempts to remove [I] from [usr.p_their()] [L.name].</span>","<span class='warning'>I attempt to remove [I] from my [L.name]...</span>")
		else
			usr.visible_message("<span class='warning'>[usr] attempts to remove [I] from [src]'s [L.name].</span>","<span class='warning'>I attempt to remove [I] from [src]'s [L.name]...</span>")
		if(do_after(usr, time_taken, needhand = TRUE, target = src))
			if(QDELETED(I) || QDELETED(L) || !L.remove_embedded_object(I))
				return
			L.receive_damage(I.embedding.embedded_unsafe_removal_pain_multiplier*I.w_class)//It hurts to rip it out, get surgery you dingus.
			usr.put_in_hands(I)
			emote("pain", TRUE)
			playsound(loc, 'sound/foley/flesh_rem.ogg', 100, TRUE, -2)
			if(usr == src)
				usr.visible_message("<span class='notice'>[usr] rips [I] out of [usr.p_their()] [L.name]!</span>", "<span class='notice'>I successfully remove [I] from my [L.name].</span>")
			else
				usr.visible_message("<span class='notice'>[usr] rips [I] out of [src]'s [L.name]!</span>", "<span class='notice'>I successfully remove [I] from [src]'s [L.name].</span>")

	if(href_list["bandage"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/obj/item/bodypart/L = locate(href_list["bandaged_limb"]) in bodyparts
		if(!L)
			return
		var/obj/item/I = L.bandage
		if(!I)
			return
		if(usr == src)
			usr.visible_message("<span class='warning'>[usr] starts unbandaging [usr.p_their()] [L.name].</span>","<span class='warning'>I start unbandaging [L.name]...</span>")
		else
			usr.visible_message("<span class='warning'>[usr] starts unbandaging [src]'s [L.name].</span>","<span class='warning'>I start unbandaging [src]'s [L.name]...</span>")
		if(do_after(usr, 50, needhand = TRUE, target = src))
			if(QDELETED(I) || QDELETED(L) || (L.bandage != I))
				return
			L.remove_bandage()
			usr.put_in_hands(I)

	if(href_list["item"]) //canUseTopic check for this is handled by mob/Topic()
		var/slot = text2num(href_list["item"])
		if(slot in check_obscured_slots(TRUE))
			to_chat(usr, span_warning("I can't reach that! Something is covering it."))
			return

	if(href_list["undiesthing"]) //canUseTopic check for this is handled by mob/Topic()
		if(!get_location_accessible(src, BODY_ZONE_PRECISE_GROIN, skipundies = TRUE))
			to_chat(usr, span_warning("I can't reach that! Something is covering it."))
			return
		if(!underwear)
			return
		usr.visible_message(span_warning("[usr] starts taking off [src]'s [underwear.name]."),span_warning("I start taking off [src]'s [underwear.name]..."))
		if(do_after(usr, 50, needhand = 1, target = src))
			var/obj/item/bodypart/chest = get_bodypart(BODY_ZONE_CHEST)
			chest.remove_bodypart_feature(underwear.undies_feature)
			underwear.forceMove(get_turf(src))
			if(iscarbon(usr))
				var/mob/living/carbon/C = usr
				C.put_in_hands(underwear)
			underwear = null

	if(href_list["pockets"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY)) //TODO: Make it match (or intergrate it into) strippanel so you get 'item cannot fit here' warnings if mob_can_equip fails
		var/pocket_side = href_list["pockets"]
		var/pocket_id = (pocket_side == "right" ? SLOT_R_STORE : SLOT_L_STORE)
		var/obj/item/pocket_item = (pocket_id == SLOT_R_STORE ? r_store : l_store)
		var/obj/item/place_item = usr.get_active_held_item() // Item to place in the pocket, if it's empty

		var/delay_denominator = 1
		if(pocket_item && !(pocket_item.item_flags & ABSTRACT))
			if(HAS_TRAIT(pocket_item, TRAIT_NODROP))
				to_chat(usr, "<span class='warning'>I try to empty [src]'s [pocket_side] pocket, it seems to be stuck!</span>")
			to_chat(usr, "<span class='notice'>I try to empty [src]'s [pocket_side] pocket.</span>")
		else if(place_item && place_item.mob_can_equip(src, usr, pocket_id, 1) && !(place_item.item_flags & ABSTRACT))
			to_chat(usr, "<span class='notice'>I try to place [place_item] into [src]'s [pocket_side] pocket.</span>")
			delay_denominator = 4
		else
			return

		if(do_mob(usr, src, POCKET_STRIP_DELAY/delay_denominator)) //placing an item into the pocket is 4 times faster
			if(pocket_item)
				if(pocket_item == (pocket_id == SLOT_R_STORE ? r_store : l_store)) //item still in the pocket we search
					dropItemToGround(pocket_item)
			else
				if(place_item)
					if(place_item.mob_can_equip(src, usr, pocket_id, FALSE, TRUE))
						usr.temporarilyRemoveItemFromInventory(place_item, TRUE)
						equip_to_slot(place_item, pocket_id, TRUE)
					//do nothing otherwise
				//updating inv screen after handled by living/Topic()
		else
			// Display a warning if the user mocks up
			to_chat(src, "<span class='warning'>I feel your [pocket_side] pocket being fumbled with!</span>")

	if(href_list["task"] == "assess")
		if(!ishuman(usr))
			return
		if(!ishuman(src))
			return
		var/mob/living/carbon/human/H = src
		var/mob/living/carbon/human/user = usr
		user.visible_message("[user] begins assessing [src].")
		if(do_mob(user, src, (40 - (user.STAINT - 10) - (user.STAPER - 10) - user.mind?.get_skill_level(/datum/skill/misc/reading)), double_progress = TRUE))
			var/is_guarded = HAS_TRAIT(src, TRAIT_DECEIVING_MEEKNESS)	//Will scramble Stats and prevent skills from being shown
			var/is_smart = FALSE	//Maximum info (all skills, gear and stats) either Intellectual virtue or having high enough PER / INT / Reading
			var/is_stupid = FALSE	//Less than 9 INT, Intellectual virtue overrides it.
			var/is_normal = FALSE	//High amount of info -- most gear slots, combat skills. No stats.
			//If you don't get any of these, you'll still get to see 3 gear slots and shown weapon skills in Assess.
			if(HAS_TRAIT(user, TRAIT_INTELLECTUAL) || ((user.STAINT - 10) + (user.STAPER - 10) + user.mind?.get_skill_level(/datum/skill/misc/reading)) >= 10)
				is_smart = TRUE	
			if(user.STAINT < 10 && !is_smart)
				is_stupid = TRUE
			if(!is_smart && !is_stupid && ((user.STAINT - 10) + (user.STAPER - 10) + H?.mind?.get_skill_level(/datum/skill/misc/reading)) >= 5)
				is_normal = TRUE
			var/list/dat = list()
			// Top-level table
			dat += "<table style='width: 100%; line-height: 20px;'>"
			// NEXT ROW
			dat += "<tr>"
			dat += "<td style='width:16%;text-align:left;vertical-align: text-top'>"
			if(HAS_TRAIT(user, TRAIT_INTELLECTUAL))
				dat += "<b>STATS:</b><br><br>"
				if(!is_guarded)
					dat +=("STR: \Roman [H.STASTR]<br>")
					dat +=("PER: \Roman [H.STAPER]<br>")
					dat +=("INT: \Roman [H.STAINT]<br>")
					dat +=("CON: \Roman [H.STACON]<br>")
					dat +=("END: \Roman [H.STAEND]<br>")
					dat +=("SPD: \Roman [H.STASPD]<br>")
				else
					dat +=("STR: \Roman [rand(1,20)]<br>")
					dat +=("PER: \Roman [rand(1,20)]<br>")
					dat +=("INT: \Roman [rand(1,20)]<br>")
					dat +=("CON: \Roman [rand(1,20)]<br>")
					dat +=("END: \Roman [rand(1,20)]<br>")
					dat +=("SPD: \Roman [rand(1,20)]<br>")
				if(is_guarded || job == "Jester")
					dat += "Something feels off..."
				dat += "</td>"
			else
				dat += "</td>"

			dat += "<td style='width:33%;text-align:center;vertical-align: text-top'>"
			dat += "<b>BODY:</b><br><br>"
			dat += "<b><font size = 4; font color = '#dddada'>HEAD</b></font><br>"
			if(H.head)
				dat += capitalize("[H.head.name]<br>")
				dat += defense_report(H.head, is_stupid, is_normal, is_smart, "THE HEAD I THINK. MAYBE MORE?")
			else
				dat += "<font color = '#8b1616'<b>NOTHING</b></font> <br>"
			
			dat += "<b><font size = 4; font color = '#dddada'>TORSO</b></font><br>"
			if(H.wear_armor)
				dat += capitalize("[H.wear_armor.name]<br>")
				dat += defense_report(H.wear_armor, is_stupid, is_normal, is_smart, "THE CHEST! PROBABLY GROIN TOO?")
			else
				dat += "<font color = '#8b1616'<b>NOTHING</b></font> <br>"

			dat += "<b><font size = 4; font color = '#dddada'>PANTS</b></font><br>"
			if(H.wear_pants)
				dat += capitalize("[H.wear_pants.name]<br>")
				dat += defense_report(H.wear_pants, is_stupid, is_normal, is_smart, "THE IMPORTANT PARTS! LEGS AS WELL, I THINK.")
			else
				dat += "<font color = '#8b1616'<b>NOTHING</b></font> <br>"

			//Extra stuff you can assess if you match the thresholds. (Neck, gloves, shirt and shoes)
			if((is_normal || is_smart) && !is_stupid)
				dat += "<b><font size = 4; font color = '#dddada'>NECK</b></font><br>"
				if(H.wear_neck)
					dat += capitalize("[H.wear_neck.name]<br>")
					dat += defense_report(H.wear_neck, is_stupid, is_normal, is_smart, "I shouldn't be seeing this.")
				else
					dat += "<font color = '#8b1616'<b>NOTHING</b></font> <br>"

				dat += "<b><font size = 4; font color = '#dddada'>GLOVES</b></font><br>"
				if(H.gloves)
					dat += capitalize("[H.gloves.name]<br>")
					dat += defense_report(H.gloves, is_stupid, is_normal, is_smart, "I shouldn't be seeing this.")
				else
					dat += "<font color = '#8b1616'<b>NOTHING</b></font> <br>"

				dat += "<b><font size = 4; font color = '#dddada'>SHIRT</b></font><br>"
				if(H.wear_shirt)
					dat += capitalize("[H.wear_shirt.name]<br>")
					dat += defense_report(H.wear_shirt, is_stupid, is_normal, is_smart, "I shouldn't be seeing this.")
				else
					dat += "<font color = '#8b1616'<b>NOTHING</b></font> <br>"

				dat += "<b><font size = 4; font color = '#dddada'>SHOES</b></font><br>"
				if(H.shoes)
					dat += capitalize("[H.shoes.name]<br>")
					dat += defense_report(H.shoes, is_stupid, is_normal, is_smart, "I shouldn't be seeing this.")
				else
					dat += "<font color = '#8b1616'<b>NOTHING</b></font> <br>"					

			
			dat += "</td>"

			dat += "<td style='width:40%;text-align:center;vertical-align: text-top'>"
			if(!is_guarded && !is_stupid)	//We don't see Guarded people's skills at all.
				dat += "<b>SKILLS:</b><br><br>"
				var/list/wornstuff = list(H.backr, H.backl, H.beltl, H.beltr)
				if(!is_normal && !is_smart)	//At minimum we get to see the skills of the weapons the person is holding, if we have them.
					for(var/stuff in wornstuff)
						if(stuff)
							if(istype(stuff, /obj/item))
								var/obj/item/wornthing = stuff
								if(wornthing.associated_skill)
									var/datum/skill/SK = wornthing.associated_skill
									if(user.mind?.get_skill_level(SK) > 0)
										dat += "<font size = 4; font color = '#dddada'><b>[SK.name]</b><br></font>"
										var/skilldiff = user.mind?.get_skill_level(SK) - H.mind?.get_skill_level(SK)
										dat += "[skilldiff_report(skilldiff)] <br>"
										dat += "-----------------------<br>"
					for(var/obj/item/I in held_items)	//Also what's in their hands!
						if(!(I.item_flags & ABSTRACT))
							if(I.associated_skill)
								var/datum/skill/SK = I.associated_skill
								if(user.mind?.get_skill_level(SK) > 0)
									dat += "<font size = 4; font color = '#dddada'><b>[SK.name]</b><br></font>"
									var/skilldiff = user.mind?.get_skill_level(SK) - H.mind?.get_skill_level(SK)
									dat += "[skilldiff_report(skilldiff)] <br>"
									dat += "-----------------------<br>"
				else	//Otherwise, we get to see all of their combat skills
					for(var/S in subtypesof(/datum/skill/combat))
						var/datum/skill/combat/SK = S
						if(user.mind?.get_skill_level(S) > 0)
							dat += "<font size = 4; font color = '#dddada'><b>[SK.name]</b><br></font>"
							var/skilldiff = user.mind?.get_skill_level(S) - H.mind?.get_skill_level(S)
							dat += "[skilldiff_report(skilldiff)] <br>"
							dat += "-----------------------<br>"
					if(is_smart)	//And if we're smart enough, /all/ skills.
						for(var/S in subtypesof(/datum/skill))
							if(user.mind?.get_skill_level(S) > 0)
								if(!ispath(S, /datum/skill/combat))	//We already did these.
									var/datum/skill/SL = S
									dat += "<font size = 4; font color = '#dddada'><b>[SL.name]</b><br></font>"
									var/skilldiff = user.mind?.get_skill_level(S) - H.mind?.get_skill_level(S)
									dat += "[skilldiff_report(skilldiff)] <br>"
									dat += "-----------------------<br>"
								else
									continue
					
			dat += "</td>"
			dat += "</tr>"
			var/datum/browser/popup = new(user, "assess", ntitle = "[src] Assesment", nwidth = 700, nheight = 600)
			popup.set_content(dat.Join())
			popup.open(FALSE)
		else
			user.visible_message("[user] fails to assess [src]!")
		return
	return ..() //end of this massive fucking chain. TODO: make the hud chain not spooky. - Yeah, great job doing that. - I made it worse sorry guys.

//Sorry colorblind folks...
/proc/colorgrade_rating(var/input, var/rating, var/elaborate = FALSE)
	var/str
	switch(rating)
		if(0 to 20)
			str = elaborate ? "<font color = '#c91a1a'>[input] (BAD)</font>" : "<font color = '#c91a1a'>[input]</font>"
		if(20 to 40)
			str = elaborate ? "<font color = '#755211'>[input] (POOR)</font>" : "<font color = '#755211'>[input]</font>"
		if(40 to 60)
			str = elaborate ? "<font color = '#d2d440'>[input] (AVERAGE)</font>" : "<font color = '#d2d440'>[input]</font>"
		if(60 to 80)
			str = elaborate ? "<font color = '#308020'>[input] (GOOD)</font>" : "<font color = '#308020'>[input]</font>"
		if(80 to 90)
			str = elaborate ? "<font color = '#0fe021'>[input] (GREAT)</font>" : "<font color = '#0fe021'>[input]</font>"
		if(100)
			str = elaborate ? "<font color = '#2492f8'>[input] (IMMUNE)</font>" : "<font color = '#2492f8'>[input]</font>"
	return str

/proc/defense_report(var/obj/item/clothing/C, var/stupid, var/normal, var/smart, var/stupid_string)
	var/list/str = list()
	if(C.armor)
		var/defense = "<u><b>DEFENSE: </b></u><br>"
		var/datum/armor/def_armor = C.armor
		defense += "[colorgrade_rating("BLUNT", def_armor.blunt)] | "
		defense += "[colorgrade_rating("SLASH", def_armor.slash)] | "
		defense += "[colorgrade_rating("STAB", def_armor.stab)] | "
		defense += "[colorgrade_rating("PIERCING", def_armor.piercing)] "
		str += "[defense]<br>"

	var/coverage = "<u><b>COVERS: </b></u><br>"
	if(!stupid)
		coverage += "<font color = '#cccccc'> | </font>"
		for(var/zone in body_parts_covered2organ_names(C.body_parts_covered))
			coverage += "<font color = '#cccccc'><b>[zone] | </b></font>"
		str += "[coverage]<br>"
	else
		str += coverage
		str += stupid_string
	if(normal || smart)
		var/crits = "<b><u>PREVENTS CRITS: </u></b><br>"
		crits += "<font color = '#b9b9b9'>| </font>"
		for(var/zone in C.prevent_crits)
			crits += "<font color = '#b9b9b9'>[capitalize(zone)] | </font>"
		str += crits
	str += "<br>---------------------------<br>"
	return str

/proc/skilldiff_report(var/input)
	switch (input)
		if(-6)
			return "<font color = '#ff4ad2'>I know nothing. They -- everything.</font>"
		if(-5)
			return "<font color = '#eb0000'<i>I stand no chance against them.</i></font>"
		if(-4)
			return "<font color = '#c53c3c'<i>I am inferior.</i></font>"
		if(-3)
			return "<font color = '#db8484'<i>I am notably worse.</i></font>"
		if(-2)
			return "<font color = '#e4a1a1'<i>I am worse.</i></font>"
		if(-1)
			return "<font color = '#f8d3d3'<i>I am slightly worse.</i></font>"
		if(0)
			return "We are equal."
		if(1)
			return "<font color = '#3f6343'> I am slightly better.</font>"
		if(2)
			return "<font color = '#49944f'> I am better.</font>"
		if(3)
			return "<font color = '#44db51'> I am notably better.</font>"
		if(4)
			return"<font color = '#62b4be'> I am superior.</font>"
		if(5)
			return "<font color = '#2bdcfc'> They have no chance in this field.</font>"
		if(6)
			return "<font color = '#ff4ad2'> They know nothing. A whelp.</font>"
