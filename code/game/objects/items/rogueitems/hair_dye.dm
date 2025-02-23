/obj/item/hair_dye_cream
    name = "hair dye cream"
    desc = "A cream that can be used to dye and style hair with various colors and gradients."
    icon = 'icons/roguetown/items/misc.dmi'
    icon_state = "cream"
    w_class = WEIGHT_CLASS_SMALL
    var/uses_remaining = 10

/obj/item/hair_dye_cream/attack(mob/living/M, mob/living/user)
    if(!ishuman(M))
        return ..()
    
    var/mob/living/carbon/human/H = M
    if(uses_remaining <= 0)
        to_chat(user, span_warning("The cream is empty!"))
        icon_state = "empty_cream"
        return
    
    var/list/options = list("hair color", "facial hair color", "natural gradient", "natural gradient color", "dye gradient", "dye gradient color")
    var/chosen = input(user, "What would you like to dye?", "Hair Dyeing") as null|anything in options
    if(!chosen)
        return
    
    switch(chosen)
        if("hair color")
            var/new_hair_color = color_pick_sanitized_lumi(user, "Choose your hair color", "Hair Color", H.hair_color)
            if(new_hair_color)
                if(!do_after(user, 30 SECONDS, target = H))
                    to_chat(user, span_warning("The dyeing was interrupted!"))
                    return
                var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
                if(head && head.bodypart_features)
                    var/datum/customizer_choice/bodypart_feature/hair/head/humanoid/hair_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/head/humanoid)
                    var/datum/customizer_entry/hair/hair_entry = new()
                    
                    var/datum/bodypart_feature/hair/head/current_hair = null
                    for(var/datum/bodypart_feature/hair/head/hair_feature in head.bodypart_features)
                        current_hair = hair_feature
                        break
                    
                    if(current_hair)
                        // Copy ALL existing properties first
                        hair_entry.hair_color = sanitize_hexcolor(new_hair_color, 6, TRUE)
                        hair_entry.natural_gradient = current_hair.natural_gradient
                        hair_entry.natural_color = current_hair.natural_color
                        hair_entry.dye_gradient = current_hair.hair_dye_gradient
                        hair_entry.dye_color = current_hair.hair_dye_color
                        
                        var/datum/bodypart_feature/hair/head/new_hair = new()
                        new_hair.set_accessory_type(current_hair.accessory_type, null, H)
                        hair_choice.customize_feature(new_hair, H, null, hair_entry)
                        head.remove_bodypart_feature(current_hair)
                        head.add_bodypart_feature(new_hair)
                        use_cream()
                        H.update_body()
                        user.visible_message(span_notice("[user] dyes [H]'s hair."), span_notice("You dye [H == user ? "your" : "[H]'s"] hair."))

        if("facial hair color")
            var/new_facial_color = color_pick_sanitized_lumi(user, "Choose your facial hair color", "Facial Hair Color", H.facial_hair_color)
            if(new_facial_color)
                if(!do_after(user, 30 SECONDS, target = H))
                    to_chat(user, span_warning("The dyeing was interrupted!"))
                    return
                var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
                if(head && head.bodypart_features)
                    var/datum/customizer_choice/bodypart_feature/hair/facial/humanoid/facial_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/facial/humanoid)
                    var/datum/customizer_entry/hair/facial/facial_entry = new()
                    facial_entry.hair_color = sanitize_hexcolor(new_facial_color, 6, TRUE)
                    
                    var/datum/bodypart_feature/hair/facial/current_facial = null
                    for(var/datum/bodypart_feature/hair/facial/facial_feature in head.bodypart_features)
                        current_facial = facial_feature
                        break
                    
                    if(current_facial)
                        var/datum/bodypart_feature/hair/facial/new_facial = new()
                        new_facial.set_accessory_type(current_facial.accessory_type, null, H)
                        facial_choice.customize_feature(new_facial, H, null, facial_entry)
                        H.facial_hair_color = facial_entry.hair_color
                        H.dna.update_ui_block(DNA_FACIAL_HAIR_COLOR_BLOCK)
                        head.remove_bodypart_feature(current_facial)
                        head.add_bodypart_feature(new_facial)
                        use_cream()
                        H.update_body()
                        user.visible_message(span_notice("[user] dyes [H]'s facial hair."), span_notice("You dye [H == user ? "your" : "[H]'s"] facial hair."))

        if("natural gradient")
            var/list/gradient_options = hair_gradient_name_to_type_list()
            var/new_gradient = input(user, "Choose gradient style", "Hair Gradient") as null|anything in gradient_options
            if(new_gradient)
                if(!do_after(user, 30 SECONDS, target = H))
                    to_chat(user, span_warning("The dyeing was interrupted!"))
                    return
                var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
                if(head && head.bodypart_features)
                    for(var/datum/bodypart_feature/hair/head/hair_feature in head.bodypart_features)
                        hair_feature.natural_gradient = gradient_options[new_gradient]
                        use_cream()
                        H.update_body()
                        user.visible_message(span_notice("[user] applies a gradient to [H]'s hair."), span_notice("You apply a gradient to [H == user ? "your" : "[H]'s"] hair."))
                        break

        if("natural gradient color")
            var/new_gradient_color = color_pick_sanitized_lumi(user, "Choose gradient color", "Hair Gradient Color", "#FFFFFF")
            if(new_gradient_color)
                if(!do_after(user, 30 SECONDS, target = H))
                    to_chat(user, span_warning("The dyeing was interrupted!"))
                    return
                var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
                if(head && head.bodypart_features)
                    for(var/datum/bodypart_feature/hair/head/hair_feature in head.bodypart_features)
                        hair_feature.natural_color = sanitize_hexcolor(new_gradient_color)
                        use_cream()
                        H.update_body()
                        user.visible_message(span_notice("[user] dyes [H]'s hair gradient."), span_notice("You dye [H == user ? "your" : "[H]'s"] hair gradient."))
                        break

        if("dye gradient")
            var/list/gradient_options = hair_gradient_name_to_type_list()
            var/new_gradient = input(user, "Choose dye gradient style", "Hair Dye Gradient") as null|anything in gradient_options
            if(new_gradient)
                if(!do_after(user, 30 SECONDS, target = H))
                    to_chat(user, span_warning("The dyeing was interrupted!"))
                    return
                var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
                if(head && head.bodypart_features)
                    var/datum/customizer_choice/bodypart_feature/hair/head/humanoid/hair_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/head/humanoid)
                    
                    var/datum/customizer_entry/hair/hair_entry = new()
                    
                    var/datum/bodypart_feature/hair/head/current_hair = null
                    for(var/datum/bodypart_feature/hair/head/hair_feature in head.bodypart_features)
                        current_hair = hair_feature
                        break
                    
                    if(current_hair)
                        hair_entry.hair_color = current_hair.hair_color
                        hair_entry.natural_gradient = current_hair.natural_gradient
                        hair_entry.natural_color = current_hair.natural_color
                        hair_entry.dye_gradient = gradient_options[new_gradient]
                        hair_entry.dye_color = current_hair.hair_dye_color
                        
                        var/datum/bodypart_feature/hair/head/new_hair = new()
                        new_hair.set_accessory_type(current_hair.accessory_type, null, H)
                        hair_choice.customize_feature(new_hair, H, null, hair_entry)
                        head.remove_bodypart_feature(current_hair)
                        head.add_bodypart_feature(new_hair)
                        use_cream()
                        H.update_body()
                        user.visible_message(span_notice("[user] applies a dye gradient to [H]'s hair."), span_notice("You apply a dye gradient to [H == user ? "your" : "[H]'s"] hair."))

        if("dye gradient color")
            var/new_gradient_color = color_pick_sanitized_lumi(user, "Choose dye gradient color", "Hair Dye Gradient Color", "#FFFFFF")
            if(new_gradient_color)
                if(!do_after(user, 30 SECONDS, target = H))
                    to_chat(user, span_warning("The dyeing was interrupted!"))
                    return
                var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
                if(head && head.bodypart_features)
                    var/datum/customizer_choice/bodypart_feature/hair/head/humanoid/hair_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/head/humanoid)
                    
                    var/datum/customizer_entry/hair/hair_entry = new()
                    
                    var/datum/bodypart_feature/hair/head/current_hair = null
                    for(var/datum/bodypart_feature/hair/head/hair_feature in head.bodypart_features)
                        current_hair = hair_feature
                        break
                    
                    if(current_hair)
                        hair_entry.hair_color = current_hair.hair_color
                        hair_entry.natural_gradient = current_hair.natural_gradient
                        hair_entry.natural_color = current_hair.natural_color
                        hair_entry.dye_gradient = current_hair.hair_dye_gradient
                        hair_entry.dye_color = sanitize_hexcolor(new_gradient_color, 6, TRUE)
                        
                        var/datum/bodypart_feature/hair/head/new_hair = new()
                        new_hair.set_accessory_type(current_hair.accessory_type, null, H)
                        hair_choice.customize_feature(new_hair, H, null, hair_entry)
                        head.remove_bodypart_feature(current_hair)
                        head.add_bodypart_feature(new_hair)
                        use_cream()
                        H.update_body()
                        user.visible_message(span_notice("[user] dyes [H]'s hair dye gradient."), span_notice("You dye [H == user ? "your" : "[H]'s"] hair dye gradient."))

/obj/item/hair_dye_cream/proc/use_cream()
    uses_remaining--
    if(uses_remaining <= 0)
        icon_state = "empty_cream"
    else if(uses_remaining <= 5)
        icon_state = "low_cream" 
