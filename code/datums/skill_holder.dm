/mob
	var/datum/skill_holder/skills

/mob/proc/ensure_skills()
	RETURN_TYPE(/datum/skill_holder)
	if(!skills)
		skills = new /datum/skill_holder()
		skills.set_current(src)
	return skills

/mob/proc/get_skill_level(skill)
	return ensure_skills().get_skill_level(skill)

/mob/proc/adjust_experience(skill, amt, silent=FALSE, check_apprentice=TRUE)
	return ensure_skills().adjust_experience(skill, amt, silent, check_apprentice)

/mob/proc/get_skill_speed_modifier(skill)
	return ensure_skills().get_skill_speed_modifier(skill)

/mob/proc/adjust_skillrank(skill, amt, silent = FALSE)
	return ensure_skills().adjust_skillrank(skill, amt, silent)

/mob/proc/adjust_skillrank_up_to(skill, amt, silent = FALSE)
	return ensure_skills().adjust_skillrank_up_to(skill, amt, silent)

/mob/proc/adjust_skillrank_down_to(skill, amt, silent = FALSE)
	return ensure_skills().adjust_skillrank_down_to(skill, amt, silent)
	
/mob/proc/print_levels()
	return ensure_skills().print_levels(src)

/datum/skill_holder
	///our current host
	var/mob/living/current
	///Assoc list of skills - level
	var/list/known_skills = list()
	///Assoc list of skills - exp
	var/list/skill_experience = list()

/datum/skill_holder/New()
	. = ..()
	for(var/datum/skill/skill as anything in SSskills.all_skills)
		if(!(skill in skill_experience))
			skill_experience |= skill
			skill_experience[skill] = 0

/datum/skill_holder/proc/set_current(mob/incoming)
	current = incoming
	RegisterSignal(incoming, COMSIG_MIND_TRANSFER, PROC_REF(transfer_skills))
	incoming.skills = src

/datum/skill_holder/proc/transfer_skills(mob/source, mob/destination)
	UnregisterSignal(source, COMSIG_MIND_TRANSFER)
	set_current(destination)

/datum/skill_holder/proc/adjust_experience(skill, amt, silent = FALSE)
	var/datum/skill/S = GetSkillRef(skill)
	skill_experience[S] = max(0, skill_experience[S] + amt) //Prevent going below 0
	var/old_level = known_skills[S]
	switch(skill_experience[S])
		if(SKILL_EXP_LEGENDARY to INFINITY)
			known_skills[S] = SKILL_LEVEL_LEGENDARY

		if(SKILL_EXP_MASTER to SKILL_EXP_LEGENDARY)
			known_skills[S] = SKILL_LEVEL_MASTER

		if(SKILL_EXP_EXPERT to SKILL_EXP_MASTER)
			known_skills[S] = SKILL_LEVEL_EXPERT

		if(SKILL_EXP_JOURNEYMAN to SKILL_EXP_EXPERT)
			known_skills[S] = SKILL_LEVEL_JOURNEYMAN

		if(SKILL_EXP_APPRENTICE to SKILL_EXP_JOURNEYMAN)
			known_skills[S] = SKILL_LEVEL_APPRENTICE

		if(SKILL_EXP_NOVICE to SKILL_EXP_APPRENTICE)
			known_skills[S] = SKILL_LEVEL_NOVICE

		if(0 to SKILL_EXP_NOVICE)
			known_skills[S] = SKILL_LEVEL_NONE

	if(isnull(old_level) || known_skills[S] == old_level)
		return //same level or we just started earning xp towards the first level.
	if(silent)
		return
	// ratio = round(skill_experience[S]/limit,1) * 100
	// to_chat(current, "<span class='nicegreen'> My [S.name] is around [ratio]% of the way there.")
	//TODO add some bar hud or something, i think i seen a request like that somewhere
	if(known_skills[S] >= old_level)
		if(known_skills[S] > old_level)
			to_chat(current, span_nicegreen("My [S.name] grows to [SSskills.level_names[known_skills[S]]]!"))
			SEND_SIGNAL(current, COMSIG_SKILL_RANK_INCREASED, S, known_skills[S], old_level)
			GLOB.azure_round_stats[STATS_SKILLS_LEARNED]++
			S.skill_level_effect(known_skills[S], src)
			if(istype(known_skills, /datum/skill/combat))
				GLOB.azure_round_stats[STATS_COMBAT_SKILLS]++
			if(istype(known_skills, /datum/skill/craft))
				GLOB.azure_round_stats[STATS_CRAFT_SKILLS]++
	else
		to_chat(current, span_warning("My [S.name] has weakened to [SSskills.level_names[known_skills[S]]]!"))

/datum/skill_holder/proc/adjust_skillrank_up_to(skill, amt, silent = FALSE)
	var/proper_amt = amt - get_skill_level(skill)
	if(proper_amt <= 0)
		return
	adjust_skillrank(skill, proper_amt, silent)

/datum/skill_holder/proc/adjust_skillrank_down_to(skill, amt, silent = FALSE)
	var/proper_amt = get_skill_level(skill) - amt
	if(proper_amt <= 0)
		return
	adjust_skillrank(skill, -proper_amt, silent)

/datum/skill_holder/proc/adjust_skillrank(skill, amt, silent = FALSE)
	var/datum/skill/S = GetSkillRef(skill)
	var/amt2gain = 0
	for(var/i in 1 to amt)
		switch(skill_experience[S])
			if(SKILL_EXP_MASTER to SKILL_EXP_LEGENDARY)
				amt2gain = SKILL_EXP_LEGENDARY-skill_experience[S]
			if(SKILL_EXP_EXPERT to SKILL_EXP_MASTER)
				amt2gain = SKILL_EXP_MASTER-skill_experience[S]
			if(SKILL_EXP_JOURNEYMAN to SKILL_EXP_EXPERT)
				amt2gain = SKILL_EXP_EXPERT-skill_experience[S]
			if(SKILL_EXP_APPRENTICE to SKILL_EXP_JOURNEYMAN)
				amt2gain = SKILL_EXP_JOURNEYMAN-skill_experience[S]
			if(SKILL_EXP_NOVICE to SKILL_EXP_APPRENTICE)
				amt2gain = SKILL_EXP_APPRENTICE-skill_experience[S]
			if(0 to SKILL_EXP_NOVICE)
				amt2gain = SKILL_EXP_NOVICE-skill_experience[S] + 1
		if(!skill_experience[S])
			amt2gain = SKILL_EXP_NOVICE+1
		skill_experience[S] = max(0, skill_experience[S] + amt2gain) //Prevent going below 0
	var/old_level = get_skill_level(skill)
	switch(skill_experience[S])
		if(SKILL_EXP_LEGENDARY to INFINITY)
			known_skills[S] = SKILL_LEVEL_LEGENDARY
		if(SKILL_EXP_MASTER to SKILL_EXP_LEGENDARY)
			known_skills[S] = SKILL_LEVEL_MASTER
		if(SKILL_EXP_EXPERT to SKILL_EXP_MASTER)
			known_skills[S] = SKILL_LEVEL_EXPERT
		if(SKILL_EXP_JOURNEYMAN to SKILL_EXP_EXPERT)
			known_skills[S] = SKILL_LEVEL_JOURNEYMAN
		if(SKILL_EXP_APPRENTICE to SKILL_EXP_JOURNEYMAN)
			known_skills[S] = SKILL_LEVEL_APPRENTICE
		if(SKILL_EXP_NOVICE to SKILL_EXP_APPRENTICE)
			known_skills[S] = SKILL_LEVEL_NOVICE
		if(0 to SKILL_EXP_NOVICE)
			known_skills[S] = SKILL_LEVEL_NONE
	if(known_skills[S] == old_level)
		return //same level or we just started earning xp towards the first level.
	if(silent)
		return
	if(known_skills[S] >= old_level)
		to_chat(current, span_nicegreen("I feel like I've become more proficient at [lowertext(S.name)]!"))
		GLOB.azure_round_stats[STATS_SKILLS_LEARNED]++
		SEND_SIGNAL(current, COMSIG_SKILL_RANK_INCREASED, S, known_skills[S], old_level)
	else
		to_chat(current, span_warning("I feel like I've become worse at [lowertext(S.name)]!"))

	if(ishuman(current))
		var/mob/living/carbon/human/H = current
		if(H.adaptive_name)
			var/str
			var/list/jobnames = list()
			for(var/skillt in SSskills.all_skills)
				var/datum/skill/sk = GetSkillRef(skillt)
				if(current.get_skill_level(sk.type) >= SKILL_LEVEL_EXPERT)
					jobnames.Add(initial(sk.expert_name))
			if(length(jobnames))
				if(length(jobnames) == 1)
					current.advjob = jobnames[1]
				else
					for(var/i in 1 to length(jobnames))
						if(i == 1)
							str += "[jobnames[i]]"
						else
							str += "-[jobnames[i]]"
					current.advjob = str

/datum/skill_holder/proc/get_skill_speed_modifier(skill)
	var/datum/skill/S = GetSkillRef(skill)
	return S.get_skill_speed_modifier(known_skills[S] || SKILL_LEVEL_NONE)

/datum/skill_holder/proc/get_skill_level(skill)
	var/datum/skill/S = GetSkillRef(skill)
	if(!(S in known_skills))
		return SKILL_LEVEL_NONE
	return known_skills[S] || SKILL_LEVEL_NONE

/datum/skill_holder/proc/print_levels(user)
	var/list/shown_skills = list()
	for(var/i in known_skills)
		if(known_skills[i]) //Do we actually have a level in this?
			shown_skills += i
	if(!length(shown_skills))
		to_chat(user, span_warning("I don't have any skills."))
		return
	var/msg = ""
	msg += span_info("*---------*\n")
	for(var/datum/skill/i in shown_skills)
		var/can_advance_post = current?.mind?.sleep_adv.enough_sleep_xp_to_advance(i.type, 1)
		var/capped_post = current?.mind?.sleep_adv.enough_sleep_xp_to_advance(i.type, 2)
		var/rankup_postfix = capped_post ? span_nicegreen(" <b>(!!)</b>") : can_advance_post ? span_nicegreen(" <b>(!)</b>") : ""
		msg += "[i] - [SSskills.level_names[known_skills[i]]][rankup_postfix]"
		msg += span_info(" <a href='?src=[REF(i)];skill_detail=1'>{?}</a>\n")
	msg += "</span>"

	to_chat(user, msg)
