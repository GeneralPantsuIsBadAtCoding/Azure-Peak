/datum/patron/divine
	name = null
	associated_faith = /datum/faith/divine
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/divine/astrata
	name = "Astrata"
	domain = "Twinned Goddess of the Sun, Day, and Order"
	desc = "The she-form of the Twinned Gods, the combined amalgam of single-bodied Astrata and Noc that opens her eyes at glorious Dae. Men bask under the gift of the Sun. A single form begets two Gods that shift at Dusk and Dawn but always endures, even at night."
	worshippers = "The Noble Hearted, Zealots and Farmers"
	mob_traits = list(TRAIT_APRICITY)
	t1 = /obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
	t2 = /obj/effect/proc_holder/spell/invoked/heal
	t3 = /obj/effect/proc_holder/spell/invoked/revive
	t4 = /obj/effect/proc_holder/spell/invoked/smite
	confess_lines = list(
		"ASTRATA IS MY LIGHT!",
		"ASTRATA BRINGS LAW!",
		"I SERVE THE GLORY OF THE SUN!",
	)

/datum/patron/divine/noc
	name = "Noc"
	domain = "Twinned God of the Moon, Night, and Knowledge"
	desc = "The he-form of the Twinned Gods, the combined amalgam of single-bodied Noc and Astrata that opens his eyes during pondorous Night. He gifted man knowledge of divinity and magicks. A single form begets two Gods that shift at Dusk and Dawn but always endures, even at dae."
	worshippers = "Wizards and Scholars"
	mob_traits = list(TRAIT_NIGHT_OWL, TRAIT_NOCSIGHT)
	t1 = /obj/effect/proc_holder/spell/invoked/blindness/miracle
	t2 = /obj/effect/proc_holder/spell/invoked/invisibility/miracle
	confess_lines = list(
		"NOC IS NIGHT!",
		"NOC SEES ALL!",
		"I SEEK THE MYSTERIES OF THE MOON!",
	)

/datum/patron/divine/dendor
	name = "Dendor"
	domain = "God of the Earth and Nature"
	desc = "The God of Wilds, born from Abyssor's feverish dreams. Spilt forth life from the oceans to land in a wild craze. The Father of Ground-Lyfe. Treefather."
	worshippers = "Druids, Beasts, Madmen"
	mob_traits = list(TRAIT_KNEESTINGER_IMMUNITY)
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop
	t2 = /obj/effect/proc_holder/spell/self/dendor_shapeshift
	t3 = /obj/effect/proc_holder/spell/targeted/conjure_glowshroom
	t4 = /obj/effect/proc_holder/spell/self/howl/call_of_the_moon
	confess_lines = list(
		"DENDOR PROVIDES!",
		"THE TREEFATHER BRINGS BOUNTY!",
		"I ANSWER THE CALL OF THE WILD!",
	)

/datum/patron/divine/abyssor
	name = "Abyssor"
	domain = "God of the Ocean, Storms and the Tide"
	desc = "The strongest of the Ten; when awakened, the world flooded for a thousand daes and a thousand nights before he was put to slumber. Resting fitfully did Dendor split from his skull like a gaping wound. Communes rarely with his followers, only offering glimpses in dreams. Gifted primordial Man water. "
	worshippers = "Men of the Sea, Primitive Aquatics"
	mob_traits = list(TRAIT_ABYSSOR_SWIM, TRAIT_SEA_DRINKER)
	t1 = /obj/effect/proc_holder/spell/invoked/abyssor_bends
	t2 = /obj/effect/proc_holder/spell/invoked/abyssheal
	t3 = /obj/effect/proc_holder/spell/invoked/call_mossback
	confess_lines = list(
		"ABYSSOR COMMANDS THE WAVES!",
		"THE OCEAN'S FURY IS ABYSSOR'S WILL!",
		"I AM DRAWN BY THE PULL OF THE TIDE!",
	)
	
/datum/patron/divine/ravox
	name = "Ravox"
	domain = "God of Justice, Glory, Battle"
	desc = "Stalwart warrior, glorious justicier; legends say he came down to the Basin to repel the vile hordes of demons with his own hands, and that he seeks warriors for his divine army among mortals."
	worshippers = "Warriors, Sellswords & those who seek Justice"
	mob_traits = list(TRAIT_SHARPER_BLADES, TRAIT_JUSTICARSIGHT)
	t1 = /obj/effect/proc_holder/spell/self/divine_strike
	t2 = /obj/effect/proc_holder/spell/self/call_to_arms
	t3 = /obj/effect/proc_holder/spell/invoked/persistence
	confess_lines = list(
		"RAVOX IS JUSTICE!",
		"THROUGH STRIFE, GRACE!",
		"THROUGH PERSISTENCE, GLORY!",
	)

/datum/patron/divine/necra
	name = "Necra"
	domain = "Goddess of Death and the Afterlife"
	desc = "Veiled Lady of the underworld, equally feared and respected by mortals. She taught mortals the inevitability of death and cares for them as they reach the afterlife."
	worshippers = "The Dead, Mourners, Gravekeepers"
	mob_traits = list(TRAIT_SOUL_EXAMINE)
	t1 = /obj/effect/proc_holder/spell/invoked/avert
	t2 = /obj/effect/proc_holder/spell/targeted/abrogation
	t3 = /obj/effect/proc_holder/spell/targeted/soulspeak
	confess_lines = list(
		"ALL SOULS FIND THEIR WAY TO NECRA!",
		"THE UNDERMAIDEN IS OUR FINAL REPOSE!",
		"I FEAR NOT DEATH, MY LADY AWAITS ME!",
	)

/datum/patron/divine/xylix
	name = "Xylix"
	domain = "God of Trickery, Freedom and Inspiration"
	desc = "The Laughing God, both famous and infamous for his sway over the forces of luck. Xylix is known for the inspiration of many a bards lyric. Speaks through his gift to man; the Tarot deck."
	worshippers = "Gamblers, Bards, Artists, and the Silver-Tongued"
	mob_traits = list(TRAIT_XYLIX)
	t1 = /obj/effect/proc_holder/spell/invoked/wheel
	t2 = /obj/effect/proc_holder/spell/invoked/mockery
	confess_lines = list(
		"ASTRATA IS MY LIGHT!",
		"NOC IS NIGHT!",
		"DENDOR PROVIDES!",
		"ABYSSOR COMMANDS THE WAVES!",
		"RAVOX IS JUSTICE!",
		"ALL SOULS FIND THEIR WAY TO NECRA!",
		"HAHAHAHA! AHAHAHA! HAHAHAHA!",
		"PESTRA SOOTHES ALL ILLS!",
		"MALUM IS MY MUSE!",
		"EORA BRINGS US TOGETHER!",
	)

/datum/patron/divine/pestra
	name = "Pestra"
	domain = "Goddess of Decay, Disease and Medicine"
	desc = "Goddess that blessed many a saint with healing hands, Pestra taught man the arts of medicine and its benefits."
	worshippers = "The Sick, Phyicians, Apothecaries"
	mob_traits = list(TRAIT_EMPATH, TRAIT_ROT_EATER)
	t0 = /obj/effect/proc_holder/spell/invoked/diagnose
	t1 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t2 = /obj/effect/proc_holder/spell/invoked/heal
	t3 = /obj/effect/proc_holder/spell/invoked/attach_bodypart
	t4 = /obj/effect/proc_holder/spell/invoked/cure_rot
	confess_lines = list(
		"PESTRA SOOTHES ALL ILLS!",
		"DECAY IS A CONTINUATION OF LIFE!",
		"MY AFFLICTION IS MY TESTAMENT!",
	)

/datum/patron/divine/malum
	name = "Malum"
	domain = "God of Fire, Destruction and Rebirth"
	desc = "Opinionless god of the crafts. He teaches that great works for killing or saving are great works, either way. The well-oiled guillotine and the well-sharpened axe are tools, and there is no good and evil to their craft."
	worshippers = "Smiths, Miners, Engineers"
	mob_traits = list(TRAIT_FORGEBLESSED)
	t1 = /obj/effect/proc_holder/spell/invoked/vigorousexchange
	t2 = /obj/effect/proc_holder/spell/invoked/heatmetal
	t3 = /obj/effect/proc_holder/spell/invoked/hammerfall
	t4 = /obj/effect/proc_holder/spell/invoked/craftercovenant
	extra_spell = /obj/effect/proc_holder/spell/invoked/malum_flame_rogue
	confess_lines = list(
		"MALUM IS MY MUSE!",
		"TRUE VALUE IS IN THE TOIL!",
		"I AM AN INSTRUMENT OF CREATION!",
	)

//Eora content from Stonekeep

/datum/patron/divine/eora
	name = "Eora"
	domain = "Goddess of Love, Life and Beauty"
	desc = "Baotha's fairer half, made from blind, unconditional love. She is without a shred of hate in her heart and taught mankind that true love that even transcends Necra's grasp."
	worshippers = "Lovers, the romantically inclined, and Doting Grandparents"
	mob_traits = list(TRAIT_EMPATH, TRAIT_GOODLOVER)
	t1 = /obj/effect/proc_holder/spell/invoked/bud
	t2 = /obj/effect/proc_holder/spell/invoked/eoracurse
	t3 = null
	confess_lines = list(
		"EORA BRINGS US TOGETHER!",
		"HER BEAUTY IS EVEN IN THIS TORMENT!",
		"I LOVE YOU, EVEN AS YOU TRESPASS AGAINST ME!",
	)
