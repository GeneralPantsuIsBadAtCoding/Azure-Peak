/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock
	name = "runelock pistol"
	desc = "Крайне смертоностное оружие. Использует руническую магию вместо пороха."
	icon = 'modular_twilight_axis/firearms/icons/32.dmi'
	icon_state = "pistol2"
	var/icon_state_ready = "pistol2-1"
	var/default_icon_state = "pistol2"
	item_state = "pistol2"
	possible_item_intents = list(/datum/intent/shoot/twilight_runelock, /datum/intent/arc/twilight_runelock, INTENT_GENERIC)
	mag_type = /obj/item/ammo_box/magazine/internal/shot/twilight_runelock
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_BULKY
	spread = 10
	recoil = 3
	associated_skill = /datum/skill/combat/twilight_firearms
	force = 10
	var/cocked = FALSE
	cartridge_wording = "runed sphere"
	load_sound = 'modular_twilight_axis/firearms/sound/musketload.ogg'
	fire_sound = 'modular_twilight_axis/firearms/sound/musketfire2.ogg'
	vary_fire_sound = TRUE
	fire_sound_volume = 200
	anvilrepair = null
	smeltresult = /obj/item/ingot/steel
	/// Chance for the weapon to misfire
	var/misfire_chance = 0
	/// Reload time, in SECONDS
	var/reload_time = 8
	damfactor = 0.7
	var/critfactor = 0.7
	var/rangefactor = 1

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 30,"sturn" = -30,"wturn" = -30,"eturn" = 30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/shoot_with_empty_chamber()
	if(cocked)
		playsound(src.loc, 'modular_twilight_axis/firearms/sound/musketcock.ogg', 100, FALSE)
		cocked = FALSE
		icon_state = initial(icon_state)
		update_icon()

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/attack_self(mob/living/user)
	if(twohands_required)
		return
	if(altgripped || wielded) //Trying to unwield it
		ungrip(user)
		return
	if(!cocked)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(HAS_TRAIT(H, TRAIT_INQUISITION) || (H.STAINT >= 15) || (H.merctype == 10))
				to_chat(H, span_info("I ready the runelock to be fired..."))
				var/adj_reload_time = reload_time
				if(H.mind)
					var/skill = H.get_skill_level(/datum/skill/combat/twilight_firearms)
					if(skill)
						adj_reload_time = reload_time / skill
				if(move_after(H, adj_reload_time SECONDS, target = H))
					playsound(H, 'modular_twilight_axis/firearms/sound/musketcock.ogg', 100, FALSE)
					cocked = TRUE
			else
				to_chat(H, "<span class='warning'>Я совершенно не понимаю, как этим пользоваться!</span>")
		else
			to_chat(user, "<span class='warning'>Я совершенно не понимаю, как этим пользоваться!</span>")
	else
		if(alt_intents)
			altgrip(user)
		if(gripped_intents)
			wield(user)
	update_icon()

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/update_icon()
	..()
	if(cocked && icon_state_ready)
		icon_state = icon_state_ready
		item_state = icon_state_ready
	else
		icon_state = default_icon_state
		item_state = default_icon_state
	if(!ismob(loc))
		return
	var/mob/M = loc
	M.update_inv_hands()

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/ammo_box) || istype(A, /obj/item/ammo_casing))
		if(cocked)
			if((loc == user) && (user.get_inactive_held_item() != src) && (user.get_active_held_item() != src))
				return
			..()
		else
			to_chat(user, span_warning("I need to cock the runelock first!"))
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

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/u = user
		if(HAS_TRAIT(u, TRAIT_INQUISITION) || (u.STAINT >= 15) || (u.merctype == 10))
			. += span_info("Это оружие оснащено руническим замком — для стрельбы достаточно взвести курок, но зарядить его можно лишь специальными рунными пулями, изготавливаемыми из черной стали или серебра.")
			if(cocked)
				if(chambered)
					. += span_bold("Взведено и готово к стрельбе.")
				else
					. += span_bold("Руны напитаны энергией, но пуля не установлена.")
			else
				. += span_bold("Не заряжено.")
		else
			. += span_info("Конструкция замка, установленного на этом оружии, вам незнакома.")

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/process_fire/(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	var/skill = user.get_skill_level(/datum/skill/combat/twilight_firearms)
	if(skill)
		misfire_chance = max(0, misfire_chance - (skill * 2))
		spread = max(3, spread / skill)
	if(prob(misfire_chance))
		to_chat(user, span_warning("The [name] misfires!"))
		explosion(src, light_impact_range = 2, heavy_impact_range = 1, smoke = TRUE, soundin = 'sound/misc/explode/bomb.ogg')
		qdel(src)
		return
	for(var/obj/item/ammo_casing/CB in get_ammo_list(FALSE, TRUE))
		var/obj/projectile/bullet/BB = CB.BB
		BB.range *= rangefactor
		BB.critfactor *= critfactor
		BB.damage *= damfactor * (user.STAPER > 10 ? user.STAPER / 10 : 1)
	cocked = FALSE
	update_icon()
	var/dir = get_dir(src, target)
	var/datum/effect_system/smoke_spread/smoke = new
	smoke.set_up(1, get_step(src, dir))
	smoke.start()
	..()

/obj/item/ammo_box/magazine/internal/shot/twilight_runelock
	ammo_type = /obj/item/ammo_casing/caseless/twilight_lead/runelock
	caliber = "runed_sphere"
	max_ammo = 1
	start_empty = TRUE

/datum/intent/shoot/twilight_runelock
	chargetime = 0
	charging_slowdown = 0

/datum/intent/arc/twilight_runelock
	chargetime = 1
	chargedrain = 0

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle
	name = "Doomsdae"
	desc = "Реликвия новой эпохи, созданная для войны, что положит конец истории мироздания, какой мы её знаем. Изготовленная отавианскими мастерами артефакторики, и зачарованная рунными магами Отавы, эта руническая винтовка - оружие, что сокрушит легионы тьмы в Конце Времен. Руны нанесены на ствол оружия кровью еретиков, поплатившихся за свое предательство истинной веры своими жизнями."
	icon = 'modular_twilight_axis/firearms/icons/runelock_rifle.dmi'
	icon_state = "runelock"
	icon_state_ready = "runelock_loaded"
	default_icon_state = "runelock"
	item_state = "runelock"
	force = 10
	force_wielded = 15
	possible_item_intents = list(/datum/intent/mace/strike/wood)
	gripped_intents = list(/datum/intent/shoot/twilight_runelock, /datum/intent/arc/twilight_runelock, INTENT_GENERIC)
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	experimental_onback = TRUE
	bigboy = TRUE
	wlength = WLENGTH_LONG
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	wdefense = 3
	damfactor = 1
	critfactor = 1
	rangefactor = 2
	reload_time = 12

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_runelock/rifle/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 6,"nx" = 7,"ny" = 6,"wx" = -2,"wy" = 3,"ex" = 1,"ey" = 3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -43,"sturn" = 43,"wturn" = 30,"eturn" = -30, "nflip" = 0, "sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -2,"nx" = -5,"ny" = -1,"wx" = -8,"wy" = 2,"ex" = 8,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 1,"nturn" = -45,"sturn" = 45,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
