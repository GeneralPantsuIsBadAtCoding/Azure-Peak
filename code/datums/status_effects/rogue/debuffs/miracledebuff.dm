///////////////////////////
// Gods Related Debuffs  //
///////////////////////////

//if it relates to the gods, it should go here. May have some overlap with antags


//apostasy 
/datum/status_effect/debuff/apostasy
	id = "Apostasy!"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/apostasy
	effectedstats = list("fortune" = -5, "intelligence" = -3, "perception" = -2 , "speed" = -2, "endurance" = -2, "constitution" = -2)
	duration = -1
	var/resistant = FALSE
	var/original_devotion = 0
	var/original_prayer_effectiveness = 0
	var/original_passive_devotion_gain = 0
	var/original_passive_progression_gain = 0

/datum/status_effect/debuff/apostasy/on_creation(mob/living/new_owner, resistant = FALSE)
	src.resistant = resistant
	return ..()

/datum/status_effect/debuff/apostasy/on_apply()
	. = ..()
	if(!ishuman(owner))
		return FALSE
	var/mob/living/carbon/human/H = owner
	if(!H.devotion)
		return FALSE

	var/datum/devotion/D = H.devotion
	original_devotion = D.devotion
	original_prayer_effectiveness = D.prayer_effectiveness
	original_passive_devotion_gain = D.passive_devotion_gain
	original_passive_progression_gain = D.passive_progression_gain

	if(resistant)
		D.devotion = original_devotion * 0.5
		D.prayer_effectiveness = original_prayer_effectiveness * 0.5
		D.passive_devotion_gain = original_passive_devotion_gain * 0.5
		D.passive_progression_gain = original_passive_progression_gain * 0.5
	else
		D.devotion = 0
		D.prayer_effectiveness = 0
		D.passive_devotion_gain = 0
		D.passive_progression_gain = 0

	to_chat(H, span_boldnotice("I have been excommunicated. I am now unable to gain devotion."))
	return ..()

/datum/status_effect/debuff/apostasy/on_remove()
	. = ..()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.devotion)
			var/datum/devotion/D = H.devotion
			D.devotion = original_devotion
			D.prayer_effectiveness = original_prayer_effectiveness
			D.passive_devotion_gain = original_passive_devotion_gain
			D.passive_progression_gain = original_passive_progression_gain

		to_chat(H, span_boldnotice("I have been welcomed back to the Church. I am now able to gain devotion again."))

/atom/movable/screen/alert/status_effect/debuff/apostasy
	name = "Apostasy!"
	desc = "Shame upon the member of clergy!"
	icon_state = "debuff"
	color ="#7a0606"

/datum/status_effect/debuff/excomm
	id = "Excommunicated!"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/excomm
	effectedstats = list("fortune" = -2, "intelligence" = -2, "speed" = -1, "endurance" = -1, "constitution" = -1)
	duration = -1

/atom/movable/screen/alert/status_effect/debuff/excomm
	name = "Excommunicated!"
	desc = "The Ten have forsaken me!"
	icon_state = "muscles"
	color ="#6d1313"

/datum/status_effect/debuff/hereticsermon
	id = "Heretic on sermon!"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hereticsermon
	effectedstats = list("intelligence" = -2, "speed" = -2, "fortune" = -2)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/debuff/hereticsermon
	name = "Heretic on sermon!"
	desc = "I was on the sermon. My patron is not proud of me."
	icon_state = "debuff"
	color ="#af9f9f"

/datum/status_effect/debuff/ritesexpended
	id = "ritesexpended"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/ritesexpended
	duration = 30 MINUTES

/atom/movable/screen/alert/status_effect/debuff/ritesexpended
	name = "Rites Complete"
	desc = "It will take time before I can next perform a rite."
	icon_state = "ritesexpended"

/datum/status_effect/debuff/ritesexpended_heavy
	id = "ritesexpended_heavy"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/ritesexpended_heavy
	duration = 1 HOURS

/atom/movable/screen/alert/status_effect/debuff/ritesexpended_heavy
	name = "Rites Complete"
	desc = "It will take a lot of time before I can perform a next rite. I am drained."
	icon_state = "ritesexpended"

//revival debuffs
/atom/movable/screen/alert/status_effect/nutrition_drain
	name = "Metabolic Acceleration"
	desc = "Your body is burning energy at an accelerated rate!"
	icon_state = "nutrition_drain"

/datum/status_effect/debuff/metabolic_acceleration
	id = "metabolic_accel"
	alert_type = /atom/movable/screen/alert/status_effect/nutrition_drain
	tick_interval = 1 MINUTES
	duration = 15 MINUTES

/datum/status_effect/debuff/metabolic_acceleration/tick()
	if(!owner || owner.stat == DEAD)
		qdel(src)
		return

	if(HAS_TRAIT(owner, TRAIT_NOHUNGER))
		// For those without hunger, drain blood instead. CONSEQUENCES FOR MY TRAIT CHOICES?!
		if(ishuman(owner))
			var/mob/living/carbon/human/H = owner
			H.blood_volume = max(H.blood_volume - 100, BLOOD_VOLUME_SURVIVE)
	else
		// For normal humans, drain nutrition
		owner.adjust_nutrition(-100)

/datum/status_effect/debuff/metabolic_acceleration/on_creation(mob/living/new_owner)
	effectedstats = list(
		"constitution" = -5
	)

	return ..()

/datum/status_effect/debuff/dreamfiend_curse
	id = "dreamfiend_curse"
	alert_type = /atom/movable/screen/alert/status_effect/dreamfiend_curse
	/// Type of dreamfiend to summon
	var/dreamfiend_type
	var/obj/effect/proc_holder/spell/invoked/summon_dreamfiend_curse/curse_spell

/datum/status_effect/debuff/dreamfiend_curse/on_creation(mob/living/new_owner)
	// Choose dreamfiend type from weighted list
	var/list/dreamfiend_types = list(
		/mob/living/simple_animal/hostile/rogue/dreamfiend = 50,
		/mob/living/simple_animal/hostile/rogue/dreamfiend/major = 49,
		/mob/living/simple_animal/hostile/rogue/dreamfiend/ancient = 1
	)
	dreamfiend_type = pickweight(dreamfiend_types)

	effectedstats = list(
		"strength" = 1,
		"intelligence" = -5,
		"fortune" = -5,
		"speed" = -2,
		"perception" = -5
	)

	// Add summoning spell to the victim
	if(!new_owner.mind?.has_spell(/obj/effect/proc_holder/spell/invoked/abyssal_strength))
		curse_spell = new(new_owner)
		new_owner.mind?.AddSpell(curse_spell)
		curse_spell.dreamfiend_type = dreamfiend_type
		curse_spell.timed_cooldown = world.time + 5 MINUTES

	. = ..()

	switch(dreamfiend_type)
		if(/mob/living/simple_animal/hostile/rogue/dreamfiend/ancient)
			linked_alert.icon_state = "dreamfiend_ancient"
			linked_alert.name = "Grand Abyssal Curse."
			linked_alert.desc = "A terrifying presence if felt fraying the edges of my mind. This is a threat I cannot face alone."
		if(/mob/living/simple_animal/hostile/rogue/dreamfiend/major)
			linked_alert.icon_state = "dreamfiend_major"
			linked_alert.name = "Major Abyssal Curse."
			linked_alert.desc = "A great deamon is sapping my mind, a dangerous foe which I must summon to regain my faculties."
		if(/mob/living/simple_animal/hostile/rogue/dreamfiend)
			linked_alert.icon_state = "dreamfiend"

/atom/movable/screen/alert/status_effect/dreamfiend_curse
	name = "Abyssal Curse."
	desc = "A nightmare entity has revived you, but now it is draining your vitality. Summon it to confront it."

/datum/status_effect/debuff/random_revival
	id = "random_revival_debuff"
	duration = 2 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/random_revival

/datum/status_effect/debuff/random_revival/on_apply()
	. = ..()
	// 10% chance for special teleport effect
	if(prob(10))
		apply_teleport_effect()
	else
		// 90% chance for normal debuff
		apply_random_debuff()
		if(prob(33))
			apply_random_debuff()
		if(prob(20))
			apply_random_debuff()

	return TRUE

/datum/status_effect/debuff/random_revival/proc/apply_random_debuff()
	var/static/list/possible_debuffs = list(
		/datum/status_effect/debuff/revived,
		/datum/status_effect/debuff/dreamfiend_curse,
		/datum/status_effect/debuff/metabolic_acceleration,
		/datum/status_effect/debuff/malum_revival,
		/datum/status_effect/debuff/ravox_revival,
		/datum/status_effect/debuff/dendor_revival,
		/datum/status_effect/debuff/noc_revival,
	)
	var/debuff_type = pick(possible_debuffs)
	owner.apply_status_effect(debuff_type)

/datum/status_effect/debuff/random_revival/proc/apply_teleport_effect()
	var/area/target_area = locate(/area/rogue/indoors/town/manor) in GLOB.sortedAreas
	if(!target_area)
		apply_random_debuff() // Fallback if manor doesn't exist
		return

	// Find valid turf in manor
	var/turf/target_turf
	var/attempts = 0
	var/max_attempts = 5

	while(attempts < max_attempts && !target_turf)
		attempts++

		// Get all turfs in manor area
		var/list/area_turfs = get_area_turfs(target_area.type)
		if(!length(area_turfs))
			break

		var/list/valid_turfs = list()
		for(var/turf/T in area_turfs)
			if(T.density)
				continue
			if(istransparentturf(T))
				continue
			if(T.teleport_restricted)
				continue
			valid_turfs += T

		if(length(valid_turfs))
			target_turf = pick(valid_turfs)

	if(target_turf)
		// Unequip everything before teleporting
		owner.unequip_everything()

		// Teleport to manor
		owner.forceMove(target_turf)
		to_chat(owner, span_userdanger("You wake up in an unfamiliar place, stripped of your belongings!"))
		owner.Jitter(30)
	else
		// Fallback to random debuff if no valid turf found
		apply_random_debuff()

/atom/movable/screen/alert/status_effect/random_revival
	name = "Strange Aftereffects"
	desc = "The revival has left you with unexpected consequences..."

//Dendor, Malum, Ravox, Noc
//Fairly generic for now, I might give these more unique effects later!
/datum/status_effect/debuff/malum_revival
	id = "malum_revival"
	duration = 15 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/malum_revival

/datum/status_effect/debuff/malum_revival/on_creation(mob/living/new_owner)
	effectedstats = list(
		"endurance" = -5,
		"strength" = -2
	)
	return ..()

/atom/movable/screen/alert/status_effect/malum_revival
	name = "Malum's Burden"
	desc = "Your body feels heavy and slow to recover."
	icon_state = "malum_burden"

/datum/status_effect/debuff/ravox_revival
	id = "ravox_revival"
	duration = 15 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/ravox_revival

/datum/status_effect/debuff/ravox_revival/on_creation(mob/living/new_owner)
	effectedstats = list(
		"strength" = -5,
		"speed" = -2
	)
	return ..()

/atom/movable/screen/alert/status_effect/ravox_revival
	name = "Ravox's Weakness"
	desc = "Your muscles feel feeble and movements sluggish."
	icon_state = "ravox_weakness"

/datum/status_effect/debuff/dendor_revival
	id = "dendor_revival"
	duration = 15 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/dendor_revival

/datum/status_effect/debuff/dendor_revival/on_creation(mob/living/new_owner)
	effectedstats = list(
		"speed" = -5,
		"constitution" = -2
	)
	return ..()

/atom/movable/screen/alert/status_effect/dendor_revival
	name = "Dendor's Sluggishness"
	desc = "Your movements are weighted by invisible roots and your body feels fragile."
	icon_state = "dendor_sluggish"

/datum/status_effect/debuff/noc_revival
	id = "noc_revival"
	duration = 15 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/noc_revival
	tick_interval = 10 SECONDS
	var/static/list/valid_body_zones = list(
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG
	)

/datum/status_effect/debuff/noc_revival/on_creation(mob/living/new_owner)
	effectedstats = list("intelligence" = -5)
	return ..()

/datum/status_effect/debuff/noc_revival/tick()
	// Check if outside at night
	if(istype(get_area(owner), /area/rogue/outdoors) && (GLOB.tod == "night"))
		if(prob(15))
			to_chat(owner, span_danger("Moonlight sears your flesh!"))
			owner.adjustFireLoss(15)
			if(iscarbon(owner))
				var/mob/living/carbon/C = owner
				var/list/valid_parts = list()

				for(var/obj/item/bodypart/BP in C.bodyparts)
					var/BP_name = BP.name
					if(!BP_name) BP_name = "Unnamed Bodypart" // Fallback

					var/bool_can_bloody_wound = BP.can_bloody_wound()
					var/bool_in_zone = (BP.body_zone in valid_body_zones)
					var/bool_combined_condition = (bool_in_zone && bool_can_bloody_wound)

					if(bool_combined_condition) //Idk but it works like this.
						valid_parts += BP

				if(length(valid_parts))
					var/obj/item/bodypart/BP = pick(valid_parts)
					BP.add_wound(/datum/wound/nocburn, FALSE, "looks burnt.")

/datum/wound/nocburn
	name = "light burn"
	whp = 15
	sewn_whp = 5
	bleed_rate = 0
	clotting_rate = 0.02
	sewn_clotting_rate = 0.02
	clotting_threshold = 0.1
	sewn_clotting_threshold = 0.05
	sew_threshold = 25
	mob_overlay = "cut"
	can_sew = TRUE
	//It's.. a burn..
	can_cauterize = FALSE

/atom/movable/screen/alert/status_effect/noc_revival
	name = "Noc's Moonlit Curse"
	desc = "Your mind feels clouded and moonlight burns your skin."
	icon_state = "noc_curse"


//specific god's debuffs

//Ravox's call to arms
/datum/status_effect/debuff/call_to_arms
	id = "call_to_arms"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/call_to_arms
	effectedstats = list("endurance" = -2, "constitution" = -2)
	duration = 2.5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/call_to_arms
	name = "Ravox's Call to Arms"
	desc = "His voice keeps ringing in your ears, rocking your soul.."
	icon_state = "call_to_arms"

/datum/status_effect/debuff/ravox_burden
	id = "ravox_burden"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/ravox_burden
	effectedstats = list("speed" = -2, "endurance" = -3)
	duration = 12 SECONDS

/atom/movable/screen/alert/status_effect/debuff/ravox_burden
	name = "Ravox's Burden"
	desc = "My arms and legs are restrained by divine chains!\n"
	icon_state = "restrained"

//Graggar's call to slaughter
/datum/status_effect/debuff/call_to_slaughter
	id = "call_to_slaughter"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/call_to_slaughter
	effectedstats = list("endurance" = -2, "constitution" = -2)
	duration = 2.5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/call_to_slaughter
	name = "Call to Slaughter"
	desc = "A putrid rotting scent fills your nose as Graggar's call for slaughter rattles you to your core.."
	icon_state = "call_to_slaughter"

 //Matthios's debuff
 #define EQUALIZED_GLOW "equalizer glow"
/datum/status_effect/debuff/equalizedebuff
	id = "equalize"
	alert_type = /atom/movable/screen/alert/status_effect/buff/equalized
	effectedstats = list("strength" = -2, "constitution" = -2, "speed" = -2)
	duration = 1 MINUTES
	var/outline_colour = "#FFD700"

/atom/movable/screen/alert/status_effect/debuff/equalized
	name = "Equalized"
	desc = "My fire is stolen from me!"

/datum/status_effect/debuff/equalizedebuff/on_apply()
	. = ..()
	owner.add_filter(EQUALIZED_GLOW, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))

/datum/status_effect/debuff/equalizedebuff/on_remove()
	. = ..()
	owner.remove_filter(EQUALIZED_GLOW)
	to_chat(owner, "<font color='yellow'>My fire returns to me!</font>")

//T3 COUNT WEALTH, HURT TARGET/APPLY EFFECTS BASED ON AMOUNT OF WEALTH. AT 500+, OLD STYLE CHURNS THE TARGET.
 #undef EQUALIZED_GLOW

//Eoran debuffs
#define POM_FILTER "pom_aura"

/datum/status_effect/debuff/pomegranate_aura
	id = "pomegranate_aura"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/pomegranate_aura
	var/outline_colour ="#42001f"
	var/datum/weakref/source_ref

/datum/status_effect/debuff/pomegranate_aura/on_creation(mob/living/owner, tree)
	source_ref = WEAKREF(tree)
	var/str_change = 0
	var/perc_change = 0

	if(owner.patron.type != /datum/patron/divine/eora)
		str_change = -8
		perc_change = -8
	else if (!(owner.get_skill_level(/datum/skill/magic/holy) >= 1))
		//Eorans get a slight edge.
		str_change = -6
		perc_change = -6
	else
		//Devotees to Eora get a strong edge.
		str_change = -4
		perc_change = -2

	effectedstats = list(
		"strength" = str_change,
		"perception" = perc_change
	)

	return ..()

/datum/status_effect/debuff/pomegranate_aura/on_apply()
	. = ..()
	var/filter = owner.get_filter(POM_FILTER)
	if (!filter)
		owner.add_filter(POM_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 180, "size" = 1))
	to_chat(owner, span_warning("My combat prowess is sapped by the tree!"))

/datum/status_effect/debuff/pomegranate_aura/on_remove()
	. = ..()
	owner.remove_filter(POM_FILTER)
	to_chat(owner, span_warning("As I leave the influence of the tree, my strength returns."))

/datum/status_effect/debuff/pomegranate_aura/tick()
	// Check if source tree still exists
	var/obj/structure/eoran_pomegranate_tree/tree = source_ref?.resolve()
	if(QDELETED(tree) || !istype(tree))
		owner.remove_status_effect(src)
		return

	// Check distance to tree. This is a sanity check given the aura SHOULD remove already, but you can never be too safe :)
	if(get_dist(owner, tree) > tree.aura_range)
		owner.remove_status_effect(src)
		return

	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		// Ugly people might get hurt
		if(HAS_TRAIT(H, TRAIT_UNSEEMLY) && prob(2))
			to_chat(H, span_warning("The tree's beauty burns your eyes!"))
			H.Dizzy(5)
			H.blur_eyes(5)
			H.adjustBruteLoss(10, 0)

		// Beautiful people might get healed
		else if(HAS_TRAIT(H, TRAIT_BEAUTIFUL) && prob(10))
			to_chat(H, span_good("The tree's beauty revitalizes you!"))
			H.apply_status_effect(/datum/status_effect/buff/healing, 1)

	// There is no beauty in death. Feed my tree.
	if(owner.stat == DEAD)
		owner.blood_volume = max(10, owner.blood_volume - 10)

/atom/movable/screen/alert/status_effect/pomegranate_aura
	name = "Eora's Blessing"
	desc = "You feel a sense of peace near this sacred tree."
	icon_state = "pom_peace"

#undef POM_FILTER

#define WILTING_FILTER "wilting_death"

/atom/movable/screen/alert/status_effect/eoran_wilting
	name = "WILTING"
	desc = "My limbs are falling off!"
	icon_state = "pom_death"

/datum/status_effect/debuff/eoran_wilting
	id = "wilting"
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/eoran_wilting
	var/outline_colour ="#2c2828"
	var/datum/weakref/source_ref

/datum/status_effect/debuff/eoran_wilting/on_apply()
	if(isliving(owner))
		owner.add_filter(WILTING_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 210, "size" = 2))
		to_chat(owner, span_userdanger("You feel like your limbs are starting to detach horrifically, death is imminent!"))
	return TRUE

/datum/status_effect/debuff/eoran_wilting/on_remove()
	if(isliving(owner))
		var/mob/living/L = owner
		L.remove_filter(WILTING_FILTER)
	
	dismember_owner()

/datum/status_effect/debuff/eoran_wilting/tick()
	if(isliving(owner))
		var/mob/living/L = owner
		L.flash_fullscreen("redflash3", 1)
		
		// Small damage to limbs as warning
		if(iscarbon(L))
			var/mob/living/carbon/C = L
			for(var/obj/item/bodypart/BP in C.bodyparts)
				if(BP.body_zone in list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
					BP.receive_damage(1)

/datum/status_effect/debuff/eoran_wilting/proc/dismember_owner()
	if(!iscarbon(owner))
		return

	var/mob/living/carbon/C = owner
	playsound(C, 'sound/misc/eat.ogg', 100, TRUE)

	// Dismember limbs in sequence
	var/static/list/dismember_order = list(
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
		BODY_ZONE_HEAD
	)

	C.visible_message(span_userdanger("[C]'s limbs wither and fall off in a gruesome display!"))

	for(var/zone in dismember_order)
		var/obj/item/bodypart/BP = C.get_bodypart(zone)
		if(BP)
			C.adjustBruteLoss(50)
			BP.dismember()
			sleep(0.5 SECONDS)

#undef WILTING_FILTER

//Pestra debuffs
/datum/status_effect/debuff/infestation
	id = "infestation"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/infestation
	duration = 10 SECONDS
	effectedstats = list("constitution" = -2)
	var/static/mutable_appearance/rotten = mutable_appearance('icons/roguetown/mob/rotten.dmi', "rotten")

/datum/status_effect/debuff/infestation/on_apply()
	. = ..()
	var/mob/living/target = owner
	to_chat(owner, span_danger("I am suddenly surrounded by a cloud of bugs!"))
	target.Jitter(20)
	target.add_overlay(rotten)
	target.update_vision_cone()

/datum/status_effect/debuff/infestation/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(rotten)
	target.update_vision_cone()
	. = ..()

/datum/status_effect/debuff/infestation/tick()
	var/mob/living/target = owner
	var/mob/living/carbon/M = target
	target.adjustToxLoss(2)
	target.adjustBruteLoss(1)
	var/prompt = pick(1,2,3)
	var/message = pick(
		"Ticks on my skin start to engorge with blood!",
		"Flies are laying eggs in my open wounds!",
		"Something crawled in my ear!",
		"There are too many bugs to count!",
		"They're trying to get under my skin!",
		"Make it stop!",
		"Millipede legs tickle the back of my ear!",
		"Fire ants bite at my feet!",
		"A wasp sting right on the nose!",
		"Cockroaches scurry across my neck!",
		"Maggots slimily wriggle along my body!",
		"Beetles crawl over my mouth!",
		"Fleas bite my ankles!",
		"Gnats buzz around my face!",
		"Lice suck my blood!",
		"Crickets chirp in my ears!",
		"Earwigs crawl into my ears!")
	if(prompt == 1 && iscarbon(M))
		M.add_nausea(pick(10,20))
		to_chat(target, span_warning(message))

/atom/movable/screen/alert/status_effect/debuff/infestation
	name = "Infestation"
	desc = "Pestilent vermin bite and chew at my skin."
	icon_state = "debuff"

//Xylix's debuffs
/datum/status_effect/debuff/viciousmockery
	id = "viciousmockery"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/viciousmockery
	duration = 600 // One minute
	effectedstats = list("strength" = -1, "speed" = -1,"endurance" = -1, "intelligence" = -3)

/atom/movable/screen/alert/status_effect/debuff/viciousmockery
	name = "Vicious Mockery"
	desc = "<span class='warning'>THAT ARROGANT BARD! ARGH!</span>\n"
	icon_state = "muscles"
