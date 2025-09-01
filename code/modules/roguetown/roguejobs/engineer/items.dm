/obj/item/roguegear //journeyman
	icon = 'icons/roguetown/items/misc.dmi'
	name = "cog"
	desc = "A cog with teeth meticulously crafted for tight interlocking."
	icon_state = "gear"
	w_class = WEIGHT_CLASS_SMALL
	smeltresult = null
	var/skillholder = null
	var/max_skill = SKILL_LEVEL_APPRENTICE
	var/obj/structure/linking
	grid_width = 64
	grid_height = 32

/obj/item/roguegear/Destroy()
	if(linking)
		linking = null
	. = ..()

/obj/item/roguegear/attack_self(mob/user)
	if(linking)
		linking = null
		to_chat(user, span_warning("Linking halted."))
		return

/obj/item/roguegear/attack_obj(obj/O, mob/living/user)
	if(!istype(O, /obj/structure))
		return ..()
	var/obj/structure/S = O
	if(linking)
		if(linking == O)
			to_chat(user, span_warning("You cannot link me to myself."))
			return
		if(linking in S.redstone_attached)
			to_chat(user, span_warning("Already linked."))
			linking = null
			return
		S.redstone_attached |= linking
		linking.redstone_attached |= S
		linking = null
		to_chat(user, span_notice("Link complete."))
		return
	linking = S
	to_chat(user, span_info("Link beginning..."))

/obj/item/roguegear/attack(mob/living/M, mob/user, skill)
	testing("attack")
	if(!user.cmode)
		if(M.construct)
			if(do_after(user, 5 SECONDS, target = user))
				var/skills = list()
				var/skill_choice
				var/groups = list("Craft", "Labor", "Misc") //No combat and magic skills. Maybe later.
				var/skill_group_choice = input("Choose skill group", "AUTO-MATO") as anything in groups
				switch(skill_group_choice)
					if("Craft")
						skills = list("Crafting", "Weaponsmithing", "Armorsmithing", "Blacksmithing", "Smelting", "Carpentry", "Masonry", "Trapmaking", "Cooking", "Engineering", "Skincrafting", "Sewing", "Alchemy")
						skill_choice = input("Choose your skill", "PROGRESS!") as anything in skills
						switch(skill_choice)
							if("Crafting")
								skillholder = /datum/skill/craft/crafting
							if("Weaponsmithing")
								skillholder = /datum/skill/craft/weaponsmithing
							if("Armorsmithing")
								skillholder = /datum/skill/craft/armorsmithing
							if("Blacksmithing")
								skillholder = /datum/skill/craft/blacksmithing
							if("Smelting")
								skillholder = /datum/skill/craft/smelting
							if("Carpentry")
								skillholder = /datum/skill/craft/carpentry
							if("Masonry")
								skillholder = /datum/skill/craft/masonry
							if("Trapmaking")
								skillholder = /datum/skill/craft/traps
							if("Cooking")
								skillholder = /datum/skill/craft/cooking
							if("Engineering")
								skillholder = /datum/skill/craft/engineering
							if("Skincrafting")
								skillholder = /datum/skill/craft/tanning
							if("Sewing")
								skillholder = /datum/skill/misc/sewing
							if("Alchemy")
								skillholder = /datum/skill/craft/alchemy
					if("Labor")
						skills = list("Farming", "Mining", "Fishing", "Butchering", "Lumberjacking")
						skill_choice = input("Choose your skill", "PROGRESS!") as anything in skills
						switch(skill_choice)
							if("Farming")
								skillholder = /datum/skill/labor/farming
							if("Mining")
								skillholder = /datum/skill/labor/mining
							if("Fishing")
								skillholder = /datum/skill/labor/fishing
							if("Butchering")
								skillholder = /datum/skill/labor/butchering
							if("Lumberjacking")
								skillholder = /datum/skill/labor/lumberjacking
					if("Misc")
						skills = list("Climbing", "Swimming", "Pickpocketing", "Sneaking", "Lockpicking", "Riding", "Music", "Medicine", "Tracking", "Pottery")
						skill_choice = input("Choose your skill", "PROGRESS!") as anything in skills
						switch(skill_choice)
							if("Climbing")
								skillholder = /datum/skill/misc/climbing
							if("Swimming")
								skillholder = /datum/skill/misc/swimming
							if("Pickpocketing")
								skillholder = /datum/skill/misc/stealing
							if("Sneaking")
								skillholder = /datum/skill/misc/sneaking
							if("Lockpicking")
								skillholder = /datum/skill/misc/lockpicking
							if("Riding")
								skillholder = /datum/skill/misc/riding
							if("Music")
								skillholder = /datum/skill/misc/music
							if("Medicine")
								skillholder = /datum/skill/misc/medicine
							if("Tracking")
								skillholder = /datum/skill/misc/tracking
							if("Pottery")
								skillholder = /datum/skill/misc/ceramics
				var/userskill = M.get_skill_level(skillholder)
				if(userskill <= max_skill && istype(src, /obj/item/roguegear))
					to_chat(M, span_blue("A strange disturbance is gaining strength in my mechanisms..."))
					M.adjust_skillrank(skillholder, 1, TRUE)
				if(userskill <= max_skill && userskill == SKILL_LEVEL_APPRENTICE && istype(src, /obj/item/roguegear))
					to_chat(M, span_blue("ᛦ I'm opening up new possibilities for my body... ᛦ"))
					M.adjust_skillrank(skillholder, 1, TRUE)
				if(userskill <= max_skill && userskill == SKILL_LEVEL_JOURNEYMAN && istype(src, /obj/item/roguegear/t1))
					to_chat(M, span_blue("ᛦᛦ I went beyond what was allowed, a strange feeling does not leave me... ᛦᛦ"))
					M.adjust_skillrank(skillholder, 1, TRUE)
				if(userskill <= max_skill && userskill == SKILL_LEVEL_EXPERT && istype(src, /obj/item/roguegear/t2))
					to_chat(M, span_blue("ᛦᛦᛦ Now I understand, I feel the power of PROGRESS! ᛦᛦᛦ"))
					M.adjust_skillrank(skillholder, 1, TRUE)
				if(M == user)
					user.visible_message(span_notice("[user] presses the cog to [user]'s body, and it is absorbed."), span_notice("I absorb the cog."))
				else
					user.visible_message(span_notice("[user] presses the cog to [M]'s body, and it is absorbed."), span_notice("I press the cog to [M], and it is absorbed."))
				return
			else 
				return ..()
		else 
			return ..()
	else 
		return ..()

/obj/item/roguegear/t1 //expert
	icon = 'icons/roguetown/items/misc.dmi'
	name = "runic cog"
	desc = "An ordinary bronze gear, but this one is imbued with an arcana."
	icon_state = "gear2"
	max_skill = SKILL_LEVEL_JOURNEYMAN

/obj/item/roguegear/t2 //master
	icon = 'icons/roguetown/items/misc.dmi'
	name = "cog of PROGRESS"
	desc = "A runic gear distorted by forbidden knowledge. Is that the Z symbol...?"
	icon_state = "gear3"
	max_skill = SKILL_LEVEL_EXPERT

/* Legendary skills
/obj/item/roguegear/t3
	icon = 'icons/roguetown/items/misc.dmi'
	name = "cog3"
	desc = "A cog with teeth meticulously crafted for tight interlocking."
	icon_state = "gear3"
	max_skill = SKILL_LEVEL_MASTER
*/
