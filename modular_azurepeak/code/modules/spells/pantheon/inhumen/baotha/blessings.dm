/datum/baotha_blessing
    var/name

/datum/baotha_blessing/proc/apply(mob/living/carbon/human/human)
    return

/datum/baotha_blessing/heartbreak
    name = "Heartbreak (bardic inspiration)"

/datum/baotha_blessing/heartbreak/apply(mob/living/carbon/human/human)
    ADD_TRAIT(human, TRAIT_GOODLOVER, src)
    ADD_TRAIT(human, TRAIT_EMPATH, src)
    ADD_TRAIT(human, TRAIT_EXTEROCEPTION, src)

    var/datum/inspiration/inspiration = new /datum/inspiration(human)
    inspiration.grant_inspiration(human, bard_tier = BARD_T2)

    human.charflaw = new /datum/charflaw/addiction/lovefiend(human)

/datum/baotha_blessing/joy
    name = "Joy (nudist, cool purple aura)"

/datum/baotha_blessing/joy/apply(mob/living/carbon/human/human)
    ADD_TRAIT(human, TRAIT_NUDIST, src)

    human.unequip_everything()
    
    human.remove_status_effect(/datum/status_effect/buff/druqks)
    human.apply_status_effect(/datum/status_effect/buff/druqks/baotha/joybringer)

/datum/baotha_blessing/feast
    name = "Feast (on-chew/on-bite effect, rot and organ eater)"

/datum/baotha_blessing/feast/apply(mob/living/carbon/human/human)
    ADD_TRAIT(human, TRAIT_ROT_EATER, src)
    ADD_TRAIT(human, TRAIT_ORGAN_EATER, src)

    human.AddElement(/datum/element/baothas_bite)
