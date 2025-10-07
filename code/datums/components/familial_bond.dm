/datum/component/familial_bond
	var/mob/living/carbon/human/bonded_with
	var/bond_duration
	var/bond_strength = 100 // Bond strength affects range and clarity of sensing
	var/last_health_check = 0
	var/last_location_ping = 0
	var/ping_cooldown = 30 SECONDS
	var/health_check_interval = 15 SECONDS
	var/max_sensing_range = 50 // Maximum range for sensing on same z-level
	var/emergency_threshold = 30 // Health percentage that triggers emergency alerts

/datum/component/familial_bond/Initialize(mob/living/carbon/human/target, duration)
	if(!istype(target) || !istype(parent))
		return COMPONENT_INCOMPATIBLE

	bonded_with = target
	bond_duration = duration
	last_health_check = world.time
	last_location_ping = world.time

	// Notify both parties of the bond formation
	var/mob/living/carbon/human/parent_mob = parent
	to_chat(parent_mob, span_purple("You feel a warm spiritual connection forming with [bonded_with]."))
	to_chat(bonded_with, span_purple("You feel a warm spiritual connection forming with [parent_mob]."))

	// Set up termination timer
	addtimer(CALLBACK(src, PROC_REF(end_bond)), duration)
	START_PROCESSING(SSprocessing, src)

	// Register signal handlers for enhanced interaction
	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(on_parent_death))
	RegisterSignal(bonded_with, COMSIG_LIVING_DEATH, PROC_REF(on_bonded_death))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement))

/datum/component/familial_bond/Destroy()
	UnregisterSignal(parent, list(COMSIG_LIVING_DEATH, COMSIG_MOVABLE_MOVED))
	if(bonded_with)
		UnregisterSignal(bonded_with, COMSIG_LIVING_DEATH)
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/datum/component/familial_bond/process()
	if(!bonded_with || QDELETED(bonded_with) || !parent || QDELETED(parent))
		end_bond()
		return

	var/mob/living/carbon/human/parent_mob = parent

	// Check if we're still on the same server/existence plane
	if(bonded_with.z == 0 || parent_mob.z == 0)
		return

	// Periodic health monitoring
	if(world.time >= last_health_check + health_check_interval)
		check_bonded_health()
		last_health_check = world.time

	// Location sensing with reduced frequency
	if(world.time >= last_location_ping + ping_cooldown)
		provide_location_sense()
		last_location_ping = world.time

	// Bond strength naturally degrades over time (adds realism)
	if(prob(5))
		bond_strength = max(bond_strength - 1, 20)

/datum/component/familial_bond/proc/check_bonded_health()
	var/mob/living/carbon/human/parent_mob = parent
	if(!parent_mob || !bonded_with)
		return

	var/bonded_health_percent = (bonded_with.health / bonded_with.maxHealth) * 100

	// Emergency health alerts
	if(bonded_health_percent <= emergency_threshold)
		to_chat(parent_mob, span_danger("You feel a sharp pain in your chest - [bonded_with] is in serious danger!"))
		// Add a subtle screen effect
		parent_mob.overlay_fullscreen("familial_pain", /atom/movable/screen/fullscreen/painflash, 1)
		addtimer(CALLBACK(parent_mob, TYPE_PROC_REF(/mob, clear_fullscreen), "familial_pain"), 3 SECONDS)

	// Mutual health awareness at close range
	if(get_dist(parent_mob, bonded_with) <= 7 && parent_mob.z == bonded_with.z)
		if(bonded_health_percent <= 50)
			to_chat(parent_mob, span_warning("You sense [bonded_with] is hurt."))
		else if(bonded_health_percent >= 90)
			to_chat(parent_mob, span_notice("You sense [bonded_with] is in good health."))

/datum/component/familial_bond/proc/provide_location_sense()
	var/mob/living/carbon/human/parent_mob = parent
	if(!parent_mob || !bonded_with)
		return

	// Different z-levels
	if(parent_mob.z != bonded_with.z)
		to_chat(parent_mob, span_info("You sense [bonded_with] is on a different level of existence."))
		return

	var/distance = get_dist(parent_mob, bonded_with)
	var/direction = get_dir(parent_mob, bonded_with)

	// Range check based on bond strength
	var/effective_range = max_sensing_range * (bond_strength / 100)
	if(distance > effective_range)
		to_chat(parent_mob, span_info("Your bond with [bonded_with] is too distant to sense clearly."))
		return

	// Provide detailed location information based on distance
	var/distance_desc
	var/direction_text = dir2text(direction)

	switch(distance)
		if(0 to 3)
			distance_desc = "very close"
		if(4 to 7)
			distance_desc = "nearby"
		if(8 to 15)
			distance_desc = "some distance away"
		if(16 to 25)
			distance_desc = "far"
		if(26 to INFINITY)
			distance_desc = "very far"

	// Add emotional context based on bond strength
	var/bond_feeling = ""
	if(bond_strength >= 80)
		bond_feeling = " Your connection feels strong and warm."
	else if(bond_strength >= 50)
		bond_feeling = " The bond feels stable."
	else if(bond_strength >= 30)
		bond_feeling = " The connection feels somewhat faint."
	else
		bond_feeling = " The bond is weakening."

	to_chat(parent_mob, span_info("You sense [bonded_with] is [distance_desc] to the [direction_text].[bond_feeling]"))

/datum/component/familial_bond/proc/on_parent_death(mob/living/source)
	SIGNAL_HANDLER

	if(bonded_with)
		to_chat(bonded_with, span_danger("You feel a terrible emptiness as your bond with [source] is severed by death."))
		bonded_with.add_stress(/datum/stressevent/bond_death)
	end_bond()

/datum/component/familial_bond/proc/on_bonded_death(mob/living/source)
	SIGNAL_HANDLER

	var/mob/living/carbon/human/parent_mob = parent
	if(parent_mob)
		to_chat(parent_mob, span_danger("You feel a terrible emptiness as your bond with [source] is severed by death."))
		parent_mob.add_stress(/datum/stressevent/bond_death)
	end_bond()

/datum/component/familial_bond/proc/on_movement(mob/living/source)
	SIGNAL_HANDLER

	// Chance to feel movement of bonded person when very close
	if(get_dist(source, bonded_with) <= 3 && prob(30))
		to_chat(bonded_with, span_info("You sense [source] moving nearby."))

/datum/component/familial_bond/proc/strengthen_bond(amount = 10)
	bond_strength = min(bond_strength + amount, 100)
	var/mob/living/carbon/human/parent_mob = parent
	to_chat(parent_mob, span_purple("Your familial bond grows stronger."))
	if(bonded_with)
		to_chat(bonded_with, span_purple("Your familial bond grows stronger."))

/datum/component/familial_bond/proc/weaken_bond(amount = 15)
	bond_strength = max(bond_strength - amount, 10)
	var/mob/living/carbon/human/parent_mob = parent
	to_chat(parent_mob, span_warning("Your familial bond weakens."))
	if(bonded_with)
		to_chat(bonded_with, span_warning("Your familial bond weakens."))

	if(bond_strength <= 10)
		to_chat(parent_mob, span_danger("Your familial bond is nearly broken!"))
		// Chance for early termination if bond is too weak
		if(prob(25))
			end_bond()

/datum/component/familial_bond/proc/end_bond()
	var/mob/living/carbon/human/parent_mob = parent

	if(parent_mob)
		to_chat(parent_mob, span_info("Your familial bond fades away, but the memory of connection remains."))
		parent_mob.add_stress(/datum/stressevent/bond_ended)

	if(bonded_with)
		to_chat(bonded_with, span_info("Your familial bond fades away, but the memory of connection remains."))
		bonded_with.add_stress(/datum/stressevent/bond_ended)

	STOP_PROCESSING(SSprocessing, src)
	qdel(src)

/datum/stressevent/bond_death
	desc = "Someone I was bonded with has died. I feel empty inside."
	stressadd = 6
	timer = 30 MINUTES

/datum/stressevent/bond_ended
	desc = "A familial bond has ended, but I feel grateful for the connection we shared."
	stressadd = -1
	timer = 10 MINUTES
