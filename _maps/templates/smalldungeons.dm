//!View bog_shack_small.dm for documentation

/obj/effect/landmark/map_load_mark/smalldungeon
	name = "Small Dungeon"
	templates = list( "smalldungeon1" )

/datum/map_template/smalldungeon1
	name = "Small Dungeon Varient 1"
	id = "smalldungeon1"
	mappath = "_maps/map_files/templates/smalldungeons/smalldungeon1.dmm"

/obj/effect/spawner/lootdrop/roguetown/dungeon
	name = "dungeon spawner"
	loot = list(
		// Materials
		/obj/item/natural/bundle/stick = 2,
		/obj/item/natural/fibers = 4,
		/obj/item/natural/stone = 4,
		/obj/item/rogueore/coal	= 4,
		/obj/item/ingot/iron = 1,
		/obj/item/ingot/steel = 1,
		/obj/item/rogueore/iron = 3,
		/obj/item/natural/bundle/fibers = 2,

		// Clothing
		/obj/item/clothing/cloak/stabard = 3,
		/obj/item/storage/backpack/rogue/satchel = 3,
		/obj/item/clothing/shoes/roguetown/simpleshoes = 4,
		/obj/item/clothing/suit/roguetown/shirt/undershirt/random = 5,
		/obj/item/storage/belt/rogue/leather/cloth = 4,
		/obj/item/clothing/cloak/raincloak/mortus = 3,
		/obj/item/clothing/head/roguetown/armingcap = 4,
		/obj/item/clothing/cloak/apron/waist = 3,
		/obj/item/storage/belt/rogue/leather/rope = 3,
		/obj/item/clothing/under/roguetown/tights/vagrant = 4,
		/obj/item/clothing/gloves/roguetown/leather = 4,
		/obj/item/clothing/shoes/roguetown/boots = 4,
		/obj/item/clothing/shoes/roguetown/boots/leather = 4,
		/obj/item/storage/belt/rogue/leather/knifebelt/iron = 2,
		/obj/item/storage/belt/rogue/leather/knifebelt/black/steel = 1,

		// Money
		/obj/item/roguecoin/copper = 5,
		/obj/item/roguecoin/silver = 5,
		/obj/item/roguecoin/gold = 5,
		/obj/item/roguecoin/copper/pile = 3,
		/obj/item/roguecoin/silver/pile = 2,
		/obj/item/roguecoin/gold/pile = 1,

		// Garbage and Miscellanous
		/obj/item/rogue/instrument/flute = 3,
		/obj/item/ash = 5,
		/obj/item/natural/glass/shard = 5,
		/obj/item/candle/yellow = 3,
		/obj/item/flashlight/flare/torch = 3,
		/obj/item/reagent_containers/glass/bowl = 4,
		/obj/item/reagent_containers/glass/cup = 4,
		/obj/item/reagent_containers/glass/cup/wooden = 4,
		/obj/item/reagent_containers/glass/cup/steel = 3,
		/obj/item/reagent_containers/glass/cup/golden = 1,
		/obj/item/reagent_containers/glass/cup/skull = 1,
		/obj/item/reagent_containers/glass/bucket/wooden = 3,
		/obj/item/natural/feather = 4,
		/obj/item/paper/scroll = 3,
		/obj/item/rope = 3,
		/obj/item/rope/chain = 3,
		/obj/item/storage/roguebag/crafted = 3,
		/obj/item/clothing/mask/cigarette/pipe = 3,
		/obj/item/paper = 3,
		/obj/item/reagent_containers/glass/bowl = 3,
		/obj/item/storage/bag/tray = 3,
		/obj/item/mundane/puzzlebox/medium = 3,
		/obj/item/mundane/puzzlebox/easy = 1,
		/obj/item/mundane/puzzlebox/impossible = 2,

		//medical
		/obj/item/needle = 4,
		/obj/item/natural/cloth = 5,
		/obj/item/natural/bundle/cloth = 3,

		//weapons
		/obj/item/rogueweapon/mace = 2,
		/obj/item/rogueweapon/huntingknife/idagger/steel = 3,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow = 2,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve = 2,
		/obj/item/gun/ballistic/revolver/grenadelauncher/crossbow = 2,
		/obj/item/quiver/arrows = 2,
		/obj/item/quiver/bolts = 2,
		/obj/item/rogueweapon/mace/woodclub/crafted = 3,
		/obj/item/rogueweapon/mace/steel/morningstar =2,
		/obj/item/rogueweapon/mace/cudgel = 2,
		/obj/item/rogueweapon/mace/wsword = 3,
		/obj/item/rogueweapon/huntingknife = 3,
		/obj/item/rogueweapon/huntingknife/stoneknife = 3,
		/obj/item/rogueweapon/halberd = 1,
		/obj/item/rogueweapon/woodstaff = 3,
		/obj/item/rogueweapon/spear = 2,
		/obj/item/rogueweapon/huntingknife/idagger/navaja = 2,
		/obj/item/rogueweapon/sword/cutlass = 2,
		/obj/item/rogueweapon/sword/long = 2,
		/obj/item/rogueweapon/katar = 1,
		/obj/item/rogueweapon/flail = 1,
		/obj/item/rogueweapon/estoc = 1,
		/obj/item/rogueweapon/greatsword/zwei = 1,
		/obj/item/rogueweapon/eaglebeak/lucerne = 1,
		/obj/item/rogueweapon/eaglebeak = 1,
		/obj/item/rogueweapon/spear/billhook = 1,
		/obj/item/rogueweapon/huntingknife/throwingknife/steel = 1,

		// tools
		/obj/item/rogueweapon/shovel = 3,
		/obj/item/rogueweapon/thresher = 3,
		/obj/item/flint = 4,
		/obj/item/rogueweapon/stoneaxe/woodcut = 3,
		/obj/item/rogueweapon/stoneaxe = 3,
		/obj/item/rogueweapon/hammer = 3,
		/obj/item/rogueweapon/tongs = 3,
		/obj/item/rogueweapon/pick = 3,

		//armor
		/obj/item/clothing/suit/roguetown/armor/leather/studded = 2,
		/obj/item/clothing/suit/roguetown/armor/leather = 2,
		/obj/item/clothing/suit/roguetown/armor/leather/hide = 2,
		/obj/item/clothing/suit/roguetown/armor/leather/studded/bikini = 2,
		/obj/item/clothing/suit/roguetown/armor/leather/hide/bikini = 2,
		/obj/item/clothing/suit/roguetown/armor/gambeson = 2,
		/obj/item/clothing/under/roguetown/chainlegs = 2,
		/obj/item/clothing/under/roguetown/brayette = 2,
		/obj/item/clothing/under/roguetown/platelegs = 1,
		/obj/item/clothing/under/roguetown/chainlegs/skirt = 2,
		/obj/item/clothing/gloves/roguetown/chain = 2,
		/obj/item/clothing/suit/roguetown/armor/chainmail = 1,
		/obj/item/clothing/suit/roguetown/armor/chainmail/iron = 2,
		/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk = 1,
		/obj/item/clothing/suit/roguetown/armor/plate/half = 1,
		/obj/item/clothing/neck/roguetown/gorget = 1,
		/obj/item/clothing/suit/roguetown/armor/plate/half/iron = 1,
		/obj/item/clothing/head/roguetown/helmet/kettle = 1,
		/obj/item/clothing/head/roguetown/helmet/leather = 2,
		/obj/item/clothing/head/roguetown/helmet/horned = 1,
		/obj/item/clothing/head/roguetown/helmet/skullcap = 1,
		/obj/item/clothing/head/roguetown/helmet/winged = 1,
		/obj/item/clothing/suit/roguetown/armor/plate/bikini = 1,
		/obj/item/clothing/suit/roguetown/armor/plate = 1,
		/obj/item/clothing/suit/roguetown/armor/longcoat = 2,
		/obj/item/clothing/suit/roguetown/armor/plate/blacksteel_half_plate = 1,


		//food
		/obj/item/reagent_containers/food/snacks/rogue/crackerscooked = 3,
		/obj/item/reagent_containers/food/snacks/butterslice = 3,
		/obj/item/reagent_containers/powder/salt = 3,
		/obj/item/reagent_containers/food/snacks/egg = 3,

	)
	lootcount = 1

/obj/effect/spawner/lootdrop/roguetown/dungeon/materials
	loot = list(
		// Materials
		/obj/item/natural/bundle/stick = 2,
		/obj/item/natural/fibers = 3,
		/obj/item/natural/stone = 3,
		/obj/item/grown/log/tree/small = 3,
		/obj/item/rogueore/coal	= 3,
		/obj/item/ingot/iron = 2,
		/obj/item/ingot/steel = 2,
		/obj/item/rogueore/iron = 3,
		/obj/item/natural/bundle/fibers = 2
		)
	lootcount = 2

/obj/effect/spawner/lootdrop/roguetown/dungeon/clothing
	loot = list(
		// Clothing
		/obj/item/clothing/cloak/stabard = 3,
		/obj/item/storage/backpack/rogue/satchel = 3,
		/obj/item/clothing/shoes/roguetown/simpleshoes = 4,
		/obj/item/clothing/suit/roguetown/shirt/undershirt/random = 5,
		/obj/item/storage/belt/rogue/leather/cloth = 4,
		/obj/item/clothing/cloak/raincloak/mortus = 3,
		/obj/item/clothing/head/roguetown/armingcap = 4,
		/obj/item/clothing/cloak/apron/waist = 3,
		/obj/item/storage/belt/rogue/leather/rope = 3,
		/obj/item/clothing/under/roguetown/tights/vagrant = 4,
		/obj/item/clothing/gloves/roguetown/leather = 4,
		/obj/item/clothing/shoes/roguetown/boots = 4,
		/obj/item/clothing/shoes/roguetown/boots/leather = 4
	)
	lootcount = 1

/obj/effect/spawner/lootdrop/roguetown/dungeon/money
	loot = list(
		// Money
		/obj/item/roguecoin/copper = 5,
		/obj/item/roguecoin/silver = 5,
		/obj/item/roguecoin/gold = 5,
		/obj/item/roguecoin/copper/pile = 3,
		/obj/item/roguecoin/silver/pile = 2,
		/obj/item/roguecoin/gold/pile = 1
	)
	lootcount = 2

/obj/effect/spawner/lootdrop/roguetown/dungeon/misc
	loot = list(
		// Garbage and Miscellanous
		/obj/item/rogue/instrument/flute = 3,
		/obj/item/rogue/instrument/lute = 3,
		/obj/item/rogue/instrument/accord = 3,
		/obj/item/ash = 5,
		/obj/item/natural/glass/shard = 5,
		/obj/item/candle/yellow = 3,
		/obj/item/flashlight/flare/torch = 3,
		/obj/item/flashlight/flare/torch/lantern = 1,
		/obj/item/reagent_containers/glass/bowl = 4,
		/obj/item/reagent_containers/glass/cup = 4,
		/obj/item/reagent_containers/glass/cup/wooden = 4,
		/obj/item/reagent_containers/glass/cup/steel = 3,
		/obj/item/reagent_containers/glass/cup/golden = 1,
		/obj/item/reagent_containers/glass/cup/skull = 1,
		/obj/item/reagent_containers/glass/bucket/wooden = 3,
		/obj/item/natural/feather = 4,
		/obj/item/paper/scroll = 3,
		/obj/item/rope = 3,
		/obj/item/rope/chain = 3,
		/obj/item/storage/roguebag/crafted = 3,
		/obj/item/clothing/mask/cigarette/pipe = 3,
		/obj/item/clothing/mask/cigarette/rollie = 3,
		/datum/crafting_recipe/roguetown/sigsweet = 2,
		/datum/crafting_recipe/roguetown/sigdry = 2,
		/obj/item/paper = 3,
		/obj/item/reagent_containers/glass/bowl = 3,
		/obj/item/storage/bag/tray = 3,
		/obj/item/mundane/puzzlebox/medium = 2,
		/obj/item/mundane/puzzlebox/easy = 2,
		/obj/item/mundane/puzzlebox/impossible = 1
	)
	lootcount = 1

/obj/effect/spawner/lootdrop/roguetown/dungeon/medical
	loot = list(
		//medical
		/obj/item/needle = 4,
		/obj/item/natural/cloth = 5,
		/obj/item/natural/bundle/cloth = 3
	)
	lootcount = 2

/obj/effect/spawner/lootdrop/roguetown/dungeon/weapons
	loot = list(
		//weapons
		/obj/item/rogueweapon/mace = 2,
		/obj/item/rogueweapon/huntingknife/idagger/steel = 3,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow = 2,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve = 2,
		/obj/item/gun/ballistic/revolver/grenadelauncher/crossbow = 2,
		/obj/item/quiver/arrows = 2,
		/obj/item/quiver/bolts = 2,
		/obj/item/rogueweapon/mace/woodclub/crafted = 3,
		/obj/item/rogueweapon/mace/steel/morningstar =2,
		/obj/item/rogueweapon/mace/cudgel = 2,
		/obj/item/rogueweapon/mace/wsword = 3,
		/obj/item/rogueweapon/huntingknife = 3,
		/obj/item/rogueweapon/huntingknife/stoneknife = 3,
		/obj/item/rogueweapon/halberd = 1,
		/obj/item/rogueweapon/woodstaff = 3,
		/obj/item/rogueweapon/spear = 2,
		/obj/item/rogueweapon/huntingknife/idagger/navaja = 2,
		/obj/item/rogueweapon/sword/cutlass = 2,
		/obj/item/rogueweapon/sword/long = 2,
		/obj/item/rogueweapon/katar = 1,
		/obj/item/rogueweapon/flail = 1,
		/obj/item/rogueweapon/estoc = 1,
		/obj/item/rogueweapon/greatsword/zwei = 1,
		/obj/item/rogueweapon/eaglebeak/lucerne = 1,
		/obj/item/rogueweapon/eaglebeak = 1,
		/obj/item/rogueweapon/spear/billhook = 1,


	)
	lootcount = 1

/obj/effect/spawner/lootdrop/roguetown/dungeon/tools
	loot = list(
		// tools
		/obj/item/rogueweapon/shovel = 3,
		/obj/item/rogueweapon/thresher = 3,
		/obj/item/flint = 4,
		/obj/item/rogueweapon/stoneaxe/woodcut = 3,
		/obj/item/rogueweapon/stoneaxe = 3,
		/obj/item/rogueweapon/hammer = 3,
		/obj/item/rogueweapon/tongs = 3,
		/obj/item/rogueweapon/pick = 3
	)
	lootcount = 1

/obj/effect/spawner/lootdrop/roguetown/dungeon/armor
	loot = list(
		//armor
		/obj/item/clothing/suit/roguetown/armor/leather/studded = 2,
		/obj/item/clothing/suit/roguetown/armor/leather = 2,
		/obj/item/clothing/suit/roguetown/armor/leather/hide = 2,
		/obj/item/clothing/suit/roguetown/armor/leather/studded/bikini = 2,
		/obj/item/clothing/suit/roguetown/armor/leather/hide/bikini = 2,
		/obj/item/clothing/suit/roguetown/armor/gambeson = 2,
		/obj/item/clothing/under/roguetown/chainlegs = 2,
		/obj/item/clothing/under/roguetown/brayette = 2,
		/obj/item/clothing/under/roguetown/platelegs = 1,
		/obj/item/clothing/under/roguetown/chainlegs/skirt = 2,
		/obj/item/clothing/gloves/roguetown/chain = 2,
		/obj/item/clothing/suit/roguetown/armor/chainmail = 1,
		/obj/item/clothing/suit/roguetown/armor/chainmail/iron = 2,
		/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk = 1,
		/obj/item/clothing/suit/roguetown/armor/plate/half = 1,
		/obj/item/clothing/neck/roguetown/gorget = 1,
		/obj/item/clothing/suit/roguetown/armor/plate/half/iron = 1,
		/obj/item/clothing/head/roguetown/helmet/kettle = 1,
		/obj/item/clothing/head/roguetown/helmet/leather = 2,
		/obj/item/clothing/head/roguetown/helmet/horned = 1,
		/obj/item/clothing/head/roguetown/helmet/skullcap = 1,
		/obj/item/clothing/head/roguetown/helmet/winged = 1,
		/obj/item/clothing/suit/roguetown/armor/plate/bikini = 1,
		/obj/item/clothing/suit/roguetown/armor/plate = 1,
		/obj/item/clothing/suit/roguetown/armor/longcoat = 2,
		/obj/item/clothing/suit/roguetown/armor/plate/blacksteel_half_plate = 1,
	)
	lootcount = 1

/obj/effect/spawner/lootdrop/roguetown/dungeon/food
	loot = list(
		//food
		/obj/item/reagent_containers/food/snacks/rogue/crackerscooked = 3,
		/obj/item/reagent_containers/food/snacks/butterslice = 3,
		/obj/item/reagent_containers/powder/salt = 3,
		/obj/item/reagent_containers/food/snacks/egg = 3
	)
	lootcount = 2

/obj/effect/spawner/lootdrop/roguetown/dungeon/spells
	loot = list(
		//spells
		/obj/item/book/granter/spell/blackstone/spitfire = 5,
		/obj/item/book/granter/spell/blackstone/lesserknock = 5,
		/obj/item/book/granter/spell/blackstone/bonechill = 5,
		/obj/item/book/granter/spell/blackstone/featherfall = 5,
		/obj/item/book/granter/spell/blackstone/sicknessray = 5,
		/obj/item/book/granter/spell/blackstone/poisonspray5e = 5,
		/obj/item/book/granter/spell/blackstone/frostbolt = 5,
		/obj/item/book/granter/spell/blackstone/forcewall_weak = 4,
		/obj/item/book/granter/spell/blackstone/guidance = 4,
		/obj/item/book/granter/spell/blackstone/fortitude = 4,
		/obj/item/book/granter/spell/blackstone/leap = 4,
		/obj/item/book/granter/spell/blackstone/enlarge = 4,
		/obj/item/book/granter/spell/blackstone/repel = 3,
		/obj/item/book/granter/spell/blackstone/fetch = 3,
		/obj/item/book/granter/spell/blackstone/fireball = 3,
		/obj/item/book/granter/spell/blackstone/message = 3,
		/obj/item/book/granter/spell/blackstone/ensnare = 2,
		/obj/item/book/granter/spell/blackstone/lightning = 2,
		/obj/item/book/granter/spell/blackstone/blindness = 2,
		/obj/item/book/granter/spell/blackstone/invisibility = 2,
		/obj/item/book/granter/spell/blackstone/greaterfireball = 1
	)
	lootcount = 1
