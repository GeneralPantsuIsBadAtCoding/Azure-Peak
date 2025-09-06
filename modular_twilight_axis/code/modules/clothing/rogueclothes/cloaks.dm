/obj/item/clothing/cloak/captain/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/roguetown/cloak)

/obj/item/clothing/cloak/captain/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))
		
/obj/item/clothing/cloak/captain/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/captain/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/cloak/half/knight
	name = "champion's halfcloak"
	desc = "A halfcloak of the Grand Duke's most loyal champion."
	color = CLOTHING_AZURE

/obj/item/clothing/cloak/half/knight/Initialize(mob/living/L)
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	GLOB.lordcolor += src

/obj/item/clothing/cloak/half/knight/lordcolor(primary,secondary)
	color = primary
	detail_color = secondary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

/obj/item/clothing/cloak/half/knight/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/cloak/raincloak/furcloak/knight
	name = "champion's cloak"
	desc = "A cloak of the Grand Duke's most loyal champion."
	color = CLOTHING_AZURE

/obj/item/clothing/cloak/raincloak/furcloak/knight/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	GLOB.lordcolor += src

/obj/item/clothing/cloak/raincloak/furcloak/knight/lordcolor(primary,secondary)
	color = primary
	detail_color = secondary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

/obj/item/clothing/cloak/half/knight/Destroy()
	GLOB.lordcolor -= src
	return ..()
