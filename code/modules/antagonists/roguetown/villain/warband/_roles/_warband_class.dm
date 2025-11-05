/datum/advclass
	var/title							// name that exclusively appears in class selection
	var/datum/storytellerlimit			// required storyteller influence for the class to be available
	var/desc
	var/rarity							// storytellers can be chosen as influences multiple times | rarity is the required number of influences before a storyteller-limited class is unlocked
	var/f_name

/datum/mind
	var/warband_ID = 0			// character's warband_ID
	var/warbandsetup = FALSE		// failsafe for someone crashing mid-creation | if this is TRUE, they'll get the menu returned on login

////////////////////////////////////
/datum/job/roguetown/warband_lieutenant
	title = "Warlord's Lieutenant"
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	min_pq = null 
	max_pq = null
	announce_latejoin = FALSE

	tutorial = "You're but one among many who've sworn loyalty to your Warlord. Here within the AZURE PEAK, you come upon the hour where that loyalty \
				shall be put to the test. Slay whom he bids you slay. Burn what he bids you burn. When he bids you to die, die well."
	show_in_credits = TRUE
	give_bank_account = FALSE
	hidden_job = TRUE

//////////////////
//////////////////
//////////////////

/datum/job/roguetown/warband_grunt
	title = "Veteran Grunt"
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	min_pq = null
	max_pq = null
	announce_latejoin = FALSE

	tutorial = "You're but one among many who've sworn loyalty to your Lieutenant. Here within the AZURE PEAK, you come upon the hour where that loyalty \
				shall be put to the test. Slay whom he bids you slay. Burn what he bids you burn. When he bids you to die, die well."

	show_in_credits = TRUE
	give_bank_account = FALSE
	hidden_job = TRUE

//////////////////
//////////////////
//////////////////

/datum/job/roguetown/warband_envoy
	title = "Warlord's Envoy"
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	min_pq = null
	max_pq = null
	announce_latejoin = FALSE

	show_in_credits = FALSE
	give_bank_account = FALSE
	hidden_job = TRUE

/datum/advclass/warband/envoy
	name = "Warlord's Envoy"
	outfit = /datum/outfit/job/roguetown/warband/warband_envoy
	traits_applied = list(TRAIT_LAWEXPERT)
	subclass_stats = list(
		STATKEY_SPD = 3,
		STATKEY_INT = 2,
	)
	subclass_skills = list(
		/datum/skill/misc/reading = 4,
	)

/datum/outfit/job/roguetown/warband/warband_envoy/pre_equip(mob/living/carbon/human/H, used_slot)
	..()
	to_chat(H, span_warning("As an Envoy, you may return to your Warlord by interacting with a Recruitment Point. In the event of an emergency, use the ABANDON ENVOY verb in your Warband tab. Failing that, re-enter your corpse."))
	H.verbs += /mob/living/carbon/human/proc/abandon_envoy
	H.verbs += /mob/living/carbon/human/proc/shortcut
	H.verbs += /mob/living/carbon/human/proc/connect_warcamp
	H.verbs += /mob/living/carbon/human/proc/communicate
	H.mind.warband_manager.members += H
	H.pronouns = "he/him"
	backl = /obj/item/storage/backpack/rogue/satchel	
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, 
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/flashlight/flare/torch/lantern/prelit = 1,
		/obj/item/grown/log/tree/stake	
	)

	var/should_tweak = input(H, "Would you like to tweak your Envoy's name and gender?") in list("Yes", "No")
	if(should_tweak == "Yes")
		H.choose_pronouns_and_body()
		H.choose_name_popup()

	var/style = list("Diplomat","Cleric","Merchant","Nobility")
	var/style_choice = input(H, "How should the ENVOY be styled?", "STYLE") as anything in style
	switch(style_choice)
		if("Diplomat")
			shoes = /obj/item/clothing/shoes/roguetown/boots
			belt = /obj/item/storage/belt/rogue/leather/black
			id = /obj/item/clothing/ring/signet
			if(should_wear_femme_clothes(H))
				cloak = /obj/item/clothing/cloak/half/red
				shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/red
				pants = /obj/item/clothing/under/roguetown/tights/black	
			else
				head = /obj/item/clothing/head/roguetown/chaperon/greyscale
				cloak = /obj/item/clothing/cloak/half/red
				shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/red
				pants = /obj/item/clothing/under/roguetown/tights/black
		if("Cleric")
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest
			pants = /obj/item/clothing/under/roguetown/tights
			belt = /obj/item/storage/belt/rogue/leather/rope
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			id = /obj/item/clothing/ring/signet
			var/datum/devotion/C = new /datum/devotion(H, H.patron)
			C.grant_miracles(H, cleric_tier = CLERIC_T1, passive_gain = CLERIC_REGEN_MINOR, devotion_limit = CLERIC_REQ_1)
		if("Merchant")
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/merchant
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
			neck = /obj/item/storage/belt/rogue/pouch/coins/rich	// trades the signet ring for a coin pouch
			pants = /obj/item/clothing/under/roguetown/tights/sailor
			belt = /obj/item/storage/belt/rogue/leather/rope
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/appraise/secular)
		if("Nobility")
			ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
			if(should_wear_femme_clothes(H))
				belt = /obj/item/storage/belt/rogue/leather/cloth/lady
				armor = /obj/item/clothing/suit/roguetown/shirt/dress/gown/wintergown
				shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
				id = /obj/item/clothing/ring/signet
				shoes = /obj/item/clothing/shoes/roguetown/shortboots
			else if(should_wear_masc_clothes(H))
				pants = /obj/item/clothing/under/roguetown/tights
				armor = /obj/item/clothing/suit/roguetown/shirt/tunic/noblecoat
				shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut
				shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
				belt = /obj/item/storage/belt/rogue/leather
				id = /obj/item/clothing/ring/signet
