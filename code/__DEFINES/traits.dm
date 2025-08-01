#define SIGNAL_ADDTRAIT(trait_ref) ("addtrait " + trait_ref)
#define SIGNAL_REMOVETRAIT(trait_ref) ("removetrait " + trait_ref)

// ROGUETRAITS (description when rmb skills button)
#define TRAIT_WEBWALK "Webwalker"
#define TRAIT_NOSTINK "Dead Nose"
#define TRAIT_ZJUMP "High Jumping"
#define TRAIT_JESTERPHOBIA "Jesterphobic"
#define TRAIT_XENOPHOBIC "Xenophobic"
#define TRAIT_TOLERANT "Tolerant"
#define TRAIT_LEAPER "Leaper"
#define TRAIT_NUTCRACKER "Nutcracker"
#define TRAIT_SEEPRICES "Skilled Appraiser"
#define TRAIT_SEEPRICES_SHITTY "Appraiser"
#define TRAIT_STRONGBITE "Strong Bite"
#define TRAIT_NOBLE "Noble Blooded"
#define TRAIT_DEFILED_NOBLE "Drained Noble Blood"
#define TRAIT_EMPATH "Empath"
#define TRAIT_BREADY "Battleready"
#define TRAIT_MEDIUMARMOR "Maille Training"
#define TRAIT_HEAVYARMOR "Plate Training"
#define TRAIT_DODGEEXPERT "Fast Reflexes"
#define TRAIT_MAGEARMOR "Magic Barrier"
#define TRAIT_DECEIVING_MEEKNESS "Deceiving Meekness"
#define TRAIT_CRITICAL_RESISTANCE "Critical Resistance"
#define TRAIT_CRITICAL_WEAKNESS "Critical Weakness"
#define TRAIT_MANIAC_AWOKEN "Awoken"
#define TRAIT_INFINITE_STAMINA "Indefatigable" //for ai
#define TRAIT_NUDIST "Nudist" //you can't wear most clothes
#define TRAIT_CYCLOPS_LEFT "Cyclops (Left)" //poked left eye
#define TRAIT_CYCLOPS_RIGHT "Cyclops (Right)" //poked right eye
#define TRAIT_INHUMEN_ANATOMY "Inhumen Anatomy" //can't wear hats and shoes
#define TRAIT_NASTY_EATER "Inhumen Digestion" //can eat rotten food, organs, poison berries, and drink murky water
#define TRAIT_WILD_EATER "Beastly Digestion" //can eat raw and rotten food and drink murky water
#define TRAIT_NOFALLDAMAGE1 "Fall Damage Reduction"
#define TRAIT_NOFALLDAMAGE2 "Fall Damage Immunity"
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
#define TRAIT_GUARDSMAN "Vigilant Guardsman"
#define TRAIT_TAVERN_FIGHTER "Tavern Fighter"
#define TRAIT_WOODSMAN "Talented Woodsman"
#define TRAIT_DUNGEONMASTER "Ruthless Jailor"
#define TRAIT_DEATHBARGAIN "Death Bargain" // Used by UNDERMAIDEN'S BARGAIN
#define TRAIT_RITUALIST "Ritualist"  // Allows use of ritual chalk
#define TRAIT_INQUISITION "Member of the Otavan Inquisition"
#define TRAIT_GOODTRAINER "Good Trainer"
#define TRAIT_OUTDOORSMAN "Outdoorsman"
#define TRAIT_SEA_DRINKER "Denizen of the Deep"
#define TRAIT_STUDENT		"Student"
#define TRAIT_INTELLECTUAL "Intellectual"
#define TRAIT_GRAVEROBBER "Experienced Grave Robber"
#define TRAIT_PURITAN "Puritan"
#define TRAIT_MIRROR_MAGIC "Mirror Magic"
#define TRAIT_WITCH "They fear me, but I am useful to them."
#define TRAIT_INFINITE_ENERGY "Boundless Energy" //infinite fatigue (blue bar) but not infinite stamina
#define TRAIT_PERMAMUTE "Permanent Mute"
#define TRAIT_EXCOMMUNICATED "Excommunicated"
#define TRAIT_HERESIARCH "Forbidden Knowledge" //allows entry to ascendant church
#define TRAIT_JACKOFALLTRADES "Jack of All Trades"	//Reduces skill up cost

//Hearthstone port (Tracking)
#define TRAIT_PERFECT_TRACKER "Perfect Tracker" //Will always find any tracks and analyzes them perfectly.
#define TRAIT_ZIZOSIGHT "Blessing of Zizo" // I can see just a bit more clearly in darkness.
#define TRAIT_DEATHSIGHT "Veiled Whispers" // Is notified when a player character dies, but not told exactly where or how.
//Hearthstone/Azure end.

// ROGUEspecialTRAITS (description when rmb skills button)
#define TRAIT_CIVILIZEDBARBARIAN "Expert Pugilist"
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
#define TRAIT_FORGEBLESSED "Blessing of Malum" //Reduces the fatigue cost of smithing a bit.
#define TRAIT_APRICITY	"Apricity" //Decreased stamina regen time during "day" and less so during night
#define TRAIT_SHARPER_BLADES "Sharper Blades" //Weapons lose less blade integrity
#define TRAIT_JUSTICARSIGHT "Blessing of Ravox" //Allows seeing bounties and crimes when examining outlaws.
#define TRAIT_EXTEROCEPTION	"Exteroception" //See others' hunger and thirst; pairs well with empath.
#define TRAIT_BLACKLEG	"Blackleg" //Rig coin, dice, cards in your favor - UNUSED FOR NOW
#define TRAIT_BETTER_SLEEP	"Better Sleep" //Recover more energy (blue bar) when sleeping
#define TRAIT_LEECHIMMUNE "Unleechable" //leeches wont attach in bog squares + dendor boon.
#define TRAIT_LONGSTRIDER "Longstrider"
#define TRAIT_PSYDONIAN_GRIT "Psydonian Grit" // Pain Tolerance. Through faith, ENDURE.
#define TRAIT_PSYDONITE "Psydonite's Devotion" // Anti-Miracles on a selective basis, anastasis / cure rot still apply. Slow passive wound healing while you have blood.
#define TRAIT_BLACKBAGGER "Apprehension Techniques" // Capable of using Garrotes and Blackbags. Apprehension techniques.

// PATRON GOD CURSES

#define TRAIT_CURSE "Curse" //source
#define TRAIT_CURSE_ASTRATA "Curse of Astrata" //Cannot sleep and burn up in sunlight
#define TRAIT_CURSE_NOC "Curse of Noc" //Cannot use magic and burn up in moonlight
#define TRAIT_CURSE_DENDOR "Curse of Dendor"//It will do something once I decide what that will be
#define TRAIT_CURSE_ABYSSOR "Curse of Abyssor" //fears the water and cannot open sleep menu
#define TRAIT_CURSE_RAVOX "Curse of Ravox" // effect same as -2 (-40% parry -40% dodge -40% accuracy) to all weapon skills
#define TRAIT_CURSE_NECRA "Curse of Necra" //critical weakness and CON nuke
#define TRAIT_CURSE_XYLIX "Curse of Xylix" //no fortune
#define TRAIT_CURSE_PESTRA "Curse of Pestra" //less stamina, cannot run and missing nose
#define TRAIT_CURSE_MALUM "Curse of Malum" //cannot craft or use smith hammer or level skills in sleep menu
#define TRAIT_CURSE_EORA "Curse of Eora" //world is ugly

// ASCENDANT CULTIST TRAITS (all of them recognize each other)
#define TRAIT_COMMIE "Blessing of Matthios" //recognized by bandits as an ally
#define TRAIT_CABAL "Of the Cabal" //Zizo cultists recognize each other too
#define TRAIT_HORDE "Anointed" //Graggarites also recognize each other
#define TRAIT_DEPRAVED "Fallen" //Baothans also recognize each other
#define TRAIT_MATTHIOS_EYES	"Eyes of Matthios" //Examine to see the most expensive item someone has (Replaces shitty-appraisal)

//ASCENDANT GOD CURSES

#define TRAIT_CURSE_ZIZO "Curse of Zizo" //int nuke and no magic
#define TRAIT_CURSE_GRAGGAR "Curse of Graggar" //str nuke, inhumen anatomy and disfigurment
#define TRAIT_CURSE_MATTHIOS "Curse of Matthios" //lck nuke and clumsy
#define TRAIT_CURSE_BAOTHA "Curse of Baotha" //nudist

#define TRAIT_BASHDOORS "Door Basher"
#define TRAIT_NOMOOD "Moodless"
#define TRAIT_BAD_MOOD "Bad Mood"
#define TRAIT_NIGHT_OWL "Night Owl"
#define TRAIT_BEAUTIFUL "Beautiful"
#define TRAIT_SIMPLE_WOUNDS "simple_wounds"
#define TRAIT_BANDITCAMP "banditcamp"
#define TRAIT_VAMPMANSION "vampiremansion"
#define TRAIT_VAMP_DREAMS "vamp_dreams"
#define TRAIT_LIMPDICK "Limp Dick"
#define TRAIT_SEXPASS "sexpass"
#define TRAIT_STEELHEARTED "Steelhearted" //no bad mood from dismembering or seeing this
#define TRAIT_IWASREVIVED "iwasrevived" //prevents PQ gain from reviving the same person twice
#define TRAIT_IWASUNZOMBIFIED "iwasunzombified" //prevents PQ gain from curing a zombie twice
#define TRAIT_IWASHAUNTED "iwashaunted" //prevents spawning a haunt from a decapitated body twice
#define TRAIT_SCHIZO_AMBIENCE "Schizo Ambience" //replaces all ambience with creepy shit
#define TRAIT_SCREENSHAKE "Tremors" //screen will always be shaking, you cannot stop it
#define TRAIT_NORUN "Decayed Flesh"
#define TRAIT_PUNISHMENT_CURSE "PunishmentCurse"
#define TRAIT_LEPROSY "Leprosy"
#define TRAIT_NUDE_SLEEPER "Nude Sleeper"
#define TRAIT_SILVER_BLESSED "Silver Blessed"
#define TRAIT_OUTLANDER "Outlander"
#define TRAIT_OUTLAW "Outlaw"
#define TRAIT_KNOWNCRIMINAL "Known Criminal"
#define TRAIT_BIGGUY "Big Guy"
#define TRAIT_RESIDENT "Resident"
#define TRAIT_COUNTERCOUNTERSPELL "Counter Counterspell"
#define TRAIT_UNSEEMLY "Ugly"
#define TRAIT_HERETIC_SEER "Heretic Seer"
#define TRAIT_DUALWIELDER "Dual Wielder"
#define TRAIT_SENTINELOFWITS "Sentinel of Wits"
#define TRAIT_KEENEARS "Keen Ears"
#define TRAIT_CICERONE "Cicerone"
#define TRAIT_EASYDISMEMBER	"Easy Dismember"
#define TRAIT_NOPAIN	"Painless"
#define TRAIT_NOPAINSTUN	"Enduring"
#define TRAIT_NOBREATH	"Breathless"
#define TRAIT_TOXIMMUNE	"Poison Immune"
#define TRAIT_GRABIMMUNE "Unstoppable"
#define TRAIT_ROTMAN "Rotman"
#define TRAIT_ZOMBIE_IMMUNE "Deadite Immunity" //immune to deadite infection
#define TRAIT_NOHUNGER	"Foodless"
#define TRAIT_DARKVISION "Darksight"
#define TRAIT_NOCSHADES "Nocshaded"
#define TRAIT_LIGHT_STEP	"Light Step"
#define TRAIT_AZURENATIVE "Azure Native"
#define TRAIT_SLEUTH	"Sleuth"
#define TRAIT_HARDSHELL "Hardshell"
#define TRAIT_WOODWALKER "Woodwalker"
#define TRAIT_ARCYNE_T1 "Arcyne Training (Novice)"
#define TRAIT_ARCYNE_T2 "Arcyne Training (Apprentice)"
#define TRAIT_ARCYNE_T3 "Arcyne Training (Expert)"
#define TRAIT_ARCYNE_T4 "Arcyne Training (Master)"
#define TRAIT_STRENGTH_UNCAPPED "Strength Unbound"	//ignores the STR softcap.
#define TRAIT_EORAN_CALM "Eoran Calm"
#define TRAIT_EORAN_SERENE "Eoran Serenity"
#define TRAIT_NECRAS_VOW "Necra's Vow"
// ARMOR / CLOTHING GIVEN TRAITS (GIVEN BY WEARING CLOTHES/ARMOR PIECES)
#define TRAIT_MONK_ROBE	"Holy Vestatures"

GLOBAL_LIST_INIT(roguetraits, list(
	TRAIT_LEPROSY = span_necrosis("I'm a disgusting leper..."),
	TRAIT_TAVERN_FIGHTER = span_info("I am vigilant in my duties. The Tavern is my home, none shall dare oppose me or skip out on payment."),
	TRAIT_GUARDSMAN = span_info("I am vigilant in my duties. In the town of Azure Peak, my abilities are sharper due to my routine and familiarity."),
	TRAIT_WOODSMAN = span_info("I am vigilant in my duties. In the grove and coast of Azure Peak, my abilities are sharper due to my routine and familiarity."),
	TRAIT_DEATHBARGAIN = span_info("A horrible deal has been prepared in your name. May you never see it fulfilled..."),
	TRAIT_RITUALIST = span_info("I am skilled in the holy arts. Using ritual chalk, I can more deftly channel my God's powers via runes."),
	TRAIT_INQUISITION = span_info("I am a member of the Otavan Inquisition. I can easily identify others of my Sect at a glance."),
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
	TRAIT_LEAPER = "I can leap like a frog, landing where I want.",
	TRAIT_NUTCRACKER = "I love kicking idiots on the nuts!",
	TRAIT_SEEPRICES = "I can tell the prices of things down to the zenny.",
	TRAIT_SEEPRICES_SHITTY = "I can tell the prices of things... <i>Kind of</i>.",
	TRAIT_STRONGBITE = span_info("Stronger bites, critical bite attacks."),
	TRAIT_NOBLE = span_blue("I'm of noble blood."),
	TRAIT_DEFILED_NOBLE = span_blue("I'm of noble blood but... Something feels off!"),
	TRAIT_EMPATH = span_info("I can notice when people are in pain."),
	TRAIT_BREADY = span_info("Defensive stance does not passively fatigue me."),
	TRAIT_MEDIUMARMOR = span_info("I can move freely in medium armor."),
	TRAIT_HEAVYARMOR = span_info("I can move freely in heavy armor."),
	TRAIT_DODGEEXPERT = span_info("I can dodge easily while only wearing light armor."),
	TRAIT_MAGEARMOR = span_info("My magics can protect me from a blow every so often."),
	TRAIT_DECEIVING_MEEKNESS = span_info("People look at me and think I am a weakling. They are mistaken. I've learned how to hide my vices and true beliefs from others."),
	TRAIT_CRITICAL_RESISTANCE = "I am resistant to wounds that would be life threatening to others.",
	TRAIT_CRITICAL_WEAKNESS = span_danger("I am weak to wounds that others could survive."),
	TRAIT_MANIAC_AWOKEN = span_danger("I am <b>WAKING UP</b> and the sheeple know this. They will resist."),
	TRAIT_INFINITE_STAMINA = "I have boundless energy, I will never tire.",
	TRAIT_NUDIST = "I <b>refuse</b> to wear clothes. They are a hindrance to my freedom.",
	TRAIT_CYCLOPS_LEFT = span_warning("My left eye has been poked out..."),
	TRAIT_CYCLOPS_RIGHT = span_warning("My right eye has been poked out..."),
	TRAIT_LEECHIMMUNE = "Leeches are reluctant to bite me.",
	TRAIT_INHUMEN_ANATOMY = "My anatomy is inhumen, preventing me from wearing hats and shoes.",
	TRAIT_NASTY_EATER = span_dead("I can eat bad food, and water that would be toxic to humen will not affect me."),
	TRAIT_WILD_EATER = span_info("I can eat raw food and drink from dirty water."),
	TRAIT_NOFALLDAMAGE1 = span_warning("I can easily handle minor falls."),
	TRAIT_NOFALLDAMAGE2 = span_warning("I can handle a fall from any height."),
	TRAIT_GRABIMMUNE = span_warning("My great strength, or slippery agility, prevents others from getting ahold of me!"),
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
	TRAIT_KNOWNCRIMINAL = span_bloody("I am a branded criminal. Nothing can change this."),
	TRAIT_NORUN = span_warning("My body has atrophied in my state of decay; my leg joints just don't have the strength or durability for running anymore"),
	TRAIT_GOODLOVER = span_love("It's a lucky thing to share my bed."),
	TRAIT_LIMPDICK = span_crit("My soldier refuses to rise to attention! Curses!"),
	TRAIT_SEEDKNOW = span_info("I know which seeds grow which crops."),
	TRAIT_PERFECT_TRACKER = span_info("I am the perfect tracker. No tracks will deceive my eyes, nor will they hide their secrets from me."),//Hearthstone port.
	TRAIT_ZIZOSIGHT = span_info("Zizo blesses my eyes to be unburdened by the night."), //Hearthstone change.
	TRAIT_CIVILIZEDBARBARIAN = span_info("My rigorous training in the martial arts has turned me into a living weapon. No limb is out of reach for my fists and feet, and my unarmed strikes now have a higher chance to inflict critical damage."),
	TRAIT_COMICSANS = span_sans("I am cursed with a odd voice."),
	TRAIT_SQUIRE_REPAIR = span_info("I know my way around my Master's tools."),
	TRAIT_WATERBREATHING = span_info("I do not drown in bodies of water."),
	TRAIT_NUDE_SLEEPER = span_warning("I can't fall asleep unless I'm nude and in bed."),
	TRAIT_ABYSSOR_SWIM = span_info("I get far less tired when swimming than my peers."),
	TRAIT_LONGSTRIDER = span_info("Each of my steps finds it's footing no matter how treacherous the terrain is."),
	TRAIT_TRAINED_SMITH = span_info("I've spent long training, and with some more, I will be able to smith legendary items."),
	TRAIT_DEATHSIGHT = span_info("I can feel when someone nearby draws the Undermaiden's attention."),
	TRAIT_FORGEBLESSED = span_info("Countless long nights spent forging metal have honed my endurance, allowing me to work an anvil far longer than most without tiring."),
	TRAIT_XYLIX = span_info("I know how to speak in code that only fellow tricksters can understand."),
	TRAIT_APRICITY = span_info("Astrata's light blesses and rejuvenates me, allowing me to regain my stamina quicker."),
	TRAIT_SHARPER_BLADES = span_info("My blades go dull slower, ensuring they stay sharp longer."),
	TRAIT_CABAL = span_info("In secret, I have studied the ways of Her ascension."),
	TRAIT_HORDE = span_info("BY BLOOD AND BONE, I AM OF GRAGGAR'S ANOINTED!"),
	TRAIT_PSYDONITE = span_info("PSYDON LYVES. PSYDON PERSISTS. I can ENDURE and LYVE with wounds better than most. Healing miracles hold no sway over me."),
	TRAIT_PSYDONIAN_GRIT = span_info("I can shrug off my wounds and maintain composure under duress. My own mortality is proof that I LYVE, as too does HE."),
	TRAIT_BLACKBAGGER = span_info("I've been trained to properly abduct individuals through the use of seizing garrotes and blackbags."),
	TRAIT_FORTITUDE = span_info("The typical drain I feel from day to day life is lessened, my athleticism greater."),
	TRAIT_GUIDANCE = span_info("The arcyne aides me in battle."),
	TRAIT_DEPRAVED = span_info("The languid scent of Her debauchery is known to me."),
	TRAIT_SILVER_BLESSED = span_info("I am anointed with holy silver, which preserves me from curses that bite."),
	TRAIT_GOODTRAINER = span_info("I am a good teacher, and when it comes to weaponry I can train others to be just as skilled as I am."),
	TRAIT_SEA_DRINKER = span_info("As a denizen of the deep, I can drink salty ocean water safely."),
	TRAIT_BIGGUY = span_info("My immense frame and size allows me to smash through wooden doors, and throw people more easily."),
	TRAIT_OUTDOORSMAN = span_info("My experience in the wilds allows me to fall asleep on surfaces like treebranches as if they were beds."),
	TRAIT_STUDENT =  span_info("I am overwhelmed by all this knowledge!"),
	TRAIT_LEGENDARY_ALCHEMIST = span_info("An expert in the art of finding herbs in the wild."),
	TRAIT_INTELLECTUAL = span_info("I have a keen eye and can assess a person's prowess in wit and blade."),
	TRAIT_COUNTERCOUNTERSPELL = span_info("I automatically know when to counter Counterspells, and can do so without even thinking about it."),
	TRAIT_UNSEEMLY = span_info("My face is ugly and makes everyone who looks at me miserable."),
	TRAIT_HERETIC_SEER = span_info("I can tell other Ascendant followers without sharing their faith."),
	TRAIT_DUALWIELDER = span_info("If I wield two identical weapons, I  roll twice for my attacks, and so will the enemy against me. I do not suffer penalties from using my off-hand in combat."),
	TRAIT_SENTINELOFWITS = span_info("My Intelligence aids in my defense. Every 2 points above 10 INT become an additional 10% chance to dodge or parry. Does not count positive buffs from potions or substances."),
	TRAIT_KEENEARS = span_info("I've a good pair of ears, and can tell who is speaking, even when they're out of sight. I can also hear whispers from further away."),
	TRAIT_SCREENSHAKE = span_suicide("I don't feel very steady anymore..."),
	TRAIT_GRAVEROBBER = span_info("My experience with 'post-mortem artifact recovery' has allowed me to resist Necra's curse placed upon those who disturb resting places."),
	TRAIT_PURITAN = span_info("I lead the Sect of the Psydonic Otavan Inquisition sent here from Otava."),
	TRAIT_MIRROR_MAGIC = span_info("Mirror, mirror on the wall, who's the fairest of them all?"),
	TRAIT_JUSTICARSIGHT = span_info("I am able to remember someone's crimes by looking at them, and how much their bounty is."),
	TRAIT_CICERONE = span_info("I am well-versed in the differences of brews and spirits, and can tell them apart at a glance."),
	TRAIT_BETTER_SLEEP = span_info("I recover more energy when sleeping."),
	TRAIT_ROTMAN = span_info("I am partially undead. My heart does not beat."),
	TRAIT_EASYDISMEMBER = span_info("My limbs are frail and fragile. They can be dismembered with greater ease, including my neck."),
	TRAIT_NOPAIN = span_info("I feel no pain."),
	TRAIT_NOPAINSTUN = span_info("Pain does not impair me."),
	TRAIT_NOBREATH = span_info("I do not breathe."),
	TRAIT_TOXIMMUNE = span_info("Poisons do nothing to me."),
	TRAIT_ZOMBIE_IMMUNE = span_info("Deadite bites cannot infect me."),
	TRAIT_NOHUNGER = span_info("I do not hunger, or thirst."),
	TRAIT_DARKVISION = span_info("I can see better in the dark."),
	TRAIT_NOCSHADES = span_info("The lens I look through allows me to see in the dark clear as dae, at the cost of greater vision."),
	TRAIT_RESIDENT = span_info("I've been granted a Meister account, and the ownership of a house in Azure Peak."),
	TRAIT_LIGHT_STEP = span_info("My steps are light and swift. I make less noise while sneaking, and can sneak much quicker."),
	TRAIT_NOMOOD = span_info("I feel no sorrow, no joy, and no stress."),
	TRAIT_AZURENATIVE = span_info("I've grown up and lived all my lyfe in these lands. I can only trigger ambushes if I sprint through them."),
	TRAIT_SLEUTH = span_info("I can spot my tracked Mark's trail without needing to approach it, and can spot them at a distance. I can track more frequently, and the act is not impaired by movement. I can examine tracks right away."),
	TRAIT_HARDSHELL = span_info("The bulk of this armor prevents me from parrying effectively, but I can still move out of the way."),
	TRAIT_MATTHIOS_EYES = span_notice("I have a sense for what the most valuable item someone has is."),
	TRAIT_WOODWALKER = span_notice("I can climb trees quicker, and gain climbing experience twice as quickly. I can step on thorns and branches safely in the woods. I can get twice as many things from searching bushes, and I can stand on leaves in trees safely."),
	TRAIT_ARCYNE_T1 = span_notice("I have received basic training in the Arcyne arts, allowing me access to a small variety of spells useful outside of combat."),
	TRAIT_ARCYNE_T2 = span_notice("I have received advanced training in the Arcyne arts, allowing me to learn basic combat spells"),
	TRAIT_ARCYNE_T3 = span_notice("I am a full-fledged mage, and have access to devastating spells that affects a wide area."),
	TRAIT_ARCYNE_T4 = span_notice("I'm a master of the Arcyne arts, and has access to some of the most powerful spells ever devised."),
	TRAIT_INFINITE_ENERGY = span_notice ("I don't need rest; I won't ever feel fatigue."),
	TRAIT_PERMAMUTE = span_notice("I am a mute. I cannot speak."),
	TRAIT_STRENGTH_UNCAPPED = span_warning("MY STRENGTH IS UNBOUND!"),
	TRAIT_MONK_ROBE = span_notice("I feel closer to the gods in my meager robes.. I feel vigorous, empowered by their light!"),
	TRAIT_EORAN_CALM = span_notice("Eora has touched me, granting me some calm. She protects me from the peaks of my stress."),
	TRAIT_EORAN_SERENE = span_greentext("Eora has blessed me with all-encompassing serenity. I feel no more stress."),
	TRAIT_NECRAS_VOW = span_warning("I've pledged myself to Necra. If I fall, I am Hers."),
	TRAIT_HERESIARCH = span_warning("I know of sacred sites of worship where followers of the Ascendants convene, and the path to the nearest conclave is etched into my memory."),
	TRAIT_CURSE_ASTRATA = span_warning("I am forsaken by the Sun. I will find no rest under Her unwavering gaze."),
	TRAIT_CURSE_NOC = span_warning("I am forsaken by the Moon. I will find no salvation in His grace."),
	TRAIT_CURSE_DENDOR = span_warning("I am forsaken by the Treefather. Reason and common sense abandon me."),
	TRAIT_CURSE_ABYSSOR = span_warning("I am forsaken by the Dreamer. His domain will surely become my grave."),
	TRAIT_CURSE_RAVOX = span_warning("I am forsaken by the Justicar. My opponents will show me no clemency."),
	TRAIT_CURSE_NECRA = span_warning("I am forsaken by the Undermaiden. Even the lightest strike could send me into Her embrace."),
	TRAIT_CURSE_XYLIX = span_warning("I am forsaken by the Trickster. Misfortune follows me on every step."),
	TRAIT_CURSE_PESTRA = span_warning("I am forsaken by the Plaguemother. Sickness overwhelms my body rendering even simplest of tasks into a challenge."),
	TRAIT_CURSE_MALUM = span_warning("I am forsaken by the Maker. My hands tremble and fog overwhelms my mind."),
	TRAIT_CURSE_EORA = span_warning("I am forsaken by the Lover. There is no beauty to be found for me in this world."),
	TRAIT_EXCOMMUNICATED = span_warning("I have been excommunicated."),
	TRAIT_CURSE_ZIZO = span_warning("I am forsaken by the Architect. Her grasp reaches for my heart."),
	TRAIT_CURSE_GRAGGAR = span_warning("I am forsaken by the Warlord. Bloodlust is only thing I know for real."),
	TRAIT_CURSE_MATTHIOS = span_warning("I am forsaken by the Dragon. Greed will be my only salvation."),
	TRAIT_CURSE_BAOTHA = span_warning("I am forsaken by the Heartbreaker. I am drowning in her promises."),
  TRAIT_JACKOFALLTRADES = span_notice("Skills cost half as much for me to raise.")
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
#define HAS_TRAIT_FROM_ONLY(target, trait, source) (HAS_TRAIT(target, trait) && (source in target._status_traits[trait]) && (length(target.status_traits[trait]) == 1))
#define HAS_TRAIT_NOT_FROM(target, trait, source) (HAS_TRAIT(target, trait) && (length(target.status_traits[trait] - source) > 0))

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
#define TRAIT_NOTIGHTGRABMESSAGE "notightgrabmessage" // Hides grab tightening messages.
#define TRAIT_NOSSDINDICATOR "nossdindicator" // Hides the SSD indicator. Used with scrying.
#define TRAIT_NOSTRUGGLE "nostruggle" // Instant grabs on someone else.
#define TRAIT_GARROTED "garroted" // Garrote-wired. Used for a snowflaked grab with item relevant tracking.
#define TRAIT_BAGGED "bagged" // Black-bagged. More snowflaking.
#define TRAIT_IGNORESLOWDOWN	"Ignore Slow"
#define TRAIT_IGNOREDAMAGESLOWDOWN "Ignore Damage Slowdown"
#define TRAIT_RIGIDMOVEMENT		"Ignore Natural Health Slowdown"
#define TRAIT_DEATHCOMA			"Death Coma" //Causes death-like unconsciousness
#define TRAIT_FAKEDEATH			"Fake Death" //Makes the owner appear as dead to most forms of medical examination
#define TRAIT_STUNIMMUNE		"stun_immunity"
#define TRAIT_STUNRESISTANCE    "stun_resistance"
#define TRAIT_SLEEPIMMUNE		"sleep_immunity"
#define TRAIT_PUSHIMMUNE		"push_immunity"
#define TRAIT_STABLEHEART		"stable_heart"
#define TRAIT_STABLELIVER		"stable_liver"
#define TRAIT_RESISTHEAT		"resist_heat"
#define TRAIT_RESISTHEATHANDS	"resist_heat_handsonly" //For when you want to be able to touch hot things, but still want fire to be an issue.
#define TRAIT_RESISTCOLD		"resist_cold"
#define TRAIT_RESISTHIGHPRESSURE	"resist_high_pressure"
#define TRAIT_RESISTLOWPRESSURE	"resist_low_pressure"
#define TRAIT_RADIMMUNE			"rad_immunity"
#define TRAIT_VIRUSIMMUNE		"virus_immunity"
#define TRAIT_PIERCEIMMUNE		"Pierce Immunity"
#define TRAIT_NODISMEMBER		"Dismember Immunity"
#define TRAIT_NOFIRE			"nonflammable"
#define TRAIT_NOGUNS			"no_guns"
#define TRAIT_NOMETABOLISM		"no_metabolism"
#define TRAIT_HARDDISMEMBER		"Hard Dismember"
#define TRAIT_LIMBATTACHMENT 	"limb_attach"
#define TRAIT_NOLIMBDISABLE		"no_limb_disable"
#define TRAIT_EASYLIMBDISABLE	"easy_limb_disable"
#define TRAIT_TOXINLOVER		"toxinlover"
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
#define TRAIT_DRUQK				"druqk"
#define TRAIT_BURIED_COIN_GIVEN "buried_coin_given" // prevents a human corpse from being used for a corpse multiple times
#define TRAIT_BLOODLOSS_IMMUNE "bloodloss_immune" // can bleed, but will never die from blood loss
#define TRAIT_NO_BITE "no_bite" //prevents biting
#define TRAIT_LEGENDARY_ALCHEMIST		"Expert Herb Finder"
#define TRAIT_STUCKITEMS "stuck_items" // Prevents removing items except for hand slots

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
#define TRAIT_VIRTUE "virtue"
#define TRAIT_MIRACLE "miracle"
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
#define TRAIT_GUIDANCE "Guidance"
#define TRAIT_FORTITUDE "Fortitude"
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

#define TRAIT_I_AM_INVISIBLE_ON_A_BOAT "invisible_on_tram"

//for ai
#define TRAIT_SUBTREE_REQUIRED_OPERATIONAL_DATUM "element-required"

/*/mob/living/proc/on_trait_gain(trait, source)
	SEND_SIGNAL(src, COMSIG_TRAIT_GAIN, trait, source)
	switch(trait)
		if(TRAIT_COMMIE, TRAIT_CABAL, TRAIT_HORDE, TRAIT_DEPRAVED)
			if(ishuman(src))
				var/mob/living/carbon/human/H = src
				H.update_heretic_commune()

/mob/living/proc/on_trait_loss(trait, source)
	SEND_SIGNAL(src, COMSIG_TRAIT_LOSS, trait, source)
	switch(trait)
		if(TRAIT_COMMIE, TRAIT_CABAL, TRAIT_HORDE, TRAIT_DEPRAVED)
			if(ishuman(src))
				var/mob/living/carbon/human/H = src
				H.update_heretic_commune()*/

///The entity has AI 'access', so is either an AI, has an access wand, or is an admin ghost AI. Used to block off regular Silicons from things.
///This is put on the mob, it is used on the client for Admins but they are the exception as they use `isAdminGhostAI`.
#define TRAIT_AI_ACCESS "ai_access_trait"
#define TRAIT_UI_BLOCKED "uiblocked"
/// Prevents usage of manipulation appendages (picking, holding or using items, manipulating storage).
#define TRAIT_HANDS_BLOCKED "handsblocked"
/// This mob should never close UI even if it doesn't have a client
#define TRAIT_PRESERVE_UI_WITHOUT_CLIENT "preserve_ui_without_client"
//important_recursive_contents traits
/*
 * Used for movables that need to be updated, via COMSIG_ENTER_AREA and COMSIG_EXIT_AREA, when transitioning areas.
 * Use [/atom/movable/proc/become_area_sensitive(trait_source)] to properly enable it. How you remove it isn't as important.
 */
#define TRAIT_AREA_SENSITIVE "area-sensitive"
///every hearing sensitive atom has this trait
#define TRAIT_HEARING_SENSITIVE "hearing_sensitive"
