/datum/flesh_archetype
	var/name = "base archetype"
	var/description = "A personality archetype"
	var/list/possible_traits = list()
	var/list/possible_quirks = list()
	var/list/discharge_colors = list()
	var/color = "#ffffff"
	var/required_item
	var/calibration_required = 5

/datum/flesh_archetype/fearful
	name = "Fearful"
	description = "Anxious and easily frightened"
	color = "#373777"
	required_item = /obj/item/alch/valeriana
	possible_traits = list(
		/datum/flesh_trait/cautious,
		/datum/flesh_trait/observant,
		/datum/flesh_trait/peaceful,
		/datum/flesh_trait/curious,
		/datum/flesh_trait/creative,
		/datum/flesh_trait/analytical
	)
	possible_quirks = list(
		/datum/flesh_quirk/timid,
		/datum/flesh_quirk/obedient,
		/datum/flesh_quirk/forgetful,
		/datum/flesh_quirk/affectionate,
		/datum/flesh_quirk/patient,
		/datum/flesh_quirk/discharge
	)
	discharge_colors = list("#373777", "#435f92", "#3c523c")

/datum/flesh_archetype/authoritarian
	name = "Authoritarian"
	description = "Demands order and respect"
	color = "#880000"
	required_item = /obj/item/alch/salvia
	possible_traits = list(
		/datum/flesh_trait/ambitious,
		/datum/flesh_trait/logical,
		/datum/flesh_trait/orderly,
		/datum/flesh_trait/dominant,
		/datum/flesh_trait/honest,
		/datum/flesh_trait/observant,
		/datum/flesh_trait/analytical
	)
	possible_quirks = list(
		/datum/flesh_quirk/royal,
		/datum/flesh_quirk/ambitious,
		/datum/flesh_quirk/territorial,
		/datum/flesh_quirk/stubborn,
		/datum/flesh_quirk/obedient,
		/datum/flesh_quirk/discharge
	)
	discharge_colors = list("#880000", "#373777", "#d7d8a6")

/datum/flesh_archetype/aggressive
	name = "Aggressive"
	description = "Prone to anger and violence"
	color = "#dc143c"
	required_item = /obj/item/alch/urtica
	possible_traits = list(
		/datum/flesh_trait/violent,
		/datum/flesh_trait/impulsive,
		/datum/flesh_trait/territorial,
		/datum/flesh_trait/dominant,
		/datum/flesh_trait/destructive,
		/datum/flesh_trait/ambitious,
		/datum/flesh_trait/chaotic
	)
	possible_quirks = list(
		/datum/flesh_quirk/impatient,
		/datum/flesh_quirk/territorial,
		/datum/flesh_quirk/hoarder,
		/datum/flesh_quirk/stubborn,
		/datum/flesh_quirk/royal,
		/datum/flesh_quirk/ambitious,
		/datum/flesh_quirk/discharge
	)
	discharge_colors = list("#d7d8a6", "#6d4b25", "#880000")

/datum/flesh_archetype/arbitrary
	name = "Arbitrary"
	description = "Unpredictable and whimsical"
	color = "#9370db"
	required_item = /obj/item/alch/artemisia
	possible_traits = list(
		/datum/flesh_trait/playful,
		/datum/flesh_trait/creative,
		/datum/flesh_trait/deception,
		/datum/flesh_trait/chaotic,
		/datum/flesh_trait/curious,
		/datum/flesh_trait/impulsive,
		/datum/flesh_trait/destructive
	)
	possible_quirks = list(
		/datum/flesh_quirk/obedient,
		/datum/flesh_quirk/curious,
		/datum/flesh_quirk/impatient,
		/datum/flesh_quirk/royal,
		/datum/flesh_quirk/discharge,
		/datum/flesh_quirk/repetitive,
		/datum/flesh_quirk/timid,
		/datum/flesh_quirk/ambitious,
		/datum/flesh_quirk/forgetful,
		/datum/flesh_quirk/affectionate,
		/datum/flesh_quirk/territorial,
		/datum/flesh_quirk/mimic,
		/datum/flesh_quirk/hoarder,
		/datum/flesh_quirk/stubborn,
		/datum/flesh_quirk/patient
	)
	discharge_colors = list("#43516b", "#6d4b25", "#d7d8a6")

/datum/flesh_archetype/inquisitive
	name = "Inquisitive"
	description = "Constantly seeking knowledge"
	color = "#1e90ff"
	required_item = /obj/item/alch/mentha
	possible_traits = list(
		/datum/flesh_trait/curious,
		/datum/flesh_trait/philosophical,
		/datum/flesh_trait/logical,
		/datum/flesh_trait/observant,
		/datum/flesh_trait/analytical,
		/datum/flesh_trait/orderly,
		/datum/flesh_trait/peaceful,
		/datum/flesh_trait/honest,
		/datum/flesh_trait/playful
	)
	possible_quirks = list(
		/datum/flesh_quirk/curious,
		/datum/flesh_quirk/repetitive,
		/datum/flesh_quirk/hoarder,
		/datum/flesh_quirk/patient,
		/datum/flesh_quirk/affectionate,
		/datum/flesh_quirk/timid,
		/datum/flesh_quirk/mimic,
		/datum/flesh_quirk/discharge
	)
	discharge_colors = list("#3c523c", "#435f92", "#d7d8a6")

/datum/flesh_archetype/split_personality
	name = "Split personality"
	description = "A constantly shifting and contradictory inner self"
	color = "#00ff7f"
	required_item = /obj/item/alch/rosa
	possible_traits = list(
		/datum/flesh_trait/cautious,
		/datum/flesh_trait/observant,
		/datum/flesh_trait/peaceful,
		/datum/flesh_trait/curious,
		/datum/flesh_trait/creative,
		/datum/flesh_trait/analytical,
		/datum/flesh_trait/ambitious,
		/datum/flesh_trait/logical,
		/datum/flesh_trait/orderly,
		/datum/flesh_trait/dominant,
		/datum/flesh_trait/honest,
		/datum/flesh_trait/violent,
		/datum/flesh_trait/impulsive,
		/datum/flesh_trait/territorial,
		/datum/flesh_trait/destructive,
		/datum/flesh_trait/chaotic,
		/datum/flesh_trait/playful,
		/datum/flesh_trait/deception,
		/datum/flesh_trait/philosophical
	)
	possible_quirks = list(
		/datum/flesh_quirk/impatient,
		/datum/flesh_quirk/royal,
		/datum/flesh_quirk/territorial,
		/datum/flesh_quirk/affectionate,
		/datum/flesh_quirk/discharge
	)
	discharge_colors = list("#880000", "#6d4b25")
