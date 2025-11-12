/obj/item/organ
	var/can_penetrate = FALSE

/obj/item/organ/tail/lizard
	can_penetrate = TRUE

/obj/item/organ/tail/tiefling
	can_penetrate = TRUE

/obj/item/organ/tail/kobold
	can_penetrate = TRUE

/obj/item/organ/tail/dragontail
	name = "dragon tail"
	accessory_type =  /datum/sprite_accessory/tail/aura
	can_penetrate = TRUE
