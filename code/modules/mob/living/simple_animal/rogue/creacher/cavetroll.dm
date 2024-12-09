/mob/living/simple_animal/hostile/retaliate/rogue/cavetroll
	icon = 'icons/roguetown/mob/monster/Trolls.dmi'
	name = "cave troll"
	icon_state = "cavetroll"
	icon_living = "cavetroll"
	icon_dead = "cavetroll_dead"
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 3
	see_in_dark = 10
	move_to_delay = 3
	base_intents = list(/datum/intent/unarmed/punch)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 15,
						/obj/item/natural/hide = 15, /obj/item/natural/bundle/bone/full = 3)
	faction = list("trolls")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 350
	maxHealth = 400
	melee_damage_lower = 45
	melee_damage_upper = 70
	vision_range = 2
	aggro_vision_range = 3
	environment_smash = ENVIRONMENT_SMASH_NONE
	retreat_distance = 0
	minimum_distance = 0
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_HEAVY
	pooptype = null
	STACON = 18
	STASTR = 15
	STASPD = 3
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0
	food = 0
	attack_sound = list('sound/combat/wooshes/blunt/wooshhuge (1).ogg','sound/combat/wooshes/blunt/wooshhuge (2).ogg','sound/combat/wooshes/blunt/wooshhuge (3).ogg')
	dodgetime = 0
	aggressive = 1

//new ai, old ai off
	AIStatus = AI_OFF
	can_have_ai = FALSE
	ai_controller = /datum/ai_controller/troll
	
//	stat_attack = UNCONSCIOUS

/mob/living/simple_animal/hostile/retaliate/rogue/cavetroll/death(gibbed)
	..()
	update_icon()

/mob/living/simple_animal/hostile/retaliate/rogue/cavetroll/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/cavetroll/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/cavetroll/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/troll/trollaggro1.ogg')
		if("death")
			return pick('sound/vo/mobs/troll/trolldeath.ogg')
		if("idle")
			return pick('sound/vo/mobs/troll/trollidle1.ogg', 'sound/vo/mobs/troll/trollidle2.ogg')


/mob/living/simple_animal/hostile/retaliate/rogue/cavetroll/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "nose"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()

