/datum/component/wise_tree_alert

/datum/component/wise_tree_alert/Initialize()
    . = ..()

    RegisterSignal(SSdcs, COMSIG_SACRED_TREE_DAMAGED, PROC_REF(wise_tree_damaged))

/datum/component/wise_tree_alert/proc/wise_tree_damaged(obj/structure/flora/roguetree/wise/druids/tree, damage_amount)
    SIGNAL_HANDLER

    to_chat(parent, span_danger("The Great Tree of Time was damaged at Druids grove from someone!"))

/datum/component/wise_tree_alert/Destroy(force)
    UnregisterSignal(SSdcs, COMSIG_SACRED_TREE_DAMAGED)
    return ..()
