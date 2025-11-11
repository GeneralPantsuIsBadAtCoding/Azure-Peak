/obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket/handjacket
	name = "noble jacket"
	icon_state = "handcoat"
	icon = 'modular_twilight_axis/icons/roguetown/clothing/special/noble.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/special/onmob/noble.dmi'
	sleeved = 'modular_twilight_axis/icons/roguetown/clothing/special/onmob/noble.dmi'
	detail_tag = "_detail"
	detail_color = CLOTHING_BLACK
	body_parts_covered = COVERAGE_SHIRT

/obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket/handjacket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket/handjacket/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket/handjacket/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket/handjacket/Destroy()
	GLOB.lordcolor -= src
	return ..()

// Elven reinforced clothes

/obj/item/clothing/shoes/roguetown/boots/armor/iron/twilight_elven
	name = "elven rider boots"
	desc = "Comfortable leather boots, reinforced with metal plates for extra protection. Crafted by elven masters, based on a design lost to ages."
	icon_state = "elven_boots"
	item_state = "elven_boots"
	allowed_race = NON_DWARVEN_RACE_TYPES
	icon = 'modular_twilight_axis/icons/roguetown/clothing/boots.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/boots.dmi'

/obj/item/clothing/gloves/roguetown/angle/twilight_elven
	name = "elven rider gloves"
	desc = "Comfortable leather gloves, reinforced with metal plates for extra protection. Crafted by elven masters, based on a design lost to ages."
	icon_state = "elven_gloves"
	item_state = "elven_gloves"
	allowed_race = NON_DWARVEN_RACE_TYPES
	icon = 'modular_twilight_axis/icons/roguetown/clothing/gloves.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/gloves.dmi'

/obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/raneshen/new_coat
	name = "Ranesheni scale coat"
	desc = "A lightweight armor made from the scales of the Ranesheni \'megarmach\', an armored reptilian creacher that ambushes prey by the riverside, and drags them deep into Abyssor's domain."
	icon = 'modular_twilight_axis/icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/32х48/armor.dmi'
	sleeved = 'modular_twilight_axis/icons/roguetown/clothing/onmob/helpers/32х48/sleeves_armor.dmi'
	icon_state = "light_armour"
	item_state = "light_armour"
	body_parts_covered = COVERAGE_FULL
