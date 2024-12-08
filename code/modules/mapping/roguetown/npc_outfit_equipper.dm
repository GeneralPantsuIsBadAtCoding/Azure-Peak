/obj/effect/mapping_helpers/outfit_handler
	name = "generic outfit equipper (SET PATH IN VARS)"
	icon_state = "plate_alt"
	icon = 'icons/roguetown/clothing/armor.dmi'
	alpha = 155 //so its easier to tell apart
	late = TRUE
	var/datum/outfit/outfit_to_equip

/obj/effect/mapping_helpers/outfit_handler/LateInitialize()
	if(!outfit_to_equip)
		qdel(src)
		return
	var/mob/living/carbon/human/located = locate(/mob/living/carbon/human) in get_turf(src)
	if(!located)
		qdel(src)
		return
	located.equipOutfit(outfit_to_equip)
	qdel(src)

/obj/effect/mapping_helpers/floor_clothing_equipper
	name = "floor clothes equipper (PLACE ITEMS ON FLOOR)"
	icon_state = "leather"
	icon = 'icons/roguetown/clothing/armor.dmi'
	alpha = 155 //so its easier to tell apart
	late = TRUE


/obj/effect/mapping_helpers/floor_clothing_equipper/LateInitialize()
	var/mob/living/carbon/human/located = locate(/mob/living/carbon/human) in get_turf(src)
	if(!located)
		qdel(src)
		return

	for(var/obj/item/clothing/clothing in get_turf(src))
		located.equip_to_appropriate_slot(clothing)

	for(var/obj/item/rogueweapon/weapon in get_turf(src))
		located.put_in_hands(weapon)
	qdel(src)
