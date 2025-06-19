/datum/round_event_control/antagonist/solo/ascendant
	name = "Ascendant"
	tags = list(
		TAG_COMBAT,
		TAG_HAUNTED,
		TAG_VILLIAN,
	)
	roundstart = TRUE
	antag_flag = ROLE_ASCENDANT
	shared_occurence_type = SHARED_HIGH_THREAT

	denominator = 40

	base_antags = 1
	maximum_antags = 1

	weight = 2 
	max_occurrences = 0 //ADMIN ONLY FOR TESTING!

	earliest_start = 0 SECONDS

	typepath = /datum/round_event/antagonist/solo/ascendant
	antag_datum = /datum/antagonist/ascendant

	restricted_roles = list(
		"Grand Duke",
		"Grand Duchess",
		"Consort",
		"Dungeoneer",
		"Sergeant",
		"Men-at-arms",
		"Marshal",
		"Merchant",
		"Priest",
		"Acolyte",
		"Martyr",
		"Templar",
		"Councillor",
		"Bandit",
		"Prince",
		"Princess",
		"Hand",
		"Steward",
		"Court Physician",
		"Town Elder",
		"Captain",
		"Archivist",
		"Knight",
		"Court Magician",
		"Inquisitor",
		"Orthodoxist",
		"Warden",
		"Squire",
		"Veteran",
		"Apothecary"
	)

	enemy_roles	= list(
		"Grand Duke",
		"Inquisitor",
		"Martyr"
	)

	required_enemies = 1

/datum/round_event/antagonist/solo/ascendant
