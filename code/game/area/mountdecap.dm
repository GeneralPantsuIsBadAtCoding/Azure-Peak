// Areas for Mount Decap
/area/rogue/outdoors/mountains/decap
	name = "mt decapitation"
	icon_state = "decap"
	ambush_types = list(
				/turf/open/floor/rogue/dirt,
				/turf/open/floor/rogue/dirt/road,
				/turf/open/floor/rogue/snow,
				/turf/open/floor/rogue/grasscold,
				/turf/open/floor/rogue/grass,
				)
	ambush_mobs = list(
				new /datum/ambush_config/pair_of_direbear = 10,
				new /datum/ambush_config/trio_of_highwaymen = 10,
				new /datum/ambush_config/singular_minotaur = 10,
				new /datum/ambush_config/duo_minotaur = 5,
				new /datum/ambush_config/solo_treasure_hunter = 15,
				new /datum/ambush_config/duo_treasure_hunter = 2,
				new /datum/ambush_config/medium_skeleton_party = 10,
				new /datum/ambush_config/heavy_skeleton_party = 5,
				)
	droning_sound = 'sound/music/area/decap.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "MOUNT DECAPITATION"
	ambush_times = list("night","dawn","dusk","day")
	converted_type = /area/rogue/indoors/shelter/mountains/decap
	deathsight_message = "a twisted tangle of soaring peaks"

/area/rogue/indoors/shelter/mountains/decap
	icon_state = "decap"
	droning_sound = 'sound/music/area/decap.ogg'
	droning_sound_dusk = null
	droning_sound_night = null


/area/rogue/outdoors/mountains/decap/stepbelow
	name = "Tarichea - Valley of Loss"
	icon_state = "decap"
	ambush_types = list(
				/turf/open/floor/rogue/dirt,
				/turf/open/floor/rogue/dirt/road,
				/turf/open/floor/rogue/snow,
				/turf/open/floor/rogue/grasscold,
				/turf/open/floor/rogue/grass,
				)
	ambush_mobs = list(
				new /datum/ambush_config/pair_of_direbear = 10,
				new /datum/ambush_config/trio_of_highwaymen = 10,
				new /datum/ambush_config/singular_minotaur = 10,
				new /datum/ambush_config/duo_minotaur = 5,
				new /datum/ambush_config/solo_treasure_hunter = 5,
				new /datum/ambush_config/duo_treasure_hunter = 1,
				new /datum/ambush_config/medium_skeleton_party = 20,
				new /datum/ambush_config/heavy_skeleton_party = 10,
				)
	droning_sound = 'sound/music/area/decap_deeper.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "TARICHEA, VALLEY OF LOSS"
	ambush_times = list("night","dawn","dusk","day")
	converted_type = /area/rogue/indoors/shelter/mountains/decap

/area/rogue/outdoors/mountains/decap/gunduzirak
	name = "Gundu Zirak"
	icon_state = "decap"
	ambush_types = list(
				/turf/open/floor/rogue/dirt,
				/turf/open/floor/rogue/cobble,
				)
	ambush_mobs = list(
				new /datum/ambush_config/treasure_hunter_posse = 1,
				/mob/living/carbon/human/species/dwarfskeleton/ambush = 30,
				)
	droning_sound = 'sound/music/area/prospector.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "RUINS OF GUNDU-ZIRAK"
	ambush_times = list("night","dawn","dusk","day")
	converted_type = /area/rogue/indoors/shelter/mountains/decap
	ceiling_protected = TRUE

/area/rogue/under/cave/dragonden
	name = "dragonnest"
	icon_state = "under"
	first_time_text = "DEN OF DRAGONS"
	droning_sound = 'sound/music/area/dragonden.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/dungeon1
	ceiling_protected = TRUE
	deathsight_message = "a twisted tangle of soaring peaks"

/area/rogue/under/cave/goblinfort
	name = "goblinfort"
	icon_state = "spidercave"
	first_time_text = "GOBLIN FORTRESS"
	droning_sound = 'sound/music/area/dungeon2.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/dungeon1
	ceiling_protected = TRUE
	deathsight_message = "a twisted tangle of soaring peaks"

/area/rogue/under/cave/scarymaze
	name = "hauntedlabyrinth"
	icon_state = "spidercave"
	first_time_text = "NECRAN LABYRINTH"
	droning_sound = 'sound/music/area/underworlddrone.ogg'
	droning_sound_dusk = 'sound/music/area/underworlddrone.ogg'
	droning_sound_night = 'sound/music/area/underworlddrone.ogg'
	converted_type = /area/rogue/outdoors/dungeon1
	ceiling_protected = TRUE
	deathsight_message = "a twisted tangle of soaring peaks"
