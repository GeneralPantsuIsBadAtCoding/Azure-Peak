/obj/item/roguemachine/navigator
	name = "navigator"
	desc = "A machine that attracts the attention of trading balloons."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "ballooner"
	density = TRUE
	blade_dulling = DULLING_BASH
	var/next_airlift
	max_integrity = 0
	anchored = TRUE
	w_class = WEIGHT_CLASS_GIGANTIC

/obj/structure/roguemachine/balloon_pad
	name = ""
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = ""
	density = FALSE
	layer = BELOW_OBJ_LAYER
	anchored = TRUE

/obj/item/roguemachine/navigator/attack_hand(mob/living/user)
	if(!anchored)
		return ..()
	user.changeNext_move(CLICK_CD_INTENTCAP)

	var/contents

	contents += "<center>MERCHANT'S GUILD<BR>"
	contents += "--------------<BR>"
	contents += "Next Balloon: [time2text((next_airlift - world.time), "mm:ss")]</center><BR>"

	if(!user.can_read(src, TRUE))
		contents = stars(contents)
	var/datum/browser/popup = new(user, "VENDORTHING", "", 370, 300)
	popup.set_content(contents)
	popup.open()

/obj/item/roguemachine/navigator/update_icon()
	if(!anchored)
		w_class = WEIGHT_CLASS_BULKY
		set_light(0)
		return
	w_class = WEIGHT_CLASS_GIGANTIC
	set_light(2, 2, 2, l_color = "#1b7bf1")

/obj/item/roguemachine/navigator/Initialize()
	. = ..()
	if(anchored)
		START_PROCESSING(SSroguemachine, src)
	update_icon()
	for(var/X in GLOB.alldirs)
		var/T = get_step(src, X)
		if(!T)
			continue
		new /obj/structure/roguemachine/balloon_pad(T)

/obj/item/roguemachine/navigator/Destroy()
	STOP_PROCESSING(SSroguemachine, src)
	set_light(0)
	return ..()

/obj/item/roguemachine/navigator/process()
	if(!anchored)
		return TRUE
	if(world.time > next_airlift)
		next_airlift = world.time + rand(2 MINUTES, 3 MINUTES)
#ifdef TESTSERVER
		next_airlift = world.time + 5 SECONDS
#endif
		var/play_sound = FALSE
		for(var/D in GLOB.alldirs)
			var/budgie = 0
			var/turf/T = get_step(src, D)
			if(!T)
				continue
			var/obj/structure/roguemachine/balloon_pad/E = locate() in T
			if(!E)
				continue
			for(var/obj/I in T)
				if(I.anchored || !isturf(I.loc) || istype(I, /obj/item/roguecoin))
					continue
				var/prize = I.get_real_price()
				if(prize >= 1)
					play_sound=TRUE
					budgie += prize
					I.visible_message(span_warning("[I] is sucked into the air!"))
					qdel(I)
			budgie = round(budgie)
			record_round_statistic(STATS_TRADE_VALUE_EXPORTED, budgie)
			if(budgie > 0)
				play_sound=TRUE
				E.budget2change(budgie)
				budgie = 0
		if(play_sound)
			playsound(src.loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
