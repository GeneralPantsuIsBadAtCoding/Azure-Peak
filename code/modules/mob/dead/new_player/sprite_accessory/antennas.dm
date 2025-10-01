/datum/sprite_accessory/antenna
	abstract_type = /datum/sprite_accessory/antenna
	color_key_name = "Antennae"
	relevant_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/antenna/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	return is_human_part_visible(owner, HIDEEARS)

/datum/sprite_accessory/antenna/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_FACE, OFFSET_FACE_F)

/datum/sprite_accessory/antenna/moth
	abstract_type = /datum/sprite_accessory/antenna/moth
	icon = 'icons/mob/sprite_accessory/antenna/moth_antenna.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	default_colors = list("#FFFFFF")

/datum/sprite_accessory/antenna/moth/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/antenna/moth/reddish
	name = "Reddish"
	icon_state = "reddish"

/datum/sprite_accessory/antenna/moth/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/antenna/moth/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/antenna/moth/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/antenna/moth/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/antenna/moth/burnt_off
	name = "Burnt Off"
	icon_state = "burnt_off"

/datum/sprite_accessory/antenna/moth/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/antenna/moth/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/antenna/moth/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/antenna/moth/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/antenna/moth/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/antenna/moth/oakworm
	name = "Oak Worm"
	icon_state = "oakworm"

/datum/sprite_accessory/antenna/moth/jungle
	name = "Jungle"
	icon_state = "jungle"

/datum/sprite_accessory/antenna/moth/witchwing
	name = "Witch Wing"
	icon_state = "witchwing"

/datum/sprite_accessory/antenna/moth/regal
	name = "Regal"
	icon_state = "regal"

/datum/sprite_accessory/antenna/moth/mothra
	name = "Mothra"
	icon_state = "mothra"
