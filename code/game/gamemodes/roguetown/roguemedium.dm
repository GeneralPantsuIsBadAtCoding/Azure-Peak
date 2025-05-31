#define ROGUEMEDIUM_PLAYER_LIMIT 35
/datum/game_mode/chaosmode/roguemedium
	name = "roguemedium"
	config_tag = "roguemedium"
	report_type = "roguemedium"
	false_report_weight = 0
	required_players = 0 //
	required_enemies = 0
	recommended_enemies = 0
	enemy_minimum_age = 0
	votable = FALSE // Temporarily disabled until we have more antags variety + scale it properly
	probability = 80

	announce_span = "danger"
	announce_text = "The town has been infiltrated by bandits and werewolves! Watch your back..."

	var/chosen_antag = ""  // Will be either "bandits" or "werewolves", used as a backup for roguelite

// Override after_DO to only use bandits and werewolves
/datum/game_mode/chaosmode/roguemedium/after_DO()
	if(allmig || roguefight)
		return TRUE

	if(num_players() <= ROGUEMEDIUM_PLAYER_LIMIT && num_players() >= ROGUELITE_PLAYER_LIMIT) // Need at least a chunk of people before we start throwing ne'er-do-wells into the mix.
		log_game("Roguemedium is active, but less than 35 readied playercount. Switching to Roguelite mode (1 antag).")
		if(prob(50))
			chosen_antag = "bandits"
			pick_bandits()
			log_game("Antagonists: Roguelite Mode (Roguemedium Fallback) - Bandits")
		else
			chosen_antag = "werewolves"
			pick_werewolves()
			log_game("Antagonists: Roguelite Mode (Roguemedium Fallback) - Werewolves")
		return TRUE
	
	if(num_players() <= ROGUELITE_PLAYER_LIMIT)
		log_game("Roguemedium is active, but less than 25 readied playercount. Antags will not be picked automatically.")
		return TRUE

	// Select bandits
	pick_bandits()
	// Select werewolves
	pick_werewolves()

	return TRUE
