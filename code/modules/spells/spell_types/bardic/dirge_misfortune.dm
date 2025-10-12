/datum/status_effect/buff/playing_dirge
	id = "play_dirge"
	alert_type = /atom/movable/screen/alert/status_effect/buff/playing_dirge
	var/effect_color
	var/datum/status_effect/debuff/debuff_to_apply
	var/pulse = 0
	var/ticks_to_apply = 10


/atom/movable/screen/alert/status_effect/buff/playing_dirge
	name = "Playing Dirge"
	desc = "Terrorizing the world with my craft."
	icon_state = "buff"


/datum/status_effect/buff/playing_dirge/tick()
	var/mob/living/carbon/human/O = owner
	if(!O.inspiration)
		return
	pulse += 1
	if (pulse >= ticks_to_apply)
		pulse = 0
		for (var/mob/living/carbon/human/H in hearers(7, owner))
			if(O.in_audience(H))
				to_chat(H, "Returning because I'm in their audience")
				return
			if (!H.has_status_effect(debuff_to_apply))
				H.apply_status_effect(debuff_to_apply)


/obj/effect/proc_holder/spell/invoked/song/dirge_fortune
	name = "Dirge of Misfortune"
	desc = "Play a dirge which inflicts misfortune upon thy foes. -2 LUCK to non-audience members nearby. "
	overlay_state = "conjure_weapon"
	sound = list('sound/magic/whiteflame.ogg')

	releasedrain = 60
	chargedrain = 1
	chargetime = 1 SECONDS
	no_early_release = TRUE
	recharge_time = 2 MINUTES
	song_tier = 2
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	invocations = list("HEAR YOUR DOOM!!") 
	invocation_type = "shout"


/obj/effect/proc_holder/spell/invoked/song/dirge_fortune/cast(mob/living/user = usr)
	if(user.has_status_effect(/datum/status_effect/buff/playing_music))
		user.apply_status_effect(/datum/status_effect/buff/playing_dirge/misfortune)
	else
		revert_cast()
		return





/datum/status_effect/buff/playing_dirge/misfortune
	debuff_to_apply = /datum/status_effect/debuff/dirge_misfortune

/datum/status_effect/debuff/dirge_misfortune
	id = "ravox_burden"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/dirge_misfortune
	effectedstats = list(STATKEY_LCK = -2)
	duration = 20 SECONDS

/atom/movable/screen/alert/status_effect/debuff/dirge_misfortune
	name = "Dirge of Misfortune"
	desc = "The blasted dirge drives me mad! My fortune is sapped!"
	icon_state = "restrained"
