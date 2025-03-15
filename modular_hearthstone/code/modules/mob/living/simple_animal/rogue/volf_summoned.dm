/mob/living/simple_animal/hostile/retaliate/summoned_volf
    name = "summoned volf"
    desc = "A mystically summoned volf that seems protective of its master."
    icon = 'icons/roguetown/mob/monster/vol.dmi'
    icon_state = "vv"
    icon_living = "vv"
    icon_dead = "vvd"
    
    // Base stats (copied from wolf)
    health = WOLF_HEALTH
    maxHealth = WOLF_HEALTH
    melee_damage_lower = 19
    melee_damage_upper = 29
    obj_damage = 35
    environment_smash = ENVIRONMENT_SMASH_STRUCTURES
    
    // Movement and combat
    move_to_delay = 2
    retreat_distance = 0
    minimum_distance = 1
    pass_flags = PASSTABLE
    move_resist = MOVE_FORCE_STRONG
    attack_sound = list('sound/vo/mobs/vw/attack (1).ogg','sound/vo/mobs/vw/attack (2).ogg','sound/vo/mobs/vw/attack (3).ogg','sound/vo/mobs/vw/attack (4).ogg')
    attack_verb_continuous = "bites"
    attack_verb_simple = "bite"
    footstep_type = FOOTSTEP_MOB_CLAW
    
    // Make it passive by default
    aggressive = FALSE
    attack_same = TRUE  // Allow attacking other volfs if they hurt the master
    AIStatus = AI_OFF
    can_have_ai = FALSE // Prevent AI from being turned on automatically
    search_objects = 0  // Don't search for weapons/items
    
    // Behavior control
    var/was_attacked = FALSE
    
    // Prevent corpse/gibbing
    del_on_death = TRUE
    loot = list() // No loot drops
    remains_type = null // No remains
    butcher_results = null // Can't be butchered

/mob/living/simple_animal/hostile/retaliate/summoned_volf/Initialize()
    . = ..()
    toggle_ai(AI_OFF)  // Ensure AI starts off
    LoseTarget()       // Clear any initial targets

// Only retaliate if attacked or master is attacked
/mob/living/simple_animal/hostile/retaliate/summoned_volf/Retaliate()
    if(!was_attacked && !enemies.len)
        return FALSE
    toggle_ai(AI_ON)  // Only turn AI on when actually retaliating
    vision_range = aggro_vision_range  // Increase vision when aggressive
    return ..()

/mob/living/simple_animal/hostile/retaliate/summoned_volf/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
    . = ..()
    if(. > 0 && stat == CONSCIOUS)
        was_attacked = TRUE
        Retaliate()  // Let our overridden Retaliate() handle the AI toggle

/mob/living/simple_animal/hostile/retaliate/summoned_volf/ListTargets()
    if(!was_attacked && !enemies.len)
        return list()  // Return empty list if not attacked and no enemies
    return ..()

// Passive AI management
/mob/living/simple_animal/hostile/retaliate/summoned_volf/Life()
    if(stat)
        return ..()  // Skip AI processing if dead/unconscious
    if(!was_attacked && !enemies.len)
        toggle_ai(AI_OFF)  // Keep AI off if not provoked
        vision_range = initial(vision_range)  // Reset vision range when passive
    ..()

// Prevent unwanted aggro
/mob/living/simple_animal/hostile/retaliate/summoned_volf/attack_hand(mob/living/carbon/human/M)
    if(!was_attacked && !enemies.len)
        return ..()  // Only allow combat interactions if already aggressive
    return ..()

/mob/living/simple_animal/hostile/retaliate/summoned_volf/attack_paw(mob/living/carbon/monkey/M)
    if(!was_attacked)
        return ..()
    return ..()

/mob/living/simple_animal/hostile/retaliate/summoned_volf/attack_animal(mob/living/simple_animal/M)
    if(!was_attacked)
        return ..()
    return ..()

/mob/living/simple_animal/hostile/retaliate/summoned_volf/AttackingTarget()
    if(!was_attacked && !enemies.len)
        LoseTarget()
        return
    return ..() 

/mob/living/simple_animal/hostile/retaliate/summoned_volf/death(gibbed)
    visible_message(span_notice("[src] fades away into mist..."))
    ..() // This will trigger the del_on_death
