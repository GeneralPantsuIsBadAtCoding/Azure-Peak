/datum/reagent/consumable/ethanol/beer/emberwine
	name = "Emberwine"
	boozepwr = 10
	taste_description = "searing sweetness"
	taste_mult = 0.5
	quality = DRINK_VERYGOOD
	metabolization_rate = 0.02 * REAGENTS_METABOLISM
	overdose_threshold = 16
	addiction_threshold = 24 //Five sips, or a full goblet (and then some, because it metabolizes while you're drinking)
	var/addiction_permanent = TRUE
	color = "#721a46"

/datum/reagent/consumable/ethanol/beer/emberwine/on_mob_metabolize(mob/living/carbon/human/C)
	..()
	C.sexcon.aphrodisiac++

/datum/reagent/consumable/ethanol/beer/emberwine/on_mob_end_metabolize(mob/living/carbon/human/C)
	C.sexcon.aphrodisiac--
	..()

/datum/reagent/consumable/ethanol/beer/emberwine/on_mob_life(mob/living/carbon/human/C)
	var/datum/sex_controller/S = C.sexcon
	var/high_message = pick("Your stomach feels hot.", "Your skin feels prickly to the touch.", "Your loins throb involuntarily.", "Your heart beats irregularly.", "You feel cold sweat running down your neck.")
	switch(current_cycle)
		if(0 to 19)
			current_cycle++
			return //Dormant
		if(20)
			to_chat(C, "<span class='aphrodisiac'>You feel a warm glow spreading through your stomach.</span>")
		if(21 to 25)
			S.adjust_arousal(5)
		if(26 to INFINITY)
			C.apply_status_effect(/datum/status_effect/debuff/emberwine)
			if(S.arousal_frozen)
				S.arousal_frozen = FALSE
			if(S.arousal < 51)
				S.set_arousal(55) //Just enough to be above the frustration threshold.
			if(prob(8))
				C.emote("sexmoanlight", forced = TRUE)
				to_chat(C, "<span class='love_high'>[high_message]</span>")
				if(istype(C.wear_armor, /obj/item/clothing))
					var/obj/item/clothing/CL = C.wear_armor
					switch(CL.armor_class)
						if(3)
							C.Immobilize(30)
							C.set_blurriness(5)
							to_chat(C, "<span class='warning'>Your armor chaffs uncomfortably against your skin and makes it difficult to breathe.</span>")
						if(2)
							C.Immobilize(15)
							C.set_blurriness(2)
							to_chat(C, "<span class='warning'>Your armor chaffs uncomfortably against your skin.</span>")
			S.adjust_charge(8)
	return ..()

/datum/reagent/consumable/ethanol/beer/emberwine/overdose_start(mob/living/carbon/human/C)
	if(current_cycle < 20)
		current_cycle = 20
		to_chat(C, "<span class='aphrodisiac'>You feel a warm glow spreading through your stomach.</span>")
		stoplag(10)
	to_chat(C, "<span class='aphrodisiac'>The glow in your stomach spreads, rushing to your head and warming your face.</span>")
	metabolization_rate = 0.1 * REAGENTS_METABOLISM //Purges faster while overdosing because this is really debilitating
	C.emote("sexmoanhvy", forced = TRUE)
	C.sexcon.aphrodisiac++
	C.Jitter(20)
	C.Stun(15)

/datum/reagent/consumable/ethanol/beer/emberwine/overdose_process(mob/living/carbon/human/C)
	if(prob(5))
		C.emote("sexmoanhvy", forced = TRUE)
		C.Stun(15)
		C.set_blurriness(5)

/datum/reagent/consumable/ethanol/beer/emberwine/addiction_act_stage3(mob/living/carbon/human/C)
	SEND_SIGNAL(C, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/withdrawal_severe, name)
	if(prob(20))
		to_chat(C, span_danger("I have an intense craving for [name]."))
		C.sexcon.adjust_arousal(5)
	if(istype(C, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = C
		if(!istype(H.charflaw, /datum/charflaw/addiction/lovefiend))
			H.charflaw = new /datum/charflaw/addiction/lovefiend(H)
	return

/datum/reagent/consumable/ethanol/beer/emberwine/addiction_act_stage4(mob/living/carbon/human/C)
	var/datum/sex_controller/S = C.sexcon
	SEND_SIGNAL(C, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/withdrawal_severe, name) //Not critical because they'll already be getting blueballed.
	if(!S.arousal_frozen)
		S.arousal_frozen = TRUE
	C.sexcon.arousal = 40
	if(S.aphrodisiac < 1.5)
		S.aphrodisiac = 1.5
	if(prob(10))
		to_chat(C, span_boldannounce("The feeling in your loins has subsided to a dull ache. Only more [name] would scratch the itch..."))
	return
