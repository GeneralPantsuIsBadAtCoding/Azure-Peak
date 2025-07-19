//intent datums ฅ^•ﻌ•^ฅ

/datum/intent/spear/thrust
	name = "thrust"
	blade_class = BCLASS_STAB
	attack_verb = list("thrusts")
	animname = "stab"
	icon_state = "instab"
	reach = 2
	chargetime = 1
	warnie = "mobwarning"
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = 50
	item_d_type = "stab"

/datum/intent/spear/thrust/militia
	penfactor = 40
	chargetime = 0

/datum/intent/spear/bash
	name = "bash"
	blade_class = BCLASS_BLUNT
	penfactor = BLUNT_DEFAULT_PENFACTOR
	icon_state = "inbash"
	attack_verb = list("bashes", "strikes")
	penfactor = 10
	damfactor = 0.8
	item_d_type = "blunt"

/datum/intent/spear/bash/ranged
	reach = 2

/datum/intent/spear/cut
	name = "cut"
	blade_class = BCLASS_CUT
	attack_verb = list("cuts", "slashes")
	icon_state = "incut"
	damfactor = 0.8
	hitsound = list('sound/combat/hits/bladed/genslash (1).ogg', 'sound/combat/hits/bladed/genslash (2).ogg', 'sound/combat/hits/bladed/genslash (3).ogg')
	reach = 2
	item_d_type = "slash"

/datum/intent/spear/cut/halberd
	damfactor = 0.9

/datum/intent/spear/cut/scythe
	reach = 3
	damfactor = 1

/datum/intent/spear/cut/bardiche
    damfactor = 1.2
    chargetime = 0

/datum/intent/spear/cut/glaive
	damfactor = 1.2
	chargetime = 0

/datum/intent/spear/cast
	name = "cast"
	chargetime = 0
	noaa = TRUE
	misscost = 0
	icon_state = "inuse"
	no_attack = TRUE

/datum/intent/spear/cut/naginata
	damfactor = 1.2
	chargetime = 0

/datum/intent/sword/cut/zwei
	reach = 2

/datum/intent/sword/thrust/zwei
	reach = 2

/datum/intent/sword/thrust/estoc
	name = "thrust"
	penfactor = 50
	recovery = 20
	clickcd = 10

/datum/intent/sword/lunge
	name = "lunge"
	icon_state = "inimpale"
	attack_verb = list("lunges")
	animname = "stab"
	blade_class = BCLASS_STAB
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	reach = 2
	penfactor = 30
	damfactor = 1.2
	chargetime = 5
	recovery = 20
	clickcd = 10

/datum/intent/sword/bash
	name = "pommel bash"
	blade_class = BCLASS_BLUNT
	icon_state = "inbash"
	attack_verb = list("bashes", "strikes")
	penfactor = BLUNT_DEFAULT_PENFACTOR
	damfactor = 1.3
	item_d_type = "blunt"


/datum/intent/rend
	name = "rend"
	icon_state = "inrend"
	attack_verb = list("rends")
	animname = "cut"
	blade_class = BCLASS_CHOP
	reach = 1
	penfactor = BLUNT_DEFAULT_PENFACTOR
	damfactor = 2.5
	chargetime = 10
	no_early_release = TRUE
	hitsound = list('sound/combat/hits/bladed/genslash (1).ogg', 'sound/combat/hits/bladed/genslash (2).ogg', 'sound/combat/hits/bladed/genslash (3).ogg')
	item_d_type = "slash"
	misscost = 10
	intent_intdamage_factor = 0.25

/datum/intent/rend/reach
	name = "long rend"
	penfactor = BLUNT_DEFAULT_PENFACTOR
	misscost = 5
	chargetime = 5
	damfactor = 2
	reach = 2

/datum/intent/rend/reach/partizan
	name = "rending thrust"
	attack_verb = list("skewers")
	blade_class = BCLASS_STAB
	chargetime = 10
	swingdelay = 8
	misscost = 20
	damfactor = 1.8
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	item_d_type = "stab"
	no_early_release = TRUE
	intent_intdamage_factor = 0.1

/datum/intent/partizan/peel
	name = "armor peel"
	icon_state = "inpeel"
	attack_verb = list("snags")
	animname = "cut"
	blade_class = BCLASS_PEEL
	hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	chargetime = 2
	penfactor = 200
	swingdelay = 5
	damfactor = 0.05
	item_d_type = "slash"
	peel_divisor = 4
	reach = 2



/datum/intent/spear/bash/ranged/quarterstaff
	damfactor = 1

/datum/intent/spear/thrust/quarterstaff
	blade_class = BCLASS_BLUNT
	hitsound = list('sound/combat/hits/blunt/bluntsmall (1).ogg', 'sound/combat/hits/blunt/bluntsmall (2).ogg')
	penfactor = BLUNT_DEFAULT_PENFACTOR
	damfactor = 1.3 // Adds up to be slightly stronger than an unenhanced ebeak strike.
	chargetime = 6 // Meant to be stronger than a bash, but with a delay.

/datum/intent/spear/thrust/lance
	damfactor = 1.5 // Turns its base damage into 30 on the 2hand thrust. It keeps the spear thrust one handed.

/datum/intent/lance/
	name = "lance"
	icon_state = "inlance"
	attack_verb = list("lances", "runs through", "skewers")
	animname = "stab"
	item_d_type = "stab"
	penfactor = BLUNT_DEFAULT_PENFACTOR // Not a mistake, to prevent it from nuking through armor.
	chargetime = 4 SECONDS
	damfactor = 4 // 80 damage on hit. It is gonna hurt.
	reach = 3 // Yep! 3 tiles

/datum/intent/lance/onehand
	chargetime = 5 SECONDS

//polearm objs ฅ^•ﻌ•^ฅ

/obj/item/rogueweapon/woodstaff
	force = 10
	force_wielded = 15
	possible_item_intents = list(SPEAR_BASH)
	gripped_intents = list(SPEAR_BASH,/datum/intent/mace/smash/wood)
	name = "wooden staff"
	desc = "A solid dependable walking stick that allows one to traverse rough terrain with ease, keep the weight off an injured leg, or reliably fend off incoming blows. Perfect for beggars, pilgrims, and mages."
	icon_state = "woodstaff"
	icon = 'icons/roguetown/weapons/64.dmi'
	wlength = WLENGTH_LONG
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	blade_dulling = DULLING_SHAFT_WOOD
	sharpness = IS_BLUNT
	walking_stick = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	wdefense = 10
	bigboy = TRUE
	gripsprite = TRUE
	associated_skill = /datum/skill/combat/polearms
	anvilrepair = /datum/skill/craft/carpentry
	resistance_flags = FLAMMABLE

/obj/item/rogueweapon/woodstaff/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = -1,"nx" = 8,"ny" = 0,"wx" = -4,"wy" = 0,"ex" = 2,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 4,"sy" = -2,"nx" = -3,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/woodstaff/wise
	name = "wise staff"
	desc = "A staff for keeping the volves at bay..."

/obj/item/rogueweapon/woodstaff/aries
	name = "staff of the shepherd"
	desc = "This staff makes you look important to any peasant."
	force = 25
	force_wielded = 28
	icon_state = "aries"
	icon = 'icons/roguetown/weapons/32.dmi'
	pixel_y = 0
	pixel_x = 0
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = FALSE
	gripsprite = FALSE
	gripped_intents = null

/obj/item/rogueweapon/woodstaff/aries/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 2,"nx" = 8,"ny" = 2,"wx" = -4,"wy" = 2,"ex" = 1,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 300,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 100,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 4,"sy" = -2,"nx" = -3,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)


/obj/item/rogueweapon/spear
	force = 20
	force_wielded = 30
	possible_item_intents = list(SPEAR_THRUST, SPEAR_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(SPEAR_THRUST, SPEAR_CUT, SPEAR_BASH)
	name = "spear"
	desc = "One of the oldest weapons still in use today, second only to the club. The lack of reinforcements along the shaft leaves it vulnerable to being split in two."
	icon_state = "spear"
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
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/iron
	associated_skill = /datum/skill/combat/polearms
	blade_dulling = DULLING_SHAFT_WOOD
	walking_stick = TRUE
	wdefense = 5
	thrown_bclass = BCLASS_STAB
	throwforce = 25
	resistance_flags = FLAMMABLE

/obj/item/rogueweapon/spear/aalloy
	name = "decrepit spear"
	desc = "A decrepit old spear. Aeon's grasp is upon it."
	icon_state = "ancient_spear"
	smeltresult = /obj/item/ingot/aalloy
	force = 13
	force_wielded = 22
	max_integrity = 180
	blade_dulling = DULLING_SHAFT_CONJURED

/obj/item/rogueweapon/spear/paalloy
	name = "ancient spear"
	desc = "A spear made of ancient alloys. Aeon's grasp has been lifted from it."
	smeltresult = /obj/item/ingot/aaslag
	icon_state = "ancient_spear"


/obj/item/rogueweapon/spear/psyspear
	name = "psydonian spear"
	desc = "An ornate spear, plated in a ceremonial veneer of silver. The barbs pierce your palm, and - for just a moment - you see red. Never forget that you are why Psydon wept."
	icon_state = "psyspear"
	resistance_flags = FIRE_PROOF	//It's meant to be smacked by a "lamptern", and is special enough to warrant overriding the spear weakness

/obj/item/rogueweapon/spear/psyspear/ComponentInitialize()
	. = ..()								//+3 force, +50 blade int, +50 int, +1 def, make silver
	AddComponent(/datum/component/psyblessed, FALSE, 3, 50, 50, 1, TRUE)

/obj/item/rogueweapon/spear/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/rogueweapon/spear/bonespear
	force = 18
	force_wielded = 22
	name = "bone spear"
	desc = "A spear made of bones..."
	icon_state = "bonespear"
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 6
	max_blade_int = 70
	smeltresult = null
	associated_skill = /datum/skill/combat/polearms
	blade_dulling = DULLING_SHAFT_WOOD
	walking_stick = TRUE
	wdefense = 4
	max_integrity = 60
	throwforce = 20

/obj/item/rogueweapon/spear/billhook
	name = "billhook"
	desc = "A neat hook. Used to pull riders from horses, as well as defend against said horses when used in a proper formation. The reinforcements along it's shaft grant it higher durability against attacks."
	icon_state = "billhook"
	smeltresult = /obj/item/ingot/steel
	max_blade_int = 200
	minstr = 8
	wdefense = 6
	throwforce = 15

/obj/item/rogueweapon/spear/improvisedbillhook
	force = 12
	force_wielded = 25
	name = "improvised billhook"
	desc = "Looks hastily made, even a little flimsy."
	icon_state = "billhook"
	smeltresult = /obj/item/ingot/iron
	max_blade_int = 100
	wdefense = 4
	throwforce = 10

/obj/item/rogueweapon/spear/stone
	force = 15
	force_wielded = 18
	name = "stone spear"
	desc = "This handmade spear is simple, but does the job."
	icon_state = "stonespear"
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	minstr = 6
	max_blade_int = 50
	smeltresult = null
	associated_skill = /datum/skill/combat/polearms
	blade_dulling = DULLING_SHAFT_WOOD
	walking_stick = TRUE
	wdefense = 4
	max_integrity = 50
	throwforce = 20

// Copper spear, no point to adjust force just slightly better integrity
/obj/item/rogueweapon/spear/stone/copper
	name = "copper spear"
	desc = "A simple spear with a copper tip. More durable than stone, but not much better."
	pixel_y = 0
	pixel_x = 0
	max_integrity = 100
	icon = 'icons/roguetown/weapons/32.dmi'
	dam_icon = 'icons/effects/item_damage32.dmi'
	icon_state = "cspear"
	smeltresult = null

/obj/item/rogueweapon/fishspear
	force = 20
	possible_item_intents = list(SPEAR_THRUST, SPEAR_BASH, SPEAR_CAST) //bash is for nonlethal takedowns, only targets limbs
	name = "fishing spear"
	desc = "This two-pronged and barbed spear was made to catch those pesky fish."
	icon_state = "fishspear"
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
	max_blade_int = 200
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/polearms
	blade_dulling = DULLING_SHAFT_WOOD
	walking_stick = TRUE
	wdefense = 4
	thrown_bclass = BCLASS_STAB
	throwforce = 35
	resistance_flags = FLAMMABLE

/obj/item/rogueweapon/fishspear/depthseek //DO NOT ADD RECIPE. MEANT TO BE AN ABYSSORITE RELIC. IDEA COURTESY OF LORDINQPLAS
	force = 45
	name = "blessed depthseeker"
	desc = "A beautifully crafted weapon, with handle carved of some beast's bone, inlaid with smooth seaglass at pommel and head, with two prongs smithed of fine dwarven steel. The seaglass carving at the head is a masterwork in and of itself, you can feel an abyssal energy radiating off it."
	icon_state = "depthseek"
	smeltresult = /obj/item/ingot/blacksteel
	max_blade_int = 2600
	wdefense = 8
	throwforce = 50

/obj/item/rogueweapon/fishspear/attack_self(mob/user)
	if(user.used_intent.type == SPEAR_CAST)
		if(user.doing)
			user.doing = 0

/obj/item/rogueweapon/fishspear/afterattack(obj/target, mob/user, proximity)
	freshfishloot = list(
		/obj/item/reagent_containers/food/snacks/fish/carp = 200,
		/obj/item/reagent_containers/food/snacks/fish/sunny = 300,
		/obj/item/reagent_containers/food/snacks/fish/salmon = 200,
		/obj/item/reagent_containers/food/snacks/fish/eel = 150,
		/mob/living/simple_animal/hostile/retaliate/rogue/mudcrab = 20,
	)
	seafishloot = list(
		/obj/item/reagent_containers/food/snacks/fish/cod = 200,
		/obj/item/reagent_containers/food/snacks/fish/plaice = 200,
		/obj/item/reagent_containers/food/snacks/fish/sole = 305,
		/obj/item/reagent_containers/food/snacks/fish/angler = 150,
		/obj/item/reagent_containers/food/snacks/fish/lobster = 300,
		/obj/item/reagent_containers/food/snacks/fish/bass = 200,
		/obj/item/reagent_containers/food/snacks/fish/clam = 100,
		/obj/item/reagent_containers/food/snacks/fish/clownfish = 50,
		/mob/living/carbon/human/species/goblin/npc/sea = 25,
		/mob/living/simple_animal/hostile/rogue/deepone = 30,
		/mob/living/simple_animal/hostile/rogue/deepone/spit = 30,
	)
	mudfishloot = list(
		/obj/item/reagent_containers/food/snacks/fish/mudskipper = 200,
		/obj/item/natural/worms/leech = 50,
		/mob/living/simple_animal/hostile/retaliate/rogue/mudcrab = 25,
	)
	var/sl = user.get_skill_level(/datum/skill/labor/fishing) // User's skill level
	var/ft = 160 //Time to get a catch, in ticks
	var/fpp =  130 - (40 + (sl * 15)) // Fishing power penalty based on fishing skill level
	var/frwt = list(/turf/open/water/river, /turf/open/water/cleanshallow, /turf/open/water/pond)
	var/salwt = list(/turf/open/water/ocean, /turf/open/water/ocean/deep)
	var/mud = list(/turf/open/water/swamp, /turf/open/water/swamp/deep)
	if(istype(target, /turf/open/water))
		if(user.used_intent.type == SPEAR_CAST && !user.doing)
			if(target in range(user,3))
				user.visible_message("<span class='warning'>[user] searches for a fish!</span>", \
									"<span class='notice'>I begin looking for a fish to spear.</span>")
				playsound(src.loc, 'sound/items/fishing_plouf.ogg', 100, TRUE)
				ft -= (sl * 20) //every skill lvl is -2 seconds
				ft = max(20,ft) //min of 2 seconds
				if(do_after(user,ft, target = target))
					var/fishchance = 100 // Total fishing chance, deductions applied below
					if(user.mind)
						if(!sl) // If we have zero fishing skill...
							fishchance -= 50 // 50% chance to fish base
						else
							fishchance -= fpp // Deduct a penalty the lower our fishing level is (-0 at legendary)
					var/mob/living/fisherman = user
					if(prob(fishchance)) // Finally, roll the dice to see if we fish.
						if(target.type in frwt)
							var/A = pickweight(freshfishloot)
							var/ow = 30 + (sl * 10) // Opportunity window, in ticks. Longer means you get more time to cancel your bait
							to_chat(user, "<span class='notice'>You see something!</span>")
							playsound(src.loc, 'sound/items/fishing_plouf.ogg', 100, TRUE)
							if(!do_after(user,ow, target = target))
								if(ismob(A)) // TODO: Baits with mobs on their fishloot lists OR water tiles with their own fish loot pools
									var/mob/M = A
									if(M.type in subtypesof(/mob/living/simple_animal/hostile))
										new M(target)
									else
										new M(user.loc)
									user.mind.add_sleep_experience(/datum/skill/labor/fishing, fisherman.STAINT*2) // High risk high reward
								else
									new A(user.loc)
									to_chat(user, "<span class='warning'>Pull 'em in!</span>")
									user.mind.add_sleep_experience(/datum/skill/labor/fishing, round(fisherman.STAINT, 2), FALSE) // Level up!
									playsound(src.loc, 'sound/items/Fish_out.ogg', 100, TRUE)	
							else
								to_chat(user, "<span class='warning'>Damn, it got away... I should <b>pull away</b> next time.</span>")								
						if(target.type in salwt)
							var/A = pickweight(seafishloot)
							var/ow = 30 + (sl * 10) // Opportunity window, in ticks. Longer means you get more time to cancel your bait
							to_chat(user, "<span class='notice'>You see something!</span>")
							playsound(src.loc, 'sound/items/fishing_plouf.ogg', 100, TRUE)
							if(!do_after(user,ow, target = target))
								if(ismob(A)) // TODO: Baits with mobs on their fishloot lists OR water tiles with their own fish loot pools
									var/mob/M = A
									if(M.type in subtypesof(/mob/living/simple_animal/hostile))
										new M(target)
									else
										new M(user.loc)
									user.mind.add_sleep_experience(/datum/skill/labor/fishing, fisherman.STAINT*2) // High risk high reward
								else
									new A(user.loc)
									to_chat(user, "<span class='warning'>Pull 'em in!</span>")
									user.mind.add_sleep_experience(/datum/skill/labor/fishing, round(fisherman.STAINT, 2), FALSE) // Level up!
									playsound(src.loc, 'sound/items/Fish_out.ogg', 100, TRUE)	
							else
								to_chat(user, "<span class='warning'>Damn, it got away... I should <b>pull away</b> next time.</span>")							
						if(target.type in mud)
							var/A = pickweight(mudfishloot)
							var/ow = 30 + (sl * 10) // Opportunity window, in ticks. Longer means you get more time to cancel your bait
							to_chat(user, "<span class='notice'>You see something!</span>")
							playsound(src.loc, 'sound/items/fishing_plouf.ogg', 100, TRUE)
							if(!do_after(user,ow, target = target))
								if(ismob(A)) // TODO: Baits with mobs on their fishloot lists OR water tiles with their own fish loot pools
									var/mob/M = A
									if(M.type in subtypesof(/mob/living/simple_animal/hostile))
										new M(target)
									else
										new M(user.loc)
									user.mind.add_sleep_experience(/datum/skill/labor/fishing, fisherman.STAINT*2) // High risk high reward
								else
									new A(user.loc)
									to_chat(user, "<span class='warning'>Pull 'em in!</span>")
									user.mind.add_sleep_experience(/datum/skill/labor/fishing, round(fisherman.STAINT, 2), FALSE) // Level up!
									playsound(src.loc, 'sound/items/Fish_out.ogg', 100, TRUE)
							else
								to_chat(user, "<span class='warning'>Damn, it got away... I should <b>pull away</b> next time.</span>")
					else
						to_chat(user, "<span class='warning'>Not a single fish...</span>")
						user.mind.add_sleep_experience(/datum/skill/labor/fishing, fisherman.STAINT/2) // Pity XP.
				else
					to_chat(user, "<span class='warning'>I must stand still to fish.</span>")
			update_icon()

/obj/item/rogueweapon/fishspear/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list(
					"shrink" = 0.6,
					"sx" = -6,
					"sy" = 7,
					"nx" = 6,
					"ny" = 8,
					"wx" = 0,
					"wy" = 6,
					"ex" = -1,
					"ey" = 8,
					"northabove" = 0,
					"southabove" = 1,
					"eastabove" = 1,
					"westabove" = 0,
					"nturn" = -50,
					"sturn" = 40,
					"wturn" = 50,
					"eturn" = -50,
					"nflip" = 0,
					"sflip" = 8,
					"wflip" = 8,
					"eflip" = 0,
					)
			if("wielded")
				return list(
					"shrink" = 0.6,
					"sx" = 3,
					"sy" = 1,
					"nx" = -3,
					"ny" = 1,
					"wx" = -9,
					"wy" = 1,
					"ex" = 9,
					"ey" = 1,
					"northabove" = 0,
					"southabove" = 1,
					"eastabove" = 1,
					"westabove" = 0,
					"nturn" = -30,
					"sturn" = 30,
					"wturn" = -30,
					"eturn" = 30,
					"nflip" = 8,
					"sflip" = 0,
					"wflip" = 8,
					"eflip" = 0,
					)

/obj/item/rogueweapon/halberd
	force = 15
	force_wielded = 30
	possible_item_intents = list(SPEAR_THRUST, SPEAR_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(SPEAR_THRUST, /datum/intent/spear/cut/halberd, /datum/intent/sword/chop, SPEAR_BASH)
	name = "halberd"
	desc = "A steel halberd, the pinnacle of all cumulative melee weapon knowledge. The only downside is the cost, so it's rarely seen outside of the guardsmans' hands. The reinforcements along the shaft provide greater durability."
	icon_state = "halberd"
	icon = 'icons/roguetown/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 9
	max_blade_int = 200
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/polearms
	blade_dulling = DULLING_SHAFT_WOOD
	walking_stick = TRUE
	wdefense = 6

/obj/item/rogueweapon/halberd/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/halberd/holysee
	name = "eclipsum halberd"
	desc = "A mutual effort of Noc and Astrata's followers, this halberd was forged with both Silver and Gold alike. Blessed to hold strength and bring hope. Whether dae or nite. The reinforced shaft provides greater durability."
	icon_state = "gsspear"
	max_integrity = 300
	force = 20
	force_wielded = 35

/obj/item/rogueweapon/halberd/bardiche
	possible_item_intents = list(/datum/intent/spear/thrust/eaglebeak, SPEAR_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(/datum/intent/spear/thrust/eaglebeak, /datum/intent/spear/cut/bardiche, /datum/intent/axe/chop, SPEAR_BASH)
	name = "bardiche"
	desc = "A beautiful variant of the halberd. Its reinforced shaft provides it with greater durability against attacks."
	icon_state = "bardiche"
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/iron
	max_blade_int = 200

/obj/item/rogueweapon/halberd/bardiche/aalloy
	name = "decrepit bardiche"
	desc = "A decrepit bardiche. Aeon's grasp upon it."
	max_integrity = 180
	force = 12
	force_wielded = 22
	icon_state = "ancient_bardiche"
	smeltresult = /obj/item/ingot/aalloy
	blade_dulling = DULLING_SHAFT_CONJURED

/obj/item/rogueweapon/halberd/bardiche/paalloy
	name = "ancient bardiche"
	desc = "A bardiche made of ancient alloys. Aeon's grasp lifted from its form."
	icon_state = "ancient_bardiche"
	smeltresult = /obj/item/ingot/aaslag


/obj/item/rogueweapon/halberd/bardiche/scythe
	name = "summer scythe"
	desc = "Summer's verdancy runs through the head of this scythe. All the more to sow."
	icon_state = "dendorscythe"
	gripped_intents = list(/datum/intent/spear/thrust/eaglebeak, /datum/intent/spear/cut/bardiche, /datum/intent/axe/chop/scythe, SPEAR_BASH)

/obj/item/rogueweapon/halberd/psyhalberd
	name = "Stigmata"
	desc = "Christened in the Siege of Lirvas, these silver-tipped poleaxes - wielded by a lonesome contingent of Saint Eora's paladins - kept the horrors at bay for forty daes-and-nites. Long-since-recovered from the rubble, this relic now serve as a bulwark for the defenseless."
	icon_state = "psyhalberd"

/obj/item/rogueweapon/halberd/psyhalberd/ComponentInitialize()
	. = ..()				//Pre-blessed, +5 force, +100 blade int, +100 int, +2 def, make silver.
	AddComponent(/datum/component/psyblessed, TRUE, 5, 100, 100, 2, TRUE)

/obj/item/rogueweapon/halberd/glaive
	possible_item_intents = list(/datum/intent/spear/thrust/eaglebeak, SPEAR_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(/datum/intent/spear/thrust/glaive, /datum/intent/spear/cut/glaive, /datum/intent/axe/chop/scythe, SPEAR_BASH)
	name = "glaive"
	desc = "A curved blade on a pole, specialised in defence, but expensive to manufacture."
	icon_state = "glaive"
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/steel
	max_blade_int = 300
	wdefense = 9

/obj/item/rogueweapon/halberd/glaive/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded") 
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onback") 
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)



/obj/item/rogueweapon/eaglebeak
	force = 15
	force_wielded = 30
	possible_item_intents = list(/datum/intent/spear/thrust/eaglebeak, SPEAR_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(/datum/intent/spear/thrust/eaglebeak, /datum/intent/mace/smash/eaglebeak, SPEAR_BASH)
	name = "eagle's beak"
	desc = "A reinforced pole affixed with an ornate steel eagle's head, of which its beak is intended to pierce with great harm."
	icon_state = "eaglebeak"
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
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/polearms
	max_blade_int = 300
	blade_dulling = DULLING_SHAFT_REINFORCED
	walking_stick = TRUE
	wdefense = 5
	wbalance = WBALANCE_HEAVY
	sellprice = 60
	intdamage_factor = 1.2

/obj/item/rogueweapon/eaglebeak/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/eaglebeak/lucerne
	name = "lucerne"
	desc = "A polehammer of simple iron. Fracture bone and dissent with simple brute force. The studding along its shaft makes for a slightly more reinforced weapon."
	force = 12
	force_wielded = 25
	icon_state = "polehammer"
	smeltresult = /obj/item/ingot/iron
	max_blade_int = 300
	sellprice = 40

/datum/intent/spear/thrust/eaglebeak
	penfactor = 20
	damfactor = 0.9

/datum/intent/spear/thrust/glaive
	penfactor = 50
	damfactor = 1.1
	chargetime = 0

/datum/intent/mace/smash/eaglebeak
	reach = 2
	swingdelay = 12
	clickcd = 14

/obj/item/rogueweapon/spear/bronze
	name = "Bronze Spear"
	desc = "A spear forged of bronze. Much more durable than a regular spear."
	icon_state = "bronzespear"
	max_blade_int = 200
	smeltresult = /obj/item/ingot/bronze
	smelt_bar_num = 2


/obj/item/rogueweapon/greatsword
	force = 12
	force_wielded = 30
	possible_item_intents = list(/datum/intent/sword/chop,/datum/intent/sword/strike) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(/datum/intent/sword/cut/zwei, /datum/intent/sword/chop, /datum/intent/sword/thrust/zwei, /datum/intent/sword/peel/big)
	alt_intents = list(/datum/intent/effect/daze, /datum/intent/sword/strike, /datum/intent/sword/bash)
	armor = ARMOR_GREATSWORD
	name = "greatsword"
	desc = "Might be able to chop anything in half!"
	icon_state = "gsw"
	parrysound = list(
		'sound/combat/parry/bladed/bladedlarge (1).ogg',
		'sound/combat/parry/bladed/bladedlarge (2).ogg',
		'sound/combat/parry/bladed/bladedlarge (3).ogg',
		)
	icon = 'icons/roguetown/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	blade_dulling = DULLING_SHAFT_METAL
	minstr = 9
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/swords
	max_blade_int = 300
	wdefense = 5
	smelt_bar_num = 3

/obj/item/rogueweapon/greatsword/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
			if("altgrip")
				return list("shrink" = 0.6,"sx" = 4,"sy" = 0,"nx" = -7,"ny" = 1,"wx" = -8,"wy" = 0,"ex" = 8,"ey" = -1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -135,"sturn" = -35,"wturn" = 45,"eturn" = 145,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)


/obj/item/rogueweapon/greatsword/aalloy
	name = "decrepit greatsword"
	desc = "A decrepit old greatsword. You'd be lucky if it chopped anything in half. Aeon's grasp is upon its form."
	force = 10
	force_wielded = 25
	max_integrity = 180
	icon_state = "ancient_gsw"
	smeltresult = /obj/item/ingot/aalloy
	blade_dulling = DULLING_SHAFT_CONJURED


/obj/item/rogueweapon/greatsword/paalloy
	name = "ancient greatsword"
	desc = "An ancient greatsword. Aeon's grasp lifted from its form."
	icon_state = "ancient_gsw"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/rogueweapon/greatsword/zwei
	name = "zweihander"
	desc = "This is much longer than a common greatsword, and well balanced too!"
	icon_state = "zwei"
	smeltresult = /obj/item/ingot/iron
	smelt_bar_num = 3
	max_blade_int = 200
	wdefense = 4
	force = 14
	force_wielded = 35

/obj/item/rogueweapon/greatsword/grenz
	name = "steel zweihander"
	icon_state = "steelzwei"
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 3
	max_blade_int = 300
	force = 14
	force_wielded = 35

/obj/item/rogueweapon/greatsword/psygsword
	name = "Apocrypha"
	desc = "In the Otavan mosaics, Saint Ravox - bare in all but a beaked helmet and loincloth - is often depicted wielding such an imposing greatweapon against the Dark Star, Graggar. Regardless of whether this relic was actually wielded by divinity-or-not, its unparallel strength will nevertheless command even the greatest foes to fall."
	icon_state = "psygsword"

/obj/item/rogueweapon/greatsword/psygsword/ComponentInitialize()
	. = ..()					//Pre-blessed, +100 Blade int, +100 int, +2 def, make it silver
	AddComponent(/datum/component/psyblessed, TRUE, 5, 100, 100, 2, TRUE)

/obj/item/rogueweapon/estoc
	name = "estoc"
	desc = "A sword possessed of a quite long and tapered blade that is intended to be thrust between the \
	gaps in an opponent's armor. The hilt is wrapped tight in black leather."
	icon_state = "estoc"
	icon = 'icons/roguetown/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	force = 12
	force_wielded = 25
	possible_item_intents = list(
		/datum/intent/sword/chop,
		/datum/intent/sword/strike,
	)
	gripped_intents = list(
		/datum/intent/sword/thrust/estoc,
		/datum/intent/sword/lunge,
		/datum/intent/sword/chop,
		/datum/intent/sword/strike,
	)
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	blade_dulling = DULLING_SHAFT_METAL
	minstr = 8
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/swords
	max_blade_int = 300
	wdefense = 5
	smelt_bar_num = 2

/obj/item/rogueweapon/estoc/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list(
					"shrink" = 0.6,
					"sx" = -6,
					"sy" = 7,
					"nx" = 6,
					"ny" = 8,
					"wx" = 0,
					"wy" = 6,
					"ex" = -1,
					"ey" = 8,
					"northabove" = 0,
					"southabove" = 1,
					"eastabove" = 1,
					"westabove" = 0,
					"nturn" = -50,
					"sturn" = 40,
					"wturn" = 50,
					"eturn" = -50,
					"nflip" = 0,
					"sflip" = 8,
					"wflip" = 8,
					"eflip" = 0,
					)
			if("wielded")
				return list(
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

/obj/item/rogueweapon/woodstaff/naledi
	name = "naledian warstaff"
	desc = "A staff carrying the crescent moon of Psydon's knowledge, as well as the black and gold insignia of the war scholars."
	icon_state = "naledistaff"
	possible_item_intents = list(SPEAR_BASH)
	gripped_intents = list(/datum/intent/spear/bash/ranged,/datum/intent/mace/smash/wood/ranged)
	force = 18
	force_wielded = 22
	max_integrity = 250

/obj/item/rogueweapon/woodstaff/naledi/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.8,"sx" = -9,"sy" = 5,"nx" = 9,"ny" = 5,"wx" = -4,"wy" = 4,"ex" = 4,"ey" = 4,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.8,"sx" = 8,"sy" = 0,"nx" = -1,"ny" = 0,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/rogueweapon/woodstaff/quarterstaff
	name = "wooden quarterstaff"
	desc = "A staff that makes any journey easier. Durable and swift, capable of bludgeoning stray volves and ruffians alike. Its length allow it to be used for a thrusting attack."
	force = 15
	force_wielded = 20
	gripped_intents = list(/datum/intent/spear/bash/ranged/quarterstaff, /datum/intent/spear/thrust/quarterstaff)
	icon_state = "quarterstaff"
	max_integrity = 300

/obj/item/rogueweapon/woodstaff/quarterstaff/iron
	name = "iron quarterstaff"
	desc = "A quarterstaff reinforced with iron tips. It is capable of dealing more damage than a wooden one, and its blunt ends make for a decent blunt thrusting weapon. Can be used to bash down your opponents weapons."
	force = 16
	force_wielded = 22
	gripped_intents = list(/datum/intent/spear/bash/ranged/quarterstaff, /datum/intent/spear/thrust/quarterstaff)
	icon_state = "quarterstaff_iron"
	max_integrity = 300
	blade_dulling = DULLING_SHAFT_REINFORCED
	intdamage_factor = 1.2

/obj/item/rogueweapon/woodstaff/quarterstaff/steel
	name = "steel quarterstaff"
	desc = "A quarterstaff reinforced with steel tips and steel rings, blurring the line between a light polehammer and a reinforced quarterstaff. Extremely durable, and more than capable of bludgeoning brigands to death. Durable enough to break your opponents weapons."
	force = 18
	force_wielded = 25
	gripped_intents = list(/datum/intent/spear/bash/ranged/quarterstaff, /datum/intent/spear/thrust/quarterstaff)
	icon_state = "quarterstaff_steel"
	max_integrity = 400
	blade_dulling = DULLING_SHAFT_REINFORCED
	intdamage_factor = 1.2

/obj/item/rogueweapon/spear/partizan
	name = "partizan"
	desc = "A reinforced spear-like polearm of disputed origin: A studded shaft fitted with a steel spearhead with protrusions to aid in parrying. An extremely recent invention that is seeing increasingly more usage in the Western lands."
	force = 8	//Not a possible one-handed weapon. Also too heavy!
	force_wielded = 30
	possible_item_intents = list(SPEAR_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(SPEAR_THRUST, PARTIZAN_REND, PARTIZAN_PEEL)
	icon_state = "partizan"
	icon = 'icons/roguetown/weapons/64.dmi'
	minstr = 10
	max_blade_int = 200
	wdefense = 6
	throwforce = 12	//Not a throwing weapon. Too heavy!
	blade_dulling = DULLING_SHAFT_REINFORCED
	icon_angle_wielded = 50

/obj/item/rogueweapon/spear/partizan/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 2,"nx" = 8,"ny" = 2,"wx" = -4,"wy" = 2,"ex" = 1,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 300,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 100,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 4,"sy" = -2,"nx" = -3,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/rogueweapon/spear/boar
	name = "boar spear"
	desc = "A spear with a wide head and a pair of wings below the head. The wings are designed to prevent a boar from charging past the spearhead. \
	It is also useful for parrying and stopping a charging opponent."
	icon = 'icons/roguetown/weapons/polearms64.dmi'
	icon_state = "boarspear"
	force_wielded = 33 // 10% base damage increase
	wdefense = 6 // A little bit extra
	max_blade_int = 150 // 50% more sharpness but it barely matter lol

/obj/item/rogueweapon/spear/lance
	name = "lance"
	desc = "A long polearm designed to be used from horseback, couched under the arm. It has a vambrace to prevent the arm sliding up \
	the shaft on impact. "
	icon = 'icons/roguetown/weapons/polearms64.dmi'
	icon_state = "lance"
	force = 15 // Its gonna sucks for 1 handed use
	force_wielded = 20 // Lower damage because a 3 tiles thrust without full charge time still deal base damage. 
	wdefense = 4 // 2 Lower than spear
	max_integrity = 200
	max_blade_int = 200 // Better sharpness
	possible_item_intents = list(SPEAR_THRUST, /datum/intent/lance/onehand, SPEAR_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(/datum/intent/spear/thrust/lance, /datum/intent/lance, SPEAR_BASH)
	resistance_flags = null
	blade_dulling = DULLING_SHAFT_REINFORCED

/obj/item/rogueweapon/spear/naginata
	name = "Naginata"
	desc = "A traditional Kazengunese polearm, combining the reach of a spear with the cutting power of a curved blade. Due to the brittle quality of Kazengunese bladesmithing, weaponsmiths have adapted its blade to be easily replaceable when broken by a peg upon the end of the shaft."
	force = 16
	force_wielded = 30
	possible_item_intents = list(/datum/intent/spear/cut/naginata, SPEAR_BASH) // no stab for you little chuddy, it's a slashing weapon
	gripped_intents = list(/datum/intent/rend/reach, /datum/intent/spear/cut/naginata, PARTIZAN_PEEL, SPEAR_BASH)
	icon_state = "naginata"
	icon = 'icons/roguetown/weapons/64.dmi'
	minstr = 7
	max_blade_int = 50 //Nippon suteeru (dogshit)
	wdefense = 5
	throwforce = 12	//Not a throwing weapon. 
	blade_dulling = DULLING_SHAFT_REINFORCED
	icon_angle_wielded = 50

/obj/item/rogueweapon/spear/naginata/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 2,"nx" = 8,"ny" = 2,"wx" = -4,"wy" = 2,"ex" = 1,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 300,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 100,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 4,"sy" = -2,"nx" = -3,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
