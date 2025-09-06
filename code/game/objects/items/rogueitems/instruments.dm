/datum/looping_sound/instrument
	mid_length = 2400 // 4 minutes for some reason. better would be each song having a specific length
	volume = 100
	extra_range = 5
	persistent_loop = TRUE
	var/stress2give = /datum/stressevent/music
	sound_group = /datum/sound_group/instruments //reserves sound channels for up to 10 instruments at a time

/obj/item/rogue/instrument
	name = ""
	desc = ""
	icon = 'icons/roguetown/items/music.dmi'
	icon_state = ""
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK_R|ITEM_SLOT_BACK_L
	can_parry = TRUE
	force = 23
	throwforce = 7
	throw_range = 4
	var/lastfilechange = 0
	var/curvol = 100
	var/datum/looping_sound/instrument/soundloop
	var/list/song_list = list()
	var/note_color = "#7f7f7f"
	var/groupplaying = FALSE
	var/curfile = ""
	var/playing = FALSE
	grid_height = 64
	grid_width = 32

/obj/item/rogue/instrument/equipped(mob/living/user, slot)
	. = ..()
	if(playing && user.get_active_held_item() != src)
		playing = FALSE
		groupplaying = FALSE
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/playing_music)

/obj/item/rogue/instrument/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = 0,"sy" = 2,"nx" = 1,"ny" = -4,"wx" = -1,"wy" = 2,"ex" = 7,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = -2,"eturn" = -2,"nflip" = 8,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogue/instrument/Initialize()
	soundloop = new(src, FALSE)
	. = ..()

/obj/item/rogue/instrument/Destroy()
	qdel(soundloop)
	. = ..()

/obj/item/rogue/instrument/dropped(mob/living/user, silent)
	..()
	groupplaying = FALSE
	playing = FALSE
	if(soundloop)
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/playing_music)

/obj/item/rogue/instrument/attack_self(mob/living/user)
	var/stressevent = /datum/stressevent/music
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	if(playing)
		playing = FALSE
		groupplaying = FALSE
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/playing_music)
		return
	else
		var/playdecision = alert(user, "Would you like to start a band?", "Band Play", "Yes", "No")
		switch(playdecision)
			if("Yes")
				groupplaying = TRUE
			if("No")
				groupplaying = FALSE
		if(!groupplaying)
			var/list/options = song_list.Copy()
			if(user.mind && user.get_skill_level(/datum/skill/misc/music) >= 4)
				options["Upload New Song"] = "upload"
			
			var/choice = input(user, "Which song?", "Music", name) as null|anything in options
			if(!choice || !user)
				return
				
			if(playing || !(src in user.held_items) || user.get_inactive_held_item())
				return
				
			if(choice == "Upload New Song")
				if(lastfilechange && world.time < lastfilechange + 3 MINUTES)
					say("NOT YET!")
					return
				playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
				var/infile = input(user, "CHOOSE A NEW SONG", src) as null|file

				if(!infile)
					return
				if(playing || !(src in user.held_items) || user.get_inactive_held_item())
					return

				var/filename = "[infile]"
				var/file_ext = lowertext(copytext(filename, -4))
				var/file_size = length(infile)
				message_admins("[ADMIN_LOOKUPFLW(user)] uploaded a song [filename] of size [file_size / 1000000] (~MB).")
				if(file_ext != ".ogg")
					to_chat(user, span_warning("SONG MUST BE AN OGG."))
					return
				if(file_size > 6485760)
					to_chat(user, span_warning("TOO BIG. 6 MEGS OR LESS."))
					return
				lastfilechange = world.time
				fcopy(infile,"data/jukeboxuploads/[user.ckey]/[filename]")
				curfile = file("data/jukeboxuploads/[user.ckey]/[filename]")
				var/songname = input(user, "Name your song:", "Song Name") as text|null
				if(songname)
					song_list[songname] = curfile
				return
			curfile = song_list[choice]
			if(!user || playing || !(src in user.held_items))
				return
			if(user.mind)
				switch(user.get_skill_level(/datum/skill/misc/music))
					if(1)
						stressevent = /datum/stressevent/music
						soundloop.stress2give = stressevent
					if(2)
						note_color = "#ffffff"
						stressevent = /datum/stressevent/music/two
						soundloop.stress2give = stressevent
					if(3)
						note_color = "#1eff00"
						stressevent = /datum/stressevent/music/three
						soundloop.stress2give = stressevent
					if(4)
						note_color = "#0070dd"
						stressevent = /datum/stressevent/music/four
						soundloop.stress2give = stressevent
					if(5)
						note_color = "#a335ee"
						stressevent = /datum/stressevent/music/five
						soundloop.stress2give = stressevent
					if(6)
						note_color = "#ff8000"
						stressevent = /datum/stressevent/music/six
						soundloop.stress2give = stressevent
					else
						soundloop.stress2give = stressevent
			if(!(src in user.held_items))
				return
			if(user.get_inactive_held_item())
				playing = FALSE
				soundloop.stop()
				user.remove_status_effect(/datum/status_effect/buff/playing_music)
				return
			if(curfile)
				playing = TRUE
				soundloop.mid_sounds = list(curfile)
				soundloop.cursound = null
				soundloop.start()
				user.apply_status_effect(/datum/status_effect/buff/playing_music, stressevent, note_color)
				GLOB.azure_round_stats[STATS_SONGS_PLAYED]++
			else
				playing = FALSE
				groupplaying = FALSE
				soundloop.stop()
				user.remove_status_effect(/datum/status_effect/buff/playing_music)
		if(groupplaying)
			var/pplnearby =view(7,loc)
			var/list/instrumentsintheband = list()
			var/list/bandmates = list()
			for(var/mob/living/carbon/human/potentialbandmates in pplnearby)
				var/list/thisguyinstrument = list()
				var/obj/item/iteminhand = potentialbandmates.get_active_held_item()
				if(istype(iteminhand, /obj/item/rogue/instrument))
					var/decision = alert(potentialbandmates, "Would you like to perform in a band?", "Band Play", "Yes", "No")
					switch(decision)
						if("No")
							return
						else
							bandmates += potentialbandmates
							instrumentsintheband += iteminhand
							thisguyinstrument += iteminhand
							for(var/obj/item/rogue/instrument/bandinstrumentspersonal in thisguyinstrument)
								if(bandinstrumentspersonal.playing)
									return
								bandinstrumentspersonal.curfile = input(potentialbandmates, "Which song shall [potentialbandmates] perform?", "Music", name) as null|anything in bandinstrumentspersonal.song_list
								bandinstrumentspersonal.curfile = bandinstrumentspersonal.song_list[bandinstrumentspersonal.curfile]
			if(do_after(user, 1))
				for(var/obj/item/rogue/instrument/bandinstrumentsband in instrumentsintheband)
					if(!curfile)
						return
					bandinstrumentsband.playing = TRUE
					bandinstrumentsband.groupplaying = TRUE
					bandinstrumentsband.soundloop.mid_sounds = bandinstrumentsband.curfile
					bandinstrumentsband.soundloop.cursound = null
					bandinstrumentsband.soundloop.start()
					for(var/mob/living/carbon/human/A in bandmates)
						A.apply_status_effect(/datum/status_effect/buff/playing_music, stressevent, note_color)

/obj/item/rogue/instrument/lute
	name = "lute"
	desc = "Its graceful curves were designed to weave joyful melodies."
	icon_state = "lute"
	song_list = list("A Knight's Return" = 'sound/silence.ogg',
	"Amongst Fare Friends" = 'sound/silence.ogg',
	"The Road Traveled by Few" = 'sound/silence.ogg',
	"Tip Thine Tankard" = 'sound/silence.ogg',
	"A Reed On the Wind" = 'sound/silence.ogg',
	"Jests On Steel Ears" = 'sound/silence.ogg',
	"Merchant in the Mire" = 'sound/silence.ogg',
	"The Power" = 'sound/silence.ogg',
	"Bard Dance" = 'sound/silence.ogg',
	"Old Time Battles" = 'sound/silence.ogg')

/obj/item/rogue/instrument/accord
	name = "accordion"
	desc = "A harmonious vessel of nostalgia and celebration."
	icon_state = "accordion"
	song_list = list("Her Healing Tears" = 'sound/silence.ogg',
	"Peddler's Tale" = 'sound/silence.ogg',
	"We Toil Together" = 'sound/silence.ogg',
	"Just One More, Tavern Wench" = 'sound/silence.ogg',
	"Moonlight Carnival" = 'sound/silence.ogg',
	"'Ye Best Be Goin'" = 'sound/silence.ogg',
	"Beloved Blue" = 'sound/silence.ogg')

/obj/item/rogue/instrument/guitar
	name = "guitar"
	desc = "This is a guitar, chosen instrument of wanderers and the heartbroken." // YIPPEE I LOVE GUITAR
	icon_state = "guitar"
	song_list = list("Fire-Cast Shadows" = 'sound/silence.ogg',
	"The Forced Hand" = 'sound/silence.ogg',
	"Regrets Unpaid" = 'sound/silence.ogg',
	"'Took the Mammon and Ran'" = 'sound/silence.ogg',
	"Poor Man's Tithe" = 'sound/silence.ogg',
	"In His Arms Ye'll Find Me" = 'sound/silence.ogg',
	"El Odio" = 'sound/silence.ogg',
	"Danza De Las Lanzas" = 'sound/silence.ogg',
	"The Feline, Forever Returning" = 'sound/silence.ogg',
	"El Beso Carmesí" = 'sound/silence.ogg',
	"The Queen's High Seas" = 'sound/silence.ogg',
	"Harsh Testimony" = 'sound/silence.ogg',
	"Someone Fair" = 'sound/silence.ogg',
	"Daisies in Bloom" = 'sound/silence.ogg')

/obj/item/rogue/instrument/harp
	name = "harp"
	desc = "A harp of elven craftsmanship."
	icon_state = "harp"
	song_list = list("Through Thine Window, He Glanced" = 'sound/silence.ogg',
	"The Lady of Red Silks" = 'sound/silence.ogg',
	"Eora Doth Watches" = 'sound/silence.ogg',
	"On the Breeze" = 'sound/silence.ogg',
	"Never Enough" = 'sound/silence.ogg',
	"Sundered Heart" = 'sound/silence.ogg',
	"Corridors of Time" = 'sound/silence.ogg',
	"Determination" = 'sound/silence.ogg')

/obj/item/rogue/instrument/flute
	name = "flute"
	desc = "A row of slender hollow tubes of varying lengths that produce a light airy sound when blown across."
	icon_state = "flute"
	song_list = list("Half-Dragon's Ten Mammon" = 'sound/silence.ogg',
	"'The Local Favorite'" = 'sound/silence.ogg',
	"Rous in the Cellar" = 'sound/silence.ogg',
	"Her Boots, So Incandescent" = 'sound/silence.ogg',
	"Moondust Minx" = 'sound/silence.ogg',
	"Quest to the Ends" = 'sound/silence.ogg',
	"Spit Shine" = 'sound/silence.ogg',
	"The Power" = 'sound/silence.ogg',
	"Bard Dance" = 'sound/silence.ogg',
	"Old Time Battles" = 'sound/silence.ogg')

/obj/item/rogue/instrument/drum
	name = "drum"
	desc = "Fashioned from taut skins across a sturdy frame, pulses like a giant heartbeat."
	icon_state = "drum"
	song_list = list("Barbarian's Moot" = 'sound/silence.ogg',
	"Muster the Wardens" = 'sound/silence.ogg',
	"The Earth That Quakes" = 'sound/silence.ogg',
	"The Power" = 'sound/silence.ogg', //BG3 Song
	"Bard Dance" = 'sound/silence.ogg', // BG3 Song
	"Old Time Battles" = 'sound/silence.ogg') // BG3 Song

/obj/item/rogue/instrument/hurdygurdy
	name = "hurdy-gurdy"
	desc = "A knob-driven, wooden string instrument that reminds you of the oceans far."
	icon_state = "hurdygurdy"
	song_list = list("Ruler's One Ring" = 'sound/silence.ogg',
	"Tangled Trod" = 'sound/silence.ogg',
	"Motus" = 'sound/silence.ogg',
	"Becalmed" = 'sound/silence.ogg',
	"The Bloody Throne" = 'sound/silence.ogg',
	"We Shall Sail Together" = 'sound/silence.ogg')

/obj/item/rogue/instrument/viola
	name = "viola"
	desc = "The prim and proper Viola, every prince's first instrument taught."
	icon_state = "viola"
	song_list = list("Far Flung Tale" = 'sound/silence.ogg',
	"G Major Cello Suite No. 1" = 'sound/silence.ogg',
	"Ursine's Home" = 'sound/silence.ogg',
	"Mead, Gold and Blood" = 'sound/silence.ogg',
	"Gasgow's Reel" = 'sound/silence.ogg',
	"The Power" = 'sound/silence.ogg', //BG3 Song, I KNOW THIS ISNT A VIOLIN, LEAVE ME ALONE
	"Bard Dance" = 'sound/silence.ogg', // BG3 Song
	"Old Time Battles" = 'sound/silence.ogg') // BG3 Song


/obj/item/rogue/instrument/vocals
	name = "vocalist's talisman"
	desc = "This talisman emanates a soft shimmer of light. When held, it can amplify and even change a bard's voice."
	icon_state = "vtalisman"
	song_list = list("Harpy's Call (Feminine)" = 'sound/silence.ogg',
	"Necra's Lullaby (Feminine)" = 'sound/silence.ogg',
	"Death Touched Aasimar (Feminine)" = 'sound/silence.ogg',
	"Our Mother, Our Divine (Feminine)" = 'sound/silence.ogg',
	"Wed, Forever More (Feminine)" = 'sound/silence.ogg',
	"Paper Boats (Feminine + Vocals)" = 'sound/silence.ogg',
	"The Dragon's Blood Surges (Masculine)" = 'sound/silence.ogg',
	"Timeless Temple (Masculine)" = 'sound/silence.ogg',
	"Angel's Earnt Halo (Masculine)" = 'sound/silence.ogg',
	"A Fabled Choir (Masculine)" = 'sound/silence.ogg',
	"A Pained Farewell (Masculine + Feminine)" = 'sound/silence.ogg',
	"The Power (Whistling)" = 'sound/silence.ogg',
	"Bard Dance (Whistling)" = 'sound/silence.ogg',
	"Old Time Battles (Whistling)" = 'sound/silence.ogg')

/obj/item/rogue/instrument/shamisen
	name = "shamisen"
	desc = "The shamisen, or simply «three strings», is an kazengunese stringed instrument with a washer, which is usually played with the help of a bachi."
	icon_state = "shamisen"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	song_list = list(
	"Cursed Apple" = 'sound/silence.ogg',
	"Fire Dance" = 'sound/silence.ogg',
	"Lute" = 'sound/silence.ogg',
	"Tsugaru Ripple" = 'sound/silence.ogg',
	"Tsugaru" = 'sound/silence.ogg',
	"Season" = 'sound/silence.ogg',
	"Parade" = 'sound/silence.ogg',
	"Koshiro" = 'sound/silence.ogg')
