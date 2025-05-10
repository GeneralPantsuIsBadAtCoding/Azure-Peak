#define ARROW_DAMAGE		50
#define BOLT_DAMAGE			70
#define BULLET_DAMAGE		80
#define ARROW_PENETRATION	40
#define BOLT_PENETRATION	50
#define BULLET_PENETRATION	100

//parent of all bolts and arrows ฅ^•ﻌ•^ฅ
/obj/item/ammo_casing/caseless/rogue/
	firing_effect_type = null

//bolts ฅ^•ﻌ•^ฅ

/obj/item/ammo_casing/caseless/rogue/bolt
	name = "bolt"
	desc = "A durable iron bolt that will pierce a skull easily."
	projectile_type = /obj/projectile/bullet/reusable/bolt
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	caliber = "regbolt"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "bolt"
	dropshrink = 0.6
	max_integrity = 10
	force = 10

/obj/projectile/bullet/reusable/bolt
	name = "bolt"
	damage = 70
	damage_type = BRUTE
	armor_penetration = 50
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "bolt_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bolt
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "piercing"
	speed = 0.5
	npc_damage_mult = 2

/obj/projectile/bullet/reusable/bolt/on_hit(atom/target)
	. = ..()

	var/mob/living/L = firer
	if(!L || !L.mind) 
		return

	var/skill_multiplier = 0

	if(isliving(target)) // If the target theyre shooting at is a mob/living
		var/mob/living/T = target
		if(T.stat != DEAD) // If theyre alive
			skill_multiplier = 4

	if(skill_multiplier && can_train_combat_skill(L, /datum/skill/combat/crossbows, SKILL_LEVEL_EXPERT))
		L.mind.add_sleep_experience(/datum/skill/combat/crossbows, L.STAINT * skill_multiplier)

//arrows ฅ^•ﻌ•^ฅ

/obj/item/ammo_casing/caseless/rogue/arrow
	name = "arrow"
	desc = "Some devices are so simple in their nature and austere in their scope \
	that they feel as if they've sprung into being without mortal intervention. \
	Consult your gods."
	projectile_type = /obj/projectile/bullet/reusable/arrow
	caliber = "arrow"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "stonearrow"
	force = 10
	dropshrink = 0.6
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	max_integrity = 10

/obj/item/ammo_casing/caseless/rogue/arrow/stone
	name = "stone arrow"
	desc = "A simple dowel sports lashed flint knapped and honed to a razor edge. Folk \
	wisdom holds that these cut finer than iron heads, but they tend to shatter \
	on impact with armor."
	max_integrity = 5
	projectile_type = /obj/projectile/bullet/reusable/arrow/stone

/obj/item/ammo_casing/caseless/rogue/arrow/iron
	name = "iron broadhead arrow"
	icon_state = "ironarrow"
	desc = "Bundles of steam straightened dowels are notched at one end and fastened \
	to iron-heads on another. With flight feathers lashed it will fly true to its \
	shooters will."
	projectile_type = /obj/projectile/bullet/reusable/arrow/iron

/obj/item/ammo_casing/caseless/rogue/arrow/steel
	name = "steel bodkin arrow"
	icon_state = "steelarrow"
	desc = "Bundles of steam straightened dowels are notched at one end and fastened \
	to steel-heads on another. Crafted for more well-prepared targets."
	projectile_type = /obj/projectile/bullet/reusable/arrow/steel

/obj/projectile/bullet/reusable/arrow
	name = "arrow"
	damage = 20
	damage_type = BRUTE
	npc_damage_mult = 2
	armor_penetration = 10
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 25
	woundclass = BCLASS_STAB
	flag = "piercing"
	speed = 0.4

/obj/projectile/bullet/reusable/arrow/on_hit(atom/target)
	..()

	var/mob/living/L = firer
	if(!L || !L.mind) 
		return

	var/skill_multiplier = 0

	if(isliving(target)) // If the target theyre shooting at is a mob/living
		var/mob/living/T = target
		if(T.stat != DEAD) // If theyre alive
			skill_multiplier = 4

	if(skill_multiplier && can_train_combat_skill(L, /datum/skill/combat/bows, SKILL_LEVEL_EXPERT))
		L.mind.add_sleep_experience(/datum/skill/combat/bows, L.STAINT * skill_multiplier)

/obj/projectile/bullet/reusable/arrow/stone
	name = "stone arrow"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/stone
	accuracy = 60

/obj/projectile/bullet/reusable/arrow/iron
	name = "broadhead arrow"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/iron

	damage = 40
	armor_penetration = 20
	embedchance = 30
	npc_damage_mult = 2

/obj/projectile/bullet/reusable/arrow/steel
	name = "bodkin arrow"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/steel

	accuracy = 75
	damage = 25
	armor_penetration = 45
	embedchance = 80
	speed = 0.6
	npc_damage_mult = 3


// POISON AMMO


/obj/item/ammo_casing/caseless/rogue/arrow/poison
	name = "poisoned arrow"
	desc = "Bundles of steam straightened dowels are notched at one end and fastened \
	to razor heads on another. Furrels cut into the arrow-head with an intoxicating concoction. \
	within."
	projectile_type = /obj/projectile/bullet/reusable/arrow/poison
	icon_state = "ironarrow_poison"
	max_integrity = 10 // same as normal arrow; usually breaks on impact with a mob anyway

/obj/item/ammo_casing/caseless/rogue/arrow/stone/poison
	name = "poisoned stone arrow"
	desc = "A simple dowel sports lashed flint honed to a razor edge and knapped \
	with furrels for carrying poison residue."
	projectile_type = /obj/projectile/bullet/reusable/arrow/poison/stone
	icon_state = "arrow_poison"

/obj/projectile/bullet/reusable/arrow/poison
	name = "poison iron arrow"
	damage = 20				//You deal a bunch of posion damage as it is, regardless of armor protection.
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/iron
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	poisontype = /datum/reagent/berrypoison //Support for future variations of poison for arrow-crafting
	poisonfeel = "burning" //Ditto
	poisonamount = 5 //Support and balance for bodkins, which will hold less poison due to how

/obj/projectile/bullet/reusable/arrow/poison/stone
	name = "poison stone arrow"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/stone

/obj/projectile/bullet/reusable/arrow/poison/on_hit(atom/target, blocked = FALSE)
	..()
	if(!istype(target, /mob/living/simple_animal)) //On-hit for carbon mobs has been moved to projectile act in living_defense.dm, to ensure poison is not applied if armor prevents damage.
		return
	var/mob/living/simple_animal/M = target
	M.show_message(span_danger("You feel an intense burning sensation spreading swiftly from the puncture!")) //In case a player is in control of the mob.
	addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living, adjustToxLoss), 100), 10 SECONDS)
	addtimer(CALLBACK(M, TYPE_PROC_REF(/atom, visible_message), span_danger("[M] appears greatly weakened by the poison!")), 10 SECONDS)


// PYRO AMMO


/obj/item/ammo_casing/caseless/rogue/bolt/pyro
	name = "pyroclastic bolt"
	desc = "A bolt smeared with a flammable tincture."
	projectile_type = /obj/projectile/bullet/bolt/pyro
	possible_item_intents = list(/datum/intent/mace/strike)
	caliber = "regbolt"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "bolt_pyroclastic"
	dropshrink = 0.8
	max_integrity = 10
	force = 10

/obj/projectile/bullet/bolt/pyro
	name = "pyroclastic bolt"
	desc = "A bolt smeared with a flammable tincture."
	damage = 20
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "boltpyro_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bolt
	range = 15
	hitsound = 'sound/blank.ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	flag = "piercing"
	speed = 0.3

/obj/projectile/bullet/bolt/pyro/on_hit(target)
	..()
	if(!ismob(target))
		return
	var/mob/living/M = target
	M.adjust_fire_stacks(6)
	M.adjustFireLoss(15)
	M.IgniteMob()


/obj/item/ammo_casing/caseless/rogue/bolt/water
	name = "water bolt"
	desc = "A bolt with its tip containing a glass ampule filled with water. It will shatter on impact, useful for taking out pesky lights."
	projectile_type = /obj/projectile/bullet/bolt/water
	possible_item_intents = list(/datum/intent/mace/strike)
	caliber = "regbolt"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "bolt_water"
	dropshrink = 0.8
	max_integrity = 10
	force = 0

/obj/projectile/bullet/bolt/water
	name = "water bolt"
	desc = "A bolt with its tip containing a glass ampule filled with water. It will shatter on impact, useful for taking out pesky lights."
	damage = 0
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "boltwater_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bolt/water
	range = 15
	hitsound = 'sound/blank.ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	flag = "piercing"
	speed = 0.3

	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

	//explosion values
	var/exp_heavy = 0
	var/exp_light = 0
	var/exp_flash = 0
	var/exp_fire = 1

/obj/projectile/bullet/bolt/water/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/living/M = target
		for(var/obj/O in M.contents) //Checks for light sources in the mob's inventory
			O.extinguish() //Extinguishes light sources on the mob you hit with the arrow.
	var/turf/T = get_turf(target)
	for(var/obj/O in T)
		O.extinguish()
//pyro arrows
/obj/item/ammo_casing/caseless/rogue/arrow/pyro
	name = "pyroclastic arrow"
	desc = "An arrow with its tip drenched in a flammable tincture."
	projectile_type = /obj/projectile/bullet/arrow/pyro
	possible_item_intents = list(/datum/intent/mace/strike)
	caliber = "arrow"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_pyroclastic"
	dropshrink = 0.8
	max_integrity = 10
	force = 10

/obj/projectile/bullet/arrow/pyro
	name = "pyroclatic arrow"
	desc = "An arrow with its tip drenched in a flammable tincture."
	damage = 15
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrowpyro_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow
	range = 15
	hitsound = 'sound/blank.ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	flag = "piercing"
	speed = 0.4

/obj/projectile/bullet/arrow/pyro/on_hit(target)
	..()
	if(!ismob(target))
		return
	var/mob/living/M = target
	M.adjust_fire_stacks(4)
	M.adjustFireLoss(10)
	M.IgniteMob()

/obj/item/ammo_casing/caseless/rogue/arrow/water
	name = "water arrow"
	desc = "An arrow with its tip containing a glass ampule filled with water. It will shatter on impact, useful for taking out pesky lights."
	projectile_type = /obj/projectile/bullet/arrow/water
	possible_item_intents = list(/datum/intent/mace/strike)
	caliber = "arrow"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_water"
	dropshrink = 0.8
	max_integrity = 10
	force = 0

/obj/projectile/bullet/arrow/water
	name = "water arrow"
	desc = "An arrow with its tip containing a glass ampule filled with water. It will shatter on impact, useful for taking out pesky lights."
	damage = 0
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrowwater_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow
	range = 15
	hitsound = 'sound/blank.ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	flag = "piercing"
	speed = 0.4


/obj/projectile/bullet/arrow/water/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/living/M = target
		for(var/obj/O in M.contents) //Checks for light sources in the mob's inventory.
			O.extinguish() //Extinguishes light sources on the mob you hit with the arrow.
	var/turf/T = get_turf(target)
	for(var/obj/O in T)
		O.extinguish()
/obj/projectile/bullet/reusable/arrow/poison/stone
	name = "stone arrow"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/stone

// GUNPOWDER AMMO


/obj/projectile/bullet/reusable/bullet
	name = "lead ball"
	damage = 50
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bullet
	range = 30
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "piercing"
	armor_penetration = 200
	speed = 0.1

/obj/item/ammo_casing/caseless/rogue/bullet
	name = "lead sphere"
	desc = "A small lead sphere. This should go well with gunpowder."
	projectile_type = /obj/projectile/bullet/reusable/bullet
	caliber = "musketball"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball"
	dropshrink = 0.5
	possible_item_intents = list(/datum/intent/use)
	max_integrity = 0.1


//mob projectiles

/obj/projectile/bullet/reusable/arrow/orc
	damage = 20
	damage_type = BRUTE
	armor_penetration = 25
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/stone
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "piercing"
	speed = 2

/obj/projectile/bullet/reusable/arrow/ancient
	damage = 10
	damage_type = BRUTE
	armor_penetration = 25
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/stone
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "piercing"
	speed = 2
//deep one stone
/obj/projectile/bullet/reusable/deepone
	name = "stone"
	damage = 25
	damage_type = BRUTE
	armor_penetration = 30
	icon = 'icons/roguetown/items/natural.dmi'
	icon_state = "stone1"
	ammo_type = /obj/item/natural/stone
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 50
	woundclass = BCLASS_STAB
	flag = "piercing"
	speed = 10

//Spider projectiles
/obj/projectile/bullet/spider
	name = "web glob"
	damage = 10
	damage_type = BRUTE
	icon = 'modular/Mapping/icons/webbing.dmi'
	icon_state = "webglob"
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 0
	//Will not cause wounds.
	woundclass = null
	flag = "piercing"
	speed = 1

/obj/projectile/bullet/spider/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/living/M = target
		M.apply_status_effect(/datum/status_effect/debuff/exposed)
		M.Immobilize(15)
	var/turf/T
	if(isturf(target))
		T = target
	else
		T = get_turf(target)
	var/web = locate(/obj/structure/spider/stickyweb/mirespider) in T.contents
	if(!(web in T.contents))
		new /obj/structure/spider/stickyweb/mirespider(T)

//Mirespider webs are thinner and will not stop projectiles or obstruct movement as often.
/obj/structure/spider/stickyweb/mirespider
	opacity = 0
	pass_flags = LETPASSTHROW
	debris = null

/obj/structure/spider/stickyweb/mirespider/CanPass(atom/movable/mover, turf/target)
	if(isliving(mover))
		if(prob(25) && !HAS_TRAIT(mover, TRAIT_WEBWALK))
			to_chat(mover, "<span class='danger'>I get stuck in \the [src] for a moment.</span>")
			return FALSE
	else if(istype(mover, /obj/projectile))
		return prob(85)
	return TRUE

//Javelins - Basically spears, but to get them working as proper javelins and able to fit in a bag, they are 'ammo'. (Maybe make an atlatl later?)
//Only ammo casing, no 'projectiles'. You throw the casing, as weird as it is.
/obj/item/ammo_casing/caseless/rogue/javelin
	force = 14
	throw_speed = 3		//1 lower than throwing knives, it hits harder + embeds more.
	name = "iron javelin"
	desc = "A tool used for centuries, as early as recorded history. This one is tipped with a iron head; standard among militiamen and irregulars alike."
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "ijavelin"
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_BULKY
	armor_penetration = 40					//Redfined because.. it's not a weapon, it's an 'arrow' basically.
	max_integrity = 50						//Breaks semi-easy, stops constant re-use. 
	wdefense = 3							//Worse than a spear
	thrown_bclass = BCLASS_STAB				//Knives are slash, lets try out stab and see if it's too strong in terms of wounding.
	throwforce = 25							//throwing knife is 22, slightly better for being bulkier.
	possible_item_intents = list(/datum/intent/sword/thrust, /datum/intent/spear/bash, /datum/intent/spear/cut)	//Sword-thrust to avoid having 2 reach.
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 35, "embedded_fall_chance" = 10)	//Better than iron throwing knife by 10%
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/iron
	associated_skill = /datum/skill/combat/polearms
	heavy_metal = FALSE						//Stops spin animation, maybe.
	thrown_damage_flag = "piercing"			//Checks peircing protection.

/obj/item/ammo_casing/caseless/rogue/javelin/steel
	force = 16
	armor_penetration = 50
	name = "steel javelin"
	desc = "A tool used for centuries, as early as recorded history. This one is tipped with a steel head; perfect for piercing armor!"
	icon_state = "javelin"
	max_integrity = 100						//In-line with other stabbing weapons.
	throwforce = 28							//Equal to steel knife BUT this has peircing damage type so..
	thrown_bclass = BCLASS_PICK				//Bypasses crit protection better than stabbing. Makes it better against heavy-targets.
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 45, "embedded_fall_chance" = 10) //Better than steel throwing knife by 10%
	smeltresult = /obj/item/ingot/steel

/obj/item/ammo_casing/caseless/rogue/javelin/silver
	name = "silver javelin"
	desc = "A tool used for centuries, as early as recorded history. This one appears to be tipped with a silver head. Decorative, perhaps.. or for some sort of specialized hunter."
	icon_state = "sjavelin"
	is_silver = TRUE
	throwforce = 25							//Less than steel because it's.. silver. Good at killing vampires/WW's still.
	armor_penetration = 60
	thrown_bclass = BCLASS_PICK				//Bypasses crit protection better than stabbing. Makes it better against heavy-targets.
	smeltresult = /obj/item/ingot/silver

//Snowflake code to make sure the silver-bane is applied on hit to targeted mob. Thanks to Aurorablade for getting this code to work.
/obj/item/ammo_casing/caseless/rogue/javelin/silver/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..() 
	if(!iscarbon(hit_atom))
		return//abort
	check_dmg(hit_atom)//apply effects and damages
		
/obj/item/ammo_casing/caseless/rogue/javelin/silver/proc/check_dmg(mob/living/hit_atom)
	var/mob/living/carbon/human/H = hit_atom
	if(H.mind)
		var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
		var/datum/antagonist/vampirelord/lesser/V = H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)
		var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
		if(V)
			if(V.disguised)
				H.visible_message("<font color='white'>The silver weapon weakens the curse temporarily!</font>")
				to_chat(H, span_userdanger("I'm hit by my BANE!"))
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				src.last_used = world.time
			else
				H.visible_message("<font color='white'>The silver weapon weakens the curse temporarily!</font>")
				to_chat(H, span_userdanger("I'm hit by my BANE!"))
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				src.last_used = world.time
		if(V_lord)
			if(V_lord.vamplevel < 4 && !V)
				H.visible_message("<font color='white'>The silver weapon weakens the curse temporarily!</font>")
				to_chat(H, span_userdanger("I'm hit by my BANE!"))
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				src.last_used = world.time
			if(V_lord.vamplevel == 4 && !V)
				to_chat(H, "<font color='red'> The silver weapon fails!</font>")
				H.visible_message(H, span_userdanger("This feeble metal can't hurt me, I AM ANCIENT!"))
		if(W && W.transformed == TRUE)
			H.visible_message("<font color='white'>The silver weapon weakens the curse temporarily!</font>")
			to_chat(H, span_userdanger("I'm hit by my BANE!"))
			H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
			src.last_used = world.time
	return

//sling bullets

/obj/item/ammo_casing/caseless/rogue/sling_bullet //parent of sling ammo and the temporary sling bullet for stones. shouldn't ever be seen
	name = "soaring stone"
	desc = "You shouldn't be seeing this."
	projectile_type = /obj/projectile/bullet/sling_bullet
	caliber = "slingbullet"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow"
	force = 5
	throwforce = 20 //you can still throw them
	dropshrink = 0.6
	possible_item_intents = list(INTENT_GENERIC) //not intended to attack with them
	max_integrity = 20
	
/obj/item/ammo_casing/caseless/rogue/sling_bullet/stone //these should be seen
	name = "stone sling bullet"
	desc = "A stone refined for wrath."
	projectile_type = /obj/projectile/bullet/reusable/sling_bullet/stone
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "stone_sling_bullet"

/obj/item/ammo_casing/caseless/rogue/sling_bullet/iron
	name = "iron sling bullet"
	desc = "Not to be mistakened for a ball bearing."
	projectile_type = /obj/projectile/bullet/reusable/sling_bullet/iron
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "iron_sling_bullet"

/obj/projectile/bullet/sling_bullet //not reusable since stones will break on impact. i couldnt figure out how to prevent that
	name = "sling bullet"
	desc = "If you're reading this: duck."
	damage = 25
	damage_type = BRUTE
	armor_penetration = 0
	icon = 'icons/roguetown/items/natural.dmi'
	icon_state = "stone1"
	range = 15
	hitsound = 'sound/combat/hits/blunt/bluntsmall (1).ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	flag = "piercing"
	speed = 0.4

/obj/projectile/bullet/sling_bullet/on_hit(atom/target)
	. = ..()

	var/mob/living/L = firer
	if(!L || !L.mind) return

	var/skill_multiplier = 0

	if(isliving(target)) // If the target theyre shooting at is a mob/living
		var/mob/living/T = target
		if(T.stat != DEAD) // If theyre alive
			skill_multiplier = 4

	if(skill_multiplier && can_train_combat_skill(L, /datum/skill/combat/slings, SKILL_LEVEL_LEGENDARY))
		L.mind.add_sleep_experience(/datum/skill/combat/slings, L.STAINT * skill_multiplier)
		
/obj/projectile/bullet/reusable/sling_bullet //parent for proper reusable sling bullets
	name = "sling bullet"
	desc = "If you're reading this: duck."
	damage = 25
	damage_type = BRUTE
	armor_penetration = 0
	icon = 'icons/roguetown/items/natural.dmi'
	icon_state = "stone1"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/sling_bullet
	range = 15
	hitsound = 'sound/combat/hits/blunt/bluntsmall (1).ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	flag = "piercing"
	speed = 0.4		

/obj/projectile/bullet/reusable/sling_bullet/on_hit(atom/target)
	. = ..()

	var/mob/living/L = firer
	if(!L || !L.mind) return

	var/skill_multiplier = 0

	if(isliving(target)) // If the target theyre shooting at is a mob/living
		var/mob/living/T = target
		if(T.stat != DEAD) // If theyre alive
			skill_multiplier = 4

	if(skill_multiplier && can_train_combat_skill(L, /datum/skill/combat/slings, SKILL_LEVEL_LEGENDARY))
		L.mind.add_sleep_experience(/datum/skill/combat/slings, L.STAINT * skill_multiplier)

/obj/projectile/bullet/reusable/sling_bullet/stone
	name = "stone sling bullet"
	damage = 30 //proper stones are better
	armor_penetration = 0
	ammo_type = /obj/item/ammo_casing/caseless/rogue/sling_bullet/stone
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj"
	
/obj/projectile/bullet/reusable/sling_bullet/iron
	name = "iron sling bullet"
	damage = 30
	armor_penetration = 30
	ammo_type = /obj/item/ammo_casing/caseless/rogue/sling_bullet/iron
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj"

#undef ARROW_DAMAGE
#undef BOLT_DAMAGE
#undef BULLET_DAMAGE
#undef ARROW_PENETRATION
#undef BOLT_PENETRATION
#undef BULLET_PENETRATION
