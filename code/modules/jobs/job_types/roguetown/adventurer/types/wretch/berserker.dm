/datum/advclass/wretch/berserker
	name = "Berserker"
	tutorial = "You are a warrior feared for your brutality, dedicated to using your might for your own gain. Might equals right, and you are the reminder of such a saying."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/wretch/berserker
	cmode_music = 'sound/music/cmode/antag/combat_darkstar.ogg'
	category_tags = list(CTAG_WRETCH)
	traits_applied = list(TRAIT_STRONGBITE, TRAIT_CRITICAL_RESISTANCE, TRAIT_NOPAINSTUN)
	// Literally same stat spread as Atgervi Shaman
	subclass_stats = list(
		STATKEY_STR = 3,
		STATKEY_CON = 2,
		STATKEY_WIL = 1,
		STATKEY_SPD = 1,
		STATKEY_INT = -1,
		STATKEY_PER = -1
	)
	subclass_skills = list(
		/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/axes = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/tracking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/medicine = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/tanning = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
		/datum/skill/labor/butchering = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/wretch/berserker/pre_equip(mob/living/carbon/human/H)
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	mask = /obj/item/clothing/mask/rogue/wildguard
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	gloves = /obj/item/clothing/gloves/roguetown/plate
	backr = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife = 1,
		/obj/item/flashlight/flare/torch/lantern/prelit = 1,
		/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
		/obj/item/rope/chain = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/reagent_containers/glass/bottle/alchemical/healthpot = 1,	//Small health vial
		)
	H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/berserk_trance)
		var/weapons = list("Katar","Steel Knuckles","Punch Dagger","MY BARE HANDS!!!","Battle Axe","Mace","Sword")
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		H.set_blindness(0)
		switch(weapon_choice)
			if ("Katar")
				H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_MASTER, TRUE)
				beltr = /obj/item/rogueweapon/katar
			if ("Steel Knuckles")
				H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_MASTER, TRUE)
				beltr = /obj/item/rogueweapon/knuckles
			if ("Punch Dagger")
				H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_MASTER, TRUE)
				beltr = /obj/item/rogueweapon/katar/punchdagger
			if ("MY BARE HANDS!!!")
				H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_MASTER, TRUE)
				ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)
			if ("Battle Axe")
				H.adjust_skillrank_up_to(/datum/skill/combat/axes, SKILL_LEVEL_EXPERT, TRUE)
				beltr = /obj/item/rogueweapon/stoneaxe/battle
			if ("Mace")
				H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_EXPERT, TRUE)
				beltr = /obj/item/rogueweapon/mace/goden/steel
			if ("Sword")
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_EXPERT, TRUE)
				beltr = /obj/item/rogueweapon/scabbard/sword
				r_hand = /obj/item/rogueweapon/sword/falx
		wretch_select_bounty(H)



#define BERSERKRAGE_FILTER "berserkrage_glow"
/atom/movable/screen/alert/status_effect/buff/berserk_rage
	name = "Berserking Trance"
	desc = "My muscles are strengthened, and I am numb to pain. (+3 Strength)"
	icon_state = "buff"

/datum/status_effect/buff/giants_strength
	var/outline_colour ="#8B0000" //same as giant's
	id = "giantstrength"
	alert_type = /atom/movable/screen/alert/status_effect/buff/berserk_rage
	effectedstats = list(STATKEY_STR = 3)
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/buff/berserk_rage/on_apply()
	. = ..()
	var/filter = owner.get_filter(BERSERKRAGE_FILTER)
	if (!filter)
		owner.add_filter(BERSERKRAGE_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 50, "size" = 1))
	ADD_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)
	to_chat(owner, span_warning("I SEE ONLY RED."))


/datum/status_effect/buff/giants_strength/on_remove()
	. = ..()
	to_chat(owner, span_warning("My muscles ache."))
	owner.remove_filter(BERSERKRAGE_FILTER)
	REMOVE_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)

#undef BERSERKRAGE_FILTE


/obj/effect/proc_holder/spell/self/berserk_trance
	name = "Berserker Trance"
	overlay_state = "giantsstrength"
	desc = "I stop holding back. I will shatter myne bindings and their bones both. (+3 Strength)" // Design Note: +3 instead of +5 for direct damage stats
	recharge_time = 10 MINUTES //longe
	overlay_state = "giants_strength"
	range = 0


/obj/effect/proc_holder/spell/self/berserk_trance/cast(list/targets, mob/user)
	if (!isliving(user))
		revert_cast()
		return

	var/mob/living/carbon/human/H = user
	playsound(get_turf(H), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	H.apply_status_effect(/datum/status_effect/buff/giants_strength)
	H.visible_message(span_danger("[usr] enters a rage!"), span_notice("I enter a rage!"))
	H.emote("rage")

