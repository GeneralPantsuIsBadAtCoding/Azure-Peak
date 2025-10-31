/obj/effect/proc_holder/spell/invoked/deadland
	name = "Dead Land"
	overlay_state = "rune2"
	desc = "Mass antimagic"
	cost = 6
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 10 SECONDS
	recharge_time = 2 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	spell_tier = 3
	invocations = list("Perstare Sicut Saxum.")
	invocation_type = "whisper"
	glow_color = GLOW_COLOR_BUFF
	glow_intensity = GLOW_INTENSITY_LOW
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	var/distance = 1
	var/effect_time = 1

#define FILTER_COUNTERSPELL "counterspell_glow"

/obj/effect/proc_holder/spell/invoked/deadland/cast(list/targets, mob/user = usr)
	var/user_skill = user.get_skill_level(associated_skill)
	distance = 1+user_skill*2
	effect_time = user_skill/2 MINUTES
	for(var/mob/living/L in range(distance))
		if(HAS_TRAIT(L, TRAIT_COUNTERCOUNTERSPELL))
			to_chat(user, "<span class='warning'>They've counterspelled my counterspell immediately! It's not going to work on them!</span>")
			revert_cast()
			return
		playsound(get_turf(L), 'sound/magic/zizo_snuff.ogg', 80, TRUE, soundping = TRUE)
		ADD_TRAIT(L, TRAIT_SPELLCOCKBLOCK, MAGIC_TRAIT)
		ADD_TRAIT(L, TRAIT_ANTIMAGIC, MAGIC_TRAIT)
		L.add_filter(FILTER_COUNTERSPELL, 2, list("type" = "outline", "color" = "#FFFFFF", "alpha" = 30, "size" = 1))
		to_chat(L, span_warning("I feel as if my connection to the Arcyne disappears entirely. The air feels still..."))
		L.visible_message("[L]'s arcyne aura seems to fade.")
		addtimer(CALLBACK(src, PROC_REF(remove_buff), L), wait = effect_time)
		return TRUE

/obj/effect/proc_holder/spell/invoked/deadland/proc/remove_buff(mob/living/carbon/L)
	REMOVE_TRAIT(L, TRAIT_SPELLCOCKBLOCK, MAGIC_TRAIT)
	REMOVE_TRAIT(L, TRAIT_ANTIMAGIC, MAGIC_TRAIT)
	L.remove_filter(FILTER_COUNTERSPELL)
	to_chat(L, span_warning("I feel my connection to the arcyne surround me once more."))
	L.visible_message("[L]'s arcyne aura seems to return once more.")

#undef FILTER_COUNTERSPELL