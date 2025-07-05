 //--------------- BLACKSTEEL ---------------------

/obj/item/clothing/suit/roguetown/armor/plate/modern/blacksteel_full_plate
	name = "blacksteel plate armor"
	desc = "A suit of Full Plate smithed from durable blacksteel. Using a modern design, the piercing and blunt protection still remain unmatched among its heavy-plated peers."
	body_parts_covered = COVERAGE_FULL
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bplate"
	item_state = "bplate"
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	armor = ARMOR_PLATE_BSTEEL
	allowed_race = CLOTHED_RACES_TYPES
	blocking_behavior = null
	max_integrity = ARMOR_INT_CHEST_PLATE_BLACKSTEEL
	smeltresult = /obj/item/ingot/blacksteel
	equip_delay_self = 12 SECONDS
	unequip_delay_self = 12 SECONDS
	equip_delay_other = 3 SECONDS
	strip_delay = 6 SECONDS
	smelt_bar_num = 4 

/obj/item/clothing/suit/roguetown/armor/plate/blacksteel_full_plate
	name = "ancient blacksteel plate armor"
	desc = "A suit of Full Plate smithed from durable blacksteel. With an internally layered gambeson, the piercing and blunt protection is unmatched among its heavy-plated peers."
	body_parts_covered = COVERAGE_FULL
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bkarmor"
	item_state = "bkarmor"
	armor = ARMOR_PLATE_BSTEEL
	allowed_race = CLOTHED_RACES_TYPES
	blocking_behavior = null
	max_integrity = ARMOR_INT_CHEST_PLATE_BLACKSTEEL
	smeltresult = /obj/item/ingot/blacksteel
	equip_delay_self = 12 SECONDS
	unequip_delay_self = 12 SECONDS
	equip_delay_other = 3 SECONDS
	strip_delay = 6 SECONDS
	smelt_bar_num = 4

/obj/item/clothing/suit/roguetown/armor/plate/blacksteel_half_plate
	name = "blacksteel cuirass"
	desc = "A basic cuirass forged from blacksteel. It's somewhat more durable than regular steel."
	body_parts_covered = COVERAGE_TORSO
	icon_state = "grenzelcuirass"
	item_state = "grenzelcuirass"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	allowed_race = CLOTHED_RACES_TYPES
	blocking_behavior = null
	max_integrity = ARMOR_INT_CHEST_PLATE_BLACKSTEEL
	smeltresult = /obj/item/ingot/blacksteel
	armor_class = ARMOR_CLASS_MEDIUM
	smelt_bar_num = 2
