/obj/item/clothing/head/roguetown/stewardtophat
	name = "top hat"
	icon_state = "stewardtophat"
	icon = 'modular_twilight_axis/icons/roguetown/clothing/special/noble.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64

/obj/item/clothing/head/roguetown/eaststrawhat
	name = "worn rice hat"
	desc = "A wicker rice hat."
	icon = 'modular_twilight_axis/icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/head.dmi'
	icon_state = "eaststrawhat"
	flags_inv = HIDEEARS
	var/hides_ears = TRUE

/obj/item/clothing/head/roguetown/eaststrawhat/MiddleClick(mob/user, params)
	. = ..()
	hides_ears = !hides_ears
	flags_inv = hides_ears ? HIDEEARS : null

/obj/item/clothing/head/roguetown/grenzelhofthat/decorated
	armor = null
	prevent_crits = null

/obj/item/clothing/head/roguetown/twilight_elven_hat
	name = "elven burka"
	desc = "A warm hat, designed to protect long elven ears from cold winds of northen Valoria."
	icon = 'modular_twilight_axis/icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/head_48.dmi'
	icon_state = "elven_hat"
	flags_inv = HIDEEARS
