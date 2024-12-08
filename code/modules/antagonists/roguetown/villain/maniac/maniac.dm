
/datum/antagonist/maniac
	name = "Maniac"
	roundend_category = "maniacs"
	antagpanel_category = "Maniac"
	antag_memory = "<b>Recently I've been visited by a lot of VISIONS. They're all about another WORLD, ANOTHER life. I will do EVERYTHING to know the TRUTH, and return to the REAL world.</b>"
	job_rank = ROLE_MANIAC
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "villain"
	confess_lines = list(
		"I gave them no time to squeal.",
		"I shant quit ripping them.",
		"They deserve to be put at my blade.",
		"Do what thou wilt shall be the whole of the law.",
	)
	rogue_enabled = FALSE
	/// Traits we apply to the owner
	var/static/list/applied_traits = list(
		TRAIT_CRITICAL_RESISTANCE,
		TRAIT_DECEIVING_MEEKNESS,
		TRAIT_NOSTINK,
		TRAIT_EMPATH,
		TRAIT_NOROGSTAM,
		TRAIT_NOPAIN,
		TRAIT_NOPAINSTUN,
		TRAIT_STEELHEARTED,
		TRAIT_NOMOOD,
		TRAIT_HARDDISMEMBER,
		TRAIT_NOSLEEP,
		TRAIT_SHOCKIMMUNE,
		TRAIT_STABLEHEART,
		TRAIT_STABLELIVER,
		TRAIT_ANTIMAGIC,
		TRAIT_SCHIZO_AMBIENCE,
		TRAIT_BLOODLOSS_IMMUNE,
	)
	/// Traits that only get applied in the final sequence
	var/static/list/final_traits = list(
		TRAIT_MANIAC_AWOKEN,
		TRAIT_SCREENSHAKE,
	)
	/// Cached old stats in case we get removed
	var/STASTR
	var/STACON
	var/STAEND
	/// Weapons we can give to the dreamer
	var/static/list/possible_weapons = list(
		/obj/item/rogueweapon/huntingknife/cleaver,
		/obj/item/rogueweapon/huntingknife/cleaver/combat,
		/obj/item/rogueweapon/huntingknife/idagger/steel/special,
	)
	/// Key number > Key text
	var/list/num_keys = list()
	/// Key text > key number
	var/list/key_nums = list()
	/// Every heart inscryption we have seen
	var/list/hearts_seen = list()
	/// Sum of the numbers of every key
	var/sum_keys = 0
	/// Keeps track of which wonder we are gonna make next
	var/current_wonder = 1
	/// Set to TRUE when we are on the last wonder (waking up)
	var/waking_up = FALSE
	/// Set to true when we WIN and are on the ending sequence
	var/triumphed = FALSE
	/// Wonders we have made
	var/list/wonders_made = list()

/datum/antagonist/maniac/New()
	set_keys()
	load_strings_file("maniac.json")
	return ..()

/datum/antagonist/maniac/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/datum/antagonist/maniac/on_gain()
	. = ..()
	owner.special_role = ROLE_MANIAC
	owner.special_items["Maniac"] = pick(possible_weapons)
	owner.special_items["Surgical Kit"] = /obj/item/storage/belt/rogue/surgery_bag/full
	if(owner.current)
		if(ishuman(owner.current))
			var/mob/living/carbon/human/dreamer = owner.current
			dreamer.cmode_music = 'sound/music/combat_maniac2.ogg'
			owner.adjust_skillrank(/datum/skill/combat/knives, 6, TRUE)
			owner.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
			owner.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
			var/medicine_skill = dreamer.mind.get_skill_level(/datum/skill/misc/medicine)
			if(medicine_skill < 3)// Bumps his skill up to 3 for surgery, not higher
				owner.adjust_skillrank(/datum/skill/misc/medicine, 3 - medicine_skill, TRUE)
			STASTR = dreamer.STASTR
			STACON = dreamer.STACON
			STAEND = dreamer.STAEND
			dreamer.STASTR = 20
			dreamer.STACON = 20
			dreamer.STAEND = 20
		for(var/trait in applied_traits)
			ADD_TRAIT(owner.current, trait, "[type]")
	LAZYINITLIST(owner.learned_recipes)
	if(length(objectives))
		SEND_SOUND(owner.current, 'sound/villain/dreamer_warning.ogg')
		to_chat(owner.current, span_danger("[antag_memory]"))
		owner.announce_objectives()
	START_PROCESSING(SSobj, src)

/datum/antagonist/maniac/on_removal()
	STOP_PROCESSING(SSobj, src)
	if(owner.current)
		if(!silent)
			to_chat(owner.current,span_danger("I am no longer a MANIAC!"))
		if(ishuman(owner.current))
			var/mob/living/carbon/human/dreamer = owner.current
			dreamer.STASTR = STASTR
			dreamer.STACON = STACON
			dreamer.STAEND = STAEND
		for(var/trait in applied_traits)
			REMOVE_TRAIT(owner.current, trait, "[type]")
		for(var/trait in final_traits)
			REMOVE_TRAIT(owner.current, trait, "[type]")
		owner.current.clear_fullscreen("maniac")
	QDEL_LIST(wonders_made)
	wonders_made = null
	owner.special_role = null
	return ..()

/datum/antagonist/maniac/proc/set_keys()
	key_nums = list()
	num_keys = list()
	//We need 4 numbers and four keys
	for(var/i in 1 to 4)
		//Make the number first
		var/randumb
		while(!randumb || (randumb in num_keys))
			randumb = "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
		//Make the key second
		var/rantelligent
		while(!rantelligent || (rantelligent in key_nums))
			rantelligent = uppertext("[pick(GLOB.alphabet)][pick(GLOB.alphabet)][pick(GLOB.alphabet)][pick(GLOB.alphabet)]")

		//Stick then in the lists, continue the loop
		num_keys[randumb] = rantelligent
		key_nums[rantelligent] = randumb

	sum_keys = 0
	for(var/i in num_keys)
		sum_keys += text2num(i)

/datum/antagonist/maniac/proc/forge_villain_objectives()
	return

//TODO Collate
/datum/antagonist/roundend_report()
	var/traitorwin = TRUE

	printplayer(owner)

	var/count = 0
	if(objectives.len)//If the traitor had no objectives, don't need to process this.
		for(var/datum/objective/objective in objectives)
			objective.update_explanation_text()
			if(objective.check_completion())
				to_chat(world, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
			else
				to_chat(world, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
				traitorwin = FALSE
			count += objective.triumph_count

	var/special_role_text = lowertext(name)

	if(!considered_alive(owner))
		traitorwin = FALSE

	if(traitorwin)
		if(count)
			if(owner)
				owner.adjust_triumphs(count)
		to_chat(world, span_greentext("The [special_role_text] has TRIUMPHED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(world, span_redtext("The [special_role_text] has FAILED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)
