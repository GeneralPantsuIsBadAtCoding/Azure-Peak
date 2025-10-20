/obj/item/twilight_ramrod
	name = "ramrod"
	icon = 'modular_twilight_axis/firearms/icons/arquebus_items.dmi'
	desc = "A ramrod used for reloading a firearm."
	icon_state = "ramrod"
	item_state = "ramrod"
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_SMALL

/obj/item/twilight_powderflask_empty
	name = "powderflask"
	icon = 'modular_twilight_axis/firearms/icons/arquebus_items.dmi'
	desc = "Пороховница, предназначенная для удобной перезарядки огнестрельного оружия. Сейчас не содержит пороха."
	icon_state = "powderflask"
	item_state = "powderflask"
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_SMALL
	grid_width = 64
	grid_height = 32

/obj/item/twilight_powderflask
	name = "powderflask"
	icon = 'modular_twilight_axis/firearms/icons/arquebus_items.dmi'
	desc = "Пороховница, предназначенная для удобной перезарядки огнестрельного оружия. Содержит обычный чёрный порох."
	var/gunpowder = "black gunpowder"
	var/charges = 30
	icon_state = "powderflask_black"
	item_state = "powderflask"
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_SMALL
	grid_width = 64
	grid_height = 32

/obj/item/twilight_powderflask/examine(mob/user)
	. = ..()
	switch(gunpowder)
		if("fyrepowder")
			. += span_bold("Поджигает цель при попадании.")
		if("thunderpowder")
			. += span_bold("Оглушает цель на короткое время при попадании.")
		if("corrosive gunpowder")
			. += span_bold("Покрывает цель кислотой, наносящей периодический урон броне и здоровью.")
		if("arcyne gunpowder")
			. += span_bold("Накладывает на цель онемение. Если у цели есть магический барьер, он будет мгновенно уничтожен.")
		if("terrorpowder")
			. += span_bold("Наносит удвоенный урон всем существам, не контролируемым игроком.")
	. += span_bold("Пороха осталось на [charges] перезарядок.")

/obj/item/twilight_powderflask/fyre
	name = "powderflask"
	desc = "Пороховница, предназначенная для удобной перезарядки огнестрельного оружия. Содержит огненный порох, наделяющий пули зажигательным эффектом."
	icon_state = "powderflask_fyre"
	gunpowder = "fyrepowder"
	charges = 16

/obj/item/twilight_powderflask/thunder
	name = "powderflask"
	desc = "Пороховница, предназначенная для удобной перезарядки огнестрельного оружия. Содержит громовой порох, наделяющий пули оглушающим эффектом."
	icon_state = "powderflask_thunder"
	gunpowder = "thunderpowder"
	charges = 16

/obj/item/twilight_powderflask/terror
	name = "powderflask"
	desc = "Пороховница, предназначенная для удобной перезарядки огнестрельного оружия. Содержит порох кошмара, делающий пули более смертоностными против тех, чья воля слаба."
	icon_state = "powderflask_terror"
	gunpowder = "terrorpowder"
	charges = 20

/obj/item/twilight_powderflask/corrosive
	name = "powderflask"
	desc = "Пороховница, предназначенная для удобной перезарядки огнестрельного оружия. Содержит коррозийный порох, наделяющий пули способностью разъедать броню цели."
	icon_state = "powderflask_corrosive"
	gunpowder = "corrosive gunpowder"
	charges = 10

/obj/item/twilight_powderflask/arcyne
	name = "powderflask"
	desc = "Пороховница, предназначенная для удобной перезарядки огнестрельного оружия. Содержит арканный порох, делающий оружие существенно эффективнее против магов."
	icon_state = "powderflask_arcyne"
	gunpowder = "arcyne gunpowder"
	charges = 10

/obj/effect/particle_effect/smoke/arquebus
	name = "smoke"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "smoke"
	pixel_x = -32
	pixel_y = -32
	opacity = FALSE
	layer = FLY_LAYER
	plane = GAME_PLANE_UPPER
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	animate_movement = 0
	amount = 4
	lifetime = 4
	opaque = FALSE

/obj/effect/particle_effect/smoke/arquebus/fyre
	color = "#A66945"

/obj/effect/particle_effect/smoke/arquebus/thunder
	color = "#5C355C"

/obj/effect/particle_effect/smoke/arquebus/terror
	color = "#423030"

/obj/effect/particle_effect/smoke/arquebus/corrosive
	color = "#7D905E"

/obj/effect/particle_effect/smoke/arquebus/arcyne
	color = "#C487C8"

/obj/item/gun/ballistic/twilight_firearm
	name = "Gunpowder weapon"
	desc = "IF YOU ARE SEEING THIS. REPORT THIS TO A DEV. "
	icon = 'modular_twilight_axis/firearms/icons/arquebus.dmi'
	icon_state = "arquebus"
	item_state = "arquebus"
	force = 10
	force_wielded = 15
	possible_item_intents = list(/datum/intent/mace/strike/wood)
	gripped_intents = list(/datum/intent/shoot/twilight_firearm, /datum/intent/arc/twilight_firearm, INTENT_GENERIC)
	internal_magazine = TRUE
	mag_type = /obj/item/ammo_box/magazine/internal/twilight_firearm
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_LONG
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	randomspread = 1
	spread = 0
	wdefense = 3
	can_parry = TRUE
	minstr = 6
	walking_stick = TRUE
	experimental_onback = TRUE
	cartridge_wording = "bullet"
	load_sound = 'modular_twilight_axis/firearms/sound/musketload.ogg'
	fire_sound = 'modular_twilight_axis/firearms/sound/arquefire.ogg'
	anvilrepair = null
	smeltresult = /obj/item/ingot/steel
	bolt_type = BOLT_TYPE_NO_BOLT
	casing_ejector = FALSE
	associated_skill = null
	//pickup_sound = 'sound/sheath_sounds/draw_from_holster.ogg'
	//sheathe_sound = 'sound/sheath_sounds/put_back_to_holster.ogg'
	var/spread_num = 10
	var/damfactor = 1
	var/critfactor = 1
	var/npcdamfactor = 1.3
	var/reloaded = FALSE
	var/silenced = FALSE
	var/load_time = 50
	var/gunpowder
	var/powder_per_reload = 1
	var/locktype = "Wheellock"
	var/match_delay = 10
	var/obj/item/twilight_ramrod/myrod = null

	//Advanced icon stuff
	var/advanced_icon				//Default icon
	var/advanced_icon_r				//Cocked
	var/advanced_icon_s				//Fuse spent
	var/advanced_icon_f				//Fuse lit
	var/advanced_icon_norod			//Ramrod removed
	var/advanced_icon_r_norod		//Cocked and ramrod removed

/obj/item/gun/ballistic/twilight_firearm/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 6,"nx" = 7,"ny" = 6,"wx" = -2,"wy" = 3,"ex" = 1,"ey" = 3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -43,"sturn" = 43,"wturn" = 30,"eturn" = -30, "nflip" = 0, "sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -2,"nx" = -5,"ny" = -1,"wx" = -8,"wy" = 2,"ex" = 8,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 1,"nturn" = -45,"sturn" = 45,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/gun/ballistic/twilight_firearm/Initialize()
	. = ..()
	if(locktype == "Wheellock")
		myrod = new /obj/item/twilight_ramrod(src)


/obj/item/gun/ballistic/twilight_firearm/shoot_live_shot(mob/living/user as mob|obj, pointblank = 0, mob/pbtarget = null, message = 1)
	if(silenced)
		fire_sound = "modular_twilight_axis/firearms/sound/umbra_fire.ogg"
	else
		switch(gunpowder)
			if("fyrepowder")
				fire_sound = pick("modular_twilight_axis/firearms/sound/fyrepowder/arquefire.ogg", "modular_twilight_axis/firearms/sound/fyrepowder/arquefire2.ogg", "modular_twilight_axis/firearms/sound/fyrepowder/arquefire3.ogg",
							"modular_twilight_axis/firearms/sound/fyrepowder/arquefire4.ogg", "modular_twilight_axis/firearms/sound/fyrepowder/arquefire5.ogg")
			if("thunderpowder")
				fire_sound = pick("modular_twilight_axis/firearms/sound/thunderpowder/arquefire.ogg", "modular_twilight_axis/firearms/sound/thunderpowder/arquefire2.ogg", "modular_twilight_axis/firearms/sound/thunderpowder/arquefire3.ogg",
							"modular_twilight_axis/firearms/sound/thunderpowder/arquefire4.ogg", "modular_twilight_axis/firearms/sound/thunderpowder/arquefire5.ogg")
			if("corrosive gunpowder")
				fire_sound = pick("modular_twilight_axis/firearms/sound/corrpowder/arquefire.ogg", "modular_twilight_axis/firearms/sound/corrpowder/arquefire2.ogg", "modular_twilight_axis/firearms/sound/corrpowder/arquefire3.ogg",
							"modular_twilight_axis/firearms/sound/corrpowder/arquefire4.ogg", "modular_twilight_axis/firearms/sound/corrpowder/arquefire5.ogg")
			if("arcyne gunpowder")
				fire_sound = pick("modular_twilight_axis/firearms/sound/arcynepowder/arquefire.ogg", "modular_twilight_axis/firearms/sound/arcynepowder/arquefire2.ogg", "modular_twilight_axis/firearms/sound/arcynepowder/arquefire3.ogg",
							"modular_twilight_axis/firearms/sound/arcynepowder/arquefire4.ogg", "modular_twilight_axis/firearms/sound/arcynepowder/arquefire5.ogg")
			if("terrorpowder")
				fire_sound = pick("modular_twilight_axis/firearms/sound/terrorpowder/arquefire.ogg", "modular_twilight_axis/firearms/sound/terrorpowder/arquefire2.ogg", "modular_twilight_axis/firearms/sound/terrorpowder/arquefire3.ogg",
							"modular_twilight_axis/firearms/sound/terrorpowder/arquefire4.ogg", "modular_twilight_axis/firearms/sound/terrorpowder/arquefire5.ogg")
			else
				fire_sound = pick("modular_twilight_axis/firearms/sound/arquefire.ogg", "modular_twilight_axis/firearms/sound/arquefire2.ogg", "modular_twilight_axis/firearms/sound/arquefire3.ogg",
							"modular_twilight_axis/firearms/sound/arquefire4.ogg", "modular_twilight_axis/firearms/sound/arquefire5.ogg")
	. = ..()

/obj/item/gun/ballistic/twilight_firearm/attack_right(mob/user)
	if(user.get_active_held_item())
		return
	else
		if(locktype == "Wheellock")
			if(myrod)
				playsound(src, "sound/items/sharpen_short1.ogg",  100, FALSE)
				to_chat(user, "<span class='warning'>I draw the ramrod from [src]!</span>")
				var/obj/item/twilight_ramrod/AM
				for(AM in src)
					user.put_in_hands(AM)
					myrod = null
				if(advanced_icon_norod)
					if(reloaded && advanced_icon_r_norod)
						icon = advanced_icon_r_norod
					else
						icon = advanced_icon_norod
			else
				to_chat(user, "<span class='warning'>There is no rod stowed in [src]!</span>")

/datum/intent/shoot/twilight_firarm
	chargedrain = 0

/datum/intent/shoot/twilight_firearm/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = chargetime
		//skill block
		newtime = newtime + 95
		newtime = newtime - (mastermob.get_skill_level(/datum/skill/combat/twilight_firearms) * 20)
		//per block
		newtime = newtime + 20
		newtime = newtime - ((mastermob.STAPER)*1.5)
		if(newtime > 0)
			return newtime
		else
			return 0.1
	return chargetime

/datum/intent/arc/twilight_firearm
	chargetime = 1
	chargedrain = 0

/datum/intent/arc/twilight_firearm/can_charge()
	if(mastermob && masteritem.wielded)
		if(!masteritem.wielded)
			return FALSE
/*		if(mastermob.get_num_arms(FALSE) < 2)
			return FALSE
		if(mastermob.get_inactive_held_item())
			return FALSE*/
		return TRUE

/datum/intent/arc/twilight_firearm/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = chargetime
		//skill block
		newtime = newtime + 90
		newtime = newtime - (mastermob.get_skill_level(/datum/skill/combat/twilight_firearms) * 20)
		//per block
		newtime = newtime + 20
		newtime = newtime - ((mastermob.STAPER)*1.5)
		if(newtime > 0)
			return newtime
		else
			return 1
	return chargetime

/obj/item/gun/ballistic/twilight_firearm/shoot_with_empty_chamber()
	playsound(src.loc, 'modular_twilight_axis/firearms/sound/musketcock.ogg', 100, FALSE)
	update_icon()

/obj/item/gun/ballistic/twilight_firearm/attack_self(mob/living/user)
	if(twohands_required)
		return
	if(altgripped || wielded) //Trying to unwield it
		ungrip(user)
		return
	if(alt_intents)
		altgrip(user)
	if(gripped_intents)
		wield(user)
	update_icon()

/obj/item/gun/ballistic/twilight_firearm/attackby(obj/item/A, mob/user, params)
	var/firearm_skill = (user?.mind ? user.get_skill_level(/datum/skill/combat/twilight_firearms) : 1)
	var/load_time_skill = load_time - (firearm_skill*5)

	if(istype(A, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/V = A
		if(chambered)
			to_chat(user, "<span class='warning'>There is already a [chambered.name] in [src]!</span>")
			return
		if(!gunpowder)
			to_chat(user, "<span class='warning'>You must fill [src] with gunpowder first!</span>")
			return
		if(V.caliber != magazine.caliber)
			to_chat(user, "<span class='warning'>The [V.name] doesn't fit into [src]!</span>")
			return
		if((loc == user) && (user.get_inactive_held_item() != src))
			return
		playsound(src, "modular_twilight_axis/firearms/sound/insert.ogg",  100, FALSE)
		user.visible_message("<span class='notice'>[user] forces a [V.name] down the barrel of [src].</span>")
		if(advanced_icon)
			if(!myrod && advanced_icon_norod)
				icon = advanced_icon_norod
			else
				icon = advanced_icon
		..()

	if(istype(A, /obj/item/twilight_powderflask))
		var/obj/item/twilight_powderflask/W = A
		if(gunpowder)
			user.visible_message("<span class='notice'>The [name] is already filled with gunpowder!</span>")
			return
		else if(W.charges < powder_per_reload)
			user.visible_message("<span class='notice'>The [W.name] doesn't contain enough gunpowder to reload [src]!</span>")
			return
		else
			switch(W.gunpowder)
				if("fyrepowder")
					playsound(src, "modular_twilight_axis/firearms/sound/fyrepowder/pour_powder.ogg",  100, FALSE)
				if("thunderpowder")
					playsound(src, "modular_twilight_axis/firearms/sound/thunderpowder/pour_powder.ogg",  100, FALSE)
				if("corrosive gunpowder")
					playsound(src, "modular_twilight_axis/firearms/sound/corrpowder/pour_powder.ogg",  100, FALSE)
				if("arcyne gunpowder")
					playsound(src, "modular_twilight_axis/firearms/sound/arcynepowder/pour_powder.ogg",  100, FALSE)
				if("terrorpowder")
					playsound(src, "modular_twilight_axis/firearms/sound/terrorpowder/pour_powder.ogg",  100, FALSE)
				else
					playsound(src, "modular_twilight_axis/firearms/sound/pour_powder.ogg",  100, FALSE)
			if(do_after(user, load_time_skill, src))
				user.visible_message("<span class='notice'>[user] fills [src] with [W.gunpowder].</span>")
				gunpowder = W.gunpowder
				W.charges = W.charges - powder_per_reload
				if(W.charges <= 0)
					qdel(W)
					var/obj/item/twilight_powderflask_empty/E = new /obj/item/twilight_powderflask_empty(get_turf(user))
					user.put_in_hands(E)
			return
	if(istype(A, /obj/item/twilight_ramrod))
		if(locktype == "Wheellock")
			var/obj/item/twilight_ramrod/R=A
			if(!reloaded)
				if(chambered)
					user.visible_message("<span class='notice'>[user] begins ramming the [R.name] down the barrel of [src].</span>")
					playsound(src, "modular_twilight_axis/firearms/sound/ramrod.ogg",  100, FALSE)
					if(do_after(user, load_time_skill, src))
						user.visible_message("<span class='notice'>[user] has finished reloading [src].</span>")
						reloaded = TRUE
						if(advanced_icon_r_norod)
							icon = advanced_icon_r_norod
					return
			if(reloaded && !myrod)
				user.transferItemToLoc(R, src)
				myrod = R
				playsound(src, "modular_twilight_axis/firearms/sound/musketload.ogg",  100, FALSE)
				user.visible_message("<span class='notice'>[user] stows the [R.name] under the barrel of [src].</span>")
				if(advanced_icon)
					if(reloaded && advanced_icon_r)
						icon = advanced_icon_r
					else
						icon = advanced_icon
			if(!chambered && !myrod)
				user.transferItemToLoc(R, src)
				myrod = R
				playsound(src, "modular_twilight_axis/firearms/sound/musketload.ogg",  100, FALSE)
				user.visible_message("<span class='notice'>[user] stows the [R.name] under the barrel of [src] without chambering it.</span>")
				if(advanced_icon)
					if(reloaded && advanced_icon_r)
						icon = advanced_icon_r
					else
						icon = advanced_icon
			if(!myrod == null)
				to_chat(user, span_warning("There's already a [R.name] inside of the [name]."))
				return
	if(istype(A, /obj/item/natural/bundle/fibers))
		var/obj/item/natural/bundle/fibers/W = A
		if(locktype == "Matchlock")
			if(!reloaded)
				if(chambered)
					user.visible_message("<span class='notice'>[user] begins attaching the fuse to [src].</span>")
					playsound(src, "sound/foley/bandage.ogg",  100, FALSE)
					if(do_after(user, (load_time_skill * 0.8), src))
						user.visible_message("<span class='notice'>[user] has finished reloading [src].</span>")
						W.amount = W.amount - 1
						if(W.amount == 1)
							new /obj/item/natural/fibers(get_turf(user))
							qdel(W)
						reloaded = TRUE
						if(advanced_icon_r)
							icon = advanced_icon_r
					return
	if(istype(A, /obj/item/natural/fibers))
		if(locktype == "Matchlock")
			if(!reloaded)
				if(chambered)
					user.visible_message("<span class='notice'>[user] begins attaching the fuse to [src].</span>")
					playsound(src, "sound/foley/bandage.ogg",  100, FALSE)
					if(do_after(user, (load_time_skill * 0.8), src))
						user.visible_message("<span class='notice'>[user] has finished reloading [src].</span>")
						qdel(A)
						reloaded = TRUE
						if(advanced_icon_r)
							icon = advanced_icon_r
					return
	if(istype(A, /obj/item/rogueweapon/hammer))
		var/repair_percent = 0.025 // 2.5% Repairing per hammer smack
		if(locate(/obj/machinery/anvil) in src.loc)
			repair_percent *= 2 // Double the repair amount if we're using an anvil
		var/exp_gained = 0
		var/repair_skill = (user?.mind ? user.get_skill_level(/datum/skill/craft/engineering) : 1)
		if((obj_integrity >= max_integrity) || !isturf(src.loc))
			return

		if(!src.ontable())
			to_chat(user, span_warning("I should put this on a table or an anvil first."))
			return

		if(repair_skill <= 0)
			if(HAS_TRAIT(user, TRAIT_SQUIRE_REPAIR))
				if(locate(/obj/machinery/anvil) in src.loc)
					repair_percent = 0.035
				//Squires can repair on tables, but less efficiently
				else if(src.ontable())
					repair_percent = 0.015
			else if(prob(30))
				repair_percent = 0.01
			else
				repair_percent = 0
		else
			repair_percent *= repair_skill

		playsound(src,'modular_twilight_axis/firearms/sound/arq_repair.ogg', 40, FALSE)
		if(repair_percent)
			repair_percent *= max_integrity
			exp_gained = min(obj_integrity + repair_percent, max_integrity) - obj_integrity
			obj_integrity = min(obj_integrity + repair_percent, max_integrity)
			if(repair_percent == 0.01) // If an inexperienced repair attempt has been successful
				to_chat(user, span_warning("You fumble your way into slightly repairing [src]."))
			else
				user.visible_message(span_info("[user] repairs [src]!"))
			if(obj_broken && obj_integrity == max_integrity)
				src.obj_fix()
			adjust_experience(user, /datum/skill/craft/engineering, exp_gained/2) //We gain as much exp as we fix divided by 2
			return
		else
			user.visible_message(span_warning("[user] fumbles trying to repair [src]!"))
			if(do_after(user, CLICK_CD_MELEE, target = src))
				attack_obj(src, user)
			return

/obj/item/gun/ballistic/twilight_firearm/examine(mob/user)
	. = ..()
	switch(locktype)
		if("Wheellock")
			. += span_info("Это оружие оснащено колесцовым замком — оно не требует фитиля, но перед выстрелом пороховой заряд необходимо уплотнить шомполом.")
		if("Matchlock")
			. += span_info("Это оружие оснащено фитильным замком — чтобы его взвести, необходимо установить фитиль.")
	if(gunpowder)
		if(chambered)
			if(reloaded)
				. += span_bold("Взведено и готово к стрельбе.")
			else
				. += span_bold("Внутри оружия видна пуля, но оно не взведено.")
		else
			. += span_bold("Через запальное отверстие виден пороховой заряд, но пуля не установлена.")
	else
		. += span_bold("Не заряжено.")

/obj/item/gun/ballistic/twilight_firearm/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)

	var/accident_chance = 0
	var/firearm_skill = (user?.mind ? user.get_skill_level(/datum/skill/combat/twilight_firearms) : 1)
	var/turf/knockback = get_ranged_target_turf(user, turn(user.dir, 180), rand(1,2))
	spread = (spread_num - firearm_skill)
	switch(firearm_skill)
		if(0)
			accident_chance = 80
		if(1)
			accident_chance = 50
		if(2)
			accident_chance = 30
		if(3)
			accident_chance = 10
		if(4)
			accident_chance = 10
		else
			accident_chance = 0
	if(user.client)
		if(user.client.chargedprog >= 100)
			spread = 0
		else
			spread = 150 - (150 * (user.client.chargedprog / 100))
	else
		spread = 0
	for(var/obj/item/ammo_casing/CB in get_ammo_list(FALSE, TRUE))
		var/obj/projectile/bullet/BB = CB.BB
		BB.damage *= damfactor * (user.STAPER > 10 ? user.STAPER / 10 : 1)
		BB.critfactor *= critfactor
		BB.gunpowder_npc_critfactor *= npcdamfactor
		BB.gunpowder = gunpowder
	reloaded = FALSE
	if(advanced_icon)
		if(!myrod && advanced_icon_norod)
			icon = advanced_icon_norod
		else
			icon = advanced_icon
	spark_act()
	if(locktype == "Wheellock")
		..()
		if(!silenced)
			switch(gunpowder)
				if("fyrepowder")
					spawn (5)
						new/obj/effect/particle_effect/smoke/arquebus/fyre(get_ranged_target_turf(user, user.dir, 1))
					spawn (10)
						new/obj/effect/particle_effect/smoke/arquebus/fyre(get_ranged_target_turf(user, user.dir, 2))
					spawn (16)
						new/obj/effect/particle_effect/smoke/arquebus/fyre(get_ranged_target_turf(user, user.dir, 1))
				if("thunderpowder")
					spawn (5)
						new/obj/effect/particle_effect/smoke/arquebus/thunder(get_ranged_target_turf(user, user.dir, 1))
					spawn (10)
						new/obj/effect/particle_effect/smoke/arquebus/thunder(get_ranged_target_turf(user, user.dir, 2))
					spawn (16)
						new/obj/effect/particle_effect/smoke/arquebus/thunder(get_ranged_target_turf(user, user.dir, 1))
				if("corrosive gunpowder")
					spawn (5)
						new/obj/effect/particle_effect/smoke/arquebus/corrosive(get_ranged_target_turf(user, user.dir, 1))
					spawn (10)
						new/obj/effect/particle_effect/smoke/arquebus/corrosive(get_ranged_target_turf(user, user.dir, 2))
					spawn (16)
						new/obj/effect/particle_effect/smoke/arquebus/corrosive(get_ranged_target_turf(user, user.dir, 1))
				if("arcyne gunpowder")
					spawn (5)
						new/obj/effect/particle_effect/smoke/arquebus/arcyne(get_ranged_target_turf(user, user.dir, 1))
					spawn (10)
						new/obj/effect/particle_effect/smoke/arquebus/arcyne(get_ranged_target_turf(user, user.dir, 2))
					spawn (16)
						new/obj/effect/particle_effect/smoke/arquebus/arcyne(get_ranged_target_turf(user, user.dir, 1))
				if("terrorpowder")
					spawn (5)
						new/obj/effect/particle_effect/smoke/arquebus/terror(get_ranged_target_turf(user, user.dir, 1))
					spawn (10)
						new/obj/effect/particle_effect/smoke/arquebus/terror(get_ranged_target_turf(user, user.dir, 2))
					spawn (16)
						new/obj/effect/particle_effect/smoke/arquebus/terror(get_ranged_target_turf(user, user.dir, 1))
				else
					spawn (5)
						new/obj/effect/particle_effect/smoke/arquebus(get_ranged_target_turf(user, user.dir, 1))
					spawn (10)
						new/obj/effect/particle_effect/smoke/arquebus(get_ranged_target_turf(user, user.dir, 2))
					spawn (16)
						new/obj/effect/particle_effect/smoke/arquebus(get_ranged_target_turf(user, user.dir, 1))
		for(var/mob/M in range(5, user))
			if(!M.stat)
				shake_camera(M, 3, 1)

		gunpowder = null
		if(prob(accident_chance))
			user.flash_fullscreen("whiteflash")
			user.apply_damage(rand(5,15), BURN, pick(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_NOSE, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND))
			user.visible_message("<span class='danger'>[user] accidentally burnt themselves while firing the [src].</span>")
			user.emote("painscream")
			if(prob(60) && firearm_skill < 4)
				user.dropItemToGround(src)
				user.Knockdown(rand(15,30))
				user.Immobilize(30)
		if(prob(accident_chance))
			user.visible_message("<span class='danger'>[user] is knocked back by the recoil!</span>")
			user.throw_at(knockback, rand(1,2), 7)
			if(prob(accident_chance) && firearm_skill < 4)
				user.dropItemToGround(src)
				user.Knockdown(rand(15,30))
				user.Immobilize(30)
			if(firearm_skill < 3 && prob(50))
				var/def_zone = "[(user.active_hand_index == 2) ? "r" : "l" ]_arm"
				var/obj/item/bodypart/BP = user.get_bodypart(def_zone)
				BP.add_wound(/datum/wound/dislocation)
	else if(locktype == "Matchlock")
		if(advanced_icon_f)
			icon = advanced_icon_f
		playsound(src, "modular_twilight_axis/firearms/sound/fuse.ogg", 100, FALSE)
		spawn(match_delay)
			..()
			if(advanced_icon_s)
				icon = advanced_icon_s
			if(!silenced)
				switch(gunpowder)
					if("fyrepowder")
						spawn (1)
							new/obj/effect/particle_effect/smoke/arquebus/fyre(get_ranged_target_turf(user, user.dir, 1))
						spawn (5)
							new/obj/effect/particle_effect/smoke/arquebus/fyre(get_ranged_target_turf(user, user.dir, 2))
						spawn (12)
							new/obj/effect/particle_effect/smoke/arquebus/fyre(get_ranged_target_turf(user, user.dir, 1))
					if("thunderpowder")
						spawn (1)
							new/obj/effect/particle_effect/smoke/arquebus/thunder(get_ranged_target_turf(user, user.dir, 1))
						spawn (5)
							new/obj/effect/particle_effect/smoke/arquebus/thunder(get_ranged_target_turf(user, user.dir, 2))
						spawn (12)
							new/obj/effect/particle_effect/smoke/arquebus/thunder(get_ranged_target_turf(user, user.dir, 1))
					if("corrosive gunpowder")
						spawn (1)
							new/obj/effect/particle_effect/smoke/arquebus/corrosive(get_ranged_target_turf(user, user.dir, 1))
						spawn (5)
							new/obj/effect/particle_effect/smoke/arquebus/corrosive(get_ranged_target_turf(user, user.dir, 2))
						spawn (12)
							new/obj/effect/particle_effect/smoke/arquebus/corrosive(get_ranged_target_turf(user, user.dir, 1))
					if("arcyne gunpowder")
						spawn (1)
							new/obj/effect/particle_effect/smoke/arquebus/arcyne(get_ranged_target_turf(user, user.dir, 1))
						spawn (5)
							new/obj/effect/particle_effect/smoke/arquebus/arcyne(get_ranged_target_turf(user, user.dir, 2))
						spawn (12)
							new/obj/effect/particle_effect/smoke/arquebus/arcyne(get_ranged_target_turf(user, user.dir, 1))
					if("terrorpowder")
						spawn (1)
							new/obj/effect/particle_effect/smoke/arquebus/terror(get_ranged_target_turf(user, user.dir, 1))
						spawn (5)
							new/obj/effect/particle_effect/smoke/arquebus/terror(get_ranged_target_turf(user, user.dir, 2))
						spawn (12)
							new/obj/effect/particle_effect/smoke/arquebus/terror(get_ranged_target_turf(user, user.dir, 1))
					else
						spawn (1)
							new/obj/effect/particle_effect/smoke/arquebus(get_ranged_target_turf(user, user.dir, 1))
						spawn (5)
							new/obj/effect/particle_effect/smoke/arquebus(get_ranged_target_turf(user, user.dir, 2))
						spawn (12)
							new/obj/effect/particle_effect/smoke/arquebus(get_ranged_target_turf(user, user.dir, 1))
			gunpowder = null
			for(var/mob/M in range(5, user))
				if(!M.stat)
					shake_camera(M, 3, 1)
			if(prob(accident_chance))
				user.flash_fullscreen("whiteflash")
				user.apply_damage(rand(5,15), BURN, pick(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_NOSE, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND))
				user.visible_message(span_danger("[user] accidentally burnt themselves while firing the [src]."))
				user.emote("painscream")
				if(prob(60))
					user.dropItemToGround(src)
					user.Knockdown(rand(15,30))
					user.Immobilize(30)
			if(prob(accident_chance))
				user.visible_message(span_danger("[user] is knocked back by the recoil!"))
				user.throw_at(knockback, rand(1,2), 7)
				if(prob(accident_chance))
					user.dropItemToGround(src)
					user.Knockdown(rand(15,30))
					user.Immobilize(30)
					if(firearm_skill <= 2 && prob(50))
						var/def_zone = "[(user.active_hand_index == 2) ? "r" : "l" ]_arm"
						var/obj/item/bodypart/BP = user.get_bodypart(def_zone)
						BP.add_wound(/datum/wound/dislocation)

/obj/item/gun/ballistic/twilight_firearm/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
/*	if(!reloaded)
		to_chat(user, span_warning("The [src] is not properly loaded yet!"))
		return*/

/obj/item/gun/ballistic/twilight_firearm/can_shoot()
	if (!reloaded)
		return FALSE
	return ..()

/obj/item/ammo_box/magazine/internal/twilight_firearm
	name = "firearm internal magazine"
	ammo_type = /obj/item/ammo_casing/caseless/twilight_lead
	caliber = "lead_sphere"
	max_ammo = 1
	start_empty = TRUE

/obj/item/gun/ballistic/twilight_firearm/arquebus
	name = "arquebus rifle"
	desc = "Пороховое оружие второго поколения, стреляющее бронебойными свинцовыми пулями."
	icon = 'modular_twilight_axis/firearms/icons/arquebus.dmi'
	icon_state = "arquebus"
	item_state = "arquebus"

/obj/item/gun/ballistic/twilight_firearm/arquebus/bayonet
	name = "arquebus rifle"
	desc = "Пороховое оружие второго поколения, стреляющее бронебойными свинцовыми пулями. Оснащена штыком для использования в ближнем бою."
	icon = 'modular_twilight_axis/firearms/icons/arquebusbaoynet.dmi'
	gripped_intents = list(/datum/intent/shoot/twilight_firearm, /datum/intent/arc/twilight_firearm, INTENT_GENERIC, /datum/intent/spear/thrust/militia)
	wdefense = 5
	associated_skill = /datum/skill/combat/polearms

/obj/item/gun/ballistic/twilight_firearm/arquebus/bayonet/pre_attack(atom/A, mob/living/user, params)
	if(!user.used_intent.tranged)
		if(!istype(A, /obj/structure/fluff/statue/tdummy))
			var/firearm_skill = (user?.mind ? user.get_skill_level(/datum/skill/combat/twilight_firearms) : 0)
			var/polearms_skill = (user?.mind ? user.get_skill_level(/datum/skill/combat/polearms) : 1)
			if(firearm_skill > polearms_skill)
				src.associated_skill = /datum/skill/combat/twilight_firearms
			else
				src.associated_skill = /datum/skill/combat/polearms
		else
			src.associated_skill = /datum/skill/combat/polearms
	. = ..()

/obj/item/gun/ballistic/twilight_firearm/arquebus/decorated
	name = "decorated arquebus rifle"
	desc = "Настоящее произведение искусства в обличии огнестрельного оружия. Приклад и цевье аркебузы украшены золотыми пластинами и инкрустированным рубином, а на стволе выбита надпись: «Взгляните на мои деянья и дрожите»."
	icon = 'modular_twilight_axis/firearms/icons/decorated_arquebus.dmi'

/obj/item/gun/ballistic/twilight_firearm/arquebus_pistol
	name = "arquebus pistol"
	desc = "Небольшое пороховое оружие, стреляющее бронебойными свинцовыми пулями. Меньшая длина ствола негативно сказывается на огневой мощи, но дизайн пистоля более компактный, и его можно носить на бедре."
	icon = 'modular_twilight_axis/firearms/icons/pistol/pistol.dmi'
	icon_state = "pistol"
	item_state = "pistol"
	force = 10
	possible_item_intents = list(/datum/intent/shoot/twilight_firearm, /datum/intent/arc/twilight_firearm, /datum/intent/mace/strike/wood)
	gripped_intents = null
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_HIP
	walking_stick = FALSE
	bigboy = FALSE
	gripsprite = FALSE
	cartridge_wording = "bullet"
	damfactor = 0.7
	critfactor = 0.7
	wdefense = 0
	advanced_icon = 'modular_twilight_axis/firearms/icons/pistol/pistol.dmi'
	advanced_icon_r = 'modular_twilight_axis/firearms/icons/pistol/pistol_r.dmi'
	advanced_icon_norod	= 'modular_twilight_axis/firearms/icons/pistol/pistol_norod.dmi'
	advanced_icon_r_norod = 'modular_twilight_axis/firearms/icons/pistol/pistol_r_norod.dmi'

/obj/item/gun/ballistic/twilight_firearm/arquebus_pistol/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 30,"sturn" = -30,"wturn" = -30,"eturn" = 30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/gun/ballistic/twilight_firearm/arquebus_pistol/umbra
	name = "Umbra"
	desc = "Компактное огнестрельное оружие отавианского производства. Ствол изготовлен из вороненой стали, на которую нанесены несколько простых рун. Благодаря необычной конструкции и рунической магии, Умбра стреляет практически бесшумно, что делает её идеальным выбором для агентов Инквизиции."
	silenced = TRUE
	critfactor = 1
	icon = 'modular_twilight_axis/firearms/icons/umbra/pistol.dmi'
	advanced_icon = 'modular_twilight_axis/firearms/icons/umbra/pistol.dmi'
	advanced_icon_r = 'modular_twilight_axis/firearms/icons/umbra/pistol_r.dmi'
	advanced_icon_norod	= 'modular_twilight_axis/firearms/icons/umbra/pistol_norod.dmi'
	advanced_icon_r_norod = 'modular_twilight_axis/firearms/icons/umbra/pistol_r_norod.dmi'

/obj/item/gun/ballistic/twilight_firearm/handgonne
	name = "culverin"
	desc = "Тяжелое пороховое оружие, стреляющее крупными свинцовыми ядрами. Важен не размер ствола, а размер отверстия, что он делает в вашем противнике."
	icon = 'modular_twilight_axis/firearms/icons/handgonne/handgonne.dmi'
	icon_state = "handgonne"
	item_state = "handgonne"
	mag_type = /obj/item/ammo_box/magazine/internal/twilight_firearm/handgonne
	cartridge_wording = "cannonball"
	locktype = "Matchlock"
	advanced_icon = 'modular_twilight_axis/firearms/icons/handgonne/handgonne.dmi'
	advanced_icon_r = 'modular_twilight_axis/firearms/icons/handgonne/handgonne_r.dmi'
	advanced_icon_f	= 'modular_twilight_axis/firearms/icons/handgonne/handgonne_f.dmi'
	advanced_icon_s = 'modular_twilight_axis/firearms/icons/handgonne/handgonne_s.dmi'
	npcdamfactor = 1

/obj/item/ammo_box/magazine/internal/twilight_firearm/handgonne
	name = "handgonne internal magazine"
	ammo_type = /obj/item/ammo_casing/caseless/twilight_cannonball
	caliber = "cannonball"
	max_ammo = 1
	start_empty = TRUE

/obj/item/gun/ballistic/twilight_firearm/flintgonne
	name = "hakenbüchse"
	desc = "Пороховое оружие первого поколения, массово изготавливаемое Грензельхофтом. Изготавливается из дешевых, быстро изнашивающихся материалов, что негативно сказывается на убойности."
	icon = 'modular_twilight_axis/firearms/icons/flintgonne.dmi'
	icon_state = "flintgonne"
	item_state = "flintgonne"
	gripped_intents = list(/datum/intent/shoot/twilight_firearm/flintgonne, /datum/intent/arc/twilight_firearm/flintgonne, INTENT_GENERIC)
	damfactor = 0.7
	critfactor = 0.7

/datum/intent/shoot/twilight_firearm/flintgonne/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = chargetime
		newtime = newtime + 105
		newtime = newtime - (mastermob.get_skill_level(/datum/skill/combat/twilight_firearms) * 20)
		newtime = newtime + 20
		newtime = newtime - ((mastermob.STAPER)*1.5)
		if(newtime > 0)
			return newtime
		else
			return 5
	return chargetime

/datum/intent/arc/twilight_firearm/flintgonne/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = chargetime
		newtime = newtime + 100
		newtime = newtime - (mastermob.get_skill_level(/datum/skill/combat/twilight_firearms) * 20)
		newtime = newtime + 20
		newtime = newtime - ((mastermob.STAPER)*1.5)
		if(newtime > 0)
			return newtime
		else
			return 1
	return chargetime

/obj/item/gun/ballistic/twilight_firearm/barker
	name = "barker"
	desc = "Один из первых образцов огнестрельного оружия, созданный отавийскими мастерами в начале позапрошлого века. Ввиду низкой мощности и точности, ныне используется преимущественно охотниками."
	icon = 'modular_twilight_axis/firearms/icons/barker.dmi'
	icon_state = "barker"
	item_state = "barker"
	gripped_intents = list(/datum/intent/shoot/twilight_firearm/flintgonne, /datum/intent/arc/twilight_firearm/flintgonne, INTENT_GENERIC)
	locktype = "Matchlock"
	damfactor = 0.7
	critfactor = 0.3
	npcdamfactor = 2.5
	match_delay = 4

/obj/item/gun/ballistic/twilight_firearm/handgonne/purgatory
	name = "Purgatory"
	desc = "Передовое огнестрельное оружие отавианского ордена Чёрного Пороха, завоевашее зловещую славу на поле боя из-за своей разрушительной мощи, обеспечиваемой двойным зарядом пороха и большим количеством картечи в залпе. Эта ручная пушка вступает в игру, когда одиночного довода против ереси просто недостаточно."
	icon = 'modular_twilight_axis/firearms/icons/purgatory/purgatory.dmi'
	icon_state = "purgatory"
	item_state = "purgatory"
	mag_type = /obj/item/ammo_box/magazine/internal/twilight_firearm/handgonne/purgatory
	advanced_icon = 'modular_twilight_axis/firearms/icons/purgatory/purgatory.dmi'
	advanced_icon_r = 'modular_twilight_axis/firearms/icons/purgatory/purgatory_r.dmi'
	advanced_icon_f	= 'modular_twilight_axis/firearms/icons/purgatory/purgatory_f.dmi'
	advanced_icon_s = 'modular_twilight_axis/firearms/icons/purgatory/purgatory_s.dmi'
	powder_per_reload = 2
	gripped_intents = list(/datum/intent/shoot/twilight_firearm, /datum/intent/arc/twilight_firearm, INTENT_GENERIC, /datum/intent/spear/thrust/militia)
	associated_skill = /datum/skill/combat/twilight_firearms
	is_silver = TRUE
	force = 15
	force_wielded = 20
	wdefense = 5
	match_delay = 8

/obj/item/ammo_box/magazine/internal/twilight_firearm/handgonne/purgatory
	name = "purgatory internal magazine"
	caliber = "otavian grapeshot"

/obj/item/gun/ballistic/twilight_firearm/handgonne/purgatory/ComponentInitialize()
	AddComponent(\
		/datum/component/silverbless,\
		pre_blessed = BLESSING_PSYDONIAN,\
		silver_type = SILVER_PSYDONIAN,\
		added_force = 0,\
		added_blade_int = 0,\
		added_int = 0,\
		added_def = 2,\
	)
