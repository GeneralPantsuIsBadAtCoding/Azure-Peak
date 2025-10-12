/datum/status_effect/buff/playing_melody
	id = "play_melody"
	alert_type = /atom/movable/screen/alert/status_effect/buff/playing_melody
	var/effect_color
	var/datum/status_effect/buff/buff_to_apply
	var/pulse = 0
	var/ticks_to_apply = 10


/atom/movable/screen/alert/status_effect/buff/playing_melody
	name = "Playing Melody"
	desc = "Healing the world with my craft."
	icon_state = "buff"


/datum/status_effect/buff/playing_melody/tick()
	var/mob/living/carbon/human/O = owner
	if(!O.inspiration)
		return
	pulse += 1
	if (pulse >= ticks_to_apply)
		pulse = 0
		for (var/mob/living/carbon/human/H in hearers(7, owner))
			if(!O.in_audience(H))
				return
			if (!H.has_status_effect(buff_to_apply))
				H.apply_status_effect(buff_to_apply)






/obj/effect/proc_holder/spell/invoked/song/rejuvenation_song
	name = "Rejuvenation Song"
	desc = "Recuperate your allies bodies with your song! Refills health slowly over time!"
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
	invocations = list("Broken bones mend, flesh knits, to the hymn!") 
	invocation_type = "shout"


/obj/effect/proc_holder/spell/invoked/song/rejuvenation_song/cast(mob/living/user = usr)
	if(user.has_status_effect(/datum/status_effect/buff/playing_music))
		user.apply_status_effect(/datum/status_effect/buff/playing_melody/rejuvenation)
	else
		revert_cast()
		return



/datum/status_effect/buff/playing_melody/rejuvenation
	buff_to_apply = /datum/status_effect/buff/healing/rejuvenationsong
	
/datum/status_effect/buff/healing/rejuvenationsong
	id = "healing"
	alert_type = /atom/movable/screen/alert/status_effect/buff/healing
	duration = 10 SECONDS
	healing_on_tick = 0.2
	outline_colour = "#b12f9b"

/datum/status_effect/buff/healing/rejuvenationsong/on_apply()
	healing_on_tick = max(owner.get_skill_level(/datum/skill/misc/music)*0.1, 0.6)
	return TRUE

/datum/status_effect/buff/healing/rejuvenationsong/tick()
	var/obj/effect/temp_visual/heal/H = new /obj/effect/temp_visual/heal_rogue(get_turf(owner))
	H.color = "#660759"
	var/list/wCount = owner.get_wounds()
	if(!owner.construct)
		if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
			owner.blood_volume = min(owner.blood_volume + (healing_on_tick + 1), BLOOD_VOLUME_NORMAL)
		if(wCount.len > 0)
			owner.heal_wounds(healing_on_tick, list(/datum/wound/slash, /datum/wound/puncture, /datum/wound/bite, /datum/wound/bruise))
			owner.update_damage_overlays()
		owner.adjustBruteLoss(-healing_on_tick, 0)
		owner.adjustFireLoss(-healing_on_tick, 0)
		owner.adjustOxyLoss(-healing_on_tick, 0)
		owner.adjustToxLoss(-healing_on_tick, 0)
		owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -healing_on_tick)
		owner.adjustCloneLoss(-healing_on_tick, 0)
