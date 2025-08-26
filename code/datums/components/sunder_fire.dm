#define TTL_DECREASE_PER_RESIST 2
#define SUNDER_BURN_PER_LIFE 5
#define SUNDER_FILTER "sunder_filter"

/datum/component/sunder_fire
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	var/life_ttl = 0
	var/qdel_timer
	var/mob_light_obj

/datum/component/sunder_fire/Initialize(life_ttl)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	src.life_ttl = life_ttl

/datum/component/sunder_fire/InheritComponent(datum/component/sunder_fire/newcomp, original, list/arguments)
	life_ttl += arguments[1]
	deltimer(qdel_timer)

/datum/component/sunder_fire/RegisterWithParent()
	RegisterSignal(parent, COMSIG_LIVING_LIFE, PROC_REF(handle_life))
	var/mob/living/living_parent = parent
	var/filter = living_parent.get_filter(SUNDER_FILTER)
	if(!filter)
		living_parent.add_filter(SUNDER_FILTER, 2, list("type" = "outline", "color" = "#ffffff", "alpha" = 60, "size" = 1))
	mob_light_obj = living_parent.mob_light("#f5edda", 5, 5)

	living_parent.remove_overlay(SUNDER_LAYER)
	var/mutable_appearance/new_fire_overlay = mutable_appearance('icons/mob/OnFire.dmi', "sunder_burning", -SUNDER_LAYER)
	new_fire_overlay.appearance_flags = RESET_COLOR
	living_parent.overlays_standing[SUNDER_LAYER] = new_fire_overlay
	living_parent.apply_overlay(SUNDER_LAYER)

/datum/component/sunder_fire/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_LIVING_LIFE)
	var/mob/living/living_parent = parent
	living_parent.remove_filter(SUNDER_FILTER)
	living_parent.remove_overlay(SUNDER_LAYER)
	QDEL_NULL(mob_light_obj)

/datum/component/sunder_fire/proc/handle_life(seconds, times_fired)
	if(life_ttl <= 0)
		qdel(src)
		return

	life_ttl -= 1
	var/mob/living/living_parent = parent
	living_parent.adjust_bodytemperature(BODYTEMP_HEATING_MAX + 12)
	SEND_SIGNAL(parent, COMSIG_ADD_MOOD_EVENT, "on_fire", /datum/mood_event/on_fire)
	living_parent.throw_alert("temp", /atom/movable/screen/alert/hot, 3)
	living_parent.apply_damage(SUNDER_BURN_PER_LIFE, BURN, spread_damage = TRUE)

/datum/component/sunder_fire/proc/resist()
	life_ttl -= TTL_DECREASE_PER_RESIST

#undef TTL_DECREASE_PER_RESIST
#undef SUNDER_BURN_PER_LIFE
#undef SUNDER_FILTER
