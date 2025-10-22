/datum/component/infestation_charges
	var/current_charges = 0
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

/datum/component/infestation_charges/proc/add_charge(source, charge_amount)
	var/max_charges = SSchimeric_tech.get_infestation_max_charges()
	current_charges = min(current_charges + charge_amount, max_charges)
	var/rounded_charges = get_charges()
	if(parent_spell)
		parent_spell.update_charge_overlay(rounded_charges)
	// This is the only value update that isn't handled by the healing spell's internal logic, so we call the update here.
	if(rounded_charges == 1)
		var/obj/effect/proc_holder/spell/invoked/pestra_heal/heal_spell = parent_mob.mind?.get_spell(/obj/effect/proc_holder/spell/invoked/pestra_heal)
		if(heal_spell)
			heal_spell.update_charges(get_charges())

/datum/component/infestation_charges/proc/remove_charge(source, charge_amount)
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
