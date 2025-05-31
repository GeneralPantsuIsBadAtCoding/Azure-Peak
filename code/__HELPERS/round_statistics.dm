// Census
#define STATS_ALIVE_NORTHERN_HUMANS "alive_northern_humans"
#define STATS_ALIVE_DWARVES "alive_dwarves"
#define STATS_ALIVE_DARK_ELVES "alive_dark_elves"
#define STATS_ALIVE_WOOD_ELVES "alive_wood_elves"
#define STATS_ALIVE_HALF_ELVES "alive_half_elves"
#define STATS_ALIVE_HALF_ORCS "alive_half_orcs"
#define STATS_ALIVE_GOBLINS "alive_goblins"
#define STATS_ALIVE_KOBOLDS "alive_kobolds"
#define STATS_ALIVE_LIZARDS "alive_lizards"
#define STATS_ALIVE_AASIMAR "alive_aasimar"
#define STATS_ALIVE_TIEFLINGS "alive_tieflings"
#define STATS_ALIVE_HALFKIN "alive_halfkin"
#define STATS_ALIVE_WILDKIN "alive_wildkin"
#define STATS_ALIVE_CONSTRUCTS "alive_constructs"
#define STATS_ALIVE_VERMINFOLK "alive_verminfolk"
#define STATS_ALIVE_DRACON "alive_dracon"
#define STATS_ALIVE_AXIAN "alive_axian"
#define STATS_ALIVE_TABAXI "alive_tabaxi"
#define STATS_ALIVE_VULPS "alive_vulps"
#define STATS_ALIVE_LUPIANS "alive_lupians"
#define STATS_ALIVE_MOTHS "alive_moths"

#define STATS_VAMPIRES "vampires"

#define STATS_ALIVE_GARRISON "alive_garrison"
#define STATS_ALIVE_CLERGY "alive_clergy"
#define STATS_ALIVE_TRADESMEN "alive_tradesmen"

#define STATS_MONARCH_PATRON "monarch_patron"
#define STATS_TOTAL_POPULATION "total_population"

#define STATS_MALE_POPULATION "male_population"
#define STATS_FEMALE_POPULATION "female_population"
#define STATS_OTHER_GENDER "other_gender_population"

#define STATS_ADULT_POPULATION "adult_population"
#define STATS_MIDDLEAGED_POPULATION "middleaged_population"
#define STATS_ELDERLY_POPULATION "elderly_population"

// General statistics

#define STATS_MOAT_FALLERS "moat_fallers"
#define STATS_ANKLES_BROKEN "ankles_broken"
#define STATS_PEOPLE_SMITTEN "people_smitten"
#define STATS_TRIUMPHS_AWARDED "triumphs_awarded"
#define STATS_TRIUMPHS_STOLEN "triumphs_stolen"
#define STATS_PRAYERS_MADE "prayers_made"
#define STATS_SKILLS_LEARNED "skills_learned"
#define STATS_DEADITES_ALIVE "deadites_alive"
#define STATS_LUX_REVIVALS "lux_revivals"
#define STATS_DODGES "dodges_made"

// Influence related statistics

//Psydon
#define STATS_HUMEN_DEATHS "humen_deaths"
#define STATS_PSYCROSS_USERS "people_wearing_psycross"
#define STATS_LUX_HARVESTED "lux_harvested"

//Astratan
#define STATS_LAWS_AND_DECREES_MADE "laws_and_decrees_made"
#define STATS_ALIVE_NOBLES "alive_nobles"
#define STATS_NOBLE_DEATHS "noble_deaths"
#define STATS_ASTRATA_REVIVALS "astrata_revivals"
#define STATS_TAXES_COLLECTED "taxes_collected"

//Noc
#define STATS_BOOKS_PRINTED "books_printed"
#define STATS_LITERACY_TAUGHT "literacy_taught"
#define STATS_BOOKS_BURNED "books_burned"
#define STATS_SKILLS_DREAMED "skills_dreamed"

//Necra
#define STATS_SKELETONS_KILLED "skeletons_killed"
#define STATS_GRAVES_ROBBED "graves_robbed"
#define STATS_DEADITES_KILLED "deadites_killed"
#define STATS_VAMPIRES_KILLED "vampires_killed"

//Pestra
#define STATS_POTIONS_BREWED "potions_brewed"
#define STATS_WOUNDS_SEWED "wounds_healed"
#define STATS_ROT_CURED "rot_cured"
#define STATS_FOOD_ROTTED "food_rotted"

//Dendor
#define STATS_TREES_CUT "trees_cut"
#define STATS_PLANTS_HARVESTED "plants_harvested"
#define STATS_WEREVOLVES "werevolves"
#define STATS_FOREST_DEATHS "forest_deaths"

//Ravox
#define STATS_COMBAT_SKILLS "combat_skills"
#define STATS_PARRIES "parries"
#define STATS_WARCRIES "warcries"
#define STATS_YIELDS "yields"

//Xylix
#define STATS_LAUGHS_MADE "laughs_made"
#define STATS_PEOPLE_MOCKED "people_mocked"
#define STATS_CRITS_MADE "crits_made"
#define STATS_SONGS_PLAYED "songs_played"

//Malum
#define STATS_MASTERWORKS_FORGED "masterworks_forged"
#define STATS_ROCKS_MINED "ores_mined"
#define STATS_CRAFT_SKILLS "craft_skills"
#define STATS_BEARDS_SHAVED "beards_shaved"

//Abyssor
#define STATS_WATER_CONSUMED "water_consumed"
#define STATS_FISH_CAUGHT "fish_caught"
#define STATS_ABYSSOR_REMEMBERED "abyssor_remembered"
#define STATS_LEECHES_EMBEDDED "leeches_embedded"
#define STATS_PEOPLE_DROWNED "people_drowned"

//Eora
#define STATS_KISSES_MADE "kisses_made"
#define STATS_PLEASURES "pleasures"
#define STATS_HUGS_MADE "hugs_made"
#define STATS_CLINGY_PEOPLE "clingy_people"

//Zizo
#define STATS_ZIZO_PRAISED "zizo_praised"
#define STATS_DEADITES_WOKEN_UP "deadites_woken_up"
#define STATS_CLERGY_DEATHS "priest_deaths"
#define STATS_TORTURES "tortures"

//Graggar
#define STATS_BLOOD_SPILT "blood_spilt"
#define STATS_ORGANS_EATEN "organs_eaten"
#define STATS_DEATHS "deaths"
#define STATS_PEOPLE_GIBBED "people_gibbed"

//Baotha
#define STATS_DRUGS_SNORTED "drugs_snorted"
#define STATS_ALCOHOL_CONSUMED "alcohol_consumed"
#define STATS_ALCOHOLICS "alcoholics"
#define STATS_JUNKIES "junkies"

//Matthios
#define STATS_ITEMS_PICKPOCKETED "items_pickpocketed"
#define STATS_SHRINE_VALUE "shrine_value"
#define STATS_GREEDY_PEOPLE "tomb_deaths"
#define STATS_LOCKS_PICKED "locks_picked"

GLOBAL_LIST_INIT(azure_round_stats, list(
	STATS_DEATHS = 0,
	STATS_NOBLE_DEATHS = 0,
	STATS_MOAT_FALLERS = 0,
	STATS_ANKLES_BROKEN = 0,
	STATS_PEOPLE_SMITTEN = 0,
	STATS_BLOOD_SPILT = 0,
	STATS_PEOPLE_GIBBED = 0,
	STATS_TRIUMPHS_AWARDED = 0,
	STATS_TRIUMPHS_STOLEN = 0,
	STATS_DRUGS_SNORTED = 0,
	STATS_BEARDS_SHAVED = 0,
	STATS_TREES_CUT = 0,
	STATS_PRAYERS_MADE = 0,
	STATS_FISH_CAUGHT = 0,
	STATS_ITEMS_PICKPOCKETED = 0,
	STATS_MASTERWORKS_FORGED = 0,
	STATS_TAXES_COLLECTED = 0,
	STATS_ORGANS_EATEN = 0,
	STATS_KISSES_MADE = 0,
	STATS_LAUGHS_MADE = 0,
	STATS_POTIONS_BREWED = 0,
	STATS_ASTRATA_REVIVALS = 0,
	STATS_PLANTS_HARVESTED = 0,
	STATS_LAWS_AND_DECREES_MADE = 0,
	STATS_ALIVE_NOBLES = 0,
	STATS_BOOKS_PRINTED = 0,
	STATS_LITERACY_TAUGHT = 0,
	STATS_BOOKS_BURNED = 0,
	STATS_SKILLS_LEARNED = 0,
	STATS_GRAVES_ROBBED = 0,
	STATS_DEADITES_KILLED = 0,
	STATS_VAMPIRES_KILLED = 0,
	STATS_WOUNDS_SEWED = 0,
	STATS_ROT_CURED = 0,
	STATS_WEREVOLVES = 0,
	STATS_FOREST_DEATHS = 0,
	STATS_COMBAT_SKILLS = 0,
	STATS_PARRIES = 0,
	STATS_WARCRIES = 0,
	STATS_YIELDS = 0,
	STATS_PEOPLE_MOCKED = 0,
	STATS_CRITS_MADE = 0,
	STATS_ROCKS_MINED = 0,
	STATS_CRAFT_SKILLS = 0,
	STATS_ABYSSOR_REMEMBERED = 0,
	STATS_LEECHES_EMBEDDED = 0,
	STATS_HUGS_MADE = 0,
	STATS_CLINGY_PEOPLE = 0,
	STATS_DEADITES_ALIVE = 0,
	STATS_CLERGY_DEATHS = 0,
	STATS_ALCOHOL_CONSUMED = 0,
	STATS_ALCOHOLICS = 0,
	STATS_JUNKIES = 0,
	STATS_SHRINE_VALUE = 0,
	STATS_GREEDY_PEOPLE = 0,
	STATS_ALIVE_NORTHERN_HUMANS = 0,
	STATS_ALIVE_DWARVES = 0,
	STATS_ALIVE_DARK_ELVES = 0,
	STATS_ALIVE_SNOW_ELVES = 0,
	STATS_ALIVE_HALF_ELVES = 0,
	STATS_ALIVE_HALF_ORCS = 0,
	STATS_ALIVE_GOBLINS = 0,
	STATS_ALIVE_KOBOLDS = 0,
	STATS_ALIVE_LIZARDS = 0,
	STATS_ALIVE_AASIMAR = 0,
	STATS_ALIVE_TIEFLINGS = 0,
	STATS_ALIVE_HALFKIN = 0,
	STATS_ALIVE_WILDKIN = 0,
	STATS_ALIVE_CONSTRUCTS = 0,
	STATS_ALIVE_VERMINFOLK = 0,
	STATS_ALIVE_DRACON = 0,
	STATS_ALIVE_AXIAN = 0,
	STATS_ALIVE_TABAXI = 0,
	STATS_ALIVE_VULPS = 0,
	STATS_ALIVE_LUPIANS = 0,
	STATS_ALIVE_MOTHS = 0,
	STATS_PEOPLE_DROWNED = 0,
	STATS_WATER_CONSUMED  = 0,
	STATS_LIMBS_BITTEN = 0,
	STATS_UNDERWORLD_DUELS = 0,
	STATS_LOCKS_PICKED = 0,
	STATS_SONGS_PLAYED = 0,
	STATS_FOOD_ROTTED = 0,
	STATS_FOREST_DEATHS = 0,
	STATS_TORTURES = 0,
	STATS_DEADITES_WOKEN_UP = 0,
	STATS_DODGES = 0,
	STATS_MONARCH_PATRON = "No Ruler",
	STATS_MALE_POPULATION = 0,
	STATS_FEMALE_POPULATION = 0,
	STATS_OTHER_GENDER = 0,
	STATS_ADULT_POPULATION = 0,
	STATS_MIDDLEAGED_POPULATION = 0,
	STATS_ELDERLY_POPULATION = 0,
	STATS_PSYCROSS_USERS = 0,
	STATS_VAMPIRES = 0,
	STATS_LUX_HARVESTED = 0,
	STATS_TOTAL_POPULATION = 0,
	STATS_ALIVE_GARRISON = 0,
	STATS_ALIVE_CLERGY = 0,
	STATS_ALIVE_TRADESMEN = 0,
	STATS_LUX_REVIVALS = 0,
	STATS_PLEASURES = 0,
	STATS_SKILLS_DREAMED = 0,
))

GLOBAL_LIST_EMPTY(patron_follower_counts)

// Featured stats of the round
#define FEATURED_STATS_TREE_FELLERS "tree_fellers"
#define FEATURED_STATS_THIEVES "thieves"
#define FEATURED_STATS_ALCHEMISTS "alchemists"
#define FEATURED_STATS_TAX_PAYERS "tax_payers"
#define FEATURED_STATS_ALCOHOLICS "alcohol_drinkers"
#define FEATURED_STATS_SPEAKERS "speakers"
#define FEATURED_STATS_FISHERS "fishers"
#define FEATURED_STATS_GOURMETS "gourmets"
#define FEATURED_STATS_SCREAMERS "screamers"
#define FEATURED_STATS_MINERS "miners"
#define FEATURED_STATS_CRIMINALS "criminals"
#define FEATURED_STATS_MAGES "mages"
#define FEATURED_STATS_CRAFTERS "crafters"
#define FEATURED_STATS_FARMERS "farmers"
#define FEATURED_STATS_STORYTELLERS "storytellers"

// Featured objects stats
#define FEATURED_STATS_CRAFTED_ITEMS "crafted_items"
#define FEATURED_STATS_DRINKS "drinks"

GLOBAL_LIST_INIT(featured_stats, list(
	FEATURED_STATS_TREE_FELLERS = list(
		"name" = "TOP 10 Lumberjacks",
		"color" = "#9b6937",
		"entries" = list()
	),
	FEATURED_STATS_TAX_PAYERS = list(
		"name" = "TOP 10 Tax Payers",
		"color" = "#f1e35d",
		"entries" = list()
	),
	FEATURED_STATS_CRIMINALS = list(
		"name" = "TOP 10 Criminals",
		"color" = "#bb6976",
		"entries" = list()
	),
	FEATURED_STATS_SPEAKERS = list(
		"name" = "TOP 10 Speakers",
		"color" = "#93cabe",
		"entries" = list()
	),
	FEATURED_STATS_MINERS = list(
		"name" = "TOP 10 Miners",
		"color" = "#bd8e60",
		"entries" = list()
	),
	FEATURED_STATS_ALCHEMISTS = list(
		"name" = "TOP 10 Alchemists",
		"color" = "#3bac5d",
		"entries" = list()
	),
	FEATURED_STATS_STORYTELLERS = list(
		"name" = "TOP 10 Reigning Gods",
		"color" = "#eeca2c",
		"entries" = list()
	),
	FEATURED_STATS_GOURMETS = list(
		"name" = "TOP 10 Gourmets",
		"color" = "#6765cf",
		"entries" = list()
	),
	FEATURED_STATS_CRAFTED_ITEMS = list(
		"name" = "TOP 10 Crafted Items",
		"color" = "#a5953a",
		"entries" = list(),
		"object_stat" = TRUE
	),
	FEATURED_STATS_FISHERS = list(
		"name" = "TOP 10 Fishers",
		"color" = "#559bbb",
		"entries" = list()
	),
	FEATURED_STATS_CRAFTERS = list(
		"name" = "TOP 10 Crafters",
		"color" = "#a8a24e",
		"entries" = list()
	),
	FEATURED_STATS_FARMERS = list(
		"name" = "TOP 10 Farmers",
		"color" = "#50eb77",
		"entries" = list()
	),
	FEATURED_STATS_DRINKS = list(
		"name" = "TOP 10 Beverages",
		"color" = "#5487c0",
		"entries" = list(),
		"object_stat" = TRUE
	),
	FEATURED_STATS_SCREAMERS = list(
		"name" = "TOP 10 Screamers",
		"color" = "#d34747",
		"entries" = list()
	),
	FEATURED_STATS_THIEVES = list(
		"name" = "TOP 10 Thieves",
		"color" = "#6e4a25",
		"entries" = list()
	),
	FEATURED_STATS_ALCOHOLICS = list(
		"name" = "TOP 10 Alcoholics",
		"color" = "#945d96",
		"entries" = list()
	),
	FEATURED_STATS_MAGES = list(
		"name" = "TOP 10 Mages",
		"color" = "#9eaceb",
		"entries" = list()
	),
))

/proc/format_top_ten(stat_category)
	var/list/stat_data = GLOB.featured_stats[stat_category]
	if(!stat_data || !stat_data["entries"])
		return "Nobody"

	var/list/entries = list()
	for(var/key in stat_data["entries"])
		entries += list(list("name" = key, "count" = stat_data["entries"][key]))

	entries = sortList(entries, /proc/cmp_stat_count_desc)

	var/list/result = list()
	for(var/i in 1 to min(10, entries.len))
		var/list/entry = entries[i]
		var/rounded_count = round(entry["count"])
		result += "[i]. [entry["name"]] - [rounded_count]"

	return result.Join("<br>")

/proc/format_top_ten_objects(stat_category)
	var/list/stat_data = GLOB.featured_stats[stat_category]
	if(!stat_data || !stat_data["entries"])
		return "None"

	var/list/entries = list()
	for(var/key in stat_data["entries"])
		entries += list(list("name" = key, "count" = stat_data["entries"][key]))

	entries = sortList(entries, /proc/cmp_stat_count_desc)

	var/list/result = list()
	for(var/i in 1 to min(10, entries.len))
		var/list/entry = entries[i]
		var/rounded_count = round(entry["count"])
		result += "[i]. [entry["name"]] - [rounded_count]"

	return result.Join("<br>")

/proc/cmp_stat_count_desc(list/a, list/b)
	return b["count"] - a["count"]

/proc/record_featured_stat(stat_category, mob/living/user, increment = 1)
	if(!stat_category || !user?.real_name || !GLOB.featured_stats[stat_category])
		return

	var/list/stat_data = GLOB.featured_stats[stat_category]
	var/job_title = ""

	if(user.mind?.assigned_role)
		if(user.gender == FEMALE && user.mind.assigned_role)
			job_title = " ([user.mind.assigned_role])"
		else
			job_title = " ([user.mind.assigned_role])"
	else if(user.mind?.special_role)
		job_title = " ([user.mind.special_role])"
	else if(user.job && user.job != "Unassigned")
		job_title = " ([user.job])"

	var/key = "[user.real_name][job_title]"

	if(!stat_data["entries"])
		stat_data["entries"] = list()

	stat_data["entries"][key] = (stat_data["entries"][key] || 0) + increment


/proc/record_featured_object_stat(stat_category, object_name, increment = 1)
	if(!stat_category || !object_name || !GLOB.featured_stats[stat_category])
		return

	var/list/stat_data = GLOB.featured_stats[stat_category]

	if(!stat_data["entries"])
		stat_data["entries"] = list()

	stat_data["entries"][object_name] = (stat_data["entries"][object_name] || 0) + increment
