/obj/effect/landmark/mob_spawner
	name = "Mob Spawner"
	icon_state = "x3"
	var/type_path = /mob/living/carbon/human/species/skeleton/npc/ambush

/obj/effect/landmark/mob_spawner/Initialize()
	. = ..()
	GLOB.mob_spawners += src

/obj/effect/landmark/mob_spawner/Destroy()
	. = ..()
	GLOB.mob_spawners -= src

/obj/effect/landmark/mob_spawner/proc/spawn_and_destroy()
	if(!QDELETED(src))
		new type_path(get_turf(src))
		qdel(src)

//HOSTILE CARBON
/obj/effect/landmark/mob_spawner/skeleton
	type_path = /mob/living/carbon/human/species/skeleton/npc

/obj/effect/landmark/mob_spawner/skeleton/no_equipment
	type_path = /mob/living/carbon/human/species/skeleton/npc/no_equipment

/obj/effect/landmark/mob_spawner/skeleton/supereasy
	type_path = /mob/living/carbon/human/species/skeleton/npc/supereasy

/obj/effect/landmark/mob_spawner/skeleton/easy
	type_path = /mob/living/carbon/human/species/skeleton/npc/easy

/obj/effect/landmark/mob_spawner/skeleton/medium
	type_path = /mob/living/carbon/human/species/skeleton/npc/medium

/obj/effect/landmark/mob_spawner/skeleton/mediumspread
	type_path = /mob/living/carbon/human/species/skeleton/npc/mediumspread

/obj/effect/landmark/mob_spawner/skeleton/hard
	type_path = /mob/living/carbon/human/species/skeleton/npc/hard

/obj/effect/landmark/mob_spawner/skeleton/hardspread
	type_path = /mob/living/carbon/human/species/skeleton/npc/hardspread

/obj/effect/landmark/mob_spawner/skeleton/bogguard
	type_path = /mob/living/carbon/human/species/skeleton/npc/bogguard

/obj/effect/landmark/mob_spawner/skeleton/lich
	type_path = /mob/living/carbon/human/species/skeleton/npc/dungeon/lich

/obj/effect/landmark/mob_spawner/skeleton/dwarf
	type_path = /mob/living/carbon/human/species/dwarfskeleton/ambush

/obj/effect/landmark/mob_spawner/skeleton/dwarf/knight
	type_path = /mob/living/carbon/human/species/dwarfskeleton/ambush/knight/summoned

/obj/effect/landmark/mob_spawner/skeleton/deadite
	type_path = /mob/living/carbon/human/species/npc/deadite

/obj/effect/landmark/mob_spawner/orc
	type_path = /mob/living/carbon/human/species/orc/npc

/obj/effect/landmark/mob_spawner/orc/footsoldier
	type_path = /mob/living/carbon/human/species/orc/npc/footsoldier

/obj/effect/landmark/mob_spawner/orc/marauder
	type_path = /mob/living/carbon/human/species/orc/npc/marauder

/obj/effect/landmark/mob_spawner/orc/berserker
	type_path = /mob/living/carbon/human/species/orc/npc/berserker

/obj/effect/landmark/mob_spawner/orc/warlord
	type_path = /mob/living/carbon/human/species/orc/npc/warlord

/obj/effect/landmark/mob_spawner/orc/chief
	type_path = /mob/living/carbon/human/species/orc/npc/warlord/chief

/obj/effect/landmark/mob_spawner/human
	type_path = /mob/living/carbon/human/species/human/northern/bum/ambush

/obj/effect/landmark/mob_spawner/thief
	type_path = /mob/living/carbon/human/species/human/northern/thief/ambush

/obj/effect/landmark/mob_spawner/highwayman
	type_path = /mob/living/carbon/human/species/human/northern/highwayman

/obj/effect/landmark/mob_spawner/searaider
	type_path = /mob/living/carbon/human/species/human/northern/searaider/ambush

/obj/effect/landmark/mob_spawner/bog_deserters
	type_path = /mob/living/carbon/human/species/human/northern/bog_deserters

/obj/effect/landmark/mob_spawner/bog_deserters/better_gear
	type_path = /mob/living/carbon/human/species/human/northern/bog_deserters/better_gear

/obj/effect/landmark/mob_spawner/drowraider
	type_path = /mob/living/carbon/human/species/elf/dark/drowraider

/obj/effect/landmark/mob_spawner/psy_vault_guard
	type_path = /mob/living/carbon/human/species/lizardfolk/psy_vault_guard

/obj/effect/landmark/mob_spawner/zizoconstruct
	type_path = /mob/living/carbon/human/species/construct/metal/zizoconstruct/ambush

/obj/effect/landmark/mob_spawner/goblin
	type_path = /mob/living/carbon/human/species/goblin/npc/ambush

/obj/effect/landmark/mob_spawner/goblin/cave
	type_path = /mob/living/carbon/human/species/goblin/npc/cave

/obj/effect/landmark/mob_spawner/goblin/sea
	type_path = /mob/living/carbon/human/species/goblin/npc/sea

/obj/effect/landmark/mob_spawner/goblin/sea/orc_faction
	type_path = /mob/living/carbon/human/species/goblin/npc/sea/orc_faction

/obj/effect/landmark/mob_spawner/goblin/hell
	type_path = /mob/living/carbon/human/species/goblin/npc/hell

/obj/effect/landmark/mob_spawner/goblin/moon
	type_path = /mob/living/carbon/human/species/goblin/npc/moon

//HOSTILE SIMPLE

/obj/effect/landmark/mob_spawner/dragon/broodmother
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/dragon/broodmother

/obj/effect/landmark/mob_spawner/dragon/broodmother/wolf_faction
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/dragon/broodmother/wolf_faction

/obj/effect/landmark/mob_spawner/dragon
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/dragon

/obj/effect/landmark/mob_spawner/dragon/wolf_faction
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/dragon/wolf_faction

/obj/effect/landmark/mob_spawner/baroness
	type_path = /mob/living/simple_animal/hostile/boss/baroness

/obj/effect/landmark/mob_spawner/lich
	type_path = /mob/living/simple_animal/hostile/boss/lich

/obj/effect/landmark/mob_spawner/wolf
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/wolf

/obj/effect/landmark/mob_spawner/fox
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/fox

/obj/effect/landmark/mob_spawner/fox/mimi
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/fox/mimi

/obj/effect/landmark/mob_spawner/bigrat
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat

/obj/effect/landmark/mob_spawner/bigrat/gethsmane
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/bigrat/gethsmane

/obj/effect/landmark/mob_spawner/mole
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/mole

/obj/effect/landmark/mob_spawner/haunt
	type_path = /mob/living/simple_animal/hostile/rogue/haunt

/obj/effect/landmark/mob_spawner/dragger
	type_path = /mob/living/simple_animal/hostile/rogue/dragger

/obj/effect/landmark/mob_spawner/headless
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/headless

/obj/effect/landmark/mob_spawner/lamia
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/lamia

/obj/effect/landmark/mob_spawner/spider
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/spider

/obj/effect/landmark/mob_spawner/spider/mutated
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/spider/mutated

/obj/effect/landmark/mob_spawner/mirespider_lurker
	type_path = /mob/living/simple_animal/hostile/rogue/mirespider_lurker

/obj/effect/landmark/mob_spawner/mirespider_paralytic/angry
	type_path = /mob/living/simple_animal/hostile/rogue/mirespider_paralytic/angry

/obj/effect/landmark/mob_spawner/mossback
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/mossback

/obj/effect/landmark/mob_spawner/skeleton/bow
	type_path = /mob/living/simple_animal/hostile/rogue/skeleton/bow

/obj/effect/landmark/mob_spawner/orc/ranged
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/orc/ranged

/obj/effect/landmark/mob_spawner/zardman_jailer_mage
	type_path = /mob/living/simple_animal/hostile/rogue/zardman_jailer_mage

/obj/effect/landmark/mob_spawner/deepone
	type_path = /mob/living/simple_animal/hostile/rogue/deepone

/obj/effect/landmark/mob_spawner/deepone/arm
	type_path = /mob/living/simple_animal/hostile/rogue/deepone/arm

/obj/effect/landmark/mob_spawner/deepone/wiz
	type_path = /mob/living/simple_animal/hostile/rogue/deepone/wiz

/obj/effect/landmark/mob_spawner/deepone/spit
	type_path = /mob/living/simple_animal/hostile/rogue/deepone/spit

/obj/effect/landmark/mob_spawner/minotaur
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/minotaur

/obj/effect/landmark/mob_spawner/minotaur/wounded/chained
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/minotaur/wounded/chained

/obj/effect/landmark/mob_spawner/minotaur/axe
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/minotaur/axe

/obj/effect/landmark/mob_spawner/minotaur/axe/female
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/minotaur/axe/female

/obj/effect/landmark/mob_spawner/troll
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/troll

/obj/effect/landmark/mob_spawner/troll/bog
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/troll/bog

/obj/effect/landmark/mob_spawner/werewolf/f
	type_path = /mob/living/simple_animal/hostile/rogue/werewolf/f

/obj/effect/landmark/mob_spawner/fae/sprite
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/fae/sprite

/obj/effect/landmark/mob_spawner/fae/glimmerwing
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/fae/glimmerwing

/obj/effect/landmark/mob_spawner/infernal/hellhound
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/infernal/hellhound

/obj/effect/landmark/mob_spawner/infernal/watcher
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/infernal/watcher

/obj/effect/landmark/mob_spawner/mimic/gold
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/mimic/gold

//PEACEFULL SIMPLE

/obj/effect/landmark/mob_spawner/cat/rogue
	type_path = /mob/living/simple_animal/pet/cat/rogue

/obj/effect/landmark/mob_spawner/cat/rogue/black
	type_path = /mob/living/simple_animal/pet/cat/rogue/black

/obj/effect/landmark/mob_spawner/cat
	type_path = /mob/living/simple_animal/pet/cat

/obj/effect/landmark/mob_spawner/cat/inn
	type_path = /mob/living/simple_animal/pet/cat/inn

/obj/effect/landmark/mob_spawner/frog
	type_path = /mob/living/simple_animal/hostile/retaliate/frog

/obj/effect/landmark/mob_spawner/butterfly
	type_path = /mob/living/simple_animal/butterfly

/obj/effect/landmark/mob_spawner/mudcrab
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/mudcrab

/obj/effect/landmark/mob_spawner/mudcrab/cabbit
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/mudcrab/cabbit

/obj/effect/landmark/mob_spawner/goat
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/goat

/obj/effect/landmark/mob_spawner/goatmale
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/goatmale

/obj/effect/landmark/mob_spawner/cow
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/cow

/obj/effect/landmark/mob_spawner/bull
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/bull

/obj/effect/landmark/mob_spawner/chicken
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/chicken

/obj/effect/landmark/mob_spawner/saiga/saigabuck
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigabuck

/obj/effect/landmark/mob_spawner/saiga/saigabuck/tame
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigabuck/tame

/obj/effect/landmark/mob_spawner/saiga/saigabuck/tame/saddled
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigabuck/tame/saddled

/obj/effect/landmark/mob_spawner/saiga/tame
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/tame

/obj/effect/landmark/mob_spawner/saiga/tame/saddled
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/tame/saddled

/obj/effect/landmark/mob_spawner/saiga/saigakid
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigakid

/obj/effect/landmark/mob_spawner/trufflepig
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/trufflepig

/obj/effect/landmark/mob_spawner/swine
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/swine

/obj/effect/landmark/mob_spawner/swine/hog/tame
	type_path = /mob/living/simple_animal/hostile/retaliate/rogue/swine/hog/tame

