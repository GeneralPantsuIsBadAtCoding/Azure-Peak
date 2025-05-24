/obj/item/rogueweapon/flail
	force = 25
	possible_item_intents = list(/datum/intent/flail/strike, /datum/intent/flail/strike/smash)
	name = "flail"
	desc = "This is a swift, iron flail. Strikes hard and far."
	icon_state = "iflail"
	icon = 'icons/roguetown/weapons/32.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.75
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	associated_skill = /datum/skill/combat/whipsflails
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/iron
	parrysound = list('sound/combat/parry/parrygen.ogg')
	swingsound = BLUNTWOOSH_MED
	blade_dulling = DULLING_SHAFT_WOOD
	throwforce = 5
	wdefense = 0
	minstr = 4
	grid_width = 32
	grid_height = 96
	intdamage_factor = 1.1

/datum/intent/flail/strike
	name = "strike"
	blade_class = BCLASS_BLUNT
	attack_verb = list("strikes", "hits")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	chargetime = 0
	penfactor = BLUNT_DEFAULT_PENFACTOR
	icon_state = "instrike"
	item_d_type = "blunt"

/datum/intent/flail/strikerange
	name = "ranged strike"
	blade_class = BCLASS_BLUNT
	attack_verb = list("strikes", "hits")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	chargetime = 0
	recovery = 15
	penfactor = BLUNT_DEFAULT_PENFACTOR
	reach = 2
	icon_state = "instrike"
	item_d_type = "blunt"

/datum/intent/flail/strike/smash
	name = "smash"
	chargetime = 5
	chargedrain = 2
	no_early_release = TRUE
	penfactor = BLUNT_DEFAULT_PENFACTOR
	recovery = 10
	damfactor = 1.6
	chargedloop = /datum/looping_sound/flailswing
	keep_looping = TRUE
	icon_state = "insmash"
	blade_class = BCLASS_SMASH
	attack_verb = list("smashes")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	item_d_type = "blunt"

/datum/intent/flail/strike/smash/militia
	damfactor = 1.35

/datum/intent/flail/strike/smash/golgotha
	hitsound = list('sound/items/beartrap2.ogg')

/datum/intent/flail/strike/smashrange
	name = "ranged smash"
	chargetime = 10
	chargedrain = 2
	no_early_release = TRUE
	recovery = 30
	damfactor = 1.5
	penfactor = BLUNT_DEFAULT_PENFACTOR
	reach = 2
	chargedloop = /datum/looping_sound/flailswing
	keep_looping = TRUE
	icon_state = "insmash"
	blade_class = BCLASS_SMASH
	attack_verb = list("smashes")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	item_d_type = "blunt"

/obj/item/rogueweapon/flail/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -10,"sy" = -3,"nx" = 11,"ny" = -2,"wx" = -7,"wy" = -3,"ex" = 3,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 22,"sturn" = -23,"wturn" = -23,"eturn" = 29,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/flail/aflail
	name = "decrepit flail"
	desc = "This is a swift, ancient flail. Strikes hard and far. Aeon's grasp is upon its form."
	icon_state = "aflail"
	force = 22
	max_integrity = 175
	smeltresult = /obj/item/ingot/aalloy
	blade_dulling = DULLING_SHAFT_CONJURED

/obj/item/rogueweapon/flail/sflail/paflail
	name = "ancient flail"
	desc = "This is a swift, ancient flail. Strikes hard and far. Aeon's grasp has been molded away from its form."
	icon_state = "aflail"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/rogueweapon/flail/sflail
	force = 30
	icon_state = "flail"
	desc = "This is a swift, steel flail. Strikes hard and far."
	smeltresult = /obj/item/ingot/steel
	minstr = 5

/obj/item/rogueweapon/flail/sflail/necraflail
	name = "swift journey"
	desc = "The striking head is full of teeth, rattling viciously with ever strike, with every rotation. Each set coming from one the wielder has laid to rest. Carried alongside them as a great show of respect."
	icon_state = "necraflail"

/obj/item/rogueweapon/flail/sflail/psyflail
	name = "psydon's flail"
	desc = "An ornate flail, plated in a ceremonial veneer of silver. Its flanged head can crumple even the toughest of darksteel-maille."
	icon_state = "psyflail"

/obj/item/rogueweapon/flail/sflail/psyflail/ComponentInitialize()
	. = ..()							//+3 force, +50 int, +1 def, make silver
	AddComponent(/datum/component/psyblessed, FALSE, 3, FALSE, 50, 1, TRUE)

/datum/intent/whip/lash
	name = "lash"
	blade_class = BCLASS_BLUNT
	attack_verb = list("lashes", "cracks")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	chargetime = 0
	recovery = 7
	penfactor = BLUNT_DEFAULT_PENFACTOR
	damfactor = 1.1
	reach = 2
	icon_state = "inlash"
	item_d_type = "slash"

/datum/intent/whip/crack
	name = "crack"
	blade_class = BCLASS_CUT
	attack_verb = list("cracks", "strikes") //something something dwarf fotresss
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	chargetime = 0
	recovery = 10
	penfactor = 40
	reach = 3
	icon_state = "incrack"
	item_d_type = "slash"

/datum/intent/whip/punish
	name = "punish"
	blade_class = BCLASS_BLUNT
	attack_verb = list("lashes")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	chargetime = 0
	recovery = 10
	penfactor = BLUNT_DEFAULT_PENFACTOR
	reach = 2
	icon_state = "inpunish"
	item_d_type = "blunt"

/obj/item/rogueweapon/whip
	force = 21
	possible_item_intents = list(/datum/intent/whip/crack, /datum/intent/whip/lash, /datum/intent/whip/punish)
	name = "whip"
	desc = "A leather whip. Built to last, with a sharp stone for a tip."
	icon_state = "whip"
	icon = 'icons/roguetown/weapons/32.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.75
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BELT
	associated_skill = /datum/skill/combat/whipsflails
	anvilrepair = /datum/skill/craft/tanning
	parrysound = list('sound/combat/parry/parrygen.ogg')
	swingsound = WHIPWOOSH
	throwforce = 5
	wdefense = 0
	minstr = 6
	grid_width = 32
	grid_height = 64

/obj/item/rogueweapon/whip/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -10,"sy" = -3,"nx" = 11,"ny" = -2,"wx" = -7,"wy" = -3,"ex" = 3,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 22,"sturn" = -23,"wturn" = -23,"eturn" = 29,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

//Ranged mace-like mode
/datum/intent/whip/crack/blunt
	name = "bludgen"
	blade_class = BCLASS_BLUNT
	recovery = 6
	damfactor = 1.2 	//20% bonus because no pen, and it doesn't get smash crits.
	reach = 2			//Less range than a normal whip by 1
	icon_state = "instrike"
	item_d_type = "blunt"

/obj/item/rogueweapon/whip/nagaika
	name = "nagaika whip"
	desc = "A short but heavy leather whip, sporting a blunt reinforced tip and a longer handle."
	icon_state = "nagaika"
	force = 25		//Same as a cudgel/sword for intent purposes. Basically a 2 range cudgel while one-handing.
	possible_item_intents = list(/datum/intent/whip/crack/blunt, /datum/intent/whip/lash, /datum/intent/whip/punish, /datum/intent/sword/strike)
	wdefense = 1	//Akin to a cudgel, still terrible at parrying though.

/obj/item/rogueweapon/whip/xylix
	name = "cackle lash"
	desc = "The chimes of this whip are said to sound as the trickster's laughter itself."
	icon_state = "xylixwhip"
	force = 24

/obj/item/rogueweapon/whip/antique
	force = 29
	name = "Repenta En"
	desc = "An extremely well maintained whip, with a polished steel tip and gilded handle"
	minstr = 11
	icon_state = "gwhip"

/obj/item/rogueweapon/whip/antique/psywhip
	name = "Daybreak"
	desc = "Holding the blessed silver evokes a memory of the Grand Otavan Cathedral, a testament to humenity's faith. There, upon the ceiling, was painted a scene-most-beautiful: of a robed Psydon standing before the Archdevil, parting the nite's sky with a crack from His fiery whip. Just as He had done prior, so too must you bring daelight to the darkness."
	icon_state = "psywhip"
	is_silver = TRUE

/obj/item/rogueweapon/whip/psywhip_lesser
	name = "psydonite whip"
	desc = "An ornate whip, plated in a ceremonial veneer of silver. Crack the leather and watch as the apostates clammer aside."
	icon_state = "psywhip_lesser"

/obj/item/rogueweapon/whip/psywhip_lesser/ComponentInitialize()
	. = ..()					//+3 force, +50 int, +1 def, make silver
	AddComponent(/datum/component/psyblessed, FALSE, 3, FALSE, 50, 1, TRUE)

/obj/item/rogueweapon/flail/peasantwarflail
	force = 10
	force_wielded = 35
	possible_item_intents = list(/datum/intent/flail/strike)
	gripped_intents = list(/datum/intent/flail/strikerange, /datum/intent/flail/strike/smashrange)
	name = "militia thresher"
	desc = "Just like how a sling's bullet can fell a giant, so too does this great flail follow the principle of converting 'momentum' into 'plate-rupturing force'."
	icon_state = "peasantwarflail"
	icon = 'icons/roguetown/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = null
	minstr = 9
	wbalance = WBALANCE_HEAVY
	smeltresult = /obj/item/ingot/iron
	associated_skill = /datum/skill/combat/polearms
	anvilrepair = /datum/skill/craft/carpentry
	dropshrink = 0.9
	blade_dulling = DULLING_SHAFT_WOOD
	wdefense = 4
	resistance_flags = FLAMMABLE

/obj/item/rogueweapon/flail/peasantwarflail/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/rogueweapon/flail/militia
	name = "militia flail"
	desc = "In another lyfe, this humble thresher was used to pound stalks into grain. Under a militiaman's grasp, however, it has found a new purpose: to humble overconfident bandits with crippling blows."
	icon_state = "milflail"
	possible_item_intents = list(/datum/intent/flail/strike, /datum/intent/flail/strike/smash/militia)
	force = 27
	wdefense = 3
	wbalance = WBALANCE_HEAVY
