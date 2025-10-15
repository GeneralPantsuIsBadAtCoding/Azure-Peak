/obj/effect/proc_holder/spell/invoked/song
	var/song_tier = 1
	sound = list('sound/magic/buffrollaccent.ogg')
	overlay_icon = 'icons/mob/actions/bardsongs.dmi'
	overlay_state = "dirge_t1_base"
	action_icon_state = "dirge_t1_base"
	action_icon = 'icons/mob/actions/bardsongs.dmi'
	warnie = "spellwarning"
	releasedrain = 60
	chargedrain = 1
	chargetime = 1 SECONDS
	no_early_release = TRUE
	recharge_time = 2 MINUTES
	no_early_release = TRUE
	movement_interrupt = FALSE


/obj/effect/proc_holder/spell/invoked/song/fervor_song
	name = "Fervorous Fantasia"
	desc = "Inspire the rhythm of battle, your allies strike and parry 20% better!"
	song_tier = 2
	warnie = "spellwarning"
	invocations = list("To my tune, strike and move thy feet!") 
	invocation_type = "shout"
	overlay_state = "bardsong_t2_base"
	action_icon_state = "bardsong_t2_base"


/obj/effect/proc_holder/spell/invoked/song/fervor_song/cast(mob/living/user = usr)
	if(user.has_status_effect(/datum/status_effect/buff/playing_music))
		for(var/datum/status_effect/buff/playing_melody/melodies in user.status_effects)
			user.remove_status_effect(melodies)
		for(var/datum/status_effect/buff/playing_dirge/dirges in user.status_effects)
			user.remove_status_effect(dirges)
		user.apply_status_effect(/datum/status_effect/buff/playing_melody/fervor)
		return TRUE
	else
		revert_cast()
		return FALSE

/datum/status_effect/buff/playing_melody/fervor
	effect = /obj/effect/temp_visual/songs/inspiration_bardsongt2
	buff_to_apply = /datum/status_effect/buff/song/fervor


#define FERVOR_FILTER "fervor_glow"

/atom/movable/screen/alert/status_effect/buff/song/fervor // spicy guidance
	name = "Musical Fervor"
	desc = "Musical assistance guides my hands. (+20% chance to bypass parry / dodge, +20% chance to parry / dodge)"
	icon_state = "buff"

/datum/status_effect/buff/song/fervor
	var/outline_colour ="#f58e2d"
	id = "fervor"
	alert_type = /atom/movable/screen/alert/status_effect/buff/song/fervor
	duration = 15 SECONDS

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
