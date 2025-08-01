/obj/structure/roguemachine/noticeboard
	name = "Notice Board"
	desc = "A large wooden notice board, carrying postings from all across Azurea. A ZAD perch sits atop it."
	icon = 'icons/roguetown/misc/64x64.dmi'
	icon_state = "noticeboard0"
	density = TRUE
	anchored = TRUE
	max_integrity = 0
	blade_dulling = DULLING_BASH
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	var/current_category = "Postings"
	var/list/categories = list("Postings", "Premium Postings", "Quests")
	/// Place to deposit completed scrolls or items
	var/input_point

/obj/structure/roguemachine/boardbarrier //Blocks sprite locations
	name = ""
	desc = "A large wooden notice board, carrying postings from all across Azurea. A ZAD perch sits atop it."
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"
	density = TRUE
	anchored = TRUE

/obj/structure/roguemachine/noticeboard/Initialize()
	. = ..()
	SSroguemachine.noticeboards += src
	input_point = locate(x, y - 1, z)
	var/obj/effect/decal/marker_export/marker = new(get_turf(input_point))
	marker.desc = "Place completed quest scrolls here to turn them in."
	marker.layer = ABOVE_OBJ_LAYER

/obj/structure/roguemachine/noticeboard/attackby(obj/item/P, mob/living/carbon/human/user, params)
	. = .. ()
	if(istype(P, /obj/item/paper/scroll/quest))
		turn_in_quest(user, P)
		return
	return

/datum/noticeboardpost
	var/title
	var/truepostername
	var/posterstitle
	var/poster
	var/message
	var/banner

/obj/structure/roguemachine/noticeboard/examine(mob/living/carbon/human/user)
	. = ..()
	if(!ishuman(user))
		return
	if(user in GLOB.board_viewers)
		return
	else
		GLOB.board_viewers += user
		to_chat(user, span_smallred("A new posting has been made since I last checked!"))

/obj/structure/roguemachine/noticeboard/update_icon()
	. = ..()
	var/total_length = length(GLOB.noticeboard_posts) + length(GLOB.premium_noticeboardposts)
	switch(total_length)
		if(0)
			icon_state = "noticeboard0"
		if(1 to 3)
			icon_state = "noticeboard1"
		if(4 to 6)
			icon_state = "noticeboard2"
		else
			icon_state = "noticeboard3"

/obj/structure/roguemachine/noticeboard/Topic(href, href_list)
	. = ..()
	if(!usr.canUseTopic(src, BE_CLOSE))
		return
	if(href_list["changecategory"])
		current_category = href_list["changecategory"]
	if(href_list["makepost"])
		make_post(usr)
		return attack_hand(usr)
	if(href_list["premiumpost"])
		premium_post(usr)
		return attack_hand(usr)
	if(href_list["removepost"])
		remove_post(usr)
		return attack_hand(usr)
	if(href_list["authorityremovepost"])
		authority_removepost(usr)
		return attack_hand(usr) 
	if(href_list["consultquests"])
		consult_quests(usr)
		return attack_hand(usr) 
	if(href_list["turninquest"])
		turn_in_quest(usr)
		return attack_hand(usr) 
	if(href_list["abandonquest"])
		abandon_quest(usr)
		return attack_hand(usr) 
	if(href_list["printquests"])
		print_quests(usr)
		return attack_hand(usr) 
	return attack_hand(usr)

/obj/structure/roguemachine/noticeboard/attack_hand(mob/living/carbon/human/user)
	if(!ishuman(user)) 
		return
	var/can_remove = FALSE
	var/can_premium = FALSE
	if(user.job in list("Man at Arms","Inquisitor", "Knight", "Sergeant", "Knight Captain", "Orthodoxist", "Absolutionist",))
		can_remove = TRUE
	if(user.job in list("Bathmaster","Merchant", "Innkeeper", "Steward", "Court Magician"))
		can_premium = TRUE
	var/contents
	contents += "<center>NOTICEBOARD<BR>"
	contents += "--------------<BR>"
	var/selection = "Categories: "
	for(var/i = 1, i <= length(categories), i++)
		var/category = categories[i]
		if(category == current_category)
			selection += "<b>[current_category]</b>"
		else if(i != length(categories))
			selection += "<a href='?src=[REF(src)];changecategory=[category]'>[category]</a> | "
		else
			selection += "<a href='?src=[REF(src)];changecategory=[category]'>[category]</a> "
	contents += selection + "<BR>"
	if(current_category in list("Postings", "Premium Postings"))
		contents += "<a href='?src=[REF(src)];makepost=1'>Make a Posting</a>"
		if(can_premium)
			contents += " | <a href='?src=[REF(src)];premiumpost=1'>Make a Premium Posting</a><br>"
		else
			contents += "<br>"
		contents += "<a href='?src=[REF(src)];removepost=1'>Remove my Posting</a><br>"
		if(can_remove)
			contents += "<a href='?src=[REF(src)];authorityremovepost=1'>Authority: Remove a Posting</a>"
		var/board_empty = TRUE
		switch(current_category)
			if("Postings")
				for(var/datum/noticeboardpost/saved_post in GLOB.noticeboard_posts)
					contents += saved_post.banner
					board_empty = FALSE
			if("Premium Postings")
				for(var/datum/noticeboardpost/saved_post in GLOB.premium_noticeboardposts)
					contents += saved_post.banner
					board_empty = FALSE
		if(board_empty)
			contents += "<br><span class='notice'>No postings have been made yet!</span>"
	else if(current_category == "Quests")
		contents += "<a href='?src=[REF(src)];consultquests=1'>Consult Quests</a><br>"
		contents += "<a href='?src=[REF(src)];turninquest=1'>Turn in Quest</a><br>"
		contents += "<a href='?src=[REF(src)];abandonquest=1'>Abandon Quest</a><br>"
		if(user.job == "Steward" || user.job == "Merchant")
			contents += "<a href='?src=[REF(src)];printquests=1'>Print Issued Quests</a><br>"
	var/datum/browser/popup = new(user, "NOTICEBOARD", "", 800, 650)
	popup.set_content(contents)
	popup.open()

/obj/structure/roguemachine/noticeboard/proc/premium_post(mob/living/carbon/human/guy)
	if(guy.has_status_effect(/datum/status_effect/debuff/postcooldown))
		to_chat(guy, span_warning("I must wait a time until my next posting..."))
		return
	var/inputtitle = input(guy, "What shall the title of my posting be?", "NOTICEBOARD", null)
	if(!inputtitle)
		return
	var/inputmessage = stripped_multiline_input(guy, "What shall I write for this posting?", "NOTICEBOARD", no_trim=TRUE)
	if(inputmessage)
		if(length(inputmessage) > 2000)
			to_chat(guy, span_warning("Too long! You shall surely overburden the with this novel!"))
			return
	else
		return
	var/inputname = input(guy, "What name shall I use on the posting?", "NOTICEBOARD", null)
	if(!inputname)
		return
	var/inputrole = input(guy, "What personal title shall I use on the posting?", "NOTICEBOARD", null)
	add_post(inputmessage, inputtitle, inputname, inputrole, guy.real_name, TRUE)
	guy.apply_status_effect(/datum/status_effect/debuff/postcooldown)
	message_admins("[ADMIN_LOOKUPFLW(guy)] has made a notice board post. The message was: [inputmessage]")
	for(var/obj/structure/roguemachine/noticeboard/board in SSroguemachine.noticeboards)
		if(board != src)
			playsound(board, 'sound/ambience/noises/birds (7).ogg', 50, FALSE, -1)
			board.visible_message(span_smallred("A ZAD lands, delivering a new posting!"))
			board.update_icon()

/obj/structure/roguemachine/noticeboard/proc/make_post(mob/living/carbon/human/guy)
	if(guy.has_status_effect(/datum/status_effect/debuff/postcooldown))
		to_chat(guy, span_warning("I must wait a time until my next posting..."))
		return
	var/inputtitle = stripped_input(guy, "What shall the title of my posting be?", "NOTICEBOARD", null)
	if(!inputtitle)
		return
	if(length(inputtitle) > 50)
		to_chat(guy, span_warning("Too long! You shall surely overburden the zad with this novel!"))
		return
	var/inputmessage = stripped_multiline_input(guy, "What shall I write for this posting?", "NOTICEBOARD", no_trim=TRUE)
	if(inputmessage)
		if(length(inputmessage) > 2000)
			to_chat(guy, span_warning("Too long! You shall surely overburden the zad with this novel!"))
			return
	else
		return
	var/inputname = stripped_input(guy, "What name shall I use on the posting?", "NOTICEBOARD", null)
	if(!inputname)
		return
	if(length(inputname) > 50)
		to_chat(guy, span_warning("Too long! You shall surely overburden the zad with this novel!"))
		return
	var/inputrole = stripped_input(guy, "What personal title shall I use on the posting?", "NOTICEBOARD", null)
	if(length(inputrole) > 50)
		to_chat(guy, span_warning("Too long! You shall surely overburden the zad with this novel!"))
		return
	add_post(inputmessage, inputtitle, inputname, inputrole, guy.real_name, FALSE)
	guy.apply_status_effect(/datum/status_effect/debuff/postcooldown)
	message_admins("[ADMIN_LOOKUPFLW(guy)] has made a notice board post. The message was: [inputmessage]")
	for(var/obj/structure/roguemachine/noticeboard/board in SSroguemachine.noticeboards)
		board.update_icon()
		if(board != src)
			playsound(board, 'sound/ambience/noises/birds (7).ogg', 50, FALSE, -1)
			board.visible_message(span_smallred("A ZAD lands, delivering a new posting!"))

/obj/structure/roguemachine/noticeboard/proc/remove_post(mob/living/carbon/human/guy)
	var/list/myposts_list = list()
	for(var/datum/noticeboardpost/removable_posts in GLOB.noticeboard_posts)
		if(removable_posts.truepostername == guy.real_name)
			myposts_list += removable_posts.title
	for(var/datum/noticeboardpost/removable_postspremium in GLOB.premium_noticeboardposts)
		if(removable_postspremium.truepostername == guy.real_name)
			myposts_list += removable_postspremium.title
	if(!myposts_list.len)
		to_chat(guy, span_warning("There are no posts I can take down."))
		return
	var/post2remove = input(guy, "Which post shall I take down?", src) as null|anything in myposts_list
	if(!post2remove)
		return
	playsound(loc, 'sound/foley/dropsound/paper_drop.ogg', 50, FALSE, -1)
	loc.visible_message(span_smallred("[guy] tears down a posting!"))
	for(var/datum/noticeboardpost/removing_post in GLOB.noticeboard_posts)
		if(post2remove == removing_post.title && removing_post.truepostername == guy.real_name)
			GLOB.noticeboard_posts -= removing_post
			message_admins("[ADMIN_LOOKUPFLW(guy)] has removed their post, the message was [removing_post.message]")
	for(var/datum/noticeboardpost/removing_post in GLOB.premium_noticeboardposts)
		if(post2remove == removing_post.title && removing_post.truepostername == guy.real_name)
			GLOB.premium_noticeboardposts -= removing_post
			message_admins("[ADMIN_LOOKUPFLW(guy)] has removed their post, the message was [removing_post.message]")
	for(var/obj/structure/roguemachine/noticeboard/board in SSroguemachine.noticeboards)
		board.update_icon()
		if(board != src)
			playsound(board, 'sound/ambience/noises/birds (7).ogg', 50, FALSE, -1)
			board.visible_message(span_smallred("A ZAD lands, removing an old posting!"))

/obj/structure/roguemachine/noticeboard/proc/authority_removepost(mob/living/carbon/human/guy)
	var/list/posts_list = list()
	for(var/datum/noticeboardpost/removable_posts in GLOB.noticeboard_posts)
		posts_list += removable_posts.title
	if(!posts_list.len)
		to_chat(guy, span_warning("There are no posts I can take down."))
		return
	var/post2remove = input(guy, "Which post shall I take down?", src) as null|anything in posts_list
	if(!post2remove)
		return
	playsound(loc, 'sound/foley/dropsound/paper_drop.ogg', 50, FALSE, -1)
	loc.visible_message(span_smallred("[guy] tears down a posting!"))
	for(var/datum/noticeboardpost/removing_post in GLOB.noticeboard_posts)
		if(post2remove == removing_post.title)
			GLOB.noticeboard_posts -= removing_post
			message_admins("[ADMIN_LOOKUPFLW(guy)] has authoritavely removed a post, the message was [removing_post.message]")



/proc/add_post(message, chosentitle, chosenname, chosenrole, truename, premium)
	var/datum/noticeboardpost/new_post = new /datum/noticeboardpost
	new_post.poster = chosenname
	new_post.title = chosentitle
	new_post.message = message
	new_post.posterstitle = chosenrole
	new_post.truepostername = truename
	compose_post(new_post)
	GLOB.board_viewers = list()
	if(!premium)
		GLOB.noticeboard_posts += new_post
	else
		GLOB.premium_noticeboardposts += new_post



/proc/compose_post(datum/noticeboardpost/new_post)
	new_post.banner += "<center><b>[new_post.title]</b><BR>"
	new_post.banner += "[new_post.message]<BR>"
	new_post.banner += "- [new_post.poster]"
	if(new_post.posterstitle)
		new_post.banner += ", [new_post.posterstitle]"
	new_post.banner += "<BR>"
	new_post.banner += "--------------<BR>"

/datum/status_effect/debuff/postcooldown
	id = "postcooldown"
	duration = 5 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/debuff/postcooldown

/atom/movable/screen/alert/status_effect/debuff/postcooldown
	name = "Recent messenger"
	desc = "I'll have to wait a bit before making another posting!"

/obj/structure/roguemachine/noticeboard/proc/consult_quests(mob/user)
	if(!(user in SStreasury.bank_accounts))
		say("You have no bank account.")
		return

	var/list/difficulty_data = list(
		QUEST_DIFFICULTY_EASY = list(
			deposit = QUEST_DEPOSIT_EASY, 
			reward_min = QUEST_REWARD_EASY_LOW, 
			reward_max = QUEST_REWARD_EASY_HIGH, 
			icon = "scroll_quest_low"
		),
		QUEST_DIFFICULTY_MEDIUM = list(
			deposit = QUEST_DEPOSIT_MEDIUM, 
			reward_min = QUEST_REWARD_MEDIUM_LOW, 
			reward_max = QUEST_REWARD_MEDIUM_HIGH, 
			icon = "scroll_quest_mid"
		),
		QUEST_DIFFICULTY_HARD = list(
			deposit = QUEST_DEPOSIT_HARD, 
			reward_min = QUEST_REWARD_HARD_LOW, 
			reward_max = QUEST_REWARD_HARD_HIGH, 
			icon = "scroll_quest_high"
		)
	)

	// Create a list with formatted difficulty choices showing deposits
	var/list/difficulty_choices = list()
	for(var/difficulty in difficulty_data)
		var/deposit = difficulty_data[difficulty]["deposit"]
		difficulty_choices["[difficulty] ([deposit] mammon deposit)"] = difficulty

	var/selection = input(user, "Select quest difficulty (deposit required)", src) as null|anything in difficulty_choices
	if(!selection)
		return

	// Get the actual difficulty key from our formatted choice
	var/actual_difficulty = difficulty_choices[selection]
	var/deposit = difficulty_data[actual_difficulty]["deposit"]

	if(SStreasury.bank_accounts[user] < deposit)
		say("Insufficient balance funds. You need [deposit] mammons in your meister.")
		return

	var/list/type_choices = list(
		QUEST_DIFFICULTY_EASY = list(QUEST_FETCH, QUEST_COURIER, QUEST_KILL),
		QUEST_DIFFICULTY_MEDIUM = list(QUEST_CLEAR_OUT),
		QUEST_DIFFICULTY_HARD = list(QUEST_MINIBOSS)
	)

	var/type_selection = input(user, "Select quest type", src) as null|anything in type_choices[actual_difficulty] // Changed from selection to actual_difficulty
	if(!type_selection)
		return

	// Continue with the rest of the proc using actual_difficulty instead of selection
	var/datum/quest/attached_quest = new()
	attached_quest.reward_amount = rand(difficulty_data[actual_difficulty]["reward_min"], difficulty_data[actual_difficulty]["reward_max"]) // Changed from selection to actual_difficulty
	attached_quest.quest_difficulty = actual_difficulty // Changed from selection to actual_difficulty
	attached_quest.quest_type = type_selection

	var/obj/item/paper/scroll/quest/spawned_scroll = new(get_turf(src))
	user.put_in_hands(spawned_scroll)
	spawned_scroll.base_icon_state = difficulty_data[actual_difficulty]["icon"] // Changed from selection to actual_difficulty
	spawned_scroll.assigned_quest = attached_quest
	attached_quest.quest_scroll_ref = WEAKREF(spawned_scroll)

	if(user.job != "Merchant" && user.job != "Steward")
		attached_quest.quest_receiver_reference = WEAKREF(user)
		attached_quest.quest_receiver_name = user.real_name
	else
		attached_quest.quest_giver_name = user.real_name
		attached_quest.quest_giver_reference = WEAKREF(user)

	var/obj/effect/landmark/quest_spawner/chosen_landmark = find_quest_landmark(actual_difficulty, type_selection) // Changed from selection to actual_difficulty
	if(!chosen_landmark)
		to_chat(user, span_warning("No suitable location found for this quest!"))
		qdel(attached_quest)
		qdel(spawned_scroll)
		return

	chosen_landmark.generate_quest(attached_quest, (user.job == "Steward" || user.job == "Merchant") ? null : user)
	spawned_scroll.update_quest_text()
	SStreasury.bank_accounts[user] -= deposit
	SStreasury.treasury_value += deposit
	SStreasury.log_entries += "+[deposit] to treasury (quest deposit)"

/obj/structure/roguemachine/noticeboard/proc/find_quest_landmark(difficulty, type)
	// First try to find landmarks that match both difficulty AND type
	var/list/correctest_landmarks = list()
	GLOB.quest_landmarks_list = shuffle(GLOB.quest_landmarks_list)
	for(var/obj/effect/landmark/quest_spawner/landmark in GLOB.quest_landmarks_list)
		if(landmark.quest_difficulty != difficulty || !(type in landmark.quest_type))
			continue

		var/has_clients_around = FALSE
		for(var/mob/M in get_hearers_in_view(world.view, landmark))
			if(!M.client)
				continue

			has_clients_around = TRUE

		if(has_clients_around)
			continue

		correctest_landmarks += landmark

	if(length(correctest_landmarks))
		return pick(correctest_landmarks)

	// If none found, try landmarks that match just the difficulty
	var/list/correcter_landmarks = list()
	for(var/obj/effect/landmark/quest_spawner/landmark in GLOB.quest_landmarks_list)
		if(landmark.quest_difficulty != difficulty)
			continue

		var/has_clients_around = FALSE
		for(var/mob/M in get_hearers_in_view(world.view, landmark))
			if(!M.client)
				continue

			has_clients_around = TRUE

		if(has_clients_around)
			continue

		correcter_landmarks += landmark

	if(length(correcter_landmarks))
		return pick(correcter_landmarks)

	return null

/obj/structure/roguemachine/noticeboard/proc/turn_in_quest(mob/user, obj/item/paper/scroll/quest/scroll_in_hand)
	var/obj/item/paper/scroll/quest/target_scroll = null

	if(scroll_in_hand)
		target_scroll = scroll_in_hand
		turn_in_scroll(user, target_scroll)
	else
		for(var/atom/movable/pawnable_loot in input_point)
			if(istype(pawnable_loot, /obj/item/paper/scroll/quest))
				target_scroll = pawnable_loot
				turn_in_scroll(user, target_scroll)


/obj/structure/roguemachine/noticeboard/proc/turn_in_scroll(mob/user, obj/item/paper/scroll/quest/scroll)
	var/reward = 0
	var/original_reward = 0
	var/total_deposit_return = 0
	if(scroll.assigned_quest?.complete)
		// Calculate base reward
		var/base_reward = scroll.assigned_quest.reward_amount
		original_reward += base_reward
		
		// Calculate deposit return based on difficulty
		var/deposit_return = scroll.assigned_quest.quest_difficulty == QUEST_DIFFICULTY_EASY ? QUEST_DEPOSIT_EASY : \
							scroll.assigned_quest.quest_difficulty == QUEST_DIFFICULTY_MEDIUM ? QUEST_DEPOSIT_MEDIUM : QUEST_DEPOSIT_HARD
		total_deposit_return += deposit_return
		
		// Apply Steward/Mechant bonus if applicable (only to the base reward)
		if(user.job == "Steward" || user.job == "Merchant")
			reward += base_reward * QUEST_HANDLER_REWARD_MULTIPLIER
		else
			reward += base_reward
		
		// Add deposit return to both reward totals
		reward += deposit_return
		original_reward += deposit_return
		
		qdel(scroll.assigned_quest)
		qdel(scroll)

	cash_in(round(reward), original_reward)

/obj/structure/roguemachine/noticeboard/proc/cash_in(reward, original_reward)
	var/list/coin_types = list(
		/obj/item/roguecoin/gold = FLOOR(reward / 10, 1),
		/obj/item/roguecoin/silver = FLOOR(reward % 10 / 5, 1),
		/obj/item/roguecoin/copper = reward % 5
	)

	for(var/coin_type in coin_types)
		var/amount = coin_types[coin_type]
		if(amount > 0)
			var/obj/item/roguecoin/coin_stack = new coin_type(get_turf(src))
			coin_stack.quantity = amount
			coin_stack.update_icon()
			coin_stack.update_transform()

	if(reward > 0)
		say(reward != original_reward ? \
			"Your handler assistance-increased reward of [reward] mammons has been dispensed! The difference is [reward - original_reward] mammons." : \
			"Your reward of [reward] mammons has been dispensed.")

/obj/structure/roguemachine/noticeboard/proc/abandon_quest(mob/user)
	var/obj/item/paper/scroll/quest/abandoned_scroll = locate() in input_point
	if(!abandoned_scroll)
		to_chat(user, span_warning("No quest scroll found in the input area!"))
		return

	var/datum/quest/quest = abandoned_scroll.assigned_quest
	if(!quest)
		to_chat(user, span_warning("This scroll doesn't have an assigned quest!"))
		return

	if(quest.complete)
		turn_in_quest(user)
		return

	var/refund = quest.quest_difficulty == QUEST_DIFFICULTY_EASY ? QUEST_DEPOSIT_EASY : \
				quest.quest_difficulty == QUEST_DIFFICULTY_MEDIUM ? QUEST_DEPOSIT_MEDIUM : QUEST_DEPOSIT_HARD

	// First try to return to quest giver
	var/mob/giver = quest.quest_giver_reference?.resolve()
	if(giver && (giver in SStreasury.bank_accounts))
		SStreasury.bank_accounts[giver] += refund
		SStreasury.treasury_value -= refund
		SStreasury.log_entries += "-[refund] from treasury (quest refund to handler)"
		to_chat(user, span_notice("The deposit has been returned to the quest giver."))
	// Otherwise try quest receiver
	else if(quest.quest_receiver_reference)
		var/mob/receiver = quest.quest_receiver_reference.resolve()
		if(receiver && (receiver in SStreasury.bank_accounts))
			SStreasury.bank_accounts[receiver] += refund
			SStreasury.treasury_value -= refund
			SStreasury.log_entries += "-[refund] from treasury (quest refund to volunteer)"
			to_chat(user, span_notice("You receive a [refund] mammon refund for abandoning the quest."))
		else
			cash_in(refund)
			SStreasury.treasury_value -= refund
			SStreasury.log_entries += "-[refund] from treasury (quest refund)"
			to_chat(user, span_notice("Your refund of [refund] mammon has been dispensed."))

	// Clean up quest items
	if(quest.quest_type == QUEST_COURIER && quest.target_delivery_item)
		quest.target_delivery_item = null
		for(var/obj/item/I in world)
			if(istype(I, quest.target_delivery_item))
				var/datum/component/quest_object/Q = I.GetComponent(/datum/component/quest_object)
				if(Q && Q.quest_ref == WEAKREF(quest))
					I.remove_filter("quest_item_outline")
					qdel(Q)
					qdel(I)

	abandoned_scroll.assigned_quest = null
	qdel(quest)
	qdel(abandoned_scroll)

/obj/structure/roguemachine/noticeboard/proc/print_quests(mob/user)
	var/list/active_quests = list()
	for(var/obj/item/paper/scroll/quest/quest_scroll in world)
		if(quest_scroll.assigned_quest && !quest_scroll.assigned_quest.complete)
			active_quests += quest_scroll

	if(!length(active_quests))
		say("No active quests found.")
		return

	var/obj/item/paper/scroll/report = new(get_turf(src))
	report.name = "Guild Quest Report"
	report.desc = "A list of currently active quests issued by the Adventurers' Guild."

	var/report_text = "<center><b>ADVENTURER'S GUILD - ACTIVE QUESTS</b></center><br><br>"
	report_text += "<i>Generated on [station_time_timestamp()]</i><br><br>"

	for(var/obj/item/paper/scroll/quest/quest_scroll in active_quests)
		var/datum/quest/quest = quest_scroll.assigned_quest
		var/area/quest_area = get_area(quest_scroll)
		report_text += "<b>Title:</b> [quest.title].<br>"
		report_text += "<b>Recipient:</b> [quest.quest_receiver_name ? quest.quest_receiver_name : "Unclaimed"].<br>"
		report_text += "<b>Type:</b> [quest.quest_type].<br>"
		report_text += "<b>Difficulty:</b> [quest.quest_difficulty].<br>"
		report_text += "<b>Last Known Location:</b> [quest_area ? quest_area.name : "Unknown Location"].<br>"
		report_text += "<b>Reward:</b> [quest.reward_amount] mammons.<br><br>"

	report.info = report_text
	say("Quest report printed.")
