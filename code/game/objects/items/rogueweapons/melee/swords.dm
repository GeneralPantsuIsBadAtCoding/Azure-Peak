//intent datums ฅ^•ﻌ•^ฅ

/datum/intent/sword/cut
	name = "strike"
	icon_state = "incut"
	attack_verb = list("cuts", "slashes")
	animname = "cut"
	blade_class = BCLASS_CUT
	chargetime = 0
	hitsound = list('sound/combat/hits/bladed/genslash (1).ogg', 'sound/combat/hits/bladed/genslash (2).ogg', 'sound/combat/hits/bladed/genslash (3).ogg')
	swingdelay = 0
	penfactor = 55
	damfactor = 1.0
	item_d_type = "slash"

/datum/intent/sword/cut/sabre
	clickcd = 10
	
/datum/intent/sword/thrust
	name = "stab"
	icon_state = "instab"
	attack_verb = list("stabs")
	animname = "stab"
	blade_class = BCLASS_STAB
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = 55
	chargetime = 0
	swingdelay = 0
	item_d_type = "stab"

/datum/intent/sword/strike
	name = "pommel strike"
	icon_state = "instrike"
	attack_verb = list("bashes", "clubs")
	animname = "strike"
	blade_class = BCLASS_BLUNT
	hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	chargetime = 0
	penfactor = 55
	swingdelay = 5
	damfactor = 0.9
	item_d_type = "blunt"

/datum/intent/sword/chop
	name = "chop"
	icon_state = "inchop"
	attack_verb = list("chops", "hacks")
	animname = "chop"
	blade_class = BCLASS_CHOP
	hitsound = list('sound/combat/hits/bladed/genchop (1).ogg', 'sound/combat/hits/bladed/genchop (2).ogg', 'sound/combat/hits/bladed/genchop (3).ogg')
	penfactor = 65
	swingdelay = 8
	damfactor = 1.0
	item_d_type = "slash"

//sword objs ฅ^•ﻌ•^ฅ

/obj/item/rogueweapon/sword
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	force = 22
	force_wielded = 23
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	name = "sword"
	desc = "A simple steel sword, clean and effective."
	icon_state = "sword1"
	icon = 'icons/roguetown/weapons/32.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/rogue_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/rogue_righthand.dmi'
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_MED
	associated_skill = /datum/skill/combat/swords
	max_blade_int = 100
	max_integrity = 150
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_BULKY
	pickup_sound = 'sound/foley/equip/swordlarge1.ogg'
	sheathe_sound = 'sound/items/wood_sharpen.ogg'
	flags_1 = CONDUCT_1
	throwforce = 10
	thrown_bclass = BCLASS_CUT
	//dropshrink = 0.75
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/steel
	minstr = 7
	sellprice = 30
	wdefense = 4

/obj/item/rogueweapon/sword/Initialize()
	. = ..()
	if(icon_state == "sword1")
		icon_state = "sword[rand(1,3)]"

/obj/item/rogueweapon/sword/decorated
	name = "engraved sword"
	desc = "A valuable sword for celebrations and rites."
	icon_state = "decsword1"
	sellprice = 140

/obj/item/rogueweapon/sword/decorated/Initialize()
	. = ..()
	if(icon_state == "decsword1")
		icon_state = "decsword[rand(1,3)]"

/obj/item/rogueweapon/sword/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/stone
	force = 17 //Weaker than a short sword
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/chop)
	gripped_intents = null
	name = "stone sword"
	desc = "A simple stone sword, crude and effective."
	icon_state = "stone_sword"
	max_blade_int = 70
	max_integrity = 70
	anvilrepair = /datum/skill/craft/crafting
	smeltresult = null
	minstr = 4
	wdefense = 4
	sellprice = 10

/obj/item/rogueweapon/sword/short
	name = "short sword"
	desc = "An archaic steel sword made for stabbing."
	force = 19
	possible_item_intents = list(/datum/intent/sword/cut/short, /datum/intent/sword/thrust/short)
	icon_state = "swordshort"
	gripped_intents = null
	minstr = 4
	wdefense = 4

/obj/item/rogueweapon/sword/long
	force = 23
	force_wielded = 24
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "longsword"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "longsword"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	name = "bastard sword"
	desc = "A bastard sword that can chop with ease."
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_LARGE
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	bigboy = 1
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	associated_skill = /datum/skill/combat/swords
	throwforce = 15
	thrown_bclass = BCLASS_CUT
	dropshrink = 0.75
	smeltresult = /obj/item/ingot/steel

/obj/item/rogueweapon/sword/long/death
	color = CLOTHING_BLACK

/obj/item/rogueweapon/sword/long/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback") return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded") return list("shrink" = 0.6,"sx" = 6,"sy" = -2,"nx" = -4,"ny" = 2,"wx" = -8,"wy" = -1,"ex" = 8,"ey" = 3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = -200,"wturn" = -160,"eturn" = -25,"nflip" = 8,"sflip" = 8,"wflip" = 0,"eflip" = 0)
			if("onbelt") return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/sword/long/heirloom
	force = 22
	force_wielded = 25
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "heirloom"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "longsword"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	name = "old sword"
	desc = "A old steel sword with a green leather grip."
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_LARGE
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	bigboy = 1
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	associated_skill = /datum/skill/combat/swords
	throwforce = 15
	thrown_bclass = BCLASS_CUT
	dropshrink = 0.75
	smeltresult = /obj/item/ingot/steel

/obj/item/rogueweapon/sword/long/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback") return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded") return list("shrink" = 0.6,"sx" = 6,"sy" = -2,"nx" = -4,"ny" = 2,"wx" = -8,"wy" = -1,"ex" = 8,"ey" = 3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = -200,"wturn" = -160,"eturn" = -25,"nflip" = 8,"sflip" = 8,"wflip" = 0,"eflip" = 0)
			if("onbelt") return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/sword/long/judgement
	force = 30
	force_wielded = 35
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "judgement"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "judgement"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	name = "judgement"
	desc = "A sword with a silver grip, a topaz gem hilt and a steel blade, what more could a noble ask for."
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_LARGE
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	bigboy = 1
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	associated_skill = /datum/skill/combat/swords
	throwforce = 15
	thrown_bclass = BCLASS_CUT
	dropshrink = 0.75
	smeltresult = /obj/item/ingot/steel
	sellprice = 363
	static_price = TRUE

/obj/item/rogueweapon/sword/long/judgement/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback") return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded") return list("shrink" = 0.4,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt") return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/long/judgement/ascendant //meant to be insanely OP; solo antag wep
	force = 30
	force_wielded = 35
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "crucified"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "judgement"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	name = "Psydonia Redentor"
	desc = "...for the LORD is my tower, and HE gives me the power to tear down the works of the enemy..."
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_LARGE
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	bigboy = 1
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	associated_skill = /datum/skill/combat/swords
	throwforce = 15
	thrown_bclass = BCLASS_CUT
	dropshrink = 0.75
	smeltresult = /obj/item/ingot/steel
	sellprice = 999
	static_price = TRUE
	max_integrity = 9999


/obj/item/rogueweapon/sword/long/vlord
	force = 28
	force_wielded = 30
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "vlord"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "vlord"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	name = "crimson fang"
	desc = "A strange long sword with a green metal composition."
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_LARGE
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	bigboy = 1
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	associated_skill = /datum/skill/combat/swords
	max_integrity = 9999
	throwforce = 15
	thrown_bclass = BCLASS_CUT
	dropshrink = 0.75
	smeltresult = /obj/item/ingot/steel
	sellprice = 363
	static_price = TRUE

/obj/item/rogueweapon/sword/long/vlord/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback") return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded") return list("shrink" = 0.4,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt") return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/long/rider
	force = 23
	force_wielded = 24
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "tabi"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "tabi"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	name = "shamshir"
	desc = "A one-handed sword with elegant curves and deadly sharpness."
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_LARGE
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	bigboy = 1
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	associated_skill = /datum/skill/combat/swords
	throwforce = 15
	thrown_bclass = BCLASS_CUT
	dropshrink = 0.75
	smeltresult = /obj/item/ingot/steel

/obj/item/rogueweapon/sword/long/rider/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/long/marlin
	force = 23
	force_wielded = 24
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "marlin"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "marlin"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	name = "shalal saber"
	desc = "Lightweight, slender and curved."
	parrysound = list('sound/combat/parry/bladed/bladedthin (1).ogg', 'sound/combat/parry/bladed/bladedthin (2).ogg', 'sound/combat/parry/bladed/bladedthin (3).ogg')
	swingsound = BLADEWOOSH_SMALL
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	bigboy = 0
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	associated_skill = /datum/skill/combat/swords
	throwforce = 15
	thrown_bclass = BCLASS_CUT
	dropshrink = 0.75
	minstr = 6
	sellprice = 42
	wdefense = 5
	smeltresult = /obj/item/ingot/steel

/obj/item/rogueweapon/sword/long/marlin/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/long/exe
	possible_item_intents = list(/datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/axe/chop)
	icon_state = "exe"
	name = "execution sword"
	desc = ""
	minstr = 10

/obj/item/rogueweapon/sword/long/exe/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 3,"nx" = -1,"ny" = 2,"wx" = 3,"wy" = 4,"ex" = -1,"ey" = 5,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 20,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/rogueweapon/sword/long/exe/cloth
	icon_state = "terminusest"
	name = "Terminus Est"

/obj/item/rogueweapon/sword/long/exe/cloth/rmb_self(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(user, "clothwipe", 100, TRUE)
	SEND_SIGNAL(src, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_STRONG)
	user.visible_message(span_warning("[user] wipes [src] down with its cloth."),span_notice("I wipe [src] down with its cloth."))
	return

/obj/item/rogueweapon/sword/iron
	name = "sword"
	desc = "A simple iron sword, the most classical war weapon."
	icon_state = "isword"
	minstr = 6
	smeltresult = /obj/item/ingot/iron
	max_integrity = 100
	sellprice = 10

/obj/item/rogueweapon/sword/iron/short
	name = "short sword"
	desc = "An archaic iron sword."
	icon_state = "iswordshort"
	possible_item_intents = list(/datum/intent/sword/cut/short, /datum/intent/sword/thrust/short)
	gripped_intents = null
	minstr = 4
	wdefense = 3

/obj/item/rogueweapon/sword/iron/short/chipped
	force = 19
	desc = "An ancient-looking iron sword."
	icon_state = "iswordshort_d"
	max_integrity = 75

/datum/intent/sword/cut/short
	clickcd = 10
	damfactor = 0.9

/datum/intent/sword/thrust/short
	clickcd = 10
	damfactor = 1.1

/obj/item/rogueweapon/sword/iron/messer
	name = "iron messer"
	desc = "A single edged blade to slice and chop with."
	icon_state = "imesser"
	possible_item_intents = list(/datum/intent/sword/cut/sabre, /datum/intent/sword/thrust, /datum/intent/axe/chop)
	gripped_intents = null
	minstr = 4
	wdefense = 2

/obj/item/rogueweapon/sword/sabre
	name = "sabre"
	desc = "A swift saber. Parries realiantly and strikes swiftly"
	icon_state = "saber"
	possible_item_intents = list(/datum/intent/sword/cut/sabre, /datum/intent/sword/thrust)
	gripped_intents = null
	parrysound = list('sound/combat/parry/bladed/bladedthin (1).ogg', 'sound/combat/parry/bladed/bladedthin (2).ogg', 'sound/combat/parry/bladed/bladedthin (3).ogg')
	swingsound = BLADEWOOSH_SMALL
	minstr = 5
	wdefense = 9
	wbalance = 1

/obj/item/rogueweapon/sword/sabre/dec
	icon_state = "decsaber"
	sellprice = 140

/obj/item/rogueweapon/sword/rapier
	name = "rapier"
	desc = "A duelist's weapon derived from western battlefield instruments, it features a tapered \
	blade with a specialized stabbing tip."
	icon = 'icons/roguetown/weapons/64.dmi'
	icon_state = "rapier"
	bigboy = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	dropshrink = 0.75
	possible_item_intents = list(/datum/intent/sword/thrust/rapier, /datum/intent/sword/cut/rapier)
	gripped_intents = null
	parrysound = list(
		'sound/combat/parry/bladed/bladedthin (1).ogg',
		'sound/combat/parry/bladed/bladedthin (2).ogg',
		'sound/combat/parry/bladed/bladedthin (3).ogg',
		)
	swingsound = BLADEWOOSH_SMALL
	minstr = 6
	wdefense = 6
	wbalance = 1

/obj/item/rogueweapon/sword/rapier/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list(
				"shrink" = 0.5,
				"sx" = -14,
				"sy" = -8,
				"nx" = 15,
				"ny" = -7,
				"wx" = -10,
				"wy" = -5,
				"ex" = 7,
				"ey" = -6,
				"northabove" = 0,
				"southabove" = 1,
				"eastabove" = 1,
				"westabove" = 0,
				"nturn" = -13,
				"sturn" = 110,
				"wturn" = -60,
				"eturn" = -30,
				"nflip" = 1,
				"sflip" = 1,
				"wflip" = 8,
				"eflip" = 1,
				)
			if("onback") return list(
				"shrink" = 0.5,
				"sx" = -1,
				"sy" = 2,
				"nx" = 0,
				"ny" = 2,
				"wx" = 2,
				"wy" = 1,
				"ex" = 0,
				"ey" = 1,
				"nturn" = 0,
				"sturn" = 0,
				"wturn" = 70,
				"eturn" = 15,
				"nflip" = 1,
				"sflip" = 1,
				"wflip" = 1,
				"eflip" = 1,
				"northabove" = 1,
				"southabove" = 0,
				"eastabove" = 0,
				"westabove" = 0,
				)
			if("onbelt") return list(
				"shrink" = 0.4,
				"sx" = -4,
				"sy" = -6,
				"nx" = 5,
				"ny" = -6,
				"wx" = 0,
				"wy" = -6,
				"ex" = -1,
				"ey" = -6,
				"nturn" = 100,
				"sturn" = 156,
				"wturn" = 90,
				"eturn" = 180,
				"nflip" = 0,
				"sflip" = 0,
				"wflip" = 0,
				"eflip" = 0,
				"northabove" = 0,
				"southabove" = 1,
				"eastabove" = 1,
				"westabove" = 0,
				)

/datum/intent/sword/cut/rapier
	clickcd = 10
	damfactor = 0.75

/datum/intent/sword/thrust/rapier
	clickcd = 8
	damfactor = 0.9

/obj/item/rogueweapon/sword/rapier/dec
	icon_state = "decrapier"
	desc = "A fine duelist's instrument with a tapered thrusting blade. Its hilt is gilt in gold and inlaid, \
	and its blade bears twin inscriptions on either side. One reads, 'CAST IN THE NAME OF GODS' while the \
	obverse reads, 'YE NOT GUILTY'."
	sellprice = 140

/obj/item/rogueweapon/sword/rapier/lord
	name = "sword of the Mad Duke"
	desc = "A royal heirloom whose spiraling basket hilt is inlaid with fine cut gems. It bears the burnish of \
	time, where once sharply defined features have been worn down by so many hands. An old rumor ties this implement \
	to the siege that smashed the Mad Duke's keep to rubble, and burnt the Duke himself to cinders."
	icon_state = "lordrap"
	sellprice = 300
	max_integrity = 300
	max_blade_int = 300
	wdefense = 7

/obj/item/rogueweapon/sword/cutlass
	name = "cutlass"
	desc = "Used by pirates and deckhands."
	icon_state = "cutlass"
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust)
	gripped_intents = null
	wdefense = 6

/obj/item/rogueweapon/sword/gladius
	force = 22
	name = "gladius"
	desc = "A bronze short sword with a slightly wider end, and no guard. Compliments a shield."
	icon_state = "gladius"
	gripped_intents = null
	smeltresult = /obj/item/ingot/bronze
	smelt_bar_num = 2
	max_blade_int = 100
	max_integrity = 200
	dropshrink = 0.80
	wdefense = 2

/obj/item/rogueweapon/sword/sabre/elf
	force = 23
	name = "elvish saber"
	desc = "This finely crafted saber is of elven design."
	icon_state = "esaber"
	item_state = "esaber"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	last_used = 0
	is_silver = TRUE
	smeltresult = /obj/item/ingot/silver
	smelt_bar_num = 2

/obj/item/rogueweapon/sword/silver
	force = 22
	name = "silver sword"
	desc = "A sword forged of pure silver. The guard is fashioned into a cross."
	icon_state = "silversword"
	is_silver = TRUE
	smeltresult = /obj/item/ingot/silver
	smelt_bar_num = 2
	max_blade_int = 150
	max_integrity = 200

/obj/item/rogueweapon/sword/long/blackflamb
	force = 23
	force_wielded = 26
	icon_state = "blackflamb"
	name = "blacksteel flamberge"
	desc = "A strange sword with a winding blade forged of blacksteel and a rontz pommel."
	smeltresult = /obj/item/ingot/blacksteel
	max_integrity = 200

/obj/item/rogueweapon/sword/long/blackflamb/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list(
				"shrink" = 0.5,
				"sx" = -14,
				"sy" = -8,
				"nx" = 15,
				"ny" = -7,
				"wx" = -10,
				"wy" = -5,
				"ex" = 7,
				"ey" = -6,
				"northabove" = 0,
				"southabove" = 1,
				"eastabove" = 1,
				"westabove" = 0,
				"nturn" = -13,
				"sturn" = 110,
				"wturn" = -60,
				"eturn" = -30,
				"nflip" = 1,
				"sflip" = 1,
				"wflip" = 8,
				"eflip" = 1,
				)
			if("onback") return list(
				"shrink" = 0.5,
				"sx" = -1,
				"sy" = 2,
				"nx" = 0,
				"ny" = 2,
				"wx" = 2,
				"wy" = 1,
				"ex" = 0,
				"ey" = 1,
				"nturn" = 0,
				"sturn" = 0,
				"wturn" = 70,
				"eturn" = 15,
				"nflip" = 1,
				"sflip" = 1,
				"wflip" = 1,
				"eflip" = 1,
				"northabove" = 1,
				"southabove" = 0,
				"eastabove" = 0,
				"westabove" = 0,
				)
			if("wielded") return list(
				"shrink" = 0.6,
				"sx" = 3,
				"sy" = 5,
				"nx" = -3,
				"ny" = 5,
				"wx" = -9,
				"wy" = 4,
				"ex" = 9,
				"ey" = 1,
				"northabove" = 0,
				"southabove" = 1,
				"eastabove" = 1,
				"westabove" = 0,
				"nturn" = 0,
				"sturn" = 0,
				"wturn" = 0,
				"eturn" = 15,
				"nflip" = 8,
				"sflip" = 0,
				"wflip" = 8,
				"eflip" = 0,
				)
			if("onbelt") return list(
				"shrink" = 0.4,
				"sx" = -4,
				"sy" = -6,
				"nx" = 5,
				"ny" = -6,
				"wx" = 0,
				"wy" = -6,
				"ex" = -1,
				"ey" = -6,
				"nturn" = 100,
				"sturn" = 156,
				"wturn" = 90,
				"eturn" = 180,
				"nflip" = 0,
				"sflip" = 0,
				"wflip" = 0,
				"eflip" = 0,
				"northabove" = 0,
				"southabove" = 1,
				"eastabove" = 1,
				"westabove" = 0,
				)

/obj/item/rogueweapon/sword/long/oathkeeper
	name = "Oathkeeper"
	desc = "An ornate golden blade with a ruby embedded in the hilt. Granted to the Knight Commander for their valiant service to the crown."
	sellprice = 140
	force = 26
	force_wielded = 35
	possible_item_intents = list(/datum/intent/sword/cut/sabre, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	icon_state = "kingslayer"
