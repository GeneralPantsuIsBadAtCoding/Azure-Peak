/obj/item/bodypart/proc/twilight_gunpowder_crit(bclass = BCLASS_BLUNT, mob/living/user, zone_precise = src.body_zone, silent = FALSE, crit_message = FALSE)
	if(!bclass || (owner.status_flags & GODMODE))
		return FALSE
	var/list/attempted_wounds = list()
	var/crit_chance = rand(1, 100)
	if(user)
		if(user.goodluck(2))
			crit_chance += 10
	if(NOBLOOD in owner.dna?.species?.species_traits)
		if(prob(30))
			attempted_wounds += /datum/wound/fracture		//More sevre wound
		else
			attempted_wounds += /datum/wound/dislocation	//Less sevre wound
	else
		switch(crit_chance)
			if(1 to 50)
				if(HAS_TRAIT(src, TRAIT_BRITTLE))
					attempted_wounds += /datum/wound/fracture
				else
					attempted_wounds += /datum/wound/dislocation
			if(50 to 80)
				if(prob(30))
					attempted_wounds += /datum/wound/fracture		//More sevre wound
				else
					attempted_wounds += /datum/wound/dislocation	//Less sevre wound
			if(80 to INFINITY)
				attempted_wounds += /datum/wound/artery

	for(var/wound_type in shuffle(attempted_wounds))
		var/datum/wound/applied = add_wound(wound_type, silent, crit_message)
		if(applied)
			if(user?.client)
				record_round_statistic(STATS_CRITS_MADE)
			return applied
	return FALSE

/obj/item/bodypart/chest/twilight_gunpowder_crit(bclass, mob/living/user, zone_precise, silent = FALSE, crit_message = FALSE)
	if(!bclass || (owner.status_flags & GODMODE))
		return FALSE
	var/list/attempted_wounds = list()
	var/resistance = HAS_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE)
	var/crit_chance = rand(1, 100)
	if(user)
		if(user.goodluck(2))
			crit_chance += 10
	if((NOBLOOD in owner.dna?.species?.species_traits) && (zone_precise != BODY_ZONE_PRECISE_STOMACH))
		attempted_wounds += /datum/wound/fracture/chest
	else
		switch(crit_chance)
			if(1 to 70)
				if(zone_precise != BODY_ZONE_PRECISE_STOMACH)
					attempted_wounds += /datum/wound/fracture/chest
				else
					attempted_wounds += /datum/wound/scarring
			if(70 to INFINITY)
				if((zone_precise == BODY_ZONE_PRECISE_STOMACH) && !resistance)
					attempted_wounds += /datum/wound/slash/disembowel
				if(owner.has_wound(/datum/wound/fracture/chest) || (bclass in GLOB.artery_heart_bclasses) || HAS_TRAIT(owner, TRAIT_CRITICAL_WEAKNESS))
					attempted_wounds += /datum/wound/artery/chest
				else
					attempted_wounds += /datum/wound/artery

	for(var/wound_type in shuffle(attempted_wounds))
		var/datum/wound/applied = add_wound(wound_type, silent, crit_message)
		if(applied)
			if(user?.client)
				record_round_statistic(STATS_CRITS_MADE)
			return applied
	return FALSE

/obj/item/bodypart/head/twilight_gunpowder_crit(bclass, mob/living/user, zone_precise, silent = FALSE, crit_message = FALSE)
	var/static/list/eyestab_zones = list(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE)
	var/static/list/tonguestab_zones = list(BODY_ZONE_PRECISE_MOUTH)
	var/static/list/nosestab_zones = list(BODY_ZONE_PRECISE_NOSE)
	var/static/list/earstab_zones = list(BODY_ZONE_PRECISE_EARS)
	var/list/attempted_wounds = list()
	var/resistance = HAS_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE)
	if(NOBLOOD in owner.dna?.species?.species_traits)
		var/fracture_type = /datum/wound/fracture
		if(HAS_TRAIT(owner, TRAIT_CRITICAL_WEAKNESS) || has_wound(/datum/wound/fracture))
			fracture_type = /datum/wound/fracture/head
		else if(zone_precise == BODY_ZONE_PRECISE_EARS)
			fracture_type = /datum/wound/fracture/head/ears
		else if(zone_precise == BODY_ZONE_PRECISE_NOSE)
			fracture_type = /datum/wound/fracture/head/nose
		else if(zone_precise == BODY_ZONE_PRECISE_MOUTH)
			fracture_type = /datum/wound/fracture/mouth
		attempted_wounds += fracture_type
	else
		var/artery_type = /datum/wound/artery
		if(zone_precise == BODY_ZONE_PRECISE_NECK)
			artery_type = /datum/wound/artery/neck
		attempted_wounds += artery_type
		if(!resistance)
			if(zone_precise in earstab_zones)
				var/obj/item/organ/ears/my_ears = owner.getorganslot(ORGAN_SLOT_EARS)
				if(my_ears)
					attempted_wounds += /datum/wound/facial/ears
			else if(zone_precise in eyestab_zones)
				var/obj/item/organ/my_eyes = owner.getorganslot(ORGAN_SLOT_EYES)
				if(my_eyes)
					if(zone_precise == BODY_ZONE_PRECISE_R_EYE)
						attempted_wounds += /datum/wound/facial/eyes/right
					else if(zone_precise == BODY_ZONE_PRECISE_L_EYE)
						attempted_wounds += /datum/wound/facial/eyes/left
			else if(zone_precise in tonguestab_zones)
				var/obj/item/organ/tongue/tongue_up_my_asshole = owner.getorganslot(ORGAN_SLOT_TONGUE)		//..hello?
				if(tongue_up_my_asshole)
					attempted_wounds += /datum/wound/facial/tongue
			else if(zone_precise in nosestab_zones)
				attempted_wounds += /datum/wound/facial/disfigurement/nose

	for(var/wound_type in shuffle(attempted_wounds))
		var/datum/wound/applied = add_wound(wound_type, silent, crit_message)
		if(applied)
			if(user?.client)
				record_round_statistic(STATS_CRITS_MADE)
			return applied
	return FALSE
