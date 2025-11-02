/datum/asset/spritesheet/pumpkin_carvings
	name = "pumpkin_carvings"

/datum/asset/spritesheet/pumpkin_carvings/create_spritesheets()
	for(var/obj/item/flashlight/flare/torch/lantern/pumpkin/P as anything in typesof(/obj/item/flashlight/flare/torch/lantern/pumpkin))
		var/icon = P::icon
		var/icon_state = P::icon_state

		if(!icon || !icon_state)
			continue

		Insert("[sanitize_css_class_name("carving_[REF(P)]")]", icon, icon_state)
