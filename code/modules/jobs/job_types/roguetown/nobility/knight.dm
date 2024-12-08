/datum/job/roguetown/knight
	title = "Royal Guard"		//Knights, but their role is far more clear this way.
	flag = KNIGHT
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	tutorial = "Having proven yourself both loyal and capable, you have been knighted to serve the realm as the Grand Duke's personal guard. You listen to your Liege and the Captain of the Guard, defending your Lord and realm."
	display_order = JDO_KNIGHT
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/knight
	advclass_cat_rolls = list(CTAG_ROYALGUARD = 20)

	give_bank_account = 22
	noble_income = 10
	min_pq = 8
	max_pq = null
	round_contrib_points = 2

	cmode_music = 'sound/music/combat_knight.ogg'

/datum/job/roguetown/knight/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard/surcoat/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "knight's tabard ([index])"
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Ser"
		if(H.pronouns == SHE_HER || H.pronouns == THEY_THEM_F)
			honorary = "Dame"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"

		for(var/X in peopleknowme)
			for(var/datum/mind/MF in get_minds(X))
				if(MF.known_people)
					MF.known_people -= prev_real_name
					H.mind.person_knows_me(MF)

/datum/outfit/job/roguetown/knight
	head = /obj/item/clothing/head/roguetown/helmet/bascinet/pigface
	pants = /obj/item/clothing/under/roguetown/chainlegs
	cloak = /obj/item/clothing/cloak/stabard/surcoat/guard
	gloves = /obj/item/clothing/gloves/roguetown/chain
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/keyring/guardcastle
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/signal_horn = 1)

/datum/advclass/knight/heavy
	name = "Heavy Knight"
	tutorial = "You are the indesputed master of man-on-man combat. Shockingly adept with massive swords, axes, and maces. People may fear the mounted knights, but they should truly fear those who come off their mount.."
	outfit = /datum/outfit/job/roguetown/knight/heavy

	category_tags = list(CTAG_ROYALGUARD)

/datum/outfit/job/roguetown/knight/heavy/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)		//swapped with sword skill to make it fair for them to use the iconic high-strength two-handed swords
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)		//axes are a two-handed weapon
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)			//Heavy-knight so not as good at riding. Don't crush your mount!
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)		
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)			//these guys suck with ranged weapons compared to other knights

	//Normal shared skill section.
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)	//Knights should be used to the horrors of war if they're tride-and-true.
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)		//Knights are /technically/ nobles? But they are of the lower-tiers; mainly that a non-blue-blood could become a knight
	ADD_TRAIT(H, TRAIT_KNIGHTSMAN, TRAIT_GENERIC) //if they can't figure out how to win vs someone in leather armor with this i literally can not help them anymore
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()		//For knightly voices; even though I despise them.
	H.verbs |= /mob/proc/haltyell


	H.change_stat("strength", 2) //tanky, two-handed melee brutes. more endurance/con than other classes in exchange for a heavy speed debuff and worse bow skills
	H.change_stat("constitution", 3)
	H.change_stat("endurance", 3)
	H.change_stat("intelligence", 1)
	H.change_stat("speed", -1)

	H.adjust_blindness(-3)
	var/weapons = list("Zweihander","Great Mace","Battle Axe", "Estoc")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Zweihander") 	// A two-handed sword, but not the strongest one
			r_hand = /obj/item/rogueweapon/greatsword/zwei
			backl = /obj/item/gwstrap
		if("Great Mace")	// Great-mace, 2-handed
			r_hand = /obj/item/rogueweapon/mace/goden/steel
		if("Battle Axe")	// Why did heavy knights get a mace+shield combo if they're supposed to be the two-hander guys? Gives them a greataxe instead.
			r_hand = /obj/item/rogueweapon/stoneaxe/battle
		if("Estoc")
			r_hand = /obj/item/rogueweapon/estoc
			backl = /obj/item/gwstrap

	neck = /obj/item/clothing/neck/roguetown/bevor
	armor = /obj/item/clothing/suit/roguetown/armor/plate		//this is actually steel half-plate, full plate is plate/full. given because they are SLOW.

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1)

/datum/advclass/knight/footknight
	name = "Foot Knight"
	tutorial = "You are accustomed to traditional foot-soldier training in swords, flails, and shields. You are not as used to riding a mount as other knights, but you are the finest of all with the versatile combination of a shield and weapon!"
	outfit = /datum/outfit/job/roguetown/knight/footknight

	category_tags = list(CTAG_ROYALGUARD)

/datum/outfit/job/roguetown/knight/footknight/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)		//axe proficiency was swapped with swords because swords have many one-handed options while axes are all ideally two-handed weapons
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)		//Mildly better shield skill due to less weapon options, kind of their specialty
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)			//Foot-knight so not as good at riding.
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)

	//Normal shared skill section.
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)	//Knights should be used to the horrors of war if they're tride-and-true.
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)		//Knights are /technically/ nobles? But they are of the lower-tiers; mainly that a non-blue-blood could become a knight.
	ADD_TRAIT(H, TRAIT_KNIGHTSMAN, TRAIT_GENERIC) //if they can't figure out how to win vs someone in leather armor with this i literally can not help them anymore
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()		//For knightly voices; even though I despise them.
	H.verbs |= /mob/proc/haltyell

	H.change_stat("strength", 2)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 2) // generalist sword/shield infantry
	H.change_stat("intelligence", 1) //was asked to give them each +1 intelligence

	H.adjust_blindness(-3)
	var/weapons = list("Bastard Sword","Flail")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Bastard Sword")
			beltr = /obj/item/rogueweapon/sword/long	//very usable one-handed, has a force of 25
			backl = /obj/item/rogueweapon/shield/tower/metal
		if("Flail")
			beltr = /obj/item/rogueweapon/flail/sflail		//these steel flails spawn in the armory anyways
			backl = /obj/item/rogueweapon/shield/tower/metal

	neck = /obj/item/clothing/neck/roguetown/chaincoif
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates		//given because it's less durability than the steel cuirass but is actually heavy, making use of their heavy skill, unlike cuirass

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1)

/datum/advclass/knight/mountedknight
	name = "Mounted Knight"
	tutorial = "You are the picture-perfect knight from a high tale, knowledgeable in riding steeds into battle. You specialize in weapons most useful on a saiga including spears, swords and maces, but know your way around a shield."
	outfit = /datum/outfit/job/roguetown/knight/mountedknight

	category_tags = list(CTAG_ROYALGUARD)

/datum/outfit/job/roguetown/knight/mountedknight/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)		// gave them polearm proficiency because mounted spear-knights were very common and a popular trope, traded with heavyknights to let them be greatsword guys
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)		//debuffed because axes are ideally two-handed and not... really a mounty weapon?
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)		//gave mounted knights maces instead of flails because we only have the one-handed flails currently and maces were more commonly used on horseback
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)		//Mildly better shield skill due to less weapon options.
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)			//this is their THING
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)

	//Normal shared skill section.
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)	//Knights should be used to the horrors of war if they're tride-and-true.
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)		//Knights are /technically/ nobles? But they are of the lower-tiers; mainly that a non-blue-blood could become a knight.
	ADD_TRAIT(H, TRAIT_KNIGHTSMAN, TRAIT_GENERIC) //if they can't figure out how to win vs someone in leather armor with this i literally can not help them anymore
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()		//For knightly voices; even though I despise them.
	H.verbs |= /mob/proc/haltyell

	H.change_stat("strength", 1)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 1)
	H.change_stat("intelligence", 1) // excels at riding, archery, and polearms - less strength/con/end than other classes, but higher perception/speed

	H.adjust_blindness(-3)
	var/weapons = list("Sword + Recurve Bow","Mace + Crossbow","Spear + Shield")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Sword + Recurve Bow")
			r_hand = /obj/item/rogueweapon/sword
			beltr = /obj/item/quiver/arrows
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve

		if("Mace + Crossbow")
			r_hand = /obj/item/rogueweapon/mace
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			beltr = /obj/item/quiver/bolts
		
		if("Spear + Shield")
			r_hand = /obj/item/rogueweapon/spear
			backl = /obj/item/rogueweapon/shield/tower/metal

	neck = /obj/item/clothing/neck/roguetown/chaincoif
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates	//given because it's less durability than the steel cuirass but is actually heavy, making use of their heavy skill, unlike cuirass

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1)
