/mob/living/simple_animal/hostile/retaliate/rogue/dragon
	icon = 'modular/icons/mob/96x96/ratwood_dragon.dmi'
	name = "dragon"
	icon_state = "dragon"
	icon_living = "dragon"
	icon_dead = "dragon_dead"
	footstep_type = FOOTSTEP_MOB_HEAVY
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 3
	speak_emote = list("growls")
	see_in_dark = 6
	move_to_delay = 3
	base_intents = list(/datum/intent/simple/bite)
	minbodytemp = 0
	maxbodytemp = INFINITY
	damage_coeff = list(BRUTE = 1, BURN = 0.2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 20,
						/obj/item/natural/hide = 10, /obj/item/natural/bundle/bone/full = 4)
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 800
	maxHealth = 800
	melee_damage_lower = 45
	melee_damage_upper = 70
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_NONE
	retreat_distance = 0
	minimum_distance = 0
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_HEAVY
	pooptype = null
	STACON = 20
	STASTR = 20
	STASPD = 13
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 9999 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = list('sound/combat/hits/blunt/genblunt (1).ogg','sound/combat/hits/blunt/genblunt (2).ogg','sound/combat/hits/blunt/genblunt (3).ogg','sound/combat/hits/blunt/flailhit.ogg')
	dodgetime = 30
	aggressive = 1
//	stat_attack = UNCONSCIOUS

/mob/living/simple_animal/hostile/retaliate/rogue/dragon/Initialize()
	. = ..()
	gender = MALE
	if(prob(33))
		gender = FEMALE
	update_icon()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_BLOODLOSS_IMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOFIRE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_BASHDOORS, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_ORGAN_EATER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NASTY_EATER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_STRONGBITE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOFALLDAMAGE1, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/rogue/dragon/death(gibbed)
	..()
	update_icon()

/* Eyes that glow in the dark. They float over kybraxor pits at the moment.
/mob/living/simple_animal/hostile/retaliate/rogue/wolf/update_icon()
	cut_overlays()
	..()
	if(stat != DEAD)
		var/mutable_appearance/eye_lights = mutable_appearance(icon, "vve")
		eye_lights.plane = 19
		eye_lights.layer = 19
		add_overlay(eye_lights)*/

/mob/living/simple_animal/hostile/retaliate/rogue/dragon/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/vw/aggro (1).ogg','sound/vo/mobs/vw/aggro (2).ogg')
		if("pain")
			return pick('sound/vo/mobs/wwolf/painscream.ogg','sound/vo/mobs/wwolf/pain (1).ogg','sound/vo/mobs/wwolf/pain (3).ogg','sound/vo/mobs/wwolf/pain (2).ogg')
		if("death")
			return pick('sound/vo/mobs/wwolf/death.ogg')
		if("idle")
			return pick('sound/vo/mobs/wwolf/idle (1).ogg',)
		if("cidle")
			return pick('sound/vo/mobs/wwolf/idle (2).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/dragon/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/dragon/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/dragon/simple_limb_hit(zone)
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

/obj/projectile/magic/aoe/dragon_breath
    name = "fire hairball"
    icon_state = "fireball"
    damage = 10
    damage_type = BRUTE
    nodamage = FALSE
    light_color = "#f8af07"
    light_outer_range = 2
    damage = 40
    flag = "magic"
    hitsound = 'sound/blank.ogg'

    //explosion values
    var/exp_heavy = 0
    var/exp_light = 2
    var/exp_flash = 3
    var/exp_fire = 3



/obj/projectile/magic/aoe/dragon_breath/on_hit(target)
    . = ..()
    if(ismob(target))
        var/mob/living/M = target
        if(exp_fire)
            M.adjust_fire_stacks(exp_fire*3)
    var/turf/T
    if(isturf(target))
        T = target
    else
        T = get_turf(target)
    explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, soundin = explode_sound)
    if(ismob(target))
        var/mob/living/M = target
        var/atom/throw_target = get_edge_target_turf(M, angle2dir(Angle))
        M.throw_at(throw_target, exp_light, EXPLOSION_THROW_SPEED)
    
/mob/living/simple_animal/hostile/retaliate/rogue/dragon/broodmother
	health = 1600
	maxHealth = 1600
	name = "dragon broodmother"
	projectiletype = /obj/projectile/magic/aoe/dragon_breath
	projectilesound = 'sound/blank.ogg'
	ranged = 1
	ranged_message = "breathes fire"
	ranged_cooldown_time = 20 SECONDS
