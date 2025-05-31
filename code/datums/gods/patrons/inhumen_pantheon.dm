/datum/patron/inhumen
	name = null
	associated_faith = /datum/faith/inhumen
	undead_hater = FALSE
	confess_lines = list(
		"PSYDON IS THE DEMIURGE!",
		"THE TEN ARE WORTHLESS COWARDS!",
		"THE TEN ARE DECEIVERS!",
	)

/datum/patron/inhumen/zizo
	name = "Zizo"
	domain = "Progress, Undeath, Hubris, Left Hand Magicks"
	desc = "A once-mortal snow elf turned god. Her hubris in thinking she could harvest lux from the planet itself led to the elimination of her entire race. Her works are still used to this dae in some cases."
	worshippers = "Necromancers, Researchers, Warlocks, and the Undead"
	mob_traits = list(TRAIT_CABAL)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison					= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 					= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/projectile/profane/miracle 	= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/raise_lesser_undead/miracle 	= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/rituos/miracle 				= CLERIC_T3
	)
	confess_lines = list(
		"PRAISE ZIZO!",
		"LONG LIVE ZIZO!",
		"ZIZO IS QUEEN!",
	)
	storyteller = /datum/storyteller/zizo

/datum/patron/inhumen/graggar
	name = "Graggar"
	domain = "God of Conquest, War, Strategy, Bind-Breaking"
	desc = "Slave orc turned deity, said by the Holy Ecclesial to have been blessed by Ravox himself. He took his blessings to wage a bloody war against his once-captors, and then continued his conquest in his own name. Some Graggarites might care for honor, however many do not- what matters are results, and victory at a reasonable cost."
	worshippers = "Prisoners, Slaves, Militants, and the Cruel"
	mob_traits = list(TRAIT_HORDE, TRAIT_ORGAN_EATER)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison					= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 					= CLERIC_T0,
					/obj/effect/proc_holder/spell/self/call_to_slaughter 				= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/projectile/blood_net 			= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/revel_in_slaughter 			= CLERIC_T3,
	)
	confess_lines = list(
		"GRAGGAR IS THE BEAST I WORSHIP!",
		"THROUGH VIOLENCE, DIVINITY!",
		"THE GOD OF CONQUEST DEMANDS BLOOD!",
	)
	storyteller = /datum/storyteller/graggar

/datum/patron/inhumen/matthios
	name = "Matthios"
	domain = "God of Exchange, Alchemy, Theft, and Greed"
	desc = "The Man who stole fire from the sun and used it in his pursuit of immortality; exchanging the knowledge of how to make fire with the lessers for safety in doing so. He guides those who live in the dark, away from the flame of civilization; and those who believe in his cause bring the wealth of the undeserving in the light to the deserving in the dark."
	worshippers = "Highwaymen, Alchemists, Downtrodden Peasants, and Merchants"
	mob_traits = list(TRAIT_COMMIE, TRAIT_MATTHIOS_EYES)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison					= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 					= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/appraise						= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/transact						= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/equalize						= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/churnwealthy					= CLERIC_T3,
	)
	confess_lines = list(
		"MATTHIOS STEALS FROM THE WORTHLESS!",
		"MATTHIOS IS JUSTICE!",
		"MATTHIOS IS MY LORD!",
	)
	storyteller = /datum/storyteller/matthios

/datum/patron/inhumen/baotha
	name = "Baotha"
	domain = "Goddess of Hedonism, Addiction, Anguish, and Heartbreak"
	desc = "The twin sister of Eora, fallen to disgrace. She brings comfort to those who can't find it elsewhere but the bottom of a bottle; and she tempts those who have lost much into her fold through offers of relief and pleasure, yet they soon find themselves unable to escape her grasp. Seen as a scorned lover by many, and followed by such."
	worshippers = "Widows, Gamblers, Addicts, and Scorned Lovers"
	mob_traits = list(TRAIT_DEPRAVED, TRAIT_CRACKHEAD)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison					= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 					= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/baothablessings				= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/projectile/blowingdust		= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/painkiller					= CLERIC_T3,
	)
	confess_lines = list(
		"BAOTHA DEMANDS PLEASURE!",
		"LIVE, LAUGH, LOVE!",
		"BAOTHA IS MY JOY!",
	)
	storyteller = /datum/storyteller/baotha
