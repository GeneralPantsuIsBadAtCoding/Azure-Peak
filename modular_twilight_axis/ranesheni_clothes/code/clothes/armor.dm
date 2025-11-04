/obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/raneshen/new_coat
	name = "Ranesheni scale coat"
	desc = "A lightweight armor made from the scales of the Ranesheni \'megarmach\', an armored reptilian creacher that ambushes prey by the riverside, and drags them deep into Abyssor's domain."
	icon = 'modular_twilight_axis/ranesheni_clothes/icons/obj/armor.dmi'
	mob_overlay_icon = 'modular_twilight_axis/ranesheni_clothes/icons/mob/armor.dmi'
	icon_state = "light_armour"
	item_state = "light_armour"
	body_parts_covered = COVERAGE_FULL

/obj/item/clothing/suit/roguetown/armor/plate/raneshen_scale
	slot_flags = ITEM_SLOT_ARMOR
	name = "Ranesheni medium lamellar armor"
	desc = "Armor used by the Empire's vanguard fighters. The plates are connected to each other with cord for mobility. The arms are protected by pauldrons, and the legs by a small chainmail skirt. The armor itself is decorated with bronze."
	icon = 'modular_twilight_axis/ranesheni_clothes/icons/obj/armor.dmi'
	mob_overlay_icon = 'modular_twilight_axis/ranesheni_clothes/icons/mob/armor.dmi'
	icon_state = "medium_armour"
	item_state = "medium_armour"
	body_parts_covered = COVERAGE_FULL
	allowed_sex = list(MALE, FEMALE)
	max_integrity = ARMOR_INT_CHEST_MEDIUM_STEEL
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 4 SECONDS
	armor_class = ARMOR_CLASS_MEDIUM
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/plate/full/raneshen_full
	name = "Ranesheni plate armor"
	desc = "Full-fledged armor with scales, a light chainmail skirt protects the lower legs, has bronze decorations and strong protective shoulder pads."
	icon = 'modular_twilight_axis/ranesheni_clothes/icons/obj/armor.dmi'
	mob_overlay_icon = 'modular_twilight_axis/ranesheni_clothes/icons/mob/armor.dmi'
	icon_state = "heavy_armour"
	item_state = "heavy_armour"
	body_parts_covered = COVERAGE_FULL
	equip_delay_self = 12 SECONDS
	unequip_delay_self = 12 SECONDS
	equip_delay_other = 3 SECONDS
	strip_delay = 6 SECONDS
	max_integrity = ARMOR_INT_CHEST_PLATE_STEEL
	smelt_bar_num = 4
	armor_class = ARMOR_CLASS_HEAVY
