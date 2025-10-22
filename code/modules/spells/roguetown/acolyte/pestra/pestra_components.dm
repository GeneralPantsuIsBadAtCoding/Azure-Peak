/datum/component/infestation_charges
	var/current_charges = 0
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/obj/effect/proc_holder/spell/invoked/infestation/parent_spell
	var/mob/living/parent_mob
	var/was_at_max = FALSE
	var/last_rebirth_use = 0
	var/next_rebirth_use = 20 MINUTES

/datum/component/infestation_charges/Initialize(obj/effect/proc_holder/spell/invoked/infestation/spell)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	parent_spell = spell
	parent_mob = parent
	current_charges = 0
	next_rebirth_use = 0
	RegisterSignal(parent_spell, COMSIG_INFESTATION_CHARGE_ADD, PROC_REF(add_charge))
	RegisterSignal(parent_mob, COMSIG_INFESTATION_CHARGE_REMOVE, PROC_REF(remove_charge))
	RegisterSignal(parent_mob, COMSIG_DIVINE_REBIRTH_CAST, PROC_REF(divine_rebirth_cast))

/datum/component/infestation_charges/proc/add_charge(source, charge_amount)
	SIGNAL_HANDLER
	var/max_charges = SSchimeric_tech.get_infestation_max_charges()
	var/cooldown_active = FALSE
	if(world.time < last_rebirth_use + next_rebirth_use)
		max_charges = 10
		cooldown_active = TRUE
	current_charges = min(current_charges + charge_amount, max_charges)
	var/rounded_charges = get_charges()
	if(parent_spell)
		parent_spell.update_charge_overlay(rounded_charges)
	// This is the only value update that isn't handled by the healing spell's internal logic, so we call the update here.
	if(rounded_charges == 1)
		var/obj/effect/proc_holder/spell/invoked/pestra_heal/heal_spell = parent_mob.mind?.get_spell(/obj/effect/proc_holder/spell/invoked/pestra_heal)
		if(heal_spell)
			heal_spell.update_charges(get_charges())
	if(!cooldown_active && current_charges >= max_charges && !was_at_max)
		was_at_max = TRUE
		// Effectively a T4 spell in strength, as such, only pestrans get this.
		if(parent_mob.get_skill_level(/datum/skill/magic/holy) >= 5)
			grant_divine_rebirth()

/datum/component/infestation_charges/proc/remove_charge(source, charge_amount)
	SIGNAL_HANDLER
	current_charges = max(current_charges - charge_amount, 0)
	if(parent_spell)
		parent_spell.update_charge_overlay(get_charges())
	var/max_charges = SSchimeric_tech.get_infestation_max_charges()
	if(was_at_max && current_charges < max_charges)
		was_at_max = FALSE
		remove_divine_rebirth()

/datum/component/infestation_charges/proc/get_charges()
	return floor(current_charges / 10)

/datum/component/infestation_charges/Destroy()
	parent_spell = null
	return ..()

/proc/remove_infestation_charges(mob/living/user, charge_amount)
	SEND_SIGNAL(user, COMSIG_INFESTATION_CHARGE_REMOVE, 10)

/datum/component/infestation_charges/proc/grant_divine_rebirth()
	if(!parent_mob?.mind)
		return

	var/obj/effect/proc_holder/spell/invoked/divine_rebirth/existing = parent_mob.mind.get_spell(/obj/effect/proc_holder/spell/invoked/divine_rebirth)
	if(existing)
		return

	var/obj/effect/proc_holder/spell/invoked/divine_rebirth/new_spell = new()
	parent_mob.mind.AddSpell(new_spell)
	to_chat(parent_mob, span_notice("As the infestation of Pestra festers within me, I feel new power well into my core! [new_spell.name] is now available."))

/datum/component/infestation_charges/proc/remove_divine_rebirth()
	if(!parent_mob?.mind)
		return

	var/obj/effect/proc_holder/spell/invoked/divine_rebirth/existing = parent_mob.mind.get_spell(/obj/effect/proc_holder/spell/invoked/divine_rebirth)
	if(existing)
		parent_mob.mind.RemoveSpell(existing)
		to_chat(parent_mob, span_warning("As the infestation of pestra within me wanes, I am robbed of her strongest gift for now. [existing.name] is no longer available."))

/datum/component/infestation_charges/proc/divine_rebirth_cast(mob/living/user, mob/living/target)
	SIGNAL_HANDLER
	last_rebirth_use = world.time
	next_rebirth_use = initial(next_rebirth_use)
	remove_infestation_charges(100)
	user.apply_status_effect(/datum/status_effect/divine_exhaustion, next_rebirth_use)
	var/obj/effect/proc_holder/spell/invoked/pestra_heal/heal_spell = parent_mob.mind?.get_spell(/obj/effect/proc_holder/spell/invoked/pestra_heal)
	if(heal_spell)
		heal_spell.update_charges(get_charges())
	if(parent_spell)
		parent_spell.update_charge_overlay(get_charges())
	to_chat(user, span_warning("The divine power leaves me completely exhausted. I won't be able to channel such power again for some time."))
