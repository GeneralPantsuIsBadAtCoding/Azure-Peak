/datum/round_event_control/antagonist/solo/masquerade
	name = "Masquerade"
	tags = list(
		TAG_COMBAT,
		TAG_HAUNTED,
		TAG_VILLIAN,
	)
	roundstart = TRUE
	antag_flag = ROLE_NBEAST
	shared_occurence_type = SHARED_HIGH_THREAT

	weight = 12

	denominator = 80

	base_antags = 4
	maximum_antags = 4

	earliest_start = 0 SECONDS

	typepath = /datum/round_event/antagonist/solo/vampire
	antag_datum = /datum/antagonist/vampire_neu

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

/datum/round_event/antagonist/solo/masquerade
