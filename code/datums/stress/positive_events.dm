/datum/stressevent/psyprayer
	timer = 30 MINUTES
	stressadd = -2
	desc = span_green("The Gods smile upon me.")

/datum/stressevent/viewsinpunish
	timer = 5 MINUTES
	stressadd = -2
	desc = span_green("I saw a sinner get punished!")

/datum/stressevent/joke
	timer = 30 MINUTES
	stressadd = -2
	desc = span_green("I heard a good joke.")

/datum/stressevent/tragedy
	timer = 30 MINUTES
	stressadd = -2
	desc = span_green("Life isn't so bad after all.")

/datum/stressevent/blessed
	timer = 60 MINUTES
	stressadd = -2
	desc = span_green("I feel a soothing presence.")

/datum/stressevent/triumph
	timer = 10 MINUTES
	stressadd = -5
	desc = span_boldgreen("I remember a TRIUMPH.")

/datum/stressevent/drunk
	timer = 1 MINUTES
	stressadd = -2
	desc = list(span_green("Alcohol eases the pain."),span_green("Alcohol, my true friend."))

/datum/stressevent/pweed
	timer = 1 MINUTES
	stressadd = -2
	desc = list(span_green("A relaxing smoke."),span_green("A flavorful smoke."))

/datum/stressevent/weed
	timer = 5 MINUTES
	stressadd = -4
	desc = span_blue("I love you sweet leaf.")

/datum/stressevent/high
	timer = 5 MINUTES
	stressadd = -4
	desc = span_blue("I'm so high, don't take away my sky.")

/datum/stressevent/stuffed
	timer = 20 MINUTES
	stressadd = -1
	desc = span_green("I'm stuffed! Feels good.")

/datum/stressevent/hydrated
	timer = 10 MINUTES
	stressadd = -1
	desc = span_green("My thirst is quenched. Invigorating.")

/datum/stressevent/prebel
	timer = 5 MINUTES
	stressadd = -5
	desc = span_boldgreen("Down with the tyranny!")

/datum/stressevent/music
	timer = 1 MINUTES
	stressadd = -1
	desc = span_green("This music is relaxing.")

/datum/stressevent/music/two
	stressadd = -2
	desc = span_green("This music is very relaxing.")
	timer = 2 MINUTES

/datum/stressevent/music/three
	stressadd = -2
	desc = span_green("This music drains away my stress.")
	timer = 4 MINUTES

/datum/stressevent/music/four
	stressadd = -3
	desc = span_green("This music is great.")
	timer = 6 MINUTES

/datum/stressevent/music/five
	stressadd = -3
	timer = 8 MINUTES
	desc = span_green("This music is wonderful!")

/datum/stressevent/music/six
	stressadd = -4
	timer = 10 MINUTES
	desc = span_boldgreen("This music is exceptional!")

/datum/stressevent/vblood
	stressadd = -5
	desc = span_boldred("Virgin blood!")
	timer = 5 MINUTES

/datum/stressevent/bathwater
	stressadd = -1
	desc = span_blue("Relaxing.")
	timer = 1 MINUTES

/datum/stressevent/beautiful
	stressadd = -2
	desc = span_green("Their face is a work of art!")
	timer = 2 MINUTES

/datum/stressevent/night_owl
	stressadd = -3
	desc = span_green("The night is so relaxing and peaceful.")
	timer = 20 MINUTES

/datum/stressevent/ozium
	stressadd = -99
	desc = span_blue("I've taken a hit and entered a painless world.")
	timer = 2 MINUTES

/datum/stressevent/moondust
	stressadd = -6
	desc = span_boldgreen("Moondust surges through me.")
	timer = 4 MINUTES

/datum/stressevent/starsugar
	stressadd = -1
	desc = span_boldgreen("My heart rushes, my blood runs, I feel tightly bound together. I could run a marathon.")
	timer = 4 MINUTES

/datum/stressevent/moondust_purest
	stressadd = -8
	desc = span_boldgreen("PURE moondust surges through me!")
	timer = 4 MINUTES

/datum/stressevent/campfire
	stressadd = -1
	desc = span_green("The warmth of the fire is comforting.")
	timer = 5 MINUTES

/datum/stressevent/puzzle_easy
	stressadd = -1
	desc = span_green("That puzzle was a nice distraction from this drudgery.")
	timer = 10 MINUTES

/datum/stressevent/puzzle_medium
	stressadd = -2
	desc = span_green("I solved a slightly difficult puzzle. If only my actual problems were so easy.")
	timer = 10 MINUTES

/datum/stressevent/puzzle_hard
	stressadd = -3
	desc = span_green("I solved a rather challenging puzzle.")
	timer = 10 MINUTES

/datum/stressevent/puzzle_impossible
	stressadd = -4
	desc = span_boldgreen("I solved an extremely difficult puzzle. Xylix is smiling at me, and surely even Noc must find it impressive.")
	timer = 15 MINUTES

/datum/stressevent/noble_lavish_food
	stressadd = -4
	desc = span_green("Truly, a feast befitting my station.")
	timer = 30 MINUTES

/datum/stressevent/wine_okay
	stressadd = -1
	desc = span_green("That drink was alright.")
	timer = 10 MINUTES

/datum/stressevent/wine_good
	stressadd = -2
	desc = span_green("A decent vintage always goes down easy.")
	timer = 10 MINUTES

/datum/stressevent/wine_great
	stressadd = -3
	desc = span_blue("An absolutely exquisite vintage. Indubitably.")
	timer = 10 MINUTES

/datum/stressevent/meditation
	timer = 10 MINUTES
	stressadd = -1
	desc = span_green("My meditations were rewarding.")

/datum/stressevent/bathcleaned
    timer = 20 MINUTES
    stressadd = -3
    desc = span_green("I feel immaculate!")

/datum/stressevent/bath
    timer = 10 MINUTES
    stressadd = -1
    desc = span_green("I'm just a bit cleaner.")


/datum/stressevent/pacified
	timer = 30 MINUTES
	stressadd = -5
	desc = span_green("All my problems have washed away!")

/datum/stressevent/noble_bowed_to
	timer = 5 MINUTES
	stressadd = -3
	desc = span_green("Someone showed me the respect I deserve as a noble.")

/datum/stressevent/noble_bowed_to/can_apply(mob/living/user)
	return HAS_TRAIT(user, TRAIT_NOBLE)

/datum/stressevent/perfume
	stressadd = -1
	desc = span_green("A soothing fragrance envelops me.")
	timer = 10 MINUTES

/datum/stressevent/astrata_grandeur
	timer = 30 MINUTES
	stressadd = -2
	desc = span_green("Astrata's light shines brightly through me. I must not let others ever forget that.")

/datum/stressevent/graggar_culling_finished
	stressadd = -1
	desc = span_green("I have prevailed over my rival! Graggar favours me now!")
	timer = INFINITY
