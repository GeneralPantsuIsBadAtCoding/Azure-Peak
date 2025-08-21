#define RURAL_TAX 50 // Free money. A small safety pool for lowpop mostly
#define TREASURY_TICK_AMOUNT 6 MINUTES
#define EXPORT_ANNOUNCE_THRESHOLD 100

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
	var/queens_tax = 0.10
	var/treasury_value = 0
	var/mint_multiplier = 0.8 // 1x is meant to leave a margin after standard 80% collectable. Less than Bathmatron.
	var/minted = 0
	var/autoexport_percentage = 0.6 // Percentage above which stockpiles will automatically export  
	var/list/bank_accounts = list()
	var/list/noble_incomes = list()
	var/list/stockpile_datums = list()
	var/next_treasury_check = 0
	var/list/log_entries = list()
	var/economic_output = 0
	var/total_deposit_tax = 0
	var/total_rural_tax = 0
	var/total_noble_income = 0
	var/total_import = 0
	var/total_export = 0

/datum/controller/subsystem/treasury/Initialize()
	treasury_value = rand(1000, 2000)

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
		next_treasury_check = world.time + TREASURY_TICK_AMOUNT
		if(SSticker.current_state == GAME_STATE_PLAYING)
			for(var/datum/roguestock/X in stockpile_datums)
				if(!X.stable_price && !X.mint_item)
					if(X.demand < initial(X.demand))
						X.demand += rand(5,15)
					if(X.demand > initial(X.demand))
						X.demand -= rand(5,15)
			for(var/datum/roguestock/stockpile/A in stockpile_datums) //Generate some remote resources
				A.held_items[2] += A.passive_generation
				A.held_items[2] = min(A.held_items[2],10) //To a maximum of 10
		var/area/A = GLOB.areas_by_type[/area/rogue/indoors/town/vault]
		for(var/obj/structure/roguemachine/vaultbank/VB in A)
			if(istype(VB))
				VB.update_icon()
		give_money_treasury(RURAL_TAX, "Rural Tax Collection") //Give the King's purse to the treasury
		total_rural_tax += RURAL_TAX
		auto_export()

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

/datum/controller/subsystem/treasury/proc/do_export(var/datum/roguestock/D, silent = FALSE)
	if((D.held_items[1] < D.importexport_amt))
		return FALSE
	var/amt = D.get_export_price()

	// You should only export from town stockpiles, not from remote. Remote is meant
	// To fulfill local economic shortfall and not to make $$ for the steward.
	if(D.held_items[1] >= D.importexport_amt)
		D.held_items[1] -= D.importexport_amt

	SStreasury.treasury_value += amt
	SStreasury.total_export += amt
	SStreasury.log_to_steward("+[amt] exported [D.name]")
	if(!silent && amt >= EXPORT_ANNOUNCE_THRESHOLD) //Only announce big spending.
		scom_announce("Azure Peak exports [D.name] for [amt] mammon.")
	D.lower_demand()
	return amt

/datum/controller/subsystem/treasury/proc/auto_export()
	var/total_value_exported = 0 
	for(var/datum/roguestock/D in stockpile_datums)
		if(!D.importexport_amt)
			continue
		if((autoexport_percentage * D.stockpile_limit) >= D.held_items[1])
			continue // We only auto export if above the auto export percentage.
		// We don't want to auto export if it is not profitable at all.
		if(D.get_export_price() <= (D.payout_price * D.importexport_amt))
			continue
		if(D.held_items[1] >= D.importexport_amt)
			var/exported = do_export(D, TRUE)
			total_value_exported += exported
	if(total_value_exported >= EXPORT_ANNOUNCE_THRESHOLD)
		scom_announce("Azure Peak exports [total_value_exported] mammons of surplus goods.")

/datum/controller/subsystem/treasury/proc/remove_person(mob/living/person)
	noble_incomes -= person
	bank_accounts -= person
	return TRUE
