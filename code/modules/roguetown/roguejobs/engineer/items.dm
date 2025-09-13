/obj/item/roguegear
	icon = 'icons/roguetown/items/misc.dmi'
	name = "example cog"
	desc = "You should not be seeing this."
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

/obj/item/roguegear/bronze
	name = "cog"
	desc = "A cog with teeth meticulously crafted for tight interlocking."
	smeltresult = /obj/item/ingot/bronze

/obj/item/roguegear/wood
	var/cart_capacity = 0
	var/misfire_modification
	var/name_prefix
	var/ulevel = 0

/obj/item/roguegear/wood/basic
	name = "wooden cog"
	desc = "A very simple cog that has the ability to increase the carry capacity of a wooden cart."
	icon_state = "wcog"
	metalizer_result = /obj/item/roguegear/bronze
	cart_capacity = 90

/obj/item/roguegear/wood/reliable
	name = "reliable wooden cog"
	desc = "A cog imbued with a special essence, making it very reliable. Used in carts and machinery."
	icon_state = "wcog2"
	filters = filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(32, 196, 218, 200))
	cart_capacity = 120
	misfire_modification = 7
	name_prefix = "stable"
	ulevel = 1

/obj/item/roguegear/wood/unstable
	name = "unstable wooden cog"
	desc = "A cog imbued with a special essence, making it prone to breaking at any time. Used in carts and machinery."
	icon_state = "wcog2"
	filters = filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(167, 17, 17, 200))
	cart_capacity = 140
	misfire_modification = 100
	ulevel = 2