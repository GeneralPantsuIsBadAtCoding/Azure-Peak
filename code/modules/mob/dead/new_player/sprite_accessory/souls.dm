/datum/sprite_accessory/soul
	abstract_type = /datum/sprite_accessory/soul
	icon = 'icons/mob/sprite_accessory/souls/souls.dmi'
	color_key_name = "Soul"

/datum/sprite_accessory/soul/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(!isdullahan(owner))
		return FALSE
	var/datum/species/dullahan/owner_species = owner.dna.species
	return !owner_species.headless || owner.stat == DEAD ? FALSE : TRUE

/datum/sprite_accessory/soul/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_FACE, OFFSET_FACE_F)

/datum/sprite_accessory/soul/fire
	name = "Fire"
	icon_state = "neckfire"
