
/proc/send_ooc_note(msg, name, job)
	var/list/names_to = list()
	if(name)
		names_to += name
	if(job)
		var/list/L = list()
		if(islist(job))
			L = job
		else
			L += job
		for(var/J in L)
			for(var/mob/living/carbon/human/X in GLOB.human_list)
				if(X.job == J)
					names_to |= X.real_name
	if(names_to.len)
		for(var/mob/living/carbon/human/X in GLOB.human_list)
			if(X.real_name in names_to)
				if(!X.stat)
					to_chat(X, span_biginfo("[msg]"))

SUBSYSTEM_DEF(treasury)
	name = "treasury"
	wait = 1
	priority = FIRE_PRIORITY_WATER_LEVEL
	var/tax_value = 0.11
	var/queens_tax = 0.15
	var/treasury_value = 0
	var/list/bank_accounts = list()
	var/list/noble_incomes = list()
	var/list/stockpile_datums = list()
	var/multiple_item_penalty = 0.66
	var/interest_rate = 0.15
	var/next_treasury_check = 0
	var/list/log_entries = list()
	var/list/vault_accounting = list() //used for the vault count, cleared every fire()
	var/economic_output = 0
	var/total_deposit_tax = 0
	var/total_vault_income = 0
	var/total_noble_income = 0
	var/total_import = 0
	var/total_export = 0

/datum/controller/subsystem/treasury/Initialize()
	treasury_value = rand(500,1000)

	for(var/path in subtypesof(/datum/roguestock/bounty))
		var/datum/D = new path
		stockpile_datums += D
	for(var/path in subtypesof(/datum/roguestock/stockpile))
		var/datum/D = new path
		stockpile_datums += D
	for(var/path in subtypesof(/datum/roguestock/import))
		var/datum/D = new path
		stockpile_datums += D
	return ..()

/datum/controller/subsystem/treasury/fire(resumed = 0)
	if(world.time > next_treasury_check)
		next_treasury_check = world.time + rand(5 MINUTES, 8 MINUTES)
		vault_accounting = list()
		if(SSticker.current_state == GAME_STATE_PLAYING)
			for(var/datum/roguestock/X in stockpile_datums)
				if(!X.stable_price && !X.transport_item)
					if(X.demand < initial(X.demand))
						X.demand += rand(5,15)
					if(X.demand > initial(X.demand))
						X.demand -= rand(5,15)
			for(var/datum/roguestock/stockpile/A in stockpile_datums) //Generate some remote resources
				A.held_items[2] += A.passive_generation
				A.held_items[2] = min(A.held_items[2],10) //To a maximum of 10
		var/area/A = GLOB.areas_by_type[/area/rogue/indoors/town/vault]
		var/amt_to_generate = 0
		for(var/obj/item/I in A)
			if(!isturf(I.loc))
				continue
			amt_to_generate += add_to_vault(I)
		for(var/obj/structure/closet/C in A)
			for(var/obj/item/I in C.contents)
				amt_to_generate += add_to_vault(I)
		amt_to_generate = amt_to_generate - (amt_to_generate * queens_tax)
		amt_to_generate = round(amt_to_generate)
		give_money_treasury(amt_to_generate, "wealth hoard")
		total_vault_income += amt_to_generate
		for(var/obj/structure/roguemachine/vaultbank/VB in A)
			if(istype(VB))
				VB.update_icon()
		send_ooc_note("Income from wealth hoard: +[amt_to_generate]", job = list("Grand Duke", "Steward", "Clerk"))

/datum/controller/subsystem/treasury/proc/add_to_vault(var/obj/item/I)
	if(I.get_real_price() <= 0 || istype(I, /obj/item/roguecoin))
		return
	if(!I.submitted_to_stockpile)
		I.submitted_to_stockpile = TRUE
	if(I.type in vault_accounting)
		vault_accounting[I.type] *= multiple_item_penalty
	else
		vault_accounting[I.type] = I.get_real_price()
	return (vault_accounting[I.type]*interest_rate)

/datum/controller/subsystem/treasury/proc/create_bank_account(name, initial_deposit)
	if(!name)
		return
	if(name in bank_accounts)
		return
	bank_accounts += name
	if(initial_deposit)
		bank_accounts[name] = initial_deposit
	else
		bank_accounts[name] = 0
	return TRUE

//increments the treasury directly (tax collection)
/datum/controller/subsystem/treasury/proc/give_money_treasury(amt, source, silent = FALSE)
	if(!amt)
		return
	treasury_value += amt
	if(silent)
		return
	if(source)
		log_to_steward("+[amt] to treasury ([source])")
	else
		log_to_steward("+[amt] to treasury")

//pays to account from treasury (payroll)
/datum/controller/subsystem/treasury/proc/give_money_account(amt, target, source)
	if(!amt)
		return
	if(!target)
		return
	amt = min(amt, 10000) //No exponentials, please!
	var/target_name = target
	if(istype(target,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = target
		target_name = H.real_name
	var/found_account
	for(var/X in bank_accounts)
		if(X == target)
			if(amt > 0)
				bank_accounts[X] += amt  // Add funds into the player's account
			else
				// Check if the amount to be fined exceeds the player's account balance
				if(abs(amt) > bank_accounts[X])
					send_ooc_note("<b>MEISTER:</b> Error: Insufficient funds in the account to complete the fine.", name = target_name)
					return FALSE  // Return early if the player has insufficient funds
				bank_accounts[X] -= abs(amt)  // Deduct the fine amount from the player's account
			found_account = TRUE
			break
	if(!found_account)
		return FALSE

	if (amt > 0)
		// Player received money
		if(source)
			send_ooc_note("<b>MEISTER:</b> You received [amt]m. ([source])", name = target_name)
			log_to_steward("+[amt] from treasury to [target_name] ([source])")
		else
			send_ooc_note("<b>MEISTER:</b> You received [amt]m.", name = target_name)
			log_to_steward("+[amt] from treasury to [target_name]")
	else
		// Player was fined
		if(source)
			send_ooc_note("<b>MEISTER:</b> You were fined [amt]m. ([source])", name = target_name)
			log_to_steward("[target_name] was fined [amt] ([source])")
		else
			send_ooc_note("<b>MEISTER:</b> You were fined [amt]m.", name = target_name)
			log_to_steward("[target_name] was fined [amt]")

	return TRUE

///Deposits money into a character's bank account. Taxes are deducted from the deposit and added to the treasury.
///@param amt: The amount of money to deposit.
///@param character: The character making the deposit.
///@return TRUE if the money was successfully deposited, FALSE otherwise.
/datum/controller/subsystem/treasury/proc/generate_money_account(amt, mob/living/carbon/human/character)
	if(!amt)
		return FALSE
	if(!character)
		return FALSE
	var/taxed_amount = 0
	var/original_amt = amt
	treasury_value += amt
	if(character in bank_accounts)
		if(HAS_TRAIT(character, TRAIT_NOBLE))
			bank_accounts[character] += amt
		else
			taxed_amount = round(amt * tax_value)
			amt -= taxed_amount
			bank_accounts[character] += amt
	else
		return FALSE

	log_to_steward("+[original_amt] deposited by [character.real_name] of which taxed [taxed_amount]")

	return TRUE


/datum/controller/subsystem/treasury/proc/withdraw_money_account(amt, target)
	if(!amt)
		return
	var/target_name = target
	if(istype(target,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = target
		target_name = H.real_name
	var/found_account
	for(var/X in bank_accounts)
		if(X == target)
			if(bank_accounts[X] < amt)  // Check if the withdrawal amount exceeds the player's account balance
				send_ooc_note("<b>MEISTER:</b> Error: Insufficient funds in the account to complete the withdrawal.", name = target_name)
				return  // Return without processing the transaction
			if(treasury_value < amt)  // Check if the amount exceeds the treasury balance
				send_ooc_note("<b>MEISTER:</b> Error: Insufficient funds in the treasury to complete the transaction.", name = target_name)
				return  // Return early if the treasury balance is insufficient
			bank_accounts[X] -= amt //The account accounts accountingly. Shame on you if you copy this, apple.
			treasury_value -= amt
			found_account = TRUE
			break
	if(!found_account)
		return
	log_to_steward("-[amt] withdrawn by [target_name]")
	return TRUE


/datum/controller/subsystem/treasury/proc/log_to_steward(log)
	log_entries += log
	return
/datum/controller/subsystem/treasury/proc/distribute_estate_incomes()
	for(var/mob/living/welfare_dependant in noble_incomes)
		var/how_much = noble_incomes[welfare_dependant]
		give_money_treasury(how_much, silent = TRUE)
		total_noble_income += how_much
		if(welfare_dependant.job == "Merchant")
			give_money_account(how_much, welfare_dependant, "The Guild")
		else
			give_money_account(how_much, welfare_dependant, "Noble Estate")
