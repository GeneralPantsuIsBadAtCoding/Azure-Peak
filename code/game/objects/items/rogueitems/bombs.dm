
/obj/item/bomb
	name = "bottle bomb"
	desc = "A fiery explosion waiting to be coaxed from its glass prison."
	icon_state = "bbomb"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	//dropshrink = 0
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	var/fuze = null //randomized on init
	var/lit = FALSE
	var/prob2fail = 5
	grid_width = 32
	grid_height = 64

/obj/item/bomb/Initialize()
	. = ..()
	fuze = rand(40,60)

/obj/item/bomb/spark_act()
	light()

/obj/item/bomb/fire_act()
	light()

/obj/item/bomb/ex_act()
	if(!QDELETED(src))
		lit = TRUE
		explode(TRUE)

/obj/item/bomb/proc/light()
	if(!lit)
		START_PROCESSING(SSfastprocess, src)
		icon_state = "bbomb-lit"
		lit = TRUE
		playsound(src.loc, 'sound/items/firelight.ogg', 100)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/bomb/extinguish()
	snuff()

/obj/item/bomb/proc/snuff()
	if(lit)
		lit = FALSE
		STOP_PROCESSING(SSfastprocess, src)
		playsound(src.loc, 'sound/items/firesnuff.ogg', 100)
		icon_state = "bbomb"
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/bomb/proc/explode(skipprob)
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	if(T)
		if(lit)
			if(!skipprob && prob(prob2fail))
				snuff()
			else
				explosion(T, light_impact_range = 1, flame_range = 2, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
		else
			if(prob(prob2fail))
				snuff()
			else
				playsound(T, 'sound/items/firesnuff.ogg', 100)
				new /obj/item/natural/glass_shard (T)
	qdel(src)

/obj/item/bomb/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	explode()

/obj/item/bomb/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)

/obj/item/smokebomb
	name = "smoke bomb"
	desc = "A soft sphere with an alchemical mixture and a dispersion mechanism hidden inside. Any pressure will detonate it."
	icon_state = "smokebomb"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	//dropshrink = 0
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	grid_width = 32
	grid_height = 64

/obj/item/smokebomb/attack_self(mob/user)
    ..()
    explode()

/obj/item/smokebomb/ex_act()
	if(!QDELETED(src))
		..()
	explode()

/obj/item/smokebomb/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	explode()

/obj/item/smokebomb/proc/explode()
    STOP_PROCESSING(SSfastprocess, src)
    var/turf/T = get_turf(src)
    if (!T) return
    playsound(src.loc, 'sound/items/smokebomb.ogg', 50)
    var/radius = 3
    var/datum/effect_system/smoke_spread/S = new /datum/effect_system/smoke_spread
    S.set_up(radius, T)
    S.start()
    new /obj/item/ash(T)
    qdel(src)


/obj/item/tntstick
	name = "Blackpowder stick"
	desc = "A bit of blackpowder in paper shell..."
	icon_state = "tnt_stick"
	var/lit_state = "tnt_stick-lit"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	throw_range = 3
	var/fuze = 7.5 SECONDS
	var/lit = FALSE
	var/prob2fail = 1

/obj/item/tntstick/spark_act()
	light()

/obj/item/tntstick/fire_act()
	light()

/obj/item/tntstick/ex_act()
	if(!QDELETED(src))
		lit = TRUE
		explode(TRUE)

/obj/item/tntstick/proc/light()
	if(!lit)
		START_PROCESSING(SSfastprocess, src)
		icon_state = lit_state
		lit = TRUE
		playsound(src.loc, 'sound/items/firelight.ogg', 100)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()
/obj/item/tntstick/attack_self(mob/user)
	..()
	extinguish()

/obj/item/tntstick/extinguish()
	snuff()

/obj/item/tntstick/proc/snuff()
	if(lit)
		lit = FALSE
		STOP_PROCESSING(SSfastprocess, src)
		playsound(src.loc, 'sound/items/firesnuff.ogg', 100)
		icon_state = initial(icon_state)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/tntstick/proc/explode(skipprob)
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	if(T)
		if(lit)
			if(!skipprob && prob(prob2fail))
				snuff()
			else
				explosion(T, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 4, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))

				qdel(src) //go into walls /turf/closed/wall/ and see /turf/closed/wall/ex_act. Its bounded with /proc/explosion
		else
			if(prob(prob2fail))
				snuff()

/obj/item/tntstick/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)

/obj/item/satchel_bomb
	name = "Bomb satchel"
	desc = "A satchel full of blackpowder..."
	icon_state = "satchel_bomb"
	var/lit_state = "satchel_bomb-lit"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 0
	throw_range = 2
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.3
	var/fuze = 15 SECONDS
	var/lit = FALSE
	var/prob2fail = 1

/obj/item/satchel_bomb/spark_act()
	light()

/obj/item/satchel_bomb/fire_act()
	light()

/obj/item/satchel_bomb/ex_act()
    if(!QDELETED(src))
        lit = TRUE
        explode(TRUE)

/obj/item/satchel_bomb/proc/light()
	if(!lit)
		START_PROCESSING(SSfastprocess, src)
		icon_state = lit_state
		lit = TRUE
		playsound(src.loc, 'sound/items/firelight.ogg', 100)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/satchel_bomb/attack_self(mob/user)
	..()
	extinguish()

/obj/item/satchel_bomb/extinguish()
	snuff()

/obj/item/satchel_bomb/proc/snuff()
	if(lit)
		lit = FALSE
		STOP_PROCESSING(SSfastprocess, src)
		playsound(src.loc, 'sound/items/firesnuff.ogg', 100)
		icon_state = initial(icon_state)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/satchel_bomb/proc/explode(skipprob)
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	if(T)
		if(lit)
			if(!skipprob && prob(prob2fail))
				snuff()
			else
				explosion(T, devastation_range = 3, light_impact_range = 10, hotspot_range = 1, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))

				qdel(src)

		else
			if(prob(prob2fail))
				snuff()

/obj/item/satchel_bomb/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)


/obj/item/impact_grenade
	name = "impact grenade"
	desc = "Some substance, hidden under some paper and skin."
	icon_state = "impact_grenade"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	throw_speed = 1
	/// An extra string describing the grenade type.
	var/additional_desc

/obj/item/impact_grenade/Initialize()
	. = ..()
	if(additional_desc) // add our extra desc
		desc = "[initial(desc)] [additional_desc]"

// Define a base explodes() proc that subtypes can override because its now explodes proc
/obj/item/impact_grenade/proc/explodes()
	STOP_PROCESSING(SSfastprocess, src)
	qdel(src) // Delete the grenade after use boy (ALWAYS USE IT)

/obj/item/impact_grenade/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	explodes()

/obj/item/impact_grenade/attack_self(mob/user)
	..()
	explodes()

/obj/item/impact_grenade/explosion
	additional_desc = "This one sparks..."

/obj/item/impact_grenade/explosion/explodes()
	var/turf/T = get_turf(src)
	if(T)
		explosion(T, heavy_impact_range = 0, light_impact_range = 2, hotspot_range = 2, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
	..() // stop processing and delete self

/obj/item/impact_grenade/smoke
	additional_desc = "This one emits clouds of harmless smoke..."
	/// The type of smoke system to use.
	var/datum/effect_system/smoke_spread/smoke_type = /datum/effect_system/smoke_spread

/obj/item/impact_grenade/smoke/explodes()
	var/turf/T = get_turf(src)
	playsound(T, 'sound/misc/explode/incendiary (1).ogg', 100)
	var/datum/effect_system/smoke_spread/smoke = new smoke_type
	smoke.set_up(2, T) // radius of 2 around T
	smoke.start()
	..() // stop processing and delete self

/obj/item/impact_grenade/smoke/poison_gas
	additional_desc = "Some substance, hidden under some paper and skin. The smell of this one makes you to gasp..."
	smoke_type = /datum/effect_system/smoke_spread/poison_gas

/obj/item/impact_grenade/smoke/healing_gas
	additional_desc = "Some substance, hidden under some paper and skin. The smell of this one reminds you the taste of red..."
	smoke_type = /datum/effect_system/smoke_spread/healing_gas

/obj/item/impact_grenade/smoke/fire_gas
	additional_desc = "It smells like chicken and burns your hand..."
	smoke_type = /datum/effect_system/smoke_spread/fire_gas

/obj/item/impact_grenade/smoke/blind_gas
	additional_desc = "The smell from this makes your eyes water."
	smoke_type = /datum/effect_system/smoke_spread/blind_gas

/obj/item/impact_grenade/smoke/mute_gas
	additional_desc = "The smell from this makes your mind blank and your tongue still."
	smoke_type = /datum/effect_system/smoke_spread/mute_gas
