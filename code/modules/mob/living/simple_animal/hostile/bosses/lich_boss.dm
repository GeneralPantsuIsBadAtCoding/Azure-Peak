/mob/living/simple_animal/hostile/boss/lich
	name = "Lich"
	desc = ""
	mob_biotypes = MOB_HUMANOID|MOB_UNDEAD
	boss_abilities = list(/datum/action/boss/lich_summon_minions)
	faction = list("lich")
	del_on_death = TRUE
	icon = 'icons/mob/evilpope.dmi'
	icon_state = "EvilPope"
	wander = 0
	vision_range = 8
	aggro_vision_range = 24
	ranged = 1
	rapid = 3
	rapid_fire_delay = 8
	ranged_message = "casts a spell"
	ranged_cooldown_time = 40
	ranged_ignores_vision = TRUE
	environment_smash = 0
	minimum_distance = 8
	retreat_distance = 0
	move_to_delay = 10
	obj_damage = 100
	base_intents = list(/datum/intent/simple/lich)
	melee_damage_lower = 60
	melee_damage_upper = 80
	health = 5000
	maxHealth = 5000
	STASTR = 12
	STAPER = 20
	STAINT = 18
	STACON = 20
	STAEND = 20
	STASPD = 15
	STALUC = 15
	loot = list(/obj/effect/temp_visual/lich_dying)
	projectiletype = /obj/projectile/magic
	var/allowed_projectile_types = list(/obj/projectile/magic/lightning, /obj/projectile/magic/sickness, /obj/projectile/magic/arcane_barrage, /obj/projectile/magic/acidsplash)
	patron = /datum/patron/inhumen/zizo
	footstep_type = FOOTSTEP_MOB_SHOE
	stat_attack = UNCONSCIOUS

	var/obj/effect/proc_holder/spell/targeted/turf_teleport/blink/blink = null
	var/next_cast = 0
	var/next_blink = 0
	var/list/taunt = list("Witness my power!", "Die!", "Suffer!")
	var/minions_to_spawn = 10
	var/next_summon = 0
	var/next_blaststrong = 0
	var/mob_type
	var/mob/new_mob
	var/spawned_mobs = 0
	var/list/minions = list(
		/mob/living/simple_animal/hostile/rogue/skeleton/guard/shield/lich = 40,
		/mob/living/simple_animal/hostile/rogue/skeleton/guard/xbow/lich = 30,
		/mob/living/simple_animal/hostile/rogue/skeleton/guard/crypt_guard/lich = 20,
		/mob/living/simple_animal/hostile/rogue/skeleton/guard/crypt_guard_spear/lich = 20)

/mob/living/simple_animal/hostile/boss/lich/Initialize()
	projectiletype = /obj/projectile/bullet/reusable/deepone
	. = ..()
	blink = new /obj/effect/proc_holder/spell/targeted/turf_teleport/blink
	blink.clothes_req = 0
	blink.human_req = 0
	blink.player_lock = 0
	blink.inner_tele_radius = 5
	blink.outer_tele_radius = 6
	blink.invocation = pick(taunt)
	blink.invocation_type = "shout"
	AddSpell(blink)
	REMOVE_TRAIT(src, TRAIT_SIMPLE_WOUNDS, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/boss/lich/Shoot()
	projectiletype = pick(allowed_projectile_types)
	..()

//First Summon Ability. Spawns two fully armored carbon skeletons.
/datum/action/boss/lich_summon_minions
	name = "Summon Minions"
	button_icon_state = "art_summon"
	usage_probability = 100
	boss_cost = 70
	boss_type = /mob/living/simple_animal/hostile/retaliate/rogue/boss/lich
	needs_target = TRUE
	say_when_triggered = "Hgf'ant'kthar!"
	var/static/summoned_minions = 0

/datum/action/boss/lich_summon_minions/Trigger()
	if(summoned_minions <= 6 && ..())
		var/list/minions = list(
		/mob/living/carbon/human/species/skeleton/npc/dungeon/lich = 30)
		var/list/directions = GLOB.cardinals.Copy()
		for(var/i in 1 to 2)
			var/minions_chosen = pickweight(minions)
			new minions_chosen (get_step(boss,pick_n_take(directions)), 1)
		summoned_minions += 1;

/mob/living/simple_animal/hostile/boss/lich/handle_automated_action()
	. = ..()
	if(target && next_cast < world.time && next_summon < world.time) //Second summon ability. Spawns a mob of simple skeletons
		spawn_minions(minions_to_spawn)
		INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, say), "Minions, to me!", null, list("colossus", "yell"))
		next_cast = world.time + 10
		next_summon = world.time + 600
		return .
	if(target && next_cast < world.time && next_blink < world.time) //Triggers a blink spell
		if(blink.cast_check(0,src))
			blink.choose_targets(src)
			blink.invocation = pick(taunt)
			next_cast = world.time + 20
			next_blink = world.time + 120
			return .
	if(target && next_cast < world.time && health < maxHealth * 0.33 && next_blaststrong < world.time) //Fires a wave of greater fireballs after blinking
		INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, say), "I am immortal, you are NOTHING!", null, list("colossus", "yell"))
		playsound(get_turf(src), 'sound/magic/antimagic.ogg', 70, TRUE)
		blaststrong()
		next_cast = world.time + 100
		next_blaststrong = world.time + 300
		return .
	if(target && next_cast < world.time) //fires a wave of a random projectile after blinking
		blast()
		next_cast = world.time + 100
		return .


/mob/living/simple_animal/hostile/boss/lich/proc/blast(set_angle)
	var/turf/target_turf = get_turf(target)
	newtonian_move(get_dir(target_turf, src))
	var/angle_to_target = Get_Angle(src, target_turf)
	if(isnum(set_angle))
		angle_to_target = set_angle
	var/static/list/colossus_shotgun_shot_angles = list(30, 20, 10, 0, -10, -20, -30)
	for(var/i in colossus_shotgun_shot_angles)
		shoot_projectile(target_turf, angle_to_target + i)

/mob/living/simple_animal/hostile/boss/lich/proc/shoot_projectile(turf/marker, set_angle)
	if(!isnum(set_angle) && (!marker || marker == loc))
		return
	var/turf/startloc = get_turf(src)
	var/obj/projectile/P = new projectiletype(startloc)
	P.preparePixelProjectile(marker, startloc)
	P.firer = src
	if(target)
		P.original = target
	P.fire(set_angle)

/mob/living/simple_animal/hostile/boss/lich/proc/blaststrong(set_angle)
	var/turf/target_turf = get_turf(target)
	newtonian_move(get_dir(target_turf, src))
	var/angle_to_target = Get_Angle(src, target_turf)
	if(isnum(set_angle))
		angle_to_target = set_angle
	var/static/list/colossus_shotgun_shot_angles = list(45, 30, 15, 0, -15, -30, -45)
	for(var/i in colossus_shotgun_shot_angles)
		shoot_projectilestrong(target_turf, angle_to_target + i)

/mob/living/simple_animal/hostile/boss/lich/proc/shoot_projectilestrong(turf/marker, set_angle)
	if(!isnum(set_angle) && (!marker || marker == loc))
		return
	var/turf/startloc = get_turf(src)
	var/obj/projectile/P = new /obj/projectile/magic/aoe/fireball/rogue/great/lich(startloc)
	P.preparePixelProjectile(marker, startloc)
	P.firer = src
	if(target)
		P.original = target
	P.fire(set_angle)

/obj/projectile/magic/sickness/lich
	speed = 15
	damage = 20

/obj/projectile/magic/aoe/fireball/rogue/great/lich
	speed = 20

/obj/projectile/magic/lich/lightning
	name = "bolt of lightning"
	tracer_type = /obj/effect/projectile/tracer/stun
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	light_color = LIGHT_COLOR_WHITE
	damage = 25
	damage_type = BURN
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#ffffff"
/obj/projectile/magic/lich/lightning/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(isliving(target))
			var/mob/living/L = target
			L.Immobilize(1, src)
			playsound(get_turf(src), pick('sound/misc/elec (1).ogg', 'sound/misc/elec (2).ogg', 'sound/misc/elec (3).ogg'), 100, FALSE)
	qdel(src)

/mob/living/simple_animal/hostile/boss/lich/proc/spawn_minions()
	var/spawn_chance = 100
	if (prob(spawn_chance))
		var/turf/spawn_turf
		var/i = 0
		while (i < minions_to_spawn)
			spawn_turf = get_random_valid_turf()
			if (spawn_turf)
				mob_type = pickweight(minions)
				new_mob = new mob_type(spawn_turf)
				if (new_mob)
					spawned_mobs++
			i++

/mob/living/simple_animal/hostile/boss/lich/proc/get_random_valid_turf()
	var/list/valid_turfs = list()
	for (var/turf/T in range(6, src))
		if (is_valid_spawn_turf(T))
			valid_turfs += T
	if (valid_turfs.len == 0)
		return null
	return pick(valid_turfs)

/mob/living/simple_animal/hostile/boss/lich/proc/is_valid_spawn_turf(turf/T)
	if (!(istype(T, /turf/open/floor/rogue)))
		return FALSE
	if (istype(T, /turf/closed))
		return FALSE
	return TRUE

/obj/effect/temp_visual/lich_dying
	name = "Lich"
	desc = ""
	layer = ABOVE_OPEN_TURF_LAYER
	icon = 'icons/mob/evilpope.dmi'
	icon_state = "popedeath"
	anchored = TRUE
	duration = 30
	randomdir = FALSE

/obj/effect/temp_visual/lich_dying/Initialize()
	. = ..()
	visible_message(span_boldannounce("The Lich collapses into a pile of dust and bone, unholy energy dispersing into the air!"))
	INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, say), "Impossible!", null, list("colossus", "yell"))

/obj/effect/temp_visual/lich_dying/Destroy()
	for(var/mob/M in range(7,src))
		shake_camera(M, 7, 1)
	var/turf/T = get_turf(src)
	playsound(T,'sound/vo/mobs/skel/skeleton_death (5).ogg', 80, TRUE, TRUE)
	new /obj/item/roguekey/mage/lich(T)
	return ..()


/mob/living/simple_animal/hostile/retaliate/rogue/boss/lich/simple_limb_hit(zone)
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

/datum/intent/simple/lich
	name = "lich"
	icon_state = "instrike"
	attack_verb = list("strikes", "cuts", "cleaves", "slashes")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = 'sound/combat/hits/bladed/genchop (1).ogg'
	chargetime = 20
	penfactor = 25
	swingdelay = 3
	candodge = TRUE
	canparry = TRUE
	item_d_type = "stab"

/mob/living/simple_animal/hostile/rogue/skeleton/guard/shield/lich
	wander = FALSE
	stat_attack = UNCONSCIOUS
	STAPER = 20
	faction = list("lich")
/mob/living/simple_animal/hostile/rogue/skeleton/guard/xbow/lich
	wander = FALSE
	stat_attack = UNCONSCIOUS
	STAPER = 20
	faction = list("lich")
/mob/living/simple_animal/hostile/rogue/skeleton/guard/crypt_guard/lich
	wander = FALSE
	stat_attack = UNCONSCIOUS
	STAPER = 20
	faction = list("lich")
/mob/living/simple_animal/hostile/rogue/skeleton/guard/crypt_guard_spear/lich
	wander = FALSE
	stat_attack = UNCONSCIOUS
	STAPER = 20
	faction = list("lich")

/mob/living/carbon/human/species/skeleton/npc/dungeon/lich
	skel_fragile = FALSE
	skel_outfit = /datum/outfit/job/roguetown/npc/skeleton/dungeon/lich

/datum/outfit/job/roguetown/npc/skeleton/dungeon/lich/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	gloves = /obj/item/clothing/gloves/roguetown/plate/blk/death
	armor = /obj/item/clothing/suit/roguetown/armor/plate/blkknight/death
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/blkknight/death
	pants = /obj/item/clothing/under/roguetown/platelegs/blk/death
	neck = /obj/item/clothing/neck/roguetown/bevor
	head = /obj/item/clothing/head/roguetown/helmet/heavy/knight/black
	belt = /obj/item/storage/belt/rogue/leather/black
	H.STASTR = 20
	H.STAPER = 20
	H.STASPD = 10
	H.STACON = 20
	H.STAEND = 20
	H.STAINT = 1
	H.faction = list("lich")
	H.wander = FALSE

	H.adjust_skillrank_up_to(/datum/skill/craft/carpentry, 1, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/craft/masonry, 1, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/sewing, 1, TRUE)

	H.adjust_skillrank_up_to(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/shields, 2, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/climbing, 2, TRUE)

	H.set_patron(/datum/patron/inhumen/zizo)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

	H.possible_rmb_intents = list(/datum/rmb_intent/feint,\
	/datum/rmb_intent/aimed,\
	/datum/rmb_intent/strong,\
	/datum/rmb_intent/swift,\
	/datum/rmb_intent/riposte,\
	/datum/rmb_intent/weak)
	H.swap_rmb_intent(num=1)

	if(prob(50))
		r_hand = /obj/item/rogueweapon/eaglebeak/lucerne
		l_hand = null
	else
		r_hand = /obj/item/rogueweapon/greatsword/zwei
		l_hand = null

/obj/effect/oneway
	name = "one way effect"
	desc = ""
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "field_dir"
	invisibility = INVISIBILITY_MAXIMUM
	anchored = TRUE

/obj/effect/oneway/CanPass(atom/movable/mover, turf/target)
	if(!(ismob(mover))) //Fixes cart exploit that broke one way boss arena doors. Only mobs can pass through now.
		return ..() && 0
	var/turf/T = get_turf(src)
	var/turf/MT = get_turf(mover)
	return ..() && (T == MT || get_dir(MT,T) == dir)

/obj/effect/oneway/lich //one way barrier to the boss room. Can be despawned with the key the boss drops.
	name = "magical barrier"
	max_integrity = 99999
	desc = "Victory or death - once you pass this point you will either triumph or fall. Recommended 5 players or more."
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	invisibility = SEE_INVISIBLE_LIVING
	anchored = TRUE

/obj/effect/oneway/lich/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/roguekey/mage/lich))
		visible_message(span_boldannounce("The magical barrier disperses!"))
		qdel(src)


/turf/open/floor/rogue/carpet/lord/center/no_teleport //sanity check to keep the Lich from blinking outside the combat arena
	teleport_restricted = TRUE

//Loot
/obj/item/roguekey/mage/lich
	name = "lich's key"
	desc = "A strange key the Lich dropped."
	icon_state = "eyekey"
	lockid = "lich"

/obj/effect/proc_holder/spell/targeted/turf_teleport/blink
	name = "Blink"
	desc = ""

	school = "abjuration"
	recharge_time = 20
	clothes_req = FALSE
	invocation = "none"
	invocation_type = "none"
	range = -1
	include_user = TRUE
	cooldown_min = 5 //4 deciseconds reduction per rank


	smoke_spread = 1
	smoke_amt = 0

	inner_tele_radius = 0
	outer_tele_radius = 6

	action_icon_state = "blink"
	sound1 = 'sound/blank.ogg'
	sound2 = 'sound/blank.ogg'
