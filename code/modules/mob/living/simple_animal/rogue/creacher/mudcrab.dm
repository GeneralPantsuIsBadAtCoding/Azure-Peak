//Look Sir, free crabs!
/mob/living/simple_animal/hostile/retaliate/rogue/mudcrab
	name = "mudcrab"
	desc = "A mudcrab."
	icon_state = "mudcrab"
	icon_living = "mudcrab"
	icon_dead = "mudcrab_dead"
	speak_emote = list("clicks")
	emote_hear = list("clicks.")
	emote_see = list("clacks.")
	speak_chance = 1
	turns_per_move = 5
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/crab = 2)
	food_type = list(/obj/item/reagent_containers/food/snacks)
	faction = list("crabs")
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "stomps"
	response_harm_simple = "stomp"
	stop_automated_movement = 1
	friendly_verb_continuous = "pinches"
	friendly_verb_simple = "pinch"
	ventcrawler = VENTCRAWLER_ALWAYS
	var/obj/item/inventory_head
	var/obj/item/inventory_mask
	gold_core_spawnable = FRIENDLY_SPAWN

	can_have_ai = FALSE //disable native ai
	AIStatus = AI_OFF
	ai_controller = /datum/ai_controller/mudcrab
	

/mob/living/simple_animal/mudcrabcrab/Life()
	..()
	//CRAB movement
	if(!ckey && !stat)
		if(isturf(loc) && !resting && !buckled)		//This is so it only moves if it's not inside a closet, gentics machine, etc.
			turns_since_move++
			if(turns_since_move >= turns_per_move)
				var/east_vs_west = pick(4,8)
				if(Process_Spacemove(east_vs_west))
					Move(get_step(src,east_vs_west), east_vs_west)

/mob/living/simple_animal/hostile/retaliate/rogue/mudcrab/get_sound(input)
	switch(input)
		if("idle")
			return pick('sound/vo/mobs/crab/crab noise (1).ogg','sound/vo/mobs/crab/crab noise (2).ogg','sound/vo/mobs/crab/crab noise (3).ogg')
		if("death")
			return pick('sound/vo/mobs/crab/crab death.ogg')

/obj/structure/crabnest
	name = "Mudcrab Burrow"
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "crabnest"
	max_integrity = 200
	anchored = TRUE
	density = FALSE
	layer = BELOW_OBJ_LAYER
	var/crabs = 0
	var/maxcrabs = 3
	var/spawning = FALSE
	attacked_sound = null

/obj/structure/crabnest/Initialize()
	. = ..()
	spawn_crab()

/obj/structure/crabnest/proc/createcrab()
	if(QDELETED(src))
		return
	if(!spawning)
		return
	spawning = FALSE
	new /mob/living/simple_animal/hostile/retaliate/rogue/mudcrab(get_turf(src))
	crabs++
	update_icon()
	if(crabs < maxcrabs)
		spawn_crab()

/obj/structure/crabnest/proc/spawn_crab()
	if(QDELETED(src))
		return
	if(spawning)
		return
	spawning = TRUE
	update_icon()
	spawn(2 SECONDS)
		createcrab()
	//addtimer(CALLBACK(src, PROC_REF(creategob)), 4 SECONDS)
