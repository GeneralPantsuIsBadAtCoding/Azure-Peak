/obj/effect/proc_holder/spell/invoked/song/suffocating_seliloquy
	name = "Suffocating Seliloquy"
	desc = "Play a dirge of Abyssor, slowly suffocating with its call."
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
	invocations = list("Suffocating seliloquy, snuff the sinners' breath!") 
	invocation_type = "shout"


/obj/effect/proc_holder/spell/invoked/song/suffocating_seliloquy/cast(mob/living/user = usr)
	if(user.has_status_effect(/datum/status_effect/buff/playing_music))
		user.apply_status_effect(/datum/status_effect/buff/playing_dirge/suffocating_seliloquy)
	else
		revert_cast()
		return





/datum/status_effect/buff/playing_dirge/suffocating_seliloquy
	debuff_to_apply = /datum/status_effect/debuff/song/suffocationsong


/atom/movable/screen/alert/status_effect/debuff/song/suffocationsong
	name = "Musical Suffocation!"
	desc = "I am suffocating on the song!"
	icon_state = "debuff"

/datum/status_effect/debuff/song/suffocationsong
	id = "suffocationsong"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/song/suffocationsong
	duration = 30 SECONDS

/datum/status_effect/debuff/song/suffocationsong/tick()
	owner.adjustOxyLoss(2.5)
