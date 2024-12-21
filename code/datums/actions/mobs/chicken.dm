/datum/action/cooldown/mob_cooldown/lay_chicken_egg
	name = "Lay Egg"
	button_icon = 'icons/obj/magic.dmi'
	button_icon_state = "fireball"
	desc = "Lay a chicken egg..."
	cooldown_time = 30 SECONDS

	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')


/datum/action/cooldown/mob_cooldown/lay_chicken_egg/Activate(atom/target_atom)
	disable_cooldown_actions()

	var/list/layMessage = EGG_LAYING_MESSAGES

	production = max(production - 30, 0)
	var/obj/item/reagent_containers/food/snacks/egg/E = new egg_type(get_turf(src)) // lays the egg
	E.pixel_x = rand(-6,6)
	E.pixel_y = rand(-6,6)
	src.visible_message(span_alert("[src] [pick(layMessage)]"))
	if(chicken_count < MAX_CHICKENS && prob(50))
		E.fertile = TRUE
		
	StartCooldown()
	enable_cooldown_actions()
	return TRUE
