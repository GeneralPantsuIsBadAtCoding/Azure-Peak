/datum/wound/bruise
	name = "hematoma"
	whp = 30
	bleed_rate = 0
	clotting_threshold = null
	sewn_clotting_threshold = null
	woundpain = 10
	sew_threshold = 50
	can_sew = FALSE
	can_cauterize = FALSE
	passive_healing = 0.5

	werewolf_infection_probability = 0

/datum/wound/bruise/small
	name = "bruise"
	whp = 15
	bleed_rate = 0
	woundpain = 5
	sew_threshold = 25

/datum/wound/bruise/large
	name = "massive hematoma"
	whp = 40
	bleed_rate = 0.9
	clotting_rate = 0.02
	clotting_threshold = 0.3
	woundpain = 25

/datum/wound/dynamic/bruise
	name = "hematoma"
	whp = 5
	bleed_rate = 0
	clotting_threshold = null
	sewn_clotting_threshold = null
	woundpain = 5
	sew_threshold = 50
	can_sew = FALSE
	can_cauterize = FALSE
	passive_healing = 0.5
	severity_names = list(
		"meager" = 20,
		"painful" = 40,
		"gnarly" = 80,
		"incapacitating" = 120,
		"insufferable" = 200,
	)

#define BRUISE_UPG_BLEEDRATE 0.02
#define BRUISE_UPG_WHPRATE 0.8
#define BRUISE_UPG_PAINRATE 0.7
#define BRUISE_UPG_PASSIVEHEAL 0.5

/datum/wound/dynamic/bruise/upgrade(dam)
	whp += (dam * BRUISE_UPG_WHPRATE)
	bleed_rate += (dam * BRUISE_UPG_BLEEDRATE)
	woundpain += (dam * BRUISE_UPG_PAINRATE)
	passive_healing += BRUISE_UPG_PASSIVEHEAL
	update_name()
	..()

#undef BRUISE_UPG_BLEEDRATE
#undef BRUISE_UPG_WHPRATE
#undef BRUISE_UPG_PAINRATE
#undef BRUISE_UPG_PASSIVEHEAL
