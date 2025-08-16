// Danger levels. Each danger level is defined as an ambush that can happen. Every time this fire, this number iterates.
#define DANGER_LEVEL_SAFE 0
#define DANGER_LEVEL_LOW 1
#define DANGER_LEVEL_MODERATE 2
#define DANGER_LEVEL_DANGEROUS 3
#define DANGER_LEVEL_DIRE 4

#define THREAT_REGION_AZURE_BASIN "Azure Basin"
#define THREAT_REGION_NORTHERN_GROVE "Northern Grove"
#define THREAT_REGION_WESTERN_GROVE "Western Grove" // Grove west of the road
#define THREAT_REGION_SOUTH_AZUREAN_COAST "South Azurean Coast"
#define THREAT_REGION_NORTH_AZUREAN_COAST "North Azurean Coast"
#define THREAT_REGION_MOUNT_DECAP "Mount Decapitation"
#define THREAT_REGION_TERRORBOG "Terrorbog"

#define LOWPOP_THRESHOLD 30 // When do we give highpop tick?
// Subsystem meant to handle regional threat level

SUBSYSTEM_DEF(regionthreat)
	name = "Regional Threat"
	wait = 10 MINUTES
	flags = SS_KEEP_TIMING | SS_BACKGROUND
	runlevels = RUNLEVEL_GAME
	// The first four regions are meant to be "tameable" for towner purposes
	var/list/threat_regions = list(
		new /datum/threat_region(
			_region_name = THREAT_REGION_AZURE_BASIN, 
			_latent_ambush = DANGER_LOW_FLOOR,
			_min_ambush = DANGER_SAFE_FLOOR,
			_max_ambush = DANGER_DANGEROUS_LIMIT, // Let's not go DIRE no matter what, in the future 
			_fixed_ambush = FALSE,
			_lowpop_tick = 1,
			_highpop_tick = 2
		),
		new /datum/threat_region(
			_region_name = THREAT_REGION_NORTHERN_GROVE,
			_latent_ambush = DANGER_MODERATE_FLOOR,
			_min_ambush = DANGER_SAFE_FLOOR,
			_max_ambush = DANGER_DANGEROUS_LIMIT,
			_fixed_ambush = FALSE,
			_lowpop_tick = 1,
			_highpop_tick = 2
		),
		new /datum/threat_region(
			_region_name = THREAT_REGION_SOUTH_AZUREAN_COAST,
			_latent_ambush = DANGER_DANGEROUS_FLOOR,
			_min_ambush = DANGER_SAFE_FLOOR,
			_max_ambush = DANGER_DIRE_LIMIT,
			_fixed_ambush = FALSE,
			_lowpop_tick = 2,
			_highpop_tick = 3 // It is not the terrorbog.
		),
		new /datum/threat_region(
			_region_name = THREAT_REGION_TERRORBOG,
			_latent_ambush = DANGER_DIRE_LIMIT,
			_min_ambush = DANGER_SAFE_FLOOR, // This is intended. A warden can engage in a long war to tame the terrorbog.
			_max_ambush = DANGER_DIRE_LIMIT,
			_fixed_ambush = 2,
			_lowpop_tick = 2,
			_highpop_tick = 4
		),
		// All regions after are meant to stay somewhat dangerous no matter what
		new /datum/threat_region(
			_region_name = THREAT_REGION_WESTERN_GROVE,
			_latent_ambush = DANGER_MODERATE_LIMIT,
			_min_ambush = DANGER_MODERATE_FLOOR,
			_max_ambush = DANGER_DIRE_LIMIT,
			_fixed_ambush = FALSE,
			_lowpop_tick = 2,
			_highpop_tick = 4
		),
		new /datum/threat_region(
			_region_name = THREAT_REGION_NORTH_AZUREAN_COAST,
			_latent_ambush = DANGER_DANGEROUS_FLOOR,
			_min_ambush = DANGER_MODERATE_FLOOR,
			_max_ambush = DANGER_DIRE_LIMIT,
			_fixed_ambush = FALSE,
			_lowpop_tick = 2,
			_highpop_tick = 4
		),
		new /datum/threat_region(
			_region_name = THREAT_REGION_MOUNT_DECAP,
			_latent_ambush = DANGER_DANGEROUS_FLOOR,
			_min_ambush = DANGER_MODERATE_FLOOR,
			_max_ambush = DANGER_DIRE_LIMIT,
			_fixed_ambush = FALSE,
			_lowpop_tick = 2,
			_highpop_tick = 4
		)
	)

/datum/controller/subsystem/regionthreat/proc/get_region(region_name)
	for(var/T in threat_regions)
		var/datum/threat_region/TR = T
		if(TR.region_name == region_name)
			return TR
	return null

/datum/controller/subsystem/regionthreat/proc/get_effective_threat_level(level)
	if(DANGER_SAFE_FLOOR <= level && level <= DANGER_LOW_LIMIT)
		return DANGER_LEVEL_SAFE
	else if(DANGER_LOW_FLOOR <= level && level <= DANGER_MODERATE_LIMIT)
		return DANGER_LEVEL_LOW
	else if(DANGER_MODERATE_FLOOR <= level && level <= DANGER_DANGEROUS_LIMIT)
		return DANGER_LEVEL_MODERATE
	else if(DANGER_DANGEROUS_FLOOR <= level && level <= DANGER_DIRE_LIMIT)
		return DANGER_LEVEL_DANGEROUS
	else if(DANGER_DIRE_FLOOR <= level)
		return DANGER_LEVEL_DIRE
	else
		return DANGER_LEVEL_SAFE

/datum/controller/subsystem/regionthreat/fire(resumed)
	var/player_count = GLOB.player_list.len
	var/ishighpop = player_count >= LOWPOP_THRESHOLD
	for(var/T in threat_regions)
		var/datum/threat_region/TR = T
		if(ishighpop)
			TR.increase_latent_ambush(TR.highpop_tick)
		else
			TR.increase_latent_ambush(TR.lowpop_tick)
