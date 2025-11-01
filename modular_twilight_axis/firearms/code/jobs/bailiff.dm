/datum/outfit/job/roguetown/marshal/classic/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/twilight_firearms, 4, TRUE)
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	belt = /obj/item/storage/belt/rogue/leather/twilight_holsterbelt/lord
	beltl = /obj/item/twilight_powderflask
	beltr = /obj/item/quiver/twilight_bullet/lead
	backpack_contents += list(/obj/item/storage/keyring/sheriff)

/datum/outfit/job/roguetown/marshal/kcommander/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/twilight_firearms, 4, TRUE)
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	belt = /obj/item/storage/belt/rogue/leather/twilight_holsterbelt/lord
	beltl = /obj/item/twilight_powderflask
	beltr = /obj/item/quiver/twilight_bullet/lead
	backpack_contents += list(/obj/item/storage/keyring/sheriff)
