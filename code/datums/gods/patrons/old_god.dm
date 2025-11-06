/datum/patron/old_god
	name = "Psydon"
	domain = "Otava, Naledi, Rockhill, and most of Psydonia's outermost fiefs."
	desc = " </br>'PSYDON YET LYVES! PSYDON YET ENDURES!' </br>‎  </br>In the wake of the Comet Syon's impact, Psydon fell silent. None truly knew what became of Him, but most had assumed the worst: that He had undertaken the ultimate sacrifice to save His world from the Archdevil. Many of His grieving children would eventually turn their prayers to the Pantheon, but a select few held hope that Psydon still lyved. </br>‎  </br>Together, these apostles pilgrimaged to an ancient kingdom and chiseled the Orthodoxy from its ruins. From the remains of the old world, a masterwork arose: Otava, the only cathedral-state that has remained ardently Psydonic following His collapse, and the aggressor of a centuries-long conflict against the Pantheon's kingdoms. </br>‎  </br>As the largest Psydonic denomination in the new world, the Orthodoxy's beliefs are well-known to even the most ardent opposers. Psydon left humenity to recover His strength, but will soon return. The Pantheon, as His creations, are seen as 'Saints': fit for reverence, but subserveant to His divine authority. The Inhumen seek to end this world, and must be stopped."
	worshippers = "Commonfolk, Zealots, Heroes, and the Esoteric."
	associated_faith = /datum/faith/old_god
	mob_traits = list(TRAIT_PSYDONIAN_GRIT) //Assigned to all mobs with Psydon as the chosen patron. Gives a Willpower-scaling chance to resist succumbing to pain.
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison			= CLERIC_ORI,
					/obj/effect/proc_holder/spell/self/check_boot				= CLERIC_T0, //Personal spell - summons a completely random item upon use. Your mileage might vary.
					/obj/effect/proc_holder/spell/invoked/psydonendure			= CLERIC_T1, //External spell - seals bleeding wounds and helps to save people who've been critically injured.
					/obj/effect/proc_holder/spell/self/psydonprayer				= CLERIC_T1, //Internal spell - minor self-regeneration, repeatedly casted while still.
					/obj/effect/proc_holder/spell/self/psydonrespite			= CLERIC_T2, //Ditto, but stronger. The original variant, intended for dedicated - non-Adventuring - combat classes.
					/obj/effect/proc_holder/spell/self/psydonpersist			= CLERIC_T3, //Ditto-ditto. Intended for non-combative devotee classes, such as the Missionary and Absolver.
	)
	traits_tier = list(TRAIT_PSYDONITE = CLERIC_T0) //Requires a minimal holy skill or the 'Devotee' virtue to unlock. Offers passive wound regeneration, but prevents healing from most miracles.
	confess_lines = list(
		"THERE IS ONLY ONE TRUE GOD!",
		"PSYDON YET LYVES! PSYDON YET ENDURES!",
		"REBUKE THE HEATHEN, SUNDER THE MONSTER!",
		"MY GOD - WITH EVERY BROKEN BONE, I SWORE I LYVED!",
		"EVEN NOW, THERE IS STILL HOPE FOR MAN! AVE PSYDONIA!",
		"WITNESS ME, PSYDON; THE SACRIFICE MADE MANIFEST!",
	)


/////////////////////////////////
// Does God Hear Your Prayer ? //
/////////////////////////////////
// no he's dead - ok maybe he does

/datum/patron/old_god/can_pray(mob/living/follower)
	. = ..()
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
