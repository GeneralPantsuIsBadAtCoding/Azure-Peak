/datum/wound/puncture
	name = "puncture"
	whp = 40
	sewn_whp = 20
	bleed_rate = 0.4
	sewn_bleed_rate = 0.04
	clotting_rate = 0.01
	sewn_clotting_rate = 0.01
	clotting_threshold = 0.2
	sewn_clotting_threshold = 0.1
	sew_threshold = 75
	mob_overlay = "cut"
	can_sew = TRUE
	can_cauterize = TRUE

/datum/wound/puncture/small
	name = "small puncture"
	whp = 20
	sewn_whp = 10
	bleed_rate = 0.2
	sewn_bleed_rate = 0.02
	clotting_rate = 0.01
	sewn_clotting_rate = 0.01
	clotting_threshold = 0.1
	sewn_clotting_threshold = 0.1
	sew_threshold = 35

/datum/wound/puncture/large
	name = "gaping puncture"
	whp = 40
	sewn_whp = 20
	bleed_rate = 1
	sewn_bleed_rate = 0.1
	clotting_rate = 0.01
	sewn_clotting_rate = 0.01
	clotting_threshold = 0.5
	sewn_clotting_threshold = 0.25
	sew_threshold = 100

/datum/wound/dynamic/puncture
	name = "puncture"
	whp = 1
	sewn_whp = 0
	bleed_rate = 1
	sewn_bleed_rate = 0.04
	clotting_rate = 0.01
	sewn_clotting_rate = 0.01
	clotting_threshold = 0.2
	sewn_clotting_threshold = 0.1
	sew_threshold = 20
	mob_overlay = "cut"
	can_sew = TRUE
	can_cauterize = TRUE
	severity_names = list(
		"shallow" = 20,
		"deep" = 40,
		"gnarly" = 80,
		"vicious" = 120,
		"lethal" = 200,
	)

//Puncture (Stab -- not Pick) Omniwounds
//Vaguely: Not nearly as painful, higher bleed cap, easier to sew / heal. Not clamped at all.

#define PUNC_UPG_BLEEDRATE 0.25
#define PUNC_UPG_WHPRATE 0.5
#define PUNC_UPG_SEWRATE 0.35
#define PUNC_UPG_PAINRATE 0.2
#define PUNC_UPG_CLAMP_ARMORED 15
#define PUNC_UPG_CLAMP_RAW 20
#define PUNC_ARMORED_BLEED_CLAMP 15

/datum/wound/dynamic/puncture/upgrade(dam, armor)
	whp += (dam * PUNC_UPG_WHPRATE)
	bleed_rate += clamp((dam * PUNC_UPG_BLEEDRATE), 0.1, ((armor > 0) ? PUNC_UPG_CLAMP_ARMORED : PUNC_UPG_CLAMP_RAW))
	sew_threshold += (dam * PUNC_UPG_SEWRATE)
	woundpain += (dam * PUNC_UPG_PAINRATE)
	armor_check(armor, PUNC_ARMORED_BLEED_CLAMP)
	update_name()
	..()

#undef PUNC_UPG_BLEEDRATE
#undef PUNC_UPG_WHPRATE
#undef PUNC_UPG_SEWRATE
#undef PUNC_UPG_PAINRATE
#undef PUNC_UPG_CLAMP_ARMORED
#undef PUNC_UPG_CLAMP_RAW
#undef PUNC_ARMORED_BLEED_CLAMP

/datum/wound/dynamic/puncture
	name = "gouge"
	whp = 1
	sewn_whp = 0
	bleed_rate = 1
	sewn_bleed_rate = 0.04
	clotting_rate = 0.01
	sewn_clotting_rate = 0.01
	clotting_threshold = 0.2
	sewn_clotting_threshold = 0.1
	sew_threshold = 20
	mob_overlay = "cut"
	can_sew = TRUE
	can_cauterize = FALSE
	severity_names = list(
		"shallow" = 20,
		"deep" = 40,
		"gnarly" = 80,
		"vicious" = 120,
		"lethal" = 200,
	)

//Gouge (Pick) Omniwounds
//Vaguely: Not very painful, not very bleedy, no difference if it's armored or not, but you can't cauterize them. You're still better off using stab every time.
//Addendum: This was made with the assumption that pick intent penetrates most armors (and being able to crit through them).

#define GOUGE_UPG_BLEEDRATE 0.03
#define GOUGE_UPG_WHPRATE 0.25
#define GOUGE_UPG_SEWRATE 0.1
#define GOUGE_UPG_PAINRATE 0.01
#define GOUGE_UPG_CLAMP_ARMORED 1
#define GOUGE_UPG_CLAMP_RAW 2
#define GOUGE_ARMORED_BLEED_CLAMP 5

/datum/wound/dynamic/gouge/upgrade(dam, armor)
	whp += (dam * GOUGE_UPG_WHPRATE)
	bleed_rate += clamp((dam * GOUGE_UPG_BLEEDRATE), 0.1, ((armor > 0) ? GOUGE_UPG_CLAMP_ARMORED : GOUGE_UPG_CLAMP_RAW))
	sew_threshold += (dam * GOUGE_UPG_SEWRATE)
	woundpain += (dam * GOUGE_UPG_PAINRATE)
	armor_check(armor, GOUGE_ARMORED_BLEED_CLAMP)
	update_name()
	..()

#undef GOUGE_UPG_BLEEDRATE
#undef GOUGE_UPG_WHPRATE
#undef GOUGE_UPG_SEWRATE
#undef GOUGE_UPG_PAINRATE
#undef GOUGE_UPG_CLAMP_ARMORED
#undef GOUGE_UPG_CLAMP_RAW
#undef GOUGE_ARMORED_BLEED_CLAMP

/datum/wound/puncture/drilling
	name = "drilling"
	check_name = span_bloody("<B>DRILLING</B>")
	severity = WOUND_SEVERITY_SUPERFICIAL
	whp = 40
	sewn_whp = 20
	bleed_rate = 1
	sewn_bleed_rate = 0.1
	clotting_rate = null
	clotting_threshold = null
	sew_threshold = 100
	passive_healing = 0
	sleep_healing = 0

/datum/wound/puncture/drilling/sew_wound()
	qdel(src)
	return TRUE

/datum/wound/puncture/drilling/cauterize_wound()
	qdel(src)
	return TRUE
