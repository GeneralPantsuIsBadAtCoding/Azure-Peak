/datum/outfit/job/roguetown/lord/pre_equip(mob/living/carbon/human/H)
	. = ..()
	backpack_contents = list()
	belt = /obj/item/storage/belt/rogue/leather/twilight_holsterbelt/lord
	beltl = /obj/item/twilight_powderflask
	beltr = /obj/item/quiver/twilight_bullet/lead

/datum/outfit/job/roguetown/lord/warrior/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.adjust_skillrank(/datum/skill/combat/twilight_firearms, 3, TRUE)
	backpack_contents += /obj/item/storage/keyring/lord
	backpack_contents += /obj/item/rogueweapon/huntingknife/idagger/steel/special

/datum/outfit/job/roguetown/lord/merchant/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.adjust_skillrank(/datum/skill/combat/twilight_firearms, 3, TRUE)
	backpack_contents += /obj/item/storage/keyring/lord
	backpack_contents += /obj/item/rogueweapon/huntingknife/idagger/steel/special

/datum/outfit/job/roguetown/lord/inbred/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.adjust_skillrank(/datum/skill/combat/twilight_firearms, 3, TRUE)
	backpack_contents += /obj/item/storage/keyring/lord
	backpack_contents += /obj/item/rogueweapon/huntingknife/idagger/steel/special
