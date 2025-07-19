//intent datums ฅ^•ﻌ•^ฅ

/datum/intent/axe/cut
	name = "cut"
	icon_state = "incut"
	blade_class = BCLASS_CUT
	attack_verb = list("cuts", "slashes")
	hitsound = list('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg')
	animname = "cut"
	penfactor = 20
	chargetime = 0
	item_d_type = "slash"

/datum/intent/axe/chop
	name = "chop"
	icon_state = "inchop"
	blade_class = BCLASS_CHOP
	attack_verb = list("chops", "hacks")
	animname = "chop"
	hitsound = list('sound/combat/hits/bladed/genchop (1).ogg', 'sound/combat/hits/bladed/genchop (2).ogg', 'sound/combat/hits/bladed/genchop (3).ogg')
	penfactor = 35
	swingdelay = 10
	clickcd = 14
	item_d_type = "slash"

/datum/intent/axe/chop/scythe
	reach = 2

/datum/intent/axe/chop/stone
	penfactor = 5

/datum/intent/axe/chop/battle
	damfactor = 1.2 //36 on battleaxe
	penfactor = 40

/datum/intent/axe/cut/battle
	penfactor = 25

/datum/intent/axe/bash
	name = "bash"
	icon_state = "inbash"
	attack_verb = list("bashes", "clubs")
	animname = "strike"
	blade_class = BCLASS_BLUNT
	hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	chargetime = 0
	penfactor = BLUNT_DEFAULT_PENFACTOR
	swingdelay = 5
	damfactor = 1.1
	item_d_type = "blunt"

//axe objs ฅ^•ﻌ•^ฅ

/obj/item/rogueweapon/stoneaxe
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	force = 18
	force_wielded = 20
	possible_item_intents = list(/datum/intent/axe/chop/stone)
	name = "stone axe"
	desc = "A rough stone axe. Badly balanced."
	icon_state = "stoneaxe"
	icon = 'icons/roguetown/weapons/32.dmi'
	item_state = "axe"
	lefthand_file = 'icons/mob/inhands/weapons/rogue_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/rogue_righthand.dmi'
	//dropshrink = 0.75
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	swingsound = BLADEWOOSH_MED
	associated_skill = /datum/skill/combat/axes
	max_blade_int = 100
	minstr = 8
	wdefense = 1
	demolition_mod = 1.25
	w_class = WEIGHT_CLASS_BULKY
	wlength = WLENGTH_SHORT
	pickup_sound = 'sound/foley/equip/rummaging-03.ogg'
	gripped_intents = list(/datum/intent/axe/chop/stone)
	resistance_flags = FLAMMABLE
	blade_dulling = DULLING_SHAFT_WOOD


/obj/item/rogueweapon/stoneaxe/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,
"sx" = -15,
"sy" = -12,
"nx" = 9,
"ny" = -11,
"wx" = -11,
"wy" = -11,
"ex" = 1,
"ey" = -12,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 0,
"nturn" = 90,
"sturn" = -90,
"wturn" = -90,
"eturn" = 90,
"nflip" = 0,
"sflip" = 8,
"wflip" = 8,
"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,
"sx" = -15,
"sy" = -1,
"nx" = 10,
"ny" = 0,
"wx" = -13,
"wy" = -1,
"ex" = 2,
"ey" = -1,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 0,
"nturn" = 0,
"sturn" = 0,
"wturn" = 0,
"eturn" = 0,
"nflip" = 0,
"sflip" = 8,
"wflip" = 8,
"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
	return ..()

// Battle Axe
/obj/item/rogueweapon/stoneaxe/battle
	force = 25
	force_wielded = 30
	possible_item_intents = list(/datum/intent/axe/cut/battle, /datum/intent/axe/chop/battle, /datum/intent/axe/bash, /datum/intent/sword/peel)
	wlength = WLENGTH_LONG		//It's a big battle-axe.
	name = "battle axe"
	desc = "A steel battleaxe of war. Has a wicked edge."
	icon_state = "battleaxe"
	max_blade_int = 300
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2
	gripped_intents = list(/datum/intent/axe/cut/battle ,/datum/intent/axe/chop/battle, /datum/intent/axe/bash, /datum/intent/sword/peel)
	minstr = 9
	wdefense = 4

/obj/item/rogueweapon/stoneaxe/battle/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -9,"sy" = -8,"nx" = 9,"ny" = -7,"wx" = -7,"wy" = -8,"ex" = 3,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = -7,"nx" = -6,"ny" = -3,"wx" = 3,"wy" = -4,"ex" = 4,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -44,"sturn" = 45,"wturn" = 47,"eturn" = 33,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
	return ..()

/obj/item/rogueweapon/stoneaxe/oath
	force = 30
	force_wielded = 40
	possible_item_intents = list(/datum/intent/axe/cut/battle, /datum/intent/axe/chop/battle, /datum/intent/axe/bash)
	name = "oath"
	desc = "A hefty, steel-forged axe marred by the touch of countless Wardens. Despite it's weathered etchings and worn grip, the blade has been honed to a razor's edge and you can see your reflection in the finely polished metal."
	icon_state = "oath"
	icon = 'icons/roguetown/weapons/64.dmi'
	max_blade_int = 500
	dropshrink = 0.75
	wlength = WLENGTH_LONG
	slot_flags = ITEM_SLOT_BACK
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	smeltresult = /obj/item/ingot/steel
	gripped_intents = list(/datum/intent/axe/cut/battle ,/datum/intent/axe/chop/battle, /datum/intent/axe/bash)
	minstr = 12
	wdefense = 5

/obj/item/rogueweapon/stoneaxe/oath/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -8,"sy" = -1,"nx" = 9,"ny" = -1,"wx" = -4,"wy" = -1,"ex" = 3,"ey" = -1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -45,"sturn" = 45,"wturn" = 45,"eturn" = -45,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0,"wielded")
			if("wielded")
				return list("shrink" = 0.5,"sx" = 4,"sy" = -4,"nx" = -6,"ny" = -3,"wx" = -8,"wy" = -4,"ex" = 8,"ey" = -4,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0,"onback")
			if("onbelt")
				return list("shrink" = 0.5,"sx" = 1,"sy" = -1,"nx" = 1,"ny" = -1,"wx" = 4,"wy" = -1,"ex" = -1,"ey" = -1,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0,)

/obj/item/rogueweapon/stoneaxe/woodcut
	name = "axe"
	force = 20
	force_wielded = 26
	possible_item_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop, /datum/intent/sword/peel)
	desc = "A regular iron woodcutting axe."
	icon_state = "axe"
	max_blade_int = 400
	smeltresult = /obj/item/ingot/iron
	gripped_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop, /datum/intent/sword/peel)
	wdefense = 2

/obj/item/rogueweapon/stoneaxe/woodcut/aaxe
	name = "decrepit axe"
	desc = "An axe which has fallen to Aeon's grasp. Withered and worn."
	icon_state = "ahandaxe"
	smeltresult = /obj/item/ingot/aalloy
	force = 17
	force_wielded = 20
	max_integrity = 180
	blade_dulling = DULLING_SHAFT_CONJURED

/obj/item/rogueweapon/stoneaxe/hurlbat
	name = "hurlbat"
	desc = "With the sleek, lightweight design of a tossblade, and the stopping power of a battleaxe, the hurlbat's tricky design allows it to strike its targets with deadly efficiency. Although its historic origin is disputed, it is often-seen amongst Varangian Bounty-Hunters and ruthless Steppesmen."
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_SMALL
	wbalance = WBALANCE_SWIFT
	minstr = 13 //Better hit those weights or go back to tossblades chuddy!
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/steel
	grid_height = 64
	grid_width = 32
	force = 20
	throwforce = 32 //You ever had an axe thrown at you? 
	throw_speed = 6 //Batarangs, baby.
	max_integrity = 50 //Brittle design, hits hard, breaks quickly.
	armor_penetration = 40 //On-par with steel tossblades. 
	wdefense = 1
	icon_state = "hurlbat"
	embedding = list("embedded_pain_multiplier" = 6, "embed_chance" = 50, "embedded_fall_chance" = 30) //high chance at embed, high chance to fall out on its own.
	possible_item_intents = list(/datum/intent/axe/chop/stone)
	gripped_intents = null
	sellprice = 1
	thrown_damage_flag = "piercing"		//Checks piercing type like an arrow.

/obj/item/rogueweapon/stoneaxe/hurlbat/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -10,"sy" = -6,"nx" = 11,"ny" = -3,"wx" = -4,"wy" = -3,"ex" = 5,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


//Pickaxe-axe ; Technically both a tool and a weapon, but it goes here due to weapon function. Subtype of woodcutter axe, mostly a weapon.
/obj/item/rogueweapon/stoneaxe/woodcut/pick
	name = "Pulaski axe"
	desc = "An odd mix of a pickaxe front and a hatchet blade back, capable of being switched between."
	icon_state = "paxe"
	possible_item_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop, /datum/intent/mace/warhammer/pick, /datum/intent/axe/bash)
	gripped_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop, /datum/intent/mace/warhammer/pick, /datum/intent/axe/bash)
	smeltresult = /obj/item/ingot/steel
	wlength = WLENGTH_NORMAL
	toolspeed = 2

/obj/item/rogueweapon/stoneaxe/woodcut/wardenpick
	name = "Wardens' axe"
	desc = "A multi-use axe smithed by the Wardens since time immemorial for both it's use as a tool and a weapon."
	icon_state = "wardenpax"
	force = 22
	force_wielded = 28
	possible_item_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop, /datum/intent/mace/warhammer/pick, /datum/intent/axe/bash)
	gripped_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop, /datum/intent/mace/warhammer/pick, /datum/intent/axe/bash)
	smeltresult = /obj/item/ingot/steel
	wlength = WLENGTH_NORMAL
	toolspeed = 2


// Copper Hatchet
/obj/item/rogueweapon/stoneaxe/handaxe/copper
	force = 13
	name = "copper hatchet"
	desc = "A copper hand axe. It is not very durable."
	max_integrity = 100 // Half of the norm
	icon_state = "chatchet"
	smeltresult = /obj/item/ingot/copper

/obj/item/rogueweapon/stoneaxe/handaxe
	force = 19
	possible_item_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop, /datum/intent/sword/peel)
	name = "hatchet"
	desc = "An iron hand axe."
	icon_state = "hatchet"
	minstr = 1
	max_blade_int = 400
	smeltresult = /obj/item/ingot/iron
	gripped_intents = null
	wdefense = 2

/obj/item/rogueweapon/stoneaxe/woodcut/steel
	name = "steel axe"
	icon_state = "saxe"
	desc = "A steel woodcutting axe. Performs much better than its iron counterpart."
	force = 26
	force_wielded = 28
	max_blade_int = 500
	smeltresult = /obj/item/ingot/steel
	wdefense = 3

/obj/item/rogueweapon/stoneaxe/woodcut/steel/paaxe
	name = "ancient alloy axe"
	desc = "An ancient axe, Aeon's grasp has been lifted from it."
	icon_state = "ahandaxe"
	smeltresult = /obj/item/ingot/aaslag

/datum/intent/axe/cut/long
	reach = 2

/datum/intent/axe/chop/long
	reach = 2

/obj/item/rogueweapon/stoneaxe/woodcut/steel/woodcutter
	name = "woodcutter's axe"
	icon = 'icons/roguetown/weapons/64.dmi'
	icon_state = "woodcutter"
	desc = "A long-handled axe with a carved grip, made of high quality wood. Perfect for those in the lumber trade."
	max_integrity = 300		//100 higher than normal; basically it's main difference.
	possible_item_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop, /datum/intent/axe/bash, /datum/intent/sword/peel)
	gripped_intents = list(/datum/intent/axe/cut/long, /datum/intent/axe/chop/long, /datum/intent/axe/bash, /datum/intent/sword/peel)
	wlength = WLENGTH_LONG
	w_class = WEIGHT_CLASS_BULKY
	demolition_mod = 1.5			//Base is 1.25, so 25% extra. Helps w/ caprentry and building kinda.
	slot_flags = ITEM_SLOT_BACK		//Needs to go on back.
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	
/obj/item/rogueweapon/stoneaxe/woodcut/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -9,"sy" = -8,"nx" = 9,"ny" = -7,"wx" = -7,"wy" = -8,"ex" = 3,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.7,"sx" = 4,"sy" = -4,"nx" = -6,"ny" = -3,"wx" = -4,"wy" = -4,"ex" = 4,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -44,"sturn" = 45,"wturn" = -33,"eturn" = 33,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/stoneaxe/boneaxe
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	force = 18
	force_wielded = 22
	possible_item_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop)
	name = "bone axe"
	desc = "A rough axe made of bones"
	icon_state = "boneaxe"
	lefthand_file = 'icons/mob/inhands/weapons/rogue_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/rogue_righthand.dmi'
	//dropshrink = 0.75
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	swingsound = BLADEWOOSH_MED
	associated_skill = /datum/skill/combat/axes
	max_blade_int = 100
	minstr = 8
	wdefense = 1
	w_class = WEIGHT_CLASS_BULKY
	wlength = WLENGTH_SHORT
	pickup_sound = 'sound/foley/equip/rummaging-03.ogg'
	gripped_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop)
	resistance_flags = FLAMMABLE

/obj/item/rogueweapon/stoneaxe/boneaxe/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -9,"sy" = -8,"nx" = 9,"ny" = -7,"wx" = -7,"wy" = -8,"ex" = 3,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = -7,"nx" = -6,"ny" = -3,"wx" = 3,"wy" = -4,"ex" = 4,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -44,"sturn" = 45,"wturn" = 47,"eturn" = 33,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
	return ..()

/obj/item/rogueweapon/stoneaxe/woodcut/silver
	name = "silver war axe"
	desc = "A one-handed war axe forged of silver."
	icon_state = "silveraxe"
	force = 24
	possible_item_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop, /datum/intent/axe/bash)
	minstr = 6
	max_blade_int = 400
	smeltresult = /obj/item/ingot/silver
	gripped_intents = null
	wdefense = 4
	is_silver = TRUE
	blade_dulling = DULLING_SHAFT_METAL

/obj/item/rogueweapon/stoneaxe/battle/psyaxe
	name = "psydonian war axe"
	desc = "An ornate battle axe, plated in a ceremonial veneer of silver. The premiere instigator of conflict against elven attachees."
	icon_state = "psyaxe"
	smeltresult = /obj/item/ingot/steel
	blade_dulling = DULLING_SHAFT_METAL

/obj/item/rogueweapon/stoneaxe/battle/psyaxe/ComponentInitialize()
	. = ..()								//+3 force, +50 blade int, +50 int, +1 def, make silver
	AddComponent(/datum/component/psyblessed, FALSE, 3, 50, 50, 1, TRUE)


/datum/intent/axe/cut/battle/greataxe
	reach = 2

/datum/intent/axe/chop/battle/greataxe
	reach = 2

/obj/item/rogueweapon/greataxe
	force = 15
	force_wielded = 30
	possible_item_intents = list(/datum/intent/axe/cut, /datum/intent/axe/chop, SPEAR_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(/datum/intent/axe/cut/battle/greataxe, /datum/intent/axe/chop/battle/greataxe, /datum/intent/sword/peel/big, SPEAR_BASH)
	name = "greataxe"
	desc = "A iron great axe, a long-handled axe with a single blade made for ruining someone's day beyond any measure.."
	icon_state = "igreataxe"
	icon = 'icons/roguetown/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 11
	max_blade_int = 200
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/iron
	associated_skill = /datum/skill/combat/axes
	blade_dulling = DULLING_SHAFT_WOOD
	wdefense = 6
	demolition_mod = 1.5

/obj/item/rogueweapon/greataxe/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/greataxe/steel
	force = 15
	force_wielded = 30
	possible_item_intents = list(/datum/intent/axe/cut, /datum/intent/axe/chop, SPEAR_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(/datum/intent/axe/cut/battle/greataxe, /datum/intent/axe/chop/battle/greataxe, /datum/intent/sword/peel/big, SPEAR_BASH)
	name = "steel greataxe"
	desc = "A steel great axe, a long-handled axe with a single blade made for ruining someone's day beyond any measure.."
	icon_state = "sgreataxe"
	icon = 'icons/roguetown/weapons/64.dmi'
	minstr = 11
	max_blade_int = 300
	smeltresult = /obj/item/ingot/steel

/obj/item/rogueweapon/greataxe/steel/doublehead
	force = 15
	force_wielded = 35
	possible_item_intents = list(/datum/intent/axe/cut, /datum/intent/axe/chop, SPEAR_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(/datum/intent/axe/cut/battle/greataxe, /datum/intent/axe/chop/battle/greataxe, /datum/intent/sword/peel/big, SPEAR_BASH)
	name = "double-headed steel greataxe"
	desc = "A steel great axe with a wicked double-bladed head. Perfect for cutting either men or trees into stumps.."
	icon_state = "doublegreataxe"
	icon = 'icons/roguetown/weapons/64.dmi'
	minstr = 12

/obj/item/rogueweapon/greataxe/steel/doublehead/graggar
	name = "vicious greataxe"
	desc = "A greataxe who's edge thrums with the motive force, violence, oh, sweet violence!"
	icon_state = "graggargaxe"
	blade_dulling = DULLING_SHAFT_GRAND
	force = 20
	force_wielded = 40
	icon = 'icons/roguetown/weapons/64.dmi'

/obj/item/rogueweapon/greataxe/steel/doublehead/graggar/pickup(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_HORDE))
		to_chat(user, "<font color='red'>UNWORTHY HANDS TOUCHING THIS AXE, CEASE OR BE PUNISHED!</font>")
		user.adjust_fire_stacks(5)
		user.IgniteMob()
		user.Stun(40)
	..()

////////////////////////////////////////
// Unique loot axes; mostly from mobs //
////////////////////////////////////////

/obj/item/rogueweapon/greataxe/steel/doublehead/minotaur
	name = "minotaur greataxe"
	desc = "An incredibly heavy and large axe, pried from the cold-dead hands of Dendor's most wicked of beasts."
	icon_state = "minotaurgreataxe"
	blade_dulling = DULLING_SHAFT_WOOD	//Suffer & go upgrade it
	force = 20							//Same as Graggar axe, only cus it's rare enough. Plus has the high strength req and crap starting-shaft.
	force_wielded = 40
	minstr = 15							//Boo-womp

/obj/item/rogueweapon/stoneaxe/woodcut/troll
	name = "crude heavy axe"
	desc = "An axe clearly made for some large crecher. Though crude in design, it appears to have a fair amount of weight to it.."
	icon_state = "trollaxe"
	force = 25
	force_wielded = 30					//Basically a slight better steel cutting axe.
	max_integrity = 150					//50% less than normal axe
	max_blade_int = 300
	minstr = 13							//Heavy, but still good.
	wdefense = 3						//Slightly better than norm, has 6 defense 2 handing it.
