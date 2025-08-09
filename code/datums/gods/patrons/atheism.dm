/datum/patron/godless
	name = "Science"
	domain = "Ontological Reality"
	desc = "No gods or kings, only man! Gods exist but you give them the finger."
	worshippers = "Madmen, beasts and some dwarves"
	associated_faith = /datum/faith/godless
	preference_accessible = FALSE
	undead_hater = FALSE
	confess_lines = list(
		"Gods are WORTHLESS!",
		"I DON'T NEED GODS!",
		"I AM MY OWN GOD!",
		"NO GODS, NO MASTERS!",
	)

/datum/patron/godless/can_pray(mob/living/follower)
	. = ..()
	to_chat(follower, span_danger("Zarlz Zarwin and psyvolution cannot hear my prayer!"))
	return FALSE	//heathen
