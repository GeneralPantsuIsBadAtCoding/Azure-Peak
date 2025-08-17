/client
	var/list/played_loops = list() //uses dlink to link to the sound

///Default override for echo
/sound
	echo = list(
		0, // Direct
		0, // DirectHF
		-10000, // Room, -10000 means no low frequency sound reverb
		-10000, // RoomHF, -10000 means no high frequency sound reverb
		0, // Obstruction
		0, // ObstructionLFRatio
		0, // Occlusion
		0.25, // OcclusionLFRatio
		1.5, // OcclusionRoomRatio
		1.0, // OcclusionDirectRatio
		0, // Exclusion
		1.0, // ExclusionLFRatio
		0, // OutsideVolumeHF
		0, // DopplerFactor
		0, // RolloffFactor
		0, // RoomRolloffFactor
		1.0, // AirAbsorptionFactor
		0, // Flags (1 = Auto Direct, 2 = Auto Room, 4 = Auto RoomHF)
	)
	environment = SOUND_ENVIRONMENT_NONE //Default to none so sounds without overrides dont get reverb

/**
 * playsound is a proc used to play a 3D sound in a specific range. This uses SOUND_RANGE + extra_range to determine that.
 *
 * source - Origin of sound.
 * soundin - Either a file, or a string that can be used to get an SFX.
 * vol - The volume of the sound, excluding falloff and pressure affection.
 * vary - bool that determines if the sound changes pitch every time it plays.
 * extrarange - modifier for sound range. This gets added on top of SOUND_RANGE.
 * falloff_exponent - Rate of falloff for the audio. Higher means quicker drop to low volume. Should generally be over 1 to indicate a quick dive to 0 rather than a slow dive.
 * frequency - playback speed of audio.
 * channel - The channel the sound is played at.
 * pressure_affected - Whether or not difference in pressure affects the sound (E.g. if you can hear in space).
 * ignore_walls - Whether or not the sound can pass through walls. If passed a sound, it will play to anyone who would not normally hear the sound due to LOS.
 * falloff_distance - Distance at which falloff begins. Sound is at peak volume (in regards to falloff) aslong as it is in this range.
 */
/proc/playsound(atom/source, soundin, vol as num, vary, extrarange as num, falloff, frequency = null, channel, pressure_affected = FALSE, ignore_walls = TRUE, soundping = FALSE, repeat, animal_pref = FALSE, falloff_exponent = SOUND_FALLOFF_EXPONENT, falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE, use_reverb = TRUE)
	if(isarea(source))
		CRASH("playsound(): source is an area")
	if(isnull(vol))
		CRASH("Playsound received a null volume, this is probably wrong!")

	var/turf/turf_source = get_turf(source)
	if(!turf_source || !soundin || !vol)
		return

	//allocate a channel if necessary now so its the same for everyone
	channel = channel || SSsounds.random_available_channel()

	// Looping through the player list has the added bonus of working for mobs inside containers
	var/sound/S = soundin
	var/maxdistance = (world.view + extrarange)
	var/source_z = turf_source.z

	if(!istype(S))
		S = sound(get_sfx(soundin))
	if(!extrarange)
		extrarange = 1

	var/list/listeners = SSmobs.clients_by_zlevel[source_z].Copy()

	// Listeners that are hearing through a wall or out of view. They will hear a much quieter sound.
	var/list/muffled_listeners = list() //this is very rudimentary list of muffled listeners above and below to mimic sound muffling (this is done through modifying the playsounds for them)
	var/muffled_sound					//for when the sound is muffled but not stopped

	. = list()//output everything that successfully heard the sound

	var/turf/above_turf = GET_TURF_ABOVE(turf_source)
	var/turf/below_turf = GET_TURF_BELOW(turf_source)

	if(soundping)
		ping_sound(source)

	if(!isnum(ignore_walls))
		muffled_sound = sound(get_sfx(ignore_walls))

	if(ignore_walls == TRUE)
		if(above_turf && istransparentturf(above_turf))
			listeners += SSmobs.clients_by_zlevel[above_turf.z]
		if(below_turf && istransparentturf(turf_source))
			listeners += SSmobs.clients_by_zlevel[below_turf.z]
	else //these sounds don't carry through walls
		listeners = get_hearers_in_view(maxdistance, turf_source)
		if(above_turf && istransparentturf(above_turf))
			listeners += get_hearers_in_view(maxdistance, above_turf)
		if(below_turf && istransparentturf(turf_source))
			listeners += get_hearers_in_view(maxdistance, below_turf)
		// If we have a partial sound to play, generate the list of partial listeners.
		if(muffled_sound)
			muffled_listeners = SSmobs.clients_by_zlevel[source_z].Copy()

			if(above_turf && istransparentturf(above_turf))
				muffled_listeners += SSmobs.clients_by_zlevel[above_turf.z]

			if(below_turf && istransparentturf(turf_source))
				muffled_listeners += SSmobs.clients_by_zlevel[below_turf.z]

			muffled_listeners -= listeners
			muffled_listeners -= SSmobs.dead_players_by_zlevel[source_z]

	//for(var/mob/M as anything in listeners)
	for(var/mob/M in listeners | SSmobs.dead_players_by_zlevel[source_z])//observers always hear through walls
		if(get_dist(M, turf_source) <= maxdistance)
			if(animal_pref)
				if(M.client?.prefs?.mute_animal_emotes)
					continue
			if(M.playsound_local(turf_source, soundin, vol, vary, frequency, falloff_exponent, channel, pressure_affected, S, maxdistance, falloff_distance, 1, use_reverb))
				. += M
	
	if(muffled_listeners)
		for(var/mob/M as anything in muffled_listeners)
			var/mob_distance = get_dist(M, turf_source)
			if(mob_distance > maxdistance)
				continue
			if(animal_pref)
				if(M.client?.prefs?.mute_animal_emotes)
					continue
			var/heard_da_sound = M.playsound_local(
				turf_source,
				muffled_sound,
				vol * 0.5,
				vary,
				frequency,
				falloff_exponent + 3,
				channel,
				pressure_affected,
				muffled_sound,
				maxdistance,
				max(min(mob_distance - SOUND_OCCLUSION_DISTANCE_MODIFIER, falloff_distance), 1),
				1,
				TRUE,
				env_override = SOUND_ENVIRONMENT_PADDED_CELL,
			)

			if(heard_da_sound)
				. += M


/proc/ping_sound(atom/A)
	var/image/I = image(icon = 'icons/effects/effects.dmi', loc = A, icon_state = "emote", layer = ABOVE_MOB_LAYER)
	if(!I)
		return
	I.pixel_y = 6
	I.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	flick_overlay(I, GLOB.clients, 6)

/proc/ping_sound_through_walls(turf/T)
	new /obj/effect/temp_visual/soundping(T)

/obj/effect/temp_visual/soundping
	plane = FULLSCREEN_PLANE
	layer = FLASH_LAYER
	icon = 'icons/effects/ore_visuals.dmi'
	icon_state = "zz"
	appearance_flags = 0 //to avoid having TILE_BOUND in the flags, so that the 480x480 icon states let you see it no matter where you are
	duration = 6
	pixel_x = -224
	pixel_y = -218

/*
/obj/effect/temp_visual/soundping/Initialize()
	. = ..()
	animate(src, alpha = 0, time = duration, easing = EASE_IN)
*/
/mob/proc/playsound_local(atom/turf_source, soundin, vol as num, vary, frequency, falloff_exponent = SOUND_FALLOFF_EXPONENT, channel = 0, pressure_affected = TRUE, sound/S, repeat, muffled, max_distance, falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE, distance_multiplier = 1, use_reverb = TRUE, wait = FALSE, env_override = null)
	if(!client || !can_hear())
		return FALSE

	if(!S)
		S = sound(get_sfx(soundin))

	S.wait = 0 //No queue
	S.channel = channel
	S.volume = vol

	if(vary)
		if(frequency)
			S.frequency = frequency
		else
			S.frequency = get_rand_frequency()

	var/vol2use = vol
	if(client.prefs)
		vol2use = vol * (client.prefs.mastervol * 0.01)

	if(isturf(turf_source))
		var/turf/turf_loc = get_turf(src)

		//sound volume falloff with distance
		var/distance = get_dist(turf_loc, turf_source) * distance_multiplier

		if(max_distance && falloff_exponent) //If theres no max_distance we're not a 3D sound, so no falloff.
			S.volume -= (max(distance - falloff_distance, 0) ** (1 / falloff_exponent)) / ((max(max_distance, distance) - falloff_distance) ** (1 / falloff_exponent)) * S.volume
			//https://www.desmos.com/calculator/sqdfl8ipgf
/*
		if(pressure_affected)
			//Atmosphere affects sound
			var/pressure_factor = 1
			var/datum/gas_mixture/hearer_env = T.return_air()
			var/datum/gas_mixture/source_env = turf_source.return_air()

			if(hearer_env && source_env)
				var/pressure = min(hearer_env.return_pressure(), source_env.return_pressure())
				if(pressure < ONE_ATMOSPHERE)
					pressure_factor = max((pressure - SOUND_MINIMUM_PRESSURE)/(ONE_ATMOSPHERE - SOUND_MINIMUM_PRESSURE), 0)
			else //space
				pressure_factor = 0

			if(distance <= 1)
				pressure_factor = max(pressure_factor, 0.15) //touching the source of the sound

			S.volume *= pressure_factor
			//End Atmosphere affecting sound
*/

		if(S.volume <= 0)
			return FALSE //No sound

		var/dx = turf_source.x - turf_loc.x // Hearing from the right/left
		S.x = dx * distance_multiplier
		var/dz = turf_source.y - turf_loc.y // Hearing from infront/behind
		S.z = dz * distance_multiplier
		var/dy = (turf_source.z - turf_loc.z) * 5 * distance_multiplier // Hearing from  above / below, multiplied by 5 because we assume height is further along coords.
		S.y = dy

		S.falloff = max_distance || 1 //use max_distance, else just use 1 as we are a direct sound so falloff isnt relevant.

		// A sound's environment will be:
		// 1. the sound's
		// 2. the mob's
		// 3. the area's (defaults to SOUND_ENVRIONMENT_NONE)

		if(isnum(env_override))
			S.environment = env_override
		else if(sound_environment_override != SOUND_ENVIRONMENT_NONE)
			S.environment = sound_environment_override
		else
			var/area/A = get_area(src)
			S.environment = A.sound_environment

		if(use_reverb && S.environment != SOUND_ENVIRONMENT_NONE) //We have reverb, reset our echo setting
			S.echo[3] = 0 //Room setting, 0 means normal reverb
			S.echo[4] = 0 //RoomHF setting, 0 means normal reverb.
	if(repeat && istype(repeat, /datum/looping_sound))
		var/datum/looping_sound/D = repeat
		if(src in D.thingshearing) //we are already hearing this loop
			if(client.played_loops[D])
				var/sound/DS = client.played_loops[D]["SOUND"]
				if(DS)
					var/volly = client.played_loops[D]["VOL"]
					if(volly != S.volume)
						DS.x = S.x
						DS.y = S.y
						DS.z = S.z
						DS.falloff = S.falloff
						client.played_loops[D]["VOL"] = S.volume
						update_sound_volume(DS, S.volume)
						if(client.played_loops[D]["MUTESTATUS"]) //we have sound so turn this off
							client.played_loops[D]["MUTESTATUS"] = null
		else
			D.thingshearing += src
			client.played_loops[D] = list()
			client.played_loops[D]["SOUND"] = S
			client.played_loops[D]["VOL"] = S.volume
			client.played_loops[D]["MUTESTATUS"] = null
			S.repeat = 1

	. = TRUE

	SEND_SOUND(src, S)
	if(LAZYLEN(observers))
		for(var/mob/dead/observer/O as anything in observers)
			SEND_SOUND(src, S)
	return TRUE

/proc/sound_to_playing_players(soundin, volume = 100, vary = FALSE, frequency = 0, falloff = FALSE, channel = 0, pressure_affected = FALSE, sound/S)
	if(!S)
		S = sound(get_sfx(soundin))
	for(var/m in GLOB.player_list)
		if(ismob(m) && !isnewplayer(m))
			var/mob/M = m
			M.playsound_local(M, null, volume, vary, frequency, falloff, channel, pressure_affected, S)

/mob/proc/stop_sound_channel(chan)
	SEND_SOUND(src, sound(null, repeat = 0, wait = 0, channel = chan))

/mob/proc/set_sound_channel_volume(channel, volume)
	var/sound/S = sound(null, FALSE, FALSE, channel, volume)
	S.status = SOUND_UPDATE
	SEND_SOUND(src, S)

/mob/proc/mute_sound_channel(chan)
	for(var/sound/S in client.SoundQuery())
		if(S.channel == chan)
			S.status |= SOUND_MUTE | SOUND_UPDATE
			SEND_SOUND(src, S)
			S.status &= ~SOUND_UPDATE

/mob/proc/unmute_sound_channel(chan)
	if(!client)
		return
	for(var/sound/S in client.SoundQuery())
		if(S.channel == chan)
			S.status |= SOUND_UPDATE
			S.status &= ~SOUND_MUTE
			SEND_SOUND(src, S)
			S.status &= ~SOUND_UPDATE

/mob/proc/mute_sound(sound/S)
	if(!client)
		return
	if(!S)
		return
	S.status |= SOUND_MUTE | SOUND_UPDATE
	SEND_SOUND(src, S)
	S.status &= ~SOUND_UPDATE

/mob/proc/unmute_sound(sound/S)
	if(!client)
		return
	if(!S)
		return
	S.status |= SOUND_UPDATE
	S.status &= ~SOUND_MUTE
	SEND_SOUND(src, S)
	S.status &= ~SOUND_UPDATE

/mob/proc/update_sound_volume(sound/S, vol)
	if(!client)
		return
	if(!S)
		return
	if(vol)
		S.volume = vol
		S.status |= SOUND_UPDATE
		S.status &= ~SOUND_MUTE
		SEND_SOUND(src, S)
		S.status &= ~SOUND_UPDATE

/mob/proc/update_music_volume(chan, vol)
	if(client)
		if(client.musicfading)
			if(vol > client.musicfading)
				return
	if(vol)
		for(var/sound/S in client.SoundQuery())
			if(S.channel == chan)
				unmute_sound_channel(chan)
				S.volume = vol
				S.status |= SOUND_UPDATE
				SEND_SOUND(src, S)
				S.status &= ~SOUND_UPDATE
	else
		mute_sound_channel(chan)

/mob/proc/update_channel_volume(chan, vol)
	if(vol)
		for(var/sound/S in client.SoundQuery())
			if(S.channel == chan)
				unmute_sound_channel(chan)
				S.volume = vol
				S.status |= SOUND_UPDATE
				SEND_SOUND(src, S)
				S.status &= ~SOUND_UPDATE

/client/proc/playtitlemusic()
	set waitfor = FALSE
	UNTIL(SSticker.login_music) //wait for SSticker init to set the login music

	if(prefs && (prefs.toggles & SOUND_LOBBY))
		SEND_SOUND(src, sound(SSticker.login_music, repeat = 1, wait = 0, volume = prefs.musicvol, channel = CHANNEL_LOBBYMUSIC)) // MAD JAMS

/proc/get_rand_frequency()
	return rand(43100, 45100) //Frequency stuff only works with 45kbps oggs.

/proc/get_sfx(soundin)
	if(islist(soundin))
		soundin = pick(soundin)
	if(istext(soundin))
		switch(soundin)
			if ("rustle")
				soundin = pick('sound/foley/equip/rummaging-01.ogg','sound/foley/equip/rummaging-02.ogg','sound/foley/equip/rummaging-03.ogg')
			if ("bodyfall")
				soundin = pick('sound/foley/bodyfall (1).ogg','sound/foley/bodyfall (2).ogg','sound/foley/bodyfall (3).ogg','sound/foley/bodyfall (4).ogg')
			if ("clothwipe")
				soundin = pick('sound/foley/cloth_wipe (1).ogg','sound/foley/cloth_wipe (2).ogg','sound/foley/cloth_wipe (3).ogg')
			if ("glassbreak")
				soundin = pick('sound/combat/hits/onglass/glassbreak (1).ogg','sound/combat/hits/onglass/glassbreak (2).ogg','sound/combat/hits/onglass/glassbreak (3).ogg')
			if ("parrywood")
				soundin = pick('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
			if ("unarmparry")
				soundin = pick('sound/combat/parry/pugilism/unarmparry (1).ogg','sound/combat/parry/pugilism/unarmparry (2).ogg','sound/combat/parry/pugilism/unarmparry (3).ogg')
			if ("dagger")
				soundin = pick('sound/combat/parry/bladed/bladedsmall (1).ogg', 'sound/combat/parry/bladed/bladedsmall (2).ogg', 'sound/combat/parry/bladed/bladedsmall (3).ogg')
			if ("rapier")
				soundin = pick('sound/combat/parry/bladed/bladedthin (1).ogg', 'sound/combat/parry/bladed/bladedthin (2).ogg', 'sound/combat/parry/bladed/bladedthin (3).ogg')
			if ("sword")
				soundin = pick('sound/combat/parry/bladed/bladedmedium (1).ogg', 'sound/combat/parry/bladed/bladedmedium (2).ogg', 'sound/combat/parry/bladed/bladedmedium (3).ogg')
			if ("largeblade")
				soundin = pick('sound/combat/parry/bladed/bladedlarge (1).ogg', 'sound/combat/parry/bladed/bladedlarge (2).ogg', 'sound/combat/parry/bladed/bladedlarge (3).ogg')
			if ("unsheathe_sword")
				soundin = pick('sound/foley/equip/swordsmall1.ogg', 'sound/foley/equip/swordsmall2.ogg')
			if ("brandish_blade")
				soundin = pick('sound/foley/equip/swordlarge1.ogg', 'sound/foley/equip/swordlarge2.ogg')
			if ("burn")
				soundin = pick('sound/combat/hits/burn (1).ogg','sound/combat/hits/burn (2).ogg')
			if ("nodmg")
				soundin = pick('sound/combat/hits/nodmg (1).ogg','sound/combat/hits/nodmg (2).ogg')
			if ("plantcross")
				soundin = pick('sound/foley/plantcross1.ogg','sound/foley/plantcross2.ogg','sound/foley/plantcross3.ogg','sound/foley/plantcross4.ogg')
			if ("smashlimb")
				soundin = pick('sound/combat/hits/smashlimb (1).ogg','sound/combat/hits/smashlimb (2).ogg','sound/combat/hits/smashlimb (3).ogg')
			if("genblunt")
				soundin = pick('sound/combat/hits/blunt/genblunt (1).ogg','sound/combat/hits/blunt/genblunt (2).ogg','sound/combat/hits/blunt/genblunt (3).ogg')
			if("wetbreak")
				soundin = pick('sound/combat/fracture/fracturewet (1).ogg',
'sound/combat/fracture/fracturewet (2).ogg',
'sound/combat/fracture/fracturewet (3).ogg')
			if("fracturedry")
				soundin = pick('sound/combat/fracture/fracturedry (1).ogg',
'sound/combat/fracture/fracturedry (2).ogg',
'sound/combat/fracture/fracturedry (3).ogg')
			if("headcrush")
				soundin = pick('sound/combat/fracture/headcrush (1).ogg',
'sound/combat/fracture/headcrush (2).ogg',
'sound/combat/fracture/headcrush (3).ogg',
'sound/combat/fracture/headcrush (4).ogg')
			if("punch")
				soundin = pick('sound/combat/hits/punch/punch (1).ogg','sound/combat/hits/punch/punch (2).ogg','sound/combat/hits/punch/punch (3).ogg')
			if("punch_hard")
				soundin = pick('sound/combat/hits/punch/punch_hard (1).ogg','sound/combat/hits/punch/punch_hard (2).ogg','sound/combat/hits/punch/punch_hard (3).ogg')
			if("smallslash")
				soundin = pick('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg')
			if("woodimpact")
				soundin = pick('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
			if("bubbles")
				soundin = pick('sound/foley/bubb (1).ogg','sound/foley/bubb (2).ogg','sound/foley/bubb (3).ogg','sound/foley/bubb (4).ogg','sound/foley/bubb (5).ogg')
			if("parrywood")
				soundin = pick('sound/combat/parry/wood/parrywood (1).ogg','sound/combat/parry/wood/parrywood (2).ogg','sound/combat/parry/wood/parrywood (3).ogg')
			if("whiz")
				soundin = pick('sound/foley/whiz (1).ogg','sound/foley/whiz (2).ogg','sound/foley/whiz (3).ogg','sound/foley/whiz (4).ogg')
			if("genslash")
				soundin = pick('sound/combat/hits/bladed/genslash (1).ogg','sound/combat/hits/bladed/genslash (2).ogg','sound/combat/hits/bladed/genslash (3).ogg')
			if("bladewooshsmall")
				soundin = pick('sound/combat/wooshes/bladed/wooshsmall (1).ogg','sound/combat/wooshes/bladed/wooshsmall (2).ogg','sound/combat/wooshes/bladed/wooshsmall (3).ogg')
			if("bluntwooshmed")
				soundin = pick('sound/combat/wooshes/blunt/wooshmed (1).ogg','sound/combat/wooshes/blunt/wooshmed (2).ogg','sound/combat/wooshes/blunt/wooshmed (3).ogg')
			if("bluntwooshlarge")
				soundin = pick('sound/combat/wooshes/blunt/wooshlarge (1).ogg','sound/combat/wooshes/blunt/wooshlarge (2).ogg','sound/combat/wooshes/blunt/wooshlarge (3).ogg')
			if("punchwoosh")
				soundin = pick('sound/combat/wooshes/punch/punchwoosh (1).ogg','sound/combat/wooshes/punch/punchwoosh (2).ogg','sound/combat/wooshes/punch/punchwoosh (3).ogg')
			if(SFX_CHAIN_STEP)
				soundin = pick(
							'sound/foley/footsteps/armor/chain (1).ogg',
							'sound/foley/footsteps/armor/chain (2).ogg',
							'sound/foley/footsteps/armor/chain (3).ogg',
							)
			if(SFX_PLATE_STEP)
				soundin = pick(
							'sound/foley/footsteps/armor/plate (1).ogg',
							'sound/foley/footsteps/armor/plate (2).ogg',
							'sound/foley/footsteps/armor/plate (3).ogg',
							)
			if(SFX_PLATE_COAT_STEP)
				soundin = pick(
							'sound/foley/footsteps/armor/coatplates (1).ogg',
							'sound/foley/footsteps/armor/coatplates (2).ogg',
							'sound/foley/footsteps/armor/coatplates (3).ogg',
							)
			if(SFX_JINGLE_BELLS)
				soundin = pick(
							'sound/items/jinglebell1.ogg',
							'sound/items/jinglebell2.ogg',
							'sound/items/jinglebell3.ogg',
							'sound/items/jinglebell4.ogg',
							)
			if(SFX_WOOD_ARMOR)
				soundin = pick(
							'sound/foley/footsteps/armor/woodarmor (1).ogg',
							'sound/foley/footsteps/armor/woodarmor (2).ogg',
							'sound/foley/footsteps/armor/woodarmor (3).ogg',
							)
	return soundin
