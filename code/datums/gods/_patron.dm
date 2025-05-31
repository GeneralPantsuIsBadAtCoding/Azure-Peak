#define CLERIC_SPELLS "Cleric"
#define PRIEST_SPELLS "Priest"

GLOBAL_LIST_EMPTY(patronlist)
GLOBAL_LIST_EMPTY(patrons_by_faith)
GLOBAL_LIST_EMPTY(preference_patrons)

/datum/patron
	/// Name of the god
	var/name
	/// Domain of the god, such as earth, fire, water, murder etc
	var/domain = "Bad coding practices"
	/// Description of the god
	var/desc = "A god that ordains you to report this on GitHub - You shouldn't be seeing this, someone forgot to set the description of this patron."
	/// String that represents who worships this guy
	var/worshippers = "Shitty coders"
	/// Faith this god belongs to
	var/datum/faith/associated_faith = /datum/faith
	/// Whether or not we are accessible in preferences
	var/preference_accessible = TRUE
	/// Whether or not this patron hates undead - Mostly so we know whether miracles should actually harm
	var/undead_hater = TRUE
	/// Some gods have related confessions, if they're evil and such
	var/list/confess_lines
	/// Some patrons have related traits, why not?
	var/list/mob_traits
	/// Assoc list of miracles it grants. Type = Cleric_Tier
	var/list/miracles = list()

	var/datum/storyteller/storyteller

/datum/patron/proc/on_gain(mob/living/pious)
	for(var/trait in mob_traits)
		ADD_TRAIT(pious, trait, "[type]")
	if(HAS_TRAIT(pious, TRAIT_XYLIX))
		pious.grant_language(/datum/language/thievescant)
		pious.verbs += /mob/living/carbon/human/proc/emote_ffsalute
	if (HAS_TRAIT(pious, TRAIT_CABAL))
		pious.faction |= "cabal"

/datum/patron/proc/on_loss(mob/living/pious)
	if (HAS_TRAIT(pious, TRAIT_CABAL))
		pious.faction -= "cabal"
	if(HAS_TRAIT(pious, TRAIT_XYLIX))
		pious.remove_language(/datum/language/thievescant)
	for(var/trait in mob_traits)
		REMOVE_TRAIT(pious, trait, "[type]")
