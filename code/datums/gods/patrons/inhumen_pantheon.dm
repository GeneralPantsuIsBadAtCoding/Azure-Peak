/datum/patron/inhumen
	name = null
	associated_faith = /datum/faith/inhumen
	undead_hater = FALSE
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	confess_lines = list(
		"PSYDON IS THE DEMIURGE!",
		"THE TEN ARE WORTHLESS COWARDS!",
		"THE TEN ARE DECEIVERS!",
	)

/datum/patron/inhumen/zizo
	name = "Zizo"
	domain = "Advancement, Hubris, Left Hand Magicks"
	desc = "Snow Elf turned God- banished by the Ten for spreading unholy magicks and forbidden sciences. Her craft taught mortals to bend the natural world to their will, but destroyed the Snow Elf race.."
	worshippers = "Necromancers, Warlocks, and the Undead"
	mob_traits = list(TRAIT_CABAL)
	t1 = /obj/effect/proc_holder/spell/invoked/projectile/profane/miracle
	t2 = /obj/effect/proc_holder/spell/invoked/raise_lesser_undead/miracle
	t3 = /obj/effect/proc_holder/spell/invoked/rituos/miracle
	confess_lines = list(
		"PRAISE ZIZO!",
		"LONG LIVE ZIZO!",
		"ZIZO IS QUEEN!",
	)

/datum/patron/inhumen/graggar
	name = "Graggar"
	domain = "God of Conquest, War, Murder, Pillaging"
	desc = "Orc turned deity, said by the Holy Ecclesial to have been blessed by Ravox himself. He took his blessings to rampage and tear down the Old Ten. Though some Graggarites might care for 'honor', most do not- what matters are results, and victory at any cost."
	worshippers = "Prisoners, Murderers and the Cruel"
	mob_traits = list(TRAIT_HORDE, TRAIT_ORGAN_EATER)
	t1 = /obj/effect/proc_holder/spell/self/call_to_slaughter
	t2 = /obj/effect/proc_holder/spell/invoked/projectile/blood_net
	t3 = /obj/effect/proc_holder/spell/invoked/revel_in_slaughter
	confess_lines = list(
		"GRAGGAR IS THE BEAST I WORSHIP!",
		"THROUGH VIOLENCE, DIVINITY!",
		"THE GOD OF CONQUEST DEMANDS BLOOD!",
	)

/datum/patron/inhumen/matthios
	name = "Matthios"
	domain = "God of Robbery, Redistribution of Wealth, and Commerce"
	desc = "The Man who stole fire from the Underworld and gave it in exchange for worship; the first Transaction, cutting a hole in the firmament and flooding ontological reality with the fact of Wealth. Take from the wealthy, give to the worthless, empower."
	worshippers = "Highwaymen, Robbers, Downtrodden Peasants, Merchants"
	mob_traits = list(TRAIT_COMMIE, TRAIT_MATTHIOS_EYES)
	t0 = /obj/effect/proc_holder/spell/invoked/appraise
	t1 = /obj/effect/proc_holder/spell/invoked/transact
	t2 = /obj/effect/proc_holder/spell/invoked/equalize
	t3 = /obj/effect/proc_holder/spell/invoked/churnwealthy
	confess_lines = list(
		"MATTHIOS STEALS FROM THE WORTHLESS!",
		"MATTHIOS IS JUSTICE!",
		"MATTHIOS IS MY LORD!",
	)

/datum/patron/inhumen/baotha
	name = "Baotha"
	domain = "Goddess of Degeneracy, Debauchery and Addiction"
	desc = "Eora's crueler half, made be from her one true love having been unfaithful. Filled with bitterness, she separated from Eora in spirit and spiraled into a dark hole of crippling hedonism. She teaches her ilk to place their trust in no one, and do only as they please."
	worshippers = "Perverts, Gamblers, Drunkards, and Bards"
	mob_traits = list(TRAIT_DEPRAVED, TRAIT_CRACKHEAD)
	t1 = /obj/effect/proc_holder/spell/invoked/baothablessings
	t2 = /obj/effect/proc_holder/spell/invoked/projectile/blowingdust
	t3 = /obj/effect/proc_holder/spell/invoked/painkiller
	confess_lines = list(
		"BAOTHA DEMANDS PLEASURE!",
		"LIVE, LAUGH, LOVE!",
		"BAOTHA IS MY JOY!",
	)
