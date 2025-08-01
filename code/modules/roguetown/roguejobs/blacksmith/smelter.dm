
/obj/item
	var/smeltresult
	var/smelt_bar_num = 1 //variable for tracking how many bars things smelt back into for multi-bar items
// MULTIBAR SMELTING WAS DISABLED FOR BALANCE REASONS
// DO NOT RE-ENABLE IT UNTIL FURTHER NOTICE
/obj/machinery/light/rogue/smelter
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "stone furnace"
	desc = "A stone furnace, weathered by time and heat."
	icon_state = "cavesmelter0"
	base_state = "cavesmelter"
	anchored = TRUE
	density = TRUE
	climbable = TRUE
	climb_time = 0
	climb_offset = 10
	on = TRUE
	var/list/ore = list()
	var/maxore = 1
	var/cooking = 0
	var/actively_smelting = FALSE // Are we currently smelting?
	var/datum/mind/smelter_mind // Who smelted the ore?

	fueluse = 30 MINUTES
	crossfire = FALSE

/obj/machinery/light/rogue/smelter/examine(mob/user, params)
	. = ..()
	. += span_info("It can hold up to [maxore] ores at a time.")
	. += span_info("Left click to insert an item. If it is a fuel item, a prompt will show on whether you want to fuel or smelt it. Right click on the furnace to put an item inside for smelting only.")
	if(ore.len)
		. += span_notice("Peeking inside, you can see:")
	for(var/obj/item/I in ore)
		. += span_info("- [I]")

/obj/machinery/light/rogue/smelter/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/rogueweapon/tongs))
		if(!actively_smelting) // Prevents an exp gain exploit. - Foxtrot
			var/obj/item/rogueweapon/tongs/T = W
			if(ore.len && !T.hingot)
				var/obj/item/I = ore[ore.len]
				ore -= I
				I.forceMove(T)
				T.hingot = I
				if(user.mind && isliving(user) && T.hingot?.smeltresult) // Prevents an exploit with coal and runtimes with everything else
					if(!istype(T.hingot, /obj/item/rogueore) && T.hingot?.smelted) // Burning items to ash won't level smelting.
						var/mob/living/L = user
						user.mind.add_sleep_experience(/datum/skill/craft/smelting, L.STAINT*2, FALSE)// Smelting is already a timesink, this is justified to accelerate levelling
				user.visible_message(span_info("[user] retrieves [I] from [src]."))
				if(on)
					var/tyme = world.time
					T.hott = tyme
					addtimer(CALLBACK(T, TYPE_PROC_REF(/obj/item/rogueweapon/tongs, make_unhot), tyme), 50)
				T.update_icon()
				return
			if(on)
				to_chat(user, span_info("Nothing to retrieve from inside."))
				return // Safety for not smelting our tongs
		else
			to_chat(user, span_warning("\The [src] is currently smelting. Wait for it to finish, or douse it with water to retrieve items from it."))
			return

	if(W.firefuel)
		if(!(..())) //False/null if using the item as fuel. If true, we want to try smelt it so go onto next segment.
			return
	if(W.smeltresult)
		addOre(W, user) // Adds the item to the smelter's ore list, if it can be smelted.
		return
	
	else
		if(!W.firefuel && !istype(W, /obj/item/flint) && !istype(W, /obj/item/flashlight/flare/torch) && !istype(W, /obj/item/rogueore/coal))
			to_chat(user, span_warning("\The [W.name] cannot be smelted."))
	return ..()

/obj/machinery/light/rogue/smelter/attack_right(mob/user)
	var/obj/item/I = user.get_active_held_item()
	if(I && I.smeltresult)
		addOre(I, user)
	return ..()

// Gaining experience from just retrieving bars with your hands would be a hard-to-patch exploit.
/obj/machinery/light/rogue/smelter/attack_hand(mob/user, params)
	if(on)
		to_chat(user, span_warning("It's too hot to retrieve bars with your hands."))
		return
	if(ore.len)
		var/obj/item/I = ore[ore.len]
		ore -= I
		I.loc = user.loc
		user.put_in_active_hand(I)
		user.visible_message(span_info("[user] retrieves \the [I] from \the [src]."))
	else
		return ..()

/obj/machinery/light/rogue/smelter/proc/addOre(obj/item/W, mob/user)
	if(!W)
		return
	if(user.get_active_held_item() != W)
		to_chat(user, span_warning("That item is no longer in my hand..."))
		return
	if(ore.len < maxore)
		user.dropItemToGround(W)
		W.forceMove(src)
		ore += W
		if(!isliving(user) || !user.mind)
			ore[W] = SMELTERY_LEVEL_SPOIL
		else
			var/smelter_exp = user.get_skill_level(/datum/skill/craft/smelting) // 0 to 6
			if(smelter_exp < 6)
				ore[W] = min(6, floor(rand(smelter_exp*15 + 10, max(30, smelter_exp*25))/25)+1) // Math explained below
			else
				ore[W] = 6 // Guarantees a return of 6 no matter how extra experience past 3000 you have.
			/*
			RANDOMLY PICKED NUMBER ACCORDING TO SMELTER SKILL:
				NO SKILL: 		between 10 and 30
				NOVICE:	 		between 25 and 30
				APPRENTICE:	 	between 40 and 50
				JOURNEYMAN: 	between 55 and 75
				EXPERT: 		between 70 and 100
				MASTER: 		between 85 and 125
				LEGENDARY: 		between 100 and 150

			PICKED NUMBER GETS DIVIDED BY 25 AND ROUNDED DOWN TO CLOSEST INTEGER, +1.
			RESULT DETERMINES QUALITY OF BAR. SEE code/__DEFINES/skills.dm
				1 = SPOILED
				2 = POOR
				3 = NORMAL
				4 = GOOD
				5 = GREAT
				6 = EXCELLENT
			*/
		user.visible_message(span_warning("[user] puts something in \the [src]."))
		cooking = 0
		return
	else
		to_chat(user, span_warning("\The [W.name] can be smelted, but \the [src] is full."))
		return

/obj/machinery/light/rogue/smelter/process()
	..()
	if(maxore > 1)
		return
	if(on)
		if(ore.len)
			if(cooking < 20)
				cooking++
				playsound(src.loc,'sound/misc/smelter_sound.ogg', 50, FALSE)
				actively_smelting = TRUE
			else
				if(cooking == 20)
					for(var/obj/item/I in ore)
						if(I.smeltresult)
//							while(I.smelt_bar_num)
//								I.smelt_bar_num--
//	DISABLED FOR NOW			var/obj/item/R = new I.smeltresult(src, ore[I])
//								ore += R
//							ore -= I
							var/obj/item/R = new I.smeltresult(src, ore[I])
							ore -= I
							ore += R
							qdel(I)
					playsound(src,'sound/misc/smelter_fin.ogg', 100, FALSE)
					visible_message(span_notice("\The [src] finished smelting."))
					cooking = 21
					actively_smelting = FALSE

/obj/machinery/light/rogue/smelter/burn_out()
	cooking = 0
	actively_smelting = FALSE
	..()

/obj/machinery/light/rogue/smelter/great
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "great furnace"
	desc = "The pinnacle of dwarven engineering and the miracle of Malum's blessed fire crystal, allowing for greater alloys to be made."
	icon_state = "smelter0"
	base_state = "smelter"
	anchored = TRUE
	density = TRUE
	maxore = 4
	climbable = FALSE

/obj/machinery/light/rogue/smelter/great/process()
	..()
	if(on)
		if(ore.len)
			if(cooking < 30)
				cooking++
				playsound(src.loc,'sound/misc/smelter_sound.ogg', 50, FALSE)
				actively_smelting = TRUE
			else
				if(cooking == 30)
					var/alloy //moving each alloy to it's own var allows for possible additions later
					// Steel Alloy requires a 1 coal to 1 iron ratio. Yes. Doesn't make sense but it is to make
					// Steel more expensive to make
					var/steelalloycoal
					var/steelalloyiron
					var/bronzealloy
					var/purifiedalloy
					var/blacksteelalloy // Idk why Blacksteel were removed but we don't have an overabundance of steel and such anymore

					for(var/obj/item/I in ore)
						if(I.smeltresult == /obj/item/rogueore/coal)
							steelalloycoal += 1
						if(I.smeltresult == /obj/item/rogueore/coal/charcoal)
							steelalloycoal += 1
						if(I.smeltresult == /obj/item/ingot/iron)
							steelalloyiron += 1
						if(I.smeltresult == /obj/item/ingot/tin)
							bronzealloy = bronzealloy + 1
						if(I.smeltresult == /obj/item/ingot/copper)
							bronzealloy = bronzealloy + 2
						if(I.smeltresult == /obj/item/ingot/aalloy)
							purifiedalloy = purifiedalloy + 3
						if(I.smeltresult == /obj/item/ingot/gold)
							purifiedalloy = purifiedalloy + 2
						if(I.smeltresult == /obj/item/ingot/silver)
							blacksteelalloy = blacksteelalloy + 1
						if(I.smeltresult == /obj/item/ingot/steel)
							blacksteelalloy = blacksteelalloy + 2

					if(steelalloycoal == 1 && steelalloyiron == 3)
						maxore = 3
						alloy = /obj/item/ingot/steel
					else if(bronzealloy == 7)
						alloy = /obj/item/ingot/bronze
					else if(purifiedalloy == 10)
						maxore = 3
						alloy = /obj/item/ingot/purifiedaalloy // 2 aalloy, 2 gold, makes 3 purified alloy.
					else if(blacksteelalloy == 7)
						maxore = 1 // Blacksteel is supposed to be rare and inefficient. 3 steel and 1 silver into one. 
						alloy = /obj/item/ingot/blacksteel
					else
						alloy = null

					if(alloy)
						// The smelting quality of all ores added together, divided by the number of ores, and then rounded to the lowest integer (this isn't done until after the for loop)
						var/floor_mean_quality = SMELTERY_LEVEL_SPOIL
						var/ore_deleted = 0
						for(var/obj/item/I in ore)
							floor_mean_quality += ore[I]
							ore_deleted += 1
							ore -= I
							qdel(I)
						floor_mean_quality = floor(floor_mean_quality/ore_deleted)
						for(var/i in 1 to maxore)
							var/obj/item/R = new alloy(src, floor_mean_quality)
							ore += R
					else
						for(var/obj/item/I in ore)
							if(I.smeltresult)
								var/obj/item/R = new I.smeltresult(src, ore[I])
								ore -= I
								ore += R
								qdel(I)

					playsound(src,'sound/misc/smelter_fin.ogg', 100, FALSE)
					visible_message(span_notice("\The [src] finished smelting."))
					maxore = initial(maxore)
					cooking = 31
					actively_smelting = FALSE



/obj/machinery/light/rogue/smelter/bronze
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "bronze melter"
	desc = "An  object of humen make, this furnace is capable of making bronze or iron."
	icon_state = "brosmelter0"
	base_state = "brosmelter"
	anchored = TRUE
	density = TRUE
	maxore = 4
	climbable = FALSE

/obj/machinery/light/rogue/smelter/bronze/process()
	..()
	if(on)
		if(ore.len)
			if(cooking < 40)
				cooking++
				playsound(src.loc,'sound/misc/smelter_sound.ogg', 50, FALSE)
				actively_smelting = TRUE
			else
				if(cooking == 40)
					var/alloy //moving each alloy to it's own var allows for possible additions later
					var/bronzealloy
					for(var/obj/item/I in ore)
						if(I.smeltresult == /obj/item/ingot/tin)
							bronzealloy = bronzealloy + 1
						if(I.smeltresult == /obj/item/ingot/copper)
							bronzealloy = bronzealloy + 2
					if(bronzealloy == 7)
						testing("BRONZE ALLOYED")
						alloy = /obj/item/ingot/bronze
					else
						alloy = null

					if(alloy)
						// The smelting quality of all ores added together, divided by the number of ores, and then rounded to the lowest integer (this isn't done until after the for loop)
						var/floor_mean_quality = SMELTERY_LEVEL_SPOIL
						var/ore_deleted = 0
						for(var/obj/item/I in ore)
							floor_mean_quality += ore[I]
							ore_deleted += 1
							ore -= I
							qdel(I)
						floor_mean_quality = floor(floor_mean_quality/ore_deleted)
						for(var/i in 1 to maxore)
							var/obj/item/R = new alloy(src, floor_mean_quality)
							ore += R
					else
						for(var/obj/item/I in ore)
							if(I.smeltresult)
								var/obj/item/R = new I.smeltresult(src, ore[I])
								ore -= I
								ore += R
								qdel(I)

					playsound(src,'sound/misc/smelter_fin.ogg', 100, FALSE)
					visible_message(span_notice("\The [src] finished smelting."))
					maxore = initial(maxore)
					cooking = 41
					actively_smelting = FALSE

/obj/machinery/light/rogue/smelter/hiron
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "iron bloomery"
	desc = "An  object of humen make, this furnace is capable of making high quanities of iron."
	icon_state = "hironsmelter0"
	base_state = "hironsmelter"
	anchored = TRUE
	density = TRUE
	maxore = 6
	climbable = FALSE



/obj/machinery/light/rogue/smelter/hiron/process()
	..()
	if(on)
		if(ore.len)
			if(cooking < 45)
				cooking++
				playsound(src.loc,'sound/misc/smelter_sound.ogg', 50, FALSE)
				actively_smelting = TRUE
			else
				if(cooking == 45)
					for(var/obj/item/I in ore)
						if(I.smeltresult)
							var/obj/item/R = new I.smeltresult(src, ore[I])
							ore -= I
							ore += R
							qdel(I)

					playsound(src,'sound/misc/smelter_fin.ogg', 100, FALSE)
					visible_message(span_notice("\The [src] finished smelting."))
					maxore = initial(maxore)
					cooking = 46
					actively_smelting = FALSE
