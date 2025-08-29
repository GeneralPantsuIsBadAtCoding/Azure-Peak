/mob/living/carbon/human/proc/disguise_verb()
	set name = "Disguise"
	set category = "VAMPIRE"

	var/datum/component/vampire_disguise/disguise_comp = GetComponent(/datum/component/vampire_disguise)
	if(!disguise_comp)
		to_chat(src, span_warning("I cannot disguise myself."))
		return

	if(disguise_comp.disguised)
		disguise_comp.remove_disguise(src)
	else
		disguise_comp.apply_disguise(src)

/mob/living/carbon/human/proc/vampire_disguise(datum/antagonist/vampire/VD)
	if(clan)
		return
	var/datum/component/vampire_disguise/disguise_comp = GetComponent(/datum/component/vampire_disguise)
	disguise_comp.apply_disguise(src)

/mob/living/carbon/human/proc/vampire_undisguise(datum/antagonist/vampire/VD)
	if(clan)
		return
	var/datum/component/vampire_disguise/disguise_comp = GetComponent(/datum/component/vampire_disguise)
	disguise_comp.remove_disguise(src)
