//wip wip wup
/obj/structure/mirror
	name = "mirror"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "mirror"
	density = FALSE
	anchored = TRUE
	max_integrity = 200
	integrity_failure = 0.9
	break_sound = "glassbreak"
	attacked_sound = 'sound/combat/hits/onglass/glasshit.ogg'
	pixel_y = 32

/obj/structure/mirror/fancy
	icon_state = "fancymirror"
	pixel_y = 32

/obj/structure/mirror/Initialize(mapload)
	. = ..()
	if(icon_state == "mirror_broke" && !broken)
		obj_break(null, mapload)

/obj/structure/mirror/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	
	if(!HAS_TRAIT(H, TRAIT_MIRROR_MAGIC))
		to_chat(H, span_warning("You look into the mirror but see only your normal reflection."))
		return
	
	if(broken || !Adjacent(user))
		return

	var/should_update = FALSE
	var/list/options = list("hairstyle", "facial hairstyle", "hair color", "facial hair color", "skin color", "eye color", 
						   "natural gradient", "natural gradient color", "dye gradient", "dye gradient color", "accessory", "face detail",
						   "body type", "penis", "testicles", "breasts", "vagina")
	var/chosen = input(user, "Change what?", "Appearance") as null|anything in options
	
	if(!chosen)
		return
		
	switch(chosen)
		if("hairstyle")
			var/datum/customizer_choice/bodypart_feature/hair/head/humanoid/hair_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/head/humanoid)
			var/list/valid_hairstyles = list()
			for(var/hair_type in hair_choice.sprite_accessories)
				var/datum/sprite_accessory/hair/head/hair = new hair_type()
				valid_hairstyles[hair.name] = hair_type
			
			var/new_style = input(user, "Choose your hairstyle", "Hair Styling") as null|anything in valid_hairstyles
			if(new_style)
				var/datum/bodypart_feature/hair/head/hair_feature = new()
				hair_feature.set_accessory_type(valid_hairstyles[new_style], H.hair_color, H)
				H.add_bodypart_feature(hair_feature)
				should_update = TRUE

		if("hair color")
			var/new_hair_color = color_pick_sanitized_lumi(user, "Choose your hair color", "Hair Color", H.hair_color)
			if(new_hair_color)
				var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
				if(head && head.bodypart_features)
					// Get the customizer choice that handles hair
					var/datum/customizer_choice/bodypart_feature/hair/head/humanoid/hair_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/head/humanoid)
					
					// Create a temporary customizer entry with the new color
					var/datum/customizer_entry/hair/hair_entry = new()
					hair_entry.hair_color = sanitize_hexcolor(new_hair_color, 6, TRUE)
					
					// Get current hair feature for its properties
					var/datum/bodypart_feature/hair/head/current_hair = null
					for(var/datum/bodypart_feature/hair/head/hair_feature in head.bodypart_features)
						current_hair = hair_feature
						break
					
					if(current_hair)
						// Create new feature
						var/datum/bodypart_feature/hair/head/new_hair = new()
						
						// Set accessory type first
						new_hair.set_accessory_type(current_hair.accessory_type, null, H)
						
						// Use the customizer's method to set colors
						hair_choice.customize_feature(new_hair, H, null, hair_entry)
						
						// Update DNA
						H.hair_color = hair_entry.hair_color
						H.dna.update_ui_block(DNA_HAIR_COLOR_BLOCK)
						
						// Remove old and add new feature
						head.remove_bodypart_feature(current_hair)
						head.add_bodypart_feature(new_hair)
						should_update = TRUE

		if("facial hair color")
			var/new_facial_color = color_pick_sanitized_lumi(user, "Choose your facial hair color", "Facial Hair Color", H.facial_hair_color)
			if(new_facial_color)
				var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
				if(head && head.bodypart_features)
					// Get the customizer choice that handles facial hair
					var/datum/customizer_choice/bodypart_feature/hair/facial/humanoid/facial_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/facial/humanoid)
					
					// Create a temporary customizer entry with the new color
					var/datum/customizer_entry/hair/facial/facial_entry = new()
					facial_entry.hair_color = sanitize_hexcolor(new_facial_color, 6, TRUE)
					
					// Get current facial hair feature for its properties
					var/datum/bodypart_feature/hair/facial/current_facial = null
					for(var/datum/bodypart_feature/hair/facial/facial_feature in head.bodypart_features)
						current_facial = facial_feature
						break
					
					if(current_facial)
						// Create new feature
						var/datum/bodypart_feature/hair/facial/new_facial = new()
						
						// Set accessory type first
						new_facial.set_accessory_type(current_facial.accessory_type, null, H)
						
						// Use the customizer's method to set colors
						facial_choice.customize_feature(new_facial, H, null, facial_entry)
						
						// Update DNA
						H.facial_hair_color = facial_entry.hair_color
						H.dna.update_ui_block(DNA_FACIAL_HAIR_COLOR_BLOCK)
						
						// Remove old and add new feature
						head.remove_bodypart_feature(current_facial)
						head.add_bodypart_feature(new_facial)
						should_update = TRUE

		if("skin color")
			var/new_skin_color = color_pick_sanitized_lumi(user, "Choose your skin color", "Skin Color", H.skin_tone)
			if(new_skin_color)
				H.skin_tone = sanitize_hexcolor(new_skin_color)
				H.dna.update_ui_block(DNA_SKIN_TONE_BLOCK)
				H.update_body()
				should_update = TRUE

		if("eye color")
			var/new_eye_color = color_pick_sanitized_lumi(user, "Choose your eye color", "Eye Color", H.eye_color)
			if(new_eye_color)
				H.eye_color = sanitize_hexcolor(new_eye_color)
				H.dna.update_ui_block(DNA_EYE_COLOR_BLOCK)
				H.update_body()
				should_update = TRUE

		if("natural gradient")
			var/list/gradient_options = hair_gradient_name_to_type_list()
			var/new_gradient = input(user, "Choose your natural gradient style", "Hair Gradient") as null|anything in gradient_options
			if(new_gradient)
				var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
				if(head && head.bodypart_features)
					// Get the customizer choice that handles hair
					var/datum/customizer_choice/bodypart_feature/hair/head/humanoid/hair_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/head/humanoid)
					
					// Create a temporary customizer entry
					var/datum/customizer_entry/hair/hair_entry = new()
					
					// Get current hair feature for its properties
					var/datum/bodypart_feature/hair/head/current_hair = null
					for(var/datum/bodypart_feature/hair/head/hair_feature in head.bodypart_features)
						current_hair = hair_feature
						break
					
					if(current_hair)
						// Copy existing properties to entry
						hair_entry.hair_color = current_hair.hair_color
						hair_entry.natural_gradient = gradient_options[new_gradient]
						hair_entry.natural_color = current_hair.natural_color
						hair_entry.dye_gradient = current_hair.hair_dye_gradient
						hair_entry.dye_color = current_hair.hair_dye_color
						
						// Create new feature
						var/datum/bodypart_feature/hair/head/new_hair = new()
						
						// Set accessory type first
						new_hair.set_accessory_type(current_hair.accessory_type, null, H)
						
						// Use the customizer's method to set properties
						hair_choice.customize_feature(new_hair, H, null, hair_entry)
						
						// Remove old and add new feature
						head.remove_bodypart_feature(current_hair)
						head.add_bodypart_feature(new_hair)
						should_update = TRUE

		if("natural gradient color")
			var/new_gradient_color = color_pick_sanitized_lumi(user, "Choose your natural gradient color", "Gradient Color", "#FFFFFF")
			if(new_gradient_color)
				var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
				if(head && head.bodypart_features)
					// Get the customizer choice that handles hair
					var/datum/customizer_choice/bodypart_feature/hair/head/humanoid/hair_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/head/humanoid)
					
					// Create a temporary customizer entry
					var/datum/customizer_entry/hair/hair_entry = new()
					
					// Get current hair feature for its properties
					var/datum/bodypart_feature/hair/head/current_hair = null
					for(var/datum/bodypart_feature/hair/head/hair_feature in head.bodypart_features)
						current_hair = hair_feature
						break
					
					if(current_hair)
						// Copy existing properties to entry
						hair_entry.hair_color = current_hair.hair_color
						hair_entry.natural_gradient = current_hair.natural_gradient
						hair_entry.natural_color = sanitize_hexcolor(new_gradient_color, 6, TRUE)
						hair_entry.dye_gradient = current_hair.hair_dye_gradient
						hair_entry.dye_color = current_hair.hair_dye_color
						
						// Create new feature
						var/datum/bodypart_feature/hair/head/new_hair = new()
						
						// Set accessory type first
						new_hair.set_accessory_type(current_hair.accessory_type, null, H)
						
						// Use the customizer's method to set properties
						hair_choice.customize_feature(new_hair, H, null, hair_entry)
						
						// Remove old and add new feature
						head.remove_bodypart_feature(current_hair)
						head.add_bodypart_feature(new_hair)
						should_update = TRUE

		if("dye gradient")
			var/list/gradient_options = hair_gradient_name_to_type_list()
			var/new_gradient = input(user, "Choose your dye gradient style", "Hair Gradient") as null|anything in gradient_options
			if(new_gradient)
				var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
				if(head && head.bodypart_features)
					// Get the customizer choice that handles hair
					var/datum/customizer_choice/bodypart_feature/hair/head/humanoid/hair_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/head/humanoid)
					
					// Create a temporary customizer entry
					var/datum/customizer_entry/hair/hair_entry = new()
					
					// Get current hair feature for its properties
					var/datum/bodypart_feature/hair/head/current_hair = null
					for(var/datum/bodypart_feature/hair/head/hair_feature in head.bodypart_features)
						current_hair = hair_feature
						break
					
					if(current_hair)
						// Copy existing properties to entry
						hair_entry.hair_color = current_hair.hair_color
						hair_entry.natural_gradient = current_hair.natural_gradient
						hair_entry.natural_color = current_hair.natural_color
						hair_entry.dye_gradient = gradient_options[new_gradient]
						hair_entry.dye_color = current_hair.hair_dye_color
						
						// Create new feature
						var/datum/bodypart_feature/hair/head/new_hair = new()
						
						// Set accessory type first
						new_hair.set_accessory_type(current_hair.accessory_type, null, H)
						
						// Use the customizer's method to set properties
						hair_choice.customize_feature(new_hair, H, null, hair_entry)
						
						// Remove old and add new feature
						head.remove_bodypart_feature(current_hair)
						head.add_bodypart_feature(new_hair)
						should_update = TRUE

		if("dye gradient color")
			var/new_gradient_color = color_pick_sanitized_lumi(user, "Choose your dye gradient color", "Gradient Color", "#FFFFFF")
			if(new_gradient_color)
				var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
				if(head && head.bodypart_features)
					// Get the customizer choice that handles hair
					var/datum/customizer_choice/bodypart_feature/hair/head/humanoid/hair_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/head/humanoid)
					
					// Create a temporary customizer entry
					var/datum/customizer_entry/hair/hair_entry = new()
					
					// Get current hair feature for its properties
					var/datum/bodypart_feature/hair/head/current_hair = null
					for(var/datum/bodypart_feature/hair/head/hair_feature in head.bodypart_features)
						current_hair = hair_feature
						break
					
					if(current_hair)
						// Copy existing properties to entry
						hair_entry.hair_color = current_hair.hair_color
						hair_entry.natural_gradient = current_hair.natural_gradient
						hair_entry.natural_color = current_hair.natural_color
						hair_entry.dye_gradient = current_hair.hair_dye_gradient
						hair_entry.dye_color = sanitize_hexcolor(new_gradient_color, 6, TRUE)
						
						// Create new feature
						var/datum/bodypart_feature/hair/head/new_hair = new()
						
						// Set accessory type first
						new_hair.set_accessory_type(current_hair.accessory_type, null, H)
						
						// Use the customizer's method to set properties
						hair_choice.customize_feature(new_hair, H, null, hair_entry)
						
						// Remove old and add new feature
						head.remove_bodypart_feature(current_hair)
						head.add_bodypart_feature(new_hair)
						should_update = TRUE

		if("facial hairstyle")
			var/datum/customizer_choice/bodypart_feature/hair/facial/humanoid/facial_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/facial/humanoid)
			var/list/valid_facial_hairstyles = list()
			for(var/facial_type in facial_choice.sprite_accessories)
				var/datum/sprite_accessory/hair/facial/facial = new facial_type()
				valid_facial_hairstyles[facial.name] = facial_type
			
			var/new_style = input(user, "Choose your facial hairstyle", "Hair Styling") as null|anything in valid_facial_hairstyles
			if(new_style)
				var/datum/bodypart_feature/hair/facial/facial_feature = new()
				facial_feature.set_accessory_type(valid_facial_hairstyles[new_style], H.facial_hair_color, H)
				H.add_bodypart_feature(facial_feature)
				should_update = TRUE

		if("accessory")
			var/datum/customizer_choice/bodypart_feature/accessory/accessory_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/accessory)
			var/list/valid_accessories = list()
			for(var/accessory_type in accessory_choice.sprite_accessories)
				var/datum/sprite_accessory/accessory/acc = new accessory_type()
				valid_accessories[acc.name] = accessory_type
			
			var/new_style = input(user, "Choose your accessory", "Accessory Styling") as null|anything in valid_accessories
			if(new_style)
				var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
				if(head && head.bodypart_features)
					// Create new feature
					var/datum/bodypart_feature/accessory/accessory_feature = new()
					
					// Set accessory type
					accessory_feature.set_accessory_type(valid_accessories[new_style], H.hair_color, H)
					
					// Remove old accessory if it exists
					for(var/datum/bodypart_feature/accessory/old_acc in head.bodypart_features)
						head.remove_bodypart_feature(old_acc)
						break
					
					// Add new accessory
					head.add_bodypart_feature(accessory_feature)
					should_update = TRUE

		if("face detail")
			var/datum/customizer_choice/bodypart_feature/face_detail/face_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/face_detail)
			var/list/valid_details = list()
			for(var/detail_type in face_choice.sprite_accessories)
				var/datum/sprite_accessory/face_detail/detail = new detail_type()
				valid_details[detail.name] = detail_type
			
			var/new_detail = input(user, "Choose your face detail", "Face Detail") as null|anything in valid_details
			if(new_detail)
				var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
				if(head && head.bodypart_features)
					// Create new feature
					var/datum/bodypart_feature/face_detail/detail_feature = new()
					
					// Set detail type
					detail_feature.set_accessory_type(valid_details[new_detail], H.hair_color, H)
					
					// Remove old detail if it exists
					for(var/datum/bodypart_feature/face_detail/old_detail in head.bodypart_features)
						head.remove_bodypart_feature(old_detail)
						break
					
					// Add new detail
					head.add_bodypart_feature(detail_feature)
					should_update = TRUE

		if("body type")
			var/new_gender = input(user, "Choose your body type:", "Body Type")
			if(new_gender)
				switch(new_gender)
					if("masculine")
						H.gender = MALE
					if("feminine")
						H.gender = FEMALE
				H.dna.update_ui_block(DNA_GENDER_BLOCK)
				H.update_body()
				H.update_body_parts()
				should_update = TRUE

		if("penis")
			// First select the type
			var/list/valid_penis_types = list()
			for(var/penis_path in subtypesof(/datum/sprite_accessory/penis))
				var/datum/sprite_accessory/penis/penis = new penis_path()
				valid_penis_types[penis.name] = penis_path
			
			var/new_style = input(user, "Choose your penis type", "Penis Customization") as null|anything in valid_penis_types
			if(new_style)
				var/obj/item/organ/penis/penis = H.getorganslot(ORGAN_SLOT_PENIS)
				if(penis)
					// Set the type
					penis.accessory_type = valid_penis_types[new_style]
					
					// Then select the size
					var/list/size_options = list("small", "medium", "large")
					var/size_choice = input(user, "Choose penis size", "Penis Customization") as null|anything in size_options
					if(size_choice)
						switch(size_choice)
							if("small")
								penis.penis_size = 1
							if("medium")
								penis.penis_size = 2
							if("large")
								penis.penis_size = 3
						
						// Match skin tone
						penis.color = H.skin_tone
						should_update = TRUE

		if("testicles")
			var/list/valid_testicle_types = list()
			for(var/testicle_path in subtypesof(/datum/sprite_accessory/testicles))
				var/datum/sprite_accessory/testicles/testicles = new testicle_path()
				valid_testicle_types[testicles.name] = testicle_path
			
			var/new_style = input(user, "Choose your testicles type", "Testicles Customization") as null|anything in valid_testicle_types
			if(new_style)
				var/obj/item/organ/testicles/testicles = H.getorganslot(ORGAN_SLOT_TESTICLES)
				if(testicles)
					testicles.accessory_type = valid_testicle_types[new_style]
					H.update_body()
					should_update = TRUE

		if("breasts")
			// First select the type
			var/list/valid_breast_types = list()
			for(var/breast_path in subtypesof(/datum/sprite_accessory/breasts))
				var/datum/sprite_accessory/breasts/breasts = new breast_path()
				valid_breast_types[breasts.name] = breast_path
			
			var/new_style = input(user, "Choose your breast type", "Breast Customization") as null|anything in valid_breast_types
			if(new_style)
				var/obj/item/organ/breasts/breasts = H.getorganslot(ORGAN_SLOT_BREASTS)
				if(breasts)
					// Set the type
					breasts.accessory_type = valid_breast_types[new_style]
					
					// Then select the size
					var/list/size_options = list("small", "medium", "large")
					var/size_choice = input(user, "Choose breast size", "Breast Customization") as null|anything in size_options
					if(size_choice)
						switch(size_choice)
							if("small")
								breasts.breast_size = 1
							if("medium")
								breasts.breast_size = 2
							if("large")
								breasts.breast_size = 3
						
						// Match skin tone
						breasts.color = H.skin_tone
						should_update = TRUE

		if("vagina")
			var/list/valid_vagina_types = list()
			for(var/vagina_path in subtypesof(/datum/sprite_accessory/vagina))
				var/datum/sprite_accessory/vagina/vagina = new vagina_path()
				valid_vagina_types[vagina.name] = vagina_path
			
			var/new_style = input(user, "Choose your vagina type", "Vagina Customization") as null|anything in valid_vagina_types
			if(new_style)
				var/obj/item/organ/vagina/vagina = H.getorganslot(ORGAN_SLOT_VAGINA)
				if(vagina)
					vagina.accessory_type = valid_vagina_types[new_style]
					H.update_body()
					should_update = TRUE

	if(should_update)
		H.update_hair()
		H.update_body()
		H.update_body_parts()

/obj/structure/mirror/examine_status(mob/user)
	if(broken)
		return list()// no message spam
	return ..()

/obj/structure/mirror/obj_break(damage_flag, mapload)
	if(!broken && !(flags_1 & NODECONSTRUCT_1))
		icon_state = "[icon_state]1"
		if(!mapload)
			new /obj/item/natural/glass/shard (get_turf(src))
		broken = TRUE
	..()

/obj/structure/mirror/deconstruct(disassembled = TRUE)
//	if(!(flags_1 & NODECONSTRUCT_1))
//		if(!disassembled)
//			new /obj/item/shard( src.loc )
	..()

/obj/structure/mirror/welder_act(mob/living/user, obj/item/I)
	..()
	if(user.used_intent.type == INTENT_HARM)
		return FALSE

	if(!broken)
		return TRUE

	if(!I.tool_start_check(user, amount=0))
		return TRUE

	to_chat(user, span_notice("I begin repairing [src]..."))
	if(I.use_tool(src, user, 10, volume=50))
		to_chat(user, span_notice("I repair [src]."))
		broken = 0
		icon_state = initial(icon_state)
		desc = initial(desc)

	return TRUE


/obj/structure/mirror/magic
	name = "magic mirror"
	desc = ""
	icon_state = "magic_mirror"
	var/list/choosable_races = list()

/obj/structure/mirror/magic/New()
	if(!choosable_races.len)
		for(var/speciestype in subtypesof(/datum/species))
			var/datum/species/S = speciestype
			if(initial(S.changesource_flags) & MIRROR_MAGIC)
				choosable_races += initial(S.id)
		choosable_races = sortList(choosable_races)
	..()

/obj/structure/mirror/magic/lesser/New()
	var/list/selectable_species = get_selectable_species()
	choosable_races = selectable_species.Copy()
	..()

/obj/structure/mirror/magic/badmin/New()
	for(var/speciestype in subtypesof(/datum/species))
		var/datum/species/S = speciestype
		if(initial(S.changesource_flags) & MIRROR_BADMIN)
			choosable_races += initial(S.id)
	..()

/obj/structure/mirror/magic/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	var/should_update = FALSE

	var/choice = input(user, "Something to change?", "Magical Grooming") as null|anything in list("name", "race", "gender", "hair", "eyes")

	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	switch(choice)
		if("name")
			var/newname = copytext(sanitize_name(input(H, "Who are we again?", "Name change", H.name) as null|text),1,MAX_NAME_LEN)

			if(!newname)
				return
			if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
				return
			H.real_name = newname
			H.name = newname
			if(H.dna)
				H.dna.real_name = newname
			if(H.mind)
				H.mind.name = newname

		if("race")
			var/newrace
			var/racechoice = input(H, "What are we again?", "Race change") as null|anything in choosable_races
			newrace = GLOB.species_list[racechoice]

			if(!newrace)
				return
			if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
				return
			H.set_species(newrace, icon_update=0)

			if(H.dna.species.use_skintones)
				var/new_s_tone = input(user, "Choose your skin tone:", "Race change")  as null|anything in GLOB.skin_tones
				if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
					return

				if(new_s_tone)
					H.skin_tone = new_s_tone
					H.dna.update_ui_block(DNA_SKIN_TONE_BLOCK)

			if(MUTCOLORS in H.dna.species.species_traits)
				var/new_mutantcolor = input(user, "Choose your skin color:", "Race change","#"+H.dna.features["mcolor"]) as color|null
				if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
					return
				if(new_mutantcolor)
					var/temp_hsv = RGBtoHSV(new_mutantcolor)

					if(ReadHSV(temp_hsv)[3] >= ReadHSV("#7F7F7F")[3]) // mutantcolors must be bright
						H.dna.features["mcolor"] = sanitize_hexcolor(new_mutantcolor)

					else
						to_chat(H, span_notice("Invalid color. Your color is not bright enough."))

			H.update_body()
			H.update_hair()
			H.update_body_parts()

		if("gender")
			if(!(H.gender in list("male", "female"))) //blame the patriarchy
				return
			if(H.gender == "male")
				if(alert(H, "Become a Witch?", "Confirmation", "Yes", "No") == "Yes")
					if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
						return
					H.gender = "female"
					to_chat(H, span_notice("Man, you feel like a woman!"))
				else
					return

			else
				if(alert(H, "Become a Warlock?", "Confirmation", "Yes", "No") == "Yes")
					if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
						return
					H.gender = "male"
					to_chat(H, span_notice("Whoa man, you feel like a man!"))
				else
					return
			H.dna.update_ui_block(DNA_GENDER_BLOCK)
			H.update_body()

		if("hair")
			var/hairchoice = alert(H, "Hairstyle or hair color?", "Change Hair", "Style", "Color")
			if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
				return
			if(hairchoice == "Style") //So you just want to use a mirror then?
				..()
			else
				var/new_hair_color = input(H, "Choose your hair color", "Hair Color","#"+H.hair_color) as color|null
				if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
					return
				if(new_hair_color)
					H.hair_color = sanitize_hexcolor(new_hair_color)
					H.facial_hair_color = H.hair_color
					H.dna.update_ui_block(DNA_HAIR_COLOR_BLOCK)
				if(H.gender == "male")
					var/new_face_color = input(H, "Choose your facial hair color", "Hair Color","#"+H.facial_hair_color) as color|null
					if(new_face_color)
						H.facial_hair_color = sanitize_hexcolor(new_face_color)
						H.dna.update_ui_block(DNA_FACIAL_HAIR_COLOR_BLOCK)
				H.update_hair()

		if("eyes")
			var/new_eye_color = input(H, "Choose your eye color", "Eye Color","#"+H.eye_color) as color|null
			if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
				return
			if(new_eye_color)
				// Get the customizer choice that handles eyes
				var/datum/customizer_choice/organ/eyes/humanoid/eye_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/organ/eyes/humanoid)
				if(eye_choice)
					// Get current eye organ
					var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
					if(eyes)
						eyes.eye_color = sanitize_hexcolor(new_eye_color)
						H.eye_color = eyes.eye_color
						H.dna.update_ui_block(DNA_EYE_COLOR_BLOCK)
						H.update_body()
						should_update = TRUE

	if(should_update)
		H.update_body()

/obj/structure/mirror/magic/proc/curse(mob/living/user)
	return
