/datum/round_event_control/antagonist/solo/masquerade
	name = "Masquerade"
	tags = list(
		TAG_COMBAT,
		TAG_HAUNTED,
		TAG_VILLIAN,
	)
	roundstart = TRUE
	antag_flag = ROLE_VAMPIRE
	shared_occurence_type = SHARED_HIGH_THREAT

	weight = 12

	denominator = 80

	base_antags = 2
	maximum_antags = 2

	earliest_start = 0 SECONDS

	typepath = /datum/round_event/antagonist/solo/vampire
	antag_datum = /datum/antagonist/vampire

	restricted_roles = list(
		"Grand Duke",
		"Grand Duchess",
		"Consort",
		"Sergeant",
		"Men-at-arms",
		"Marshal",
		"Bishop",
		"Acolyte",
		"Martyr",
		"Templar",
		"Councillor",
		"Bandit",
		"Prince",
		"Princess",
		"Hand",
		"Steward",
		"Captain",
		"Knight",
		"Court Magician",
		"Inquisitor",
		"Orthodoxist",
		"Absolver",
		"Warden",
		"Squire",
	)

/datum/round_event/antagonist/solo/masquerade
	var/leader = FALSE

#define PRIORITY_LOW "low"
#define PRIORITY_MEDIUM "medium"
#define PRIORITY_HIGH "high"

/datum/round_event/antagonist/solo/start()
	INVOKE_ASYNC(src, PROC_REF(distribute_clans), setup_minds)

/datum/round_event/antagonist/solo/proc/distribute_clans(list/datum/mind/minds_to_distribute)
	var/datum/vampire_clan_vote/vampire_clan_vote = new()
	var/list/mind_to_action = list()
	for(var/datum/mind/mind as anything in minds_to_distribute)
		var/datum/action/vampire_vote/vvote = new(vampire_clan_vote)
		vvote.Grant(mind.current)
		mind_to_action[mind] = vvote
	sleep(30 SECONDS)
	var/list/taken_clans = list()
	var/list/assigned_candidates = list()
	for(var/level in list(PRIORITY_HIGH, PRIORITY_MEDIUM, PRIORITY_LOW))
		for(var/entry in vampire_clan_vote.clan_to_mind_to_priority)
			if(entry in taken_clans)
				continue

			var/datum/mind/candidate = vampire_clan_vote.clan_to_mind_to_priority[entry]
			if(candidate in assigned_candidates)
				continue

			if(vampire_clan_vote.clan_to_mind_to_priority[entry][candidate] != level)
				continue

			var/datum/antagonist/vampire/new_antag = new /datum/antagonist/vampire(incoming_clan = entry, forced_clan = TRUE, generation = GENERATION_ANCILLAE)
			candidate.add_antag_datum(new_antag)
			taken_clans += entry
			assigned_candidates += candidate
			var/datum/action/vote = mind_to_action[candidate]
			vote?.Remove(candidate.current)

/datum/vampire_clan_vote
	var/list/clan_to_mind_to_priority = list()
	var/end_time = 0

/datum/vampire_clan_vote/New()
	. = ..()
	end_time = world.time + 30 SECONDS

/datum/vampire_clan_vote/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "VampireVote", "Clan Selection")
		ui.open()

/datum/vampire_clan_vote/ui_data(mob/user)
	var/list/data = list()
	var/datum/asset/spritesheet/spritesheet = get_asset_datum(/datum/asset/spritesheet/vampire_clan_icons)
	data["timeLeft"] = end_time - world.time
	for(var/clantype in subtypesof(/datum/clan))
		var/datum/clan/typecasted = clantype
		var/list/clan_data = list(
			"clanName" = initial(typecasted.name),
			"description"  = initial(typecasted.desc),
			"type" = clantype,
			"priority" = LAZYACCESSASSOC(clan_to_mind_to_priority, clantype, user.mind),
			"icon" = spritesheet.icon_class_name(sanitize_css_class_name("clan_[clantype]"))
		)
		data["clans"] += list(clan_data)
	return data

/datum/vampire_clan_vote/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return TRUE

	var/mob/user = usr

	switch(action)
		if("select_priority")
			var/prev_priority = LAZYACCESSASSOC(clan_to_mind_to_priority, text2path(params["selected_clan"]), user.mind)
			LAZYADDASSOCLIST(clan_to_mind_to_priority, text2path(params["selected_clan"]), user.mind)
			switch(prev_priority)
				if(PRIORITY_HIGH)
					clan_to_mind_to_priority[text2path(params["selected_clan"])][user.mind] = null
				if(PRIORITY_MEDIUM)
					clan_to_mind_to_priority[text2path(params["selected_clan"])][user.mind] = PRIORITY_HIGH
				if(PRIORITY_LOW)
					clan_to_mind_to_priority[text2path(params["selected_clan"])][user.mind] = PRIORITY_MEDIUM
				if(null)
					clan_to_mind_to_priority[text2path(params["selected_clan"])][user.mind] = PRIORITY_LOW

/datum/vampire_clan_vote/ui_state(mob/user)
	return GLOB.always_state

/datum/vampire_clan_vote/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/vampire_clan_icons)
	)

/datum/action/vampire_vote
	name = "Clan selection!"
	button_icon_state = "vote"

/datum/action/vampire_vote/Trigger()
	if(!..())
		return FALSE
	target.ui_interact(owner)
	return TRUE

/datum/action/vampire_vote/IsAvailable()
	return TRUE

/datum/asset/spritesheet/vampire_clan_icons
	name = "vampire_clan_icons"

/datum/asset/spritesheet/vampire_clan_icons/create_spritesheets()
	for(var/clantype in subtypesof(/datum/clan))
		var/datum/clan/typecasted = clantype
		var/icon = 'icons/mob/actions/vampspells.dmi'
		var/icon_state = initial(typecasted.clanicon)

		if(!icon || !icon_state)
			continue

		Insert("[sanitize_css_class_name("clan_[clantype]")]", icon, icon_state)
