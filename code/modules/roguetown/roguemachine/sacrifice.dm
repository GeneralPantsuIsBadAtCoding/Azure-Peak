/*
Funky Mafia / Werewolf type of inspired object. At X minutes a call for sacrifices from noble-roles is made. 
Once they all come to the altar and snip their fingers the blood is counted. If any Ascendants offered theirs,
the ritual fails. Otherwise, it succeeds. The Priest has a few tools to remove or swap out the needed and sacrificed roles during the timer.
If the timer expires w/o everyone having contributed, the ritual also fails.

CONSEQUENCES:

SUCCESS:
Every tennite gets a mood buff for the rest of the round.

FAILURE:
Every Ascendant gets a mood buff for the rest of the round.
Every tennite gets a mood debuff for the rest of the round.
A Bad Omen is added
Every Church member loses their heal miracle (except Priest)
Priest loses Anastasis and Cure Rot

PRIEST OVERRIDE:
Success, but the Church loses their heals.
*/
/obj/structure/roguemachine/sacrifice
	name = "Altar of the Ten"
	desc = "An ancient rite preserved throughout the key locations of the clergy. The last ditch effort in subduing the rot, through sacrifices of sanctified blood. \nThere are rumors that the stones are the very shards of comet Syon, but the clerge staunchly opposes this. It is very susceptible to Ascendant mingling. The Priest ordaines the rituals."
	icon = 'icons/roguetown/misc/sacrifice_altar.dmi'
	icon_state = "altar"
	density = TRUE
	blade_dulling = DULLING_BASH
	light_system = STATIC_LIGHT
	light_outer_range = 5
	light_power = 1
	light_color = LIGHT_COLOR_FIRE
	var/light_color_divine = LIGHT_COLOR_CYAN
	var/light_color_heretic = LIGHT_COLOR_BLOOD_MAGIC
	
	//basic toggles and list.
	var/list/expected_roles = list("Marshal", "Guard Captain", "Hand", "Consort", "Steward", "Grand Duke", "Prince", "Priest")	//Roles that are counted for the checks, and will be expected primarily.

	//Role categories that can be swapped TO. These will pick from a range of the written category of roles. 
	//Does not account if a player of that job is currently online.
	var/list/swap_roles = list("Garrison", "Church", "Inquisition", "Yeomen", "Peasants", "Youngfolk", "Jester")

	//Roles that had already contributed their blood. Can be removed from by the Priest.
	var/list/sacrificed_roles = list()
	var/list/dynamic_roles = list()
	var/is_active = FALSE
	var/delay = 5 MINUTES
	var/cancel_due_to_pop = FALSE

	//ritual timer bolognese
	var/ritual_delay
	var/ritual_end
	var/ritual_time
	var/ritual_start = 100 MINUTES	
	var/ritual_warning
	var/ritual_finished = FALSE

	//actually important vars
	var/role_count_threshold = 5	
	var/delay_count = 0
	var/admins_warned
	var/countdown_warning = FALSE
	var/corrupted = FALSE
	var/role_removed = 0
	var/role_swapped = 0
	var/priest_override = FALSE
	var/mob/living/carbon/human/HPR

/obj/structure/roguemachine/sacrifice/Initialize()
	. = ..()
	START_PROCESSING(SSdcs, src)
	pixel_x = -32
	pixel_y = -32


//This is called in process() ten minutes prior and on ritual_start time in ticks. It checks if the ritual CAN happen. Returns true / false.
/obj/structure/roguemachine/sacrifice/proc/ritual_check()
	var/prince_found = FALSE	//There can be multiple princes, we only need one
	var/priest_found = FALSE	//If there's no priest, don't do the ritual
	var/count = 0
	role_removed = 0
	LAZYCLEARLIST(dynamic_roles)
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!H)
			continue
		if(!H.client)		
			continue
		if(H.job)
			var/J = H.job

			if(J == "Prince" && !prince_found)
				prince_found = TRUE
				LAZYADD(dynamic_roles, J)
				count++
				continue

			if(J == "Priest" && !priest_found)
				priest_found = TRUE
				HPR = H
				LAZYADD(dynamic_roles, J)
				count++
				continue

			for(var/role in expected_roles)
				if(J == role && J != "Priest" && J != "Prince")
					count++
					LAZYADD(dynamic_roles, J)

	if(role_count_threshold <= count && priest_found)	//Post-loop we found enough people AND a priest to call for the ritual
		if(count > 5)
			role_removed--	//They get an extra removable role (2 total)
		if(count >= 7)
			role_swapped--	//Extra swappable role (2 total)
		return TRUE
	else
		LAZYCLEARLIST(dynamic_roles)
		return FALSE

/obj/structure/roguemachine/sacrifice/proc/begin_ritual()
	is_active = TRUE
	priority_announce("The Rot Requires Sacrifice. The Priest and the Duchy's blue-blooded must gather at the altar to preserve the lands. Each sacrifice must come within a sixth of a dae of the last.", "Call For Tithe", 'sound/misc/heroin_rush.ogg')
	icon_state = "altar_combined"
	ritual_time = world.time
	ritual_end = ritual_time + delay
	ritual_warning = ritual_end - 1 MINUTES
	set_light_on(TRUE)
	update_light()

/obj/structure/roguemachine/sacrifice/proc/end_ritual(override = FALSE)
	is_active = FALSE
	if(override)
		priest_override = TRUE
	ritual_finished = TRUE
	if(!override)
		priority_announce("The tithes have been paid. May these lands continue to stand against the blight. The tithe will now be churned.", "Tithe Complete", 'sound/misc/deadbell.ogg')
	else
		priority_announce("The leader of the Church has chosen to sacrifice its faithful to subdue the Rot.", "Tithe Complete", 'sound/misc/deadbell.ogg')
	addtimer(CALLBACK(src, PROC_REF(process_ending)), 300)

/obj/structure/roguemachine/sacrifice/proc/process_ending()
	var/list/targets = viewers(15, get_turf(src))
	for(var/mob/living/carbon/C in targets)
		C.flash_act()
	if((corrupted || dynamic_roles.len) && !priest_override)
		icon_state = "altar_corrupted"
		GLOB.todoverride = "night"
		settod()
		SSParticleWeather?.run_weather(/datum/particle_weather/blood_rain_storm)
		priest_consequences()
		addomen(OMEN_SUNSTEAL)
		for(var/mob/living/carbon/human/astrater in GLOB.human_list)
			if(istype(astrater.patron, /datum/patron/divine))
				astrater.add_stress(/datum/stressevent/ritualfail)
				if(istype(astrater.patron, /datum/patron/divine/astrata))
					to_chat(astrater, span_userdanger("You feel the pain of [astrater.patron.name]!"))
					astrater.emote_scream()
			else if(istype(astrater.patron, /datum/patron/inhumen))
				astrater.add_stress(/datum/stressevent/ritualsuccess)
		priority_announce("Through the insidious plots of the Heretics, the Rot spreads. Ill omens fall upon these lands. Pray, survive, and endure.", "Ritual Failure", 'sound/misc/deadbell.ogg')
		set_light_color(light_color_heretic)
	else
		if(priest_override)
			priest_consequences()
		for(var/mob/living/carbon/human/astrater in GLOB.human_list)
			if(istype(astrater.patron, /datum/patron/divine))
				astrater.add_stress(/datum/stressevent/ritualsuccess)
		icon_state = "altar_success"
		set_light_color(light_color_divine)
		playsound(src, 'sound/magic/ahh1.ogg', 100, FALSE, -1)
	update_light()

/obj/structure/roguemachine/sacrifice/process()
	if(!is_active && !cancel_due_to_pop && !ritual_finished)
		if((world.time > ritual_start - 1 MINUTES) && !admins_warned)
			if(ritual_check())
				message_admins("The sacrifice ritual meets the criteria. It will begin in ten minutes. [ADMIN_CANCELRITUAL(src)]")
			else
				message_admins("The sacrifice ritual has not met its criteria with ten minutes left. It likely will not trigger.")
			admins_warned = TRUE
		if(world.time > ritual_start)
			if(ritual_check())
				begin_ritual()
			else
				cancel_due_to_pop = TRUE
	else if(is_active && !ritual_finished)
		if(world.time < ritual_end)
			if(world.time > ritual_warning && !countdown_warning)
				say("One minute remains.")
				playsound(src, 'sound/magic/holyshield.ogg', 100, FALSE, -1)
				countdown_warning = TRUE
		if(world.time > ritual_end)
			end_ritual()

/obj/structure/roguemachine/sacrifice/proc/accept_sacrifice(var/mob/living/carbon/human/H)
	var/obj/item/bodypart/BP = H.get_bodypart(pick(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM))
	H.flash_fullscreen("redflash3")
	playsound(H, 'sound/combat/hits/bladed/smallslash (1).ogg', 100, FALSE, -1)
	BP.add_wound(/datum/wound/slash/small)
	H.visible_message("[H] presses [H.p_their()] palm into the edge of the bowl, slicing through the skin.", "You offer your sacrifice.")
	if(H.patron)
		sacrificed_roles[H.job] = H.patron
		if(istype(H.patron, /datum/patron/inhumen))
			corrupted = TRUE
	LAZYREMOVE(dynamic_roles, H.job)
	if(dynamic_roles.len)
		say(pick("Praise the Ten.","For the Ten.","May the Rot fade.","We stand united.","No blight shall trouble us.","Divided, but together.","We shall not go quietly into the rot.","We bleed. For the souls yet unredeemed.","A goat would've worked just as well, you know.","Ascendance is not the future. This is."))
		if(prob(50))
			playsound(src, 'sound/magic/holyshield.ogg', 100, FALSE, -1)
		if(prob(30))
			var/line = "The tithe still requires a sacrifice from: "
			for(var/S in dynamic_roles)
				line += "[S]. "
			say(line)
		delay()
	else
		end_ritual()

/obj/structure/roguemachine/sacrifice/proc/priest_consequences()
	if(HPR)
		HPR.mind?.RemoveSpell(/obj/effect/proc_holder/spell/invoked/revive)
		HPR.mind?.RemoveSpell(/obj/effect/proc_holder/spell/invoked/cure_rot)
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.job in GLOB.church_positions && H.job != "Priest")
			H.mind?.RemoveSpell(/obj/effect/proc_holder/spell/invoked/lesser_heal)

/obj/structure/roguemachine/sacrifice/proc/delay(priest_override = FALSE)
	if(ritual_end)
		if(priest_override)
			if(delay_count < 3)
				ritual_end += delay
				ritual_warning = ritual_end - 1 MINUTES
				delay_count++
				say("The leader of Faith has extended the tithe.")
				playsound(src, 'sound/magic/holyshield.ogg', 100, FALSE, -1)
				return
			else
				return
		else
			ritual_end += delay
			countdown_warning = FALSE
			ritual_warning = ritual_end - 1 MINUTES
		
/obj/structure/roguemachine/sacrifice/proc/draw_window()
	var/list/dat = list()
	// Top-level table
	dat += "<table style='width: 100%; line-height: 20px;border: 1px solid white'>"
	dat += "<center><font size = 5><font color = '#dddada'> YOUR EMINENCE </font></center>"
	// NEXT ROW
	dat += "<tr>"
	dat += "<td style='width:150px;text-align:center;vertical-align: text-top;border: 1px solid white'>"
	dat += "<font size = 4; font color = '#dddada'><b>CHOICES</b></font><br>"
	dat += "<center>"
	if("Priest" in dynamic_roles)
		dat += "<a href='?src=[REF(src)];sacrifice=1'>SACRIFICE</a><br>"
		dat += "-------<br>"
	if(role_removed <= 0)
		dat += "<a href='?src=[REF(src)];removerole=1'>REMOVE ROLE</a><br>"
		dat += "-------<br>"
	if(role_swapped <= 0)
		dat += "<a href='?src=[REF(src)];swaprole=1'>SWAP ROLE</a><br>"
		dat += "-------<br>"
	dat += "<a href='?src=[REF(src)];scry=1'>SCRY</a><br>"
	dat += "-------<br>"
	if(delay_count < 3)
		dat += "<a href='?src=[REF(src)];delay=1'>DELAY</a><br>"
		dat += "-------<br>"
	dat += "<a href='?src=[REF(src)];sacrificeall=1'>SACRIFICE (FOR ALL)</a>"
	dat += "</center>"
	dat += "</td>"
	dat += "<td style='width:50%;text-align:center;vertical-align: text-top'>"
	dat += "<b><font size = 4; font color = '#dddada'>PENDING SOULS</b></font><br>"
	if(dynamic_roles.len)
		for(var/role in dynamic_roles)
			dat += "<b><font color = '#a14040'>[role]</font></b><br>"
	dat += "</td>"
	dat += "<td style='width:33%;text-align:center;vertical-align: text-top;border: 1px solid white'>"
	dat += "<b><font size = 4; font color = '#dddada'>TIME LEFT</b></font><br>"
	var/minsleft = round((ritual_end - world.time) / 600)
	if(minsleft > 0)
		dat += "<b><font size = 5; font color = '#6e0000'>\Roman [minsleft + 1] MINUTES</b></font>"
	else
		dat += "<b><font size = 5; font color = '#6e0000'>LESS THAN A MINUTE</b></font>"
	dat += "</td>"
	dat += "</tr>"
	var/datum/browser/popup = new(HPR, "sacrifice altar", ntitle = "<center>Sacrifice Altar</center>", nwidth = 650, nheight = 400)
	popup.set_content(dat.Join())
	popup.open(FALSE)


/obj/structure/roguemachine/sacrifice/attack_hand(mob/user)
	if(!ishuman(user))
		return
	if(!is_active)
		return
	var/mob/living/carbon/human/H = user
	if(H.job)
		var/J = H.job
		if(J == "Priest")
			if(!HPR)
				HPR = H
			draw_window()
		else if(J in dynamic_roles)
			accept_sacrifice(H)
		else if(J in expected_roles)
			say("Your blood is not needed for this week. Pray.")
			playsound(src, 'sound/magic/holyshield.ogg', 50, FALSE, -1)
		else
			say("Your blood has no value.")

/obj/structure/roguemachine/sacrifice/Topic(href, list/href_list)
	. = ..()

	//Slash your palm and add your blood to the altar.
	if(href_list["sacrifice"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY) && is_active)
		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			accept_sacrifice(H)
		draw_window()

	//Remove a role from pending or already-committed list.
	else if(href_list["removerole"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY) && is_active && role_removed <= 1)
		if(dynamic_roles.len && sacrificed_roles.len)
			var/choice = alert(usr, "Would you like to purge a completed, or pending sacrifice?", "Choice", "Pending", "Completed", "Nevermind")
			switch(choice)
				if("Pending")
					var/list/roles = dynamic_roles.Copy()
					roles.Remove(HPR.job)	//remove Priest from the selection
					var/chosen_role = input(usr, "Which role would you like to remove the demand of?", "REMOVE DEMAND") as null|anything in roles
					if(chosen_role)
						if(chosen_role in dynamic_roles)
							LAZYREMOVE(dynamic_roles, chosen_role)
							to_chat(usr, span_info("You purge the demand of [chosen_role] from the list!"))
							role_removed++
							if(!dynamic_roles.len)	//If the last role is removed, we end the ritual there and then
								end_ritual()
				if("Completed")
					var/chosen_role = input(usr, "Which role's blood would you like to purge?", "REMOVE BLOOD") as null|anything in sacrificed_roles
					if(chosen_role)
						if(istype(sacrificed_roles[chosen_role], /datum/patron/inhumen))
							var/count = 0
							for(var/role in sacrificed_roles)
								if(istype(sacrificed_roles[role], /datum/patron/inhumen))
									count++
							if(count <= 1)	//We are removing the one and only ascendant blood sacrifice, so it resets the corruption.
								corrupted = FALSE
						to_chat(usr, span_info("You purge the blood of [chosen_role] from the altar in all its forms!"))
						sacrificed_roles.Remove(chosen_role)
						role_removed++
				if("Nevermind")
					return
			draw_window()

	//Get a choice of two categories to swap a role with. It picks a random job from those categories.
	else if(href_list["swaprole"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY) && is_active && role_swapped <= 1)
		var/choice = alert(usr, "Would you like to exchange a role for one decided by the gods?", "Choice", "Yes", "No")
		switch(choice)
			if("Yes")
				var/list/roles = dynamic_roles.Copy()
				roles.Remove(HPR.job)	//remove Priest from the selection, cus why tf would you lol
				var/chosen_role = input(usr, "Which role would you like to swap out?", "REMOVE DEMAND") as null|anything in roles

				var/list/allowed_list = swap_roles.Copy()
				var/option_one = pick(allowed_list)
				allowed_list.Remove(option_one)
				var/option_two = pick(allowed_list)

				var/swap = alert(usr, "These are the two major alignments the gods favor.", "CHOOSE THE SWAP", "[option_one]", "[option_two]")

				if(chosen_role && swap)
					if(chosen_role in dynamic_roles)
						LAZYREMOVE(dynamic_roles, chosen_role)
						var/role_to_be_swapped
						var/list/rolelist
						switch(swap)
							if("Garrison")
								rolelist = GLOB.garrison_positions.Copy()
							if("Church")
								rolelist = GLOB.church_positions.Copy()
								rolelist.Remove("Priest")
							if("Inquisition")
								rolelist = GLOB.inquisition_positions.Copy()
							if("Yeomen")
								rolelist = GLOB.yeoman_positions.Copy()
							if("Peasants")
								rolelist = GLOB.peasant_positions.Copy()
								rolelist.Remove("Bandit", "Court Agent","Pilgrim")
							if("Youngfolk")
								rolelist = GLOB.youngfolk_positions.Copy()
							if("Jester")
								role_to_be_swapped = "Jester"
						if(!role_to_be_swapped)	//Not Jester, so we filter for roles that have actual players in them
							shuffle(rolelist)
							for(var/mob/living/carbon/human/H in GLOB.player_list)
								for(var/J in rolelist)
									if(H.job == J)
										role_to_be_swapped = H.job
										break
						if(!role_to_be_swapped)	//If somehow there isn't someone with those roles, allow to reset (Jester is on you, Priest, should've checked in if there was one!)
							to_chat(usr, span_info("No souls with that fate were found. You were given clemency to try again."))
							return
						LAZYADD(dynamic_roles, role_to_be_swapped)
						to_chat(usr, span_info("You purge the demand of [chosen_role] from the list and replace it with [role_to_be_swapped]!"))
						say("[chosen_role] is no longer required. Bring me the blood of \the [role_to_be_swapped]")
						playsound(src, 'sound/magic/holyshield.ogg', 100, FALSE, -1)
						role_swapped++
						draw_window()
			else
				to_chat(HPR, "You reconsider.")
				draw_window()

	else if(href_list["delay"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY) && is_active)
		delay(priest_override = TRUE)
		draw_window()

	else if(href_list["scry"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY) && is_active)
		var/input = input(usr, "Who are you looking for?", "Altar's Peering Eye") as null|anything in dynamic_roles
		if(input)
			if(ishuman(usr))
				var/mob/living/carbon/human/H = usr
				for(var/mob/living/carbon/human/HL in GLOB.player_list)
					if(HL.job == input)
						var/turf/T = get_turf(HL)
						if(!T)
							continue
						if(HAS_TRAIT(HL, TRAIT_ANTISCRYING))
							to_chat(H, span_warning("An impenetrable fog shrouds \the [input]."))
							to_chat(HL, span_warning("My magical shrouding reacted to something."))
							return
						message_admins("SCRYING: [H.real_name] ([H.ckey]) has used the ALTAR to leer at [HL.real_name] ([HL.ckey])")
						log_game("SCRYING: [H.real_name] ([H.ckey]) has used the ALTAR to leer at [HL.real_name] ([HL.ckey])")
						var/mob/dead/observer/screye/S = usr.scry_ghost()
						if(!S)
							return
						S.ManualFollow(HL)
						H.visible_message(span_danger("[H] stares into [src], [H.p_their()] eyes rolling back into [H.p_their()] head."))
						addtimer(CALLBACK(S, TYPE_PROC_REF(/mob/dead/observer, reenter_corpse)), 8 SECONDS)

	else if(href_list["sacrificeall"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY) && is_active && !priest_override)
		end_ritual(override = TRUE)
		draw_window()
	else if(href_list["cancelritual"] && !is_active)
		cancel_due_to_pop = TRUE
		message_admins("Ritual cancelled by [key_name(usr)]")
	return ..()
