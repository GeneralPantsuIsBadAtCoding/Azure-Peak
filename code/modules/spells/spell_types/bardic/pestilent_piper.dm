/obj/effect/proc_holder/spell/invoked/song/pestilent_piedpiper
	name = "Pestilent Pied Piper"
	desc = "Play a dirge inspired by Pestra. Leaving the droning of insects in their ears! (-1 WIL -2 CON non-audience members)"
	overlay_state = "conjure_weapon"
	sound = list('sound/magic/whiteflame.ogg')

	releasedrain = 60
	chargedrain = 1
	chargetime = 1 SECONDS
	no_early_release = TRUE
	recharge_time = 2 MINUTES
	song_tier = 3
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	invocations = list("A festering performance!") 
	invocation_type = "shout"


/obj/effect/proc_holder/spell/invoked/song/pestilent_piedpiper/cast(mob/living/user = usr)
	if(user.has_status_effect(/datum/status_effect/buff/playing_music))
		for(var/datum/status_effect/buff/playing_melody/melodies in user.status_effects)
			user.remove_status_effect(melodies)
		for(var/datum/status_effect/buff/playing_dirge/dirges in user.status_effects)
			user.remove_status_effect(dirges)
		user.apply_status_effect(/datum/status_effect/buff/playing_dirge/pestilent_piedpiper)
	else
		revert_cast()
		return





/datum/status_effect/buff/playing_dirge/pestilent_piedpiper
	debuff_to_apply = /datum/status_effect/debuff/song/pestilentpiper


/atom/movable/screen/alert/status_effect/debuff/song/pestilentpiper
	name = "Musical Suffocation!"
	desc = "I am suffocating on the song!"
	icon_state = "debuff"

/datum/status_effect/debuff/song/pestilentpiper
	id = "pestilentpiper"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/song/pestilentpiper
	duration = 15 SECONDS
	effectedstats = list(STATKEY_WIL = -1, STATKEY_CON = -2)
