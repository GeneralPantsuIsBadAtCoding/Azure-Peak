/* COMBAT DEFINES for NON ARMOR VALUES */

#define BASE_PARRY_STAMINA_DRAIN 5 // Unmodified stamina drain for parry, now a var instead of setting on simplemobs
#define BAD_GUARD_FATIGUE_DRAIN 20 //Percentage of your green bar lost on letting a guard expire.
#define GUARD_PEEL_REDUCTION 2	//How many Peel stacks to lose if a Guard is hit.
#define BAIT_PEEL_REDUCTION 1	//How many Peel stacks to lose if we perfectly bait.

/*
Medical defines
*/
#define ARTERY_LIMB_BLEEDRATE 20	//This is used as a reference point for dynamic wounds, so it's better off as a define.
#define CONSTITUTION_BLEEDRATE_MOD 0.1	//How much slower we'll be bleeding for every CON point. 0.1 = 10% slower.
#define CONSTITUTION_BLEEDRATE_CAP 15	//The CON value up to which we get a bleedrate reduction.

/*
 Misc. Category. Spin it out if needed
*/
#define CRIT_DISMEMBER_DAMAGE_THRESHOLD 0.9 // 90% damage threshold for dismemberment / crit
