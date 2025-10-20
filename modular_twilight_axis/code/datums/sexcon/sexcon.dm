/datum/sex_controller
	var/aphrodisiac = 1
	var/manual_arousal = SEX_MANUAL_AROUSAL_DEFAULT

/proc/do_thrust_animate(atom/movable/user, atom/movable/target, pixels = 4, time = 2.7)
	var/oldx = user.pixel_x
	var/oldy = user.pixel_y
	var/target_x = oldx
	var/target_y = oldy
	var/dir = get_dir(user, target)
	if(user.loc == target.loc)
		dir = user.dir
	switch(dir)
		if(NORTH)
			target_y += pixels
		if(SOUTH)
			target_y -= pixels
		if(WEST)
			target_x -= pixels
		if(EAST)
			target_x += pixels

	animate(user, pixel_x = target_x, pixel_y = target_y, time = time)
	animate(pixel_x = oldx, pixel_y = oldy, time = time)

/datum/sex_controller/proc/adjust_arousal_manual(amt)
	manual_arousal = clamp(manual_arousal + amt, SEX_MANUAL_AROUSAL_MIN, SEX_MANUAL_AROUSAL_MAX)

/datum/sex_controller/proc/handle_cock_milking(mob/living/carbon/human/milker)
	if(arousal < ACTIVE_EJAC_THRESHOLD)
		return
	if(is_spent())
		return
	if(!can_ejaculate())
		return FALSE
	ejaculate_container(milker.get_active_held_item())

/datum/sex_controller/proc/handle_breast_milking(mob/living/carbon/human/milker, mob/living/carbon/human/target)
	var/obj/item/organ/breasts/breasts = target.getorganslot(ORGAN_SLOT_BREASTS)
	var/milk_to_add = min(max(breasts.breast_size, 1), breasts.milk_stored)
	if(breasts.lactating && milk_to_add > 0)
		breasts.milk_stored -= milk_to_add
		milk_container(milker.get_active_held_item(), milk_to_add)
	else
		to_chat(milker, span_notice("Молоко не выходит из груди..."))

/datum/sex_controller/proc/milk_container(obj/item/reagent_containers/glass/C, amout)
	user.visible_message(span_lovebold("[user.name] наполняет [C.name] молочком!"))
	playsound(user, 'sound/misc/mat/segso.ogg', 50, TRUE, ignore_walls = FALSE)
	C.reagents.add_reagent(/datum/reagent/consumable/milk, amout)

/datum/sex_controller/proc/ejaculate_container(obj/item/reagent_containers/glass/C)
	log_combat(user, user, "Кончает в емкость")
	user.visible_message(span_lovebold("[user.name] наполняет [C.name] семенем!"))
	playsound(user, 'sound/misc/mat/endout.ogg', 50, TRUE, ignore_walls = FALSE)
	C.reagents.add_reagent(/datum/reagent/erpjuice/cum, 3)
	after_ejaculation()

/datum/sex_controller/proc/handle_container_ejaculation()
	if(arousal < PASSIVE_EJAC_THRESHOLD)
		return
	if(is_spent())
		return
	if(!can_ejaculate())
		return FALSE
	ejaculate_container(user.get_active_held_item())

/datum/sex_controller/proc/get_manual_arousal_string()
	switch(manual_arousal)
		if(SEX_MANUAL_AROUSAL_DEFAULT)
			return "<font color='#eac8de'>ПЕРЕМЕННАЯ ЭРЕКЦИЯ</font>" // влияет на спрайт
		if(SEX_MANUAL_AROUSAL_UNAROUSED)
			return "<font color='#e9a8d1'>СЛАБАЯ ЭРЕКЦИЯ</font>"
		if(SEX_MANUAL_AROUSAL_PARTIAL)
			return "<font color='#f05ee1'>НОРМАЛЬНАЯ ЭРЕКЦИЯ</font>"
		if(SEX_MANUAL_AROUSAL_FULL)
			return "<font color='#d146f5'>СИЛЬНАЯ ЭРЕКЦИЯ</font>"
