/datum/wound/bite
	name = "bite"
	bleed_rate = 0.5
	sewn_bleed_rate = 0
	clotting_threshold = null
	sewn_clotting_threshold = null
	whp = 30
	woundpain = 10
	sew_threshold = 50
	mob_overlay = "cut"
	can_sew = TRUE
	can_cauterize = TRUE
	passive_healing = 0.5

/datum/wound/bite/small
	name = "nip"
	whp = 15

/datum/wound/bite/large
	name = "gnarly bite"
	whp = 40
	sewn_whp = 15
	bleed_rate = 1
	sewn_bleed_rate = 0.2
	clotting_rate = 0.01
	sewn_clotting_rate = 0.01
	clotting_threshold = 0.5
	sewn_clotting_threshold = 0.25
	woundpain = 15
	sewn_woundpain = 5
	can_sew = TRUE
	can_cauterize = TRUE
	passive_healing = 0

/datum/wound/dynamic/bite
	name = "bite"
	bleed_rate = 0.5
	sewn_bleed_rate = 0
	clotting_threshold = null
	sewn_clotting_threshold = null
	whp = 30
	woundpain = 10
	sew_threshold = 50
	mob_overlay = "cut"


	can_sew = TRUE
	can_cauterize = TRUE
	passive_healing = 0.5
	severity_names = list(
		"shallow" = 20,
		"deep" = 40,
		"gnarly" = 80,
		"lethal" = 120,
		"impossible" = 200,
	)

#define BITE_UPG_BLEEDRATE 0.35
#define BITE_UPG_WHPRATE 0.05
#define BITE_UPG_SEWRATE 0.1
#define BITE_UPG_PAINRATE 0.5

/datum/wound/dynamic/bite/upgrade(dam)
	whp += (dam * BITE_UPG_WHPRATE)
	bleed_rate += (dam * BITE_UPG_BLEEDRATE)
	sew_threshold += (dam * BITE_UPG_SEWRATE)
	woundpain += (dam * BITE_UPG_PAINRATE)
	update_name()
	..()

#undef BITE_UPG_BLEEDRATE
#undef BITE_UPG_WHPRATE
#undef BITE_UPG_SEWRATE
#undef BITE_UPG_PAINRATE

/datum/wound/bite/dynamic/sew_wound()
	heal_wound(whp)
