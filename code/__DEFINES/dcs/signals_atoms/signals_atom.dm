///from base of atom/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
#define COMSIG_ATOM_HITBY "atom_hitby"
///from base of atom/attackby(): (/obj/item, /mob/living, params)
#define COMSIG_ATOM_ATTACKBY "atom_attackby"
///from base of atom/examine(): (/mob, list/examine_text)
#define COMSIG_ATOM_EXAMINE "atom_examine"
///from base of atom/examine_tags(): (/mob, list/examine_tags)
#define COMSIG_ATOM_EXAMINE_TAGS "atom_examine_tags"
///from base of atom/examine_more(): (/mob, examine_list)
#define COMSIG_ATOM_EXAMINE_MORE "atom_examine_more"

#define COMSIG_LOCKPICK_ONMOUSEDOWN "lockpick_onmousedown"
	#define COMPONENT_LOCKPICK_ONMOUSEDOWN_BYPASS (1<<0)

#define COMPONENT_PICKED "picked"

//from base of client/MouseDown(): (/client, object, location, control, params)
#define COMSIG_CLIENT_MOUSEDOWN "client_mousedown"
//from base of client/MouseUp(): (/client, object, location, control, params)
#define COMSIG_CLIENT_MOUSEUP "client_mouseup"
	#define COMPONENT_CLIENT_MOUSEUP_INTERCEPT (1<<0)
