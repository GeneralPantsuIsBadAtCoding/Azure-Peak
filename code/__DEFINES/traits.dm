// ROGUETRAITS (description when rmb skills button)
#define TRAIT_WEBWALK "Webwalker"
#define TRAIT_NOSTINK "Dead Nose"
#define TRAIT_ZJUMP "High Jumping"
#define TRAIT_JESTERPHOBIA "Jesterphobic"
#define TRAIT_XENOPHOBIC "Xenophobic"
#define TRAIT_TOLERANT "Tolerant"
#define TRAIT_LEAPER "Leaper"
#define TRAIT_NOSEGRAB "Nosey"
#define TRAIT_NUTCRACKER "Nutcracker"
#define TRAIT_SEEPRICES "Skilled Appraiser"
#define TRAIT_SEEPRICES_SHITTY "Appraiser"
#define TRAIT_STRONGBITE "Strong Bite"
#define TRAIT_NOBLE "Noble Blooded"
#define TRAIT_EMPATH "Empath"
#define TRAIT_BREADY "Battleready"
#define TRAIT_MEDIUMARMOR "Maille Training"
#define TRAIT_HEAVYARMOR "Plate Training"
#define TRAIT_DODGEEXPERT "Fast Reflexes"
#define TRAIT_DECEIVING_MEEKNESS "Deceiving Meekness"
#define TRAIT_CRITICAL_RESISTANCE "Critical Resistance"
#define TRAIT_CRITICAL_WEAKNESS "Critical Weakness"
#define TRAIT_MANIAC_AWOKEN "Awoken"
#define TRAIT_NOROGSTAM "Indefatigable" //for ai
#define TRAIT_NUDIST "Nudist" //you can't wear most clothes
#define TRAIT_CYCLOPS_LEFT "Cyclops (Left)" //poked left eye
#define TRAIT_CYCLOPS_RIGHT "Cyclops (Right)" //poked right eye
#define TRAIT_INHUMEN_ANATOMY "Inhumen Anatomy" //can't wear hats and shoes
#define TRAIT_NASTY_EATER "Inhumen Digestion" //can eat rotten food, organs, poison berries, and drink murky water
#define TRAIT_WILD_EATER "Beastly Digestion" //can eat raw and rotten food and drink murky water
#define TRAIT_NOFALLDAMAGE1 "Minor fall damage immunity"
#define TRAIT_NOFALLDAMAGE2 "Total fall damage immunity"
#define TRAIT_MISSING_NOSE "Missing Nose" //halved stamina regeneration
#define TRAIT_DISFIGURED "Disfigured"
#define TRAIT_SPELLCOCKBLOCK "Bewitched" //prevents spellcasting
#define TRAIT_ANTIMAGIC	"Anti-Magic"
#define TRAIT_ANTISCRYING "Non-Detection"
#define TRAIT_SHOCKIMMUNE "Shock Immunity"
#define TRAIT_NOSLEEP "Fatal Insomnia"
#define TRAIT_FASTSLEEP "Fast Sleeper"
#define TRAIT_GOODLOVER "Fabled Lover"
#define TRAIT_SEEDKNOW "Seed Knower"
#define TRAIT_SQUIRE_REPAIR "Squire Knowledge"
#define TRAIT_TRAINED_SMITH "Trained Smith"

//Hearthstone port (Tracking)
#define TRAIT_PERFECT_TRACKER "Perfect Tracker" //Will always find any tracks and analyzes them perfectly.
#define TRAIT_NOCSIGHT "Blessing of Noc" // I can see just a bit more clearly in darkness.
#define TRAIT_DEATHSIGHT "Veiled Whispers" // Is notified when a player character dies, but not told exactly where or how.
//Hearthstone/Azure end.

// ROGUEspecialTRAITS (description when rmb skills button)
#define TRAIT_CIVILIZEDBARBARIAN "Tavern Brawler"
#define TRAIT_COMICSANS "Annoying Face"
#define TRAIT_WATERBREATHING "Water Breathing"

// PATRON GOD TRAITS
#define TRAIT_ROT_EATER "Blessing of Pestra" //can eat rotten food
#define TRAIT_ORGAN_EATER "Blessing of Graggar" //can eat organs
#define TRAIT_KNEESTINGER_IMMUNITY "Blessing of Dendor"
#define TRAIT_SOUL_EXAMINE "Blessing of Necra" //can check bodies to see if they have departed
#define TRAIT_CRACKHEAD "Blessing of Baotha" //will never overdose
#define TRAIT_CHOSEN "Astrata's Chosen"
#define TRAIT_ABYSSOR_SWIM "Blessing of Abyssor" //less base fatigue drain when swimming
#define TRAIT_XYLIX "Blessing of Xylix" //secret thieves cant language

// ASCENDANT CULTIST TRAITS (all of them recognize each other)
#define TRAIT_COMMIE "Blessing of Matthios" //recognized by bandits as an ally
#define TRAIT_CABAL "Of the Cabal" //Zizo cultists recognize each other too
#define TRAIT_HORDE "Anointed" //Graggarites also recognize each other
#define TRAIT_DEPRAVED "Fallen" //Baothans also recognize each other

#define TRAIT_BASHDOORS "bashdoors"
#define TRAIT_NOMOOD "no_mood"
#define TRAIT_BAD_MOOD "Bad Mood"
#define TRAIT_NIGHT_OWL "Night Owl"
#define TRAIT_BEAUTIFUL "Beautiful"
#define TRAIT_SIMPLE_WOUNDS "simple_wounds"
#define TRAIT_BANDITCAMP "banditcamp"
#define TRAIT_VAMPMANSION "vampiremansion"
#define TRAIT_VAMP_DREAMS "vamp_dreams"
#define TRAIT_LIMPDICK "limp_dick"
#define TRAIT_SEXPASS "sexpass"
#define TRAIT_STEELHEARTED "steelhearted" //no bad mood from dismembering or seeing this
#define TRAIT_IWASREVIVED "iwasrevived" //prevents PQ gain from reviving the same person twice
#define TRAIT_IWASUNZOMBIFIED "iwasunzombified" //prevents PQ gain from curing a zombie twice
#define TRAIT_IWASHAUNTED "iwashaunted" //prevents spawning a haunt from a decapitated body twice
#define TRAIT_SCHIZO_AMBIENCE "schizo_ambience" //replaces all ambience with creepy shit
#define TRAIT_SCREENSHAKE "screenshake" //screen will always be shaking, you cannot stop it
#define TRAIT_NORUN "Decayed Flesh"
#define TRAIT_PUNISHMENT_CURSE "PunishmentCurse"
#define TRAIT_LEPROSY "Leprosy"
#define TRAIT_NUDE_SLEEPER "Nude Sleeper"

GLOBAL_LIST_INIT(roguetraits, list(
	TRAIT_LEPROSY = span_necrosis("I'm a disgusting leper..."),
	TRAIT_CHOSEN = "Astrata choose you to represent her glory.",
	TRAIT_WEBWALK = "I can move freely between webs.",
	TRAIT_NOSTINK = span_dead("My nose is numb to the smell of decay."),
	TRAIT_ZJUMP = "Time to reach a new high.",
	TRAIT_JESTERPHOBIA = span_warning("I have a severe irrational fear of Jesters"),
	TRAIT_XENOPHOBIC = span_warning("Lesser races pollute our land"),
	TRAIT_TOLERANT = span_info("I dream of an ideal future, one with peace between all races"),
	TRAIT_NIGHT_OWL = span_info("I enjoy spending my time in the night"),
	TRAIT_BEAUTIFUL = span_info("People love looking at my face"),
	TRAIT_BAD_MOOD = span_warning("Everything just seems to piss me off"),
	TRAIT_LEAPER = "I can leap like a frog.",
	TRAIT_NOSEGRAB = "I love to grab idiots by their noses!",
	TRAIT_NUTCRACKER = "I love kicking idiots on the nuts!",
	TRAIT_SEEPRICES = "I can tell the prices of things down to the zenny.",
	TRAIT_SEEPRICES_SHITTY = "I can tell the prices of things... <i>Kind of</i>.",
	TRAIT_STRONGBITE = "Stronger bites, critical bite attacks.",
	TRAIT_NOBLE = span_blue("I'm of noble blood."),
	TRAIT_EMPATH = "I can notice when people are in pain.",
	TRAIT_BREADY = "Defensive stance does not passively fatigue me.",
	TRAIT_MEDIUMARMOR = "I can move freely in medium armor.",
	TRAIT_HEAVYARMOR = "I can move freely in heavy armor.",
	TRAIT_DODGEEXPERT = "I can dodge easily while only wearing light armor.",
	TRAIT_DECEIVING_MEEKNESS = "People look at me and think I am a weakling. They are mistaken.",
	TRAIT_CRITICAL_RESISTANCE = "I am resistant to wounds that would be life threatening to others.",
	TRAIT_CRITICAL_WEAKNESS = span_danger("I am weak to wounds that others could survive."),
	TRAIT_MANIAC_AWOKEN = span_danger("I am <b>WAKING UP</b> and the sheeple know this. They will resist."),
	TRAIT_NOROGSTAM = "I have boundless energy, I will never tire.",
	TRAIT_NUDIST = "I <b>refuse</b> to wear clothes. They are a hindrance to my freedom.",
	TRAIT_CYCLOPS_LEFT = span_warning("My left eye has been poked out..."),
	TRAIT_CYCLOPS_RIGHT = span_warning("My right eye has been poked out..."),
	TRAIT_INHUMEN_ANATOMY = "My anatomy is inhumen, preventing me from wearing hats and shoes.",
	TRAIT_NASTY_EATER = span_dead("I can eat bad food, and water that would be toxic to humen will not affect me."),
	TRAIT_WILD_EATER = span_info("I can eat raw food and drink from dirty water."),
	TRAIT_NOFALLDAMAGE1 = span_warning("I can easily handle minor falls."),
	TRAIT_NOFALLDAMAGE2 = span_warning("I can handle a fall from any height."),
	TRAIT_DISFIGURED = span_warning("No one can recognize me..."),
	TRAIT_MISSING_NOSE = span_warning("I struggle to breathe."),
	TRAIT_SPELLCOCKBLOCK = span_warning("I cannot cast any spells."),
	TRAIT_ANTIMAGIC = "I am immune to most forms of magic.",
	TRAIT_ANTISCRYING = "I am immune to most forms of magical divination.",
	TRAIT_SHOCKIMMUNE = "I am immune to electrical shocks.",
	TRAIT_NOSLEEP = span_warning("I can't sleep."),
	TRAIT_ROT_EATER = span_necrosis("I can eat rotten food."),
	TRAIT_ORGAN_EATER = span_bloody("I can eat organs and raw flesh."),
	TRAIT_KNEESTINGER_IMMUNITY = "I am immune to the shock of kneestingers.",
	TRAIT_SOUL_EXAMINE = span_deadsay("I know when someone's soul has departed."),
	TRAIT_CRACKHEAD = span_love("I can use drugs as much as I want!"),
	TRAIT_COMMIE = span_bloody("I can recognize other free men, and they can recognize me too."),
	TRAIT_NORUN = span_warning("My body has atrophied in my state of decay; my leg joints just don't have the strength or durability for running anymore"),
	TRAIT_GOODLOVER = span_love("It's a lucky thing to share my bed."),
	TRAIT_SEEDKNOW = span_info("I know which seeds grow which crops."),
	TRAIT_PERFECT_TRACKER = span_info("I am the perfect tracker. No tracks will deceive my eyes, nor will they hide their secrets from me."),//Hearthstone port.
	TRAIT_NOCSIGHT = span_info("Noc blesses my eyes to be unburdened by the night."), //Hearthstone change.
	TRAIT_CIVILIZEDBARBARIAN = span_info("Your fists are heavier."),
	TRAIT_COMICSANS = span_sans("I am cursed with a odd voice."),
	TRAIT_SQUIRE_REPAIR = span_info("I know my way around my Master's tools."),
	TRAIT_WATERBREATHING = span_info("I do not drown in bodies of water."),
	TRAIT_NUDE_SLEEPER = span_warning("I can't fall asleep unless I'm nude and in bed."),
	TRAIT_ABYSSOR_SWIM = "I get far less tired when swimming than my peers.",
	TRAIT_LONGSTRIDER = "Each of my steps finds it's footing no matter how treacherous the terrain is.",
	TRAIT_TRAINED_SMITH = span_info("I've spent long training, and with some more, I will be able to smith legendary items."),
	TRAIT_DEATHSIGHT = span_info("I can feel when someone nearby draws the Undermaiden's attention."),
	TRAIT_XYLIX = span_info("I know how to speak in code that only fellow tricksters can understand."),
	TRAIT_CABAL = span_info("In secret, I have studied the ways of Her ascension, and know of others of the Cabal."),
	TRAIT_HORDE = span_info("BY BLOOD AND BONE, I AM OF GRAGGAR'S ANOINTED! I FEEL THE STRENGTH IN OTHERS WHO ARE THE SAME."),
	TRAIT_DEPRAVED = span_info("The languid scent of Her debauchery is known to me, and I can detect its sordid presence upon others.")
))

// trait accessor defines
#define ADD_TRAIT(target, trait, source) \
	do { \
		var/list/_L; \
		if (!target.status_traits) { \
			target.status_traits = list(); \
			_L = target.status_traits; \
			_L[trait] = list(source); \
		} else { \
			_L = target.status_traits; \
			if (_L[trait]) { \
				_L[trait] |= list(source); \
			} else { \
				_L[trait] = list(source); \
			} \
		} \
	} while (0)
#define REMOVE_TRAIT(target, trait, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S; \
		if (sources && !islist(sources)) { \
			_S = list(sources); \
		} else { \
			_S = sources\
		}; \
		if (_L && _L[trait]) { \
			for (var/_T in _L[trait]) { \
				if ((!_S && (_T != ROUNDSTART_TRAIT)) || (_T in _S)) { \
					_L[trait] -= _T \
				} \
			};\
			if (!length(_L[trait])) { \
				_L -= trait \
			}; \
			if (!length(_L)) { \
				target.status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAITS_NOT_IN(target, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S = sources; \
		if (_L) { \
			for (var/_T in _L) { \
				_L[_T] &= _S;\
				if (!length(_L[_T])) { \
					_L -= _T } \
				};\
				if (!length(_L)) { \
					target.status_traits = null\
				};\
		}\
	} while (0)
#define HAS_TRAIT(target, trait) (target.status_traits ? (target.status_traits[trait] ? TRUE : FALSE) : FALSE)
#define HAS_TRAIT_FROM(target, trait, source) (target.status_traits ? (target.status_traits[trait] ? (source in target.status_traits[trait]) : FALSE) : FALSE)

/*
Remember to update _globalvars/traits.dm if you're adding/removing/renaming traits.
*/

//mob traits
#define TRAIT_BLIND 			"blind"
#define TRAIT_MUTE				"mute"
#define TRAIT_ZOMBIE_SPEECH 	"zombie_speech"
#define TRAIT_GARGLE_SPEECH		"gargle_speech"
#define TRAIT_EMOTEMUTE			"emotemute"
#define TRAIT_DEAF				"deaf"
#define TRAIT_NEARSIGHT			"nearsighted"
#define TRAIT_FAT				"fat"
#define TRAIT_HUSK				"husk"
#define TRAIT_BADDNA			"baddna"
#define TRAIT_CLUMSY			"clumsy"
#define TRAIT_CHUNKYFINGERS		"chunkyfingers" //means that you can't use weapons with normal trigger guards.
#define TRAIT_DUMB				"dumb"
#define TRAIT_MONKEYLIKE		"monkeylike" //sets IsAdvancedToolUser to FALSE
#define TRAIT_PACIFISM			"pacifism"
#define TRAIT_IGNORESLOWDOWN	"ignoreslow"
#define TRAIT_IGNOREDAMAGESLOWDOWN "ignoredamageslowdown"
#define TRAIT_DEATHCOMA			"deathcoma" //Causes death-like unconsciousness
#define TRAIT_FAKEDEATH			"fakedeath" //Makes the owner appear as dead to most forms of medical examination
#define TRAIT_XENO_HOST			"xeno_host"	//Tracks whether we're gonna be a baby alien's mummy.
#define TRAIT_STUNIMMUNE		"stun_immunity"
#define TRAIT_STUNRESISTANCE    "stun_resistance"
#define TRAIT_SLEEPIMMUNE		"sleep_immunity"
#define TRAIT_PUSHIMMUNE		"push_immunity"
#define TRAIT_STABLEHEART		"stable_heart"
#define TRAIT_STABLELIVER		"stable_liver"
#define TRAIT_NOPAINSTUN		"no_pain-stun"
#define TRAIT_RESISTHEAT		"resist_heat"
#define TRAIT_RESISTHEATHANDS	"resist_heat_handsonly" //For when you want to be able to touch hot things, but still want fire to be an issue.
#define TRAIT_RESISTCOLD		"resist_cold"
#define TRAIT_RESISTHIGHPRESSURE	"resist_high_pressure"
#define TRAIT_RESISTLOWPRESSURE	"resist_low_pressure"
#define TRAIT_RADIMMUNE			"rad_immunity"
#define TRAIT_VIRUSIMMUNE		"virus_immunity"
#define TRAIT_PIERCEIMMUNE		"pierce_immunity"
#define TRAIT_NODISMEMBER		"dismember_immunity"
#define TRAIT_NOFIRE			"nonflammable"
#define TRAIT_NOGUNS			"no_guns"
#define TRAIT_NOHUNGER			"no_hunger"
#define TRAIT_NOMETABOLISM		"no_metabolism"
#define TRAIT_TOXIMMUNE			"toxin_immune"
#define TRAIT_HARDDISMEMBER		"hard_dismember"
#define TRAIT_EASYDISMEMBER		"easy_dismember"
#define TRAIT_LIMBATTACHMENT 	"limb_attach"
#define TRAIT_NOLIMBDISABLE		"no_limb_disable"
#define TRAIT_EASYLIMBDISABLE	"easy_limb_disable"
#define TRAIT_TOXINLOVER		"toxinlover"
#define TRAIT_NOBREATH			"no_breath"
#define TRAIT_HOLDBREATH		"hold_breath"
#define TRAIT_HOLY				"holy"
#define TRAIT_DEPRESSION		"depression"
#define TRAIT_JOLLY				"jolly"
#define TRAIT_NOCRITDAMAGE		"no_crit"
#define TRAIT_NOSLIPWATER		"noslip_water"
#define TRAIT_NOSLIPALL			"noslip_all"
#define TRAIT_NODEATH			"nodeath"
#define TRAIT_NOHARDCRIT		"nohardcrit"
#define TRAIT_NOSOFTCRIT		"nosoftcrit"
#define TRAIT_MINDSHIELD		"mindshield"
#define TRAIT_DISSECTED			"dissected"
#define TRAIT_SIXTHSENSE		"sixth_sense" //I can hear dead people
#define TRAIT_FEARLESS			"fearless"
#define TRAIT_PARALYSIS_L_ARM	"para-l-arm" //These are used for brain-based paralysis, where replacing the limb won't fix it
#define TRAIT_PARALYSIS_R_ARM	"para-r-arm"
#define TRAIT_PARALYSIS_L_LEG	"para-l-leg"
#define TRAIT_PARALYSIS_R_LEG	"para-r-leg"
#define TRAIT_CANNOT_OPEN_PRESENTS "cannot-open-presents"
#define TRAIT_PRESENT_VISION    "present-vision"
#define TRAIT_DISK_VERIFIER     "disk-verifier"
#define TRAIT_NOMOBSWAP         "no-mob-swap"
#define TRAIT_XRAY_VISION       "xray_vision"
#define TRAIT_THERMAL_VISION    "thermal_vision"
#define TRAIT_ABDUCTOR_TRAINING "abductor-training"
#define TRAIT_ABDUCTOR_SCIENTIST_TRAINING "abductor-scientist-training"
#define TRAIT_SURGEON           "surgeon"
#define TRAIT_STRONG_GRABBER	"strong_grabber"
#define TRAIT_MAGIC_CHOKE		"magic_choke"
#define TRAIT_SOOTHED_THROAT    "soothed-throat"
#define TRAIT_LAW_ENFORCEMENT_METABOLISM "law-enforcement-metabolism"
#define TRAIT_ALWAYS_CLEAN      "always-clean"
#define TRAIT_BOOZE_SLIDER      "booze-slider"
#define TRAIT_QUICK_CARRY		"quick-carry"
#define TRAIT_QUICKER_CARRY		"quicker-carry"
#define TRAIT_UNINTELLIGIBLE_SPEECH "unintelligible-speech"
#define TRAIT_LANGUAGE_BARRIER	"language-barrier"
#define TRAIT_UNSTABLE			"unstable"
#define TRAIT_OIL_FRIED			"oil_fried"
#define TRAIT_MEDICAL_HUD		"med_hud"
#define TRAIT_SECURITY_HUD		"sec_hud"
#define TRAIT_MEDIBOTCOMINGTHROUGH "medbot" //Is a medbot healing you
#define TRAIT_PASSTABLE			"passtable"
#define TRAIT_NOFLASH			"noflash" //Makes you immune to flashes
#define TRAIT_XENO_IMMUNE		"xeno_immune"//prevents xeno huggies implanting skeletons
#define TRAIT_NOPAIN			"no_pain"
#define TRAIT_DRUQK				"druqk"
#define TRAIT_BURIED_COIN_GIVEN "buried_coin_given" // prevents a human corpse from being used for a corpse multiple times
#define TRAIT_BLOODLOSS_IMMUNE "bloodloss_immune" // can bleed, but will never die from blood loss
#define TRAIT_ROTMAN "rotman" //you are a rotman and need occasional maintenance
#define TRAIT_ZOMBIE_IMMUNE "zombie_immune" //immune to zombie infection
#define TRAIT_NO_BITE "no_bite" //prevents biting

//bodypart traits
#define TRAIT_PARALYSIS	"paralysis" //Used for limb-based paralysis and full body paralysis
#define TRAIT_BRITTLE "brittle" //The limb is more susceptible to fractures
#define TRAIT_FINGERLESS "fingerless" //The limb has no fingies

//item traits
#define TRAIT_NODROP            "nodrop"
#define TRAIT_NOEMBED			"noembed"
#define TRAIT_T_RAY_VISIBLE     "t-ray-visible" // Visible on t-ray scanners if the atom/var/level == 1
#define TRAIT_NO_TELEPORT		"no-teleport" //you just can't

//quirk traits
#define TRAIT_ALCOHOL_TOLERANCE	"alcohol_tolerance"
#define TRAIT_AGEUSIA			"ageusia"
#define TRAIT_HEAVY_SLEEPER		"heavy_sleeper"
#define TRAIT_NIGHT_VISION		"night_vision"
#define TRAIT_LIGHT_STEP		"light_step"
#define TRAIT_SPIRITUAL			"spiritual"
#define TRAIT_FAN_CLOWN			"fan_clown"
#define TRAIT_FAN_MIME			"fan_mime"
#define TRAIT_VORACIOUS			"voracious"
#define TRAIT_SELF_AWARE		"self_aware"
#define TRAIT_FREERUNNING		"freerunning"
#define TRAIT_SKITTISH			"skittish"
#define TRAIT_POOR_AIM			"poor_aim"
#define TRAIT_PROSOPAGNOSIA		"prosopagnosia"
#define TRAIT_DRUNK_HEALING		"drunk_healing"
#define TRAIT_TAGGER			"tagger"
#define TRAIT_PHOTOGRAPHER		"photographer"
#define TRAIT_MUSICIAN			"musician"
#define TRAIT_LIGHT_DRINKER		"light_drinker"
#define TRAIT_FRIENDLY			"friendly"
#define TRAIT_GRABWEAKNESS		"grab_weakness"
#define TRAIT_SNOB				"snob"

// common trait sources
#define TRAIT_GENERIC "generic"
#define UNCONSCIOUS_BLIND "unconscious_blind"
#define EYE_DAMAGE "eye_damage"
#define GENETIC_MUTATION "genetic"
#define OBESITY "obesity"
#define MAGIC_TRAIT "magic"
#define TRAUMA_TRAIT "trauma"
#define DISEASE_TRAIT "disease"
#define SPECIES_TRAIT "species"
#define ORGAN_TRAIT "organ"
#define CRIT_TRAIT "crit"
#define ROUNDSTART_TRAIT "roundstart" //cannot be removed without admin intervention
#define JOB_TRAIT "job"
#define CYBORG_ITEM_TRAIT "cyborg-item"
#define ADMIN_TRAIT "admin" // (B)admins only.
#define CHANGELING_TRAIT "changeling"
#define CULT_TRAIT "cult"
#define CURSED_ITEM_TRAIT "cursed-item" // The item is magically cursed
#define ABSTRACT_ITEM_TRAIT "abstract-item"
#define STATUS_EFFECT_TRAIT "status-effect"
#define CLOTHING_TRAIT "clothing"
#define HELMET_TRAIT "helmet"
#define GLASSES_TRAIT "glasses"
#define VEHICLE_TRAIT "vehicle" // inherited from riding vehicles
#define INNATE_TRAIT "innate"

// unique trait sources, still defines
#define TRAIT_LONGSTRIDER "longstrider"
#define TRAIT_DARKVISION "darkvision"
#define CLONING_POD_TRAIT "cloning-pod"
#define STATUE_MUTE "statue"
#define CHANGELING_DRAIN "drain"
#define CHANGELING_HIVEMIND_MUTE "ling_mute"
#define ABYSSAL_GAZE_BLIND "abyssal_gaze"
#define HIGHLANDER "highlander"
#define TRAIT_HULK "hulk"
#define STASIS_MUTE "stasis"
#define GENETICS_SPELL "genetics_spell"
#define EYES_COVERED "eyes_covered"
#define CULT_EYES "cult_eyes"
#define TRAIT_SANTA "santa"
#define SCRYING_ORB "scrying-orb"
#define ABDUCTOR_ANTAGONIST "abductor-antagonist"
#define NUKEOP_TRAIT "nuke-op"
#define DEATHSQUAD_TRAIT "deathsquad"
#define MEGAFAUNA_TRAIT "megafauna"
#define CLOWN_NUKE_TRAIT "clown-nuke"
#define STICKY_MOUSTACHE_TRAIT "sticky-moustache"
#define CHAINSAW_FRENZY_TRAIT "chainsaw-frenzy"
#define CHRONO_GUN_TRAIT "chrono-gun"
#define REVERSE_BEAR_TRAP_TRAIT "reverse-bear-trap"
#define CURSED_MASK_TRAIT "cursed-mask"
#define HIS_GRACE_TRAIT "his-grace"
#define HAND_REPLACEMENT_TRAIT "magic-hand"
#define HOT_POTATO_TRAIT "hot-potato"
#define SABRE_SUICIDE_TRAIT "sabre-suicide"
#define ABDUCTOR_VEST_TRAIT "abductor-vest"
#define CAPTURE_THE_FLAG_TRAIT "capture-the-flag"
#define EYE_OF_GOD_TRAIT "eye-of-god"
#define SHAMEBRERO_TRAIT "shamebrero"
#define CHRONOSUIT_TRAIT "chronosuit"
#define LOCKED_HELMET_TRAIT "locked-helmet"
#define NINJA_SUIT_TRAIT "ninja-suit"
#define ANTI_DROP_IMPLANT_TRAIT "anti-drop-implant"
#define SLEEPING_CARP_TRAIT "sleeping_carp"
#define MADE_UNCLONEABLE "made-uncloneable"
#define TIMESTOP_TRAIT "timestop"
#define HUGBOX_TRAIT "hugbox"
#define ADVENTURER_TRAIT "adventurer"
