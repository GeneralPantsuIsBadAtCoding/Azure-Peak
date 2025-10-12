
/mob/living/simple_animal/hostile/rogue/werewolf
	name = "WEREWOLF"
	desc = "THE HOWL OF A MAD GOD SHAKES YOUR BONES! FLESH SHORN INTO VISCERA SPRAYS THE WALLS! RIP AND TEAR!"
	icon = 'icons/roguetown/mob/monster/werewolf.dmi'
	gender = MALE
	icon_state = "wwolf_m"
	icon_living = "wwolf_m"
	icon_dead = "wwolf_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 80
	maxHealth = 333
	health = 333
	melee_damage_lower = 15
	melee_damage_upper = 18
	STASTR = 20
	STAWIL = 20
	STASPD = 20
	obj_damage = 20
	environment_smash = ENVIRONMENT_SMASH_WALLS
	attack_sound = BLADEWOOSH_LARGE
	dextrous = TRUE
	held_items = list(null, null)
//	base_intents = list(INTENT_HELP, INTENT_GRAB, /datum/intent/simple/claw/wwolf)
	faction = list("wolves")
	robust_searching = TRUE
	stat_attack = UNCONSCIOUS
	footstep_type = FOOTSTEP_MOB_HEAVY

/mob/living/simple_animal/hostile/rogue/werewolf/Initialize()
	. = ..()
	regenerate_icons()
	ADD_TRAIT(src, TRAIT_SIMPLE_WOUNDS, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_SILVER_WEAK, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/rogue/werewolf/f
	icon_state = "wwolf_f"
	icon_living = "wwolf_f"
	gender = FEMALE

/mob/living/simple_animal/hostile/rogue/werewolf/f/Initialize()
	. = ..()
	regenerate_icons()
	ADD_TRAIT(src, TRAIT_SIMPLE_WOUNDS, TRAIT_GENERIC)
