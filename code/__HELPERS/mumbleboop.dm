//Handles random voice assigns based on gender.
/proc/random_voice_type(gender)
	switch(gender)
		if(MALE)
			return pick(GLOB.male_voice_type_list)
		if(FEMALE)
			return pick(GLOB.female_voice_type_list)
		if(PLURAL)
			return pick(GLOB.all_voice_type_list)

GLOBAL_LIST_INIT(male_voice_type_list, sort_list(list(
	"male_01",
	"male_02",
	"male_03",
	"male_04",
	"male_05",
	"male_06",
	"male_07",
	"neutral_01",
	)))

GLOBAL_LIST_INIT(female_voice_type_list, sort_list(list(
	"female_01",
	"female_02",
	"female_03",
	"female_04",
	"female_05",
	"female_06",
	"female_07",
	"neutral_01",
	)))

GLOBAL_LIST_INIT(all_voice_type_list, sort_list(list(
	"neutral_01",
	"male_01",
	"male_02",
	"male_03",
	"male_04",
	"male_05",
	"male_06",
	"male_07",
	"female_01",
	"female_02",
	"female_03",
	"female_04",
	"female_05",
	"female_06",
	"female_07",
)))
