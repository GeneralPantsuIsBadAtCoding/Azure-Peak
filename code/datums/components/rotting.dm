#define DEAD_TO_ZOMBIE_TIME 3 MINUTES ///Time before death -> raised as zombie (when outside of the city)

/datum/component/rot
	var/amount = 0
	var/last_process = 0
	var/datum/looping_sound/fliesloop/soundloop

/datum/component/rot/Initialize(new_amount)
	..()
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	if(new_amount)
		amount = new_amount

	soundloop = new(parent, FALSE)

	START_PROCESSING(SSroguerot, src)

/datum/component/rot/Destroy()
	if(soundloop)
		soundloop.stop()
	. = ..()

/datum/component/rot/process()

	var/amt2add = 10 // 1 Second. Base increment. 
	var/current_time = world.time
    
	// time elapsed since the last rot/process
	var/elapsed_time = last_process ? (current_time - last_process) : 0
	last_process = current_time

	// Add amount based on the time elapsed. This is used to calculate when to wake/decompose
	amount += (elapsed_time / 10) * amt2add 

	return

/datum/component/rot/corpse/Initialize()
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE
	. = ..()
/*
	ZOMBIFICATION
*/
/datum/component/rot/corpse/process()
	..()
	var/mob/living/carbon/C = parent
	var/is_zombie
	if(C.mind)
		if(C.mind.has_antag_datum(/datum/antagonist/zombie))
			is_zombie = TRUE
	if(!is_zombie)
		if(C.stat != DEAD)
			qdel(src)
			return


	if(!(C.mob_biotypes & (MOB_ORGANIC|MOB_UNDEAD)))
		qdel(src)
		return
	
	if(amount > DEAD_TO_ZOMBIE_TIME)
		if(is_zombie)
			var/datum/antagonist/zombie/Z = C.mind.has_antag_datum(/datum/antagonist/zombie)
			if(Z && !Z.has_turned && !Z.revived && C.stat == DEAD)
				wake_zombie(C, infected_wake = TRUE, converted = FALSE)

	var/findonerotten = FALSE
	var/shouldupdate = FALSE
	var/dustme = FALSE
	for(var/obj/item/bodypart/B in C.bodyparts)
		if(!B.skeletonized && B.is_organic_limb())
			if(!B.rotted)
				if(amount > 20 MINUTES)
					B.rotted = TRUE
					findonerotten = TRUE
					shouldupdate = TRUE
					C.change_stat("constitution", -8, "rottenlimbs")
			else
				if(amount > 40 MINUTES)
					if(!is_zombie)
						B.skeletonize()
						if(C.dna && C.dna.species)
							C.dna.species.species_traits |= NOBLOOD
						C.change_stat("constitution", -99, "skeletonized")
						shouldupdate = TRUE
				else
					findonerotten = TRUE
		if(amount > 35 MINUTES)  // Code to delete a corpse after 35 minutes if it's not a zombie and not skeletonized. Possible failsafe.
			if(!is_zombie)
				if(B.skeletonized)
					dustme = TRUE

	if(dustme)
		qdel(src)
		return C.dust(drop_items=TRUE)

	if(findonerotten)
		var/turf/open/T = C.loc
		if(istype(T))
			T.add_pollutants(/datum/pollutant/rot, 5)
			if(soundloop && soundloop.stopped && !is_zombie)
				soundloop.start()
		else
			if(soundloop && !soundloop.stopped)
				soundloop.stop()
	else
		if(soundloop && !soundloop.stopped)
			soundloop.stop()
	if(shouldupdate)
		if(findonerotten)
			if(ishuman(C))
				var/mob/living/carbon/human/H = C
				H.skin_tone = "878f79" //elf ears
			if(soundloop && soundloop.stopped && !is_zombie)
				soundloop.start()
		C.update_body()

/datum/component/rot/simple/process()
	..()
	var/mob/living/L = parent
	if(L.stat != DEAD)
		qdel(src)
		return
	if(amount > 15 MINUTES)
		if(soundloop && soundloop.stopped)
			soundloop.start()
		var/turf/open/T = get_turf(L)
		if(istype(T))
			T.add_pollutants(/datum/pollutant/rot, 5)
	if(amount > 25 MINUTES)
		qdel(src)
		return L.dust(drop_items=TRUE)

/datum/component/rot/gibs
	amount = MIASMA_GIBS_MOLES

/datum/looping_sound/fliesloop
	mid_sounds = list('sound/misc/fliesloop.ogg')
	mid_length = 60
	volume = 50
	extra_range = 0

#undef DEAD_TO_ZOMBIE_TIME
