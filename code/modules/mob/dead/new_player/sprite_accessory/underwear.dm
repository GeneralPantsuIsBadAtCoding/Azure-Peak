/datum/sprite_accessory/underwear
	abstract_type = /datum/sprite_accessory/underwear
	icon = 'icons/mob/sprite_accessory/underwear.dmi'
	color_key_name = "Underwear"
	var/underwear_type
	///Whether this underwear includes a top (Because gender = FEMALE doesn't actually apply here.). Hides breasts, nothing more.
	var/hides_breasts = FALSE

/datum/sprite_accessory/underwear/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_UNDIES, OFFSET_UNDIES_F)

/datum/sprite_accessory/underwear/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(hides_breasts)
		if(is_human_part_visible(owner, HIDECROTCH) || is_human_part_visible(owner, HIDEBOOB))
			return TRUE	
	return is_human_part_visible(owner, HIDECROTCH)

/datum/sprite_accessory/underwear/briefs
	name = "Briefs"
	icon_state = "male_reg"
	underwear_type = /obj/item/undies

/datum/sprite_accessory/underwear/briefs/get_icon_state(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(is_species(owner,/datum/species/dwarf))
		return "maledwarf_reg"
	if(owner.gender == FEMALE)
		return "maleelf_reg"
	return "male_reg"

/datum/sprite_accessory/underwear/bikini
	name = "Bikini"
	icon_state = "female_bikini"
	underwear_type = /obj/item/undies/bikini
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/panties
	name = "Panties"
	icon_state = "panties"
	underwear_type = /obj/item/undies/panties

/datum/sprite_accessory/underwear/leotard
	name = "Leotard"
	icon_state = "female_leotard"
	underwear_type = /obj/item/undies/leotard
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/leotard/get_icon_state(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(owner.gender == MALE)
		return "male_leotard"
	return "female_leotard"

/datum/sprite_accessory/underwear/athletic_leotard
	name = "Athletic Leotard"
	icon_state = "female_sleeved_leotard"
	underwear_type = /obj/item/undies/athletic_leotard
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/athletic_leotard/get_icon_state(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(owner.gender == MALE)
		return "male_athletic_leotard"
	return "female_athletic_leotard"

/datum/sprite_accessory/underwear/braies
	name = "Braies"
	icon_state = "braies"
	underwear_type = /obj/item/undies

/datum/sprite_accessory/underwear/braies/get_icon_state(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(owner.gender == FEMALE)
		return "braies_f"
	return "braies"
