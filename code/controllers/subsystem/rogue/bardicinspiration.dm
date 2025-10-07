// Bardic Inspo time - Datum/definition setup

#define BARD_T1 1
#define BARD_T2 2
#define BARD_T3 3

GLOBAL_LIST_INIT(learnable_songs, (list(/obj/effect/proc_holder/spell/invoked/song/fervor_song,
		)
))




/datum/inspiration
	var/mob/living/carbon/human/holder
	var/level = BARD_T1
	var/songpoints = BARD_T1
	var/list/audience = list()


/datum/inspiration/proc/grant_inspiration(mob/living/carbon/human/H, bard_tier)
	if(!H || !H.mind)
		return
	try_add_songs(H, bard_tier)
	songpoints = bard_tier
	H.verbs += list(/mob/living/carbon/human/proc/setaudience, /mob/living/carbon/human/proc/clearaudience, /mob/living/carbon/human/proc/checkaudience)


/mob/living/carbon/human/proc/setaudience()
	set name = "Audience Choice"
	set category = "Inspiration"

	if(!inspiration)
		return FALSE
	var/list/folksnearby = list()
	for(var/mob/living/carbon/human/folks in view(5, loc))
		folksnearby += folks

	if(!folksnearby)
		return
	var/target = input(src, "Who will you perform for?") as null|anything in folksnearby
	if(target)
		inspiration.audience += target

	return TRUE

/mob/living/carbon/human/proc/clearaudience()
	set name = "Clear Audience"
	set category = "Inspiration"
	if(!inspiration)
		return FALSE
	if(src.has_status_effect(/datum/status_effect/buff/playing_music)) // cant clear while playing
		return
	inspiration.audience = list()

	return TRUE


/mob/living/carbon/human/proc/checkaudience()
	set name = "Check Audience"
	set category = "Inspiration"

	if(!inspiration)
		return FALSE
	var/text = ""
	for(var/mob/living/carbon/human/folks in inspiration.audience)
		text += "[folks.real_name], "
	if(!text)
		return
	to_chat(src, "My audience members are: [text]")

	return TRUE
	

/datum/inspiration/New(mob/living/carbon/human/holder)
	. = ..()
	src.holder = holder
	holder?.inspiration = src
	ADD_TRAIT(holder, INSPIRING_MUSICIAN, "inspiration")


/datum/inspiration/proc/try_add_songs(mob/living/carbon/human/holder, bard_tier)
	if(!holder || !holder.mind)
		return
	level = bard_tier
	var/list/choices = list()
	var/list/songs = GLOB.learnable_songs


	for(var/i = 1, i <= songs.len, i++)
		var/obj/effect/proc_holder/spell/invoked/song/song_item = songs[i]
		if(song_item.song_tier > bard_tier)
			continue
		choices["[song_item.name]"] = song_item
	
	choices = sortList(choices)
	var/song_count = bard_tier
	for(var/l, l <= song_count, l++)
		var/choice = input("Choose a song") as anything in choices
		var/obj/effect/proc_holder/spell/item = choices[choice]

		if(!item)
			return     // user canceled;
		if(alert(holder, "[item.desc]", "[item.name]", "Learn", "Cancel") == "Cancel") //gives a preview of the spell's description to let people know what a spell does
			return

		for(var/obj/effect/proc_holder/spell/knownsong in holder.mind.spell_list)
			if(knownsong.type == item.type)
				to_chat(holder,span_warning("You already know this one!"))
				return
			var/obj/effect/proc_holder/spell/new_song = new item
			holder.mind.AddSpell(new_song)
