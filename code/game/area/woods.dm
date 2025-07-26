// Azure Grove - the areas to the south of the map

/area/rogue/outdoors/woods
	name = "The Azure Grove"
	icon_state = "woods"
	ambientsounds = AMB_FORESTDAY
	ambientnight = AMB_FORESTNIGHT
	spookysounds = SPOOKY_CROWS
	spookynight = SPOOKY_FOREST
	droning_sound = 'sound/music/area/forest.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/forestnight.ogg'
	soundenv = 15
	warden_area = TRUE
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/floor/rogue/dirt,
				/turf/open/floor/rogue/grass)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 40,
				/mob/living/carbon/human/species/skeleton/npc/ambush = 10,
				/mob/living/carbon/human/species/goblin/npc/ambush = 30,
				/mob/living/carbon/human/species/human/northern/highwayman/ambush = 30)
	first_time_text = "THE AZURE GROVE"
	converted_type = /area/rogue/indoors/shelter/woods
	deathsight_message = "somewhere in the wilds"

/area/rogue/indoors/shelter/woods
	name = "Azure Grove"
	icon_state = "woods"
	droning_sound = 'sound/music/area/forest.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/forestnight.ogg'

/area/rogue/outdoors/woods/northwest
	name = "Azure Grove - Northwest"

/area/rogue/outdoors/woods/north
	name = "Azure Grove - North"

/area/rogue/outdoors/woods/northeast
	name = "Azure Grove - Northeast"

/area/rogue/outdoors/woods/southeast
	name = "Azure Grove - Southeast"

/area/rogue/outdoors/woods/south
	name = "Azure Grove - South"

/area/rogue/outdoors/woods/southwest
	name = "Azure Grove - Southwest"

