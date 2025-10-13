/obj/item/clothing/neck/roguetown/collar/bell_collar
	icon = 'modular_twilight_axis/icons/obj/leashes_collars.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/mob/collars_leashes.dmi'

/obj/item/clothing/neck/roguetown/gorget/cursed_collar
	leashable = TRUE

// Crafting recipes for collars and leashes

/datum/crafting_recipe/roguetown/leather/neck/catbell_collar
	name = "catbell collar (1 cured leather, catbell)"
	result = /obj/item/clothing/neck/roguetown/collar/bell/catbell
	reqs = list(/obj/item/natural/hide/cured = 1, /obj/item/catbell = 1)
	tools = list(/obj/item/needle)
	time = 10 SECONDS
	category = "Leatherwork"
	subcategory = CAT_NONE
	always_availible = TRUE

/datum/crafting_recipe/roguetown/leather/neck/cowbell_collar
	name = "cowbell collar (1 curedleather, cowbell)"
	result = /obj/item/clothing/neck/roguetown/collar/bell/cowbell
	reqs = list(/obj/item/natural/hide/cured = 1, /obj/item/catbell/cow = 1)
	tools = list(/obj/item/needle)
	time = 10 SECONDS
	category = "Leatherwork"
	subcategory = CAT_NONE
	always_availible = TRUE


/datum/crafting_recipe/roguetown/leather/neck/leather_leash
	name = "leather leash (1 leather)"
	result = /obj/item/leash/leather
	reqs = list(/obj/item/natural/hide/cured = 1)
	tools = list(/obj/item/needle)
	time = 10 SECONDS
	category = "Leatherwork"
	subcategory = CAT_NONE
	always_availible = TRUE

/obj/item/clothing/neck/roguetown/loveamulet
	name = "tears of love amulet"
	desc = "This amulet is made in the southern county of the Black Empire called Sudstal. Faceted with black diamonds, this piece of jewelry symbolizes the pain and sadness that lies beneath the surface of happiness and tranquility."
	icon_state = "loveamulet"
	item_state = "loveamulet"
	icon = 'modular_twilight_axis/icons/roguetown/clothing/neck.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/roguetown/clothing/onmob/neck.dmi'
