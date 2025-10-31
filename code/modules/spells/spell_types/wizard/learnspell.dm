//A spell to choose new spells, upon spawning or gaining levels
// TODO: Implement per patron spell lists
/obj/effect/proc_holder/spell/self/learnspell
	name = "Attempt to learn a new spell"
	desc = "Weave a new spell"
	school = "transmutation"
	overlay_state = "book1"
	chargedrain = 0
	chargetime = 0

/obj/effect/proc_holder/spell/self/learnspell/cast(list/targets, mob/user = usr)
	. = ..()
	var/scoollist = null
	var/additional_check = 0
	if(!user.mind.magic_scool)
		var/scool = list("Pyromancy","Cryomancy","Electromancy","Dark Magic")
		var/scool_choice = input(user, "Choose your magic scool.", "IM LEARNED...") as anything in scool
		switch(scool_choice)
			if("Pyromancy")
				user.mind.magic_scool = "Pyromancy"
			if("Cryomancy")
				user.mind.magic_scool = "Cryomancy"
			if("Electromancy")
				user.mind.magic_scool = "Electromancy"
			if("Dark Magic")
				user.mind.magic_scool = "Dark Magic"
		return TRUE

	scoolcheck() //primary scool
	additional_check = 1
	scoolcheck() //secondary scool

	//list of spells you can learn, it may be good to move this somewhere else eventually
	var/list/choices = list()

	var/user_spell_tier = get_user_spell_tier(user)

	var/list/spell_choices = GLOB.learnable_spells + scoollist + secondaryscoollist

	for(var/i = 1, i <= spell_choices.len, i++)
		var/obj/effect/proc_holder/spell/spell_item = spell_choices[i]
		if(spell_item.spell_tier > user_spell_tier)
			continue
		choices["[spell_item.name]: [spell_item.cost]"] = spell_item

	choices = sortList(choices)

	var/choice = input("Choose a spell, points left: [user.mind.spell_points - user.mind.used_spell_points]") as null|anything in choices
	var/obj/effect/proc_holder/spell/item = choices[choice]

	if(!item)
		return     // user canceled;
	if(alert(user, "[item.desc]", "[item.name]", "Learn", "Cancel") == "Cancel") //gives a preview of the spell's description to let people know what a spell does
		return
	for(var/obj/effect/proc_holder/spell/knownspell in user.mind.spell_list)
		if(knownspell.type == item.type)
			to_chat(user,span_warning("You already know this one!"))
			return	//already know the spell
	if(item.cost > user.mind.spell_points - user.mind.used_spell_points)
		to_chat(user,span_warning("You do not have enough experience to create a new spell."))
		return		// not enough spell points
	else
		user.mind.used_spell_points += item.cost
		var/obj/effect/proc_holder/spell/new_spell = new item
		new_spell.refundable = TRUE
		user.mind.AddSpell(new_spell)
		addtimer(CALLBACK(user.mind, TYPE_PROC_REF(/datum/mind, check_learnspell)), 2 SECONDS) //self remove if no points
		return TRUE

/obj/effect/proc_holder/spell/self/learnspell/scoolcheck(mob/user = usr)
	if(additional_check)
		switch(user.mind.secondary_magic_scool)
			if("Pyromancy")
				secondaryscoollist = GLOB.Pyromancy_spells
			if("Cryomancy")
				secondaryscoollist = GLOB.Cryomancy_spells
			if("Electromancy")
				secondaryscoollist = GLOB.Electromancy_spells
			if("Dark Magic")
				secondaryscoollist = GLOB.Darkmagic_spells
	else
		switch(user.mind.magic_scool)
			if("Pyromancy")
				scoollist = GLOB.Pyromancy_spells
			if("Cryomancy")
				scoollist = GLOB.Cryomancy_spells
			if("Electromancy")
				scoollist = GLOB.Electromancy_spells
			if("Dark Magic")
				scoollist = GLOB.Darkmagic_spells