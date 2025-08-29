#define BLESSING_NONE 0
#define BLESSING_PSYDONIAN 1
#define BLESSING_TENNITE 2
/// Tennite blessings are 30% worse. Cope.
#define TENNITE_BLESSING_DIVISOR 0.7

/datum/component/psyblessed
	var/is_blessed
	var/pre_blessed
	var/added_force
	var/added_blade_int
	var/added_int
	var/added_def
	var/silver

/datum/component/psyblessed/Initialize(blessing_type = BLESSING_NONE, force, blade_int, int, def, makesilver)
	if(!istype(parent, /obj/item/rogueweapon))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ITEM_OBJFIX, PROC_REF(on_fix))
	pre_blessed = blessing_type
	added_force = force
	added_blade_int = blade_int
	added_int = int
	added_def = def
	silver = makesilver
	if(pre_blessed)
		apply_bless(blessing_type)
		
/datum/component/psyblessed/proc/on_examine(datum/source, mob/user, list/examine_list)
	if(!is_blessed)
		examine_list += span_info("<font color = '#cfa446'>This object may be blessed by the lingering shard of COMET SYON. Until then, its impure alloying of silver-and-steel cannot blight inhumen foes on its own.</font>")
	if(is_blessed)
		examine_list += span_info("<font color = '#46bacf'>This object has been blessed by COMET SYON.</font>")
		if(silver)
			examine_list += span_info("It has been imbued with <b>silver</b>.")

/datum/component/psyblessed/proc/try_bless(blessing_type)
	if(!is_blessed)
		apply_bless(blessing_type)
		play_effects()
		return TRUE
	else
		return FALSE

/datum/component/psyblessed/proc/play_effects()
	if(isitem(parent))
		var/obj/item/I = parent
		playsound(I, 'sound/magic/holyshield.ogg', 100)
		I.visible_message(span_notice("[I] glistens with power as dust of COMET SYON lands upon it!"))

/datum/component/psyblessed/proc/apply_bless(blessing_type)
	var/blessing_divisor = 1
	if(blessing_type == BLESSING_TENNITE)
		blessing_divisor = TENNITE_BLESSING_DIVISOR
	if(isitem(parent))
		var/obj/item/I = parent
		is_blessed = TRUE
		I.force += added_force
		if(I.force_wielded)
			I.force_wielded += added_force
		if(I.max_blade_int)
			I.max_blade_int += round(added_blade_int * blessing_divisor)
			I.blade_int = round(I.max_blade_int * blessing_divisor)
		I.max_integrity += round(added_int * blessing_divisor)
		I.obj_integrity = round(I.max_integrity * blessing_divisor)
		I.wdefense += round(added_def * blessing_divisor)
		if(silver)
			I.is_silver = silver
			I.smeltresult = /obj/item/ingot/silver
		I.name = "blessed [I.name]"
		I.AddComponent(/datum/component/metal_glint)

// This is called right after the object is fixed and all of its force / wdefense values are reset to initial. We re-apply the relevant bonuses.
/datum/component/psyblessed/proc/on_fix()
	if(!is_blessed)
		return
	var/obj/item/rogueweapon/I = parent
	I.force += added_force
	if(I.force_wielded)
		I.force_wielded += added_force
	I.wdefense += round(added_def * (is_blessed == BLESSING_TENNITE ? TENNITE_BLESSING_DIVISOR : 1))
