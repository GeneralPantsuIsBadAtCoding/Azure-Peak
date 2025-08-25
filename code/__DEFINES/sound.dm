//max channel is 1024. Only go lower from here, because byond tends to pick the first availiable channel to play sounds on
#define CHANNEL_LOBBYMUSIC 1024
#define CHANNEL_ADMIN 1023 //USED FOR MUSIC
#define CHANNEL_VOX 1022
#define CHANNEL_JUKEBOX 1021
#define CHANNEL_JUSTICAR_ARK 1020
#define CHANNEL_HEARTBEAT 1019 //sound channel for heartbeats
#define CHANNEL_AMBIENCE 1018
#define CHANNEL_BUZZ 1017
#define CHANNEL_BICYCLE 1016
#define CHANNEL_RAIN 1015
#define CHANNEL_MUSIC 1014
#define CHANNEL_CMUSIC 1013
#define CHANNEL_WEATHER 1012

//THIS SHOULD ALWAYS BE THE LOWEST ONE!
//KEEP IT UPDATED

#define CHANNEL_HIGHEST_AVAILABLE 1011
#define SOUND_MINIMUM_PRESSURE 10
#define FALLOFF_SOUNDS 1

///Percentage of sound's range where no falloff is applied
#define SOUND_DEFAULT_FALLOFF_DISTANCE 1 //For a normal sound this would be 1 tile of no falloff
///The default exponent of sound falloff
#define SOUND_FALLOFF_EXPONENT 6
/// When a sound is from a non-visible source, add this many turfs to the distance between the source and the hearer
#define SOUND_OCCLUSION_DISTANCE_MODIFIER 4

//Sound enviorments: Determines how reverb sounds and how sounds carry over enviorments.
//default byond sound environments
#define SOUND_ENVIRONMENT_NONE -1
#define SOUND_ENVIRONMENT_GENERIC 0
#define SOUND_ENVIRONMENT_PADDED_CELL 1
#define SOUND_ENVIRONMENT_ROOM 2
#define SOUND_ENVIRONMENT_BATHROOM 3
#define SOUND_ENVIRONMENT_LIVINGROOM 4
#define SOUND_ENVIRONMENT_STONEROOM 5
#define SOUND_ENVIRONMENT_AUDITORIUM 6
#define SOUND_ENVIRONMENT_CONCERT_HALL 7
#define SOUND_ENVIRONMENT_CAVE 8
#define SOUND_ENVIRONMENT_ARENA 9
#define SOUND_ENVIRONMENT_HANGAR 10
#define SOUND_ENVIRONMENT_CARPETED_HALLWAY 11
#define SOUND_ENVIRONMENT_HALLWAY 12
#define SOUND_ENVIRONMENT_STONE_CORRIDOR 13
#define SOUND_ENVIRONMENT_ALLEY 14
#define SOUND_ENVIRONMENT_FOREST 15
#define SOUND_ENVIRONMENT_CITY 16
#define SOUND_ENVIRONMENT_MOUNTAINS 17
#define SOUND_ENVIRONMENT_QUARRY 18
#define SOUND_ENVIRONMENT_PLAIN 19
#define SOUND_ENVIRONMENT_PARKING_LOT 20
#define SOUND_ENVIRONMENT_SEWER_PIPE 21
#define SOUND_ENVIRONMENT_UNDERWATER 22
#define SOUND_ENVIRONMENT_DRUGGED 23
#define SOUND_ENVIRONMENT_DIZZY 24
#define SOUND_ENVIRONMENT_PSYCHOTIC 25
//If we ever make custom ones add them here
#define SOUND_ENVIROMENT_PHASED list(1.8, 0.5, -1000, -4000, 0, 5, 0.1, 1, -15500, 0.007, 2000, 0.05, 0.25, 1, 1.18, 0.348, -5, 2000, 250, 0, 3, 100, 63)

//"sound areas": easy way of keeping different types of areas consistent.
#define SOUND_AREA_STANDARD_ENCLOSED SOUND_ENVIRONMENT_STONEROOM
#define SOUND_AREA_LARGE_ENCLOSED SOUND_ENVIRONMENT_HANGAR
#define SOUND_AREA_SMALL_ENCLOSED SOUND_ENVIRONMENT_BATHROOM
#define SOUND_AREA_TUNNEL_ENCLOSED SOUND_ENVIRONMENT_CAVE
#define SOUND_AREA_LARGE_SOFTFLOOR SOUND_ENVIRONMENT_CARPETED_HALLWAY
#define SOUND_AREA_MEDIUM_SOFTFLOOR SOUND_ENVIRONMENT_LIVINGROOM
#define SOUND_AREA_SMALL_SOFTFLOOR SOUND_ENVIRONMENT_ROOM
#define SOUND_AREA_ASTEROID SOUND_ENVIRONMENT_CAVE
#define SOUND_AREA_SPACE SOUND_ENVIRONMENT_UNDERWATER
#define SOUND_AREA_ICEMOON SOUND_ENVIRONMENT_CAVE
#define SOUND_AREA_WOODFLOOR SOUND_ENVIRONMENT_CITY

//Ambience types
#define GENERIC list('sound/blank.ogg',\
								'sound/blank.ogg',\
								'sound/blank.ogg',\
								'sound/blank.ogg',\
								'sound/blank.ogg',\
								'sound/blank.ogg')

#define HOLY list('sound/blank.ogg',\
										'sound/blank.ogg',\
										'sound/blank.ogg')

#define HIGHSEC list('sound/blank.ogg')

#define RUINS list('sound/blank.ogg',\
									'sound/blank.ogg',\
									'sound/blank.ogg',\
									'sound/blank.ogg',\
									'sound/blank.ogg')

#define ENGINEERING list('sound/blank.ogg',\
										'sound/blank.ogg')

#define MINING list('sound/blank.ogg',\
											'sound/blank.ogg',\
											'sound/blank.ogg',\
											'sound/blank.ogg')

#define MEDICAL list('sound/blank.ogg')

#define SPOOKY list('sound/blank.ogg',\
										'sound/blank.ogg')

#define SPACE list('sound/blank.ogg')

#define MAINTENANCE list('sound/blank.ogg',\
											'sound/blank.ogg' )

#define AWAY_MISSION list('sound/blank.ogg',\
									'sound/blank.ogg',\
									'sound/blank.ogg',\
									'sound/blank.ogg',\
									'sound/blank.ogg')

#define REEBE list('sound/blank.ogg')



#define CREEPY_SOUNDS list('sound/blank.ogg',\
	'sound/blank.ogg',\
	'sound/blank.ogg',\
	'sound/blank.ogg',\
	'sound/blank.ogg')


#define RAIN_IN list('sound/ambience/rainin.ogg')

#define RAIN_SEWER list('sound/ambience/rainsewer.ogg')

#define RAIN_OUT list('sound/ambience/rainout.ogg')

#define AMB_GENCAVE list('sound/ambience/cave.ogg')

#define AMB_TOWNDAY list('sound/ambience/townday.ogg')

#define AMB_MOUNTAIN list('sound/ambience/MOUNTAIN (1).ogg',\
						'sound/ambience/MOUNTAIN (2).ogg')

#define AMB_TOWNNIGHT list('sound/ambience/townnight (1).ogg',\
						'sound/ambience/townnight (2).ogg',\
						'sound/ambience/townnight (3).ogg')

#define AMB_BOGDAY list('sound/ambience/bogday (1).ogg',\
						'sound/ambience/bogday (2).ogg',\
						'sound/ambience/bogday (3).ogg')

#define AMB_BOGNIGHT list('sound/ambience/bognight.ogg')

#define AMB_FORESTDAY list('sound/ambience/forestday.ogg')

#define AMB_ABISLAND list('sound/ambience/waves.ogg')

#define AMB_FORESTNIGHT list('sound/ambience/forestnight.ogg')

#define AMB_INGEN list('sound/ambience/indoorgen.ogg')


#define AMB_BASEMENT list('sound/ambience/basement.ogg')

#define AMB_JUNGLENIGHT list('sound/ambience/jungleday.ogg')

#define AMB_JUNGLEDAY list('sound/ambience/jungleday.ogg')

#define AMB_BEACH list('sound/ambience/lake (1).ogg',\
						'sound/ambience/lake (2).ogg',\
						'sound/ambience/lake (3).ogg')

#define AMB_BOAT list('sound/ambience/boat (1).ogg',\
						'sound/ambience/boat (2).ogg')

#define AMB_RIVERDAY list('sound/ambience/riverday (1).ogg',\
						'sound/ambience/riverday (2).ogg',\
						'sound/ambience/riverday (3).ogg')

#define AMB_RIVERNIGHT list('sound/ambience/rivernight (1).ogg',\
						'sound/ambience/rivernight (2).ogg',\
						'sound/ambience/rivernight (3).ogg')

#define AMB_CAVEWATER list('sound/ambience/cavewater (1).ogg',\
						'sound/ambience/cavewater (2).ogg',\
						'sound/ambience/cavewater (3).ogg')

#define AMB_CAVELAVA list('sound/ambience/cavelava (1).ogg',\
						'sound/ambience/cavelava (2).ogg',\
						'sound/ambience/cavelava (3).ogg')

//******* SPOOKED YA

#define SPOOKY_CAVE list('sound/ambience/noises/cave (1).ogg',\
						'sound/ambience/noises/cave (2).ogg',\
						'sound/ambience/noises/cave (3).ogg')

#define SPOOKY_FOREST list('sound/ambience/noises/owl.ogg',\
						'sound/ambience/noises/wolf (1).ogg',\
						'sound/ambience/noises/wolf (2).ogg',\
						'sound/ambience/noises/wolf (3).ogg')

#define SPOOKY_GEN list('sound/ambience/noises/genspooky (1).ogg',\
						'sound/ambience/noises/genspooky (4).ogg',\
						'sound/ambience/noises/genspooky (2).ogg',\
						'sound/ambience/noises/genspooky (3).ogg',\
						'sound/ambience/noises/genspooky (5).ogg')

#define SPOOKY_DUNGEON list('sound/ambience/noises/dungeon (1).ogg',\
						'sound/ambience/noises/dungeon (4).ogg',\
						'sound/ambience/noises/dungeon (2).ogg',\
						'sound/ambience/noises/dungeon (3).ogg',\
						'sound/ambience/noises/dungeon (5).ogg')

#define SPOOKY_RATS list('sound/ambience/noises/RAT1.ogg',\
						'sound/ambience/noises/RAT2.ogg')

#define SPOOKY_FROG list('sound/ambience/noises/frog (1).ogg',\
						'sound/ambience/noises/frog (2).ogg')

#define SPOOKY_MYSTICAL list('sound/ambience/noises/mystical (1).ogg',\
						'sound/ambience/noises/mystical (2).ogg',\
						'sound/ambience/noises/mystical (3).ogg',\
						'sound/ambience/noises/mystical (4).ogg',\
						'sound/ambience/noises/mystical (5).ogg',\
						'sound/ambience/noises/mystical (6).ogg')

#define SPOOKY_CROWS list('sound/ambience/noises/birds (1).ogg',\
						'sound/ambience/noises/birds (2).ogg',\
						'sound/ambience/noises/birds (3).ogg',\
						'sound/ambience/noises/birds (4).ogg',\
						'sound/ambience/noises/birds (5).ogg',\
						'sound/ambience/noises/birds (6).ogg',\
						'sound/ambience/noises/birds (7).ogg')

#define SFX_CHAIN_STEP "chain_step"
#define SFX_PLATE_STEP	"plate_step"
#define SFX_PLATE_COAT_STEP "plate_coat_step"
#define SFX_JINGLE_BELLS "jingle_bells"
#define SFX_WOOD_ARMOR "wood_armor"

#define INTERACTION_SOUND_RANGE_MODIFIER 0
#define EQUIP_SOUND_VOLUME 100
#define PICKUP_SOUND_VOLUME 100
#define DROP_SOUND_VOLUME 100
#define YEET_SOUND_VOLUME 100
#define HOLSTER_SOUND_VOLUME 15
