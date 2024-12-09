/obj/projectile/magic/aoe/dragon_breath
    name = "dragon's breath"
    icon_state = "fireball"
    damage = 40
    damage_type = BRUTE
    nodamage = FALSE
    light_color = "#f8af07"
    light_range = 2
    flag = "magic"
    hitsound = 'sound/blank.ogg'

    //explosion values
    var/exp_heavy = 0
    var/exp_light = 2
    var/exp_flash = 3
    var/exp_fire = 3

/obj/projectile/magic/aoe/dragon_breath/on_hit(target)
    . = ..()
    if(ismob(target))
        var/mob/living/M = target
        if(exp_fire)
            M.adjust_fire_stacks(exp_fire*3)
    var/turf/T
    if(isturf(target))
        T = target
    else
        T = get_turf(target)
    explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, soundin = explode_sound)
    if(ismob(target))
        var/mob/living/M = target
        var/atom/throw_target = get_edge_target_turf(M, angle2dir(Angle))
        M.throw_at(throw_target, exp_light, EXPLOSION_THROW_SPEED)

/obj/effect/proc_holder/spell/invoked/projectile/dragon_breath //breath of a young dragon
	name = "Dragon's Breath"
	desc = "The breath of a dragon. It's hot!"
	clothes_req = FALSE
	range = 10
	projectile_type = /obj/projectile/magic/aoe/dragon_breath
	overlay_state = "fireball"
	sound = list('sound/blank.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 50
	charge_max = 45 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokefire

/obj/effect/proc_holder/spell/invoked/projectile/dragon_breath/young
	charge_max = 60 SECONDS
	chargetime = 60

/obj/effect/proc_holder/spell/invoked/projectile/dragon_breath/adult //broodmother, can add ancient after
	desc = "The breath of an elder dragon. It's hot!"
	chargetime = 20
	charge_max = 15 SECONDS
