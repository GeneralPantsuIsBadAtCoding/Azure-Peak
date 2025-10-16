/datum/sprite_accessory/brand
	abstract_type = /datum/sprite_accessory/brand
	icon = 'icons/mob/body_markings/other_markings.dmi'
	color_key_name = "Brand"
	relevant_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/brand/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_BACK)

/datum/sprite_accessory/brand/vampire_seal
	name = "Vampiric Seal"
	icon_state = "slave_seal"
	//glows = TRUE
	default_colors = COLOR_RED
