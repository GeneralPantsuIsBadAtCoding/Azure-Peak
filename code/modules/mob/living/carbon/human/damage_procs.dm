

/mob/living/carbon/human/apply_damage(damage = 0,damagetype = BRUTE, def_zone = null, blocked = FALSE, forced = FALSE, spread_damage = FALSE)
	// depending on the species, it will run the corresponding apply_damage code there
	if(buckled) 			// If we're a person on a mount who got hit while sprinting, we get thrown off
		if(istype(buckled, /mob/living/simple_animal/hostile/retaliate/rogue/saiga))
			if(ishuman(src))
				var/mob/living/carbon/human/H = src
				if(H.m_intent == MOVE_INTENT_RUN)
					var/mob/living/simple_animal/M = buckled
					M.violent_dismount(H)
	if(dna)
		return dna.species.apply_damage(damage, damagetype, def_zone, blocked, src, forced, spread_damage)
