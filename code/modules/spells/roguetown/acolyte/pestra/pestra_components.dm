/datum/component/infestation_charges
	var/current_charges = 0
	var/max_charges = 100
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/obj/effect/proc_holder/spell/invoked/infestation/parent_spell
	var/mob/living/parent_mob

/datum/component/infestation_charges/Initialize(obj/effect/proc_holder/spell/invoked/infestation/spell)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	parent_spell = spell
	parent_mob = parent
	current_charges = 0

	RegisterSignal(parent_spell, COMSIG_INFESTATION_CHARGE_ADD, PROC_REF(add_charge))
	RegisterSignal(parent_mob, COMSIG_INFESTATION_CHARGE_REMOVE, PROC_REF(remove_charge))

/datum/component/infestation_charges/proc/add_charge(charge_amount)
	current_charges = min(current_charges + charge_amount, max_charges)
	if(parent_spell)
		parent_spell.update_charge_overlay(get_charges())

/datum/component/infestation_charges/proc/remove_charge(charge_amount)
	current_charges = max(current_charges - charge_amount, 0)
	if(parent_spell)
		parent_spell.update_charge_overlay(get_charges())

/datum/component/infestation_charges/proc/get_charges()
	return floor(current_charges / 10)

/datum/component/infestation_charges/Destroy()
	parent_spell = null
	return ..()

/proc/remove_infestation_charges(mob/living/user, charge_amount)
	SEND_SIGNAL(user, COMSIG_INFESTATION_CHARGE_REMOVE, 10)
