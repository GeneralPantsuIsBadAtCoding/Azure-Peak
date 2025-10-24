/datum/job/roguetown/orthodoxist
	title = "Orthodoxist"
	flag = ORTHODOXIST
	department_flag = INQUISITION
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	allowed_races = RACES_ALL_KINDS
	allowed_patrons = PSYDONIC_MAJORITY_PATRONS //Requires the character to be a practicing Psydonite within the 'Orthodoxism', 'Mysticism', or 'Fatalism' denominations. 'Syonacism'-type followers aren't strictly barred, but would likely object to the Inquisition's harsher methods.
	tutorial = "Praise. Atone. Mourn. A hundred different paths across a hundred different lyves, all ending the same; with you swearing fealty to Psydon, and your admittance into the Inquisitor's retinue. Root the abberants out from wherever they dwell, and - whether with a clenched fist or open palm - bring them back to the light."
	selection_color = JCOLOR_INQUISITION
	outfit = null
	outfit_female = null
	display_order = JDO_ORTHODOXIST
	min_pq = 5
	max_pq = null
	round_contrib_points = 2
	advclass_cat_rolls = list(CTAG_INQUISITION = 20)
	wanderer_examine = FALSE
	advjob_examine = TRUE
	give_bank_account = 15
	job_traits = list(TRAIT_STEELHEARTED, TRAIT_INQUISITION)
	job_subclasses = list(
		/datum/advclass/psydoniantemplar,
		/datum/advclass/disciple,
		/datum/advclass/confessor,
		/datum/advclass/psyaltrist
	)
