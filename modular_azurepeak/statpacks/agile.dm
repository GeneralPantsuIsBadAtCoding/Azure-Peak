// Ranger/rogue archetypes
/datum/statpack/agile/swift
	name = "Swift"
	desc = "With the wind in your hair and trouble at your back, your speed has oft been your salvation."
	stat_array = list(STAT_STRENGTH = -1, STAT_CONSTITUTION = -1, STAT_ENDURANCE = 1, STAT_SPEED = 2)

/datum/statpack/agile/hardy
	name = "Hardy"
	desc = "Uniquely Pestran fortitude affords you the means to shrug off illnesses and poisons that others might not."
	stat_array = list(STAT_STRENGTH = -1, STAT_CONSTITUTION = 2, STAT_ENDURANCE = 1, STAT_SPEED = -1)

/datum/statpack/agile/tricky
	name = "Tricky"
	desc = "Swift feet with a mind to match and a tiny sliver of the Ten's own luck... or not."
	stat_array = list(STAT_STRENGTH = -1, STAT_PERCEPTION = 1, STAT_INTELLIGENCE = 1, STAT_ENDURANCE = -1, STAT_SPEED = 1, STAT_FORTUNE = list(-1, 1))

/datum/statpack/agile/thug
	name = "Thuggish"
	desc = "Your robust physique and keen eyes oft been your most valuable friends in such trying times."
	stat_array = list(STAT_STRENGTH = 2, STAT_PERCEPTION = 1, STAT_FORTUNE = list(0, 1), STAT_CONSTITUTION = -1, STAT_ENDURANCE = -1, STAT_SPEED = -1)

/datum/statpack/agile/wary
	name = "Wary"
	desc = "Eyes forward, ever and always. A careful course has always seen you through... so far."
	stat_array = list(STAT_STRENGTH = -1, STAT_PERCEPTION = 1, STAT_INTELLIGENCE = 1, STAT_CONSTITUTION = 1, STAT_SPEED = -1)
