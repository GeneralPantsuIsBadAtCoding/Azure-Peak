// --------- AMMUNITION -----------

/datum/anvil_recipe/engineering/twilight_ammunition
	i_type = "Ammo (Engineering)"

/datum/anvil_recipe/engineering/twilight_ammunition/musket
	name = "Lead bullets 8x "
	req_bar = /obj/item/ingot/tin		//more uses for tin, and historically some musketballs were lead-tin alloys.
	created_item = /obj/item/ammo_casing/caseless/twilight_lead
	createditem_num = 8
	craftdiff = 2

/datum/anvil_recipe/engineering/twilight_ammunition/silver_musket
	name = "Silver bullets 8x "
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/ammo_casing/caseless/twilight_lead/silver
	createditem_num = 8
	craftdiff = 5

/datum/anvil_recipe/engineering/twilight_ammunition/runelock
	name = "Runed spheres 6x "
	req_bar = /obj/item/ingot/blacksteel
	created_item = /obj/item/ammo_casing/caseless/twilight_lead/runelock
	createditem_num = 6
	craftdiff = 5

/datum/anvil_recipe/engineering/twilight_ammunition/cannonball
	name = "Lead cannonballs 6x "
	req_bar = /obj/item/ingot/tin
	created_item = /obj/item/ammo_casing/caseless/twilight_cannonball
	createditem_num = 6
	craftdiff = 2

/datum/anvil_recipe/engineering/twilight_ammunition/grapeshot
	name = "Grapeshot 6x "
	req_bar = /obj/item/ingot/tin
	created_item = /obj/item/ammo_casing/caseless/twilight_cannonball/grapeshot
	createditem_num = 6
	craftdiff = 2

/datum/anvil_recipe/weapons/twilight_ammunition
	i_type = "Ammo (Smithing)"

/datum/anvil_recipe/weapons/twilight_ammunition/musket
	name = "Lead bullets 8x "
	req_bar = /obj/item/ingot/tin		//more uses for tin, and historically some musketballs were lead-tin alloys.
	created_item = /obj/item/ammo_casing/caseless/twilight_lead
	createditem_num = 8
	craftdiff = 2

/datum/anvil_recipe/weapons/twilight_ammunition/silver_musket
	name = "Silver bullets 8x "
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/ammo_casing/caseless/twilight_lead/silver
	createditem_num = 8
	craftdiff = 5

/datum/anvil_recipe/weapons/twilight_ammunition/runelock
	name = "Runed spheres 6x "
	req_bar = /obj/item/ingot/blacksteel
	created_item = /obj/item/ammo_casing/caseless/twilight_lead/runelock
	createditem_num = 6
	craftdiff = 5

/datum/anvil_recipe/weapons/twilight_ammunition/cannonball
	name = "Lead cannonballs 6x "
	req_bar = /obj/item/ingot/tin
	created_item = /obj/item/ammo_casing/caseless/twilight_cannonball
	createditem_num = 6
	craftdiff = 2

/datum/anvil_recipe/weapons/twilight_ammunition/grapeshot
	name = "Grapeshot 6x "
	req_bar = /obj/item/ingot/tin
	created_item = /obj/item/ammo_casing/caseless/twilight_cannonball/grapeshot
	createditem_num = 6
	craftdiff = 2

// --------- GUNS -----------

/obj/item/twilight_gunlock
	name = "Gun Lock"
	icon_state = "gunlock"
	desc = "The 'firing' part of a gun."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_twilight_axis/firearms/icons/misc.dmi'

/obj/item/twilight_gunstock
	name = "Gun Stock"
	icon_state = "gunstock"
	desc = "The 'holding' part of a gun."
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'modular_twilight_axis/firearms/icons/misc.dmi'

/obj/item/twilight_simplestock
	name = "Simple Stock"
	icon_state = "ironstock"
	desc = "The 'holding' part of a gun."
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'modular_twilight_axis/firearms/icons/misc.dmi'

/obj/item/twilight_gunbarrel
	name = "Gun Barrel"
	icon_state = "gunbarrel"
	desc = "The 'aiming' part of a gun."
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'modular_twilight_axis/firearms/icons/misc.dmi'

/obj/item/twilight_ironbarrel
	name = "Iron Barrel"
	icon_state = "ironbarrel"
	desc = "The 'aiming' part of a gun."
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'modular_twilight_axis/firearms/icons/misc.dmi'

/datum/anvil_recipe/engineering/twilight_guns
	i_type = "Firearms"

/datum/anvil_recipe/engineering/twilight_guns/barrel
	name = "Gun Barrel (+1 Steel)"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/twilight_gunbarrel
	additional_items = list(/obj/item/ingot/steel = 1)
	craftdiff = 3

/datum/anvil_recipe/engineering/twilight_guns/ironbarrel
	name = "Iron Barrel (+1 Iron)"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/twilight_ironbarrel
	additional_items = list(/obj/item/ingot/iron = 1)
	craftdiff = 1

/datum/anvil_recipe/engineering/twilight_guns/parts
	name = "Gun Lock (+1 Cog)"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/twilight_gunlock
	additional_items = list(/obj/item/roguegear = 1)
	craftdiff = 1

/datum/anvil_recipe/engineering/twilight_guns/stock
	name = "Gun Stock (+1 Wood)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/natural/wood/plank = 1)
	created_item = /obj/item/twilight_gunstock
	craftdiff = 3

/datum/anvil_recipe/engineering/twilight_guns/ironstock
	name = "Simple Stock (+1 Wood)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/wood/plank = 1)
	created_item = /obj/item/twilight_simplestock
	craftdiff = 1

/datum/anvil_recipe/engineering/twilight_guns/arquebus
	name = "Arquebus Rifle (+1 Stock) (+1 Lock) (+1 Barrel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/twilight_gunlock = 1,
							/obj/item/twilight_gunstock = 1,
							/obj/item/twilight_gunbarrel = 1)
	created_item = /obj/item/gun/ballistic/twilight_firearm/arquebus
	craftdiff = 4

/datum/anvil_recipe/engineering/twilight_guns/handgonne
	name = "Culverin (+1 Stock) (+1 Barrel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/twilight_gunstock = 1,
							/obj/item/twilight_gunbarrel = 1)
	created_item = /obj/item/gun/ballistic/twilight_firearm/handgonne
	craftdiff = 4

/datum/anvil_recipe/engineering/twilight_guns/flintgonne
	name = "Hakenbüchse (+1 Simple Stock) (+1 Lock) (+1 Iron Barrel)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/twilight_gunlock = 1,
							/obj/item/twilight_simplestock = 1,
							/obj/item/twilight_ironbarrel = 1)
	created_item = /obj/item/gun/ballistic/twilight_firearm/flintgonne
	craftdiff = 2

/datum/anvil_recipe/engineering/twilight_guns/barker
	name = "Barker (+1 Simple Stock) (+1 Iron Barrel)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/twilight_simplestock = 1,
							/obj/item/twilight_ironbarrel = 1)
	created_item = /obj/item/gun/ballistic/twilight_firearm/barker
	craftdiff = 1

/datum/anvil_recipe/engineering/twilight_guns/arquebus_pistol
	name = "Arquebus Pistol (+1 Stock) (+1 Lock) (+1 Barrel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/twilight_gunlock = 1,
							/obj/item/twilight_gunstock = 1,
							/obj/item/twilight_gunbarrel = 1)
	created_item = /obj/item/gun/ballistic/twilight_firearm/arquebus_pistol
	craftdiff = 4

/datum/anvil_recipe/engineering/twilight_guns/arquebus_decorated
	name = "Decorated Arquebus (+1 Stock) (+1 Lock) (+1 Barrel) (+1 Gold)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/twilight_gunlock = 1,
							/obj/item/twilight_gunstock = 1,
							/obj/item/twilight_gunbarrel = 1,
							/obj/item/ingot/gold = 1)
	created_item = /obj/item/gun/ballistic/twilight_firearm/arquebus/decorated
	craftdiff = 4

/datum/anvil_recipe/weapons/twilight_arquebus_decorated
	name = "Decorated Arquebus (+1 Arquebus Rifle)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/gun/ballistic/twilight_firearm/arquebus)
	created_item = /obj/item/gun/ballistic/twilight_firearm/arquebus/decorated
	craftdiff = 2

/datum/anvil_recipe/weapons/twilight_ramrod
	name = "Ramrod"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/twilight_ramrod
	craftdiff = 1
