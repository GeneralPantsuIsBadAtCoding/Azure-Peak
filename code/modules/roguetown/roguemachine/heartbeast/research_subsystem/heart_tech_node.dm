/datum/chimeric_tech_node
	// Make sure this identifier is unique
	var/name = "Base Node"
	var/description = "This is the default description."
	var/tech_path // The path of the actual implementation datum/object
	var/string_id = "BASE_NODE" // Used to find the datums in the tech subsytem

	var/unlocked = FALSE
	var/is_recipe_node = FALSE

	var/required_tier = 1        	// Heartbeast Language Tier requirement
	var/cost = 50                	// Tech Points cost
	var/list/prerequisites = list() // List of required node paths
	var/recipe_override = null

	var/selection_weight = 10    // Higher number = more likely to appear

/// HEALING MIRACLE TECHS
/datum/chimeric_tech_node/awaken_healing
	name = "Awaken divine regeneration"
	description = "Increases the healing of most healing miracles significantly."
	string_id = "HEAL_TIER1"
	required_tier = 1
	cost = 20
	selection_weight = 15

/datum/chimeric_tech_node/enhanced_healing
	name = "Enhance divine regeneration"
	description = "Increases the healing of most healing miracles slightly."
	string_id = "HEAL_TIER2"
	required_tier = 3
	cost = 85
	selection_weight = 15
	prerequisites = list("HEAL_TIER1") 

/datum/chimeric_tech_node/awaken_resurrection
	name = "Awaken divine resurrection"
	description = "Decreases the cooldown of resurrection miracles significantly."
	string_id = "REVIVE_TIER1"
	required_tier = 2
	cost = 40
	selection_weight = 50
	prerequisites = list("HEAL_TIER1")

/datum/chimeric_tech_node/enhanced_resurrection
	name = "Enhance divine resurrection"
	description = "Decreases the cost of resurrection miracles significantly."
	string_id = "REVIVE_TIER2"
	required_tier = 3
	cost = 120
	selection_weight = 50
	prerequisites = list("REVIVE_TIER1")

/datum/chimeric_tech_node/residual_frankenbrew
	name = "Impure lux filtration"
	description = "Allows making a small amount of revival elixer for fulmenor chairs out of impure lux."
	string_id = "LUX_FILTRATION"
	required_tier = 1
	cost = 5
	selection_weight = 5
	is_recipe_node = TRUE
