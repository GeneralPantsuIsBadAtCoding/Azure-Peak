/datum/element/baothas_bite

/datum/element/baothas_bite/Attach(datum/target)
    if(!iscarbon(target))
        return ELEMENT_INCOMPATIBLE

    RegisterSignal(target, COMSIG_CARBON_BITE, PROC_REF(apply_effect))
    RegisterSignal(target, COMSIG_CARBON_CHEW, PROC_REF(apply_effect))

    return ..()

/datum/element/baothas_bite/proc/apply_effect(mob/living/carbon/user, mob/living/carbon/target)
    SIGNAL_HANDLER

    if(target.stat || !prob(30))
        return

    target.reagents.add_reagent(/datum/reagent/herozium, 10)
