// Thievery Related Supplies. I sure hope this don't go wrong!!!
// Took lockpicks out so it don't get spammed. Get the expensive hairpins instead.

/datum/supply_pack/rogue/bath_rogue
	group = "Roguery"
	crate_name = "merchant guild's crate"
	crate_type = /obj/structure/closet/crate/chest/merchant

// Same as merchant
/datum/supply_pack/rogue/bath_rogue/chains
	name = "Chains"
	cost = 15
	contains = list(
		/obj/item/rope/chain,
		/obj/item/rope/chain,
		/obj/item/rope/chain,
	)

/datum/supply_pack/rogue/bath_rogue/goldpin
	name = "Golden Hairpin"
	cost = 70
	contains = list(/obj/item/lockpick/goldpin)

/datum/supply_pack/rogue/bath_rogue/silverpin
	name = "Silver Hairpin"
	cost = 140
	contains = list(/obj/item/lockpick/goldpin/silver)

/datum/supply_pack/rogue/bath_rogue/smokebomb
	name = "Smoke Bomb"
	cost = 25
	contains = list(
		/obj/item/smokebomb,
		/obj/item/smokebomb,
		/obj/item/smokebomb)

/datum/supply_pack/rogue/bath_rogue/waterarrows
	name = "Water Arrow"
	cost = 20
	contains = list (
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
		/obj/item/ammo_casing/caseless/rogue/arrow/water,
	)

/datum/supply_pack/rogue/bath_rogue/grappler
	name = "Grappler"
	cost = 200
	contains = list(/obj/item/grapplinghook)

/datum/supply_pack/rogue/bath_rogue/climbing_gear
	name = "Climbing Gear"
	cost = 150
	contains = list(/obj/item/clothing/climbing_gear)
