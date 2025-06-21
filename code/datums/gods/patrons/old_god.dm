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
	/obj/item/alch/salvia,
	/obj/item/alch/artemisia,
	/obj/item/alch/rosa,
	/obj/item/rogueweapon/huntingknife/idagger/navaja,
	/obj/item/lockpick,
	/obj/item/reagent_containers/glass/bottle/alchemical/strpot,
	/obj/item/reagent_containers/glass/bottle/alchemical/endpot,
	/obj/item/reagent_containers/glass/bottle/alchemical/conpot,
	/obj/item/reagent_containers/glass/bottle/alchemical/lucpot,
	/obj/item/reagent_containers/glass/bottle/rogue/poison,
	/obj/item/reagent_containers/glass/bottle/rogue/healthpot,
	/obj/item/needle,
	/obj/item/natural/rock,
	/obj/item/natural/bundle/cloth,
	/obj/item/natural/bundle/fibers,
	/obj/item/clothing/suit/roguetown/armor/leather/hide/bikini,
	/obj/item/reagent_containers/glass/bottle/waterskin/milk,
	/obj/item/reagent_containers/food/snacks/rogue/bread,
	/obj/item/reagent_containers/food/snacks/grown/apple,
	/obj/item/natural/worms,
	/obj/item/natural/worms/leech,
	/obj/item/reagent_containers/food/snacks/rogue/psycrossbun,
	/obj/item/clothing/neck/roguetown/psicross,
	/obj/item/clothing/neck/roguetown/psicross/wood,
	/obj/item/rope/chain,
	/obj/item/rope,
	/obj/item/clothing/neck/roguetown/collar,
	/obj/item/natural/dirtclod,
	/obj/item/reagent_containers/glass/cup/wooden,
	/obj/item/natural/glass,
	/obj/item/clothing/shoes/roguetown/sandals,
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



/////////////////////////////////
// Does God Hear Your Prayer ? //
/////////////////////////////////
// no he's dead - ok maybe he does

/datum/patron/old_god/can_pray(mob/living/follower)
	. = TRUE
	// Allows prayer near psycross.
	for(var/obj/structure/fluff/psycross/cross in view(4, get_turf(follower)))
		if(cross.divine == FALSE)
			to_chat(follower, span_danger("That defiled cross interupts my prayers!"))
			return FALSE
		return TRUE
	// Allows prayer if raining and outside. Psydon weeps.
	if(GLOB.forecast == "rain")
		if(istype(get_area(follower), /area/rogue/outdoors))
			return TRUE
	// Allows prayer if bleeding.
	if(follower.bleed_rate > 0)
		return TRUE
	// Allows prayer if holding silver psycross.
	if(istype(follower.get_active_held_item(), /obj/item/clothing/neck/roguetown/psicross/silver))
		return TRUE
	to_chat(follower, span_danger("For Psydon to hear my prayer I must either must be near a Pantheon Cross, shed my own blood in penitence, hold one of his silver holy symbols, or bask in his rain; as Psydon weeps for his children.."))
	return FALSE
