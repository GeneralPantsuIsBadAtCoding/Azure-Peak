
//////////////////////////////////////////////
//                                          //
//           SYNDICATE TRAITORS             //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/traitor
	name = "Traitors"
	persistent = TRUE
	antag_flag = ROLE_TRAITOR
	antag_datum = /datum/antagonist/traitor/
	minimum_required_age = 0
	protected_roles = list("Security Officer", "Warden", "Detective", "Head of Security", "Captain")
	restricted_roles = list("Cyborg")
	required_candidates = 1
	weight = 5
	cost = 10	// Avoid raising traitor threat above 10, as it is the default low cost ruleset.
	scaling_cost = 10
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	high_population_requirement = 10
	antag_cap = list(1,1,1,1,2,2,2,2,3,3)
	var/autotraitor_cooldown = 450 // 15 minutes (ticks once per 2 sec)

/datum/dynamic_ruleset/roundstart/traitor/pre_execute()
	var/num_traitors = antag_cap[indice_pop] * (scaled_times + 1)
	for (var/i = 1 to num_traitors)
		var/mob/M = pick_n_take(candidates)
		assigned += M.mind
		M.mind.special_role = ROLE_TRAITOR
		M.mind.restricted_roles = restricted_roles
		GLOB.pre_setup_antags += M.mind
	return TRUE

/datum/dynamic_ruleset/roundstart/traitor/rule_process()
	if (autotraitor_cooldown > 0)
		autotraitor_cooldown--
	else
		autotraitor_cooldown = 450 // 15 minutes
		message_admins("Checking if we can turn someone into a traitor.")
		log_game("DYNAMIC: Checking if we can turn someone into a traitor.")
		mode.picking_specific_rule(/datum/dynamic_ruleset/midround/autotraitor)

// Admin only rulesets. The threat requirement is 101 so it is not possible to roll them.

//////////////////////////////////////////////
//                                          //
//               EXTENDED                   //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/extended
	name = "Extended"
	antag_flag = null
	antag_datum = null
	restricted_roles = list()
	required_candidates = 0
	weight = 3
	cost = 0
	requirements = list(101,101,101,101,101,101,101,101,101,101)
	high_population_requirement = 101

/datum/dynamic_ruleset/roundstart/extended/pre_execute()
	message_admins("Starting a round of extended.")
	log_game("Starting a round of extended.")
	mode.spend_threat(mode.threat)
	return TRUE
