/datum/advclass/wretch/pyromaniac
	name = "Pyromaniac"
	tutorial = "A notorious arsonist with a penchant for fire, you wield your own personal vendetta against the chaotic forces within Azuria. Bring mayhem and destruction with flame and misfortune! Just... try not to hit yourself with your explosives - you aren't fireproof, after all."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/pyromaniac
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER, TRAIT_OUTLAW, TRAIT_MEDIUMARMOR, TRAIT_HERESIARCH)

/datum/outfit/job/roguetown/wretch/pyromaniac/pre_equip(mob/living/carbon/human/H)
	head = /obj/item/clothing/head/roguetown/helmet/heavy/sheriff //wear protection :) 
	mask = /obj/item/clothing/mask/rogue/facemask/
	neck = /obj/item/clothing/neck/roguetown/chaincoif/full //Protect your head!
	pants = /obj/item/clothing/under/roguetown/splintlegs
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/iron
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	gloves = /obj/item/clothing/gloves/roguetown/plate/iron
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	wrists = /obj/item/clothing/wrists/roguetown/splintarms
	r_hand = /obj/item/bomb
	l_hand = /obj/item/bomb
	backpack_contents = list(
		/obj/item/bomb = 2,
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/flashlight/flare/torch/lantern/prelit = 1,
		/obj/item/flint = 1,
		)
	H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // RUN BOY RUN
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE) // To escape grapplers, fuck you
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	H.change_stat("endurance", 3)
	H.change_stat("constitution", 3)
	H.change_stat("intelligence", 3)
	wretch_select_bounty(H)
	H.cmode_music = 'sound/music/Iconoclast.ogg'
	var/weapons = list("Archery", "Crossbows", "LET THERE BE FLAME!!!")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Archery")
			H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			beltl = /obj/item/quiver/pyroarrows
		if("Crossbows")
			H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			beltl = /obj/item/quiver/pyrobolts
		if("LET THERE BE FLAME!!!")
			H.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			backr = /obj/item/rogueweapon/woodstaff/toper
			if(H.mind)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/spitfire)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/stoneskin) // To not be instapaincritted if you accidentally hit yourself
