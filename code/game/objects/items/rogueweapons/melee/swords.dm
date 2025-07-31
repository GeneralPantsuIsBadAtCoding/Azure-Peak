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
	damfactor = 1.1
	item_d_type = "slash"

/datum/intent/sword/cut/militia
	penfactor = 30
	damfactor = 1.2
	chargetime = 0.2

/datum/intent/sword/chop/militia
	penfactor = 50
	chargetime = 0.5
	swingdelay = 0
	damfactor = 1.0

/datum/intent/sword/thrust
	name = "stab"
	icon_state = "instab"
	attack_verb = list("stabs")
	animname = "stab"
	blade_class = BCLASS_STAB
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = 20
	chargetime = 0
	swingdelay = 0
	item_d_type = "stab"

/datum/intent/sword/thrust/krieg
	damfactor = 0.9

/datum/intent/sword/strike
	name = "pommel strike"
	icon_state = "instrike"
	attack_verb = list("bashes", "clubs")
	animname = "strike"
	blade_class = BCLASS_BLUNT
	hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	chargetime = 0
	penfactor = BLUNT_DEFAULT_PENFACTOR
	swingdelay = 0
	damfactor = 1
	item_d_type = "blunt"

/datum/intent/sword/peel
	name = "armor peel"
	icon_state = "inpeel"
	attack_verb = list("peels", "tears")
	animname = "cut"
	blade_class = BCLASS_PEEL
	hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	chargetime = 0
	penfactor = 200
	swingdelay = 0
	damfactor = 0.05
	item_d_type = "slash"
	peel_divisor = 4

/datum/intent/sword/peel/big
	name = "big sword armor peel"
	reach = 2

/datum/intent/sword/chop
	name = "chop"
	icon_state = "inchop"
	attack_verb = list("chops", "hacks")
	animname = "chop"
	blade_class = BCLASS_CHOP
	hitsound = list('sound/combat/hits/bladed/genchop (1).ogg', 'sound/combat/hits/bladed/genchop (2).ogg', 'sound/combat/hits/bladed/genchop (3).ogg')
	penfactor = 30
	swingdelay = 8
	damfactor = 1.0
	item_d_type = "slash"

/datum/intent/sword/cut/falx
	penfactor = 20

/datum/intent/sword/chop/falx
	penfactor = 40

/datum/intent/sword/cut/krieg
	clickcd = 10

/datum/intent/sword/thrust/krieg
	damfactor = 0.8

/datum/intent/rend/krieg
	intent_intdamage_factor = 0.2

//sword objs ฅ^•ﻌ•^ฅ

/obj/item/rogueweapon/sword
	name = "arming sword"
	desc = "A long steel blade attached to a hilt, separated by a crossguard. The arming sword has been Psydonia's implement of war by excellence for generations."
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	force = 22
	force_wielded = 25
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/peel)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/peel)
	armor = ARMOR_SWORD
	damage_deflection = 14
	icon_state = "sword1"
	sheathe_icon = "sword1"
	icon = 'icons/roguetown/weapons/32.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/rogue_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/rogue_righthand.dmi'
	parrysound = list(
		'sound/combat/parry/bladed/bladedmedium (1).ogg',
		'sound/combat/parry/bladed/bladedmedium (2).ogg',
		'sound/combat/parry/bladed/bladedmedium (3).ogg',
		)
	swingsound = BLADEWOOSH_MED
	associated_skill = /datum/skill/combat/swords
	max_blade_int = 100
	max_integrity = 150
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_BULKY
	pickup_sound = 'sound/foley/equip/swordlarge1.ogg'
	holster_sound = 'sound/items/wood_sharpen.ogg'
	flags_1 = CONDUCT_1
	throwforce = 10
	thrown_bclass = BCLASS_CUT
	blade_dulling = DULLING_SHAFT_METAL
	//dropshrink = 0.75
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/steel
	minstr = 7
	sellprice = 30
	wdefense = 4
	grid_width = 32
	grid_height = 64

	equip_delay_self = 1.5 SECONDS
	unequip_delay_self = 1.5 SECONDS
	inv_storage_delay = 1.5 SECONDS
	edelay_type = 1

/obj/item/rogueweapon/sword/Initialize()
	. = ..()
	var/rand_icon = "sword[rand(1,3)]"
	if(icon_state == "sword1")
		icon_state = "[rand_icon]"
		sheathe_icon = "[rand_icon]"

/obj/item/rogueweapon/sword/falchion
	name = "falchion"
	desc = "A single-edged sword that is similar to a messer in appearance, its origins trace back to Otava. An implement of commoners and knights alike. It's good for cutting and thrusting."
	force = 20
	possible_item_intents = list(/datum/intent/sword/cut/short, /datum/intent/sword/thrust/short, /datum/intent/sword/peel)
	icon_state = "falchion"
	gripped_intents = null
	minstr = 4
	wdefense = 6
	sheathe_icon = "falchion"

/obj/item/rogueweapon/sword/falx
	name = "falx"
	desc = "An unusual type of curved sword that evolved from the farmer's sickle. It has an inwards edge, making it useful for cutting and chopping."
	force = 22
	possible_item_intents = list(/datum/intent/sword/cut/falx,  /datum/intent/sword/chop/falx, /datum/intent/sword/strike, /datum/intent/sword/peel)
	icon_state = "falx"
	max_blade_int = 100
	max_integrity = 125
	gripped_intents = null
	minstr = 4
	wdefense = 6

/obj/item/rogueweapon/sword/decorated
	name = "decorated arming sword"
	desc = "A valuable ornate arming sword made for the purpose of ceremonial fashion, with a fine leather grip and a carefully engraved golden crossguard."
	icon_state = "decsword1"
	sellprice = 140



/obj/item/rogueweapon/sword/decorated/Initialize()
	. = ..()
	var/rand_icon = "decsword[rand(1,3)]"
	if(icon_state == "decsword1")
		icon_state = "[rand_icon]"
		sheathe_icon = "[rand_icon]"

/obj/item/rogueweapon/sword/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.7,"sx" = 5,"sy" = -4,"nx" = -6,"ny" = 2,"wx" = -8,"wy" = 1,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -30,"sturn" = 45,"wturn" = -30,"eturn" = 30,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/stone
	force = 17 //Weaker than a short sword
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/chop)
	gripped_intents = null
	name = "stone sword"
	desc = "A crude mockery of what seems to be a sword, really just a long knapped stone tied to a carved wooden shaft."
	icon_state = "stone_sword"
	max_blade_int = 70
	max_integrity = 70
	anvilrepair = /datum/skill/craft/crafting
	smeltresult = null
	minstr = 4
	wdefense = 4
	sellprice = 10

/obj/item/rogueweapon/sword/short
	name = "steel shortsword"
	desc = "The arming sword's shorter and much older brother. Despite being centuries older than the swords of todae, it remains in use as a cheap sidearm for shieldbearers and archers."
	force = 19
	possible_item_intents = list(/datum/intent/sword/cut/short, /datum/intent/sword/thrust/short, /datum/intent/sword/peel)
	icon_state = "swordshort"
	sheathe_icon = "swordshort"
	gripped_intents = null
	minstr = 4
	wdefense = 4
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_NORMAL
	grid_width = 32
	grid_height = 96

/obj/item/rogueweapon/sword/short/pashortsword
	name = "ancient shortsword"
	desc = "A sword made of ancient alloys. Aeon's grasp has been lifted from its form."
	icon_state = "ashortsword"
	sheathe_icon = "ashortsword"
	smeltresult = /obj/item/ingot/aaslag


/obj/item/rogueweapon/sword/long
	name = "longsword"
	desc = "A lethal and perfectly balanced weapon. The longsword is the protagonist of endless tales and myths all across Psydonia, seen in the hands of noblemen and an ever-decreasing quantity of master duelists.\
		 It has great cultural significance in the empires of Grenzelhoft and Etrusca, where legendary swordsmen have created and perfected many fighting techniques of todae."
	force = 25
	force_wielded = 30
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/peel)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/peel, /datum/intent/sword/chop)
	alt_intents = list(/datum/intent/effect/daze, /datum/intent/sword/strike, /datum/intent/sword/bash)
	icon_state = "longsword"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "longsword"
	sheathe_icon = "longsword"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
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
			if("gen") return list("shrink" = 0.5, "sx" = -14, "sy" = -8, "nx" = 15, "ny" = -7, "wx" = -10, "wy" = -5, "ex" = 7, "ey" = -6, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 0, "nturn" = -13, "sturn" = 110, "wturn" = -60, "eturn" = -30, "nflip" = 1, "sflip" = 1, "wflip" = 8, "eflip" = 1)
			if("wielded") return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)
			if("onback") return list("shrink" = 0.5, "sx" = -1, "sy" = 2, "nx" = 0, "ny" = 2, "wx" = 2, "wy" = 1, "ex" = 0, "ey" = 1, "nturn" = 0, "sturn" = 0, "wturn" = 70, "eturn" = 15, "nflip" = 1, "sflip" = 1, "wflip" = 1, "eflip" = 1, "northabove" = 1, "southabove" = 0, "eastabove" = 0, "westabove" = 0)
			if("onbelt") return list("shrink" = 0.4, "sx" = -4, "sy" = -6, "nx" = 5, "ny" = -6, "wx" = 0, "wy" = -6, "ex" = -1, "ey" = -6, "nturn" = 100, "sturn" = 156, "wturn" = 90, "eturn" = 180, "nflip" = 0, "sflip" = 0, "wflip" = 0, "eflip" = 0, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 0)
			if("altgrip") return list("shrink" = 0.6,"sx" = 2,"sy" = 3,"nx" = -7,"ny" = 1,"wx" = -8,"wy" = 0,"ex" = 8,"ey" = -1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -135,"sturn" = -35,"wturn" = 45,"eturn" = 145,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)

/obj/item/rogueweapon/sword/long/etruscan
	name = "basket-hilted longsword"
	desc = "An uncommon and elaborate type of longsword with a compound hilt like those seen on rapiers and smallswords. It has a marked unsharpened section for safe unarmored half-swording, and it's made of Calorian steel."
	icon_state = "elongsword"

/obj/item/rogueweapon/sword/long/malumflamm
	name = "forgefiend flamberge"
	desc = "This sword's creation took a riddle in its own making. A great sacrifice was made for a blade of perfect quality."
	icon_state = "malumflamberge"
	max_integrity = 200

/obj/item/rogueweapon/sword/long/zizo
	name = "darksteel longsword"
	desc = "A wicked, unconventional, and otherwordly blade that was created by no swordsmith - a manifestation of hate for the state of this world that follows no design principles but spite and anger."
	icon_state = "zizosword"
	sheathe_icon = "zizosword"
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/peel, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/peel, /datum/intent/sword/chop)
	alt_intents = list(/datum/intent/effect/daze, /datum/intent/sword/strike, /datum/intent/sword/bash)
	force = 30
	force_wielded = 35
	blade_dulling = DULLING_SHAFT_GRAND
	equip_delay_self = 0
	unequip_delay_self = 0

/obj/item/rogueweapon/sword/long/zizo/pickup(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_CABAL))
		to_chat(user, "<font color='purple'>UNWORTHY HANDS TOUCHING THIS SWORD, CEASE OR BE PUNISHED!</font>")
		user.adjust_fire_stacks(5)
		user.IgniteMob()
		user.Stun(40)
	..()


/obj/item/rogueweapon/sword/long/heirloom
	name = "old longsword"
	desc = "A very old steel longsword that has since become a showpiece. Perhaps a family relic, or the weapon of a dead knight."
	force = 20
	force_wielded = 32
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "heirloom"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "longsword"
	sheathe_icon = "heirloom"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
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

/obj/item/rogueweapon/sword/long/heirloom/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list("shrink" = 0.5, "sx" = -14, "sy" = -8, "nx" = 15, "ny" = -7, "wx" = -10, "wy" = -5, "ex" = 7, "ey" = -6, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 0, "nturn" = -13, "sturn" = 110, "wturn" = -60, "eturn" = -30, "nflip" = 1, "sflip" = 1, "wflip" = 8, "eflip" = 1)
			if("wielded") return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)
			if("onback") return list("shrink" = 0.5, "sx" = -1, "sy" = 2, "nx" = 0, "ny" = 2, "wx" = 2, "wy" = 1, "ex" = 0, "ey" = 1, "nturn" = 0, "sturn" = 0, "wturn" = 70, "eturn" = 15, "nflip" = 1, "sflip" = 1, "wflip" = 1, "eflip" = 1, "northabove" = 1, "southabove" = 0, "eastabove" = 0, "westabove" = 0)
			if("onbelt") return list("shrink" = 0.3, "sx" = -4, "sy" = -6, "nx" = 5, "ny" = -6, "wx" = 0, "wy" = -6, "ex" = -1, "ey" = -6, "nturn" = 100, "sturn" = 156, "wturn" = 90, "eturn" = 180, "nflip" = 0, "sflip" = 0, "wflip" = 0, "eflip" = 0, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 0)

/obj/item/rogueweapon/sword/long/judgement
	name = "\"Judgement\""
	desc = "An intricately forged longsword, it's blade is made from Aavnr's finest Vyšvou steel - held from an ornate carved ivory grip from the region's \"Mamük\" megafauna. A sight that's truly unique."
	icon_state = "judgement"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "judgement"
	sheathe_icon = "judgement"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	swingsound = BLADEWOOSH_LARGE
	wbalance = WBALANCE_HEAVY
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
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.4,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/long/judgement/ascendant //meant to be insanely OP; solo antag wep
	name = "\"The Redentor\""
	desc = "An intricately forged sword of great power. And the preacher said: \"For the Lord is my tower, and He gives me the power to tear down the works of the enemy.\""
	force = 50
	force_wielded = 70
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "crucified"
	sheathe_icon = "crucified"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "judgement"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
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
	name = "\"Ichor Fang\""
	desc = "An unholy longsword made of odd steel. A green crystalline mass covers the blade and pommel, its edges and serrations tougher and sharper than anything forged by a master swordsmith."
	force = 40
	force_wielded = 55
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/peel, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	alt_intents = list(/datum/intent/effect/daze, /datum/intent/sword/strike, /datum/intent/sword/bash)
	icon_state = "vlord"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "vlord"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
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
	blade_dulling = DULLING_SHAFT_GRAND
	dropshrink = 0.75
	smeltresult = /obj/item/ingot/steel
	sellprice = 363
	static_price = TRUE
	equip_delay_self = 0
	unequip_delay_self = 0

/obj/item/rogueweapon/sword/long/vlord/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.4,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/sabre/shamshir
	name = "shamshir"
	desc = "A curved one-handed longsword. This type of scimitar is the quintessential armament of Ranesheni horsemen, its name derived from Sama'glos for \"Tiger's claw\"."
	force = 24
	wdefense = 6	//Has chop mode, so slightly less defense. Slightly.
	wbalance = WBALANCE_SWIFT
	icon_state = "tabi"
	icon = 'icons/roguetown/weapons/64.dmi'
	possible_item_intents = list(/datum/intent/sword/cut/sabre, /datum/intent/sword/thrust, /datum/intent/sword/peel, /datum/intent/sword/chop)
	alt_intents = list(/datum/intent/sword/cut/sabre, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	gripped_intents = null
	parrysound = list('sound/combat/parry/bladed/bladedthin (1).ogg', 'sound/combat/parry/bladed/bladedthin (2).ogg', 'sound/combat/parry/bladed/bladedthin (3).ogg')
	swingsound = BLADEWOOSH_SMALL
	bigboy = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	dropshrink = 0.75
	smeltresult = /obj/item/ingot/steel

/obj/item/rogueweapon/sword/sabre/shamshir/getonmobprop(tag)
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
	name = "shalal saber"
	desc = "A large yet surprisingly agile curved blade meant to be wielded in two hands. It has a similar composition to northwestern Psydonian longswords, but it's notably lighter."
	force = 26
	force_wielded = 31
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/strike, /datum/intent/sword/peel)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/strike, /datum/intent/sword/chop, /datum/intent/sword/peel)
	icon_state = "marlin"
	icon = 'icons/roguetown/weapons/64.dmi'
	item_state = "marlin"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
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

//Slightly more expensive than a longsword by 1 iron, so gets to be slightly better.
/obj/item/rogueweapon/sword/long/exe
	name = "executioners sword"
	desc = "A longsword with extra heft to its blade, reinforced."
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/peel, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust/exe, /datum/intent/rend, /datum/intent/axe/chop)
	icon_state = "exe"
	minstr = 12
	slot_flags = ITEM_SLOT_BACK //Too big for hip

/datum/intent/sword/thrust/exe
	swingdelay = 4	//Slight delay to stab; big and heavy.
	penfactor = BLUNT_DEFAULT_PENFACTOR //Flat tip? I don't know, man. This intent is won't penetrate anything but it damages armor more.
	intent_intdamage_factor = 1.3 //This is basically like getting hit by a mace.

/obj/item/rogueweapon/sword/long/exe/astrata
	name = "\"Solar Judge\""
	desc = "An incredibly unusual executioner's sword clad in gold and brass. Two separate blades protude outwards and join near its intricately decorated crossguard. This weapon calls for order."
	icon_state = "astratasword"
	max_integrity = 200
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/peel, /datum/intent/axe/chop)

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
	name = "\"Terminus Est\""
	desc = "An ancient and damaged executioner's sword, decorated with a bronze pommel and crossguard. A bloody rag winds around the ricasso, ever-present to keep the blade clean."

/obj/item/rogueweapon/sword/long/exe/cloth/rmb_self(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(user, "clothwipe", 100, TRUE)
	SEND_SIGNAL(src, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_STRONG)
	user.visible_message(span_warning("[user] wipes [src] down with its cloth."),span_notice("I wipe [src] down with its cloth."))
	return

/obj/item/rogueweapon/sword/long/oldpsysword
	name = "old psydonian longsword"
	desc = "A finely made longsword, plated in a worn-down veneer of grubby silver. It's long seen better daes."
	icon_state = "psysword"
	sheathe_icon = "psysword"

/obj/item/rogueweapon/sword/long/psysword
	name = "psydonian longsword"
	desc = "A finely made longsword, plated in a ceremonial veneer of ornate silver - made for felling men and monsters alike.\
		\"Psydon will deliver those who were mindful of Him to their place of ultimate triumph. No evil will touch them, nor will they grieve.\""
	icon_state = "psysword"
	sheathe_icon = "psysword"

/obj/item/rogueweapon/sword/long/psysword/ComponentInitialize()
	. = ..()							//+3 force, +100 blade int, +50 int, +1 def, make silver
	AddComponent(/datum/component/psyblessed, FALSE, 3, 100, 50, 1, TRUE)


/obj/item/rogueweapon/sword/iron
	name = "iron arming sword"
	desc = "A long iron blade attached to a hilt, separated by a crossguard. The arming sword has been Psydonia's implement of war by excellence for generations, this one is cheaper than its steel brother."
	icon_state = "isword"
	minstr = 6
	smeltresult = /obj/item/ingot/iron
	max_integrity = 100
	sellprice = 10
	sheathe_icon = "isword"

/obj/item/rogueweapon/sword/iron/short
	name = "iron shortsword"
	desc = "The arming sword's shorter and much older brother. Despite being centuries older than the swords of todae, it remains in use as a cheap sidearm for shieldbearers and archers. This iron variant predates them all."
	icon_state = "iswordshort"
	sheathe_icon = "iswordshort"
	possible_item_intents = list(/datum/intent/sword/cut/short, /datum/intent/sword/thrust/short, /datum/intent/sword/peel)
	gripped_intents = null
	minstr = 4
	wdefense = 3
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_NORMAL
	grid_width = 32
	grid_height = 96

/obj/item/rogueweapon/sword/iron/short/ashort
	name = "decrepit short sword"
	desc = "A decrepit old short sword. Aeon's grasp has withered its form."
	icon_state = "ashortsword"
	sheathe_icon = "ashortsword"
	max_integrity = 75
	force = 18
	smeltresult = /obj/item/ingot/aalloy
	blade_dulling = DULLING_SHAFT_CONJURED

/obj/item/rogueweapon/sword/iron/short/gladius
	name = "gladius"
	desc = "A bronze short sword with a slightly wider end, and no guard. Best used together with a shield, thrusted directly into your enemy's guts."
	icon_state = "gladius"
	sheathe_icon = "gladius"
	max_integrity = 200
	smeltresult = /obj/item/ingot/bronze
	wdefense = 3

/obj/item/rogueweapon/sword/iron/short/gladius/agladius
	name = "decrepit gladius"
	desc = "A decrepit old gladius. Aeon's grasp is upon its form."
	force = 18
	max_integrity = 150
	icon_state = "agladius"
	smeltresult = /obj/item/ingot/aalloy
	blade_dulling = DULLING_SHAFT_CONJURED

/obj/item/rogueweapon/sword/iron/short/gladius/pagladius
	name = "ancient gladius"
	desc = "A gladius made of ancient alloys. Aeon's grasp lifted from its form."
	icon_state = "agladius"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/rogueweapon/sword/iron/short/chipped
	name = "chipped iron shortsword"
	desc = "A damaged and ancient iron shortsword. It looks duller, and seems less effective."
	force = 17
	icon_state = "iswordshort_d"
	sheathe_icon = "iswordshort_d"
	max_integrity = 75
	wlength = WLENGTH_SHORT

/datum/intent/sword/cut/short
	clickcd = 9
	damfactor = 1

/datum/intent/sword/thrust/short
	clickcd = 8
	damfactor = 1.1
	penfactor = 30

/obj/item/rogueweapon/sword/iron/messer
	name = "hunting sword"
	desc = "A basic single-edge sword that is usually used to finish off hunted game. It excels at slicing and chopping, and it's made of iron. \
	It's a fairly reliable and affordable self-defense weapon."
	icon_state = "imesser"
	possible_item_intents = list(/datum/intent/sword/cut/sabre, /datum/intent/sword/thrust, /datum/intent/axe/chop, /datum/intent/sword/peel)
	gripped_intents = null
	minstr = 4
	wdefense = 2

/obj/item/rogueweapon/sword/iron/messer/virtue
	name = "dueling messer"
	desc = "A basic single-edge iron hunting sword that has been modified for the express purpose of dueling, with an added guard and a leaner grip for comfort and speed."
	icon_state = "dmesser"
	swingsound = BLADEWOOSH_SMALL
	wdefense = 3
	wbalance = WBALANCE_SWIFT

// This typepath is so fucked bruh but I am not repeating code and not dropping a massive merge conflict for now
/obj/item/rogueweapon/sword/iron/messer/copper
	name = "copper messer"
	desc = "A copper hunting sword. Less durable than its iron counterpart."
	force = 20 // Slightly worse
	icon_state = "cmesser"
	max_integrity = 150
	minstr = 4
	wdefense = 2
	smeltresult = /obj/item/ingot/copper

/obj/item/rogueweapon/sword/short/messer
	name = "messer"
	desc = "A \"Großesmesser\" of disputed Grenzel origin, meaning greatknife. It's a basic single-edge sword for civilian and military use. It excels at slicing and chopping, and it's made of steel. \
	It can fill the exact function of a hunting sword, this one is more durable."
	icon_state = "smesser"
	force = 22	//Same damage as the iron messer
	possible_item_intents = list(/datum/intent/sword/cut/sabre, /datum/intent/sword/thrust, /datum/intent/axe/chop, /datum/intent/sword/peel)
	gripped_intents = null
	minstr = 5
	wdefense = 4

/obj/item/rogueweapon/sword/iron/saber
	name = "iron saber"
	desc = "A Naledian sword mass produced for line infantry. Its fittings are simple, munitions grade, but the construction is sturdy and the blade as threatening \
	as any."
	icon_state = "isaber"
	possible_item_intents = list(/datum/intent/sword/cut/sabre, /datum/intent/sword/thrust/sabre, /datum/intent/sword/peel, /datum/intent/sword/strike)
	gripped_intents = null
	parrysound = list('sound/combat/parry/bladed/bladedthin (1).ogg', 'sound/combat/parry/bladed/bladedthin (2).ogg', 'sound/combat/parry/bladed/bladedthin (3).ogg')
	swingsound = BLADEWOOSH_SMALL
	wbalance = WBALANCE_SWIFT

/obj/item/rogueweapon/sword/sabre
	name = "sabre"
	desc = "A very popular backsword made for cavalrymen that originated in Naledi and spread its influence further north, reaching Aavnr as a \"Szablya\" and notoriously cementing itself as the preferred weapon of the Potentate's Hussars."
	icon_state = "saber"
	sheathe_icon = "saber"
	possible_item_intents = list(/datum/intent/sword/cut/sabre, /datum/intent/sword/thrust/sabre, /datum/intent/sword/peel, /datum/intent/sword/strike)
	gripped_intents = null
	parrysound = list('sound/combat/parry/bladed/bladedthin (1).ogg', 'sound/combat/parry/bladed/bladedthin (2).ogg', 'sound/combat/parry/bladed/bladedthin (3).ogg')
	swingsound = BLADEWOOSH_SMALL
	minstr = 5
	wdefense = 7		//Same as rapier
	wbalance = WBALANCE_SWIFT

/datum/intent/sword/cut/sabre
	clickcd = 8		//Faster than sword by 4
	damfactor = 1.25	//Better than rapier (Base is 1.1 for swords)
	penfactor = 10		//Very slight buff to pen on cut mode. Still weaker then sword-chop mode.

/datum/intent/sword/thrust/sabre
	clickcd = 9			//Fast but still not as fast as rapier n' shittier.
	damfactor = 0.9		//10% worse	than base

/obj/item/rogueweapon/sword/sabre/dec
	icon_state = "decsaber"
	sheathe_icon = "decsaber"
	sellprice = 140

//Unique church sword - slightly better than regular sabre due to falx chop.
/obj/item/rogueweapon/sword/sabre/nockhopesh
	name = "moonlight khopesh"
	desc = "A sickle-shaped sword of Naledi origin that owes its design to a type of battle axe its ancient settlers once used - it represents a symbol of power and conquest. This one in particular is made of blued steel."
	icon_state = "nockhopesh"
	force = 25	//Base is 22
	possible_item_intents = list(/datum/intent/sword/cut/sabre, /datum/intent/sword/thrust, /datum/intent/sword/chop/falx, /datum/intent/sword/peel)
	max_integrity = 200

/obj/item/rogueweapon/sword/sabre/alloy
	name = "decrepit khopesh"
	desc = "A decrepit old khopesh. Aeon's grasp is upon its form."
	smeltresult = /obj/item/ingot/aalloy
	force = 18
	max_integrity = 115
	icon_state = "akhopesh"
	blade_dulling = DULLING_SHAFT_CONJURED

/obj/item/rogueweapon/sword/sabre/palloy
	name = "ancient khopesh"
	desc = "A ancient alloy khopesh. Aeon's grasp has been lifted from its form."
	smeltresult = /obj/item/ingot/aaslag
	icon_state = "akhopesh"


/obj/item/rogueweapon/sword/sabre/elf
	name = "elvish saber"
	desc = "This finely crafted saber is of elven design."
	icon_state = "esaber"
	item_state = "esaber"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 25	//Base is 22
	last_used = 0
	is_silver = TRUE
	smeltresult = /obj/item/ingot/silver
	smelt_bar_num = 2

/obj/item/rogueweapon/sword/rapier
	name = "rapier"
	desc = "A practically brand new sword type with a straight, slender and sharply pointed blade meant to be wielded in one hand. \
		Originating in the islands of Etrusca, its name comes from the term \"spada ropera\" (Literally \"dress sword\") due to its primary function being that of an accessory. \
		A very young type of fighting technique for this weapon is emerging in the island, aptly named \"Destreza\" for dexterity."
	icon = 'icons/roguetown/weapons/64.dmi'
	icon_state = "rapier"
	sheathe_icon = "rapier"
	bigboy = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	dropshrink = 0.75
	possible_item_intents = list(/datum/intent/sword/thrust/rapier, /datum/intent/sword/cut/rapier, /datum/intent/sword/peel)
	gripped_intents = null
	parrysound = list(
		'sound/combat/parry/bladed/bladedthin (1).ogg',
		'sound/combat/parry/bladed/bladedthin (2).ogg',
		'sound/combat/parry/bladed/bladedthin (3).ogg',
		)
	swingsound = BLADEWOOSH_SMALL
	minstr = 6
	wdefense = 7
	wbalance = WBALANCE_SWIFT

/obj/item/rogueweapon/sword/rapier/vaquero
	name = "cup-hilt rapier"
	desc = "A special variant of an Etruscan rapier. The cup hilt of this weapon is both simpler to produce and more protective than the type of traditional design of current rapiers."
	icon = 'icons/roguetown/weapons/64.dmi'
	icon_state = "cup_hilt_rapier"
	wdefense = 8
	force = 25

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
	damfactor = 1.1
	penfactor = 30

/obj/item/rogueweapon/sword/rapier/dec
	name = "decorated rapier"
	desc = "A fine duelist's instrument with a tapered thrusting blade. Its hilt is gilt in gold and inlaid, \
	and its blade bears twin inscriptions on either side. One reads, \"CAST IN THE NAME OF GODS\" while the \
	obverse reads, \"YE NOT GUILTY\"."
	icon_state = "decrapier"
	sheathe_icon = "decrapier"
	sellprice = 140

/obj/item/rogueweapon/sword/rapier/lord
	name = "sword of the Mad Duke"
	desc = "A royal heirloom whose spiraling basket hilt is inlaid with fine cut gems. It bears the burnish of \
	time, where once sharply defined features have been worn down by so many hands. An old rumor ties this implement \
	to the siege that smashed the Mad Duke's keep to rubble, and burnt the Duke himself to cinders."
	icon_state = "lordrap"
	sheathe_icon = "lordrapier"
	sellprice = 300
	max_integrity = 300
	max_blade_int = 300
	wdefense = 7

/obj/item/rogueweapon/sword/rapier/eora
	name = "\"Heartstring\""
	desc = "A specialty-made bilbo hilt rapier made in service to Lady Eora. For the time when soft words can no longer be spoken, and hearts are to be pierced."
	icon = 'icons/roguetown/weapons/32.dmi'
	icon_state = "eorarapier"
	sheathe_icon = "eorarapier"
	grid_width = 32
	grid_height = 64
	dropshrink = 0
	bigboy = FALSE

/obj/item/rogueweapon/sword/cutlass
	name = "cutlass"
	desc = "The mariner's special: A short, broad sabre with a slightly curved blade optimized for slashing."
	icon_state = "cutlass"
	force = 23
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/chop, /datum/intent/sword/peel)
	gripped_intents = null
	wdefense = 6
	wbalance = WBALANCE_SWIFT
	sheathe_icon = "cutlass"


/obj/item/rogueweapon/sword/silver
	force = 24
	name = "silver sword"
	desc = "A sword forged of pure silver, the guard fashioned into a cross - a weapon to ward off creechers of evil."
	icon_state = "silversword"
	sheathe_icon = "silversword"
	is_silver = TRUE
	smeltresult = /obj/item/ingot/silver
	smelt_bar_num = 2
	max_blade_int = 150
	max_integrity = 200

/obj/item/rogueweapon/sword/long/blackflamb
	name = "blacksteel flamberge"
	desc = "An uncommon kind of sword with a characteristically undulating style of blade, made with an equally rare metal. The wave in the blade is considered to contribute a flame-like quality to its appearance, turning it into a menacing sight. \"Flaming swords\" are often the protagonists of Otavan epics and other knights' tales."
	force = 20
	force_wielded = 32
	icon_state = "blackflamb"
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

/obj/item/rogueweapon/sword/long/rhomphaia
	name = "rhomphaia"
	desc = "An ancient sword similar to the falx, with the key difference of its curve being less pronounced - feared for its ability to strike and thrust with precision."
	force = 25
	force_wielded = 30
	possible_item_intents = list(/datum/intent/sword/cut/falx, /datum/intent/sword/strike, /datum/intent/sword/chop/falx, /datum/intent/sword/peel)
	gripped_intents = list(/datum/intent/sword/cut/falx, /datum/intent/sword/strike, /datum/intent/sword/chop/falx, /datum/intent/sword/peel)
	icon_state = "rhomphaia"
	smeltresult = /obj/item/ingot/steel
	max_integrity = 125

/obj/item/rogueweapon/sword/long/rhomphaia/getonmobprop(tag)
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

/obj/item/rogueweapon/sword/long/rhomphaia/copper
	name = "copper rhomphaia"
	desc = "An ancient sword similar to the falx, with the key difference of its curve being less pronounced - feared for its ability to strike and thrust with precision. This one is made of copper, making it weaker."
	icon_state = "crhomphaia"
	force = 22
	force_wielded = 26
	max_integrity = 100
	smeltresult = /obj/item/ingot/copper

/obj/item/rogueweapon/sword/long/oathkeeper
	name = "Oathkeeper"
	desc = "An ornate golden longsword with a ruby embedded in the hilt, given to the Knight Commander for their valiant service to the crown."
	sellprice = 140
	possible_item_intents = list(/datum/intent/sword/cut/sabre, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	icon_state = "kingslayer"
	sheathe_icon = "kingslayer"

/obj/item/rogueweapon/sword/long/oathkeeper/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/sword/long/holysee
	name = "eclipsum sword"
	desc = "A deadly longsword born of Astratan and Nocite hands, this blade was forged with both silver and gold alike. Blessed to hold strength and bring hope, whether it be during the dae or the nite."
	icon_state = "eclipsum"
	sheathe_icon = "eclipsum"
	force = 34
	force_wielded = 50
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/peel, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/peel, /datum/intent/sword/chop)
	is_silver = TRUE
	smeltresult = /obj/item/ingot/silver
	smelt_bar_num = 2
	max_integrity = 999

/obj/item/rogueweapon/sword/long/holysee/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list(
				"shrink" = 0.65,
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
				"shrink" = 0.65,
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

/obj/item/rogueweapon/sword/long/kriegmesser
	name = "kriegsmesser"
	desc = "A large two-handed sword with a single-edged blade, a crossguard and a knife-like hilt. \
	It is meant to be wielded with both hands and is a popular weapon amongst Grenzelhoftian mercenaries."
	icon = 'icons/roguetown/weapons/swords64.dmi'
	icon_state = "kriegmesser"
	possible_item_intents = list(/datum/intent/sword/cut/krieg, /datum/intent/sword/chop/falx, /datum/intent/rend/krieg, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/sword/cut/krieg, /datum/intent/sword/thrust/krieg, /datum/intent/rend/krieg, /datum/intent/sword/strike)
	alt_intents = null // Can't mordhau this
	smeltresult = /obj/item/ingot/steel

/obj/item/rogueweapon/sword/long/dec
	name = "decorated longsword"
	desc = "A valuable ornate longsword made for the purpose of ceremonial fashion, with a fine leather grip and a carefully engraved golden crossguard. \
	Its blade bears twin inscriptions on either side. One reads, \"THY KINGDOM COME\" while the obverse reads, \"THY WILL BE DONE\"."
	icon_state = "declongsword"
	sellprice = 140

// kazengite content

/obj/item/rogueweapon/sword/sabre/mulyeog
	force = 25
	name = "foreign straight blade"
	desc = "A foreign sword used by cut-throats & thugs. There's a red tassel on the hilt."
	sheathe_icon = "mulyeog"
	icon_state = "eastsword1"
	smeltresult = /obj/item/ingot/steel
	wdefense = 3

/obj/item/rogueweapon/sword/sabre/mulyeog/rumahench
	name = "hwang blade"
	desc = "A foreign steel sword with cloud patterns on the groove. An blade of the Ruma clan's insignia along it."
	icon_state = "eastsword2"

/obj/item/rogueweapon/sword/sabre/mulyeog/rumacaptain
	force = 30
	name = "samjeongdo"
	desc = "A gold-stained with cloud patterns on the groove. One of a kind. It is a symbol of status within the Ruma clan."
	icon_state = "eastsword3"
	max_integrity = 180
	wdefense = 4
