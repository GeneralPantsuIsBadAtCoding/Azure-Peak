
/obj/structure/flora/roguegrass/maneater
	name = "grass"
	desc = "Green and vivid.. Did i see.. a tendril?"
	icon = 'icons/roguetown/mob/monster/maneater.dmi'
	icon_state = "maneater-hidden"
	max_integrity = 5

/obj/structure/flora/roguegrass/maneater/update_icon()
	return

/obj/structure/flora/roguegrass/maneater/real
	var/aggroed = 0
	max_integrity = 100
	integrity_failure = 0.15
	attacked_sound = list('sound/vo/mobs/plant/pain (1).ogg','sound/vo/mobs/plant/pain (2).ogg','sound/vo/mobs/plant/pain (3).ogg','sound/vo/mobs/plant/pain (4).ogg')
	var/list/eatablez = list(/obj/item/bodypart, /obj/item/organ, /obj/item/reagent_containers/food/snacks/rogue/meat)
	var/last_eat
	buckle_lying = 0
	buckle_prevents_pull = 1
	var/seednutrition = 0
	var/max_seednutrition = 100
	var/mob/planter = null

/obj/structure/flora/roguegrass/maneater/real/Initialize()
	. = ..()
	proximity_monitor = new(src, 1)

/obj/structure/flora/roguegrass/maneater/real/Destroy()
	QDEL_NULL(proximity_monitor)
	unbuckle_all_mobs()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/flora/roguegrass/maneater/real/obj_break(damage_flag)
	..()
	QDEL_NULL(proximity_monitor)
	unbuckle_all_mobs()
	STOP_PROCESSING(SSobj, src)
	update_icon()

/obj/structure/flora/roguegrass/maneater/real/process()
	if(seednutrition >= max_seednutrition)
		produce_seed()
		seednutrition = 0
	if(!has_buckled_mobs())
		if(world.time > last_eat + 50)
			var/list/around = view(1, src)
			for(var/mob/living/M in around)
				HasProximity(M)
				return
			for(var/obj/item/F in around)
				if(is_type_in_list(F, eatablez))
					aggroed = world.time
					last_eat = world.time
					playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
					qdel(F)
					seednutrition += 10
					return
		if(world.time > aggroed + 30 SECONDS)
			aggroed = 0
			update_icon()
			STOP_PROCESSING(SSobj, src)
			return TRUE
	for(var/mob/living/L in buckled_mobs)
		if(world.time > last_eat + 50)
			last_eat = world.time
			L.flash_fullscreen("redflash3")
			playsound(src.loc, list('sound/vo/mobs/plant/attack (1).ogg','sound/vo/mobs/plant/attack (2).ogg','sound/vo/mobs/plant/attack (3).ogg','sound/vo/mobs/plant/attack (4).ogg'), 100, FALSE, -1)
			if(iscarbon(L))
				var/mob/living/carbon/C = L
				if(src.planter == L) // We won't harm our planter
					maneater_spit_out(C)
					return
				src.visible_message(span_danger("[src] starts to rip apart [C]!"))
				spawn(50)
					if(C && (C.buckled == src))
						var/obj/item/bodypart/limb
						var/list/limb_list = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
						for(var/zone in limb_list)
							limb = C.get_bodypart(zone)
							if(limb)
								playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
								limb.dismember()
								qdel(limb)
								seednutrition += 20
								if(C.mind) // eat only one limb of things with minds
									maneater_spit_out(C)
									return
								return
						if(C.mind) // nugget case, just spit them out
							maneater_spit_out(C)
							return
						limb = C.get_bodypart(BODY_ZONE_HEAD)
						if(limb)
							playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
							limb.dismember()
							qdel(limb)
							return
						limb = C.get_bodypart(BODY_ZONE_CHEST)
						if(limb)
							if(!limb.dismember())
								C.gib()
								seednutrition += 50
							return
			else
				src.visible_message(span_danger("[src] starts to rip apart [L]!"))
				spawn(50)
					if(L && (L.buckled == src))
						L.gib()
						seednutrition += 30
						return

/obj/structure/flora/roguegrass/maneater/real/proc/maneater_spit_out(mob/living/C)
	if(!C)
		return
	src.visible_message(span_danger("[src] spits out [C]!"))
	unbuckle_mob(C)
	var/turf/target = get_ranged_target_turf(src, pick(GLOB.alldirs), 3)
	C.throw_at(target, 3, 2)
	playsound(src,'sound/misc/maneaterspit.ogg', 100)
	return TRUE

/obj/structure/flora/roguegrass/maneater/real/update_icon()
	if(obj_broken)
		name = "MANEATER"
		desc = "This cunning creature is thankfully defeated." // i think this might break, dunno
		icon_state = "maneater-dead"
		return
	if(aggroed)
		name = "MANEATER"
		icon_state = "maneater"
	else
		name = "grass"
		icon_state = "maneater-hidden"

/obj/structure/flora/roguegrass/maneater/real/user_unbuckle_mob(mob/living/M, mob/user)
	if(obj_broken)
		..()
		return
	if(isliving(user))
		var/mob/living/L = user
		var/time2mount = CLAMP((L.STASTR * 2), 1, 99)
		if(istype(src, /obj/structure/flora/roguegrass/maneater/real/juvenile)) //Easier to escape juvenile
			time2mount = CLAMP(time2mount * 3, 1, 99)
		user.changeNext_move(CLICK_CD_RAPID)
		if(user != M)
			if(prob(time2mount))
				..()
			else
				user.visible_message(span_warning("[user] tries to pull [M] free of [src]!"))
			return
		if(prob(time2mount))
			..()
		else
			user.visible_message(span_warning("[user] tries to break free of [src]!"))

/obj/structure/flora/roguegrass/maneater/real/user_buckle_mob(mob/living/M, mob/living/user) //Don't want them getting put on the rack other than by spiking
	return

/obj/structure/flora/roguegrass/maneater/real/HasProximity(atom/movable/AM)
	if(has_buckled_mobs())
		return
	if(world.time > last_eat + 50)
		var/list/around = view(src, 1) // scan for enemies
		if(!(AM in around))
			return
		if(istype(AM, /mob/living))
			var/mob/living/L = AM
			if(!aggroed)
				if(L.m_intent != MOVE_INTENT_RUN)
					return
			aggroed = world.time
			last_eat = world.time
			update_icon()
			buckle_mob(L, TRUE, check_loc = FALSE)
			START_PROCESSING(SSobj, src)
			if(!HAS_TRAIT(L, TRAIT_NOPAIN))
				L.emote("painscream", forced = TRUE)
			src.visible_message(span_danger("[src] snatches [L]!"))
			playsound(src.loc, list('sound/vo/mobs/plant/attack (1).ogg','sound/vo/mobs/plant/attack (2).ogg','sound/vo/mobs/plant/attack (3).ogg','sound/vo/mobs/plant/attack (4).ogg'), 100, FALSE, -1)
		if(istype(AM, /obj/item))
			if(is_type_in_list(AM, eatablez))
				aggroed = world.time
				last_eat = world.time
				START_PROCESSING(SSobj, src)
				update_icon()
				playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
				qdel(AM)
				return
/obj/structure/flora/roguegrass/maneater/real/attackby(obj/item/W, mob/user, params)
	. = ..()
	aggroed = world.time
	update_icon()

//MANEATER SEEDS

/obj/item/maneaterseed
	name = "maneater seed"
	desc = "A seed from a maneater. It looks like it could grow into something dangerous. It can only take root in green grass, or dirt."
	icon = 'icons/roguetown/mob/monster/maneater.dmi'
	icon_state = "maneater-seed"
	max_integrity = 5
	sellprice = 30

/obj/item/maneaterseed/afterattack(atom/target, mob/user, proximity_flag, click_parameters)

	var/turf/T = get_turf(target)
	if(istype(T, /turf/open/floor/rogue/dirt) || istype(T, /turf/open/floor/rogue/grass))
		if(!proximity_flag)
			return
		for(var/obj/structure/flora/roguegrass/maneater/M in T)
			to_chat(user, span_warning("The maneater plants need more space between them to grow."))
			return
		for(var/turf/adjacent in orange(2, T))
			for(var/obj/structure/flora/roguegrass/maneater/M in adjacent)
				to_chat(user, span_warning("The maneater plants need more space between them to grow."))
				return
		for(var/obj/effect/decal/D in T) //To stop planting on mapped cobble decals etc
			to_chat(user, span_warning("The ground is too uneven to plant a maneater seed here."))
			return
		user.visible_message(span_notice("[user] begins planting a maneater seed."), \
				span_notice("I begin planting the maneater seed."))
		if(do_after(user, 10 SECONDS))
			var/obj/structure/flora/roguegrass/maneater/real/juvenile/myboy = new(T)
			myboy.planter = user
			user.visible_message(span_notice("[user] plants a maneater seed."), \
				span_notice("I plant the maneater seed."))
			qdel(src)
			message_admins("[user]/([user.ckey]) plants a maneater seed at [ADMIN_VERBOSEJMP(T)]")
			return
	. = ..()

/obj/structure/flora/roguegrass/maneater/real/proc/produce_seed()
	visible_message(span_warning("[src] spits out a seed!"))
	var/turf/target = get_ranged_target_turf(src, pick(GLOB.alldirs), rand(1,3))
	var/obj/item/maneaterseed/S = new(get_turf(src))
	S.throw_at(target,3,2)
	playsound(src,'sound/misc/maneaterspit.ogg', 100)

//JUVENILE MANEATER

/obj/structure/flora/roguegrass/maneater/real/juvenile
	name = "juvenile maneater"
	desc = "Green and vivid.. This plant seems smaller than usual.."
	icon = 'icons/roguetown/mob/monster/maneater.dmi'
	icon_state = "maneater-hidden"
	max_integrity = 50
	seednutrition = 0
	max_seednutrition = 50
	var/growth_stage = 1
	var/max_growth_stage = 3
	var/growth_time = 20 MINUTES


/obj/structure/flora/roguegrass/maneater/real/juvenile/Initialize()
	. = ..()
	transform = transform.Scale(0.5, 0.5)  // Start at half size
	START_PROCESSING(SSobj, src)
	addtimer(CALLBACK(src, .proc/try_grow), growth_time)

/obj/structure/flora/roguegrass/maneater/real/juvenile/process()
	if(!has_buckled_mobs())
		if(world.time > last_eat + 50)
			var/list/around = view(1, src)
			for(var/mob/living/M in around)
				HasProximity(M)
				return
			for(var/obj/item/F in around)
				if(is_type_in_list(F, eatablez))
					aggroed = world.time
					last_eat = world.time
					playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
					seednutrition += 10
					if(seednutrition >= max_seednutrition)
						seednutrition = 0
						try_grow()
					qdel(F)
					return
		if(world.time > aggroed + 30 SECONDS)
			aggroed = 0
			update_icon()
			return TRUE
	for(var/mob/living/L in buckled_mobs)
		if(world.time > last_eat + 50)
			last_eat = world.time
			L.flash_fullscreen("redflash3")
			playsound(src.loc, list('sound/vo/mobs/plant/attack (1).ogg','sound/vo/mobs/plant/attack (2).ogg','sound/vo/mobs/plant/attack (3).ogg','sound/vo/mobs/plant/attack (4).ogg'), 100, FALSE, -1)
			if(iscarbon(L))
				var/mob/living/carbon/C = L
				src.visible_message(span_danger("[src] gnaws on [C]!"))  // Different message for juvenile
				if(C && (C.buckled == src))
					C.adjustBruteLoss(10)  // Just does damage instead of dismembering
					seednutrition += 10
					if(seednutrition >= max_seednutrition)
						seednutrition = 0
						try_grow()

/obj/structure/flora/roguegrass/maneater/real/juvenile/proc/try_grow()
	if(growth_stage < max_growth_stage)
		growth_stage++
		// We end up at 1.0 size by final stage
		transform = transform.Scale(1.26, 1.26)
		visible_message(span_warning("[src] grows bigger!"))
		playsound(src.loc, list('sound/vo/mobs/plant/attack (1).ogg','sound/vo/mobs/plant/attack (2).ogg','sound/vo/mobs/plant/attack (3).ogg','sound/vo/mobs/plant/attack (4).ogg'), 100, FALSE, -1)
		addtimer(CALLBACK(src, .proc/try_grow), growth_time)
	else
		// Replace with adult form
		visible_message(span_danger("[src] reaches full maturity!"))
		var/turf/T = get_turf(src)
		var/obj/structure/flora/roguegrass/maneater/real/myboy = new(T)
		myboy.planter = src.planter
		qdel(src)

/obj/structure/flora/roguegrass/maneater/real/juvenile/update_icon()
	if(obj_broken)
		name = "dead juvenile maneater"
		icon_state = "maneater-dead"
		return
	if(aggroed)
		name = "juvenile MANEATER"
		icon_state = "maneater"
	else
		name = "strange grass"
		icon_state = "maneater-hidden"

/obj/structure/flora/roguegrass/maneater/real/juvenile/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()
