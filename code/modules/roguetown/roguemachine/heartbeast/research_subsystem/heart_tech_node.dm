/datum/chimeric_tech_node
	// Make sure this identifier is unique
	var/name = "Base Node"
	var/description = "This is the default description."
	var/tech_path // The path of the actual implementation datum/object

	var/unlocked = FALSE

	var/required_tier = 1        	// Heartbeast Language Tier requirement
	var/cost = 50                	// Tech Points cost
	var/list/prerequisites = list() // List of required node paths

	var/selection_weight = 10    // Higher number = more likely to appear

/// HEALING MIRACLE TECHS
/datum/chimeric_tech_node/awaken_healing
    name = "Awaken divine regeneration"
    description = "Increases the healing of most healing miracles significantly."
    required_tier = 1
    cost = 20
    selection_weight = 15

/datum/chimeric_tech_node/enhanced_healing
    name = "Enhance divine regeneration"
    description = "Increases the healing of most healing miracles slightly."
    required_tier = 3
    cost = 85
    selection_weight = 15
	prerequisites = list(/datum/chimeric_tech_node/awaken_healing) 

/datum/chimeric_tech_node/awaken_resurrection
	name = "Awaken divine resurrection"
	description = "Decreases the cooldown of resurrection miracles significantly."
	required_tier = 2
	cost = 40
	selection_weight = 50
	prerequisites = list(/datum/chimeric_tech_node/awaken_healing)

/datum/chimeric_tech_node/enhanced_resurrection
	name = "Enhance divine resurrection"
	description = "Decreases the cost of resurrection miracles significantly."
	required_tier = 3
	cost = 120
	selection_weight = 50
	prerequisites = list(/datum/chimeric_tech_node/awaken_resurrection)
