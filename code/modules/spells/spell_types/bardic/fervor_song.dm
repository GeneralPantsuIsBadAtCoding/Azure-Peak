/obj/effect/proc_holder/spell/invoked/song
	var/song_tier = 1



/obj/effect/proc_holder/spell/invoked/song/fervor_song
	name = "Fervor Song"
	desc = "Inspire the rhythm of battle, your allies strike and parry 20% better!"
	overlay_state = "conjure_weapon"
	sound = list('sound/magic/whiteflame.ogg')

	releasedrain = 60
	chargedrain = 1
	chargetime = 1 SECONDS
	no_early_release = TRUE
	recharge_time = 4 MINUTES
	song_tier = 1
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	invocations = list("To my tune, strike and move thy feet!") 
	invocation_type = "shout"


/obj/effect/proc_holder/spell/invoked/song/fervor_song/cast(mob/living/user = usr)
	var/mob/living/carbon/human/H = user
	if(user.has_status_effect(/datum/status_effect/buff/playing_music))
		for(var/mob/living/carbon/human/folks in view(5, loc))
			if(folks in H.inspiration.audience)
				folks.apply_status_effect(/datum/status_effect/buff/song/fervor)
	else
		revert_cast()
		return


#define FERVOR_FILTER "fervor_glow"

/atom/movable/screen/alert/status_effect/buff/song/fervor // spicy guidance
	name = "Musical Fervor"
	desc = "Musical assistance guides my hands. (+20% chance to bypass parry / dodge, +20% chance to parry / dodge)"
	icon_state = "buff"

/datum/status_effect/buff/song/fervor
	var/outline_colour ="#f58e2d"
	id = "guidance"
	alert_type = /atom/movable/screen/alert/status_effect/buff/song/fervor
	duration = -1

/datum/status_effect/buff/song/fervor/on_apply()
	. = ..()
	var/filter = owner.get_filter(FERVOR_FILTER)
	if (!filter)
		owner.add_filter(FERVOR_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 50, "size" = 1))
	to_chat(owner, span_warning("The tune aides me in battle."))
	ADD_TRAIT(owner, TRAIT_GUIDANCE, MAGIC_TRAIT)

/datum/status_effect/buff/song/fervor/on_remove()
	. = ..()
	to_chat(owner, span_warning("My feeble mind muddies my warcraft once more."))
	owner.remove_filter(FERVOR_FILTER)
	REMOVE_TRAIT(owner, TRAIT_GUIDANCE, MAGIC_TRAIT)


#undef FERVOR_FILTER
