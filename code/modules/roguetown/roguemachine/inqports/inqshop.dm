/datum/inqports/reliquary/
	category = 1 // Category for the HERMES. They are - "✤ SUPPLIES ✤", "✤ ARTICLES ✤", ✤ RELIQUARY ✤, "✤ WARDROBE ✤", "✤ EQUIPMENT ✤".

/datum/inqports/supplies/
	category = 2  // Category for the HERMES. They are - "✤ SUPPLIES ✤", "✤ ARTICLES ✤", ✤ RELIQUARY ✤, "✤ WARDROBE ✤", "✤ EQUIPMENT ✤".

/datum/inqports/articles/
	category = 3  // Category for the HERMES. They are - "✤ SUPPLIES ✤", "✤ ARTICLES ✤", ✤ RELIQUARY ✤, "✤ WARDROBE ✤", "✤ EQUIPMENT ✤".

/datum/inqports/equipment/
	category = 4 // Category for the HERMES. They are - "✤ SUPPLIES ✤", "✤ ARTICLES ✤", ✤ RELIQUARY ✤, "✤ WARDROBE ✤", "✤ EQUIPMENT ✤".

/datum/inqports/wardrobe/
	category = 5 // Category for the HERMES. They are - "✤ SUPPLIES ✤", "✤ ARTICLES ✤", ✤ RELIQUARY ✤, "✤ WARDROBE ✤", "✤ EQUIPMENT ✤".


/obj/structure/closet/crate/chest/inqcrate/supplies/
	name = "inquisitorial supply crate"

/obj/structure/closet/crate/chest/inqcrate/articles/
	name = "inquisitorial article crate"

/obj/structure/closet/crate/chest/inqreliquary/relic/
	lockid = "puritan"
	locked = TRUE

/obj/structure/closet/crate/chest/inqcrate/equipment/
	name = "inquisitorial equipment crate"

/obj/structure/closet/crate/chest/inqcrate/wardrobe/
	name = "otava's finest wardrobe crate"

/// ✤ SUPPLIES ✤ START HERE! WOW!	

/datum/inqports/supplies/extrafunding
	name = "Extra Funding"
	item_type = /obj/structure/closet/crate/chest/inqcrate/supplies/extrafunding
	marquescost = 10
	maximum = 1

/obj/item/roguecoin/silver/inqpile/Initialize()
	. = ..()
	set_quantity(20)

/obj/structure/closet/crate/chest/inqcrate/supplies/extrafunding/Initialize()
	. = ..()
	new /obj/item/roguecoin/silver/inqpile(src)
	new /obj/item/roguecoin/silver/inqpile(src)
	new /obj/item/roguecoin/silver/inqpile(src)
	new /obj/item/roguecoin/silver/inqpile(src)

/datum/inqports/supplies/medical
	name = "5 Rolls of Cloth and Needles"
	item_type = /obj/structure/closet/crate/chest/inqcrate/supplies/medical
	marquescost = 4

/obj/item/natural/bundle/cloth/roll/Initialize()
	. = ..()
	icon_state = "clothroll2"
	amount = 10

/obj/structure/closet/crate/chest/inqcrate/supplies/medical/Initialize()
	. = ..()
	new /obj/item/needle(src)
	new /obj/item/needle(src)
	new /obj/item/needle(src)
	new /obj/item/needle(src)
	new /obj/item/needle(src)
	new /obj/item/natural/bundle/cloth/roll(src)
	new /obj/item/natural/bundle/cloth/roll(src)
	new /obj/item/natural/bundle/cloth/roll(src)
	new /obj/item/natural/bundle/cloth/roll(src)
	new /obj/item/natural/bundle/cloth/roll(src)


/datum/inqports/supplies/rope
	name = "4 Spools of Rope"
	item_type = /obj/structure/closet/crate/chest/inqcrate/supplies/ropes
	marquescost = 2

/obj/structure/closet/crate/chest/inqcrate/supplies/ropes/Initialize()
	. = ..()
	new /obj/item/rope(src)
	new /obj/item/rope(src)
	new /obj/item/rope(src)
	new /obj/item/rope(src)

/datum/inqports/supplies/chains
	name = "4 Lengths of Chain"
	item_type = /obj/structure/closet/crate/chest/inqcrate/supplies/chains
	marquescost = 4

/obj/structure/closet/crate/chest/inqcrate/supplies/chains/Initialize()
	. = ..()
	new /obj/item/rope/chain(src)
	new /obj/item/rope/chain(src)
	new /obj/item/rope/chain(src)
	new /obj/item/rope/chain(src)

/datum/inqports/supplies/redpotions
	name = "3 Bottles of Red"
	item_type = /obj/structure/closet/crate/chest/inqcrate/supplies/redpots
	marquescost = 4

/obj/structure/closet/crate/chest/inqcrate/supplies/redpots/Initialize()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)

/datum/inqports/supplies/lifebloodvials
	name = "3 Vials of Strong Red"
	item_type = /obj/structure/closet/crate/chest/inqcrate/supplies/sredvials
	maximum = 4
	marquescost = 6

/obj/structure/closet/crate/chest/inqcrate/supplies/sredvials/Initialize()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/alchemical/healthpotnew(src)
	new /obj/item/reagent_containers/glass/bottle/alchemical/healthpotnew(src)
	new /obj/item/reagent_containers/glass/bottle/alchemical/healthpotnew(src)

/datum/inqports/supplies/bluepotions
	name = "3 Bottles of Blue"
	item_type = /obj/structure/closet/crate/chest/inqcrate/supplies/bluepots
	marquescost = 6

/obj/structure/closet/crate/chest/inqcrate/supplies/bluepots/Initialize()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/rogue/manapot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/manapot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/manapot(src)

/datum/inqports/supplies/strongbluevials
	name = "3 Vials of Strong Blue"
	item_type = /obj/structure/closet/crate/chest/inqcrate/supplies/sbluevials
	maximum = 4
	marquescost = 8

/obj/structure/closet/crate/chest/inqcrate/supplies/sbluevials/Initialize()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/alchemical/strongmanapot(src)
	new /obj/item/reagent_containers/glass/bottle/alchemical/strongmanapot(src)
	new /obj/item/reagent_containers/glass/bottle/alchemical/strongmanapot(src)

/datum/inqports/supplies/smokes
	name = "6 Smokebombs"
	item_type = /obj/structure/closet/crate/chest/inqcrate/supplies/smokes
	marquescost = 4

/obj/structure/closet/crate/chest/inqcrate/supplies/smokes/Initialize()
	. = ..()
	new /obj/item/smokebomb(src)
	new /obj/item/smokebomb(src)
	new /obj/item/smokebomb(src)
	new /obj/item/smokebomb(src)
	new /obj/item/smokebomb(src)
	new /obj/item/smokebomb(src)

/datum/inqports/supplies/bottlebombs
	name = "3 Bottlebombs"
	item_type = /obj/structure/closet/crate/chest/inqcrate/supplies/bottlebombs
	marquescost = 6

/obj/structure/closet/crate/chest/inqcrate/supplies/bottlebombs/Initialize()
	. = ..()
	new /obj/item/bomb(src)
	new /obj/item/bomb(src)
	new /obj/item/bomb(src)

// ✤ RELIQUARY ✤ GOES HERE! DO THAT!

/datum/inqports/reliquary/bullion
	name = "6 Blessed Silver Bullion"
	item_type = /obj/structure/closet/crate/chest/inqreliquary/relic/bullion/
	marquescost = 16

/obj/structure/closet/crate/chest/inqreliquary/relic/bullion/Initialize()
	. = ..()
	new /obj/item/ingot/silverblessed/bullion(src)
	new /obj/item/ingot/silverblessed/bullion(src)
	new /obj/item/ingot/silverblessed/bullion(src)
	new /obj/item/ingot/silverblessed/bullion(src)
	new /obj/item/ingot/silverblessed/bullion(src)
	new /obj/item/ingot/silverblessed/bullion(src)


/datum/inqports/reliquary/crankbox
	name = "The Crankbox"
	item_type = /obj/structure/closet/crate/chest/inqreliquary/relic/crankbox/
	marquescost = 16
	maximum = 1

/obj/structure/closet/crate/chest/inqreliquary/relic/crankbox/Initialize()
	. = ..()
	new /obj/item/psydonmusicbox(src)

// ✤ ARTICLES ✤ RIGHT HERE! THAT'S RIGHT!

/datum/inqports/articles/quicksilver
	name = "Quicksilver Poultice"
	item_type = /obj/item/quicksilver
	maximum = 1
	marquescost = 8

// ✤ EQUIPMENT ✤ BELONGS HERE! JUST BELOW!


// ✤ WARDROBE ✤ STARTS HERE! YEP!

/datum/inqports/wardrobe/fencerset
	name = "The Otavan Fencer's Finest Set Crate"
	item_type = /obj/structure/closet/crate/chest/inqcrate/wardrobe/fencerset
	marquescost = 8

/obj/structure/closet/crate/chest/inqcrate/wardrobe/fencerset/Initialize()
	. = ..()
	new /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/otavan(src)
	new /obj/item/clothing/neck/roguetown/fencerguard(src)
	new /obj/item/clothing/gloves/roguetown/otavan(src)
	new /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan(src)
	new /obj/item/clothing/shoes/roguetown/boots/otavan(src)

/datum/inqports/wardrobe/inspector
	name = "The Inquisitorial Inspector's Best Crate"
	item_type = /obj/structure/closet/crate/chest/inqcrate/wardrobe/inspector
	marquescost = 12

/obj/structure/closet/crate/chest/inqcrate/wardrobe/inspector/Initialize()
	. = ..()
	new /obj/item/clothing/head/roguetown/inqhat(src)
	new /obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat(src)
	new /obj/item/clothing/gloves/roguetown/otavan/inqgloves(src)
	new /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan(src)
	new /obj/item/clothing/shoes/roguetown/boots/otavan/inqboots(src)

/datum/inqports/wardrobe/paddedgambthree
	name = "The Padded Gambeson Three-Pack"
	item_type = /obj/structure/closet/crate/chest/inqcrate/wardrobe/paddedgambthree
	marquescost = 6

/obj/structure/closet/crate/chest/inqcrate/wardrobe/paddedgambthree/Initialize()
	. = ..()
	new /obj/item/clothing/suit/roguetown/armor/gambeson/heavy(src)
	new /obj/item/clothing/suit/roguetown/armor/gambeson/heavy(src)
	new /obj/item/clothing/suit/roguetown/armor/gambeson/heavy(src)

/datum/inqports/wardrobe/fencersthree
	name = "The Fencer's Gambeson Three-Pack"
	item_type = /obj/structure/closet/crate/chest/inqcrate/wardrobe/fencersthree
	marquescost = 10

/obj/structure/closet/crate/chest/inqcrate/wardrobe/fencersthree/Initialize()
	. = ..()
	new /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/otavan(src)
	new /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/otavan(src)
	new /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/otavan(src)

/datum/inqports/wardrobe/leatherpantsed
	name = "The Otavan Leathers Three-Pack"
	item_type = /obj/structure/closet/crate/chest/inqcrate/wardrobe/leatherpantsed
	marquescost = 6

/obj/structure/closet/crate/chest/inqcrate/wardrobe/leatherpantsed/Initialize()
	. = ..()
	new /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan(src)
	new /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan(src)
	new /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan(src)
	new /obj/item/clothing/gloves/roguetown/otavan(src)
	new /obj/item/clothing/gloves/roguetown/otavan(src)
	new /obj/item/clothing/gloves/roguetown/otavan(src)

/datum/inqports/wardrobe/nobledressup
	name = "The Cost of Nobility Crate"
	item_type = /obj/structure/closet/crate/chest/inqcrate/wardrobe/nobledressup
	marquescost = 14

/obj/structure/closet/crate/chest/inqcrate/wardrobe/nobledressup/Initialize()
	. = ..()
	new /obj/item/clothing/cloak/lordcloak/ladycloak(src)
	new /obj/item/clothing/cloak/lordcloak(src)
	new /obj/item/clothing/suit/roguetown/shirt/tunic/noblecoat(src)
	new /obj/item/clothing/suit/roguetown/shirt/dress/royal(src)
	new /obj/item/clothing/suit/roguetown/shirt/tunic/noblecoat(src)
	new /obj/item/clothing/gloves/roguetown/otavan(src)
