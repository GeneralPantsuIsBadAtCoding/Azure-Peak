SUBSYSTEM_DEF(chimeric_tech)
	name = "Chimeric Tech Controller"
	priority = FIRE_PRIORITY_DEFAULT
	flags = SS_NO_FIRE

	// The master list of all instantiated nodes, keyed by type path.
	var/list/all_tech_nodes = list()
	var/list/cached_choices = list() // Stores the currently offered choices
	var/list/cached_choices_paths = list()

/datum/controller/subsystem/chimeric_tech/proc/clear_cached_choices()
	// Clears the cache when a tech is unlocked.
	cached_choices = list()
	cached_choices_paths = list()

/datum/controller/subsystem/chimeric_tech/Initialize()
	. = ..()
	to_chat(world, span_userdanger("SUBSYSTEMO LOADED"))
	load_all_tech_nodes()
	return

/datum/controller/subsystem/chimeric_tech/proc/load_all_tech_nodes()
	for(var/T in typesof(/datum/chimeric_tech_node) - /datum/chimeric_tech_node)
		var/datum/chimeric_tech_node/new_node = new T()
		all_tech_nodes[new_node.string_id] = new_node

/datum/controller/subsystem/chimeric_tech/proc/get_node_status(var/node_path)
	var/datum/chimeric_tech_node/node = all_tech_nodes[node_path]
	if(node)
		return node.unlocked
	return FALSE

/datum/controller/subsystem/chimeric_tech/proc/get_available_choices(var/current_tier, var/current_points, var/max_choices = 3)
	to_chat(world, "DEBUG: get_available_choices called. Tier: [current_tier], Points: [current_points]")
	if(cached_choices.len)
		to_chat(world, "DEBUG: Returning cached choices ([cached_choices.len] nodes).")
		return cached_choices

	var/list/eligible_nodes = list()
	var/list/selection_pool = list()

	to_chat(world, "DEBUG: AMOUNT OF NODES ([all_tech_nodes.len] nodes).")
	// Determine Eligibility and Cost Check
	for(var/node_path in all_tech_nodes)
		var/datum/chimeric_tech_node/N = all_tech_nodes[node_path]
		to_chat(world, "DEBUG: Checking node: [N.name] ([node_path])")

		if(N.unlocked)
			to_chat(world, "DEBUG: - Skipping [N.name]: Already unlocked.")
			continue

		if(current_tier < N.required_tier)
			to_chat(world, "DEBUG: - Skipping [N.name]: Tier [current_tier] < Required Tier [N.required_tier].")
			continue

		var/prereqs_met = TRUE
		for(var/required_node_path in N.prerequisites)
			if(!get_node_status(required_node_path)) // Use the global check proc
				to_chat(world, "DEBUG: - Skipping [N.name]: Missing prerequisite [required_node_path].")
				prereqs_met = FALSE
				break

		if(prereqs_met)
			to_chat(world, "DEBUG: - Node [N.name] is eligible.")
			eligible_nodes += N

	to_chat(world, "DEBUG: Total eligible nodes: [eligible_nodes.len]")

	// Build the Weighted Selection Pool
	for(var/datum/chimeric_tech_node/N in eligible_nodes)
		for(var/i = 1 to N.selection_weight)
			selection_pool += N

	// Select the Limited Choices
	var/list/final_choices = list()
	while(final_choices.len < max_choices && selection_pool.len > 0)
		var/datum/chimeric_tech_node/chosen_node = pick(selection_pool)

		if(!(chosen_node in final_choices))
			final_choices += chosen_node

		selection_pool -= chosen_node // Remove all instances of this node

	cached_choices = final_choices
	for(var/datum/chimeric_tech_node/N in final_choices)
		cached_choices_paths += N.type

	to_chat(world, "DEBUG: Final choices selected: [final_choices.len]")

	return final_choices

/datum/controller/subsystem/chimeric_tech/proc/unlock_node(var/string_id, var/datum/component/chimeric_heart_beast/beast_component)
	to_chat(world, span_userdanger("[string_id] string id!"))
	var/datum/chimeric_tech_node/node = all_tech_nodes[string_id]

	if(!node)
		return "Error: Node not found."
	if(node.unlocked)
		return "Already unlocked."

	if(beast_component.language_tier < node.required_tier || beast_component.tech_points < node.cost)
		return "Requirements not met."

	for(var/required_node_path in node.prerequisites)
		if(!get_node_status(required_node_path))
			return "Missing prerequisite: [required_node_path]"

	beast_component.tech_points -= node.cost
	node.unlocked = TRUE
	clear_cached_choices() 

	return "Successfully unlocked [node.name]!"

/datum/controller/subsystem/chimeric_tech/proc/get_healing_multiplier()
	var/multiplier = 0.75

	var/advanced_healing_path = /datum/chimeric_tech_node/awaken_healing
	var/enhanced_healing_path = /datum/chimeric_tech_node/enhanced_healing
	
	if(get_node_status(advanced_healing_path))
		multiplier = 1.0
	if(get_node_status(enhanced_healing_path))
		multiplier = 1.1
	
	return multiplier
