/// DEFINITIONS ///
#define CLERIC_ORI -1
#define CLERIC_T0 0
#define CLERIC_T1 1
#define CLERIC_T2 2
#define CLERIC_T3 3
#define CLERIC_T4 4

#define CLERIC_REQ_0 0
#define CLERIC_REQ_1 100
#define CLERIC_REQ_2 250
#define CLERIC_REQ_3 500
#define CLERIC_REQ_4 750

#define CLERIC_REGEN_DEVOTEE 0.3
#define CLERIC_REGEN_MINOR 0.5
#define CLERIC_REGEN_MAJOR 1

// Cleric Holder Datums

/datum/devotion
	/// Mob that owns this datum
	var/mob/living/carbon/human/holder
	/// Patron this holder is for
	var/datum/patron/patron
	/// Current devotion we are holding
	var/devotion = 0
	/// Maximum devotion we can hold at once
	var/max_devotion = CLERIC_REQ_3 * 2
	/// Current progression (experience)
	var/progression = 0
	/// Maximum progression (experience) we can achieve
	var/max_progression = CLERIC_REQ_4
	/// Current spell tier, basically
	var/level = CLERIC_T0
	/// Last spell tier, to prevent duplicating miracles
	var/last_level = null
	/// How much devotion is gained per process call
	var/passive_devotion_gain = 0
	/// How much progression is gained per process call
	var/passive_progression_gain = 0
	/// How much devotion is gained per prayer cycle
	var/prayer_effectiveness = 2
	/// Spells we have granted thus far
	var/list/granted_spells

/datum/devotion/New(mob/living/carbon/human/holder, datum/patron/patron)
	. = ..()
	src.holder = holder
	holder?.devotion = src
	src.patron = patron
	if (patron.type == /datum/patron/inhumen/zizo || patron.type == /datum/patron/divine/necra)
		ADD_TRAIT(holder, TRAIT_DEATHSIGHT, "devotion")

/datum/devotion/Destroy(force)
	. = ..()
	if (patron.type == /datum/patron/inhumen/zizo || patron.type == /datum/patron/divine/necra)
		REMOVE_TRAIT(holder, TRAIT_DEATHSIGHT, "devotion")
	holder?.devotion = null
	holder = null
	patron = null
	granted_spells = null
	STOP_PROCESSING(SSobj, src)

/datum/devotion/process()
	if(!passive_devotion_gain && !passive_progression_gain)
		return PROCESS_KILL
	var/devotion_multiplier = 1
	if(holder?.mind)
		devotion_multiplier += (holder.get_skill_level(/datum/skill/magic/holy) / SKILL_LEVEL_LEGENDARY)
	update_devotion((passive_devotion_gain * devotion_multiplier), (passive_progression_gain * devotion_multiplier), silent = TRUE)

/datum/devotion/proc/check_devotion(obj/effect/proc_holder/spell/spell)
	if(devotion - spell.devotion_cost < 0)
		return FALSE
	return TRUE

/datum/devotion/proc/update_devotion(dev_amt, prog_amt, silent = FALSE)
	devotion = clamp(devotion + dev_amt, 0, max_devotion)
	//Max devotion limit
	if((devotion >= max_devotion) && !silent)
		to_chat(holder, span_warning("I have reached the limit of my devotion..."))
	if(!prog_amt) // no point in the rest if it's just an expenditure
		return TRUE
	progression = clamp(progression + prog_amt, 0, max_progression)
	switch(level)
		if(CLERIC_T0)
			if(progression >= CLERIC_REQ_1)
				level = CLERIC_T1
		if(CLERIC_T1)
			if(progression >= CLERIC_REQ_2)
				level = CLERIC_T2
		if(CLERIC_T2)
			if(progression >= CLERIC_REQ_3)
				level = CLERIC_T3
		if(CLERIC_T3)
			if(progression >= CLERIC_REQ_4)
				level = CLERIC_T4
	if(!holder?.mind)
		return FALSE
	if(level != last_level)
		try_add_spells(silent = silent)
		last_level = level
	return TRUE

/datum/devotion/proc/try_add_spells(silent = FALSE)
	if(length(patron.miracles))
		for(var/spell_type in patron.miracles)
			if(patron.miracles[spell_type] <= level)
				if(holder.mind.has_spell(spell_type))
					continue
				else
					var/newspell = new spell_type
					if(!silent)
						to_chat(holder, span_boldnotice("I have unlocked a new spell: [newspell]"))
					holder.mind.AddSpell(newspell)
					LAZYADD(granted_spells, newspell)
	if(length(patron.traits_tier))
		for(var/trait in patron.traits_tier)
			if(patron.traits_tier[trait] <= level)
				ADD_TRAIT(holder, trait, TRAIT_MIRACLE)


//The main proc that distributes all the needed devotion tweaks to the given class.
//cleric_tier 		- The cleric tier that the holder will get spells of immediately.
//passive_gain 		- Passive devotion gain, if any, will begin processing this datum.
//devotion_limit	- The CLERIC_REQ max_devotion and max_progression will be set to. Devotee overrides this with its own value!
//start_maxed		- Whether this class starts out with all devotion maxed. Mostly used by Acolytes & Priests to spawn with everything.
/datum/devotion/proc/grant_miracles(mob/living/carbon/human/H, cleric_tier = CLERIC_T0, passive_gain = 0, devotion_limit, start_maxed = FALSE)
	if(!H || !H.mind || !patron)
		return
	level = cleric_tier
	if(devotion_limit) //Upper devotion limit - Limits gain to that tier's miracles. Mostly used by Templars / Paladins.
		max_devotion = devotion_limit
		max_progression = devotion_limit
	if(passive_gain)
		passive_devotion_gain = passive_gain
		passive_progression_gain = passive_gain
		START_PROCESSING(SSobj, src)
	if(start_maxed)		//Mainly for Acolytes & Priests
		devotion = max_devotion
		update_devotion(max_devotion, CLERIC_REQ_4, silent = TRUE)
	else
		update_devotion(50, 50, silent = TRUE)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

// Debug verb
/mob/living/carbon/human/proc/devotionchange()
	set name = "(DEBUG)Change Devotion"
	set category = "-Special Verbs-"

	if(!devotion)
		return FALSE

	var/changeamt = input(src, "My devotion is [devotion.devotion]. How much to change?", "How much to change?") as null|num
	if(!changeamt)
		return FALSE
	devotion.update_devotion(changeamt)
	return TRUE

/mob/living/carbon/human/proc/devotionreport()
	set name = "Check Devotion"
	set category = "Cleric"

	if(!devotion)
		return FALSE

	to_chat(src,"My devotion is [devotion.devotion].")
	return TRUE

/mob/living/carbon/human/proc/clericpray()
	set name = "Give Prayer"
	set category = "Cleric"

	if(!devotion)
		return FALSE

	var/prayersesh = 0
	visible_message("[src] kneels their head in prayer to the Gods.", "I kneel my head in prayer to [devotion.patron.name].")
	for(var/i in 1 to 50)
		if(devotion.devotion >= devotion.max_devotion)
			to_chat(src, span_warning("I have reached the limit of my devotion..."))
			break
		if(!do_after(src, 30))
			break
		var/devotion_multiplier = 1
		if(mind)
			devotion_multiplier += (get_skill_level(/datum/skill/magic/holy) / SKILL_LEVEL_LEGENDARY)
		var/prayer_effectiveness = round(devotion.prayer_effectiveness * devotion_multiplier)
		devotion.update_devotion(prayer_effectiveness, prayer_effectiveness)
		prayersesh += prayer_effectiveness
	visible_message("[src] concludes their prayer.", "I conclude my prayer.")
	to_chat(src, "<font color='purple'>I gained [prayersesh] devotion!</font>")
	return TRUE

/mob/living/carbon/human/proc/changevoice()
	set name = "Change Second Voice (Can only use Once!)"
	set category = "Virtue"

	var/newcolor = input(src, "Choose your character's SECOND voice color:", "VIRTUE","#a0a0a0") as color|null
	if(newcolor)
		second_voice = sanitize_hexcolor(newcolor)
		src.verbs -= /mob/living/carbon/human/proc/changevoice
		return TRUE
	else
		return FALSE

/mob/living/carbon/human/proc/swapvoice()
	set name = "Swap Voice"
	set category = "Virtue"

	if(!second_voice)
		to_chat(src, span_info("I haven't decided on my second voice yet."))
		return FALSE
	if(voice_color != second_voice)
		original_voice = voice_color
		voice_color = second_voice
		to_chat(src, span_info("I've changed my voice to the second one."))
	else
		voice_color = original_voice
		to_chat(src, span_info("I've returned to my natural voice."))
	return TRUE

/mob/living/carbon/human/proc/toggleblindness()
	set name = "Toggle Colorblindness"
	set category = "Virtue"

	if(!get_client_color(/datum/client_colour/monochrome))
		add_client_colour(/datum/client_colour/monochrome)
	else
		remove_client_colour(/datum/client_colour/monochrome)

/datum/devotion/proc/excommunicate(mob/living/carbon/human/H)
    if (!devotion)
        return

    prayer_effectiveness = 0
    devotion = 0
    passive_devotion_gain = 0
    passive_progression_gain = 0
    STOP_PROCESSING(SSobj, src)
    to_chat(H, span_boldnotice("I have been excommunicated. I am now unable to gain devotion."))

/datum/devotion/proc/recommunicate(mob/living/carbon/human/H)
    prayer_effectiveness = 2
    if (!passive_devotion_gain && !passive_progression_gain)
        passive_devotion_gain = CLERIC_REGEN_DEVOTEE
        passive_progression_gain = CLERIC_REGEN_DEVOTEE
        START_PROCESSING(SSobj, src)

    to_chat(H, span_boldnotice("I have been welcomed back to the Church. I am now able to gain devotion again."))
