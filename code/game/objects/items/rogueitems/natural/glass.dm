/obj/item/natural/glass/shard
	name = "shard"
	desc = "A sharp shard of glass."
	icon = 'icons/obj/shards.dmi'
	icon_state = "large"
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/stab)
	force = 3
	throwforce = 5
	item_state = "shard-glass"
	resistance_flags = null
	w_class = WEIGHT_CLASS_TINY
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	attack_verb = list("stabbed", "slashed", "sliced", "cut")
	max_integrity = 40
	smeltresult = /obj/item/natural/glass
