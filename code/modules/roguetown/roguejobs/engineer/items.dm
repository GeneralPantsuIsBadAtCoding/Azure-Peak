/obj/item/roguegear
	icon = 'icons/roguetown/items/misc.dmi'
	name = "cog"
	desc = "A cog with teeth meticulously crafted for tight interlocking."
	icon_state = "gear"
	w_class = WEIGHT_CLASS_SMALL
	smeltresult = null
	var/obj/structure/linking
	grid_width = 64
	grid_height = 32

/* linking now done by wrenches
/obj/item/roguegear/Destroy()
	if(linking)
		linking = null
	. = ..()

/obj/item/roguegear/attack_self(mob/user)
	if(linking)
		linking = null
		to_chat(user, span_warning("Linking halted."))
		return

/obj/item/roguegear/attack_obj(obj/O, mob/living/user)
	if(!istype(O, /obj/structure))
		return ..()
	var/obj/structure/S = O
	if(linking)
		if(linking == O)
			to_chat(user, span_warning("You cannot link me to myself."))
			return
		if(linking in S.redstone_attached)
			to_chat(user, span_warning("Already linked."))
			linking = null
			return
		S.redstone_attached |= linking
		linking.redstone_attached |= S
		linking = null
		to_chat(user, span_notice("Link complete."))
		return
	linking = S
	to_chat(user, span_info("Link beginning..."))
*/
