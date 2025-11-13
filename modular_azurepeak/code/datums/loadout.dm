GLOBAL_LIST_EMPTY(loadout_items)
GLOBAL_LIST_EMPTY(loadout_items_by_name)
GLOBAL_LIST_EMPTY(loadout_items_by_category)

/datum/loadout_item
	var/name = "Parent loadout datum"
	var/desc
	var/atom/movable/path
	var/donoritem			//autoset on new if null
	var/donatitem = FALSE
	var/list/ckeywhitelist
	var/triumph_cost
	var/category = "Разное"

/datum/loadout_item/New()
	if(isnull(donoritem))
		if(ckeywhitelist)
			donoritem = TRUE
	if (triumph_cost)
		desc += "<b>Costs [triumph_cost] TRIUMPH.</b>"

/datum/loadout_item/proc/donator_ckey_check(key)
	if(ckeywhitelist && ckeywhitelist.Find(key))
		return TRUE
	return

//Miscellaneous

/datum/loadout_item/card_deck
	name = "Card Deck"
	category = "Разное"
	path = /obj/item/toy/cards/deck

/datum/loadout_item/farkle_dice
	name = "Farkle Dice Container"
	category = "Разное"
	path = /obj/item/storage/pill_bottle/dice/farkle

/datum/loadout_item/tarot_deck
	name = "Tarot Deck"
	category = "Разное"
	path = /obj/item/toy/cards/deck/tarot

/datum/loadout_item/custom_book
	name = "Custom Book"
	category = "Разное"
	path = /obj/item/book/rogue/loadoutbook

//TOOLS
/datum/loadout_item/bauernwehr
	name = "Bauernwehr (-3 TRI)"
	category = "Триумфы"
	path = /obj/item/rogueweapon/huntingknife/throwingknife/bauernwehr
	triumph_cost = 3

//HATS
/datum/loadout_item/shalal
	name = "Keffiyeh"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/roguehood/shalal

/datum/loadout_item/tricorn
	name = "Tricorn Hat"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/helmet/tricorn

/datum/loadout_item/nurseveil
	name = "Nurse Veil"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/veiled

/datum/loadout_item/archercap
	name = "Archer's cap"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/archercap

/datum/loadout_item/strawhat
	name = "Straw Hat"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/strawhat

/datum/loadout_item/eaststrawhat
	name = "Worn rice hat"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/eaststrawhat

/datum/loadout_item/witchhat
	name = "Witch Hat"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/witchhat

/datum/loadout_item/bardhat
	name = "Bard Hat"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/bardhat

/datum/loadout_item/fancyhat
	name = "Fancy Hat"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/fancyhat

/datum/loadout_item/furhat
	name = "Fur Hat"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/hatfur

/datum/loadout_item/smokingcap
	name = "Smoking Cap"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/smokingcap

/datum/loadout_item/headband
	name = "Headband"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/headband

/datum/loadout_item/buckled_hat
	name = "Buckled Hat"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/puritan

/datum/loadout_item/folded_hat
	name = "Folded Hat"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/bucklehat

/datum/loadout_item/duelist_hatc
	name = "Duelist's Hat"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/duelhat

/datum/loadout_item/hood
	name = "Hood"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/roguehood

/datum/loadout_item/hijab
	name = "Hijab"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/roguehood/shalal/hijab

/datum/loadout_item/heavyhood
	name = "Heavy Hood"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/roguehood/shalal/heavyhood

/datum/loadout_item/nunveil
	name = "Nun Veil"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/nun

/datum/loadout_item/papakha
	name = "Papakha"
	category = "Головные уборы"
	path = /obj/item/clothing/head/roguetown/papakha

/datum/loadout_item/rosa_crown
	name = "Rosa Crown"
	path = /obj/item/flowercrown/rosa

/datum/loadout_item/salvia_crown
	name = "Salvia Crown"
	path = /obj/item/flowercrown/salvia

//CLOAKS
/datum/loadout_item/tabard
	name = "Tabard"
	category = "Плащи"
	path = /obj/item/clothing/cloak/tabard

/datum/loadout_item/surcoat
	name = "Surcoat"
	category = "Плащи"
	path = /obj/item/clothing/cloak/stabard

/datum/loadout_item/jupon
	name = "Jupon"
	category = "Плащи"
	path = /obj/item/clothing/cloak/stabard/surcoat

/datum/loadout_item/cape
	name = "Cape"
	category = "Плащи"
	path = /obj/item/clothing/cloak/cape

/datum/loadout_item/halfcloak
	name = "Halfcloak"
	category = "Плащи"
	path = /obj/item/clothing/cloak/half

/datum/loadout_item/ridercloak
	name = "Rider Cloak"
	category = "Плащи"
	path = /obj/item/clothing/cloak/half/rider

/datum/loadout_item/raincloak
	name = "Rain Cloak"
	category = "Плащи"
	path = /obj/item/clothing/cloak/raincloak

/datum/loadout_item/furcloak
	name = "Fur Cloak"
	category = "Плащи"
	path = /obj/item/clothing/cloak/raincloak/furcloak

/datum/loadout_item/direcloak
	name = "direbear cloak"
	category = "Плащи"
	path = /obj/item/clothing/cloak/darkcloak/bear

/datum/loadout_item/lightdirecloak
	name = "light direbear cloak"
	category = "Плащи"
	path = /obj/item/clothing/cloak/darkcloak/bear/light

/datum/loadout_item/volfmantle
	name = "Volf Mantle"
	category = "Плащи"
	path = /obj/item/clothing/cloak/volfmantle

/datum/loadout_item/eastcloak2
	name = "Leather Cloak"
	category = "Плащи"
	path = /obj/item/clothing/cloak/eastcloak2

/datum/loadout_item/thief_cloakc
	name = "Rapscallion's Shawl"
	category = "Плащи"
	path = /obj/item/clothing/cloak/thief_cloak

/datum/loadout_item/tabardscarlet
	name = "Tabard, Scarlet"
	category = "Плащи"
	path = /obj/item/clothing/suit/roguetown/shirt/robe/tabardscarlet

/datum/loadout_item/shroudscarlet
	name = "Tabard Shroud, Scarlet"
	category = "Плащи"
	path = /obj/item/clothing/head/roguetown/roguehood/shroudscarlet

/datum/loadout_item/tabardblack
	name = "Tabard, Black"
	category = "Плащи"
	path = /obj/item/clothing/suit/roguetown/shirt/robe/tabardblack

/datum/loadout_item/shroudblack
	name = "Tabard Shroud, Black"
	category = "Плащи"
	path = /obj/item/clothing/head/roguetown/roguehood/shroudblack

//SHOES
/datum/loadout_item/darkboots
	name = "Dark Boots"
	category = "Обувь"
	path = /obj/item/clothing/shoes/roguetown/boots

/datum/loadout_item/babouche
	name = "Babouche"
	category = "Обувь"
	path = /obj/item/clothing/shoes/roguetown/shalal

/datum/loadout_item/nobleboots
	name = "Noble Boots"
	category = "Обувь"
	path = /obj/item/clothing/shoes/roguetown/boots/nobleboot

/datum/loadout_item/sandals
	name = "Sandals"
	category = "Обувь"
	path = /obj/item/clothing/shoes/roguetown/sandals

/datum/loadout_item/shortboots
	name = "Short Boots"
	category = "Обувь"
	path = /obj/item/clothing/shoes/roguetown/shortboots

/datum/loadout_item/gladsandals
	name = "Gladiatorial Sandals"
	category = "Обувь"
	path = /obj/item/clothing/shoes/roguetown/gladiator

/datum/loadout_item/ridingboots
	name = "Riding Boots"
	category = "Обувь"
	path = /obj/item/clothing/shoes/roguetown/ridingboots

/datum/loadout_item/ankletscloth
	name = "Cloth Anklets"
	category = "Обувь"
	path = /obj/item/clothing/shoes/roguetown/boots/clothlinedanklets

/datum/loadout_item/ankletsfur
	name = "Fur Anklets"
	category = "Обувь"
	path = /obj/item/clothing/shoes/roguetown/boots/furlinedanklets

/datum/loadout_item/exoticanklets
	name = "Exotic Anklets"
	category = "Обувь"
	path = /obj/item/clothing/shoes/roguetown/anklets

/datum/loadout_item/rumaclanshoes
	name = "Raised Sandals"
	category = "Обувь"
	path = /obj/item/clothing/shoes/roguetown/armor/rumaclan

//SHIRTS
/datum/loadout_item/longcoat
	name = "Longcoat"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/armor/longcoat

/datum/loadout_item/robe
	name = "Robe"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/robe

/datum/loadout_item/phys_robe
	name = "Physicker's Robe"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/robe/phys

/datum/loadout_item/feld_robe
	name = "Feldsher's Robe"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/robe/feld

/datum/loadout_item/formalsilks
	name = "Formal Silks"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan

/datum/loadout_item/longshirt
	name = "Shirt"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/black

/datum/loadout_item/shortshirt
	name = "Short-sleeved Shirt"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/shortshirt

/datum/loadout_item/sailorshirt
	name = "Striped Shirt"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor

/datum/loadout_item/sailorjacket
	name = "Leather Jacket"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor

/datum/loadout_item/priestrobe
	name = "Undervestments"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest

/datum/loadout_item/exoticsilkbra
	name = "Exotic Silk Bra"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/exoticsilkbra

/datum/loadout_item/desertbra
	name = "Desert Bra"
	path = /obj/item/clothing/suit/roguetown/shirt/desertbra

/datum/loadout_item/deserthood
	name = "Desert Hood"
	path = /obj/item/clothing/head/roguetown/deserthood

/datum/loadout_item/desertskirt
	name = "Desert Skirt"
	path = /obj/item/clothing/under/roguetown/skirt/desert

/datum/loadout_item/explorerhat
	name = "Explorer Hat"
	path = /obj/item/clothing/head/roguetown/explorerhat

/datum/loadout_item/explorervest
	name = "Explorer Vest"
	path = /obj/item/clothing/suit/roguetown/shirt/explorer

/datum/loadout_item/fancycoat
	name = "Fancy Coat"
	path = /obj/item/clothing/cloak/poncho/fancycoat

/datum/loadout_item/explorerpants
	name = "Explorer Pants"
	path = /obj/item/clothing/under/roguetown/tights/explorerpants

/datum/loadout_item/bottomtunic
	name = "Low-cut Tunic"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut

/datum/loadout_item/tunic
	name = "Tunic"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/tunic

/datum/loadout_item/stripedtunic
	name = "Striped Tunic"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/armor/workervest

/datum/loadout_item/dress
	name = "Dress"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen

/datum/loadout_item/bardress
	name = "Bar Dress"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/dress

/datum/loadout_item/chemise
	name = "Chemise"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress

/datum/loadout_item/sexydress
	name = "Sexy Dress"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy

/datum/loadout_item/straplessdress
	name = "Strapless Dress"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless

/datum/loadout_item/straplessdress/alt
	name = "Strapless Dress, alt"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless/alt

/datum/loadout_item/gown
	name = "Spring Gown"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gown

/datum/loadout_item/gown/summer
	name = "Summer Gown"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gown/summergown

/datum/loadout_item/gown/fall
	name = "Fall Gown"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gown/fallgown

/datum/loadout_item/gown/winter
	name = "Winter Gown"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/gown/wintergown

/datum/loadout_item/gown/silkydress
	name = "Silky Dress"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/dress/silkydress

/datum/loadout_item/noblecoat
	name = "Fancy Coat"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/tunic/noblecoat

/datum/loadout_item/leathervest
	name = "Leather Vest"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/armor/leather/vest

/datum/loadout_item/nun_habit
	name = "Nun Habit"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/robe/nun

/datum/loadout_item/eastshirt1
	name = "Black Foreign Shirt"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1

/datum/loadout_item/eastshirt2
	name = "White Foreign Shirt"
	category = "Одежда"
	path = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt2
//PANTS
/datum/loadout_item/tights
	name = "Cloth Tights"
	category = "Штаны"
	path = /obj/item/clothing/under/roguetown/tights/black

/datum/loadout_item/leathertights
	name = "Leather Tights"
	category = "Штаны"
	path = /obj/item/clothing/under/roguetown/trou/leathertights

/datum/loadout_item/trou
	name = "Work Trousers"
	category = "Штаны"
	path = /obj/item/clothing/under/roguetown/trou

/datum/loadout_item/leathertrou
	name = "Leather Trousers"
	category = "Штаны"
	path = /obj/item/clothing/under/roguetown/trou/leather

/datum/loadout_item/leathershorts
	name = "Leather Shorts"
	path = /obj/item/clothing/under/roguetown/heavy_leather_pants/shorts

/datum/loadout_item/sailorpants
	name = "Seafaring Pants"
	category = "Штаны"
	path = /obj/item/clothing/under/roguetown/tights/sailor

/datum/loadout_item/skirt
	name = "Skirt"
	category = "Штаны"
	path = /obj/item/clothing/under/roguetown/skirt

//ACCESSORIES
/datum/loadout_item/wrappings
	name = "Handwraps"
	category = "Аксессуары"
	path = /obj/item/clothing/wrists/roguetown/wrappings

/datum/loadout_item/allwrappings
	name = "Cloth Wrappings"
	path = /obj/item/clothing/wrists/roguetown/allwrappings

/datum/loadout_item/loincloth
	name = "Loincloth"
	category = "Аксессуары"
	path = /obj/item/clothing/under/roguetown/loincloth

/datum/loadout_item/spectacles
	name = "Spectacles"
	category = "Аксессуары"
	path = /obj/item/clothing/mask/rogue/spectacles

/datum/loadout_item/fingerless
	name = "Fingerless Gloves"
	category = "Аксессуары"
	path = /obj/item/clothing/gloves/roguetown/fingerless

/datum/loadout_item/bandages
	name = "Bandages, Gloves"
	path = /obj/item/clothing/gloves/roguetown/bandages

/datum/loadout_item/exoticsilkbelt
	name = "Exotic Silk Belt"
	category = "Аксессуары"
	path = /obj/item/storage/belt/rogue/leather/exoticsilkbelt

/datum/loadout_item/ragmask
	name = "Rag Mask"
	category = "Аксессуары"
	path = /obj/item/clothing/mask/rogue/ragmask

/datum/loadout_item/halfmask
	name = "Halfmask"
	category = "Аксессуары"
	path = /obj/item/clothing/mask/rogue/shepherd

/datum/loadout_item/dendormask
	name = "Briar Mask"
	category = "Аксессуары"
	path = /obj/item/clothing/head/roguetown/dendormask

/datum/loadout_item/exoticsilkmask
	name = "Exotic Silk Mask"
	category = "Аксессуары"
	path = /obj/item/clothing/mask/rogue/exoticsilkmask

/datum/loadout_item/duelmaskc
	name = "Duelist's Mask"
	category = "Аксессуары"
	path = /obj/item/clothing/mask/rogue/duelmask

/datum/loadout_item/pipe
	name = "Pipe"
	category = "Аксессуары"
	path = /obj/item/clothing/mask/cigarette/pipe

/datum/loadout_item/pipewestman
	name = "Westman Pipe"
	category = "Аксессуары"
	path = /obj/item/clothing/mask/cigarette/pipe/westman

/datum/loadout_item/feather
	name = "Feather"
	category = "Аксессуары"
	path = /obj/item/natural/feather

/datum/loadout_item/collar
	name = "Collar"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/collar/leather

/datum/loadout_item/forlon_collar
	name = "Light Forlorn Collar"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/collar/forlorn

/datum/loadout_item/catbell_collar
	name = "Catbell Collar"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/collar/bell/catbell

/datum/loadout_item/bell_collar
	name = "Cowbell Collar"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/collar/bell/cowbell

/datum/loadout_item/cursed_collar
	name = "Cursed Collar"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/gorget/cursed_collar

/datum/loadout_item/rope_leash
	name = "Rope Leash"
	category = "Аксессуары"
	path = /obj/item/leash

/datum/loadout_item/leather_leash
	name = "Leather Leash"
	category = "Аксессуары"
	path = /obj/item/leash/leather

/datum/loadout_item/chain_leash
	name = "Chain Leash"
	category = "Аксессуары"
	path = /obj/item/leash/chain

/datum/loadout_item/cloth_blindfold
	name = "Cloth Blindfold"
	category = "Аксессуары"
	path = /obj/item/clothing/mask/rogue/blindfold

/datum/loadout_item/fake_blindfold
	name = "Fake Blindfold"
	category = "Аксессуары"
	path = /obj/item/clothing/mask/rogue/blindfold/fake

/datum/loadout_item/bases
	name = "Cloth military skirt"
	category = "Аксессуары"
	path = /obj/item/storage/belt/rogue/leather/battleskirt

/datum/loadout_item/fauldedbelt
	name = "Belt with faulds"
	category = "Аксессуары"
	path = /obj/item/storage/belt/rogue/leather/battleskirt/faulds

/datum/loadout_item/psicross
	name = "Psydonian Cross"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/psicross

/datum/loadout_item/psicross/astrata
	name = "Amulet of Astrata"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/psicross/astrata

/datum/loadout_item/psicross/noc
	name = "Amulet of Noc"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/psicross/noc

/datum/loadout_item/psicross/abyssor
	name = "Amulet of Abyssor"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/psicross/abyssor

/datum/loadout_item/psicross/dendor
	name = "Amulet of Dendor"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/psicross/dendor

/datum/loadout_item/psicross/necra
	name = "Amulet of Necra"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/psicross/necra

/datum/loadout_item/psicross/pestra
	name = "Amulet of Pestra"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/psicross/pestra

/datum/loadout_item/psicross/ravox
	name = "Amulet of Ravox"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/psicross/ravox

/datum/loadout_item/psicross/malum
	name = "Amulet of Malum"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/psicross/malum

/datum/loadout_item/psicross/eora
	name = "Amulet of Eora"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/psicross/eora

/datum/loadout_item/psicross/undivided
	name = "Amulet of Ten"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/psicross/undivided

/datum/loadout_item/psicross/zizo
	name = "Decrepit Zcross"
	category = "Аксессуары"
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/aalloy

/datum/loadout_item/zcross_iron
	name = "Iron Zcross"
	path = /obj/item/clothing/neck/roguetown/psicross/inhumen/iron

/datum/loadout_item/wedding_band
	name = "silver wedding band"
	category = "Аксессуары"
	path = /obj/item/clothing/ring/band

/datum/loadout_item/chaperon
    name = "Chaperon (Normal)"
    category = "Головные уборы"
    path = /obj/item/clothing/head/roguetown/chaperon

/datum/loadout_item/chaperon/alt
    name = "Chaperon (Alt)"
    category = "Головные уборы"
    path = /obj/item/clothing/head/roguetown/chaperon/greyscale

/datum/loadout_item/chaperon/burgherc
    name = "Noble's Chaperon"
    category = "Головные уборы"
    path = /obj/item/clothing/head/roguetown/chaperon/noble

/datum/loadout_item/jesterhatc
    name = "Jester's Hat"
    category = "Головные уборы"
    path = /obj/item/clothing/head/roguetown/jester

/datum/loadout_item/jestertunickc
    name = "Jester's Tunick"
    category = "Одежда"
    path = /obj/item/clothing/suit/roguetown/shirt/jester

/datum/loadout_item/jestershoess
    name = "Jester's Shoes"
    category = "Обувь"
    path = /obj/item/clothing/shoes/roguetown/jester

/datum/loadout_item/cotehardie
	name = "Fitted Coat"
	category = "Одежда"
	path = /obj/item/clothing/cloak/cotehardie

//Donator Section
//All these items are stored in the donator_fluff.dm in the azure modular folder for simplicity.
//All should be subtypes of existing weapons/clothes/armor/gear, whatever, to avoid balance issues I guess. Idk, I'm not your boss.

// Энчант киты
/datum/loadout_item/donator_plex
	name = "Donator Kit - Rapier di Aliseo - Required: Rapier"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/plexiant
	donatitem = TRUE

/datum/loadout_item/donator_sru
	name = "Donator Kit - Emerald Dress - Required: Dress(No Small Races)"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/srusu
	donatitem = TRUE

/datum/loadout_item/donator_strudel
	name = "Donator Kit - Grenzelhoftian Mage Vest - Required: Robe(No Small Races)"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/strudle
	donatitem = TRUE

/datum/loadout_item/donator_bat
	name = "Donator Kit - Handcarved Harp - Required: Harp"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/bat
	donatitem = TRUE

/datum/loadout_item/donator_mansa
	name = "Donator Kit - Wortträger - Required: Estoc"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/ryebread
	donatitem = TRUE

/datum/loadout_item/donator_rebel
	name = "Donator Kit - Gilded Sallet - Required: Visored Sallet"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/rebel
	donatitem = TRUE

/datum/loadout_item/donator_bigfoot
	name = "Donator Kit - Gilded Knight Helm - Required: Knight Helmet"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/bigfoot
	donatitem = TRUE

/datum/loadout_item/donator_ravoxhelm_oldrw
	name = "Donator Kit - Plumed Ravox Helmet - Required: Heavy Helmet"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/ravoxhelm_oldrw
	donatitem = TRUE

/datum/loadout_item/donator_necranhelm_oldrw
	name = "Donator Kit - Hooded Necra Helmet - Required: Heavy Helmet"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/necranhelm_oldrw
	donatitem = TRUE

/datum/loadout_item/donator_astratanhelm_oldrw
	name = "Donator Kit - Plumed Astrata Helmet - Required: Heavy Helmet"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/astratanhelm_oldrw
	donatitem = TRUE

/datum/loadout_item/donator_bigfoot_axe
	name = "Donator Kit - Gilded GreatAxe - Required: Steel Greataxe"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/bigfoot_axe
	donatitem = TRUE

/datum/loadout_item/donator_zydras
	name = "Donator Kit - Padded silky dress - Required: Silky Dress(No Small Races)"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/zydras
	donatitem = TRUE

/datum/loadout_item/donator_eiren
	name = "Donator Kit - Regret - Required: Any Zweihander"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/eiren
	donatitem = TRUE

/datum/loadout_item/donator_eiren2
	name = "Donator Kit - Lunae - Required: Sabre"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/eirensabre
	donatitem = TRUE

/datum/loadout_item/donator_eiren3
	name = "Donator Kit - Cinis - Required: Sabre"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/eirensabre2
	donatitem = TRUE

/datum/loadout_item/donator_waff
	name = "Donator Kit - Weeper Lathe - Required: Greatsword"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/waff
	donatitem = TRUE

/datum/loadout_item/donator_inverserun
	name = "Donator Kit - Votive Thorns - Required: Any Zweihander"
	path = /obj/item/enchantingkit/inverserun
	category = list("Разное", "Донат")
	donatitem = TRUE

/datum/loadout_item/donator_zoe
	name = "Donator Kit - Shroud of the Undermaiden - Required: Direbear Cloak"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/zoe
	donatitem = TRUE

/datum/loadout_item/donator_kumie
	name = "Donator Kit - Aristocratic Boots - Required: Heavy Leather Boots or Noble Boots"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/kumie_boots
	donatitem = TRUE

/datum/loadout_item/donator_kumie2
	name = "Donator Kit - Aristocratic Gloves - Required: Fingerless Leather Gloves or Heavy Leather Gloves"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/kumie_gloves
	donatitem = TRUE

/datum/loadout_item/donator_kumie3
	name = "Donator Kit - Aristocratic Shirt - Required: Gambeson or Padded Gambeson(No Small Races)"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/kumie_shirt
	donatitem = TRUE

/datum/loadout_item/donator_kumie4
	name = "Donator Kit - Aristocratic Coat - Required: Hardened Leather Coat(No Small Races)"
	category = list("Разное", "Донат")
	path = /obj/item/enchantingkit/kumie_coat
	donatitem = TRUE

// Разное
/datum/loadout_item/donat
	name = "Музыкальная коробка"
	category = list("Разное", "Донат")
	path = /obj/item/dmusicbox
	donatitem = TRUE

/datum/loadout_item/donat/lute
	name = "Музыкальный инструмент: Лютня"
	category = list("Аксессуары", "Донат")
	path = /obj/item/rogue/instrument/lute
	donatitem = TRUE

/datum/loadout_item/donat/accord
	name = "Музыкальный инструмент: Аккордеон"
	category = list("Аксессуары", "Донат")
	path = /obj/item/rogue/instrument/accord
	donatitem = TRUE

/datum/loadout_item/donat/guitar
	name = "Музыкальный инструмент: Гитара"
	category = list("Аксессуары", "Донат")
	path = /obj/item/rogue/instrument/guitar
	donatitem = TRUE

/datum/loadout_item/donat/harp
	name = "Музыкальный инструмент: Арфа"
	category = list("Аксессуары", "Донат")
	path = /obj/item/rogue/instrument/harp
	donatitem = TRUE

/datum/loadout_item/donat/flute
	name = "Музыкальный инструмент: Флейта"
	category = list("Аксессуары", "Донат")
	path = /obj/item/rogue/instrument/flute
	donatitem = TRUE

/datum/loadout_item/donat/drum
	name = "Музыкальный инструмент: Барабан"
	category = list("Аксессуары", "Донат")
	path = /obj/item/rogue/instrument/drum
	donatitem = TRUE

/datum/loadout_item/donat/shamisen
	name = "Музыкальный инструмент: Сямисэн"
	category = list("Аксессуары", "Донат")
	path = /obj/item/rogue/instrument/shamisen
	donatitem = TRUE

/datum/loadout_item/donat/vocals
	name = "Музыкальный инструмент: Талисман Вокалиста"
	category = list("Аксессуары", "Донат")
	path = /obj/item/rogue/instrument/vocals
	donatitem = TRUE

/datum/loadout_item/donat/viola
	name = "Музыкальный инструмент: Виола"
	category = list("Аксессуары", "Донат")
	path = /obj/item/rogue/instrument/viola
	donatitem = TRUE

// Одежда для донатеров
/datum/loadout_item/donat/corset
	name = "Корсет"
	category = list("Одежда", "Донат")
	path = /obj/item/clothing/suit/roguetown/armor/corset
	donatitem = TRUE

/datum/loadout_item/donat/elven_suit
	name = "Эльфийский костюм"
	category = list("Одежда", "Донат")
	path = /obj/item/clothing/suit/roguetown/shirt/twilight_elven
	donatitem = TRUE

/datum/loadout_item/donat/elven_coat
	name = "Эльфийское пальто"
	category = list("Одежда", "Донат")
	path = /obj/item/clothing/suit/roguetown/shirt/twilight_elven/coat
	donatitem = TRUE

/datum/loadout_item/donat/elven_coat_alt
	name = "Эльфийское меховое пальто"
	category = list("Одежда", "Донат")
	path = /obj/item/clothing/suit/roguetown/shirt/twilight_elven/coat/alt
	donatitem = TRUE

// Табарды и плащи

/datum/loadout_item/donat/matron
	name = "Плащ матроны"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/matron
	donatitem = TRUE

/datum/loadout_item/donat/capeblkknight
	name = "Кровавая мантия"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/cape/blkknight
	donatitem = TRUE

/datum/loadout_item/donat/xylixiancloak
	name = "Ксайликситский плащ"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/templar/xylixian
	donatitem = TRUE

/datum/loadout_item/donat/furcloak
	name = "Меховой плащ"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/raincloak/furcloak
	donatitem = TRUE

/datum/loadout_item/donat/snowcloak
	name = "Снежный плащ"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/forrestercloak/snow
	donatitem = TRUE

/datum/loadout_item/donat/tabard/astata
	name = "Табард-плащ Астраты"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/templar/astratan
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/noc
	name = "Табард-плащ Нок"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/tabard/crusader/noc
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/dendor
	name = "Табард-плащ Дендора"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/tabard/crusader/dendor
	donatitem = TRUE

/datum/loadout_item/donat/tabard/pestra
	name = "Табард-плащ Пестры"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/templar/pestran
	donatitem = TRUE

/datum/loadout_item/donat/tabard/malum
	name = "Табард-плащ Малума"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/templar/malumite
	donatitem = TRUE

/datum/loadout_item/donat/tabard/abyssor
	name = "Табард-плащ Абиссора"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/abyssortabard
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/ravox
	name = "Табард-плащ Равокса"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/cleric/ravox
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/eora
	name = "Табард-плащ Эоры(старый)"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/tabard/crusader/eora
	donatitem = TRUE

/datum/loadout_item/donat/tabard/eora
	name = "Табард-плащ Эоры"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/templar/eoran
	donatitem = TRUE

/datum/loadout_item/donat/tabard/crusader/necra
	name = "Табард Некры"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/templar/necran
	donatitem = TRUE
	
/datum/loadout_item/donat/tabard/crusader/psydon
	name = "Табард Псайдона"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/psydontabard
	donatitem = TRUE

/datum/loadout_item/poncho
	name = "Пончо"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/poncho
	donatitem = TRUE

/datum/loadout_item/donat/elvencloak
	name = "Эльфийский плащ"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/twilight_elven
	donatitem = TRUE

/datum/loadout_item/donat/elvencloak_short
	name = "Короткий эльфийский плащ"
	category = list("Плащи", "Донат")
	path = /obj/item/clothing/cloak/twilight_elven/short
	donatitem = TRUE

/datum/loadout_item/donat/scarf
	name = "Шарф"
	category = list("Аксессуары", "Донат")
	path = /obj/item/clothing/cloak/twilight_scarf
	donatitem = TRUE

/datum/loadout_item/donat/elven_burka
	name = "Эльфийская бурка"
	category = list("Головные уборы", "Донат")
	path = /obj/item/clothing/head/roguetown/twilight_elven_hat

/datum/loadout_item/donat/loveamulet
	name = "Амулет Слез Любви"
	category = list("Аксессуары", "Донат")
	path = /obj/item/clothing/neck/roguetown/loveamulet
	donatitem = TRUE

// Маски

/datum/loadout_item/donat/naledimask
	name = "Маска Наледи"
	category = list("Головные уборы", "Донат")
	path = /obj/item/clothing/mask/rogue/lordmask/naledi/decorated
	donatitem = TRUE

/datum/loadout_item/donat/eoramask
	name = "Эоранская маска"
	category = list("Головные уборы", "Донат")
	path = /obj/item/clothing/head/roguetown/eoramask
	donatitem = TRUE

// Шляпы

/datum/loadout_item/donat/grenzelhofthat_decorated
	name = "Грензельхофтская шляпа(без брони, декоративная)"
	category = list("Головные уборы", "Донат")
	path = /obj/item/clothing/head/roguetown/grenzelhofthat/decorated
	donatitem = TRUE
