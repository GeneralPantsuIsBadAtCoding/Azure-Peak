/obj/structure/roguemachine/questgiver
	name = "grand quest book"
	desc = "A large wooden notice board, carrying postings from all across Azuria. A crow's perch sits atop it."
	icon = 'code/modules/roguetown/roguemachine/questing/questing.dmi'
	icon_state = "questgiver"
	density = TRUE
	anchored = TRUE
	max_integrity = 0
	blade_dulling = DULLING_BASH
	/// Whether it's the main guild quest giver
	var/guild = FALSE
	/// Place to deposit completed scrolls or items
	var/input_point
	/// Place to spawn scrolls or rewards
	var/scroll_point
	/// Items that can be sold directly through the guild
	var/list/sellable_items = list()

/obj/structure/roguemachine/questgiver/Initialize()
	. = ..()
	SSroguemachine.questgivers += src
	input_point = locate(x, y - 1, z)
	scroll_point = locate(x, y, z)

	var/obj/effect/decal/marker_export/marker = new(get_turf(input_point))
	marker.desc = "Place completed quest scrolls here to turn them in."
	marker.layer = ABOVE_OBJ_LAYER

/obj/structure/roguemachine/questgiver/examine(mob/user)
	. = ..()
	if(guild)
		. += span_notice("This quest book will give <b>bigger rewards</b> if processed with the help of a <b>steward or merchant</b>!")

/obj/structure/roguemachine/questgiver/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return

	var/list/choices = list("Consult Quests", "Turn In Quest", "Abandon Quest")
	if(guild && (user.job == "Steward" || user.job == "Merchant"))
		choices += "Print Issued Quests"

	var/selection = input(user, "The Excidium listens", src) as null|anything in choices
	if(!selection)
		return

	switch(selection)
		if("Consult Quests")
			consult_quests(user)
		if("Turn In Quest")
			turn_in_quest(user)
		if("Abandon Quest")
			abandon_quest(user)
		if("Print Issued Quests")
			print_quests(user)

/obj/structure/roguemachine/questgiver/proc/consult_quests(mob/user)
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

	var/selection = input(user, "Select quest difficulty", src) as null|anything in difficulty_data
	if(!selection)
		return

	var/deposit = difficulty_data[selection]["deposit"]
	if(SStreasury.bank_accounts[user] < deposit)
		say("Insufficient balance funds. You need [deposit] mammons in your meister.")
		return

	var/list/type_choices = list(
		QUEST_DIFFICULTY_EASY = list(QUEST_FETCH, QUEST_COURIER, QUEST_KILL),
		QUEST_DIFFICULTY_MEDIUM = list(QUEST_KILL, QUEST_CLEAR_OUT),
		QUEST_DIFFICULTY_HARD = list(QUEST_CLEAR_OUT, QUEST_MINIBOSS)
	)

	var/type_selection = input(user, "Select quest type", src) as null|anything in type_choices[selection]
	if(!type_selection)
		return

	var/datum/quest/attached_quest = new()
	attached_quest.reward_amount = rand(difficulty_data[selection]["reward_min"], difficulty_data[selection]["reward_max"])
	attached_quest.quest_difficulty = selection
	attached_quest.quest_type = type_selection

	var/obj/item/paper/scroll/quest/spawned_scroll = new(get_turf(scroll_point))
	spawned_scroll.base_icon_state = difficulty_data[selection]["icon"]
	spawned_scroll.assigned_quest = attached_quest
	attached_quest.quest_scroll_ref = WEAKREF(spawned_scroll)

	if(user.job != "Merchant" && user.job != "Steward")
		attached_quest.quest_receiver_reference = WEAKREF(user)
		attached_quest.quest_receiver_name = user.real_name
	else
		attached_quest.quest_giver_name = user.real_name
		attached_quest.quest_giver_reference = WEAKREF(user)

	var/obj/effect/landmark/quest_spawner/chosen_landmark = find_quest_landmark(selection, type_selection)
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

/obj/structure/roguemachine/questgiver/proc/find_quest_landmark(difficulty, type)
	// First try to find landmarks that match both difficulty AND type
	var/list/correctest_landmarks = list()
	for(var/obj/effect/landmark/quest_spawner/landmark in GLOB.landmarks_list)
		if(landmark.quest_difficulty == difficulty && (type in landmark.quest_type))
			correctest_landmarks += landmark

	if(length(correctest_landmarks))
		return pick(correctest_landmarks)

	// If none found, try landmarks that match just the difficulty
	var/list/correcter_landmarks = list()
	for(var/obj/effect/landmark/quest_spawner/landmark in GLOB.landmarks_list)
		if(landmark.quest_difficulty == difficulty)
			correcter_landmarks += landmark

	if(length(correcter_landmarks))
		return pick(correcter_landmarks)

	// If still none found, return a random landmark as fallback
	var/list/fallback_landmarks = list()
	for(var/obj/effect/landmark/quest_spawner/landmark in GLOB.landmarks_list)
		fallback_landmarks += landmark

	if(length(fallback_landmarks))
		return pick(fallback_landmarks)

	return null

/obj/structure/roguemachine/questgiver/proc/turn_in_quest(mob/user)
	var/reward = 0
	var/original_reward = 0
	var/total_deposit_return = 0

	for(var/atom/movable/pawnable_loot in input_point)
		if(istype(pawnable_loot, /obj/item/paper/scroll/quest))
			var/obj/item/paper/scroll/quest/turned_in_scroll = pawnable_loot
			if(turned_in_scroll.assigned_quest?.complete)
				// Calculate base reward
				var/base_reward = turned_in_scroll.assigned_quest.reward_amount
				original_reward += base_reward
				
				// Calculate deposit return based on difficulty
				var/deposit_return = turned_in_scroll.assigned_quest.quest_difficulty == QUEST_DIFFICULTY_EASY ? QUEST_DEPOSIT_EASY : \
									turned_in_scroll.assigned_quest.quest_difficulty == QUEST_DIFFICULTY_MEDIUM ? QUEST_DEPOSIT_MEDIUM : QUEST_DEPOSIT_HARD
				total_deposit_return += deposit_return
				
				// Apply Steward/Mechant bonus if applicable (only to the base reward)
				if(guild && (user.job == "Steward" || user.job == "Merchant"))
					reward += base_reward * QUEST_HANDLER_REWARD_MULTIPLIER
				else
					reward += base_reward
				
				// Add deposit return to both reward totals
				reward += deposit_return
				original_reward += deposit_return
				
				qdel(turned_in_scroll.assigned_quest)
				qdel(turned_in_scroll)
				continue

		if(guild && is_type_in_list(pawnable_loot, sellable_items))
			var/obj/item/to_sell = pawnable_loot
			if(to_sell.get_real_price() > 0)
				reward += to_sell.sellprice
				qdel(to_sell)
				continue

	cash_in(round(reward), original_reward)

/obj/structure/roguemachine/questgiver/proc/cash_in(reward, original_reward)
	var/list/coin_types = list(
		/obj/item/roguecoin/gold = FLOOR(reward / 10, 1),
		/obj/item/roguecoin/silver = FLOOR(reward % 10 / 5, 1),
		/obj/item/roguecoin/copper = reward % 5
	)

	for(var/coin_type in coin_types)
		var/amount = coin_types[coin_type]
		if(amount > 0)
			var/obj/item/roguecoin/coin_stack = new coin_type(scroll_point)
			coin_stack.quantity = amount
			coin_stack.update_icon()
			coin_stack.update_transform()

	if(reward > 0)
		say(reward != original_reward ? \
			"Your handler assistance-increased reward of [reward] marks has been dispensed! The difference is [reward - original_reward] marks." : \
			"Your reward of [reward] marks has been dispensed.")

/obj/structure/roguemachine/questgiver/proc/abandon_quest(mob/user)
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

/obj/structure/roguemachine/questgiver/proc/print_quests(mob/user)
	if(!guild)
		return

	var/list/active_quests = list()
	for(var/obj/item/paper/scroll/quest/quest_scroll in world)
		if(quest_scroll.assigned_quest && !quest_scroll.assigned_quest.complete)
			active_quests += quest_scroll

	if(!length(active_quests))
		say("No active quests found.")
		return

	var/obj/item/paper/scroll/report = new(get_turf(scroll_point))
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
		report_text += "<b>Reward:</b> [quest.reward_amount] marks.<br><br>"

	report.info = report_text
	say("Quest report printed.")

/obj/structure/roguemachine/questgiver/guild
	guild = TRUE
	icon_state = "questgiver_guild"
