/datum/round_event_control/antagonist/solo/warlord
	name = "Warlord"
	tags = list(
		TAG_COMBAT,
		TAG_VILLIAN,
		TAG_WAR
	)
	roundstart = TRUE
	antag_flag = ROLE_WARLORD
	shared_occurence_type = SHARED_HIGH_THREAT
	earliest_start = 0 SECONDS

	denominator = 80
	base_antags = 1
	maximum_antags = 1
	max_occurrences = 1
	weight = 2

	min_players = 40	
	required_enemies = 25
	enemy_roles = list("Man at Arms", 
	"Sergeant",
	"Knight",
	"Captain",
	"Squire",
	"Marshal",
	"Court Magician",
	"Warden",
	"Court Agent",
	"Veteran",
	"Templar",
	"Martyr",
	"Mercenary",
	"Adventurer")

	restricted_roles = list(
		"Grand Duke",
		"Grand Duchess",
		"Consort",
		"Suitor",
		"Dungeoneer",
		"Sergeant",
		"Men-at-arms",
		"Marshal",
		"Merchant",
		"Priest",
		"Acolyte",
		"Martyr",
		"Templar",
		"Prince",
		"Princess",
		"Hand",
		"Steward",
		"Court Physician",
		"Captain",
		"Knight",
		"Court Magician",
		"Inquisitor",
		"Orthodoxist",
		"Warden",
		"Squire",
		"Councillor",
		"Veteran"
	)

	typepath = /datum/round_event/antagonist/solo/warlord
	antag_datum = /datum/antagonist/warlord


/datum/round_event/antagonist/solo/warlord



/datum/round_event/antagonist/solo/warlord/start()
	for(var/datum/mind/antag_mind as anything in setup_minds)
		var/datum/job/J = SSjob.GetJob(antag_mind.current?.job)
		J?.current_positions = max(J?.current_positions-1, 0)
		SSjob.AssignRole(antag_mind.current, "Warlord")
		antag_mind.add_antag_datum(/datum/antagonist/warlord)



