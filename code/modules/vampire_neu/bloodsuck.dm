/mob/living/carbon/human/proc/add_bite_animation()
	remove_overlay(BITE_LAYER)
	var/mutable_appearance/bite_overlay = mutable_appearance('icons/effects/clan.dmi', "bite", -BITE_LAYER)
	overlays_standing[BITE_LAYER] = bite_overlay
	apply_overlay(BITE_LAYER)
	addtimer(CALLBACK(src, PROC_REF(remove_bite)), 1.5 SECONDS)

/mob/living/carbon/human/proc/remove_bite()
	remove_overlay(BITE_LAYER)

/mob/living/carbon/human/proc/drinksomeblood(mob/living/mob)
	last_drinkblood_use = world.time

	if(mob.bloodpool <= 1 && mob.maxbloodpool > 1)
		to_chat(src, "<span class='warning'>You feel small amount of <b>BLOOD</b> in your victim.</span>")
		if(mob.clan)
			if(!mob.client)
				to_chat(src, "<span class='warning'>You need [mob]'s attention to do that...</span>")
				return
			message_admins("[ADMIN_LOOKUPFLW(src)] is attempting to Diablerize [ADMIN_LOOKUPFLW(mob)]")
			log_attack("[key_name(src)] is attempting to Diablerize [key_name(mob)].")
			if(mob.key)
				var/vse_taki = FALSE
				if(clan)
					if(clan.name != "Caitiff")
						if(!mind.special_role)
							to_chat(src, "<span class='warning'>You find the idea of drinking your own <b>KIND's</b> blood disgusting!</span>")
							last_drinkblood_use = 0
							return
						else
							vse_taki = TRUE
					else
						vse_taki = TRUE

				if(vse_taki)
					to_chat(src, "<span class='userdanger'><b>YOU TRY TO COMMIT DIABLERIE ON [mob].</b></span>")
				else
					to_chat(src, "<span class='warning'>You find the idea of drinking your own <b>KIND</b> disgusting!</span>")
					return
			else
				to_chat(src, "<span class='warning'>You need [mob]'s attention to do that...</span>")
				return

	if(do_after(src, 3 SECONDS, target = mob, progress = TRUE))
		mob.adjust_bloodpool(-50)
		if(ishuman(mob))
			var/mob/living/carbon/human/H = mob
			drunked_of |= "[H.dna.real_name]"
			H.blood_volume = max(H.blood_volume-50, 150)
			if(H.reagents)
				if(length(H.reagents.reagent_list))
					if(prob(50))
						H.reagents.trans_to(src, min(10, H.reagents.total_volume), transfered_by = mob)

		to_chat(src, "<span class='warning'>You sip some <b>BLOOD</b> from your victim. It feels good.</span>")
		adjust_bloodpool(1)
		adjustBruteLoss(-10, TRUE)
		adjustFireLoss(-10, TRUE)
		update_damage_overlays()
		update_health_hud()
		if(!mob.clan && mob.blood_volume <= BLOOD_VOLUME_SURVIVE)
			if(alert(src, "Would you like to sire a new spawn?", "THE CURSE OF KAIN", "MAKE IT SO", "I RESCIND") != "MAKE IT SO")
				to_chat(src, span_warning("I decide [mob] is unworthy."))
			else
				src.visible_message(span_danger("Some dark energy begins to flow from [src] into [mob]..."), span_userdanger("I begin siring [mob]..."))
				if(do_after(src, 3 SECONDS, mob))
					mob.visible_message(span_red("[mob] rises as a new spawn!"))
					var/datum/antagonist/vampire_neu/current_licker = mind?.has_antag_datum(/datum/antagonist/vampire_neu)
					var/datum/antagonist/vampire_neu/new_antag = new /datum/antagonist/vampire_neu(clan, TRUE, current_licker.generation - GENERATION_MODIFIER)
					mob.mind?.add_antag_datum(new_antag)
					// this is bad, should give them a healing buff instead
					sleep(2 SECONDS)
					mob.fully_heal()

		else if(mob.bloodpool <= 0)
			if(ishuman(mob))
				var/mob/living/carbon/human/K = mob
				if(mob.clan && clan)
					AdjustMasquerade(-1)
					message_admins("[ADMIN_LOOKUPFLW(src)] successfully Diablerized [ADMIN_LOOKUPFLW(mob)]")
					log_attack("[key_name(src)] successfully Diablerized [key_name(mob)].")
					mob.death()
					adjustBruteLoss(-50, TRUE)
					adjustFireLoss(-50, TRUE)
					return
				else
					K.blood_volume = 0
			if(ishuman(mob) && !mob.clan)
				if(mob.stat != DEAD)
					to_chat(src, "<span class='warning'>This sad sacrifice for your own pleasure affects something deep in your mind.</span>")
					AdjustMasquerade(-1)
					mob.death()
			if(!ishuman(mob))
				if(mob.stat != DEAD)
					mob.death()
			last_drinkblood_use = 0
			return
		if(grab_state >= GRAB_PASSIVE)
			drinksomeblood(mob)
	else
		last_drinkblood_use = 0
		mob.SetSleeping(5 SECONDS)
