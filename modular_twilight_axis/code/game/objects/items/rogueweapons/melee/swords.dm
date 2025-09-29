/obj/item/rogueweapon/sword/rapier/psyrapier
	name = "psydonian rapier"
	desc = "An ornate rapier, plated in a ceremonial veneer of silver. The barbs pierce your palm, and - for just a moment - you see red. Never forget that you are why Psydon wept."
	icon = 'modular_twilight_axis/icons/roguetown/weapons/64.dmi'
	icon_state = "psyrapier"
	item_state = "psyrapier"
	resistance_flags = FIRE_PROOF
	force = 17
	force_wielded = 20
	is_silver = TRUE

/obj/item/rogueweapon/sword/rapier/psyrapier/ComponentInitialize()
	AddComponent(\
		/datum/component/silverbless,\
		pre_blessed = BLESSING_NONE,\
		silver_type = SILVER_PSYDONIAN,\
		added_force = 0,\
		added_blade_int = 100,\
		added_int = 50,\
		added_def = 2,\
	)

/obj/item/rogueweapon/sword/rapier/foldsword
	name = "pathmaker"
	desc = "Дорогостоющий складной меч, сделанный специально по заказу для десницы. Можно носить как обычный меч в ножнах, так и в сумке или в поясе, если сложить."
	icon = 'modular_twilight_axis/icons/roguetown/weapons/64.dmi'
	icon_state = "folding_sword_on"
	item_state = "folding_sword_on"
	var/on = FALSE

/obj/item/rogueweapon/sword/rapier/foldsword/update_icon()
	if(on)
		icon_state = "folding_sword_on"
	else
		icon_state = "folding_sword_off"

/obj/item/rogueweapon/sword/rapier/foldsword/attack_self(mob/user)
	if(on)
		on = FALSE
		possible_item_intents = list(/datum/intent/sword/strike)
		wlength = WLENGTH_SHORT
		w_class = WEIGHT_CLASS_SMALL
		equip_delay_self = 0 SECONDS
		unequip_delay_self = 0 SECONDS
		inv_storage_delay = 0 SECONDS
		slot_flags = ITEM_SLOT_HIP
	else
		on = TRUE
		possible_item_intents = list(/datum/intent/sword/thrust/rapier, /datum/intent/sword/cut/rapier, /datum/intent/sword/peel)
		wlength = WLENGTH_NORMAL
		w_class = WEIGHT_CLASS_BULKY
		equip_delay_self = 1.5 SECONDS
		unequip_delay_self = 1.5 SECONDS
		inv_storage_delay = 1.5 SECONDS
		slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	if(user.a_intent)
		var/datum/intent/I = user.a_intent
		if(istype(I))
			I.afterchange()
	user.update_a_intents()
	update_icon()
