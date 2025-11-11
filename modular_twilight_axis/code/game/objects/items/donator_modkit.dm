/obj/item/enchantingkit/kumie_boots
	name = "'Aristocratic boots' morphing elixer'"
	desc = "A small container of special morphing dust, perfect to make a specifc item. Required: Heavy Leather Boots"
	target_items = list(/obj/item/clothing/shoes/roguetown/boots/leather/reinforced, /obj/item/clothing/shoes/roguetown/boots/nobleboot)
	result_item = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced/aristocratic

/obj/item/enchantingkit/kumie_boots/pre_attack(obj/item/I, mob/user)
	if(is_type_in_list(I, target_items))
		var/result_type
		if(istype(I, /obj/item/clothing/shoes/roguetown/boots/nobleboot))
			result_type = /obj/item/clothing/shoes/roguetown/boots/nobleboot/aristocratic
		else if(istype(I, /obj/item/clothing/shoes/roguetown/boots/leather/reinforced))
			result_type = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced/aristocratic
		else
			return ..()
		
		var/obj/item/R = new result_type(get_turf(user))
		to_chat(user, span_notice("You apply the [src] to [I], using the enchanting dust and tools to turn it into [R]."))
		R.name += " <font size = 1>([I.name])</font>"
		remove_item_from_storage(I)
		qdel(I)
		user.put_in_hands(R)
		qdel(src)
		return TRUE
	else
		return ..()

//Kumie donator item - Aristocratic gloves
/obj/item/enchantingkit/kumie_gloves
	name = "'Aristocratic gloves' morphing elixer'"
	desc = "A small container of special morphing dust, perfect to make a specifc item. Required: Fingerless Leather Gloves"
	target_items = list(/obj/item/clothing/gloves/roguetown/fingerless_leather, /obj/item/clothing/gloves/roguetown/angle)
	result_item = /obj/item/clothing/gloves/roguetown/fingerless_leather/aristocratic

/obj/item/enchantingkit/kumie_gloves/pre_attack(obj/item/I, mob/user)
	if(is_type_in_list(I, target_items))
		var/result_type
		if(istype(I, /obj/item/clothing/gloves/roguetown/angle))
			result_type = /obj/item/clothing/gloves/roguetown/angle/aristocratic
		else if(istype(I, /obj/item/clothing/gloves/roguetown/fingerless_leather))
			result_type = /obj/item/clothing/gloves/roguetown/fingerless_leather/aristocratic
		else
			return ..()
		
		var/obj/item/R = new result_type(get_turf(user))
		to_chat(user, span_notice("You apply the [src] to [I], using the enchanting dust and tools to turn it into [R]."))
		R.name += " <font size = 1>([I.name])</font>"
		remove_item_from_storage(I)
		qdel(I)
		user.put_in_hands(R)
		qdel(src)
		return TRUE
	else
		return ..()

//Kumie donator item - Aristocratic shirt
/obj/item/enchantingkit/kumie_shirt
	name = "'Aristocratic Shirt' morphing elixer'"
	desc = "A small container of special morphing dust, perfect to make a specifc item. Required: Gambeson"
	target_items = list(/obj/item/clothing/suit/roguetown/armor/gambeson, /obj/item/clothing/suit/roguetown/armor/gambeson/heavy)
	result_item = /obj/item/clothing/suit/roguetown/armor/gambeson/aristocratic

/obj/item/enchantingkit/kumie_shirt/pre_attack(obj/item/I, mob/user)
	if(is_type_in_list(I, target_items))
		var/result_type
		if(istype(I, /obj/item/clothing/suit/roguetown/armor/gambeson/heavy))
			result_type = /obj/item/clothing/suit/roguetown/armor/gambeson/aristocratic/heavy
		else if(istype(I, /obj/item/clothing/suit/roguetown/armor/gambeson))
			result_type = /obj/item/clothing/suit/roguetown/armor/gambeson/aristocratic
		else
			return ..()
		
		var/obj/item/R = new result_type(get_turf(user))
		to_chat(user, span_notice("You apply the [src] to [I], using the enchanting dust and tools to turn it into [R]."))
		R.name += " <font size = 1>([I.name])</font>"
		remove_item_from_storage(I)
		qdel(I)
		user.put_in_hands(R)
		qdel(src)
		return TRUE
	else
		return ..()

//Kumie donator item - Aristocratic coat
/obj/item/enchantingkit/kumie_coat
	name = "'Aristocratic Coat' morphing elixer'"
	desc = "A small container of special morphing dust, perfect to make a specifc item. Required: Hardened Leather Coat"
	target_items = list(/obj/item/clothing/suit/roguetown/armor/leather/heavy/coat)
	result_item = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/aristocratic

/obj/item/enchantingkit/ravoxhelm_oldrw
	name = "'Plumed Ravox Helmet' morphing elixer'"
	desc = "A small container of special morphing dust, perfect to make a specifc item. Required: Heavy Helmet"
	target_items = list(/obj/item/clothing/head/roguetown/helmet/heavy)
	result_item = /obj/item/clothing/head/roguetown/helmet/heavy/ravoxhelm/oldrw

/obj/item/enchantingkit/necranhelm_oldrw
	name = "'Hooded Necra Helmet' morphing elixer'"
	desc = "A small container of special morphing dust, perfect to make a specifc item. Required: Heavy Helmet"
	target_items = list(/obj/item/clothing/head/roguetown/helmet/heavy)
	result_item = /obj/item/clothing/head/roguetown/helmet/heavy/necran/oldrw

/obj/item/enchantingkit/astratanhelm_oldrw
	name = "'Plumed Astrata Helmet' morphing elixer'"
	desc = "A small container of special morphing dust, perfect to make a specifc item. Required: Heavy Helmet"
	target_items = list(/obj/item/clothing/head/roguetown/helmet/heavy)
	result_item = /obj/item/clothing/head/roguetown/helmet/heavy/astratan/oldrw
