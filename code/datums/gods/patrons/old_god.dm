/datum/patron/old_god
	name = "Psydon"
	domain = "God of Ontological Reality"
	desc = "The true God of everything, Psydon is maximally good - He created humen in his image to live in Psydonia, and defended the Azure Basin by sending the COMET SYON to defeat the rampaging archdemon."
	worshippers = "Fanatics and Nostalgists"
	associated_faith = /datum/faith/old_god
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison			= CLERIC_ORI,
					/obj/effect/proc_holder/spell/self/check_boot				= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 			= CLERIC_T1,
	)
	confess_lines = list(
		"THERE IS ONLY ONE TRUE GOD!",
		"PSYDON YET LIVES! PSYDON YET ENDURES!",
		"REBUKE THE HERETICAL- PSYDON ENDURES!",
	)

/obj/effect/proc_holder/spell/self/check_boot
	name = "Check Your Boot"
	releasedrain = 10
	chargedrain = 0
	chargetime = 0
	chargedloop = null
	sound = null
	overlay_state = "psy"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 10 MINUTES
	miracle = TRUE
	devotion_cost = 30
	range = 1
	var/static/list/lootpool = list(/obj/item/flowercrown/rosa,
	/obj/item/bouquet/rosa,
	/obj/item/jingle_bells,
	/obj/item/bouquet/salvia,
	/obj/item/bouquet/calendula,
	/obj/item/roguecoin/gold,
	/obj/item/roguecoin/silver,
	/obj/item/roguecoin/copper,
	/obj/item/alch/atropa,
	/obj/item/alch/matricaria,
	/obj/item/alch/symphitum,
	/obj/item/alch/taraxacum,
	/obj/item/alch/euphrasia,
	/obj/item/alch/paris,
	/obj/item/alch/calendula,
	/obj/item/alch/mentha,
	/obj/item/alch/urtica,
	/obj/item/alch/salvia,
	/obj/item/alch/hypericum,
	/obj/item/alch/benedictus,
	/obj/item/alch/valeriana,
	/obj/item/alch/artemisia,
	/obj/item/alch/rosa,
	/obj/item/alch/transisdust)
	
/obj/effect/proc_holder/spell/self/check_boot/cast(list/targets, mob/user = usr)
	. = ..()
	if(!ishuman(user))
		revert_cast()
		return FALSE
	var/mob/living/carbon/human/H = user
	var/obj/item/found_thing
	if(H.get_stress_amount() > 0 && H.STALUC > 10)
		found_thing = new /obj/item/roguecoin/gold
	else if(H.STALUC == 10)
		found_thing = new /obj/item/roguecoin/silver
	else
		found_thing = new /obj/item/roguecoin/copper
	to_chat(H, span_info("A coin in my boot? Psydon smiles upon me!"))
	H.put_in_hands(found_thing, FALSE)
	if(prob(H.STALUC + H.mind?.get_skill_level(associated_skill)))
		var/obj/item/extra_thing = pick(lootpool)
		new extra_thing(get_turf(user))
		to_chat(H, span_info("Ah, of course! I almost forgot I had this stashed away for a perfect occasion."))
		H.put_in_hands(extra_thing, FALSE)
	return TRUE


