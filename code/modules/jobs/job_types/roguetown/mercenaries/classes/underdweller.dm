// Meant for cave-races, less boons than other mercs but unique weapon + mining skill and helmet-torch combo. ALSO gets alchemy now for bomb-making.
/datum/advclass/mercenary/underdweller
	name = "Underdweller"
	tutorial = "A member of the Underdwellers, you've taken many of the deadliest contracts known to man in literal underground circles. Drow or Dwarf, you've put your differences aside for coin and adventure."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/dwarf/mountain,
		/datum/species/elf/dark,
		/datum/species/kobold,
		/datum/species/goblinp,				//Might be a little weird but goblins do reside in caves, and they could use a unique merc class type.
		/datum/species/anthromorphsmall,	//Basically all under-ground races. Perfect for cave-clearing.
	)
	outfit = /datum/outfit/job/roguetown/mercenary/underdweller
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_OUTLANDER)

/datum/outfit/job/roguetown/mercenary/underdweller/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/kettle/minershelm
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	gloves = /obj/item/clothing/gloves/roguetown/chain
	mask = /obj/item/clothing/mask/rogue/ragmask
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather/black		//Should give these guys a unique miners belt at some point..
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	beltl = /obj/item/rogueweapon/stoneaxe/woodcut/pick
	beltr = /obj/item/rogueweapon/huntingknife
	backl = /obj/item/storage/backpack/rogue/backpack
	backr = /obj/item/rogueweapon/shield/wood
	backpack_contents = list(
		/obj/item/roguekey/mercenary,
		/obj/item/storage/belt/rogue/pouch/coins/poor,
		/obj/item/bomb = 2,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)
	H.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mining, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)	//Gets this for bomb making.
	H.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/smelting, 2, TRUE)	//Accompanies mining; they know how to smelt, not make armor though.
	H.change_stat("fortune", 1)
	H.change_stat("strength", 1)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 2)
	H.change_stat("speed", 1)

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_WEBWALK, TRAIT_GENERIC)	//A cave dweller fears no spider.
	H.merctype = 12


//Clothing here to avoid overcrowding the hats.dm with snowflake gear. It's just a kettle with a light.
/obj/item/clothing/head/roguetown/helmet/kettle/minershelm
	name = "reinforced miners helmet"
	desc = "A rimmed miners helmet reinforced with leather atop its flimsy thin inner steel, its glowing lamp fueled by magiks from the depths."
	icon_state = "minerslamp"
	var/on = FALSE
	light_outer_range = 5 	//Same as a lamptern; can't be extinguished either.
	light_power = 1
	max_integrity = 250		//Slightly better integrity. Just because unique kettle. Plus class doesn't have much going for it traits-wise.
	light_color = LIGHT_COLOR_ORANGE
	light_system = MOVABLE_LIGHT

/obj/item/clothing/head/roguetown/helmet/kettle/minershelm/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/toggle_lamp.ogg', 100)
	toggle_helmet_light(user)
	to_chat(user, span_info("I toggle [src] [on ? "on" : "off"]."))

/obj/item/clothing/head/roguetown/helmet/kettle/minershelm/proc/toggle_helmet_light(mob/living/user)
	on = !on
	set_light_on(on)
	update_icon()

/obj/item/clothing/head/roguetown/helmet/kettle/minershelm/update_icon()
	icon_state = "minerslamp[on]"
	item_state = "minerslamp[on]"
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.update_inv_head()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon(force = TRUE)
	..()
