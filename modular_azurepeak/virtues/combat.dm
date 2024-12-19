/datum/virtue/combat/magical_potential
	name = "Arcyne Potential"
	desc = "I grasped the basics of arcyne magic at an early age, and have been able to prestidigitate for as long as I can remember."
	added_skills = list(/datum/skill/magic/arcane = 1)

/datum/virtue/combat/magical_potential/apply_to_human(mob/living/carbon/human/recipient)
	if (!recipient.mind?.get_skill_level(/datum/skill/magic/arcane)) // we can do this because apply_to is always called first
		recipient.mind?.adjust_spellpoints(-4) // Limits skill gain through for non-initial arcynes
		if (!recipient.mind?.has_spell(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation))
			recipient.mind?.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	else
		if (!HAS_TRAIT(recipient, TRAIT_MEDIUMARMOR) && !HAS_TRAIT(recipient, TRAIT_HEAVYARMOR) && !HAS_TRAIT(recipient, TRAIT_DODGEEXPERT))
			recipient.mind?.adjust_spellpoints(1) // 1 extra spellpoint if you're already arcane
		else
			recipient.mind?.adjust_spellpoints(2) // This lessons the -6 that applies to martial classes by default (currently only pontifex at time of change).
			to_chat(recipient, span_notice("My virtue lessens the limitations of my magical reach."))

/datum/virtue/combat/devotee
	name = "Devotee"
	desc = "Though not officially of the Church, my relationship with my chosen Patron is strong enough to grant me the most minor of their blessings."
	added_skills = list(/datum/skill/magic/holy = 1)

/datum/virtue/combat/devotee/apply_to_human(mob/living/carbon/human/recipient)
	if (!recipient.mind)
		return
	if (!recipient.devotion)
		// only give non-devotionists orison... and t0 for some reason (this is probably a bad idea)
		var/datum/devotion/new_faith = new /datum/devotion(recipient, recipient.patron)
		var/datum/patron/our_patron = new_faith.patron
		new_faith.max_devotion = CLERIC_REQ_1 - 20
		new_faith.max_progression = CLERIC_REQ_1 - 20
		recipient.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
		recipient.mind?.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/orison)
		recipient.mind?.AddSpell(new our_patron.t0) // i dunno... let's see how it plays out
	else
		// for devotionists, bump up their maximum 1 tier and give them a TINY amount of passive devo gain
		var/datum/devotion/our_faith = recipient.devotion
		our_faith.passive_devotion_gain += 0.15
		switch (our_faith.max_progression)
			if (CLERIC_REQ_0)
				our_faith.max_progression = CLERIC_REQ_1
			if (CLERIC_REQ_1)
				our_faith.max_progression = CLERIC_REQ_2
			if (CLERIC_REQ_2)
				our_faith.max_progression = CLERIC_REQ_3
			if (CLERIC_REQ_3)
				our_faith.max_progression = CLERIC_REQ_4
			if (CLERIC_REQ_4)
				our_faith.passive_devotion_gain += 1

/datum/virtue/combat/duelist
	name = "Duelist Apprentice"
	desc = "I have trained under a duelist of considerable skill, and always have my trusty rapier close at hand."
	added_skills = list(list(/datum/skill/combat/swords, 1, 4)) // increase swords by one to a maximum of 4
	added_stashed_items = list("Rapier" = /obj/item/rogueweapon/sword/rapier)

/datum/virtue/combat/bowman
	name = "Toxophilite"
	desc = "I have studied underneath a bowman of considerable skill, and always have my trusty bow and a quiver of arrows close at hand."
	added_skills = list(list(/datum/skill/combat/bows, 1, 4))
	added_stashed_items = list("Recurve Bow" = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve,
								"Quiver (Arrows)" = /obj/item/quiver/arrows
	)

/*/datum/virtue/combat/tavern_brawler
	name = "Tavern Brawler"
	desc = "I've never met a problem my fists couldn't solve."
	added_traits = list(TRAIT_CIVILIZEDBARBARIAN)*/

/datum/virtue/combat/guarded
	name = "Guarded"
	desc = "I have long kept my true capabilities a secret. Sometimes being deceptively weak can save one's life."
	added_traits = list(TRAIT_DECEIVING_MEEKNESS)

/datum/virtue/combat/impervious
	name = "Impervious"
	desc = "I've spent years shoring up my weakspots, and have become difficult to wound with critical blows."
	added_traits = list(TRAIT_CRITICAL_RESISTANCE)

/datum/virtue/combat/rotcured
	name = "Rotcured"
	desc = "I was once afflicted with the accursed rot, and was cured. It has left me changed: my limbs are weaker, but I feel no pain and have no need to breathe..."
	// below is functionally equivalent to dying and being resurrected via astrata T4 - yep, this is what it gives you.
	added_traits = list(TRAIT_EASYDISMEMBER, TRAIT_NOPAIN, TRAIT_NOPAINSTUN, TRAIT_NOBREATH, TRAIT_TOXIMMUNE, TRAIT_ZOMBIE_IMMUNE, TRAIT_ROTMAN)

/datum/virtue/combat/rotcured/apply_to_human(mob/living/carbon/human/recipient)
	recipient.update_body() // applies the rot skin tone stuff
