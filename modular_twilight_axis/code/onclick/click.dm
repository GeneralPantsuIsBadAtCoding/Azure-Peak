/mob/living/try_special_attack(atom/A, list/modifiers)
	if(istype(A, /obj/item/gun/ballistic/twilight_firearm))
		return FALSE
	. = ..()
