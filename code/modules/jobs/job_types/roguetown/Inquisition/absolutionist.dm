/datum/job/roguetown/absolutionist
	title = "Absolutionist"
	flag = ABSOLUTIONIST
	department_flag = INQUISITION
	faction = "Station"
	total_positions = 1 // THE ONE.
	spawn_positions = 1
	allowed_races = RACES_ALL_KINDS
	allowed_patrons = list(/datum/patron/old_god) //You MUST have a Psydonite character to start. Just so people don't get japed into Oops Suddenly Psydon!
	tutorial = "Whether hand-picked by the Sovereignty of Otava or taken along through mere circumstance, you now serve as a loyal adherent to the Inquisitor's retinue. Descend into the darkness and - be it with a clenched fist or an opened palm - bring the inhumen towards the light: gift them salvation or damnation."
	selection_color = JCOLOR_INQUISITION
	outfit = /datum/outfit/job/roguetown/absolutionist
	display_order = JDO_ABSOLUTIONIST
	min_pq = 3 // Low potential for grief. A pacifist by trade. Also needs to know wtf a PSYDON is.
	max_pq = null
	round_contrib_points = 2
	advclass_cat_rolls = list(CTAG_INQUISITION = 20)
	wanderer_examine = FALSE
	advjob_examine = FALSE
	give_bank_account = 15

// REMEMBER FLAGELLANT? REMEMBER LASZLO? THIS IS HIM NOW. FEEL OLD YET?

/datum/outfit/job/roguetown/absolutionist/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) // Enduring.
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE) // A hobbyist.

	wrists = /obj/item/clothing/wrists/roguetown/bracers/psythorns
	gloves = /obj/item/clothing/gloves/roguetown/otavan/psygloves
	beltr = /obj/item/flashlight/flare/torch/lantern/psycenser
	beltl = /obj/item/storage/belt/rogue/surgery_bag/full
	neck = /obj/item/clothing/neck/roguetown/psicross/silver
	cloak = /obj/item/clothing/cloak/absolutionistrobe
	backr = /obj/item/storage/backpack/rogue/satchel/otavan
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/fencer/psydon
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/inq
	shoes = /obj/item/clothing/shoes/roguetown/boots/psydonboots
	mask = /obj/item/clothing/head/roguetown/helmet/blacksteel/psythorns
	head = /obj/item/clothing/head/roguetown/helmet/heavy/absolutionist
	id = /obj/item/clothing/ring/signet/silver
	backpack_contents = list(
		/obj/item/roguekey/inquisition = 1,
		)
	H.change_stat("strength", 1)
	H.change_stat("endurance", 3)
	H.change_stat("constitution", 7)
	H.change_stat("intelligence", 1)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_miracles(H, cleric_tier = CLERIC_T4, passive_gain = CLERIC_REGEN_ABSOLUTIONIST, start_maxed = TRUE) // PSYDONIAN MIRACLE-WORKER. LUX-MERGING FREEK.
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_PACIFISM, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INQUISITION, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OUTLANDER, TRAIT_GENERIC)		//You're a foreigner, a guest of the realm.
	H.grant_language(/datum/language/otavan)
