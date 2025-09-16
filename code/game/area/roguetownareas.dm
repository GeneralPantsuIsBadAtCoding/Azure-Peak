GLOBAL_LIST_EMPTY(chosen_music)

GLOBAL_LIST_INIT(roguetown_areas_typecache, typecacheof(/area/rogue/indoors/town,/area/rogue/outdoors/town,/area/rogue/under/town)) //hey

/area/rogue
	name = "roguetown"
	icon_state = "rogue"
	has_gravity = STANDARD_GRAVITY
	ambientsounds = null
	always_unpowered = TRUE
	poweralm = FALSE
	power_environ = TRUE
	power_equip = TRUE
	power_light = TRUE
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	requires_power = FALSE
//	var/previous_ambient = ""
	var/town_area = FALSE
	var/keep_area = FALSE
	var/tavern_area = FALSE
	var/warden_area = FALSE
	var/holy_area = FALSE
	var/cell_area = FALSE
	var/ceiling_protected = FALSE //Prevents tunneling into these from above

/area/rogue/Entered(mob/living/carbon/human/guy)
	. = ..()
	if((src.town_area == TRUE) && HAS_TRAIT(guy, TRAIT_GUARDSMAN) && !guy.has_status_effect(/datum/status_effect/buff/guardbuffone)) //man at arms
		guy.apply_status_effect(/datum/status_effect/buff/guardbuffone)
	if((src.tavern_area == TRUE) && HAS_TRAIT(guy, TRAIT_TAVERN_FIGHTER) && !guy.has_status_effect(/datum/status_effect/buff/barkeepbuff)) // THE FIGHTER
		guy.apply_status_effect(/datum/status_effect/buff/barkeepbuff)
	if((src.warden_area == TRUE) && HAS_TRAIT(guy, TRAIT_WOODSMAN) && !guy.has_status_effect(/datum/status_effect/buff/wardenbuff)) // Warden
		guy.apply_status_effect(/datum/status_effect/buff/wardenbuff)
	if((src.cell_area == TRUE) && HAS_TRAIT(guy, TRAIT_DUNGEONMASTER) && !guy.has_status_effect(/datum/status_effect/buff/dungeoneerbuff)) // Dungeoneer
		guy.apply_status_effect(/datum/status_effect/buff/dungeoneerbuff)
	if((src.holy_area == TRUE) && HAS_TRAIT(guy, TRAIT_UNDIVIDED)) // get a long-lingering mood buff so long as we visit the church daily as Undivided.
		guy.add_stress(/datum/stressevent/seeblessed)

/area/rogue/indoors
	name = "indoors rt"
	icon_state = "indoors"
	ambientrain = RAIN_IN
	ambientsounds = AMB_INGEN
	ambientnight = AMB_INGEN
	spookysounds = SPOOKY_GEN
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/towngen.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	soundenv = 2
	plane = INDOOR_PLANE
	converted_type = /area/rogue/outdoors

/area/rogue/indoors/banditcamp
	name = "bandit camp indoors"
	droning_sound = 'sound/music/area/banditcamp.ogg'
	droning_sound_dusk = 'sound/music/area/banditcamp.ogg'
	droning_sound_night = 'sound/music/area/banditcamp.ogg'


/area/rogue/indoors/ravoxarena
	name = "ravox arena"
	deathsight_message = "an arena of justice"

/area/rogue/indoors/ravoxarena/can_craft_here()
	return FALSE

/area/rogue/indoors/ravoxarena/proc/cleanthearena(var/turf/returnzone)
	for(var/obj/item/trash in src)
		do_teleport(trash, returnzone)
	GLOB.arenafolks.len = list()

/area/rogue/indoors/eventarea
	name = "eventarea"
	deathsight_message = "a place shielded from mortal eyes"

///// OUTDOORS AREAS //////

/area/rogue/outdoors
	name = "outdoors roguetown"
	icon_state = "outdoors"
	outdoors = TRUE
	ambientrain = RAIN_OUT
//	ambientsounds = list('sound/ambience/wamb.ogg')
	ambientsounds = AMB_TOWNDAY
	ambientnight = AMB_TOWNNIGHT
	spookysounds = SPOOKY_CROWS
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/rogue/indoors/shelter
	soundenv = 16
	deathsight_message = "somewhere in the wilds"

/area/rogue/outdoors/banditcamp
	name = "bandit camp outdoors"
	droning_sound = 'sound/music/area/banditcamp.ogg'
	droning_sound_dusk = 'sound/music/area/banditcamp.ogg'
	droning_sound_night = 'sound/music/area/banditcamp.ogg'
	deathsight_message = "somewhere in the wilds"

/area/rogue/indoors/shelter
	icon_state = "shelter"
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	deathsight_message = "somewhere in the wilds, under a roof"

/area/rogue/outdoors/mountains
	name = "mountains"
	icon_state = "mountains"
	ambientsounds = AMB_MOUNTAIN
	ambientnight = AMB_MOUNTAIN
	spookysounds = SPOOKY_GEN
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	warden_area = TRUE
	soundenv = 17
	converted_type = /area/rogue/indoors/shelter/mountains
	deathsight_message = "a twisted tangle of soaring peaks"
	// I SURE HOPE NO ONE USE THIS HUH


/area/rogue/indoors/shelter/mountains
	icon_state = "mountains"
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	deathsight_message = "a twisted tangle of soaring peaks"

/area/rogue/outdoors/rtfield
	name = "Azure Basin"
	icon_state = "rtfield"
	soundenv = 19
	ambush_times = list("night")
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf/bobcat = 20,
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 30,
				/mob/living/simple_animal/hostile/retaliate/rogue/fox = 30,
				/mob/living/carbon/human/species/skeleton/npc/supereasy = 30)
	first_time_text = "AZURE BASIN"
	droning_sound = 'sound/music/area/field.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/rogue/indoors/shelter/rtfield
	deathsight_message = "somewhere in the wilds, next to towering walls"
	warden_area = TRUE
	threat_region = THREAT_REGION_AZURE_BASIN

/area/rogue/indoors/shelter/rtfield
	icon_state = "rtfield"
	droning_sound = 'sound/music/area/field.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'

/area/rogue/outdoors/rtfield/eora
	name = "Eoran Shrine"
	icon_state = "eora"
	soundenv = 19
	ambush_times = list("night")
	first_time_text = "EORAN SHRINE"
	droning_sound = 'sound/newmusic/lovecraft2.ogg'
	droning_sound_dusk = 'sound/newmusic/lovecraft2.ogg'
	droning_sound_night = 'sound/newmusic/lovecraft2.ogg'
	converted_type = /area/rogue/indoors/shelter/rtfield
	deathsight_message = "somewhere high up in a mountains, where cherry blossoms bloom"

/area/rogue/outdoors/abisland
	name = "abyssors grasp"
	icon_state = "island"
	ambientsounds = AMB_ABISLAND
	ambientnight = AMB_ABISLAND
	droning_sound = 'sound/music/area/morosewaters.ogg'
	droning_sound_dusk = 'sound/music/area/morosewaters.ogg'
	droning_sound_night = 'sound/music/area/angrywaters.ogg'
	ambush_mobs = list(
		/mob/living/simple_animal/hostile/rogue/deepone = 50,
		/mob/living/simple_animal/hostile/rogue/deepone/spit = 30
	)
	first_time_text = "ABYSSOR'S GRASP"
	deathsight_message = "amidst abyssor's"

//// UNDER AREAS (no indoor rain sound usually)

// these don't get a rain sound because they're underground
/area/rogue/under
	name = "basement"
	icon_state = "under"
	droning_sound = 'sound/music/area/towngen.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	soundenv = 8
	plane = INDOOR_PLANE
	converted_type = /area/rogue/outdoors/exposed
/area/rogue/outdoors/exposed
	icon_state = "exposed"
	droning_sound = 'sound/music/area/towngen.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'

/area/rogue/under/cave
	name = "cave"
	warden_area = TRUE
	icon_state = "cave"
	ambientsounds = AMB_GENCAVE
	ambientnight = AMB_GENCAVE
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambush_times = list("night","dawn","dusk","day")
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 30,
				/mob/living/carbon/human/species/goblin/npc/ambush/cave = 20,
				/mob/living/carbon/human/species/skeleton/npc/ambush = 10,
				/mob/living/carbon/human/species/human/northern/highwayman/ambush = 5,
				/mob/living/simple_animal/hostile/retaliate/rogue/direbear = 5,
				/mob/living/simple_animal/hostile/retaliate/rogue/minotaur = 5)
	converted_type = /area/rogue/outdoors/caves
/area/rogue/outdoors/caves
	icon_state = "caves"
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/cave/spider
	icon_state = "spider"
	first_time_text = "ARAIGNÉE"
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/spider = 100)
	droning_sound = 'sound/music/area/spidercave.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/spidercave

/area/rogue/outdoors/spidercave
	icon_state = "spidercave"
	droning_sound = 'sound/music/area/spidercave.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/spiderbase
	name = "spiderbase"
	ambientsounds = AMB_BASEMENT
	ambientnight = AMB_BASEMENT
	icon_state = "spiderbase"
	droning_sound = 'sound/music/area/spidercave.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/spidercave

/area/rogue/outdoors/spidercave
	icon_state = "spidercave"
	droning_sound = 'sound/music/area/spidercave.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/cavelava
	name = "cavelava"
	icon_state = "cavelava"
	first_time_text = "MOUNT DECAPITATION"
	ambientsounds = AMB_CAVELAVA
	ambientnight = AMB_CAVELAVA
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	ambush_times = list("night","dawn","dusk","day")
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 10,
				/mob/living/carbon/human/species/skeleton/npc/ambush = 20,
				/mob/living/carbon/human/species/goblin/npc/hell = 25,
				/mob/living/simple_animal/hostile/retaliate/rogue/minotaur = 15)
	droning_sound = 'sound/music/area/decap.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/decap

/area/rogue/outdoors/exposed/decap
	icon_state = "decap"
	droning_sound = 'sound/music/area/decap.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/lake
	name = "underground lake"
	icon_state = "lake"
	ambientsounds = AMB_BEACH
	ambientnight = AMB_BEACH
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_GEN

/area/rogue/under/cave/dungeon1
	name = "smalldungeon1"
	icon_state = "spider"
	droning_sound = 'sound/music/area/dungeon.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/dungeon1

/area/rogue/under/cave/licharena
	name = "licharena"
	icon_state = "under"
	first_time_text = "LICH'S DOMAIN"
	droning_sound = 'sound/music/area/dragonden.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/dungeon1
	ceiling_protected = TRUE

/area/rogue/under/cave/licharena/bossroom
	name = "licharenaboss"
	first_time_text = "THE LICH"

/area/rogue/under/cave/licharena/bossroom/can_craft_here()
	return FALSE

/area/rogue/under/cave/his_vault
	name = "his_vault"
	icon_state = "under"
	first_time_text = "HIS VAULT"
	droning_sound = 'sound/music/area/dragonden.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/dungeon1
	ceiling_protected = TRUE

/area/rogue/under/cave/his_vault/one
	first_time_text = "PSLM 89:99"

/area/rogue/under/cave/his_vault/one/can_craft_here()
	return FALSE

/area/rogue/under/cave/his_vault/two
	first_time_text = "PSLM 71:6"

/area/rogue/under/cave/his_vault/two/can_craft_here()
	return FALSE

/area/rogue/under/cave/his_vault/three
	first_time_text = "PSY 66:2"

/area/rogue/under/cave/his_vault/three/can_craft_here()
	return FALSE

/area/rogue/under/cave/his_vault/four
	first_time_text = "PSY 1:4"

/area/rogue/under/cave/his_vault/four/can_craft_here()
	return FALSE

/area/rogue/under/cave/his_vault/puzzle
	first_time_text = "NODD 8:14"

/area/rogue/under/cave/his_vault/puzzle/can_craft_here()
	return FALSE

/area/rogue/under/cave/undeadmanor
	name = "skelemansion"
	icon_state = "spidercave"
	first_time_text = "ABANDONED MANOR"
	droning_sound = 'sound/music/area/dungeon2.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/dungeon1
	ceiling_protected = TRUE

/area/rogue/outdoors/dungeon1
	name = "smalldungeonoutdoors"
	icon_state = "spidercave"
	droning_sound = 'sound/music/area/dungeon.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ceiling_protected = TRUE

/area/rogue/under/cave/inhumen
	name = "inhumen"
	icon_state = "cave"
	first_time_text = "FORSAKEN CATHEDRAL"
	droning_sound = 'sound/music/unholy.ogg'
	droning_sound_dusk = 'sound/music/unholy.ogg'
	droning_sound_night = 'sound/music/unholy.ogg'
	converted_type = /area/rogue/outdoors/dungeon1

/area/rogue/under/cave/fishmandungeon //idk what the fish guys are called in lore
	name = "fishmandungeon"
	icon_state = "under"
	first_time_text = "INVASION STAGING AREA"
	droning_sound = 'sound/music/area/dungeon.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/dungeon1
	ceiling_protected = TRUE

//////
/////
////     TOWN AREAS
////
///
//



/area/rogue/indoors/town
	name = "indoors"
	icon_state = "town"
	droning_sound = 'sound/music/area/towngen.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/rogue/outdoors/exposed/town
	town_area = TRUE
	deathsight_message = "the city of Azure Peak and all its bustling souls"

/area/rogue/outdoors/exposed/town
	icon_state = "town"
	droning_sound = 'sound/music/area/towngen.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'

/area/rogue/outdoors/exposed/town/keep
	name = "Keep"
	icon_state = "manor"
	droning_sound = 'sound/music/area/manorgarri.ogg'
	keep_area = TRUE
	town_area = TRUE

/area/rogue/outdoors/exposed/town/keep/unbuildable
	name = "Keep unbuildable"

/area/rogue/outdoors/exposed/town/keep/unbuildable/can_craft_here()
	return FALSE

/area/rogue/indoors/town/manor
	name = "Manor"
	icon_state = "manor"
	droning_sound = list('sound/music/area/manor.ogg', 'sound/music/area/manor2.ogg')
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/manorgarri
	first_time_text = "THE KEEP OF AZURE PEAK"
	keep_area = TRUE

/area/rogue/outdoors/exposed/manorgarri
	icon_state = "manorgarri"
	droning_sound = 'sound/music/area/manorgarri.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	keep_area = TRUE

/area/rogue/indoors/town/magician
	name = "Wizard's Tower"
	icon_state = "magician"
	spookysounds = SPOOKY_MYSTICAL
	spookynight = SPOOKY_MYSTICAL
	droning_sound = 'sound/music/area/magiciantower.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/magiciantower
	keep_area = TRUE

/area/rogue/outdoors/exposed/magiciantower
	icon_state = "magiciantower"
	droning_sound = 'sound/music/area/magiciantower.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	keep_area = TRUE

/area/rogue/indoors/town/shop
	name = "Shop"
	icon_state = "shop"
	droning_sound = 'sound/music/area/shop.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/shop
/area/rogue/outdoors/exposed/shop
	icon_state = "shop"
	droning_sound = 'sound/music/area/shop.ogg'

/area/rogue/indoors/town/steward
	name = "Steward"
	icon_state = "steward"
	droning_sound = 'sound/music/area/shop.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/indoors/town/physician
	name = "Physician"
	icon_state = "physician"
	droning_sound = 'sound/music/area/shop.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/indoors/town/bath
	name = "Baths"
	icon_state = "bath"
	droning_sound = 'sound/music/area/bath.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/bath
/area/rogue/outdoors/exposed/bath
	icon_state = "bath"
	droning_sound = 'sound/music/area/bath.ogg'

/area/rogue/outdoors/exposed/bath/vault
	name = "Bathmaster vault"
	icon_state = "bathvault"
	ceiling_protected = TRUE

/area/rogue/indoors/town/garrison
	name = "Garrison"
	icon_state = "garrison"
	droning_sound = 'sound/music/area/manorgarri.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/manorgarri
	keep_area = TRUE

/area/rogue/indoors/town/cell
	name = "dungeon cell"
	icon_state = "cell"
	spookysounds = SPOOKY_DUNGEON
	spookynight = SPOOKY_DUNGEON
	droning_sound = 'sound/music/area/manorgarri.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/manorgarri
	keep_area = TRUE
	cell_area = TRUE

/area/rogue/indoors/town/tavern
	name = "tavern"
	icon_state = "tavern"
	ambientsounds = AMB_INGEN
	ambientnight = AMB_INGEN
	droning_sound = 'sound/silence.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/tavern
	tavern_area = TRUE
/area/rogue/outdoors/exposed/tavern
	icon_state = "tavern"
	droning_sound = 'sound/silence.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	tavern_area = TRUE

/area/rogue/indoors/town/church
	name = "church"
	icon_state = "church"
	droning_sound = 'sound/music/area/church.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	holy_area = TRUE
	droning_sound_dawn = 'sound/music/area/churchdawn.ogg'
	converted_type = /area/rogue/outdoors/exposed/church
	deathsight_message = "a hallowed place, sworn to the Ten"

/area/rogue/outdoors/exposed/church
	icon_state = "church"
	droning_sound = 'sound/music/area/church.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	droning_sound_dawn = 'sound/music/area/churchdawn.ogg'
	deathsight_message = "a hallowed place, sworn to the Ten"

/area/rogue/indoors/town/church/chapel
	icon_state = "chapel"
	first_time_text = "THE HOUSE OF THE TEN"

/area/rogue/indoors/town/church/basement
	icon_state = "church"
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "THE CRYPT OF THE TEN"

/area/rogue/indoors/town/fire_chamber
	name = "incinerator"
	icon_state = "fire_chamber"

/area/rogue/indoors/town/warehouse
	name = "dock warehouse import"
	icon_state = "warehouse"

/area/rogue/indoors/inq
	name = "The Inquisition"
	icon_state = "chapel"
	first_time_text = "THE OTAVAN INQUISITION"

/area/rogue/indoors/inq/office
	name = "The Inquisitor's Office"
	icon_state = "chapel"

/area/rogue/indoors/inq/basement
	name = "The Inquisition's Basement"
	icon_state = "chapel"

/area/rogue/indoors/town/warehouse/can_craft_here()
	return FALSE

/area/rogue/indoors/inq/import
	name = "foreign imports"
	icon_state = "warehouse"

/area/rogue/indoors/inq/import/can_craft_here()
	return FALSE

/area/rogue/indoors/town/vault
	name = "vault"
	icon_state = "vault"
	keep_area = TRUE
/area/rogue/indoors/town/entrance
	first_time_text = "Roguetown"
	icon_state = "entrance"

/area/rogue/indoors/town/dwarfin
	name = "The Guild of Craft"
	icon_state = "dwarfin"
	droning_sound = 'sound/music/area/dwarf.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "AZUREAN GUILD OF CRAFT"
	converted_type = /area/rogue/outdoors/exposed/dwarf

/area/rogue/outdoors/exposed/dwarf
	icon_state = "dwarf"
	droning_sound = 'sound/music/area/dwarf.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

///// outside

/area/rogue/outdoors/town
	name = "outdoors"
	icon_state = "town"
	soundenv = 16
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/rogue/indoors/shelter/town
	first_time_text = "THE CITY OF AZURE PEAK"
	town_area = TRUE

/area/rogue/indoors/shelter/town
	icon_state = "town"
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'


/area/rogue/outdoors/town/sargoth
	name = "outdoors"
	icon_state = "sargoth"
	soundenv = 16
	droning_sound = 'sound/music/area/sargoth.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/indoors/shelter/town/sargoth
	first_time_text = "SARGOTH"
/area/rogue/indoors/shelter/town/sargoth
	icon_state = "sargoth"
	droning_sound = 'sound/music/area/sargoth.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "SARGOTH"

/area/rogue/outdoors/town/roofs
	name = "roofs"
	icon_state = "roofs"
	ambientsounds = AMB_MOUNTAIN
	ambientnight = AMB_MOUNTAIN
	spookysounds = SPOOKY_GEN
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/field.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	soundenv = 17
	converted_type = /area/rogue/indoors/shelter/town/roofs

/area/rogue/outdoors/town/roofs/keep
	name = "Keep Rooftops"
	icon_state = "manor"
	keep_area = TRUE
	town_area = TRUE

/area/rogue/indoors/shelter/town/roofs
	icon_state = "roofs"
	droning_sound = 'sound/music/area/field.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'

/area/rogue/outdoors/town/dwarf
	name = "dwarven quarter"
	icon_state = "dwarf"
	droning_sound = 'sound/music/area/dwarf.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "The Dwarven Quarter"
	soundenv = 16
	converted_type = /area/rogue/indoors/shelter/town/dwarf
/area/rogue/indoors/shelter/town/dwarf
	icon_state = "dwarf"
	droning_sound = 'sound/music/area/dwarf.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/// under


/area/rogue/under/town
	name = "basement"
	icon_state = "town"
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/under/town
/area/rogue/outdoors/exposed/under/town
	icon_state = "town"
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/town/sewer
	name = "sewer"
	icon_state = "sewer"
	ambientsounds = AMB_CAVEWATER
	ambientnight = AMB_CAVEWATER
	spookysounds = SPOOKY_RATS
	spookynight = SPOOKY_RATS
	droning_sound = 'sound/music/area/sewers.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambientrain = RAIN_SEWER
	soundenv = 21
	converted_type = /area/rogue/outdoors/exposed/under/sewer
/area/rogue/outdoors/exposed/under/sewer
	icon_state = "sewer"
	droning_sound = 'sound/music/area/sewers.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/town/caverogue
	name = "miningcave (roguetown)"
	icon_state = "caverogue"
	ambientsounds = AMB_GENCAVE
	ambientnight = AMB_GENCAVE
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/under/caves
/area/rogue/outdoors/exposed/under/caves
	icon_state = "caves"
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/town/basement
	name = "basement"
	icon_state = "basement"
	ambientsounds = AMB_BASEMENT
	ambientnight = AMB_BASEMENT
	spookysounds = SPOOKY_DUNGEON
	spookynight = SPOOKY_DUNGEON
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	soundenv = 5
	town_area = TRUE
	converted_type = /area/rogue/outdoors/exposed/under/basement

/area/rogue/under/town/basement/keep
	name = "keep basement"
	icon_state = "basement"
	keep_area = TRUE
	town_area = TRUE
	ceiling_protected = TRUE

/area/rogue/outdoors/exposed/under/basement
	icon_state = "basement"
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

// underworld
/area/rogue/underworld
	name = "underworld"
	icon_state = "underworld"
	droning_sound = 'sound/music/area/underworlddrone.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "The Forest of Repentence"

/area/rogue/underworld/dream
	name = "dream realm"
	icon_state = "dream"
	first_time_text = "Abyssal Dream"
