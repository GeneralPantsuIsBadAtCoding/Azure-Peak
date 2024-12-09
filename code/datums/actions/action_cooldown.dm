
	

//Preset for an action with a cooldown
/datum/action/cooldown
	check_flags = NONE

	transparent_when_unavailable = FALSE
	/// The default cooldown applied when StartCooldown() is called
	var/cooldown_time = 0
	/// The actual next time this ability can be used
	var/next_use_time = 0
	/// List of prerequisite actions that have been initialized
	var/list/initialized_actions
	/// List of prerequisite actions that are used in this sequenced ability, you cannot put other sequenced abilities in this
	var/list/sequence_actions

	/// The stat panel this action shows up in the stat panel in. If null, will not show up.
	var/panel

	/// The default melee cooldown applied after the ability ends. If set to null, copies cooldown_time.
	var/melee_cooldown_time = 0
	/// The actual next time the owner of this action can melee
	var/next_melee_use_time = 0
	/// Whether or not you want the cooldown for the ability to display in text form
	var/text_cooldown = TRUE
	/// Significant figures to round cooldown to
	var/cooldown_rounding = 0.1
	/// Shares cooldowns with other abiliies, bitflag
	var/shared_cooldown = NONE

/datum/action/cooldown/New()
	..()
	button.maptext = ""
	button.maptext_x = 8
	button.maptext_y = 0
	button.maptext_width = 24
	button.maptext_height = 12

/datum/action/cooldown/IsAvailable(feedback = FALSE)
	return ..() && (next_use_time <= world.time)

/datum/action/cooldown/proc/StartCooldown()
	next_use_time = world.time + cooldown_time
	button.maptext = "<b>[round(cooldown_time/10, 0.1)]</b>"
	//UpdateButtonIcon()
	START_PROCESSING(SSfastprocess, src)

/datum/action/cooldown/process()
	if(!owner)
		button.maptext = ""
		STOP_PROCESSING(SSfastprocess, src)
	var/timeleft = max(next_use_time - world.time, 0)
	if(timeleft == 0)
		button.maptext = ""
		UpdateButtonIcon()
		STOP_PROCESSING(SSfastprocess, src)
	else
		button.maptext = "<b>[round(timeleft/10, 0.1)]</b>"

/datum/action/cooldown/Grant(mob/M)
	..()
	if(owner)
		//UpdateButtonIcon()
		if(next_use_time > world.time)
			START_PROCESSING(SSfastprocess, src)

/// Resets the cooldown of this ability
/datum/action/cooldown/proc/ResetCooldown()
	next_use_time = world.time
//	build_all_button_icons(UPDATE_BUTTON_STATUS)

/// Re-enables this cooldown action
/datum/action/cooldown/proc/enable()
	action_disabled = FALSE
//	build_all_button_icons(UPDATE_BUTTON_STATUS)

/// Disables this cooldown action
/datum/action/cooldown/proc/disable()
	action_disabled = TRUE
//	build_all_button_icons(UPDATE_BUTTON_STATUS)

/// Re-enables all cooldown actions
/datum/action/cooldown/proc/enable_cooldown_actions()
	for(var/datum/action/cooldown/cd_action in owner.actions)
		cd_action.enable()

/// Disables all cooldown actions
/datum/action/cooldown/proc/disable_cooldown_actions()
	for(var/datum/action/cooldown/cd_action in owner.actions)
		cd_action.disable()

/datum/action/cooldown/Grant(mob/granted_to)
	. = ..()
	if(!owner)
		return
	//build_all_button_icons()
	if(next_use_time > world.time)
		START_PROCESSING(SSfastprocess, src)
	//RegisterSignal(granted_to, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, PROC_REF(handle_melee_attack))
	for(var/datum/action/cooldown/ability as anything in initialized_actions)
		ability.Grant(granted_to)

/datum/action/cooldown/Remove(mob/removed_from)
	//``UnregisterSignal(removed_from, COMSIG_HOSTILE_PRE_ATTACKINGTARGET)
	/*if(click_to_activate && removed_from.click_intercept == src)
		unset_click_ability(removed_from, refund_cooldown = FALSE)*/
	for(var/datum/action/cooldown/ability as anything in initialized_actions)
		ability.Remove(removed_from)
	return ..()

/datum/action/cooldown/Destroy()
	QDEL_LIST(initialized_actions)
	return ..()


/// To be implemented by subtypes 
/datum/action/cooldown/proc/Activate(atom/target)
	var/total_delay = 0
	for(var/datum/action/cooldown/ability as anything in initialized_actions)
		if(LAZYLEN(ability.initialized_actions) > 0)
			ability.initialized_actions = list()
		addtimer(CALLBACK(ability, PROC_REF(Activate), target), total_delay)
		total_delay += initialized_actions[ability]
	StartCooldown()

/// Initializes any sequence actions
/datum/action/cooldown/proc/create_sequence_actions()
	if(!LAZYLEN(sequence_actions))
		return
	// remove existing actions if any
	QDEL_LIST(initialized_actions)
	initialized_actions = list()
	for(var/type_path in sequence_actions)
		var/datum/action/cooldown/ability = new type_path(target, original = FALSE)
		// prevents clients from using the individual abilities in sequences (this stops it from being added to mob actions when granted as well)
		ability.owner_has_control = FALSE
		// [ability] = delay
		initialized_actions[ability] = sequence_actions[type_path]

/datum/action/cooldown/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!owner)
		return FALSE

	var/mob/user = usr || owner

	
	if(target)
		return PreActivate(target)
	return PreActivate(user)

	// If our cooldown action is not a click_to_activate action:
	// We can just continue on and use the action
	// the target is the user of the action (often, the owner)

/// For signal calling
/datum/action/cooldown/proc/PreActivate(atom/target)
	if(SEND_SIGNAL(owner, COMSIG_MOB_ABILITY_STARTED, src, target)) //& COMPONENT_BLOCK_ABILITY_START)
		return
	// Note, that PreActivate handles no cooldowns at all by default.
	// Be sure to call StartCooldown() in Activate() where necessary.
	. = Activate(target)
	// There is a possibility our action (or owner) is qdeleted in Activate().
	if(!QDELETED(src) && !QDELETED(owner))
		SEND_SIGNAL(owner, COMSIG_MOB_ABILITY_FINISHED, src)

