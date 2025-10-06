#define SPEC_ID_HUMAN "human"
#define SPEC_ID_HALFELF "halfelf"
#define SPEC_ID_DARKELF "darkelf"
#define SPEC_ID_WOODELF "woodelf"
#define SPEC_ID_MOUNTAINDWARF "mountaindwarf"
#define SPEC_ID_TIEFLING "tiefling" // Tieberian in code
#define SPEC_ID_AASIMAR "aasimar"
#define SPEC_ID_LIZARDFOLK "lizardfolk"
#define SPEC_ID_LUPIAN "lupian"
#define SPEC_ID_TABAXI "tabaxi"
#define SPEC_ID_VENARDINE "venardine"
#define SPEC_ID_AXIAN "axian" // Akula in code
#define SPEC_ID_MOTH "moth" // Fluvian
#define SPEC_ID_DRACON "dracon" // Drakian
#define SPEC_ID_ANTHROMORPH "anthromorph" // Wildkin
#define SPEC_ID_ANTHROMORPHSMALL "anthromorphsmall" // Verminvolk
#define SPEC_ID_DEMIHUMAN "demihuman" // Halfkin
#define SPEC_ID_HALFORC "halforc"
#define SPEC_ID_KOBOLD "kobold"
#define SPEC_ID_GOBLINP "goblinp" // Goblin

//used in various places
#define ALL_RACES_TYPES list(\
	/datum/species/human/northern,\
	/datum/species/human/halfelf,\
	/datum/species/elf/dark,\
	/datum/species/elf/wood,\
	/datum/species/dwarf/mountain,\
	/datum/species/tieberian,\
	/datum/species/aasimar,\
	/datum/species/lizardfolk,\
	/datum/species/lupian,\
	/datum/species/tabaxi,\
	/datum/species/vulpkanin,\
	/datum/species/akula,\
	/datum/species/moth,\
	/datum/species/dracon,\
	/datum/species/anthromorph,\
	/datum/species/anthromorphsmall,\
	/datum/species/demihuman,\
	/datum/species/halforc,\
	/datum/species/kobold,\
	/datum/species/goblinp,\
)

#define RACES_RESPECTED \
	/datum/species/human/northern,\
	/datum/species/elf/wood,\
	/datum/species/human/halfelf,\
	/datum/species/dwarf/mountain,\
	/datum/species/aasimar,\
	/datum/species/lupian,\
	/datum/species/vulpkanin,\
	/datum/species/moth,\
	/datum/species/dracon,

#define RACES_TOLERATED \
	/datum/species/elf/dark,\
	/datum/species/tieberian,\
	/datum/species/lizardfolk,\
	/datum/species/tabaxi,\
	/datum/species/akula,\
	/datum/species/anthromorph,\
	/datum/species/demihuman,\


#define RACES_SHUNNED \
	/datum/species/halforc,\
	/datum/species/anthromorphsmall,\
	/datum/species/kobold,\

#define RACES_DESPISED \
	/datum/species/goblinp,\

#define RACES_CONSTRUCT \
	/datum/species/construct/metal,\

#define RACES_ALL_KINDS list(RACES_DESPISED, RACES_SHUNNED, RACES_TOLERATED, RACES_RESPECTED, RACES_CONSTRUCT)

#define RACES_NO_CONSTRUCT list(RACES_DESPISED, RACES_SHUNNED, RACES_TOLERATED, RACES_RESPECTED)

#define RACES_SHUNNED_UP list(RACES_SHUNNED, RACES_TOLERATED, RACES_RESPECTED)

#define RACES_TOLERATED_UP list(RACES_TOLERATED, RACES_RESPECTED)

#define NOBLE_RACES_TYPES list(\
	/datum/species/human/northern,\
	/datum/species/human/halfelf,\
	/datum/species/elf/dark,\
	/datum/species/elf/wood,\
	/datum/species/dwarf/mountain,\
	/datum/species/tieberian,\
	/datum/species/aasimar,\
	/datum/species/lizardfolk,\
	/datum/species/lupian,\
	/datum/species/tabaxi,\
	/datum/species/vulpkanin,\
	/datum/species/akula,\
	/datum/species/moth,\
	/datum/species/dracon,\
	/datum/species/anthromorph,\
	/datum/species/anthromorphsmall,\
	/datum/species/demihuman,\
	/datum/species/kobold,\
	/datum/species/goblinp,\
	/datum/species/construct/metal,\
)

#define CLOTHED_RACES_TYPES list(\
	/datum/species/human/northern,\
	/datum/species/human/halfelf,\
	/datum/species/elf/dark,\
	/datum/species/elf/wood,\
	/datum/species/dwarf/mountain,\
	/datum/species/tieberian,\
	/datum/species/aasimar,\
	/datum/species/lizardfolk,\
	/datum/species/lupian,\
	/datum/species/tabaxi,\
	/datum/species/vulpkanin,\
	/datum/species/akula,\
	/datum/species/moth,\
	/datum/species/dracon,\
	/datum/species/anthromorph,\
	/datum/species/anthromorphsmall,\
	/datum/species/demihuman,\
	/datum/species/halforc,\
	/datum/species/orc,\
	/datum/species/kobold,\
	/datum/species/goblinp,\
	/datum/species/construct/metal,\
)
// Non-dwarf non-kobold non-goblin mostly
#define NON_DWARVEN_RACE_TYPES list(\
	/datum/species/human/northern,\
	/datum/species/human/halfelf,\
	/datum/species/elf/dark,\
	/datum/species/elf/wood,\
	/datum/species/tieberian,\
	/datum/species/aasimar,\
	/datum/species/lizardfolk,\
	/datum/species/lupian,\
	/datum/species/tabaxi,\
	/datum/species/vulpkanin,\
	/datum/species/akula,\
	/datum/species/moth,\
	/datum/species/dracon,\
	/datum/species/anthromorph,\
	/datum/species/demihuman,\
	/datum/species/halforc,\
	/datum/species/construct/metal,\
)
// Non-elf non-dwarf non-kobold non-goblin mostly
#define HUMANLIKE_RACE_TYPES list(\
	/datum/species/human/northern,\
	/datum/species/tieberian,\
	/datum/species/aasimar,\
	/datum/species/lizardfolk,\
	/datum/species/lupian,\
	/datum/species/tabaxi,\
	/datum/species/vulpkanin,\
	/datum/species/akula,\
	/datum/species/moth,\
	/datum/species/dracon,\
	/datum/species/anthromorph,\
	/datum/species/demihuman,\
	/datum/species/construct/metal,\
)
