/datum/flesh_trait
	var/name = "base trait"
	var/description = "A basic personality trait"
	var/list/conflicting_traits = list() // Types of traits that can't coexist
	var/list/liked_concepts = list() // Topics this trait enjoys
	var/list/preferred_approaches = list()

/datum/flesh_trait/deception
	name = "Deception"
	description = "Enjoys lies, tricks, and hidden meanings"
	conflicting_traits = list(/datum/flesh_trait/honest)
	preferred_approaches = list("clever", "subtle", "mysterious")
	liked_concepts = list("lies", "secrets", "tricks", "illusions", "betrayal")

/datum/flesh_trait/violent
	name = "Violent" 
	description = "Thrives on aggression, pain, and destruction"
	conflicting_traits = list(/datum/flesh_trait/peaceful)
	preferred_approaches = list("forceful", "aggressive", "intense")
	liked_concepts = list("pain", "blood", "fighting", "breaking", "suffering")

/datum/flesh_trait/cautious
	name = "Cautious"
	description = "Hesitant and risk-averse"
	conflicting_traits = list(/datum/flesh_trait/impulsive, /datum/flesh_trait/destructive, /datum/flesh_trait/curious)
	preferred_approaches = list("gentle", "patient", "careful")
	liked_concepts = list("safe", "protection", "warning", "preparation", "patience")

/datum/flesh_trait/observant
	name = "Observant" 
	description = "Notices small details and patterns"
	conflicting_traits = list(/datum/flesh_trait/impulsive)
	preferred_approaches = list("detailed", "specific", "patient")
	liked_concepts = list("patterns", "details", "watching", "noticing", "clues")

/datum/flesh_trait/peaceful
	name = "Peaceful"
	description = "Prefers harmony and non-violence"
	conflicting_traits = list(/datum/flesh_trait/violent, /datum/flesh_trait/destructive)
	preferred_approaches = list("gentle", "calm", "patient")
	liked_concepts = list("calm", "quiet", "harmony", "peace", "stillness")

/datum/flesh_trait/creative
	name = "Creative"
	description = "Imaginative and original"
	conflicting_traits = list(/datum/flesh_trait/logical, /datum/flesh_trait/orderly, /datum/flesh_trait/destructive)
	preferred_approaches = list("imaginative", "unusual", "expressive")
	liked_concepts = list("imagination", "creation", "art", "dreams", "invention")

/datum/flesh_trait/curious
	name = "Curious"
	description = "Eager to learn and explore"
	conflicting_traits = list(/datum/flesh_trait/cautious)
	preferred_approaches = list("questioning", "exploratory", "detailed")
	liked_concepts = list("questions", "discovery", "secrets", "learning", "unknown")

/datum/flesh_trait/ambitious
	name = "Ambitious"
	description = "Driven by goals and achievement"
	conflicting_traits = list(/datum/flesh_trait/peaceful)
	preferred_approaches = list("determined", "focused", "forceful")
	liked_concepts = list("power", "success", "achievement", "goals", "dominance")

/datum/flesh_trait/logical
	name = "Logical"
	description = "Rational and systematic"
	conflicting_traits = list(/datum/flesh_trait/chaotic, /datum/flesh_trait/creative)
	preferred_approaches = list("precise", "systematic", "rational")
	liked_concepts = list("reason", "order", "proof", "system", "logic")

/datum/flesh_trait/honest
	name = "Honest"
	description = "Values truth and transparency"
	conflicting_traits = list(/datum/flesh_trait/deception)
	preferred_approaches = list("direct", "clear", "truthful")
	liked_concepts = list("truth", "honesty", "clarity", "trust", "transparency")

/datum/flesh_trait/orderly
	name = "Orderly"
	description = "Prefers structure and organization"
	conflicting_traits = list(/datum/flesh_trait/chaotic, /datum/flesh_trait/impulsive, /datum/flesh_trait/creative, /datum/flesh_trait/playful)
	preferred_approaches = list("systematic", "methodical", "precise")
	liked_concepts = list("order", "structure", "rules", "system", "organization")

/datum/flesh_trait/impulsive
	name = "Impulsive"
	description = "Acts on immediate desires"
	conflicting_traits = list(/datum/flesh_trait/cautious, /datum/flesh_trait/orderly, /datum/flesh_trait/observant, /datum/flesh_trait/philosophical, /datum/flesh_trait/analytical)
	preferred_approaches = list("quick", "spontaneous", "direct")
	liked_concepts = list("now", "immediate", "action", "desire", "impulse")

/datum/flesh_trait/territorial
	name = "Territorial"
	description = "Protective of space and possessions"
	conflicting_traits = list()
	preferred_approaches = list("protective", "defensive", "forceful")
	liked_concepts = list("mine", "territory", "defense", "protection", "ownership")

/datum/flesh_trait/dominant
	name = "Dominant"
	description = "Seeks control and authority"
	conflicting_traits = list()
	preferred_approaches = list("commanding", "forceful", "authoritative")
	liked_concepts = list("control", "power", "authority", "command", "dominance")

/datum/flesh_trait/destructive
	name = "Destructive"
	description = "Enjoys destruction and ruin"
	conflicting_traits = list(/datum/flesh_trait/peaceful, /datum/flesh_trait/creative, /datum/flesh_trait/cautious)
	preferred_approaches = list("forceful", "aggressive", "intense")
	liked_concepts = list("break", "destroy", "ruin", "shatter", "crush")

/datum/flesh_trait/playful
	name = "Playful"
	description = "Fun-loving and mischievous"
	conflicting_traits = list(/datum/flesh_trait/orderly)
	preferred_approaches = list("humorous", "light", "energetic")
	liked_concepts = list("fun", "games", "jokes", "play", "laughter")

/datum/flesh_trait/chaotic
	name = "Chaotic"
	description = "Embraces randomness and disorder"
	conflicting_traits = list(/datum/flesh_trait/orderly, /datum/flesh_trait/logical)
	preferred_approaches = list("unpredictable", "spontaneous", "random")
	liked_concepts = list("chaos", "random", "change", "surprise", "freedom")

/datum/flesh_trait/philosophical
	name = "Philosophical"
	description = "Contemplates deep questions"
	conflicting_traits = list(/datum/flesh_trait/impulsive)
	preferred_approaches = list("thoughtful", "deep", "questioning")
	liked_concepts = list("meaning", "existence", "truth", "reality", "purpose")

/datum/flesh_trait/analytical
	name = "Analytical"
	description = "Breaks things down systematically"
	conflicting_traits = list(/datum/flesh_trait/impulsive)
	preferred_approaches = list("detailed", "systematic", "precise")
	liked_concepts = list("analysis", "examination", "details", "patterns", "understanding")
