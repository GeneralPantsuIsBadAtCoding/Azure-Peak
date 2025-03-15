/datum/anvil_recipe/valuables
	appro_skill = /datum/skill/craft/blacksmithing
	craftdiff = 2
	i_type = "Valuables"

/datum/anvil_recipe/valuables/gold
	name = "Statue"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/roguestatue/gold

/datum/anvil_recipe/valuables/silver
	name = "Statue"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/roguestatue/silver

/datum/anvil_recipe/valuables/iron
	name = "Statue"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/roguestatue/iron

/datum/anvil_recipe/valuables/steel
	name = "Statue"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/roguestatue/steel

/*
/datum/anvil_recipe/valuables/eargol
	name = "gold earrings"
	req_bar = /obj/item/ingot/gold
	created_item = list(/obj/item/rogueacc/eargold,
						/obj/item/rogueacc/eargold,
						/obj/item/rogueacc/eargold)
	type = "Valuables"

/datum/anvil_recipe/valuables/earsil
	name = "silver earrings"
	req_bar = /obj/item/ingot/silver
	created_item = list(/obj/item/rogueacc/earsilver,
						/obj/item/rogueacc/earsilver,
						/obj/item/rogueacc/earsilver)*/
//	i_type = "Valuables"

/datum/anvil_recipe/valuables/ringg
	name = "Rings 3x"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/ring/gold
	createditem_num = 3

/datum/anvil_recipe/valuables/rings
	name = "Rings 3x"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/clothing/ring/silver
	createditem_num = 3

/datum/anvil_recipe/valuables/ornateamulet
	name = "Ornate Amulet"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/neck/roguetown/ornateamulet

/datum/anvil_recipe/valuables/skullamulet
	name = "Skull Amulet"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/neck/roguetown/skullamulet

//Gold Rings
/datum/anvil_recipe/valuables/emeringg
	name = "Gemerald Ring (+1 Gemerald)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/green)
	created_item = /obj/item/clothing/ring/emerald

/datum/anvil_recipe/valuables/rubyg
	name = "Rontz Ring (+1 Rontz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem)
	created_item = /obj/item/clothing/ring/ruby

/datum/anvil_recipe/valuables/topazg
	name = "Toper Ring (+1 Toper)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/yellow)
	created_item = /obj/item/clothing/ring/topaz

/datum/anvil_recipe/valuables/quartzg
	name = "Blortz Ring (+1 Blortz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/blue)
	created_item = /obj/item/clothing/ring/quartz
	i_type = "Valuables"

/datum/anvil_recipe/valuables/sapphireg
	name = "Saffira Ring (+1 Saffira)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/violet)
	created_item = /obj/item/clothing/ring/sapphire

/datum/anvil_recipe/valuables/diamondg
	name = "Dorpel Ring (+1 Dorpel)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/diamond)
	created_item = /obj/item/clothing/ring/diamond

/datum/anvil_recipe/valuables/signet
	name = "Signet Ring"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/ring/signet

// Silver ingots are now in play, and as such, the steel rings have been converted to silver with their value adjusted accordingly. -Kyogon

/datum/anvil_recipe/valuables/emerings
	name = "Gemerald Ring (+1 Gemerald)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/roguegem/green)
	created_item = /obj/item/clothing/ring/emeralds

/datum/anvil_recipe/valuables/rubys
	name = "Rontz Ring (+1 Rontz)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/roguegem)
	created_item = /obj/item/clothing/ring/rubys

/datum/anvil_recipe/valuables/topazs
	name = "Toper Ring (+1 Toper)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/roguegem/yellow)
	created_item = /obj/item/clothing/ring/topazs

/datum/anvil_recipe/valuables/quartzs
	name = "Blortz Ring (+1 Blortz)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/roguegem/blue)
	created_item = /obj/item/clothing/ring/quartzs

/datum/anvil_recipe/valuables/sapphires
	name = "Saffira Ring (+1 Saffira)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/roguegem/violet)
	created_item = /obj/item/clothing/ring/sapphires

/datum/anvil_recipe/valuables/diamonds
	name = "Dorpel Ring (+1 Dorpel)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/roguegem/diamond)
	created_item = /obj/item/clothing/ring/diamonds

/datum/anvil_recipe/valuables/terminus
	name = "Terminus Est (+1 Gold Bar, +1 Steel, +1 Rontz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/ingot/gold, /obj/item/ingot/steel, /obj/item/roguegem)
	created_item = /obj/item/rogueweapon/sword/long/exe/cloth
	craftdiff = 3
	i_type = "Weapons"

/datum/anvil_recipe/valuables/dragon
	name = "Dragon Ring (+ Secrets)"
	req_bar =  /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/gold, /obj/item/roguegem/blue, /obj/item/roguegem/violet, /obj/item/clothing/neck/roguetown/psicross/silver)
	created_item = /obj/item/clothing/ring/dragon_ring
	craftdiff = 6

/datum/anvil_recipe/roguetown/sewing/goldanklet
	name = "exotic silk anklets"
	req_bar =  /obj/item/ingot/gold
	created_item = list (/obj/item/clothing/shoes/roguetown/anklets)
	craftdiff = 6
