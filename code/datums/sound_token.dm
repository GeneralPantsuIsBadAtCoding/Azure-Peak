// Sound tokens, a datumized handler for spatial sound.
// Creating a sound token registers all connected clients to the sound, so that they are in sync
// Even if someone enters the range of the sound after it has started.
/datum/sound_token
	/// The atom playing the sound.
	var/atom/source
	/// k:v list of mob : sound status
	var/list/listeners

	/// Sound maximum range
	var/range
	/// Sound volume
	var/volume
	/// Sound falloff
	var/falloff_exponent
	/// Sound falloff distance
	var/falloff_distance

	/// The master copy of the playing sound.
	var/sound/sound
	/// Null sound for cancelling the sound entirely.
	var/sound/null_sound

	/// Status of the playing sound
	var/sound_status = NONE
	/// The channel being used.
	var/sound_channel

/datum/sound_token/New(atom/_source, sound/_sound, _range = 10, _volume = 50, _falloff_exponent = SOUND_FALLOFF_EXPONENT, _falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE)
	source = _source
	RegisterSignal(source, COMSIG_PARENT_QDELETING, PROC_REF(source_deleted))
	RegisterSignal(source, COMSIG_MOVABLE_MOVED, PROC_REF(source_moved))

	range = _range
	volume = _volume
	falloff_exponent = _falloff_exponent
	falloff_distance = _falloff_distance

	sound = _sound
	sound.status |= SOUND_UPDATE
	sound_channel = SSsounds.reserve_sound_channel(src)
	sound.channel = sound_channel
	null_sound = sound(channel = sound_channel)

	listeners = list()

	for(var/mob/M in GLOB.player_list)
		AddOrUpdateListener(M)

	RegisterSignal(SSdcs, COMSIG_GLOB_PLAYER_LOGIN, PROC_REF(player_login))
	RegisterSignal(SSdcs, COMSIG_GLOB_PLAYER_LOGOUT, PROC_REF(player_logout))

/datum/sound_token/Destroy(force, ...)
	for(var/listener in listeners)
		RemoveListener(listener)

	listeners = null
	source = null
	return ..()

/// Updates the data of a listener, or adds them if they are not present.
/datum/sound_token/proc/AddOrUpdateListener(mob/M)
	if(isnull(listeners[M]))
		AddListener(M)
		return

	UpdateListener(M)

/// Adds a listener to the sound.
/datum/sound_token/proc/AddListener(mob/M)
	if(!isnull(listeners[M]))
		return FALSE

	if(!M.client || isnewplayer(M))
		return

	listeners[M] = NONE
	RegisterSignal(M, COMSIG_PARENT_QDELETING, PROC_REF(listener_deleted))
	RegisterSignal(M, COMSIG_MOVABLE_MOVED, PROC_REF(listener_moved))
	RegisterSignal(M, list(SIGNAL_ADDTRAIT(TRAIT_DEAF),SIGNAL_REMOVETRAIT(TRAIT_DEAF)), PROC_REF(listener_deafness_update))
	UpdateListener(M, FALSE)
	return TRUE

/// Remove a listener from the sound.
/datum/sound_token/proc/RemoveListener(mob/M)
	UnregisterSignal(M, list(COMSIG_PARENT_QDELETING, COMSIG_MOVABLE_MOVED, COMSIG_MOB_LOGIN, SIGNAL_ADDTRAIT(TRAIT_DEAF),SIGNAL_REMOVETRAIT(TRAIT_DEAF)))
	listeners -= M
	SEND_SOUND(M, null_sound)

/datum/sound_token/proc/UpdateListener(mob/M, update_sound = TRUE)
	var/turf/source_turf = get_turf(source)
	var/turf/listener_turf = get_turf(M)

	var/is_muted = listeners[M] & SOUND_MUTE
	var/should_be_muted = FALSE
	if(!source_turf || !listener_turf)
		should_be_muted = TRUE
		if(should_be_muted && is_muted)
			return

	var/distance = get_dist(source_turf, listener_turf)
	if(distance > range)
		should_be_muted = TRUE
		if(should_be_muted && is_muted)
			return

	should_be_muted ||= !M.can_hear()
	if(should_be_muted && is_muted)
		return

	SetListenerStatus(M, should_be_muted ? SOUND_MUTE : NONE)
	send_listener_sound(M, update_sound)

/datum/sound_token/proc/send_listener_sound(mob/M, update_sound)
	PRIVATE_PROC(TRUE)

	sound.status = SOUND_STREAM|sound_status|listeners[M]
	if(update_sound)
		sound.status |= SOUND_UPDATE

	if(sound.status & SOUND_MUTE)
		SEND_SOUND(M, sound)
		return

	if(!M.playsound_local(get_turf(source), vol = volume, falloff_exponent = falloff_exponent, channel = sound_channel, soundin = sound, max_distance = range, falloff_distance = falloff_distance, use_reverb = TRUE))
		sound.status = SOUND_UPDATE|SOUND_MUTE
		SEND_SOUND(M, sound)

/datum/sound_token/proc/update_all_listeners()
	for(var/mob/M in listeners)
		if(M.client)
			UpdateListener(M)

/// Setter for volume
/datum/sound_token/proc/SetVolume(new_volume)
	volume = new_volume
	update_all_listeners()

/// Set the status of a listener. Does not update the sound.
/datum/sound_token/proc/SetListenerStatus(mob/M, new_status)
	if(isnull(listeners[M]))
		return

	listeners[M] = new_status

/// Respond to a listener moving.
/datum/sound_token/proc/listener_moved(atom/movable/source)
	SIGNAL_HANDLER
	UpdateListener(source)

/// Respond to TRAIT_DEAF addition/removal
/datum/sound_token/proc/listener_deafness_update(atom/movable/source)
	SIGNAL_HANDLER
	UpdateListener(source)

/datum/sound_token/proc/listener_deleted(datum/source)
	SIGNAL_HANDLER
	RemoveListener(source)

/// Respond to any mob in the world being logged into.
/datum/sound_token/proc/player_login(mob/player)
	SIGNAL_HANDLER
	AddOrUpdateListener(player)

/// Respond to any cliented mob becoming uncliented
/datum/sound_token/proc/player_logout(mob/player)
	SIGNAL_HANDLER
	RemoveListener(player)

/// If the sound source moves, update all listeners.
/datum/sound_token/proc/source_moved()
	SIGNAL_HANDLER
	update_all_listeners()

/datum/sound_token/proc/source_deleted()
	SIGNAL_HANDLER

	qdel(src)
