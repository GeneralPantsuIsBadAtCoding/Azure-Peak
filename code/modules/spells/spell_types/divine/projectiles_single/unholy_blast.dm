/obj/effect/proc_holder/spell/invoked/projectile/divineblast/unholyblast
	name = "Unholy Blast"
	desc = "Channel unholy power and sunder the unbelievers. Deals additional damage to wretched conformists and Psydonites! \n\
	Damage is increased by 100% versus simple-minded creechurs.\n\
	Can be fired in an arc over an ally's head with a mage's staff, spellbook or psicross on arc intent. It will deals 25% less damage that way."
	projectile_type = /obj/projectile/energy/unholyblast
	invocations = list("Fortschritt macht!")

/obj/projectile/energy/unholyblast
	name = "Unholy Blast"
	icon_state = "divine_blast"
	damage = 20 // wont do much to a heretical worshipper
	woundclass = BCLASS_CUT // I REALLY wanted to do cut
	nodamage = FALSE
	npc_simple_damage_mult = 2 // The Simple Skele Gibber
	hitsound = 'sound/magic/churn.ogg'
	speed = 1

/obj/projectile/energy/unholyblast/arc
	name = "Arced Unholy Blast"
	damage = 15 // Slightly lower base damage
	arcshot = TRUE

/obj/effect/proc_holder/spell/invoked/projectile/divineblast/unholyblast/cast(list/targets, mob/user = user)
	var/mob/living/carbon/human/H = user
	var/datum/intent/a_intent = H.a_intent
	if(istype(a_intent, /datum/intent/special/magicarc))
		projectile_type = /obj/projectile/energy/unholyblast/arc
	else
		projectile_type = /obj/projectile/energy/unholyblast
	. = ..()

/obj/projectile/energy/unholyblast/on_hit(target)
	. = ..()
	if(isliving(target))
		var/mob/living/H = target
		if(H.mob_biotypes & MOB_UNDEAD)
			damage += 20
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(istype(H.patron, /datum/patron/divine))
			damage += 20
		if(istype(H.patron, /datum/patron/old_god))
			damage += 20
		if(H.mind) // vampire/ww stuff - Apply BANE debuff.
			var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
			var/datum/antagonist/vampirelord/lesser/V = H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)
			var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
			if(V)
				if(V.disguised)
					H.visible_message("<font color='white'>The unholy strike weakens the curse temporarily!</font>")
					to_chat(H, span_userdanger("I'm hit by my BANE!"))
					H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				else
					H.visible_message("<font color='white'>The unholy strike weakens the curse temporarily!</font>")
					to_chat(H, span_userdanger("I'm hit by my BANE!"))
					H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
			if(V_lord)
				if(V_lord.vamplevel < 4 && !V)
					H.visible_message("<font color='white'>The unholy strike weakens the curse temporarily!</font>")
					to_chat(H, span_userdanger("I'm hit by my BANE!"))
					H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				if(V_lord.vamplevel == 4 && !V)
					H.visible_message(H, span_userdanger("This unholy upstart can't hurt me, I AM ANCIENT!"))
			if(W && W.transformed == TRUE)
				H.visible_message("<font color='white'>The unholy strike weakens the curse temporarily!</font>")
				to_chat(H, span_userdanger("I'm hit by my BANE!"))
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
		var/mob/living/carbon/human/caster
		if (ishuman(firer))
			caster = firer
			switch(caster.patron.type)
				if(/datum/patron/inhumen/baotha)
					H.adjustToxLoss(10)
					H.Dizzy(5)
				if(/datum/patron/inhumen/matthios)
					if(HAS_TRAIT(H, TRAIT_NOBLE))
						damage += 10 
						H.adjust_fire_stacks(4)
					H.adjust_fire_stacks(2)
					H.IgniteMob()
				if(/datum/patron/inhumen/graggar)
					H.visible_message(span_warning("A splatter of blood covers [H]'s face!"), span_warning("A glob of blood splatters my vision!"))
					H.Dizzy(5)
					H.blur_eyes(5)
				if(/datum/patron/inhumen/zizo)
					if(istype(H.patron, /datum/patron/divine/necra)) //Hilarious
						H.adjust_fire_stacks(6)
						H.IgniteMob()
					H.Slowdown(3) 
					H.visible_message(span_warning("Seething ambition sears within [H]'s mind!"), span_warning("Visions of progress and ambition sear into my mind!"))
	else
		return




