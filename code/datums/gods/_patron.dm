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
	/// List of words that this god considers profane. (Master for all faiths.)
	var/list/profane_words = list("zizo","cock","dick","fuck","shit","pussy","cuck","cunt","asshole", "pintle")

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

/* -----PRAYERS----- */

/// Called when a patron's follower attempts to pray.
/// Returns TRUE if they satisfy the needed conditions.
/datum/patron/proc/can_pray(mob/living/follower)
	return TRUE

/// Called when a patron's follower prays to them.
/// Returns TRUE if their prayer was heard and the patron was not insulted
/datum/patron/proc/hear_prayer(mob/living/follower, message)
	if(!follower || !message)
		return FALSE
	var/prayer = sanitize_hear_message(message)

	if(length(profane_words))
		for(var/profanity in profane_words)
			if(findtext(prayer, profanity))
				punish_prayer(follower)
				return FALSE

	var/patron_name = follower?.patron?.name
	if(!patron_name)
		CRASH("check_prayer called with null patron")

	if(length(prayer) <= 15)
		to_chat(follower, span_danger("My prayer was kinda short..."))
		return FALSE

	if(follower.mob_timers[MT_PSYPRAY])
		if(world.time < follower.mob_timers[MT_PSYPRAY] + 1 MINUTES)
			follower.mob_timers[MT_PSYPRAY] = world.time
			return FALSE
	else
		follower.mob_timers[MT_PSYPRAY] = world.time

	. = TRUE //the prayer has succeeded by this point forward

	if(findtext(prayer, name))
		reward_prayer(follower)

/// The follower has somehow offended the patron and is now being punished.
/datum/patron/proc/punish_prayer(mob/living/follower)
	follower.adjust_divine_fire_stacks(20)
	follower.IgniteMob()
	follower.add_stress(/datum/stressevent/psycurse)

/// The follower has prayed in a special way to the patron and is being rewarded.
/datum/patron/proc/reward_prayer(mob/living/follower)
	SHOULD_CALL_PARENT(TRUE)
	if(follower.has_flaw(/datum/charflaw/addiction/godfearing))
		follower.sate_addiction()
	follower.playsound_local(follower, 'sound/misc/notice (2).ogg', 100, FALSE)
	follower.add_stress(/datum/stressevent/psyprayer)
