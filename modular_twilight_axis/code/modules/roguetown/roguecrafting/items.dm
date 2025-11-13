/datum/crafting_recipe/roguetown/survival/rope_leash
	name = "rope leash (1 rope)"
	result = /obj/item/leash
	reqs = list(/obj/item/rope = 1)
	tools = list(/obj/item/needle)
	verbage_simple = "sew"
	verbage = "sews"
	category = "General"
	always_availible = TRUE

/datum/crafting_recipe/roguetown/survival/chain_leash
	name = "chain leash (1 chain)"
	result = /obj/item/leash/chain
	reqs = list(/obj/item/rope/chain = 1)
	verbage_simple = "craft"
	verbage = "crafts"
	category = "General"
	always_availible = TRUE

/datum/crafting_recipe/roguetown/survival/sallet_visor_grenzelhoft
	name = "салад с забралом со шляпой Грензельхофта - (салад с забралом; грензельхофтская шляпа)"
	result = /obj/item/clothing/head/roguetown/helmet/sallet/visored/grenzelhoft
	reqs = list(/obj/item/clothing/head/roguetown/helmet/sallet/visored = 1,
				/obj/item/clothing/head/roguetown/grenzelhofthat = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/armet_grenzelhoft
	name = "армет с шляпой Грензельхофта - (армет с шляпой; грензельхофтская шляпа)"
	result = /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet/grenzelhoft
	reqs = list(/obj/item/clothing/head/roguetown/helmet/heavy/knight/armet = 1,
				/obj/item/clothing/head/roguetown/grenzelhofthat = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/etruscan_grenzelhoft
	name = "этрусский бацинет с шляпой Грензельхофта - (этрусский бацинет с шляпой; грензельхофтская шляпа)"
	result = /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan/grenzelhoft
	reqs = list(/obj/item/clothing/head/roguetown/helmet/bascinet/etruscan = 1,
				/obj/item/clothing/head/roguetown/grenzelhofthat = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/sallet_visorgrenzelhoft
	name = "салад с шляпой Грензельхофта - (салад с шляпой; грензельхофтская шляпа)"
	result = /obj/item/clothing/head/roguetown/helmet/sallet/grenzelhoft
	reqs = list(/obj/item/clothing/head/roguetown/helmet/sallet = 1,
				/obj/item/clothing/head/roguetown/grenzelhofthat = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/sallet_visor_grenzelhoft_decorated_hat
	name = "салад с забралом с шляпой Грензельхофта - (салад с забралом; грензельхофтская шляпа)"
	result = /obj/item/clothing/head/roguetown/helmet/sallet/visored/grenzelhoft
	reqs = list(/obj/item/clothing/head/roguetown/helmet/sallet/visored = 1,
				/obj/item/clothing/head/roguetown/grenzelhofthat/decorated = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/armet_grenzelhoft_decorated_hat
	name = "армет с шляпой Грензельхофта - (армет с шляпой; грензельхофтская шляпа)"
	result = /obj/item/clothing/head/roguetown/helmet/heavy/knight/armet/grenzelhoft
	reqs = list(/obj/item/clothing/head/roguetown/helmet/heavy/knight/armet = 1,
				/obj/item/clothing/head/roguetown/grenzelhofthat/decorated = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/etruscan_grenzelhoft_decorated_hat
	name = "этрусский бацинет с шляпой Грензельхофта - (этрусский бацинет с шляпой; грензельхофтская шляпа)"
	result = /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan/grenzelhoft
	reqs = list(/obj/item/clothing/head/roguetown/helmet/bascinet/etruscan = 1,
				/obj/item/clothing/head/roguetown/grenzelhofthat/decorated = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/sallet_visorgrenzelhoft_decorated_hat
	name = "салад с шляпой Грензельхофта - (салад с шляпой; грензельхофтская шляпа)"
	result = /obj/item/clothing/head/roguetown/helmet/sallet/grenzelhoft
	reqs = list(/obj/item/clothing/head/roguetown/helmet/sallet = 1,
				/obj/item/clothing/head/roguetown/grenzelhofthat/decorated = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/grenzelpants_chain
	name = "грензельхофтские помперы с кольчугой - (грензельхофтские помперы; стальные кольчужные шоссы)"
	result = /obj/item/clothing/under/roguetown/chainlegs/grenzelpants
	reqs = list(/obj/item/clothing/under/roguetown/chainlegs = 1,
				/obj/item/clothing/under/roguetown/heavy_leather_pants/grenzelpants = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/grenzelshirt_chain
	name = "грензельхофтская рубашка с кольчугой - (грензельхофтская рубашка; хауберк)"
	result = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/grenzelhoft
	reqs = list(/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk = 1,
				/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/grenzelhoft = 1)
	craftdiff = 0
