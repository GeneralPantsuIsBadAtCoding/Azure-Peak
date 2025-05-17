/obj/item/cooking/pan
	force = 20
	throwforce = 15
	possible_item_intents = list(/datum/intent/mace/strike/pan)
	name = "frypan"
	desc = "Two in one: Cook and smash heads."
	icon_state = "pan"
	wlength = WLENGTH_SHORT
	sharpness = IS_BLUNT
	//dropshrink = 0.8
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	can_parry = TRUE
	associated_skill = /datum/skill/craft/cooking // This make pan a "viable" weapon for cook with high hit / parry chance. Won't carry them alone ofc.
	has_inspect_verb = TRUE // For snowflake and allowing you to examine the pan's properties lmao
	swingsound = list('sound/combat/wooshes/blunt/shovel_swing.ogg','sound/combat/wooshes/blunt/shovel_swing2.ogg')
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	wdefense = 2
	ingsize = 3
	grid_width = 32
	grid_height = 64

/obj/item/cooking/pan/examine(mob/user)
	. = ..()

/datum/intent/mace/strike/pan
	hitsound = list('sound/combat/hits/blunt/frying_pan(1).ogg', 'sound/combat/hits/blunt/frying_pan(2).ogg', 'sound/combat/hits/blunt/frying_pan(3).ogg', 'sound/combat/hits/blunt/frying_pan(4).ogg')


/obj/item/cooking/pan/aalloy
	name = "decrepit pan"
	desc = "A decrepit old pan. Aeon's grasp is upon it."
	icon_state = "apan"
