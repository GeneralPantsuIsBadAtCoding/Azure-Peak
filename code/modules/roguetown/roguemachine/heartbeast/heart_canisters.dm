/obj/item/stone_canister
    name = "alchemical canister"
    desc = "A crystal canister that seems to pulse with latent energy. Use in-hand to choose an aspect to attune to."
    icon = 'icons/obj/structures/heart_beast.dmi'
    icon_state = "canister_empty"
    pixel_x = 0
    pixel_y = 0
    layer = ABOVE_MOB_LAYER
    
    var/obj/structure/stone_rack/parent_rack
    var/filled = FALSE
    var/current_color = "#ffffff"
    var/current_aspect_name = ""
    var/current_aspect_type = null
    var/required_item_type = null
    var/expected_color = "#ffffff"
    var/aspect_datum_ref = null
    var/attuned = FALSE
