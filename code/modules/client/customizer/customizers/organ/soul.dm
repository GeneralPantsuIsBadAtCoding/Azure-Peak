// What comes out of a Dullahan's neck, referred to as their soul.
/datum/customizer/organ/soul
	abstract_type = /datum/customizer/organ/soul
	name = "Soul"

/datum/customizer_choice/organ/soul
	abstract_type = /datum/customizer_choice/organ/soul
	name = "Soul"
	organ_type = /obj/item/organ/soul
	organ_slot = ORGAN_SLOT_SOUL


/datum/customizer/organ/soul/fire
	customizer_choices = list(/datum/customizer_choice/organ/soul/fire)
	default_choice = /datum/customizer_choice/organ/soul/fire

/datum/customizer_choice/organ/soul/fire
	name = "Fire"
	organ_type = /obj/item/organ/soul/fire
	sprite_accessories = list(
		/datum/sprite_accessory/soul/fire,
		)
