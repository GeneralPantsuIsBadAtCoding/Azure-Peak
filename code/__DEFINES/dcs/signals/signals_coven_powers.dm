//Normal signals sent to the power and caster, _ON signals are sent to target

//can_activate() signals
///from datum/coven_power/can_activate(): (datum/coven_power/power, atom/target)
#define COMSIG_POWER_TRY_ACTIVATE "power_try_activate"
///from datum/coven_power/can_activate(): (datum/coven_power/power)
#define COMSIG_POWER_TRY_ACTIVATE_ON "power_try_activate_on"
	///Makes can_activate return false and prevent activation
	#define POWER_PREVENT_ACTIVATE (1<<0)

//pre_activation() signals
///from datum/coven_power/pre_activation(): (datum/coven_power/power, atom/target)
#define COMSIG_POWER_PRE_ACTIVATION "power_pre_activation"
///from datum/coven_power/pre_activation(): (datum/coven_power/power)
#define COMSIG_POWER_PRE_ACTIVATION_ON "power_pre_activation_on"
	///Cancels activation after it's been initiated but before its effects take hold
	#define POWER_CANCEL_ACTIVATION (1<<0)

//activate() signals
///from datum/coven_power/activate(): (datum/coven_power/power, atom/target)
#define COMSIG_POWER_ACTIVATE "power_activate"
///from datum/coven_power/activate(): (datum/coven_power/power)
#define COMSIG_POWER_ACTIVATE_ON "power_activate_on"

//can_deactivate() signals
///from datum/coven_power/can_deactivate(): (datum/coven_power/power, atom/target)
#define COMSIG_POWER_TRY_DEACTIVATE "power_try_deactivate"
///from datum/coven_power/can_deactivate(): (datum/coven_power/power)
#define COMSIG_POWER_TRY_DEACTIVATE_ON "power_try_deactivate_on"
	///Makes can_deactivate return false and prevent deactivation
	#define POWER_PREVENT_DEACTIVATE (1<<0)

//deactivate() signals
///from datum/coven_power/deactivate(): (atom/target)
#define COMSIG_POWER_DEACTIVATE "power_deactivate"
///from datum/coven_power/deactivate()
#define COMSIG_POWER_DEACTIVATE_ON "power_deactivate_on"
