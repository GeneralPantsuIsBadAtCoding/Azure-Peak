GLOBAL_LIST_EMPTY(apostasy_players)
GLOBAL_LIST_EMPTY(cursed_players)
GLOBAL_LIST_EMPTY(excommunicated_players)
GLOBAL_LIST_EMPTY(heretical_players)
#define PRIEST_ANNOUNCEMENT_COOLDOWN (2 MINUTES)
#define PRIEST_SERMON_COOLDOWN (30 MINUTES)
#define PRIEST_APOSTASY_COOLDOWN (10 MINUTES)
#define PRIEST_EXCOMMUNICATION_COOLDOWN (10 MINUTES)
#define PRIEST_CURSE_COOLDOWN (15 MINUTES)
#define PRIEST_SWAP_COOLDOWN (20 MINUTES)

/datum/job/roguetown/priest
	title = "Bishop"
	flag = PRIEST
	department_flag = CHURCHMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	selection_color = JCOLOR_CHURCH
	f_title = "Bishop"
	allowed_races = RACES_NO_CONSTRUCT		//Too recent arrivals to ascend to priesthood.
	allowed_patrons = list(/datum/patron/divine/undivided)
	allowed_sexes = list(MALE, FEMALE)
	tutorial = "The Divine is all that matters in a world of the immoral. The Weeping God abandoned us, and in his stead the TEN rule over us mortals--and you will preach their wisdom to any who still heed their will. The faithless are growing in number. It is up to you to shepherd them toward a Gods-fearing future; for you are a Bishop of the Holy See."
	whitelist_req = FALSE
	cmode_music = 'sound/music/cmode/church/combat_astrata.ogg'

	spells = list(/obj/effect/proc_holder/spell/invoked/cure_rot, /obj/effect/proc_holder/spell/self/convertrole/templar, /obj/effect/proc_holder/spell/self/convertrole/monk, /obj/effect/proc_holder/spell/invoked/projectile/divineblast)
	outfit = /datum/outfit/job/roguetown/priest
	display_order = JDO_PRIEST
	give_bank_account = 115
	min_pq = 5 // You should know the basics of things if you're going to lead the town's entire religious sector
	max_pq = null
	round_contrib_points = 3

	//No nobility for you, being a member of the clergy means you gave UP your nobility. It says this in many of the church tutorial texts.
	virtue_restrictions = list(/datum/virtue/utility/noble)

/datum/outfit/job/roguetown/priest
	job_bitflag = BITFLAG_CHURCH
	allowed_patrons = list(/datum/patron/divine/undivided)	//We lock this cus head of church, acktully

/datum/outfit/job/roguetown/priest/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/psicross/undivided
	head = /obj/item/clothing/head/roguetown/priestmask
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	beltl = /obj/item/storage/keyring/priest
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	id = /obj/item/clothing/ring/active/nomag
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/priest
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/needle/pestra = 1,
		/obj/item/natural/worms/leech/cheele = 1, //little buddy
		/obj/item/ritechalk = 1,
		/obj/item/rogueweapon/huntingknife/idagger/steel/holysee = 1,	//Unique knife from the Holy See
		/obj/item/rogueweapon/scabbard/sheath = 1
	)
	ADD_TRAIT(H, TRAIT_CHOSEN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/magic/holy, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
	H.grant_language(/datum/language/grenzelhoftian)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
	H.change_stat("strength", -1)
	H.change_stat("intelligence", 3)
	H.change_stat("constitution", -1)
	H.change_stat("endurance", 1)
	H.change_stat("speed", -1)
	var/datum/devotion/C = new /datum/devotion(H, H.patron) // This creates the cleric holder used for devotion spells
	C.grant_miracles(H, cleric_tier = CLERIC_T4, passive_gain = CLERIC_REGEN_MAJOR, start_maxed = TRUE)	//Starts off maxed out.

	H.verbs |= /mob/living/carbon/human/proc/coronate_lord
	H.verbs |= /mob/living/carbon/human/proc/churchannouncement
	H.verbs |= /mob/living/carbon/human/proc/change_miracle_set
	H.verbs |= /mob/living/carbon/human/proc/churchexcommunicate //your button against clergy
	H.verbs |= /mob/living/carbon/human/proc/churchpriestcurse //snowflake priests button. Will not sacrifice them
	H.verbs |= /mob/living/carbon/human/proc/churcheapostasy //punish the lamb reward the wolf
	H.verbs |= /mob/living/carbon/human/proc/completesermon
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/convert_heretic_priest)

/datum/job/priest/vice //just used to change the priest title
	title = "Vice Priest"
	f_title = "Vice Priestess"
	flag = PRIEST
	department_flag = CHURCHMEN
	total_positions = 0
	spawn_positions = 0

/mob/living/carbon/human/proc/change_miracle_set(mob/living/user)
	set name = "Change Miracle Set"
	set category = "Priest"
	var/mono_first_pick = FALSE

	if(!mind || user != src)
		return

	if(HAS_TRAIT(src, TRAIT_MONOTHEIST))
		to_chat(src, "<font color='yellow'>I have dedicated myself to a single god.</font>")
		return

	if(!COOLDOWN_FINISHED(src, priest_change_miracles))
		to_chat(src, "<font color='yellow'>I am not yet ready to call upon another god.</font>")
		return

	if(!HAS_TRAIT(src, TRAIT_POLYTHEIST))
		var/choice = alert(src, "Do you wish to dedicate yourself to a single god? This choice is permanent and will prevent changing miracles in the future.", "Divine Dedication", "Dedicate (Monotheist)", "Remain Flexible (Polytheist)", "Cancel")

		switch(choice)
			if("Dedicate (Monotheist)")
				ADD_TRAIT(src, TRAIT_MONOTHEIST, "divine_dedication")
				mono_first_pick = TRUE
			if("Remain Flexible (Polytheist)")
				ADD_TRAIT(src, TRAIT_POLYTHEIST, "divine_dedication")
			else
				return

	// Create god selection menu
	var/list/god_choice = list()
	var/list/god_type = list()
	for(var/path as anything in GLOB.patrons_by_faith[/datum/faith/divine])
		var/datum/patron/patron = GLOB.patronlist[path]
		if(!patron || !patron.name)
			continue
		god_choice[patron.name] = icon(icon = 'icons/mob/overhead_effects.dmi', icon_state = "sign_[patron.name]")
		god_type[patron.name] = patron

	// Show radial menu
	var/string_choice = show_radial_menu(src, src, god_choice, require_near = FALSE)
	if(!string_choice)
		return

	// Apply new miracle set
	var/datum/patron/god = god_type[string_choice]

	if(patron.type == god.type && !mono_first_pick)
		to_chat(src, "<font color='yellow'>I'm already blessed by that [patron.name].</font>")
		return

	if(mono_first_pick)
		for(var/obj/effect/proc_holder/spell/S in src.devotion.granted_spells)
			src.mind.RemoveSpell(S)
	if(mono_first_pick)
		//devotion.granted_spells.Cut()
		var/datum/devotion/patrondev = new /datum/devotion(src, god)
		patron = god
		patrondev.grant_miracles(src, cleric_tier = CLERIC_T4, passive_gain = CLERIC_REGEN_MAJOR, devotion_limit = CLERIC_REQ_4)
		if(!mind.has_spell(/obj/effect/proc_holder/spell/invoked/revive))
			mind.AddSpell(/obj/effect/proc_holder/spell/invoked/revive)
	else
		// Define whitelist of swapable spells (T0-T2 only)
		var/list/whitelist = list(
			// Astrata
			/obj/effect/proc_holder/spell/targeted/touch/orison,
			/obj/effect/proc_holder/spell/invoked/ignition,
			/obj/effect/proc_holder/spell/self/astrata_gaze,
			/obj/effect/proc_holder/spell/invoked/lesser_heal,
			/obj/effect/proc_holder/spell/invoked/blood_heal,
			/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt/sacred_flame_rogue,
			/obj/effect/proc_holder/spell/invoked/heal,
			// Noc
			/obj/effect/proc_holder/spell/invoked/noc_sight,
			/obj/effect/proc_holder/spell/targeted/touch/darkvision/miracle,
			/obj/effect/proc_holder/spell/invoked/invisibility/miracle,
			// Dendor
			/obj/effect/proc_holder/spell/invoked/spiderspeak,
			/obj/effect/proc_holder/spell/targeted/wildshape,
			// Abyssor
			/obj/effect/proc_holder/spell/self/abyssor_wind,
			/obj/effect/proc_holder/spell/invoked/abyssor_bends,
			/obj/effect/proc_holder/spell/invoked/abyssor_undertow,
			/obj/effect/proc_holder/spell/invoked/abyssheal,
			// Ravox
			/obj/effect/proc_holder/spell/invoked/tug_of_war,
			/obj/effect/proc_holder/spell/self/divine_strike,
			/obj/effect/proc_holder/spell/self/call_to_arms,
			/obj/effect/proc_holder/spell/invoked/challenge,
			// Necra
			/obj/effect/proc_holder/spell/invoked/necras_sight,
			/obj/effect/proc_holder/spell/invoked/avert,
			/obj/effect/proc_holder/spell/invoked/deaths_door,
			/obj/effect/proc_holder/spell/invoked/raise_spirits_vengeance,
			// Xylix
			/obj/effect/proc_holder/spell/self/xylixslip,
			/obj/effect/proc_holder/spell/invoked/mockery,
			/obj/effect/proc_holder/spell/invoked/mastersillusion,
			// Pestra
			/obj/effect/proc_holder/spell/invoked/diagnose,
			/obj/effect/proc_holder/spell/invoked/pestra_leech,
			/obj/effect/proc_holder/spell/invoked/heal,
			/obj/effect/proc_holder/spell/invoked/infestation,
			/obj/effect/proc_holder/spell/invoked/attach_bodypart,
			// Malum
			/obj/effect/proc_holder/spell/invoked/malum_flame_rogue,
			/obj/effect/proc_holder/spell/invoked/conjure_tool,
			/obj/effect/proc_holder/spell/invoked/vigorousexchange,
			/obj/effect/proc_holder/spell/invoked/heatmetal,
			// Eora
			/obj/effect/proc_holder/spell/invoked/eora_blessing,
			/obj/effect/proc_holder/spell/invoked/bud,
			/obj/effect/proc_holder/spell/invoked/heartweave
		)
		for(var/obj/effect/proc_holder/spell/S in mind.spell_list)
			if(S.type in whitelist)
				mind.RemoveSpell(S)
		
		for(var/spell_type in god.miracles)
			if(god.miracles[spell_type] <= CLERIC_T4 && (spell_type in whitelist))
				var/obj/effect/proc_holder/spell/new_spell = new spell_type
				mind.AddSpell(new_spell)

		var/list/base_spells = list(
			/obj/effect/proc_holder/spell/invoked/revive,
			/obj/effect/proc_holder/spell/invoked/immolation
		)
		for(var/type in base_spells)
			if(!mind.has_spell(type))
				mind.AddSpell(new type)

	src.devotion.devotion *= 0.4

	// Special messages
	if(string_choice == "Astrata")
		to_chat(src, "<font color='yellow'>HEAVEN SHALL THEE RECOMPENSE. THOU BEARS MYNE POWER ONCE MORE.</font>")
	else
		to_chat(src, "<font color='yellow'>Thou wieldeth now the power of [string_choice].</font>")

	to_chat(src, "<font color='yellow'>The strain of changing your miracles has consumed all your devotion.</font>")

	COOLDOWN_START(src, priest_change_miracles, PRIEST_SWAP_COOLDOWN)

/mob/living/carbon/human/proc/coronate_lord()
	set name = "Coronate"
	set category = "Priest"
	if(!mind)
		return
	if(world.time < 30 MINUTES)
		to_chat(src, span_warning("It is a bad omen to coronate so early in the week."))
		return FALSE
	if(!istype(get_area(src), /area/rogue/indoors/town/church/chapel))
		to_chat(src, span_warning("I need to do this in the chapel."))
		return FALSE
	for(var/mob/living/carbon/human/HU in get_step(src, src.dir))
		if(!HU.mind)
			continue
		if(HU.mind.assigned_role == "Grand Duke")
			continue
		if(!HU.head)
			continue
		if(!istype(HU.head, /obj/item/clothing/head/roguetown/crown/serpcrown))
			continue

		//Abdicate previous King
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.mind)
				if(HL.mind.assigned_role == "Grand Duke")
					HL.mind.assigned_role = "Towner" //So they don't get the innate traits of the king
			//would be better to change their title directly, but that's not possible since the title comes from the job datum
			if(HL.job == "Grand Duke")
				HL.job = "Duke Emeritus"

		//Coronate new King (or Queen)
		HU.mind.assigned_role = "Grand Duke"
		HU.job = "Grand Duke"
		SSticker.set_ruler_mob(HU)
		SSticker.regentmob = null
		var/dispjob = mind.assigned_role
		removeomen(OMEN_NOLORD)
		say("By the authority of the gods, I pronounce you Ruler of all Azuria!")
		priority_announce("[real_name] the [dispjob] has named [HU.real_name] the inheritor of AZURE PEAK!", title = "Long Live [HU.real_name]!", sound = 'sound/misc/bell.ogg')
		var/datum/job/roguetown/nomoredukes = SSjob.GetJob("Grand Duke")
		if(nomoredukes)
			nomoredukes.total_positions = -1000 //We got what we got now.

/mob/living/carbon/human/proc/churchannouncement()
	set name = "Announcement"
	set category = "Priest"

	if(stat)
		return

	if (!istype(get_area(src), /area/rogue/indoors/town/church/chapel))
		to_chat(src, span_warning("I need to do this in the chapel."))
		return FALSE

	var/announcementinput = input("Bellow to the Peaks", "Make an Announcement") as text|null
	if(announcementinput)
		if(!src.can_speak_vocal())
			to_chat(src,span_warning("I can't speak!"))
			return FALSE
		if (!COOLDOWN_FINISHED(src, priest_announcement))
			to_chat(src, span_warning("You must wait before speaking again."))
			return
		visible_message(span_warning("[src] takes a deep breath, preparing to make an announcement.."))
		if(do_after(src, 15 SECONDS, target = src)) // Reduced to 15 seconds from 30 on the original Herald PR. 15 is well enough time for sm1 to shove you.
			say(announcementinput)
			priority_announce("[announcementinput]", "The Bishop Preaches", 'sound/misc/bell.ogg', sender = src)
			COOLDOWN_START(src, priest_announcement, PRIEST_ANNOUNCEMENT_COOLDOWN)
		else
			to_chat(src, span_warning("Your announcement was interrupted!"))
			return FALSE

/obj/effect/proc_holder/spell/self/convertrole/templar
	name = "Recruit Templar"
	new_role = "Templar"
	overlay_state = "recruit_templar"
	recruitment_faction = "Templars"
	recruitment_message = "Serve the ten, %RECRUIT!"
	accept_message = "FOR THE TEN!"
	refuse_message = "I refuse."

/obj/effect/proc_holder/spell/self/convertrole/monk
	name = "Recruit Acolyte"
	new_role = "Acolyte"
	overlay_state = "recruit_acolyte"
	recruitment_faction = "Church"
	recruitment_message = "Serve the ten, %RECRUIT!"
	accept_message = "FOR THE TEN!"
	refuse_message = "I refuse."

/mob/living/carbon/human/proc/completesermon()
	set name = "Sermon"
	set category = "Priest"

	if (!mind)
		return

	if (!istype(get_area(src), /area/rogue/indoors/town/church/chapel))
		to_chat(src, span_warning("I need to do this in the chapel."))
		return FALSE

	if (!COOLDOWN_FINISHED(src, priest_sermon))
		to_chat(src, span_warning("You cannot inspire others so early."))
		return

	src.visible_message(span_notice("[src] begins preaching a sermon..."))

	if (!do_after(src, 120, target = src)) // 120 seconds
		src.visible_message(span_warning("[src] stops preaching."))
		return

	src.visible_message(span_notice("[src] finishes the sermon, inspiring those nearby!"))
	playsound(src.loc, 'sound/magic/bless.ogg', 80, TRUE)
	COOLDOWN_START(src, priest_sermon, PRIEST_SERMON_COOLDOWN)

	for (var/mob/living/carbon/human/H in view(7, src))
		if (!H.patron)
			continue

		if (istype(H.patron, /datum/patron/divine))
			H.apply_status_effect(/datum/status_effect/buff/sermon)
			H.add_stress(/datum/stressevent/sermon)
			to_chat(H, span_notice("You feel a divine affirmation from your patron."))

		else if (istype(H.patron, /datum/patron/inhumen))
			H.apply_status_effect(/datum/status_effect/debuff/hereticsermon)
			H.add_stress(/datum/stressevent/heretic_on_sermon)
			to_chat(H, span_warning("Your patron seethes with disapproval."))

		else
			// Other patrons - fluff only
			to_chat(H, span_notice("Nothing seems to happen to you."))

	return TRUE

/mob/living/carbon/human/proc/churchecancurse(var/mob/living/carbon/human/H, apostasy = FALSE)
	if (!H.devotion && apostasy)
		to_chat(src, span_warning("This one's connection to the ten is too shallow."))
		return FALSE

	//Flavor messages for cursing certain god's faithful.
	//Dendor works in mysterious ways.
	if (istype(H.patron, /datum/patron/divine/dendor))
		to_chat(src, span_warning("The mad god Dendor is felt strongly. The wolf in this one balks and trashes as it is faintly restrained."))
		//If we check this here there's no need to apply this trait preemtively to a bunch of people, and allows for greater fluff feedback.
		ADD_TRAIT(H, TRAIT_CURSE_RESIST, TRAIT_GENERIC)

	//Abyssor's clergy are gripped by his dream.
	if (istype(H.patron, /datum/patron/divine/abyssor))
		to_chat(src, span_warning("The Dreamer, Abyssor has his clutches grasped firmly around this one. The light of the ten only barely penetrates the depths."))
		ADD_TRAIT(H, TRAIT_CURSE_RESIST, TRAIT_GENERIC)

	//Let's not curse heretical antags.
	if(HAS_TRAIT(H, TRAIT_HERESIARCH))
		to_chat(src, span_warning("The patron of this one shields them from being suppressed."))
		return FALSE

	return TRUE

/mob/living/carbon/human/proc/churcheapostasy(var/mob/living/carbon/human/H in GLOB.player_list)
	set name = "Apostasy"
	set category = "Priest"

	if (stat)
		return

	var/found = FALSE
	var/inputty = input("Put an apostasy on someone, removing their ability to use miracles... (apostasy them again to remove it)", "Sinner Name") as text|null

	if (!inputty)
		return

	if (!istype(get_area(src), /area/rogue/indoors/town/church/chapel))
		to_chat(src, span_warning("I need to do this from the House of the Ten."))
		return FALSE

	if(!src.key)
		return

	if(!src.mind || !src.mind.do_i_know(name=inputty))
		to_chat(src, span_warning("I don't know anyone by that name."))
		return

	if (inputty in GLOB.apostasy_players)
		GLOB.apostasy_players -= inputty
		priority_announce("[real_name] has forgiven [inputty]. Their patron hears their prayer once more!", title = "APOSTASY LIFTED", sound = 'sound/misc/bell.ogg')
		message_admins("APOSTASY: [real_name] ([ckey]) has used forgiven apostasy at [H.real_name] ([H.ckey])")
		log_game("APOSTASY: [real_name] ([ckey]) has used forgiven apostasy at [H.real_name] ([H.ckey])")

		if (H.real_name == inputty)
			if (istype(H.patron, /datum/patron/divine) && H.devotion)
				H.remove_status_effect(/datum/status_effect/debuff/apostasy)
				H.remove_stress(/datum/stressevent/apostasy)

		return TRUE

	if (H.real_name == inputty)
		if (!COOLDOWN_FINISHED(src, priest_apostasy))
			to_chat(src, span_warning("You must wait until you can mark another."))
			return

		//Check if we can curse this person.
		if(!churchecancurse(H))
			return

		found = TRUE
		GLOB.apostasy_players += inputty
		COOLDOWN_START(src, priest_apostasy, PRIEST_APOSTASY_COOLDOWN)

		var/curse_resist = HAS_TRAIT(H, TRAIT_CURSE_RESIST)

		if (istype(H.patron, /datum/patron/divine))
			H.apply_status_effect(/datum/status_effect/debuff/apostasy, curse_resist)
			H.add_stress(/datum/stressevent/apostasy)
			to_chat(H, span_warning("A holy silence falls upon you. Your Patron cannot hear you anymore..."))
		else
			to_chat(H, span_warning("A holy silence falls upon you..."))

		priority_announce("[real_name] has placed mark of shame upon [inputty]. Their prayers fall on deaf ears.", title = "APOSTASY", sound = 'sound/misc/excomm.ogg')
		message_admins("APOSTASY: [real_name] ([ckey]) has used apostasy at [H.real_name] ([H.ckey])")
		log_game("APOSTASY: [real_name] ([ckey]) has used apostasy at [H.real_name] ([H.ckey])")
		return TRUE

	if (!found)
		return FALSE

	return

/mob/living/carbon/human/proc/churchexcommunicate(var/mob/living/carbon/human/H in GLOB.player_list)
	set name = "Excommunicate"
	set category = "Priest"

	if (stat)
		return

	var/found = FALSE
	var/inputty = input("Excommunicate someone, away from the Ten...  (excommunicate them again to remove it)", "Sinner Name") as text|null

	if (!inputty)
		return

	if (!istype(get_area(src), /area/rogue/indoors/town/church/chapel))
		to_chat(src, span_warning("I need to do this from the House of the Ten."))
		return FALSE

	if(!src.key)
		return

	if(!src.mind || !src.mind.do_i_know(name=inputty))
		to_chat(src, span_warning("I don't know anyone by that name."))
		return

	if (inputty in GLOB.excommunicated_players)
		GLOB.excommunicated_players -= inputty
		priority_announce("[real_name] has reconciled [inputty] with the Church. They are once again part of the flock!", title = "RECONCILIATION", sound = 'sound/misc/bell.ogg')
		message_admins("EXCOMMUNICATION: [real_name] ([ckey]) has reconciled [H.real_name] ([H.ckey])")
		log_game("EXCOMMUNICATION: [real_name] ([ckey]) has reconciled [H.real_name] ([H.ckey])")

		if (H.real_name == inputty)
			REMOVE_TRAIT(H, TRAIT_EXCOMMUNICATED, TRAIT_GENERIC)

			if (H.patron)
				if (istype(H.patron, /datum/patron/divine))
					H.remove_stress(/datum/stressevent/excommunicated)
					H.remove_status_effect(/datum/status_effect/debuff/excomm)
					to_chat(H, span_warning("No longer a rotten husk, you walk again in their light."))
				else
					return
		return

	if (H.real_name == inputty)
		if (!COOLDOWN_FINISHED(src, priest_excommunicate))
			to_chat(src, span_warning("You must wait until you can excommunicate another."))
			return // Anybody can still be excommunicated, so no extra checks here since it's purely RP and not mechanical.
		found = TRUE
		ADD_TRAIT(H, TRAIT_EXCOMMUNICATED, TRAIT_GENERIC)
		COOLDOWN_START(src, priest_excommunicate, PRIEST_EXCOMMUNICATION_COOLDOWN)

		if (H.patron)
			if (istype(H.patron, /datum/patron/divine))
				H.add_stress(/datum/stressevent/excommunicated)
				H.apply_status_effect(/datum/status_effect/debuff/excomm)
				to_chat(H, span_warning("Your divine light has been severed. Gods turn their backs to you."))
			else
				return

		if (!found)
			return FALSE

	GLOB.excommunicated_players += inputty
	priority_announce("[real_name] has excommunicated [inputty]! SHAME!", title = "EXCOMMUNICATION", sound = 'sound/misc/excomm.ogg')
	message_admins("EXCOMMUNICATION: [real_name] ([ckey]) has excommunicated [H.real_name] ([H.ckey])")
	log_game("EXCOMMUNICATION: [real_name] ([ckey]) has excommunicated [H.real_name] ([H.ckey])")

	return

/* PRIEST CURSE - powerful debuffs to punish ppl outside church otherwise use apostasy
code\modules\admin\verbs\divinewrath.dm has a variant with all the gods so keep that updated if this gets any changes.*/
/mob/living/carbon/human/proc/churchpriestcurse(var/mob/living/carbon/human/H in GLOB.player_list)
	set name = "Divine Curse"
	set category = "Priest"

	if (stat)
		return

	var/target_name = input("Who shall receive a curse?", "Target Name") as text|null

	if (!target_name)
		return

	if (!istype(get_area(src), /area/rogue/indoors/town/church/chapel))
		to_chat(src, span_warning("I need to do this from the House of the Ten."))
		return FALSE

	if(!src.key)
		return

	if(!src.mind || !src.mind.do_i_know(name=target_name))
		to_chat(src, span_warning("I don't know anyone by that name."))
		return

	var/list/curse_choices = list(
		"Curse of Astrata" = /datum/curse/astrata,
		"Curse of Noc" = /datum/curse/noc,
		"Curse of Ravox" = /datum/curse/ravox,
		"Curse of Necra" = /datum/curse/necra,
		"Curse of Xylix" = /datum/curse/xylix,
		)

	var/curse_pick = input("Choose a curse to apply or lift.", "Select Curse") as null|anything in curse_choices
	if (!curse_pick)
		return

	var/curse_type = curse_choices[curse_pick]

	if (H.real_name == target_name)
		var/datum/curse/temp = new curse_type()

		if (H.is_cursed(temp))
			H.remove_curse(temp)
			priority_announce("[real_name] has lifted [curse_pick] from [H.real_name]! They are once again part of the flock!", title = "REDEMPTION", sound = 'sound/misc/bell.ogg')
			message_admins("DIVINE CURSE: [real_name] ([ckey]) has removed [curse_pick] from [H.real_name]) ") //[ADMIN_LOOKUPFLW(user)] Maybe add this here if desirable but dunno.
			log_game("DIVINE CURSE: [real_name] ([ckey]) has removed [curse_pick] from [H.real_name])")
		else
			if (length(H.curses) >= 1)
				to_chat(src, span_syndradio("[H.real_name] is already afflicted by another curse."))
				message_admins("DIVINE CURSE: [real_name] ([ckey]) has attempted to strike [H.real_name] ([H.ckey] with [curse_pick])")
				log_game("DIVINE CURSE: [real_name] ([ckey]) has attempted to strike [H.real_name] ([H.ckey] with [curse_pick])")
				return

			if (!COOLDOWN_FINISHED(src, priest_curse))
				to_chat(src, span_warning("You must wait before invoking a curse again."))
				return

			//Check if we can curse this person.
			if(!churchecancurse(H))
				return

			COOLDOWN_START(src, priest_curse, PRIEST_CURSE_COOLDOWN)
			H.add_curse(curse_type)
			
			priority_announce("[real_name] has stricken [H.real_name] with [curse_pick]! SHAME!", title = "JUDGEMENT", sound = 'sound/misc/excomm.ogg')
			message_admins("DIVINE CURSE: [real_name] ([ckey]) has stricken [H.real_name] ([H.ckey] with [curse_pick])")
			log_game("DIVINE CURSE: [real_name] ([ckey]) has stricken [H.real_name] ([H.ckey] with [curse_pick])")

		return

/obj/effect/proc_holder/spell/invoked/convert_heretic_priest
	name = "Absolve the Heretic"
	desc = "Convert a heretic back to the fold of the church. Requires the heretic to be willing, and takes a long time to cast."
	invocations = list("Show this lost sheep the way back to the flock.")
	invocation_type = "whisper"
	sound = 'sound/magic/bless.ogg'
	devotion_cost = 100
	recharge_time = 20 MINUTES
	chargetime = 10 SECONDS
	associated_skill = /datum/skill/magic/holy
	overlay_state = "convert_heretic"

/obj/effect/proc_holder/spell/invoked/convert_heretic_priest/cast(list/targets, mob/living/carbon/human/user)
	var/mob/living/carbon/human/target = targets[1]

	if(!ishuman(target))
		revert_cast()
		return FALSE

	if(!HAS_TRAIT(target, TRAIT_HERESIARCH))
		to_chat(user, span_warning("[target] wasn't marked by the enemy as a heretic!"))
		revert_cast()
		return FALSE

	if(alert(target, "[user.real_name] is trying to convert you back to the church. Do you accept?", "Conversion Request", "Yes", "No") != "Yes")
		to_chat(user, span_warning("[target] refused your offer of conversion."))
		revert_cast()
		return FALSE

	// Remove from excommunication lists
	if(target.real_name in GLOB.excommunicated_players)
		GLOB.excommunicated_players -= target.real_name

	// Remove heretic traits
	REMOVE_TRAIT(target, TRAIT_HERESIARCH, TRAIT_GENERIC)
	REMOVE_TRAIT(target, TRAIT_EXCOMMUNICATED, TRAIT_GENERIC)

	// Remove divine punishments
	target.remove_status_effect(/datum/status_effect/debuff/excomm)
	target.remove_stress(/datum/stressevent/excommunicated)

	// Save devotion state
	var/saved_level = CLERIC_T0
	var/saved_max_progression = CLERIC_T1
	var/saved_devotion_gain = CLERIC_REGEN_MINOR

	if(target.devotion)
		saved_level = target.devotion.level
		saved_devotion_gain = target.devotion.passive_devotion_gain
		saved_max_progression = target.devotion.max_progression

		// Remove all granted spells
		for(var/obj/effect/proc_holder/spell/S in target.devotion.granted_spells)
			target.mind.RemoveSpell(S)

		target.devotion.Destroy()

	// Convert to priest's patron
	target.patron = new user.patron.type()

	// Grant new devotion
	var/datum/devotion/new_devotion = new /datum/devotion(target, target.patron)
	target.devotion = new_devotion
	new_devotion.grant_miracles(target, saved_level, saved_devotion_gain, saved_max_progression)

	// Apply revival debuff as a small cost to conversion in addition to the cooldown
	user.apply_status_effect(/datum/status_effect/debuff/devitalised)
	target.apply_status_effect(/datum/status_effect/debuff/devitalised)

	var/announcement_text = "[user.real_name] has brought [target.real_name] back into the fold of the church! [target.real_name] now follows [user.patron.name]!"
	priority_announce(announcement_text, title = "REDEMPTION", sound = 'sound/misc/bell.ogg')
	message_admins("HERETIC CONVERSION: [user.real_name] ([user.ckey]) has converted [target.real_name] ([target.ckey]) to [user.patron.name]")
	log_game("HERETIC CONVERSION: [user.real_name] ([user.ckey]) converted [target.real_name] ([target.ckey]) to [user.patron.name]")
	to_chat(user, span_danger("You've converted [target.name] to follow [user.patron.name]!"))
	to_chat(target, span_danger("You feel the weight of heresy lift from your soul as you embrace [user.patron.name]!"))

	return TRUE
