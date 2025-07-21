

/*Enchantment scrolls here. Here enchantment scroll has a component. Refer to magic_items.dm, and it's various subfolders for differant enchantment datums.
T1 Enchantments below here*/

/obj/item/enchantmentscroll
	name = "scroll of enchanting"
	desc = "A scroll imbued with an arcane enchantment. Can be used on certain items to imbue them."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "enchantment"
	var/component
	possible_item_intents = list(/datum/intent/use)

/obj/item/enchantmentscroll/attack_obj(obj/item/O, mob/living/user)
	var/datum/component/magic_item/M = O.GetComponent(/datum/component/magic_item, component)
	if(M)
		if(length(M.magical_effects) >= M.enchanting_capacity)
			to_chat(user, span_warning("This item is already enchanted to its full capacity."))
			return FALSE
	return TRUE

/obj/item/enchantmentscroll/woodcut
	name = "enchanting scroll of woodcutting"
	desc = "A scroll imbued with an enchantment of woodcutting. Good for cutting wood."
	component = /datum/magic_item/mundane/woodcut

/obj/item/enchantmentscroll/woodcut/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/rogueweapon/stoneaxe))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of woodcutting"
		qdel(src)
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/mining
	name = "enchanting scroll of mining"
	desc = "A scroll imbued with an enchantment of mining. Good for mining rock."
	component = /datum/magic_item/mundane/mining

/obj/item/enchantmentscroll/mining/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/rogueweapon/pick))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of mining"
		qdel(src)
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/xylix
	name = "enchanting scroll of xylix's grace"
	desc = "A scroll imbued with an enchantment of luck. Grants luck to its wearer."
	component = /datum/magic_item/mundane/xylix

/obj/item/enchantmentscroll/xylix/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/clothing))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of xylixs grace"
		qdel(src)
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/light
	name = "enchanting scroll of unyielding light"
	desc = "A scroll imbued with an enchantment of unyielding light. Causes an enchanted item to glow with light."
	component = /datum/magic_item/mundane/unyieldinglight

/obj/item/enchantmentscroll/light/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/clothing)|| istype(O,/obj/item/rogueweapon))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of unyielding light"
		qdel(src)
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/holding
	name = "enchanting scroll of storage"
	desc = "A scroll imbued with an enchantment of storage. Doubles the storage space of a container."
	component = /datum/magic_item/mundane/holding
	w_class = WEIGHT_CLASS_HUGE

/obj/item/enchantmentscroll/holding/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/storage))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of storage"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/revealing
	name = "enchanting scroll of revealing"
	desc = "A scroll imbued with an enchantment of revealing. Doubles the range of lightsources."
	component = /datum/magic_item/mundane/revealing

/obj/item/enchantmentscroll/revealing/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/flashlight/flare/torch))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of revealing"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

//T2 Enchantments below

/obj/item/enchantmentscroll/nightvision
	name = "enchanting scroll of darkvision"
	desc = "A scroll imbued with an enchantment of darkvision. Good for seeing in the dark."
	component = /datum/magic_item/superior/nightvision

/obj/item/enchantmentscroll/nightvision/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/clothing))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of darkvision"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/featherstep
	name = "enchanting scroll of featherstep"
	desc = "A scroll imbued with an enchantment of featherstep. Makes you speedier, and makes your footfalls silent."
	component = /datum/magic_item/superior/featherstep

/obj/item/enchantmentscroll/featherstep/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/clothing/shoes)||istype(O,/obj/item/clothing/ring))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of featherstep"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/fireresist
	name = "enchanting scroll of fire resistance"
	desc = "A scroll imbued with an enchantment of fire resistance. Prevents you from catching fire."
	component = /datum/magic_item/superior/fireresist

/obj/item/enchantmentscroll/fireresist/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/clothing))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of fire resistance"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/climbing
	name = "enchanting scroll of spider-climbing"
	desc = "A scroll imbued with an enchantment of spider-climbing. Helps you clamber up difficult surfaces."
	component = /datum/magic_item/superior/climbing

/obj/item/enchantmentscroll/climbing/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/clothing))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of spider-climbing"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/thievery
	name = "enchanting scroll of nimble fingers"
	desc = "A scroll imbued with an enchantment of thievery. Helps you steal and pick locks."
	component = /datum/magic_item/superior/thievery

/obj/item/enchantmentscroll/thievery/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/clothing/gloves)||istype(O,/obj/item/clothing/ring))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of nimble fingers"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/trekk
	name = "enchanting scroll of longstriding"
	desc = "A scroll imbued with an enchantment of longstriding. Provides easy movement through swamps."
	component = /datum/magic_item/superior/trekk

/obj/item/enchantmentscroll/trekk/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/clothing/shoes)||istype(O,/obj/item/clothing/ring))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of longstriding"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/smithing
	name = "enchanting scroll of smithing"
	desc = "A scroll imbued with an enchantment of smithing. Provides more effective hammer strikes on anvils."
	component = /datum/magic_item/superior/smithing

/obj/item/enchantmentscroll/smithing/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/rogueweapon/hammer))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of smithing"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))
//T3 Enchantments below

/obj/item/enchantmentscroll/lifesteal
	name = "enchanting scroll of lyfestealing"
	desc = "A scroll imbued with an enchantment of lyfe stealing. Heals you occasionally when you hit a living foe."
	component = /datum/magic_item/greater/lifesteal

/obj/item/enchantmentscroll/lifesteal/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/rogueweapon))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of lyfestealing"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/frostveil
	name = "enchanting scroll of frostveil"
	desc = "A scroll imbued with an enchantment of frostveil. Slows enemies that hit you when applied on armor, or enemies that you hit when applied on weapons."
	component = /datum/magic_item/greater/frostveil

/obj/item/enchantmentscroll/frostveil/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/clothing)|| istype(O,/obj/item/rogueweapon))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of frostveil"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/returningweapon
	name = "enchanting scroll of returning weapon"
	desc = "A scroll imbued with an enchantment of returning weapon. Enables you to summon an existing weapon back to you."
	component = /datum/magic_item/greater/returningweapon

/obj/item/enchantmentscroll/returningweapon/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/clothing/ring)||istype(O,/obj/item/clothing/gloves))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of returning weapon"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/archery
	name = "enchanting scroll of archery"
	desc = "A scroll imbued with an enchantment of archery. Provides the wearer with better archery skill."
	component = /datum/magic_item/greater/archery

/obj/item/enchantmentscroll/archery/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/clothing/ring)||istype(O,/obj/item/clothing/gloves)|| istype(O, /obj/item/clothing/wrists/roguetown/bracers))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of archery"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))

/obj/item/enchantmentscroll/briars
	name = "enchanting scroll of briar's curse"
	desc = "A scroll imbued with an enchantment of briar's curse. A weapon with this enchantment does more damage, but damages its wielder in return."
	component = /datum/magic_item/mythic/briarcurse

/obj/item/enchantmentscroll/briars/attack_obj(obj/item/O, mob/living/user)
	if(!..())
		return
	if(istype(O,/obj/item/rogueweapon))
		to_chat(user, span_notice("You open [src] and place [O] within. Moments later, it flashes blue with arcana, and [src] crumbles to dust."))
		var/magiceffect= new component
		O.AddComponent(/datum/component/magic_item, magiceffect)
		O.name += " of briar's curse"
		O.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		qdel(src)
	else
		to_chat(user, span_notice("Nothing happens. Perhaps you can't enchant [O] with this?"))
