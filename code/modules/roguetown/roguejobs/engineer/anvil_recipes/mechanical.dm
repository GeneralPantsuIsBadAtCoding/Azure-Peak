/datum/anvil_recipe/engineering
	i_type = "Engineering"
	appro_skill = /datum/skill/craft/engineering
	craftdiff = 1

// --------- BRONZE RECIPES -----------

/datum/anvil_recipe/engineering/bronze/locks
	name = "Lock (x3)"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/customlock
	createditem_num = 3
	craftdiff = 1

/datum/anvil_recipe/engineering/bronze/keys
	name = "Keys (x3)"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/customblank
	createditem_num = 3
	craftdiff = 1

/datum/anvil_recipe/engineering/bronze/cog
	name = "Cog"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/roguegear
	craftdiff = 0

/datum/anvil_recipe/engineering/bronze/lamptern
	name = "Bronze Lamptern (x3)"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/flashlight/flare/torch/lantern/bronzelamptern
	createditem_num = 3
	craftdiff = 2

/datum/anvil_recipe/engineering/bronze/waterpurifier
	name = "Self-Purifying Waterskin (+1 Waterskin)"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/reagent_containers/glass/bottle/waterskin/purifier
	additional_items = list(/obj/item/reagent_containers/glass/bottle/waterskin)
	craftdiff = 3

/datum/anvil_recipe/engineering/bronze/minershelm
	name = "Miner's Helmet"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/clothing/head/roguetown/helmet/leather/minershelm
	craftdiff = 2

/datum/anvil_recipe/engineering/bronze/steelminerhelm
	name = "Steel Miner's Helmet (+1 Kettleman Helmet)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/clothing/head/roguetown/helmet/kettle)
	created_item = /obj/item/clothing/head/roguetown/helmet/kettle/miner
	craftdiff = 3

/datum/anvil_recipe/engineering/bronze/serfstone
	name = "Serfstone (+1 Steel)"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/scomstone/bad
	additional_items = list(/obj/item/ingot/steel)
	craftdiff = 3

/datum/anvil_recipe/engineering/bronze/scomstone
	name = "Scomstone (+1 Gold)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/scomstone
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/magic_horn
	name = "Enchanted Signal Horn"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/magic_horn
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/talkstone
	name = "Talkstone (+1 Gold, +1 Dorpel)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/gold, /obj/item/roguegem/diamond)
	created_item = /obj/item/clothing/neck/roguetown/talkstone
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/smokebomb
	name = "Smokepowder Ball (+1 Iron)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/smokebomb
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/musicbox
	name = "Dwarven Music Box (+1 Riddle of Steel)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/riddleofsteel, /obj/item/roguegear, /obj/item/roguegear)
	created_item = /obj/item/dmusicbox
	craftdiff = 6

// ------------ PROSTHETICS ----------------

/datum/anvil_recipe/engineering/bronze/prosthetic/bronzeleftarm
	name = "Bronze Left Arm (+1 Bronze, +2 Gear)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/roguegear, /obj/item/roguegear)
	created_item = /obj/item/bodypart/l_arm/prosthetic/bronzeleft
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/prosthetic/bronzerightarm
	name = "Bronze Right Arm (+1 Bronze, +2 Gear)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/roguegear, /obj/item/roguegear)
	created_item = /obj/item/bodypart/r_arm/prosthetic/bronzeright
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/prosthetic/bronzeleftleg
	name = "Bronze Left Leg (+1 Bronze, +2 Gear)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/roguegear, /obj/item/roguegear)
	created_item = /obj/item/bodypart/l_leg/prosthetic/bronzeleft
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/prosthetic/bronzerightleg
	name = "Bronze Right Leg (+1 Bronze, +2 Gear)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/roguegear, /obj/item/roguegear)
	created_item = /obj/item/bodypart/r_leg/prosthetic/bronzeright
	craftdiff = 4


// ------------ SMOKE BOMB ------------

/obj/item/smokebomb
	name = "ball of smokepowder"
	desc = "A strange, smooth round ball filled with a highly sensitive powder. Toss it onto the ground to ignite the powder inside and create a cloud of smoke around you!"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "cball"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/smokebomb/attack_self(mob/living/user)
	. = ..()
	user.visible_message(span_warning("[user] is about to toss the [src] onto the ground!"))
	if(do_after(user, 5))
		smokebomb(user)

/obj/item/smokebomb/proc/smokebomb(mob/living/user)
	new /obj/effect/particle_effect/smoke(get_turf(user))
	user.visible_message(span_warning("[user] tosses smokepowder onto the ground and vanishes in a puff of smoke!"), span_notice("I toss smokepowder onto the ground and vanish in a puff of smoke!"))
	playsound(user.loc, 'sound/misc/explode/incendiary (1).ogg', 50, FALSE, -1)
	animate(user, alpha = 0.1, time = 0.5 SECONDS, easing = EASE_IN)
	user.mob_timers[MT_INVISIBILITY] = world.time + 6 SECONDS
	addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE), 6 SECONDS)
	addtimer(CALLBACK(user, TYPE_PROC_REF(/atom/movable, visible_message), span_warning("[user] fades back into view."), span_warning("I become visible again.")), 6 SECONDS)
	qdel(src)
	return FALSE
