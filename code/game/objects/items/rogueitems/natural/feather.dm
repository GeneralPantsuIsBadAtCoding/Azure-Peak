
/obj/item/natural/feather
	name = "feather"
	icon_state = "feather"
	possible_item_intents = list(/datum/intent/use)
	desc = "A fluffy feather."
	force = 0
	throwforce = 0
	obj_flags = null
	firefuel = null
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	body_parts_covered = null
	experimental_onhip = TRUE
	max_integrity = 20
	muteinmouth = TRUE
	spitoutmouth = FALSE
	w_class = WEIGHT_CLASS_TINY

//reproduces some code from pens so that we can utilize feathers for renaming objects

/obj/item/natural/feather/afterattack(obj/O, mob/living/user, proximity)
	. = ..()
	if(isobj(O) && proximity && (O.obj_flags & UNIQUE_RENAME))
		var/penchoice = input(user, "What would you like to edit?", "Rename or change description?") as null|anything in list("Rename","Change description")
		if(QDELETED(O) || !user.canUseTopic(O, BE_CLOSE))
			return
		if(penchoice == "Rename")
			var/input = stripped_input(user,"What do you want to name \the [O.name]?", ,"", MAX_NAME_LEN)
			var/oldname = O.name
			if(QDELETED(O) || !user.canUseTopic(O, BE_CLOSE))
				return
			if(oldname == input)
				to_chat(user, span_notice("I changed \the [O.name] to... well... \the [O.name]."))
			else
				O.name = "[input] ([oldname])"
				to_chat(user, span_notice("\The [oldname] has been successfully been renamed to \the [input]."))
				O.renamedByPlayer = TRUE

		if(penchoice == "Change description")
			var/input = stripped_input(user,"Describe \the [O.name] here", ,"", 100)
			if(QDELETED(O) || !user.canUseTopic(O, BE_CLOSE))
				return
			O.desc = input
			to_chat(user, span_notice("I have successfully changed \the [O.name]'s description."))
