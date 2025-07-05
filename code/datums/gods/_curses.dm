/mob/living/carbon/human
    var/list/curses = list()
    var/last_curse_time = 0

/mob/living/carbon/human/proc/handle_curses()
    for(var/curse in curses)
        var/datum/curse/C = curse
        C.on_life(src)

/mob/living/carbon/human/proc/add_curse(datum/curse/C)
    if(is_cursed(C))
        return FALSE

    C = new C()
    curses += C
    C.on_gain(src)
    return TRUE

/mob/living/carbon/human/proc/remove_curse(datum/curse/C)
    if(!is_cursed(C))
        return FALSE

    for(var/datum/curse/curse in curses)
        if(curse.name == C.name)
            curse.on_loss(src)
            curses -= curse
            return TRUE
    return FALSE

/mob/living/carbon/human/proc/is_cursed(datum/curse/C)
    if(!C)
        return FALSE

    for(var/datum/curse/curse in curses)
        if(curse.name == C.name)
            return TRUE
    return FALSE

/datum/curse
    var/name = "Debug Curse"
    var/description = "This is a debug curse."
    var/trait

/datum/curse/proc/on_life(mob/living/carbon/human/owner)
    return

/datum/curse/proc/on_death(mob/living/carbon/human/owner)
    return

/datum/curse/proc/on_gain(mob/living/carbon/human/owner)
    ADD_TRAIT(owner, trait, TRAIT_CURSE)
    to_chat(owner, span_userdanger("Something is wrong... I feel cursed."))
    to_chat(owner, span_danger(description))
    owner.playsound_local(get_turf(owner), 'sound/misc/excomm.ogg', 80, FALSE, pressure_affected = FALSE)
    return

/datum/curse/proc/on_loss(mob/living/carbon/human/owner)
    REMOVE_TRAIT(owner, trait, TRAIT_CURSE)
    to_chat(owner, span_userdanger("Something has changed... I feel relieved."))
    owner.playsound_local(get_turf(owner), 'sound/misc/bell.ogg', 80, FALSE, pressure_affected = FALSE)
    qdel(src)
    return


/datum/curse/ravox
    name = "Ravox's Curse"
    description = "Violence disgusts me. I cannot bring myself to wield any kind of weapon."
    trait = TRAIT_RAVOX_CURSE

/datum/curse/pestra
    name = "Pestra's Curse"
    description = "I feel sick to my stomach, and my skin is slowly starting to rot."
    trait = TRAIT_PESTRA_CURSE

/datum/curse/eora
    name = "Eora's Curse"
    description = "I am unable to show any kind of affection or love, whether carnal or platonic."
    trait = TRAIT_LIMPDICK

/datum/curse/abyssor
    name = "Abyssor's Curse"
    description = "I hear the ocean whisper in my mind. Fear of drowning has left me... but so has reason."
    trait = TRAIT_ABYSSOR_CURSE

/datum/curse/malum
    name = "Malum's Curse"
    description = "My thoughts race with endless designs I cannot build. The tools tremble in my hands."
    trait = TRAIT_MALUM_CURSE


//Pestra's Curse

/datum/curse/pestra/on_life(mob/living/carbon/human/owner)
	. = ..()
	if(owner.mob_timers["pestra_curse"])
		if(world.time < owner.mob_timers["pestra_curse"] + rand(30,60)SECONDS)
			return
	owner.mob_timers["pestra_curse"] = world.time
	var/effect = rand(1, 3)
	switch(effect)
		if(1)
			owner.vomit()
		if(2)
			owner.Unconscious(20)
		if(3)
			owner.blur_eyes(10)
