/obj/item/flashlight/lantern/shrunken
	name = "shrunken lamp"
	desc = "A beacon."
	icon_state = "shrunkenlamp"
	item_state = "shrunkenlamp"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	light_range = 4
	light_power = 20
	light_color = LIGHT_COLOR_BLOOD_MAGIC

/obj/item/flashlight/lantern/shrunken/update_brightness(mob/user = null)
	if(on)
		icon_state = "[initial(icon_state)]-on"
		set_light_on(TRUE)
	else
		icon_state = initial(icon_state)
		set_light_on(FALSE)


/obj/structure/underworld/carriageman
	name = "The Carriageman"
	desc = "They will take the reigns and lead the way. But only if the price I can pay."
	icon = 'icons/roguetown/underworld/enigma_carriageman.dmi'
	icon_state = "carriageman"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	anchored = TRUE
	density = TRUE

/obj/structure/underworld/carriageman/Initialize()
	. = ..()
	set_light(5, 30, LIGHT_COLOR_BLUE)

/obj/structure/underworld/carriageman/attack_hand(mob/living/carbon/spirit/user)
	if(!user.paid)
		user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)
		to_chat(user, "<br><font color=purple><span class='bold'>FETCH THE TOLL AND YOU MAY BOARD</span></font>")
	else
		to_chat(user, "<br><font color=purple><span class='bold'>HANDS EXCHANGE PAY, BE ON YOUR WAY</span></font>")
		user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)

/obj/structure/underworld/carriageman/attackby(obj/item/W, mob/living/user)
	var/mob/living/carbon/spirit/ghost = user
	if(istype(W, /obj/item/underworld/coin))
		if(!ghost.paid)
			qdel(W)
			to_chat(ghost, "<br><font color=purple><span class='bold'>THE TOLL IS PAID, THROUGH THE CARRIAGE THE UNDERMAIDEN WAITS.</span></font>")
			user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)
			ghost.paid = TRUE
			return
		if(ghost.paid)
			to_chat(ghost, "<br><font color=purple><span class='bold'>FURTHER PAYMENT WILL NOT CHANGE HER JUDGEMENT.</span></font>")
			user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)
	else
		to_chat(ghost, "<br><font color=purple><span class='bold'>ONLY THE TOLL WILL I ACCEPT</span></font>")
		user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)

/obj/structure/underworld/barrier //Blocks sprite locations
	name = "DONT STAND HERE"
	desc = "The Undermaiden awaits."
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"
	density = TRUE
	anchored = TRUE

/obj/structure/underworld/carriage_normal
	name = "Carriage"
	desc = "Azure Peak awaits."
	icon = 'icons/roguetown/underworld/enigma_carriage.dmi'
	icon_state = "carriage_normal"
	anchored = TRUE
	density = TRUE

/obj/structure/underworld/carriage
	name = "Carriage"
	desc = "The Undermaiden awaits."
	icon = 'icons/roguetown/underworld/enigma_carriage.dmi'
	icon_state = "carriage_lit"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	anchored = TRUE
	density = TRUE


/obj/structure/underworld/carriage/Initialize()
	. = ..()
	set_light(5, 30, LIGHT_COLOR_BLUE)

/obj/structure/underworld/carriage/attack_hand(mob/living/carbon/spirit/user)
	if(user.paid)
		switch(alert("Are you ready to be judged?",,"Yes","No"))
			if("Yes")
				playsound(user, 'sound/misc/deadbell.ogg', 50, TRUE, -2, ignore_walls = TRUE)
				user.returntolobby()
			if("No")
				usr << "You delay fate."
	else
		to_chat(user, "<B><font size=3 color=red>It's LOCKED.</font></B>")

GLOBAL_VAR_INIT(underworld_coins, 0)

/obj/item/underworld/coin
	name = "The Toll"
	desc = "This is more than just a coin."
	icon = 'icons/roguetown/underworld/enigma_husks.dmi'
	icon_state = "soultoken_floor"
	var/should_track = TRUE

/obj/item/underworld/coin/Initialize()
	. = ..()
	if(should_track)
		GLOB.underworld_coins += 1

/obj/item/underworld/coin/Destroy()
	if(should_track)
		GLOB.underworld_coins -= 1
	coin_upkeep()
	return ..()

/obj/item/underworld/coin/pickup(mob/user)
	..()
	if(should_track)
		GLOB.underworld_coins -= 1
	coin_upkeep()
	icon_state = "soultoken"

/obj/item/underworld/coin/dropped(mob/user)
	..()
	if(should_track)
		GLOB.underworld_coins += 1
	icon_state = "soultoken_floor"

/obj/item/underworld/coin/notracking
	should_track = FALSE

/proc/coin_upkeep()
	if(GLOB.underworld_coins < 8)
		for(var/obj/effect/landmark/underworldcoin/B in GLOB.landmarks_list)
			new /obj/item/underworld/coin(B.loc)


// why not also some mob stuff too
/mob/living/simple_animal/hostile/rogue/dragger
	name = "dragger"
	desc = ""
	icon = 'icons/roguetown/underworld/enigma_dragger.dmi'
	icon_state = "dragger"
	icon_living = "dragger"
	icon_dead = "dragger_dead"
	mob_biotypes = MOB_UNDEAD|MOB_HUMANOID
	movement_type = GROUND
	environment_smash = ENVIRONMENT_SMASH_NONE
	pass_flags = PASSTABLE|PASSGRILLE
	base_intents = list(/datum/intent/simple/slash)
	gender = FEMALE //they're WOKE now...
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "passes through"
	response_help_simple = "pass through"
	maxHealth = 215
	health = 215
	layer = 16
	plane = 16
	spacewalk = FALSE
	stat_attack = UNCONSCIOUS
	robust_searching = 1
	speed = 1
	move_to_delay = 5 //delay for the automated movement.
	harm_intent_damage = 1
	obj_damage = 1
	melee_damage_lower = 30
	melee_damage_upper = 45
	attack_same = FALSE
	attack_sound = 'sound/combat/wooshes/bladed/wooshmed (1).ogg'
	dodge_sound = 'sound/combat/dodge.ogg'
	parry_sound = "bladedmedium"
	d_intent = INTENT_PARRY
	speak_emote = list("growls")
	limb_destroyer = 1
	del_on_death = FALSE
	STALUC = 11
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	faction = list("undead")
	footstep_type = null
	defprob = 50 //decently skilled
	defdrain = 20
	canparry = TRUE
	retreat_health = null

	can_have_ai = FALSE //disable native ai
	AIStatus = AI_OFF
	ai_controller = /datum/ai_controller/dragger

/mob/living/simple_animal/hostile/rogue/dragger/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	return FALSE

/mob/living/simple_animal/hostile/rogue/dragger/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "head"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "head"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "hand"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "hand"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "tail"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "tail"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "body"
		if(BODY_ZONE_PRECISE_GROIN)
			return "body"
		if(BODY_ZONE_PRECISE_R_INHAND)
			return "body"
		if(BODY_ZONE_PRECISE_L_INHAND)
			return "body"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "tail"
		if(BODY_ZONE_L_LEG)
			return "tail"
		if(BODY_ZONE_R_ARM)
			return "arm"
		if(BODY_ZONE_L_ARM)
			return "arm"
		if(BODY_ZONE_CHEST)
			return "chest"

	return ..()

/mob/living/simple_animal/hostile/rogue/dragger/taunted(mob/user)
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/rogue/dragger/Initialize()
	. = ..()
	set_light(2, 2, "#c0523f")
	ADD_TRAIT(src, TRAIT_IGNOREDAMAGESLOWDOWN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAINSTUN, TRAIT_GENERIC)


/mob/living/simple_animal/hostile/rogue/dragger/death(gibbed)
	emote("death")
	..()

/mob/living/simple_animal/hostile/rogue/dragger/Life()
	. = ..()

/mob/living/simple_animal/hostile/rogue/dragger/get_sound(input)
	switch(input)
		if("laugh")
			return pick('sound/vo/mobs/ghost/laugh (1).ogg','sound/vo/mobs/ghost/laugh (2).ogg','sound/vo/mobs/ghost/laugh (3).ogg','sound/vo/mobs/ghost/laugh (4).ogg','sound/vo/mobs/ghost/laugh (5).ogg','sound/vo/mobs/ghost/laugh (6).ogg')
		if("moan")
			return pick('sound/vo/mobs/ghost/moan (1).ogg','sound/vo/mobs/ghost/laugh (2).ogg','sound/vo/mobs/ghost/laugh (3).ogg')
		if("death")
			return 'sound/vo/mobs/ghost/death.ogg'
		if("whisper")
			return pick('sound/vo/mobs/ghost/whisper (1).ogg','sound/vo/mobs/ghost/whisper (2).ogg','sound/vo/mobs/ghost/whisper (3).ogg')
		if("aggro")
			return pick('sound/vo/mobs/ghost/aggro (1).ogg','sound/vo/mobs/ghost/aggro (2).ogg','sound/vo/mobs/ghost/aggro (3).ogg','sound/vo/mobs/ghost/aggro (4).ogg','sound/vo/mobs/ghost/aggro (5).ogg','sound/vo/mobs/ghost/aggro (6).ogg')

/mob/living/simple_animal/hostile/rogue/dragger/AttackingTarget()
	. = ..()
	if(. && prob(8) && iscarbon(target))
		var/mob/living/carbon/C = target
		C.Immobilize(50)
		C.visible_message(span_danger("\The [src] paralyzes \the [C] in fear!"), \
				span_danger("\The [src] paralyzes me!"))
		emote("laugh")

/obj/effect/landmark/underworldsafe/Crossed(atom/movable/AM, oldloc)
	if(istype(AM, /mob/living/simple_animal/hostile/rogue/dragger))
		for(var/mob/living/carbon/human/A in view(4))
			to_chat(A, "The monster's form dematerializes as it nears the Carriage.")
		qdel(AM)

