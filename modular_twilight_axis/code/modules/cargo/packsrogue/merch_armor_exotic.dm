/datum/supply_pack/rogue/armor_exotic/raneshi_hmamluk
	name = "Masked mamluk helmet"
	cost = 110
	contains = list(/obj/item/clothing/head/roguetown/helmet/heavy/knight/raneshi_hmamluk)

/datum/supply_pack/rogue/armor_exotic/raneshi_vmamluk
	name = "Hound masked mamluk helmet"
	cost = 110
	contains = list(/obj/item/clothing/head/roguetown/helmet/heavy/knight/raneshi_hmamluk/raneshi_vmamluk)

/datum/supply_pack/rogue/armor_exotic/raneshi_jarhelmet
	name = "Raneshene jar helmet"
	cost = 70
	contains = list(/obj/item/clothing/head/roguetown/helmet/raneshi_jarhelmet)

/datum/supply_pack/rogue/armor_exotic/raneshen_new_coat //Только в продаже, т.к. с точки зрения лора делается из специальных чешуек.
	name = "Raneshene light scale coat"
	cost = 80
	contains = list(/obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/raneshen/new_coat)

/datum/supply_pack/rogue/armor_exotic/raneshen_scale
	name = "Raneshene medium lamellar armor"
	cost = 110
	contains = list(/obj/item/clothing/suit/roguetown/armor/plate/raneshen_scale)

/datum/supply_pack/rogue/armor_exotic/raneshen_plated
	name = "Raneshene plate armor"
	cost = 380 //Взял цену флютированных лат, т.к. там +1 железо, а у меня +1 бронза, seems fair?
	contains = list(/obj/item/clothing/suit/roguetown/armor/plate/full/raneshen_plated)

// Магазин мерка-бандитов.

/datum/supply_pack/rogue/Sellsword/raneshi_hmamluk //Поскольку у мерка-бандита в продаже вещи из Зибантии и Грензельхофта, добавлю и ему несколько шмоток.
	name = "Masked mamluk helmet"
	cost = 40 //Беру цену саллета с забралом (30) + 10 за 1 бронзовый слиток.
	contains = list(/obj/item/clothing/head/roguetown/helmet/heavy/knight/raneshi_hmamluk)

/datum/supply_pack/rogue/Sellsword/raneshi_vmamluk
	name = "Hound masked mamluk helmet"
	cost = 40
	contains = list(/obj/item/clothing/head/roguetown/helmet/heavy/knight/raneshi_hmamluk/raneshi_vmamluk)

/datum/supply_pack/rogue/Sellsword/raneshen_scale
	name = "Raneshene medium lamellar armor"
	cost = 40 //Взял цену обычной чешуйки (20) + 20 сверху за слиток.
	contains = list(/obj/item/clothing/suit/roguetown/armor/plate/raneshen_scale)
