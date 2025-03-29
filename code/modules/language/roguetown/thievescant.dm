/datum/language/thievescant
	name = "Trickster's Tongue"
	desc = ""
	speech_verb = "murmurs"
	ask_verb = "questions"
	exclaim_verb = "shouts"
	key = "x"
	flags = LANGUAGE_HIDE_ICON_IF_UNDERSTOOD | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	space_chance = 66
	default_priority = 80
	icon_state = "asse"
	spans = list(SPAN_PAPYRUS)
	syllables = list("trick", "peasant", "torch", "cards", "gamble", "cottar", "knight", "grove", "mire", "coast", "dice", "dragon", "speak",
		"limner", "caudle", "fel", "trencher", "volf", "skelelon", "zomble", "kingsfield", "azure peak", "prince", "princess", "trap",
		"dawn", "dusk", "night", "day", "table", "bench", "tunnel", "roof", "floorboards",
		"pintle", "drake", "elf", "dwarf", "tall", "short", "frame", "portrait", "lord", "lady", "river", "woods", "axe", "dagger", "sword", "day", "night", "listen",
		"look", "see", "watch", "hear", "peep", "smell", "taste", "no", "yes", "silver", "gold", "sand", "grass", "rock",
		"mud", "hah", "save", "cave","over", "under", "carkin", "lark", "tosser", "knobhead", "daft", "gnerd", "knave",
		"fort", "cave","through the","hand","leg","foot","head","arrow","knee","elbow","eye","for a","reach","the","a","an","ask","tell","pray","travel","journey","quest")
	invisible = TRUE

/datum/language/thievescant/scramble(input)
	input = ""
	return input
