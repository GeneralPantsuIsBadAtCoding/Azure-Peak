/obj/item/signal_horn
	name = "signal horn"
	desc = "Used to sound the alarm."
	icon = 'modular_hearthstone/icons/obj/items/signalhorn.dmi'
	icon_state = "signalhorn"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_NORMAL
	grid_height = 32
	grid_width = 64

/obj/item/signal_horn/attack_self(mob/living/user)
	. = ..()
	user.visible_message(span_warning("[user] is about to sound the [src]!"))
	if(do_after(user, 15))
		sound_horn(user)

/obj/item/signal_horn/proc/sound_horn(mob/living/user)
	user.visible_message(span_warning("[user] blows the horn!"))
	switch(user.job)
		if("Warden")
			playsound(src, 'modular_hearthstone/sound/items/bogguardhorn.ogg', 100, TRUE)
		if("Town Sheriff", "Watchman", "Sergeant", "Man at Arms")
			playsound(src, 'modular_hearthstone/sound/items/watchhorn.ogg', 100, TRUE)
		if("Knight Captain", "Royal Guard")
			playsound(src, 'modular_hearthstone/sound/items/rghorn.ogg', 100, TRUE)
		else
			playsound(src, 'modular_hearthstone/sound/items/signalhorn.ogg', 100, TRUE)

	for(var/i = 0, i < 5, i++)
		user.consider_ambush(TRUE, TRUE)
 