/obj/effect/proc_holder/spell/invoked/song/suffocating_seliloquy
	name = "Suffocating Seliloquy"
	desc = "Play a dirge inspired by Abyssor, slowly suffocating with its call."
	overlay_state = "dirge_t3_base"
	action_icon_state = "dirge_t3_base"
	song_tier = 3
	invocations = list("Suffocating seliloquy, snuff the sinners' breath!") 
	invocation_type = "shout"
	overlay_state = "dirge_t3_base"
	action_icon_state = "dirge_t3_base"
	sound = list('sound/magic/debuffroll.ogg')


/obj/effect/proc_holder/spell/invoked/song/suffocating_seliloquy/cast(mob/living/user = usr)
	if(user.has_status_effect(/datum/status_effect/buff/playing_music))
		for(var/datum/status_effect/buff/playing_melody/melodies in user.status_effects)
			user.remove_status_effect(melodies)
		for(var/datum/status_effect/buff/playing_dirge/dirges in user.status_effects)
			user.remove_status_effect(dirges)
		user.apply_status_effect(/datum/status_effect/buff/playing_dirge/suffocating_seliloquy)
		return TRUE
	else
		revert_cast()
		to_chat(user, span_warning("I must be playing something to inspire my audience!"))
		return





/datum/status_effect/buff/playing_dirge/suffocating_seliloquy
	effect = /obj/effect/temp_visual/songs/inspiration_dirget3
	debuff_to_apply = /datum/status_effect/debuff/song/suffocationsong


/atom/movable/screen/alert/status_effect/debuff/song/suffocationsong
	name = "Musical Suffocation!"
	desc = "I am suffocating on the song!"
	icon_state = "debuff"

/datum/status_effect/debuff/song/suffocationsong
	id = "suffocationsong"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/song/suffocationsong
	duration = 15 SECONDS

/datum/status_effect/debuff/song/suffocationsong/tick()
	owner.adjustOxyLoss(1.5)
