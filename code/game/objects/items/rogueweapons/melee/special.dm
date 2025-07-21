/obj/item/rogueweapon/lordscepter
	force = 20
	force_wielded = 20
	possible_item_intents = list(/datum/intent/lordbash, /datum/intent/lord_electrocute, /datum/intent/lord_silence)
	gripped_intents = list(/datum/intent/lordbash)
	name = "master's rod"
	desc = "Bend the knee. Can't be used outside of the manor."
	icon_state = "scepter"
	icon = 'icons/roguetown/weapons/32.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.75
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP
	associated_skill = /datum/skill/combat/maces
	smeltresult = /obj/item/ingot/iron
	swingsound = BLUNTWOOSH_MED
	minstr = 5
	blade_dulling = DULLING_SHAFT_WOOD

	grid_height = 96
	grid_width = 32

/datum/intent/lordbash
	name = "bash"
	blade_class = BCLASS_BLUNT
	icon_state = "inbash"
	attack_verb = list("bashes", "strikes")
	penfactor = BLUNT_DEFAULT_PENFACTOR
	item_d_type = "blunt"

/datum/intent/lord_electrocute
	name = "electrocute"
	blade_class = null
	icon_state = "inuse"
	tranged = TRUE
	noaa = TRUE

/datum/intent/lord_silence
	name = "silence"
	blade_class = null
	icon_state = "inuse"
	tranged = TRUE
	noaa = TRUE

/obj/item/rogueweapon/lordscepter/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -7,"nx" = 11,"ny" = -6,"wx" = -1,"wy" = -6,"ex" = 3,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -1,"sy" = -4,"nx" = 1,"ny" = -3,"wx" = -1,"wy" = -6,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 20,"wturn" = 18,"eturn" = -19,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 0,"sy" = 2,"nx" = 1,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 4,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/rogueweapon/lordscepter/afterattack(atom/target, mob/user, flag)
	. = ..()
	if(get_dist(user, target) > 7)
		return
	
	user.changeNext_move(CLICK_CD_MELEE)

	if(ishuman(user))
		var/mob/living/carbon/human/HU = user

		if(HU.job != "Grand Duke")
			to_chat(user, span_danger("The rod doesn't obey me."))
			return

		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			var/area/target_area = get_area(H)

			if(!istype(target_area, /area/rogue/indoors/town/manor))
				to_chat(user, span_danger("The rod cannot be used on targets outside of the manor!"))
				return

			if(H == HU)
				return

			if(H.anti_magic_check())
				to_chat(user, span_danger("Something is disrupting the rod's power!"))
				return
		
			if(!(H in SStreasury.bank_accounts))
				to_chat(user, span_danger("The target must have a Meister account!"))
				return

			if(istype(user.used_intent, /datum/intent/lord_electrocute))
				HU.visible_message(span_warning("[HU] electrocutes [H] with the [src]."))
				user.Beam(target,icon_state="lightning[rand(1,12)]",time=5)
				H.electrocute_act(5, src)
				to_chat(H, span_danger("I'm electrocuted by the scepter!"))
				return

			if(istype(user.used_intent, /datum/intent/lord_silence))
				HU.visible_message("<span class='warning'>[HU] silences [H] with \the [src].</span>")
				H.set_silence(20 SECONDS)
				to_chat(H, "<span class='danger'>I'm silenced by the scepter!</span>")
				return

/obj/item/rogueweapon/mace/stunmace
	force = 15
	force_wielded = 15
	name = "stunmace"
	icon_state = "stunmace0"
	desc = "Pain is our currency here."
	gripped_intents = null
	w_class = WEIGHT_CLASS_NORMAL
	possible_item_intents = list(/datum/intent/mace/strike/stunner, /datum/intent/mace/smash/stunner)
	wbalance = WBALANCE_NORMAL
	minstr = 5
	wdefense = 0
	var/charge = 100
	var/on = FALSE

/datum/intent/mace/strike/stunner/afterchange()
	var/obj/item/rogueweapon/mace/stunmace/I = masteritem
	if(I)
		if(I.on)
			hitsound = list('sound/items/stunmace_hit (1).ogg','sound/items/stunmace_hit (2).ogg')
		else
			hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	. = ..()

/datum/intent/mace/smash/stunner/afterchange()
	var/obj/item/rogueweapon/mace/stunmace/I = masteritem
	if(I)
		if(I.on)
			hitsound = list('sound/items/stunmace_hit (1).ogg','sound/items/stunmace_hit (2).ogg')
		else
			hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	. = ..()

/obj/item/rogueweapon/mace/stunmace/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/rogueweapon/mace/stunmace/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/rogueweapon/mace/stunmace/funny_attack_effects(mob/living/target, mob/living/user, nodmg)
	. = ..()
	if(on)
		target.electrocute_act(5, src)
		charge -= 33
		if(charge <= 0)
			on = FALSE
			charge = 0
			update_icon()
			if(user.a_intent)
				var/datum/intent/I = user.a_intent
				if(istype(I))
					I.afterchange()

/obj/item/rogueweapon/mace/stunmace/update_icon()
	if(on)
		icon_state = "stunmace1"
	else
		icon_state = "stunmace0"

/obj/item/rogueweapon/mace/stunmace/attack_self(mob/user)
	if(on)
		on = FALSE
	else
		if(charge <= 33)
			to_chat(user, span_warning("It's out of juice."))
			return
		user.visible_message(span_warning("[user] flicks [src] on."))
		on = TRUE
		charge--
	playsound(user, pick('sound/items/stunmace_toggle (1).ogg','sound/items/stunmace_toggle (2).ogg','sound/items/stunmace_toggle (3).ogg'), 100, TRUE)
	if(user.a_intent)
		var/datum/intent/I = user.a_intent
		if(istype(I))
			I.afterchange()
	update_icon()
	add_fingerprint(user)

/obj/item/rogueweapon/mace/stunmace/process()
	if(on)
		charge--
	else
		if(charge < 100)
			charge++
	if(charge <= 0)
		on = FALSE
		charge = 0
		update_icon()
		var/mob/user = loc
		if(istype(user))
			if(user.a_intent)
				var/datum/intent/I = user.a_intent
				if(istype(I))
					I.afterchange()
		playsound(src, pick('sound/items/stunmace_toggle (1).ogg','sound/items/stunmace_toggle (2).ogg','sound/items/stunmace_toggle (3).ogg'), 100, TRUE)

/obj/item/rogueweapon/mace/stunmace/extinguish()
	if(on)
		var/mob/living/user = loc
		if(istype(user))
			user.electrocute_act(5, src)
		on = FALSE
		charge = 0
		update_icon()
		playsound(src, pick('sound/items/stunmace_toggle (1).ogg','sound/items/stunmace_toggle (2).ogg','sound/items/stunmace_toggle (3).ogg'), 100, TRUE)

/obj/item/rogueweapon/katar
	slot_flags = ITEM_SLOT_HIP
	force = 24
	possible_item_intents = list(/datum/intent/katar/cut, /datum/intent/katar/thrust)
	name = "katar"
	desc = "A blade that sits above the users fist. Commonly used by those proficient at unarmed fighting"
	icon_state = "katar"
	icon = 'icons/roguetown/weapons/32.dmi'
	gripsprite = FALSE
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_SMALL
	parrysound = list('sound/combat/parry/bladed/bladedsmall (1).ogg','sound/combat/parry/bladed/bladedsmall (2).ogg','sound/combat/parry/bladed/bladedsmall (3).ogg')
	max_blade_int = 150
	max_integrity = 80
	swingsound = list('sound/combat/wooshes/bladed/wooshsmall (1).ogg','sound/combat/wooshes/bladed/wooshsmall (2).ogg','sound/combat/wooshes/bladed/wooshsmall (3).ogg')
	associated_skill = /datum/skill/combat/unarmed
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	throwforce = 12
	wdefense = 4
	wbalance = WBALANCE_SWIFT
	thrown_bclass = BCLASS_CUT
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/steel

/datum/intent/katar
	clickcd = 8

/datum/intent/katar/cut
	name = "cut"
	icon_state = "incut"
	attack_verb = list("cuts", "slashes")
	animname = "cut"
	blade_class = BCLASS_CUT
	hitsound = list('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg')
	penfactor = 0
	chargetime = 0
	swingdelay = 0
	damfactor = 1.3
	clickcd = CLICK_CD_INTENTCAP
	item_d_type = "slash"

/datum/intent/katar/thrust
	name = "thrust"
	icon_state = "instab"
	attack_verb = list("thrusts")
	animname = "stab"
	blade_class = BCLASS_STAB
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = 40
	chargetime = 0
	clickcd = CLICK_CD_INTENTCAP
	item_d_type = "stab"

/obj/item/rogueweapon/katar/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -7,"sy" = -4,"nx" = 7,"ny" = -4,"wx" = -3,"wy" = -4,"ex" = 1,"ey" = -4,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 110,"sturn" = -110,"wturn" = -110,"eturn" = 110,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/katar/abyssor
	name = "barotrauma"
	desc = "A gift from a creature of the sea. The claw is sharpened to a wicked edge."
	icon_state = "abyssorclaw"
	force = 27	//Its thrust will be able to pen 80 stab armor if the wielder has 17 STR. (With softcap)
	max_integrity = 120


/obj/item/rogueweapon/knuckles
	name = "steel knuckles"
	desc = "A mean looking pair of steel knuckles."
	force = 22
	possible_item_intents = list(/datum/intent/knuckles/strike,/datum/intent/knuckles/smash)
	icon = 'icons/roguetown/weapons/32.dmi'
	icon_state = "steelknuckle"
	gripsprite = FALSE
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_HIP
	parrysound = list('sound/combat/parry/pugilism/unarmparry (1).ogg','sound/combat/parry/pugilism/unarmparry (2).ogg','sound/combat/parry/pugilism/unarmparry (3).ogg')
	sharpness = IS_BLUNT
	max_integrity = 300
	swingsound = list('sound/combat/wooshes/punch/punchwoosh (1).ogg','sound/combat/wooshes/punch/punchwoosh (2).ogg','sound/combat/wooshes/punch/punchwoosh (3).ogg')
	associated_skill = /datum/skill/combat/unarmed
	throwforce = 12
	wdefense = 7
	wbalance = WBALANCE_HEAVY
	blade_dulling = DULLING_SHAFT_WOOD
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/steel
	grid_width = 64
	grid_height = 32
	intdamage_factor = 1.2

/obj/item/rogueweapon/knuckles/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.2,"sx" = -7,"sy" = -4,"nx" = 7,"ny" = -4,"wx" = -3,"wy" = -4,"ex" = 1,"ey" = -4,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 110,"sturn" = -110,"wturn" = -110,"eturn" = 110,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.1,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/knuckles/bronzeknuckles
	name = "bronze knuckles"
	desc = "A mean looking pair of bronze knuckles. Mildly heavier than it's steel counterpart, making it a solid defensive option, if less wieldy."
	force = 20
	possible_item_intents = list(/datum/intent/knuckles/strike,/datum/intent/knuckles/smash)
	icon = 'icons/roguetown/weapons/32.dmi'
	icon_state = "bronzeknuckle"
	gripsprite = FALSE
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_HIP
	parrysound = list('sound/combat/parry/pugilism/unarmparry (1).ogg','sound/combat/parry/pugilism/unarmparry (2).ogg','sound/combat/parry/pugilism/unarmparry (3).ogg')
	sharpness = IS_BLUNT
	max_integrity = 250
	swingsound = list('sound/combat/wooshes/punch/punchwoosh (1).ogg','sound/combat/wooshes/punch/punchwoosh (2).ogg','sound/combat/wooshes/punch/punchwoosh (3).ogg')
	associated_skill = /datum/skill/combat/unarmed
	throwforce = 12
	wdefense = 6
	wbalance = WBALANCE_HEAVY
	blade_dulling = DULLING_SHAFT_WOOD
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/bronze
	intdamage_factor = 1.2

/datum/intent/knuckles
	clickcd = 8

/datum/intent/knuckles/strike
	name = "punch"
	blade_class = BCLASS_BLUNT
	attack_verb = list("punches", "clocks")
	hitsound = list('sound/combat/hits/punch/punch_hard (1).ogg', 'sound/combat/hits/punch/punch_hard (2).ogg', 'sound/combat/hits/punch/punch_hard (3).ogg')
	chargetime = 0
	penfactor = BLUNT_DEFAULT_PENFACTOR
	clickcd = 8
	damfactor = 1.1
	swingdelay = 0
	icon_state = "inpunch"
	item_d_type = "blunt"

/datum/intent/knuckles/smash
	name = "smash"
	blade_class = BCLASS_SMASH
	attack_verb = list("smashes")
	hitsound = list('sound/combat/hits/punch/punch_hard (1).ogg', 'sound/combat/hits/punch/punch_hard (2).ogg', 'sound/combat/hits/punch/punch_hard (3).ogg')
	penfactor = BLUNT_DEFAULT_PENFACTOR
	damfactor = 1.1
	clickcd = CLICK_CD_MELEE
	swingdelay = 8
	intent_intdamage_factor = 1.8
	icon_state = "insmash"
	item_d_type = "blunt"

/obj/item/rogueweapon/knuckles/aknuckles
	name = "decrepit knuckles"
	desc = "a set of knuckles made of ancient metals, Aeon's grasp wither their form."
	icon_state = "aknuckle"
	force = 12
	max_integrity = 150
	wdefense = 5
	smeltresult = /obj/item/ingot/aalloy
	blade_dulling = DULLING_SHAFT_CONJURED

/obj/item/rogueweapon/knuckles/paknuckles
	name = "ancient knuckles"
	desc = "a set of knuckles made of ancient metals, Aeon's grasp has been lifted from their form."
	icon_state = "aknuckle"
	smeltresult = /obj/item/ingot/aaslag


/obj/item/rogueweapon/knuckles/eora
	name = "close caress"
	desc = "Some times call for a more intimate approach."
	force = 25
	icon_state = "eoraknuckle"

///Peasantry / Militia Weapon Pack///

/obj/item/rogueweapon/woodstaff/militia
	force = 20
	force_wielded = 30
	possible_item_intents = list(SPEAR_BASH, /datum/intent/spear/cut)
	gripped_intents = list(/datum/intent/pick/ranged, /datum/intent/spear/thrust, SPEAR_BASH)
	name = "militia goedendag"
	desc = "Clubs - and their spiked descendants - are older than most languages and civilizations. Tyme hasn't made them any less deadly, however. "
	icon_state = "peasantwarclub"
	icon = 'icons/roguetown/weapons/64.dmi'
	smeltresult = /obj/item/rogueore/coal
	sharpness = IS_SHARP
	walking_stick = TRUE
	wdefense = 6
	max_blade_int = 80

/obj/item/rogueweapon/woodstaff/militia/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.8,"sx" = -9,"sy" = 5,"nx" = 9,"ny" = 5,"wx" = -4,"wy" = 4,"ex" = 4,"ey" = 4,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.8,"sx" = 8,"sy" = 0,"nx" = -1,"ny" = 0,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/rogueweapon/greataxe/militia
	name = "militia war axe"
	desc = "Shovels have always held some manner of importance in a militiaman's lyfe. Instead of digging corpsepits, however, this poleaxe will now fill them up."
	icon_state = "peasantwaraxe"
	possible_item_intents = list(/datum/intent/axe/cut, /datum/intent/axe/chop, SPEAR_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(/datum/intent/rend/reach, /datum/intent/axe/chop/battle/greataxe, /datum/intent/sword/peel/big, SPEAR_BASH)
	force = 15
	force_wielded = 25
	minstr = 10
	max_blade_int = 100
	anvilrepair = /datum/skill/craft/carpentry
	smeltresult = /obj/item/rogueore/coal
	wdefense = 4
	wbalance = WBALANCE_HEAVY

/obj/item/rogueweapon/spear/militia
	force = 18
	force_wielded = 30
	possible_item_intents = list(SPEAR_THRUST, SPEAR_BASH)
	gripped_intents = list(SPEAR_THRUST, SPEAR_CUT, SPEAR_BASH)
	name = "militia spear"
	desc = "Pitchforks and hoes traditionally till the soil. In tymes of peril, however, it isn't uncommon for a militiaman to pound them into polearms."
	icon_state = "peasantwarspear"
	icon = 'icons/roguetown/weapons/64.dmi'
	minstr = 8
	max_blade_int = 100
	max_integrity = 200
	anvilrepair = /datum/skill/craft/carpentry
	smeltresult = /obj/item/rogueore/coal
	resistance_flags = FIRE_PROOF
	light_system = MOVABLE_LIGHT
	light_power = 5
	light_outer_range = 5
	light_on = FALSE
	light_color = "#db892b"
	var/is_loaded = FALSE 
	var/list/hay_types = list(/obj/structure/fluff/nest, /obj/structure/composter, /obj/structure/flora/roguegrass, /obj/item/reagent_containers/food/snacks/grown/wheat)

/obj/item/rogueweapon/spear/militia/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/ignitable/warspear)

/obj/item/rogueweapon/spear/militia/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(user.Adjacent(target) || get_dist(target, user) <= user.used_intent?.reach)
		if(!is_loaded)
			for(var/type in hay_types)
				if(istype(target, type))
					load_hay()
					update_icon()
					user.regenerate_icons()
					visible_message(span_warning("[user] grabs a clump of [target] and wraps it around \the [src]!"))
					playsound(src, 'sound/misc/hay_collect.ogg', 100)
					qdel(target)
					break

/obj/item/rogueweapon/spear/militia/proc/load_hay()
	var/datum/component/ignitable/CI = GetComponent(/datum/component/ignitable)
	is_loaded = TRUE
	toggle_state = "peasantwarspear_hay"
	icon_state = "[toggle_state][wielded ? "1" : ""]"
	CI.make_ignitable()

/datum/component/ignitable/warspear
	single_use = TRUE
	is_ignitable = FALSE
	icon_state_ignited = "peasantwarspear_hayfire"


/datum/component/ignitable/warspear/light_off()
	..()
	if(istype(parent, /obj/item/rogueweapon/spear/militia))
		var/obj/item/rogueweapon/spear/militia/P = parent
		P.is_loaded = FALSE

//Component used to make any item gain the ability to be lit afire and turned into a light source / usable for single-use fire attack.
//Uses toggle_state for the 'on-fire' sprites.
//By default, all it does is become ignited when you click a fire / light source with it, and spread it to anything else, then extinguish.
/datum/component/ignitable
	var/is_ignitable = TRUE	//This var makes it actually ignitable, so you want to handle it on a per-item-with-component basis.
	var/is_active
	var/single_use = TRUE
	var/icon_state_ignited

/datum/component/ignitable/Initialize(...)
	. = ..()
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK, PROC_REF(item_afterattack))
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ATOM_FIRE_ACT, PROC_REF(on_fireact))

/datum/component/ignitable/proc/on_fireact(added, maxstacks)
	if(is_ignitable && !is_active)
		light_on()

/datum/component/ignitable/proc/make_ignitable()
	if(!is_ignitable && !is_active)
		is_ignitable = TRUE

/datum/component/ignitable/proc/light_on()
	var/obj/I = parent
	I.set_light_on(TRUE)
	playsound(I.loc, 'sound/items/firelight.ogg', 100)
	is_active = TRUE
	is_ignitable = FALSE
	update_icon()

/datum/component/ignitable/proc/light_off()
	var/obj/I = parent
	I.set_light_on(FALSE)
	playsound(get_turf(I), 'sound/items/firesnuff.ogg', 100)

/datum/component/ignitable/proc/update_icon()
	var/obj/item/I = parent
	if(is_active)
		I.toggle_state = "[icon_state_ignited]"
		I.icon_state = "[icon_state_ignited][I.wielded ? "1" : ""]"
	else
		I.icon_state = "[initial(I.icon_state)][I.wielded ? "1" : ""]"
		I.toggle_state = null
		I.update_icon()


/datum/component/ignitable/proc/item_afterattack(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	var/ignited = FALSE
	if(user.used_intent?.reach >= get_dist(target, user))
		if(is_active)
			if(isobj(target))
				var/obj/O = target
				if(!(O.resistance_flags & FIRE_PROOF))
					O.spark_act()
					O.fire_act()
					ignited = TRUE
			if(isliving(target))
				var/mob/living/M = target
				M.adjust_fire_stacks(5)
				M.IgniteMob()
				ignited = TRUE
			if(ignited && single_use)
				is_active = FALSE
				light_off()
				update_icon()
				user.regenerate_icons()
		else if(is_ignitable && !is_active)
			if(isobj(target))
				var/obj/O = target
				if(O.damtype == BURN || O.light_on == TRUE)	//Super hacky, but should work on every conventional source you'd expect to ignite it. But also a few other weird ones.
					light_on()
					user.regenerate_icons()


	
/datum/component/ignitable/proc/on_examine(datum/source, mob/user, list/examine_list)
	return

/obj/item/rogueweapon/scythe
	force = 15
	force_wielded = 25
	possible_item_intents = list(SPEAR_BASH)
	gripped_intents = list(/datum/intent/spear/cut/scythe, SPEAR_BASH, MACE_STRIKE)
	name = "scythe"
	desc = "The bane of fields, the trimmer of grass, the harvester of wheat, and - depending on who you ask - the shepherd of souls to the afterlyfe."
	icon_state = "peasantscythe"
	icon = 'icons/roguetown/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 8
	max_blade_int = 100
	anvilrepair = /datum/skill/craft/carpentry
	smeltresult = /obj/item/rogueore/coal
	associated_skill = /datum/skill/labor/farming
	blade_dulling = DULLING_SHAFT_WOOD
	walking_stick = TRUE
	wdefense = 6
	thrown_bclass = BCLASS_BLUNT
	throwforce = 10
	resistance_flags = FLAMMABLE

/obj/item/rogueweapon/scythe/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.7,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)


/obj/item/rogueweapon/pick/militia
	name = "militia warpick"
	desc = "At the end of the dae, a knight's bascinet isn't much different than a particularly large stone. After all, both tend to rupture with sobering ease when introduced to a sharpened pickend."
	force = 20
	force_wielded = 25
	possible_item_intents = list(/datum/intent/pick)
	gripped_intents = list(/datum/intent/pick, /datum/intent/stab/militia)
	icon_state = "milpick"
	icon = 'icons/roguetown/weapons/32.dmi'
	sharpness = IS_SHARP
	wlength = WLENGTH_SHORT
	max_blade_int = 80
	max_integrity = 400
	slot_flags = ITEM_SLOT_HIP
	associated_skill = /datum/skill/labor/mining
	anvilrepair = /datum/skill/craft/carpentry
	smeltresult = /obj/item/ingot/iron
	wdefense = 1
	wbalance = WBALANCE_NORMAL

/obj/item/rogueweapon/pick/militia/steel
	force = 25
	force_wielded = 30
	name = "militia steel warpick"
	desc = "At the end of the dae, a knight's bascinet isn't much different than a particularly large stone. After all, both tend to rupture with sobering ease when introduced to a sharpened pickend. This one is honed out of steel parts."
	icon_state = "milsteelpick"
	max_blade_int = 160
	max_integrity = 600
	associated_skill = /datum/skill/combat/axes
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/steel
	wdefense = 5
	wbalance = WBALANCE_HEAVY

/obj/item/rogueweapon/sword/falchion/militia
	name = "maciejowski"
	desc = "Fittingly coined as a 'peasant's falchion', this hunting sword's blade has been retempered to hunt the most dangerous game. Those jagged edges are perfect for tearing into flesh-and-maille."
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/strike)
	icon_state = "maciejowski"
	gripped_intents = list(/datum/intent/rend, /datum/intent/sword/chop/militia, /datum/intent/sword/peel, /datum/intent/sword/strike)
	force = 18
	force_wielded = 25
	anvilrepair = /datum/skill/craft/carpentry
	smeltresult = /obj/item/ingot/iron
	wdefense = 3
	wbalance = WBALANCE_HEAVY
	intdamage_factor = 0.6
