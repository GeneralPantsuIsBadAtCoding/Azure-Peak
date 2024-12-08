//entirely neutral or internal status effects go here


//Roguetown

/datum/status_effect/incapacitating/off_balanced
	id = "off_balanced"
	alert_type = /atom/movable/screen/alert/status_effect/off_balanced

/atom/movable/screen/alert/status_effect/off_balanced
	name = "Off Balanced"
	desc = ""
	icon_state = "off_balanced"

//ENDROGUE

/datum/status_effect/sigil_mark //allows the affected target to always trigger sigils while mindless
	id = "sigil_mark"
	duration = -1
	alert_type = null
	var/stat_allowed = DEAD //if owner's stat is below this, will remove itself

/datum/status_effect/sigil_mark/tick()
	if(owner.stat < stat_allowed)
		qdel(src)

/datum/status_effect/crusher_damage //tracks the damage dealt to this mob by kinetic crushers
	id = "crusher_damage"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	var/total_damage = 0

/datum/status_effect/syphon_mark
	id = "syphon_mark"
	duration = 50
	status_type = STATUS_EFFECT_MULTIPLE
	alert_type = null
	on_remove_on_mob_delete = TRUE
	var/obj/item/borg/upgrade/modkit/bounty/reward_target

/datum/status_effect/syphon_mark/on_creation(mob/living/new_owner, obj/item/borg/upgrade/modkit/bounty/new_reward_target)
	. = ..()
	if(.)
		reward_target = new_reward_target

/datum/status_effect/syphon_mark/on_apply()
	if(owner.stat == DEAD)
		return FALSE
	return ..()

/datum/status_effect/syphon_mark/proc/get_kill()
	if(!QDELETED(reward_target))
		reward_target.get_kill(owner)

/datum/status_effect/syphon_mark/tick()
	if(owner.stat == DEAD)
		get_kill()
		qdel(src)

/datum/status_effect/syphon_mark/on_remove()
	get_kill()
	. = ..()

/atom/movable/screen/alert/status_effect/in_love
	name = "In Love"
	desc = ""
	icon_state = "in_love"

/datum/status_effect/in_love
	id = "in_love"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/in_love
	var/mob/living/date

/datum/status_effect/in_love/on_creation(mob/living/new_owner, mob/living/love_interest)
	. = ..()
	if(.)
		date = love_interest
	linked_alert.desc = ""

/datum/status_effect/in_love/tick()
	if(date)
		new /obj/effect/temp_visual/love_heart/invisible(get_turf(date.loc), owner)


/datum/status_effect/throat_soothed
	id = "throat_soothed"
	duration = 60 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null

/datum/status_effect/throat_soothed/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_SOOTHED_THROAT, "[STATUS_EFFECT_TRAIT]_[id]")

/datum/status_effect/throat_soothed/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_SOOTHED_THROAT, "[STATUS_EFFECT_TRAIT]_[id]")

/datum/status_effect/bounty
	id = "bounty"
	status_type = STATUS_EFFECT_UNIQUE
	var/mob/living/rewarded

/datum/status_effect/bounty/on_creation(mob/living/new_owner, mob/living/caster)
	. = ..()
	if(.)
		rewarded = caster

/datum/status_effect/bounty/on_apply()
	to_chat(owner, span_boldnotice("I hear something behind you talking...</span> <span class='notice'>I have been marked for death by [rewarded]. If you die, they will be rewarded."))
	playsound(owner, 'sound/blank.ogg', 75, FALSE)
	return ..()

/datum/status_effect/bounty/tick()
	if(owner.stat == DEAD)
		rewards()
		qdel(src)

/datum/status_effect/bounty/proc/rewards()
	if(rewarded && rewarded.mind && rewarded.stat != DEAD)
		to_chat(owner, span_boldnotice("I hear something behind you talking...</span> <span class='notice'>Bounty claimed."))
		playsound(owner, 'sound/blank.ogg', 75, FALSE)
		to_chat(rewarded, span_greentext("I feel a surge of mana flow into you!"))
		for(var/obj/effect/proc_holder/spell/spell in rewarded.mind.spell_list)
			spell.charge_counter = spell.charge_max
			spell.recharging = FALSE
			spell.update_icon()
		rewarded.adjustBruteLoss(-25)
		rewarded.adjustFireLoss(-25)
		rewarded.adjustToxLoss(-25)
		rewarded.adjustOxyLoss(-25)
		rewarded.adjustCloneLoss(-25)

/datum/status_effect/bugged //Lets another mob hear everything you can
	id = "bugged"
	duration = -1
	status_type = STATUS_EFFECT_MULTIPLE
	alert_type = null
	var/mob/living/listening_in

/datum/status_effect/bugged/on_apply(mob/living/new_owner, mob/living/tracker)
	. = ..()
	if (.)
		RegisterSignal(new_owner, COMSIG_MOVABLE_HEAR, PROC_REF(handle_hearing))

/datum/status_effect/bugged/on_remove()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOVABLE_HEAR)

/datum/status_effect/bugged/proc/handle_hearing(datum/source, list/hearing_args)
	listening_in.show_message(hearing_args[HEARING_MESSAGE])

/datum/status_effect/bugged/on_creation(mob/living/new_owner, mob/living/tracker)
	. = ..()
	if(.)
		listening_in = tracker

//Xylix Gambling
var/wheeleffect
/datum/status_effect/wheel
	id = "lucky(?)"
	status_type = STATUS_EFFECT_UNIQUE
	effectedstats = list("fortune" = "?")
	duration = 3000 //five minutes
	
/datum/status_effect/wheel/on_apply()
	. = ..()
	switch(pick(-5,-4,-3,-2,-1,0,1,2,3,4,5))
		if(-5)
			owner.change_stat("fortune", -5)
			to_chat(owner, span_boldnotice("My heart sinks, I feel as though I've lost something!"))
			wheeleffect = -5
		if(-4)
			owner.change_stat("fortune", -4)
			to_chat(owner, span_boldnotice("My heart sinks, I feel as though I've lost something!"))
			wheeleffect = -4
		if(-3)
			owner.change_stat("fortune", -3)
			to_chat(owner, span_boldnotice("My heart sinks, I feel as though I've lost something!"))
			wheeleffect = -3
		if(-2)
			owner.change_stat("fortune", -2)
			to_chat(owner, span_boldnotice("My heart sinks, I feel as though I've lost something!"))
			wheeleffect = -2
		if(-1)
			owner.change_stat("fortune", -1)
			to_chat(owner, span_boldnotice("My heart sinks, I feel as though I've lost something!"))
			wheeleffect = -1
		if(0)
			owner.change_stat("fortune", 0)
			to_chat(owner, span_boldnotice("My heart beats, I feel as though nothing has changed at all..."))
			wheeleffect = 0
		if(1)
			owner.change_stat("fortune", 1)
			to_chat(owner, span_boldnotice("My heart flutters, I feel as though I won the lottery!"))
			wheeleffect = 1
		if(2)
			owner.change_stat("fortune", 2)
			to_chat(owner, span_boldnotice("My heart flutters, I feel as though I won the lottery!"))
			wheeleffect = 2
		if(3)
			owner.change_stat("fortune", 3)
			to_chat(owner, span_boldnotice("My heart flutters, I feel as though I won the lottery!"))
			wheeleffect = 3
		if(4)
			owner.change_stat("fortune", 4)
			to_chat(owner, span_boldnotice("My heart flutters, I feel as though I won the lottery!"))
			wheeleffect = 4
		if(5)
			owner.change_stat("fortune", 5)
			to_chat(owner, span_boldnotice("My heart flutters, I feel as though I won the lottery!"))
			wheeleffect = 5									

/datum/status_effect/wheel/on_remove()
	. = ..()
	if(wheeleffect == -5)
		owner.change_stat("fortune", 5)
	if(wheeleffect == -4)
		owner.change_stat("fortune", 4)
	if(wheeleffect == -3)
		owner.change_stat("fortune", 3)
	if(wheeleffect == -2)
		owner.change_stat("fortune", 2)
	if(wheeleffect == -1)
		owner.change_stat("fortune", 1)
	if(wheeleffect == 0)
		owner.change_stat("fortune", 0)
	if(wheeleffect == 1)
		owner.change_stat("fortune", -1)
	if(wheeleffect == 2)
		owner.change_stat("fortune", -2)
	if(wheeleffect == 3)
		owner.change_stat("fortune", -3)
	if(wheeleffect == 4)
		owner.change_stat("fortune", -4)
	if(wheeleffect == 5)
		owner.change_stat("fortune", -5)

/atom/movable/screen/alert/status_effect/wheel
	name = "Lucky(?)"
	desc = "I feel different since my fortune was changed..."
	icon_state = "asleep"	
