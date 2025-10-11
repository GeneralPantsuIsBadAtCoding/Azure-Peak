/obj/effect/proc_holder/spell/invoked/song/recovery_song
	name = "Recovery Song"
	desc = "Recuperate your allies spirit's with your song! Refills stamina over time!"
	overlay_state = "conjure_weapon"
	sound = list('sound/magic/whiteflame.ogg')

	releasedrain = 60
	chargedrain = 1
	chargetime = 1 SECONDS
	no_early_release = TRUE
	recharge_time = 4 MINUTES
	song_tier = 2
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	invocations = list("Thy muscles recuperate, thy limbs refresh!") 
	invocation_type = "shout"


/obj/effect/proc_holder/spell/invoked/song/recovery_song/cast(mob/living/user = usr)
	var/mob/living/carbon/human/H = user
	if(user.has_status_effect(/datum/status_effect/buff/playing_music))
		for(var/mob/living/carbon/human/folks in view(5, loc))
			if(folks in H.inspiration.audience)
				folks.apply_status_effect(/datum/status_effect/buff/song/recovery)
	else
		revert_cast()
		return



/atom/movable/screen/alert/status_effect/buff/song/recovery // spicy guidance
	name = "Musical Recovery"
	desc = "I am refreshed by the song!"
	icon_state = "buff"

/datum/status_effect/buff/song/recovery
	id = "recoverysong"
	alert_type = /atom/movable/screen/alert/status_effect/buff/song/recovery
	duration = 1 MINUTES

/datum/status_effect/buff/song/recovery/tick()
	owner.stamina_add(-25)
