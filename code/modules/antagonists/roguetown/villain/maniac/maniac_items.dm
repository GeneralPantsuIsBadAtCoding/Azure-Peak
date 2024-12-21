//Mostly garbage related to the ending "cutscene"
/obj/item/clothing/head/roguetown/cyberdeck
	name = "cyberdeck headset"
	desc = "Sweet dreams..."
	icon = 'icons/roguetown/maniac/clothing.dmi'
	mob_overlay_icon = 'icons/roguetown/maniac/clothing_mob.dmi'
	icon_state = "cyberdeck"
	armor = list("blunt" = 25, "slash" = 25, "stab" = 25, "piercing" = 0, "fire" = 0, "acid" = 0)
	tint = TINT_BLIND //it covers ya eyes

/obj/item/clothing/head/roguetown/cyberdeck/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HEAD)
		user.become_blind("blindfold_[REF(src)]")

/obj/item/clothing/head/roguetown/cyberdeck/dropped(mob/living/carbon/human/user)
	. = ..()
	user.cure_blind("blindfold_[REF(src)]")

/obj/item/clothing/suit/roguetown/shirt/formal
	name = "formal shirt"
	desc = "TNC is the fairest company I know."
	icon = 'icons/roguetown/maniac/clothing.dmi'
	mob_overlay_icon = 'icons/roguetown/maniac/clothing_mob.dmi'
	icon_state = "shirt"

/obj/item/clothing/under/roguetown/tights/formal
	name = "formal pants"
	desc = "TNC is the fairest company I know."
	gender = PLURAL
	icon = 'icons/roguetown/maniac/clothing.dmi'
	mob_overlay_icon = 'icons/roguetown/maniac/clothing_mob.dmi'
	icon_state = "pants"

/datum/outfit/treyliam
	name = "Trey Liam"
	head = /obj/item/clothing/head/roguetown/cyberdeck
	shirt = /obj/item/clothing/suit/roguetown/shirt/formal
	pants = /obj/item/clothing/under/roguetown/tights/formal

/obj/effect/landmark/treyliam
	name = "trey"

/obj/item/gun/ballistic/revolver/last_resort
	name = "\proper last resort"
	desc = "There is always a way out."
