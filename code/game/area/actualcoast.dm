// Actual coastal coastal area
/area/rogue/outdoors/beach
	name = "Central Coast"
	icon_state = "beach"
	warden_area = TRUE
	ambientsounds = AMB_BEACH
	ambientnight = AMB_BEACH
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/rogue/under/lake
	first_time_text = "CENTRAL COAST"

/area/rogue/outdoors/beach/north
	name = "Northern Coast"
	ambush_types = list(
		/turf/open/floor/rogue/dirt,
		/turf/open/floor/rogue/grass,
		/turf/open/floor/rogue/AzureSand)
	ambush_mobs = list(
		/mob/living/carbon/human/species/human/northern/searaider/ambush = 10,
		/mob/living/carbon/human/species/goblin/npc/ambush/sea = 20,
		/mob/living/simple_animal/hostile/retaliate/rogue/mossback = 40
	)
	first_time_text = "NORTHERN COAST"

/area/rogue/outdoors/beach/south
	name = "Southern Coast"
	ambush_types = list(
			/turf/open/floor/rogue/dirt,
			/turf/open/floor/rogue/grass,
			/turf/open/floor/rogue/AzureSand)
	ambush_mobs = list(
		/mob/living/carbon/human/species/human/northern/searaider/ambush = 5,
		/mob/living/carbon/human/species/goblin/npc/ambush/sea = 20,
		/mob/living/simple_animal/hostile/retaliate/rogue/mossback = 10,
		new /datum/ambush_config/triple_deepone = 30,
		new /datum/ambush_config/deepone_party = 20,
	)
	first_time_text = "SOUTHERN COAST"
