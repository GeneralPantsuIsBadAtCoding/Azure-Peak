//Lazily shoving all donator fluff items in here for now. Feel free to make this a sub-folder or something, I think it's just easier to keep a list here and just modify as needed.

//Plexiant's donator item - rapier
/obj/item/rogueweapon/sword/rapier/aliseo
	name = "Rapier di Aliseo"
	desc = "A rapier of sporting a steel blade and decrotive silver-plating. Elaborately designed in classic intricate yet functional Etrucian style, the pummel appears to be embedded with a cut emerald with a family crest engraved in the fine leather grip of the handle."
	icon_state = "plex"
	icon = 'modular_azurepeak/icons/obj/items/donor_weapons_64.dmi'

//Ryebread's donator item - estoc
/obj/item/rogueweapon/estoc/worttrager
	name = "Wortträger"
	desc = "An imported Grenzelhoftian panzerstecher, a superbly crafted implement devoid of armory marks- merely bearing a maker's mark and the Zenitstadt seal. This one has a grip of walnut wood, and a pale saffira set within the crossguard. The ricasso is engraved with Ravoxian scripture."
	icon_state = "mansa"
	icon = 'modular_azurepeak/icons/obj/items/donor_weapons_64.dmi'

//Srusu's donator item - dress
/obj/item/clothing/suit/roguetown/shirt/dress/emerald
	name = "emerald dress"
	desc = "A silky smooth emerald-green dress, only for the finest of ladies."
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR	//Goes either slot, no armor on it after all.
	icon_state = "laciedress"
	sleevetype = "laciedress"
	icon = 'modular_azurepeak/icons/clothing/donor_clothes.dmi'
	mob_overlay_icon = 'modular_azurepeak/icons/clothing/onmob/donor_clothes.dmi'
	sleeved = 'modular_azurepeak/icons/clothing/onmob/donor_sleeves_armor.dmi'

//Strudles donator item - mage vest (same as robes)
/obj/item/clothing/suit/roguetown/shirt/robe/sofiavest
	name = "grenzelhoftian mages vest"
	desc = "A vest often worn by those of the Grenzelhoftian mages college."
	icon_state = "sofiavest"
	item_state = "sofiavest"
	sleevetype = "sofiavest"
	icon = 'modular_azurepeak/icons/clothing/donor_clothes.dmi'
	mob_overlay_icon = 'modular_azurepeak/icons/clothing/onmob/donor_clothes.dmi'
	sleeved = 'modular_azurepeak/icons/clothing/onmob/donor_sleeves_armor.dmi'
	flags_inv = HIDEBOOB
	color = null
	nodismemsleeves = TRUE // prevents sleeves from being torn

//Bat's donator item - custom harp sprite
/obj/item/rogue/instrument/harp/handcarved
	name = "handcrafted harp"
	desc = "A handcrafted harp."
	icon_state = "batharp"
	icon = 'modular_azurepeak/icons/obj/items/donor_objects.dmi'

//Rebel0's donator item - visored sallet with a hood on under it. (Same as normal sallet)
/obj/item/clothing/head/roguetown/helmet/sallet/visored/gilded
	name = "gilded visored sallet"
	desc = "A steel helmet with gilded trim which protects the ears, nose, and eyes."
	icon_state = "gildedsallet_visor"
	item_state = "gildedsallet_visor"
	icon = 'modular_azurepeak/icons/clothing/donor_clothes.dmi'
	mob_overlay_icon = 'modular_azurepeak/icons/clothing/onmob/donor_clothes.dmi'

//Zydras donator item - merchant dress
/obj/item/clothing/suit/roguetown/shirt/dress/silkydress/zydrasdress //Recolored silky dress
	name = "Gold-Black silky dress"
	desc = "A gorgeous black and gold dress. It seems the padding was removed."
	icon_state = "zydrasdress"
	item_state = "zydrasdress"
	sleevetype = "zydrasdress"
	icon = 'modular_azurepeak/icons/clothing/donor_clothes.dmi'
	mob_overlay_icon = 'modular_azurepeak/icons/clothing/onmob/donor_clothes.dmi'
	sleeved = 'modular_azurepeak/icons/clothing/onmob/donor_sleeves_armor.dmi' //No sleeves

//Eiren's donator item - custom zweihander
/obj/item/rogueweapon/greatsword/zwei/eiren
	name = "Regret"
	desc = "People bring the small flames of their wishes together... to keep them from burning out, we cast our own flames into the biggest fire we can find. But you know... I didn't bring a flame with me. As for me, maybe I just wandered up to the campfire to warm myself a little..."
	icon_state = "eiren"
	icon = 'modular_azurepeak/icons/obj/items/donor_weapons_64.dmi'

//pretzel's special sword
/obj/item/rogueweapon/greatsword/weeperslathe
	name = "Weeper's Lathe"
	desc = "A modern recreation of a gilbronze greatsword. Inscribed on the blade is a simple message: \"I have only a short time to lyve, but I am not afraid to die." 
	icon_state = "weeperslathe"
	icon = 'modular_azurepeak/icons/obj/items/donor_weapons_64.dmi'
