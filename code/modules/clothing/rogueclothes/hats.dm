/obj/item/clothing/head/roguetown
	name = "hat"
	desc = ""
	icon = 'icons/roguetown/clothing/head.dmi'
	icon_state = "top_hat"
	item_state = "that"
	body_parts_covered = HEAD|HAIR
	body_parts_inherent = HEAD
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	dynamic_hair_suffix = "+generic"
	bloody_icon_state = "helmetblood"
	experimental_onhip = FALSE
	var/mask_override = FALSE //override if we want to always respect our inv flags if the helm is in a mask slot
	experimental_inhand = FALSE
	var/hidesnoutADJ = FALSE
	var/overarmor = TRUE

/obj/item/clothing/head/roguetown/equipped(mob/user, slot)
	. = ..()
	user.update_fov_angles()
	if(slot != SLOT_HEAD && !mask_override)
		flags_inv = null
	else
		flags_inv = initial(flags_inv)

/obj/item/clothing/head/roguetown/dropped(mob/user)
	. = ..()
	user.update_fov_angles()

/obj/item/clothing/head/roguetown/antlerhood
	name = "antlerhood"
	desc = "A hood suited for druids and shamans."
	color = null
	flags_inv = HIDEEARS|HIDEHAIR
	icon_state = "antlerhood"
	item_state = "antlerhood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = HEAD|HAIR|EARS|NECK
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = ""
	max_integrity = 80
	armor = ARMOR_HEAD_CLOTHING
	prevent_crits = list(BCLASS_TWIST)
	anvilrepair = null
	sewrepair = TRUE
	blocksound = SOFTHIT

/obj/item/clothing/head/roguetown/spellcasterhat
	name = "spellsinger hat"
	desc = "An oddly shaped hat made of tightly-sewn leather, commonly worn by spellswords."
	icon_state = "spellcasterhat"
	item_state = "spellcasterhat"
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = ARMOR_SPELLSINGER
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/roguehood/MiddleClick(mob/user) 
	overarmor = !overarmor
	to_chat(user, span_info("I [overarmor ? "wear \the [src] under my hair" : "wear \the [src] over my hair"]."))
	if(overarmor)
		alternate_worn_layer = HOOD_LAYER //Below Hair Layer
	else
		alternate_worn_layer = BACK_LAYER //Above Hair Layer
	user.update_inv_wear_mask()
	user.update_inv_head()

/obj/item/clothing/head/roguetown/roguehood
	name = "hood"
	desc = ""
	color = CLOTHING_BROWN
	icon_state = "basichood"
	item_state = "basichood"
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi' //Overrides slot icon behavior
	alternate_worn_layer  = 8.9 //On top of helmet
	body_parts_covered = NECK|HAIR|EARS|HEAD
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	sleevetype = null
	sleeved = null
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100
	sewrepair = TRUE
	block2add = FOV_BEHIND

/obj/item/clothing/head/roguetown/roguehood/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/adjustable_clothing, NECK, null, null, 'sound/foley/equip/cloak (3).ogg', null, (UPD_HEAD|UPD_MASK))	//Standard hood

/obj/item/clothing/head/roguetown/beekeeper
	name = "beekeeper's hood"
	desc = ""
	flags_inv = HIDEEARS|HIDEHAIR
	icon_state = "beekeeper"
	item_state = "beekeeper"
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi'
	alternate_worn_layer  = 8.9 //On top of helmet
	body_parts_covered = HEAD|HAIR|EARS|NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	sleevetype = null
	sleeved = null
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CANT_CADJUST
	toggle_icon_state = FALSE
	max_integrity = 100
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/roguehood/shalal
	name = "keffiyeh"
	desc = "A protective covering worn by those native to the desert."
	color = "#b8252c"
	icon_state = "shalal"
	item_state = "shalal"
	flags_inv = HIDEHAIR|HIDEFACIALHAIR|HIDEFACE|HIDEEARS
	sleevetype = null
	sleeved = null
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi' //Overrides slot icon behavior
	alternate_worn_layer  = 8.9 //On top of helmet
	body_parts_covered = HEAD|HAIR|EARS|NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	armor = ARMOR_HEAD_CLOTHING
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	hidesnoutADJ = TRUE
	blocksound = SOFTHIT
	max_integrity = 100
	sewrepair = TRUE
	mask_override = TRUE
	overarmor = FALSE

/obj/item/clothing/head/roguetown/roguehood/shalal/black
	color = CLOTHING_BLACK

/obj/item/clothing/head/roguetown/roguehood/shalal/hijab
	name = "hijab"
	desc = "Flowing like blood from a wound, this tithe of cloth-and-silk spills out to the shoulders. It carries the telltale mark of Naledian stitcheries."
	item_state = "hijab"
	icon_state = "deserthood"
	hidesnoutADJ = FALSE
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR	//Does not hide face.
	block2add = null

/obj/item/clothing/head/roguetown/roguehood/shalal/hijab/raneshen
	name = "padded headscarf"
	desc = "A common sight amongst those travelling the long desert routes, it offers protection from the heat and a modicum of it against the beasts that prowl its more comfortable nites."
	max_integrity = 100
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = ARMOR_HEAD_PSYDON //basically the same as a warscholar hood
	item_state = "hijab"
	icon_state = "deserthood"
	naledicolor = TRUE

/obj/item/clothing/head/roguetown/roguehood/shalal/heavyhood
	name = "heavy hood"
	desc = "This thick lump of burlap completely shrouds your head, protecting it from harsh weather and nosey protagonists alike."
	color = CLOTHING_BROWN
	item_state = "heavyhood"
	icon_state = "heavyhood"
	hidesnoutADJ = FALSE

/obj/item/clothing/head/roguetown/roguehood/astrata
	name = "sun hood"
	desc = "A hood worn by those who favor Astrata. Praise the firstborn sun!"
	color = null
	icon_state = "astratahood"
	item_state = "astratahood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100

/obj/item/clothing/head/roguetown/nochood
	name = "moon hood"
	desc = "A hood worn by those who favor Noc with a mask in the shape of a crescent."
	color = null
	icon_state = "nochood"
	item_state = "nochood"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	dynamic_hair_suffix = ""
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/necrahood
	name = "death shroud"
	desc = "Wisps of dark fabric that cover your entire head and flutter gently in the breeze. Often worn by those who usher the dead to the afterlife."
	color = null
	icon_state = "necrahood"
	item_state = "necrahood"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	dynamic_hair_suffix = ""
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/roguehood/abyssor
	name = "depths hood"
	desc = "A hood worn by the followers of Abyssor, with a unique, coral-shaped mask. How do they even see out of this?"
	color = null
	icon_state = "abyssorhood"
	item_state = "abyssorhood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100

/obj/item/clothing/head/roguetown/necramask
	name = "death mask"
	desc = "A hood with a decorated jaw bone at the chin, normally worn by some followers of Necra as a form of devotion"
	color = null
	icon_state = "deathface"
	item_state = "deathface"
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi' //Overrides slot icon behavior
	body_parts_covered = NECK|MOUTH //Jaw bone
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	flags_inv = HIDEEARS|HIDESNOUT|HIDEHAIR|HIDEFACIALHAIR
	dynamic_hair_suffix = ""
	sewrepair = TRUE
	mask_override = TRUE


/obj/item/clothing/head/roguetown/dendormask
	name = "briarmask"
	desc = "A mask of wood and thorns worn by druids in service to Dendor."
	color = null
	icon_state = "dendormask"
	item_state = "dendormask"
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi' 
	body_parts_covered = MOUTH
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	dynamic_hair_suffix = ""
	sewrepair = TRUE
	mask_override = TRUE

/obj/item/clothing/head/roguetown/necromhood
	name = "necromancers hood"
	color = null
	icon_state = "necromhood"
	item_state = "necromhood"
	body_parts_covered = NECK
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	dynamic_hair_suffix = ""
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/roguehood/ravoxgorget
	name = "ravox's tabard gorget"
	color = null
	icon_state = "ravoxgorget"
	item_state = "ravoxgorget"
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	flags_inv = HIDENECK
	dynamic_hair_suffix = ""
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/priestmask
	name = "solar visage"
	desc = "The sanctified helm of the most devoted. Thieves beware."
	color = null
	icon_state = "priesthead"
	item_state = "priesthead"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	dynamic_hair_suffix = ""
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/priestmask/pickup(mob/living/user)
	..()
	if(!HAS_TRAIT(user, TRAIT_CHOSEN))
		to_chat(user, "<font color='yellow'>UNWORTHY HANDS TOUCH THE VISAGE, CEASE OR BE PUNISHED</font>")
		spawn(30)
			if(loc == user)
				user.adjust_fire_stacks(5)
				user.IgniteMob()

/obj/item/clothing/head/roguetown/roguehood/red
	color = CLOTHING_RED

/obj/item/clothing/head/roguetown/roguehood/black
	color = CLOTHING_BLACK

/obj/item/clothing/head/roguetown/roguehood/darkgreen
	color = "#264d26"

/obj/item/clothing/head/roguetown/roguehood/random/Initialize()
	color = pick("#544236", "#435436", "#543836", "#79763f")
	..()

/obj/item/clothing/head/roguetown/roguehood/mage/Initialize()
	color = pick("#4756d8", "#759259", "#bf6f39", "#c1b144", "#b8252c")
	..()

/obj/item/clothing/head/roguetown/menacing
	name = "sack hood"
	desc = "A hood commonly worn by executioners to hide their face; The stigma of such a role, and all the grisly work it entails, makes many executioners outcasts in their own right."
	icon_state = "menacing"
	item_state = "menacing"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	dynamic_hair_suffix = ""
	sewrepair = TRUE
	color = "#999999"
	//dropshrink = 0.75

/obj/item/clothing/head/roguetown/menacing/bandit
	icon_state = "bandithood"

/obj/item/clothing/head/roguetown/jester
	name = "jester's hat"
	desc = "A funny-looking hat with jingly bells attached to it."
	icon_state = "jester"
	item_state = "jester"
	detail_tag = "_detail"
	altdetail_tag = "_detailalt"
	dynamic_hair_suffix = "+generic"
	sewrepair = TRUE
	flags_inv = HIDEEARS
	detail_color = CLOTHING_WHITE
	color = CLOTHING_AZURE
	altdetail_color = CLOTHING_WHITE

/obj/item/clothing/head/roguetown/jester/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/jester/lordcolor(primary,secondary)
	detail_color = secondary
	color = primary
	update_icon()

/obj/item/clothing/head/roguetown/jester/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_JINGLE_BELLS, 2)
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/head/roguetown/jester/jester/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/head/roguetown/jester/MiddleClick(mob/user)
	if(!ishuman(user))
		return
	if(flags_inv & HIDE_HEADTOP)
		flags_inv &= ~HIDE_HEADTOP
	else
		flags_inv |= HIDE_HEADTOP
	user.update_inv_head()

/obj/item/clothing/head/roguetown/strawhat
	name = "straw hat"
	desc = "It's scratchy and rustic, but at least it keeps the sun off your head while you toil in the fields."
	icon_state = "strawhat"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/puritan
	name = "buckled hat"
	icon_state = "puritan_hat"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/nightman
	name = "teller's hat"
	icon_state = "tophat"
	color = CLOTHING_BLACK
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/bardhat
	name = "bard's hat"
	icon_state = "bardhat"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/smokingcap
	name = "smoking cap"
	icon_state = "smokingc"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/fancyhat
	name = "fancy hat"
	desc = "A fancy looking hat with colorful feathers sticking out of it."
	icon_state = "fancy_hat"
	item_state = "fancyhat"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/fedora
	name = "archeologist's hat"
	desc = "A strangely-shaped hat with dust caked onto its aged leather."
	icon_state = "curator"
	item_state = "curator"
	sewrepair = TRUE
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/head/roguetown/hatfur
	name = "fur hat"
	desc = "A comfortable warm hat lined with fur."
	icon_state = "hatfur"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/papakha
	name = "papakha"
	icon_state = "papakha"
	item_state = "papakha"
	sewrepair = TRUE
	flags_inv = HIDEEARS
	armor = ARMOR_HEAD_CLOTHING
	blocksound = SOFTHIT

/obj/item/clothing/head/roguetown/hatblu
	name = "fur hat"
	desc = "A blue hat lined with fur."
	icon_state = "hatblu"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/fisherhat
	name = "straw hat"
	desc = "A hat worn by fishermen to protect from the sun."
	icon_state = "fisherhat"
	item_state = "fisherhat"
	sewrepair = TRUE
//	color = "#fbc588"
	//dropshrink = 0.75

/obj/item/clothing/head/roguetown/flathat
	name = "flat hat"
	icon_state = "flathat"
	item_state = "flathat"
	sewrepair = TRUE


/obj/item/clothing/head/roguetown/chaperon
	name = "chaperon hat"
	desc = "A utilitarian yet fashionable hat traditionally made from a hood. Usually worn as a status symbol."
	icon_state = "chaperon"
	item_state = "chaperon"
	sewrepair = TRUE
	//dropshrink = 0.75

/obj/item/clothing/head/roguetown/cookhat
	name = "cook hat"
	desc = "A hat which designates one as well-versed in the arts of cooking."
	icon_state = "chef"
	item_state = "chef"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/chaperon/greyscale
	name = "chaperon hat"
	desc = "A utilitarian yet fashionable hat traditionally made from a hood. This one has been treated to take dyes more easily."
	icon_state = "chap_alt"
	item_state = "chap_alt"
	color = "#dbcde0"

/obj/item/clothing/head/roguetown/chaperon/noble
	name = "noble's chaperon"
	desc = "A decorated chaperon worn by the more influential members of society."
	icon_state = "noblechaperon"
	item_state = "noblechaperon"
	detail_tag = "_detail"
	color = CLOTHING_WHITE
	detail_color = COLOR_ASSEMBLY_GOLD

/obj/item/clothing/head/roguetown/chaperon/noble/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/chaperon/noble/bailiff
	name = "Marshal's chaperon"
	desc = "A noble's chaperon made for the local Marshal. \"How terribly unfortunate you are!\""
	color = "#641E16"
	detail_color = "#b68e37ff"

/obj/item/clothing/head/roguetown/chaperon/noble/guildmaster
	name = "Guildmaster's chapereon"
	desc = "A noble's chaperon made for the guildmaster."
	color = "#1b1717ff"
	detail_color = "#b68e37ff"

/obj/item/clothing/head/roguetown/chaperon/councillor
	name = "chaperon hat"
	desc = "A fancy hat worn by nobles."
	icon_state = "chap_alt"
	item_state = "chap_alt"
	color = "#7dcea0"

/obj/item/clothing/head/roguetown/chaperon/greyscale/elder
	name = "elder's chaperon hat"
	color = "#007fff"

/obj/item/clothing/head/roguetown/chef
	name = "chef's hat"
	desc = "A hat which designates one as well-versed in the arts of cooking."
	icon_state = "chef"
	sewrepair = TRUE
	//dropshrink = 0.75

/obj/item/clothing/head/roguetown/armingcap
	name = "cap"
	desc = "A light cap made of leather, usually worn under a helmet."
	icon_state = "armingcap"
	item_state = "armingcap"
	flags_inv = HIDEEARS
	sewrepair = TRUE
	salvage_result = /obj/item/natural/hide/cured
	//dropshrink = 0.75

/obj/item/clothing/head/roguetown/knitcap
	name = "knit cap"
	desc = "A simple knitted cap."
	icon_state = "knitcap"
	sewrepair = TRUE
	//dropshrink = 0.75

/obj/item/clothing/head/roguetown/armingcap/dwarf
	color = "#cb3434"

/obj/item/clothing/head/roguetown/headband
	name = "headband"
	desc = "A simple headband to keep sweat out of your eyes."
	icon_state = "headband"
	item_state = "headband"
	sewrepair = TRUE
	//dropshrink = 0.75
	dynamic_hair_suffix = null

/obj/item/clothing/head/roguetown/inqhat
	name = "inquisitorial hat"
	desc = "To keep ones vision away from the heavens, and focused on the sin beneath the soil."
	icon_state = "inqhat"
	item_state = "inqhat"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/headband/red
	color = CLOTHING_RED

/obj/item/clothing/head/roguetown/crown/fakecrown
	name = "fake crown"
	desc = "You shouldn't be seeing this."
	icon_state = "serpcrown"

/obj/item/clothing/head/roguetown/crown/surplus
	name = "crown"
	icon_state = "serpcrowno"
	sellprice = 100
	allowed_race = list(/datum/species/goblinp)

/obj/item/clothing/head/roguetown/crown/sparrowcrown
	name = "champion's circlet"
	desc = ""
	icon_state = "sparrowcrown"
	//dropshrink = 0
	dynamic_hair_suffix = null
	resistance_flags = FIRE_PROOF | ACID_PROOF
	sellprice = 50
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/clothing/head/roguetown/nyle
	name = "jewel of nyle"
	icon_state = "nile"
	body_parts_covered = null
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = null
	sellprice = 100
	resistance_flags = FIRE_PROOF
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/clothing/head/roguetown/nyle/consortcrown
	name = "gem-encrusted crown"
	icon_state = "consortcrown"
	item_state = "consortcrown"
	sellprice = 100

/obj/item/clothing/head/roguetown/circlet
	name = "golden circlet"
	icon_state = "circlet"
	item_state = "circlet"
	sellprice = 50

/obj/item/clothing/head/roguetown/priesthat
	name = "priest's hat"
	desc = ""
	icon_state = "priest"
	//dropshrink = 0
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	dynamic_hair_suffix = "+generic"
	sellprice = 77
	worn_x_dimension = 64
	worn_y_dimension = 64
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/reqhat
	name = "serpent crown"
	desc = ""
	icon_state = "reqhat"
	sellprice = 100
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/clothing/head/roguetown/headdress
	name = "nemes"
	desc = "A foreign silk headdress."
	icon_state = "headdress"
	sellprice = 10
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/headdress/alt
	icon_state = "headdressalt"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/nun
	name = "nun's veil"
	desc = "A humble hat for the faithful."
	icon_state = "nun"
	sellprice = 5
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/hennin
	name = "hennin"
	desc = "A hat typically worn by women in nobility."
	icon_state = "hennin"
	sellprice = 19
	dynamic_hair_suffix = "+generic"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/paddedcap
	name = "padded cap"
	desc = "A modest arming cap."
	icon_state = "armingcap"
	item_state = "armingcap"
	sleevetype = null
	sleeved = null
	body_parts_covered = HEAD|HAIR|EARS
	slot_flags = ITEM_SLOT_MASK|ITEM_SLOT_NECK|ITEM_SLOT_HEAD
	armor = ARMOR_HEAD_BAD
	prevent_crits = list(BCLASS_CUT)
	blocksound = SOFTHIT
	max_integrity = 75
	color = "#463C2B"
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/helmet
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi'
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	name = "helmet"
	desc = "A helmet that doesn't get any more simple in design."
	body_parts_covered = HEAD|HAIR|NOSE
	icon_state = "nasal"
	sleevetype = null
	sleeved = null
	resistance_flags = FIRE_PROOF
	armor = ARMOR_HEAD_HELMET
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	clothing_flags = CANT_SLEEP_IN
	dynamic_hair_suffix = "+generic"
	bloody_icon_state = "helmetblood"
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	blocksound = PLATEHIT
	max_integrity = 200
	grid_height = 64
	grid_width = 64
	experimental_onhip = TRUE
	experimental_inhand = TRUE

/obj/item/clothing/head/roguetown/helmet/MiddleClick(mob/user)
	if(!ishuman(user))
		return
	if(flags_inv & HIDE_HEADTOP)
		flags_inv &= ~HIDE_HEADTOP
	else
		flags_inv |= HIDE_HEADTOP
	user.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -5,"sy" = -3,"nx" = 0,"ny" = 0,"wx" = 0,"wy" = -3,"ex" = 2,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 8)
			if("onbelt")
				return list("shrink" = 0.42,"sx" = -3,"sy" = -8,"nx" = 6,"ny" = -8,"wx" = -1,"wy" = -8,"ex" = 3,"ey" = -8,"nturn" = 180,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 1,"sflip" = 0,"wflip" = 0,"eflip" = 8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

// Copper lamellar cap
/obj/item/clothing/head/roguetown/helmet/coppercap
	name = "lamellar cap"
	desc = "A heavy lamellar cap made out of copper. Despite the primitive material, it's an effective design that keeps the head safe."
	icon_state = "lamellar"
	smeltresult = /obj/item/ingot/copper
	armor = ARMOR_HEAD_HELMET_BAD
	max_integrity = 150

/obj/item/clothing/head/roguetown/helmet/skullcap
	name = "skull cap"
	desc = "An iron helmet which covers the top of the head."
	icon_state = "skullcap"
	body_parts_covered = HEAD|HAIR
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/horned
	name = "horned cap"
	desc = "An iron helmet with two horns poking out of the sides."
	icon_state = "hornedcap"
	body_parts_covered = HEAD|HAIR
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/winged
	name = "winged cap"
	desc = "A helmet with two wings on its sides."
	icon_state = "wingedcap"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	body_parts_covered = HEAD|HAIR

/obj/item/clothing/head/roguetown/helmet/kettle
	name = "kettle helmet"
	desc = "A steel helmet which protects the top and sides of the head."
	icon_state = "kettle"
	body_parts_covered = HEAD|HAIR|EARS
	armor = ARMOR_HEAD_HELMET

/obj/item/clothing/head/roguetown/helmet/kettle/wide
	name = "wide kettle helmet"
	desc = "A steel helmet which protects the top and sides of the head. This one looks wider than others."
	icon_state = "kettlewide"

/obj/item/clothing/head/roguetown/helmet/kettle/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Orle") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/kettle/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/sallet
	name = "sallet"
	icon_state = "sallet"
	desc = "A steel helmet which protects the ears."
	smeltresult = /obj/item/ingot/steel
	body_parts_covered = HEAD|HAIR|EARS

/obj/item/clothing/head/roguetown/helmet/sallet/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Orle") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/sallet/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/sallet/visored
	name = "visored sallet"
	desc = "A steel helmet which protects the ears, nose, and eyes."
	icon_state = "sallet_visor"
	adjustable = CAN_CADJUST
	flags_inv = HIDEFACE|HIDESNOUT|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES
	block2add = FOV_BEHIND
	smelt_bar_num = 2
	armor = ARMOR_HEAD_HELMET_VISOR

/obj/item/clothing/head/roguetown/helmet/sallet/visored/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), HIDEHAIR, null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Sallet. Does not hide anything when opened.

/obj/item/clothing/head/roguetown/helmet/sallet/visored/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Orle") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/sallet/visored/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/sallet/elven
	desc = "A steel helmet with a thin gold plating designed for Elven woodland guardians."
	icon_state = "bascinet_novisor"
	item_state = "bascinet_novisor"
	color = COLOR_ASSEMBLY_GOLD

/obj/item/clothing/head/roguetown/helmet/sallet/raneshen
	name = "kulah khud"
	desc = "A sturdy, conical helm that has served the Empire well throughout its many campaigns. It's a sight to see, thousands of these bobbing as an army marches. The only greater humiliation than losing it is losing one's medallion."
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	icon_state = "raneshen"
	worn_x_dimension = 64
	worn_y_dimension = 64
	bloody_icon = 'icons/effects/blood64.dmi'

/obj/item/clothing/head/roguetown/helmet/otavan
	name = "otavan helmet"
	desc = ""
	icon_state = "otavahelm"
	item_state = "otavahelm"
	adjustable = CAN_CADJUST
	emote_environment = 3
	body_parts_covered = FULL_HEAD
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2
	max_integrity = 300

/obj/item/clothing/head/roguetown/helmet/otavan/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -5,"sy" = -3,"nx" = 0,"ny" = 0,"wx" = 0,"wy" = -3,"ex" = 2,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 8)
			if("onbelt")
				return list("shrink" = 0.32,"sx" = -3,"sy" = -8,"nx" = 6,"ny" = -8,"wx" = -1,"wy" = -8,"ex" = 3,"ey" = -8,"nturn" = 180,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 1,"sflip" = 0,"wflip" = 0,"eflip" = 8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/clothing/head/roguetown/helmet/otavan/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), HIDEEARS, null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Otavan. Only hides ears when open.


/obj/item/clothing/head/roguetown/helmet/heavy
	name = "barbute"
	desc = "A simple helmet with a visor in the shape of a Y."
	body_parts_covered = FULL_HEAD
	icon_state = "barbute"
	item_state = "barbute"
	flags_inv = HIDEEARS|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = ARMOR_HEAD_HELMET_VISOR
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_SMASH, BCLASS_TWIST, BCLASS_PICK)
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	max_integrity = 400

/obj/item/clothing/head/roguetown/helmet/heavy/aalloy
	name = "decrepit barbute"
	desc = "A withered old barbute. Aeon's grasp is upon it."
	max_integrity = 200
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	smeltresult = /obj/item/ingot/aalloy
	icon_state = "ancientbarbute"

/obj/item/clothing/head/roguetown/helmet/heavy/aalloy/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/feather) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Plume") as anything in colorlist
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/aalloy/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/paalloy
	name = "ancient barbute"
	desc = "A barbute crafted of ancient alloys. Aeon's grasp has been lifted from its form."
	icon_state = "ancientbarbute"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/head/roguetown/helmet/heavy/paalloy/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/feather) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Plume") as anything in colorlist
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/matthios
	name = "gilded visage"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	desc = "All that glitters is not gold,"
	flags_inv = HIDEEARS|HIDEFACE|HIDESNOUT|HIDEHAIR|HIDEFACIALHAIR
	icon_state = "matthioshelm"
	max_integrity = 600
	worn_x_dimension = 64
	worn_y_dimension = 64
	bloody_icon = 'icons/effects/blood64.dmi'
	experimental_inhand = FALSE
	experimental_onhip = FALSE

/obj/item/clothing/head/roguetown/helmet/heavy/graggar
	name = "vicious helmet"
	desc = "A rugged helmet which stirs with the same violence which drives our world."
	icon_state = "graggarplatehelm"
	max_integrity = 600
	flags_inv = HIDEEARS|HIDEFACE|HIDESNOUT|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/roguetown/helmet/heavy/graggar/pickup(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_HORDE))
		to_chat(user, "<font color='red'>UNWORTHY HANDS TOUCHING THIS HELM, CEASE OR BE RENDED ASUNDER!</font>")
		user.adjust_fire_stacks(5)
		user.IgniteMob()
		user.Stun(40)
	..()

/obj/item/clothing/head/roguetown/helmet/heavy/matthios/pickup(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_COMMIE))
		to_chat(user, "<font color='yellow'>UNWORTHY HANDS TOUCH THE VISAGE, CEASE OR BE PUNISHED</font>")
		user.adjust_fire_stacks(5)
		user.IgniteMob()
		user.Stun(40)
	..()

/obj/item/clothing/head/roguetown/helmet/heavy/zizo
	name = "darksteel barbute"
	desc = "A darksteel barbute. This one has an adjustable visor. Called forth from the edge of what should be known. In Her name."
	adjustable = CAN_CADJUST
	icon_state = "zizobarbute"
	max_integrity = 600
	peel_threshold = 4
	var/frogstyle = FALSE

/obj/item/clothing/head/roguetown/helmet/heavy/zizo/MiddleClick(mob/user)
	frogstyle = !frogstyle
	to_chat(user, span_info("My darksteel helmet shifts into the style of [frogstyle ? "a froggemund" : "a barbute"]."))
	if(frogstyle)
		icon_state = "zizofrogmouth"
		name = "darksteel froggemund"
		desc = "A darksteel froggemund. Called forth from the edge of what should be known. In Her name."
		flags_inv = HIDEFACE|HIDESNOUT|HIDEEARS 
		body_parts_covered = HEAD|EARS|HAIR
		adjustable = CANT_CADJUST
	else
		icon_state = "zizobarbute"
		name = "darksteel barbute"
		desc = "A darksteel barbute. This one has an adjustable visor. Called forth from the edge of what should be known. In Her name."
		adjustable = CAN_CADJUST
	update_icon()
	user.update_inv_head()


/obj/item/clothing/head/roguetown/helmet/heavy/zizo/pickup(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_CABAL))
		to_chat(user, "<font color='purple'>UNWORTHY HANDS TOUCH THE HELMET, CEASE OR BE PUNISHED</font>")
		user.adjust_fire_stacks(5)
		user.IgniteMob()
		user.Stun(40)
	..()

/obj/item/clothing/head/roguetown/helmet/heavy/zizo/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), (HIDEEARS|HIDEHAIR), null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Standard helmet


/obj/item/clothing/head/roguetown/helmet/heavy/guard
	name = "savoyard"
	desc = "A helmet with a menacing visage."
	icon_state = "guardhelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/heavy/guard/aalloy
	name = "decrepit savoyard"
	desc = "A decrepit old savoyard. Aeon's grasp is upon its form."
	max_integrity = 200
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	smeltresult = /obj/item/ingot/aalloy
	icon_state = "ancientsavoyard"

/obj/item/clothing/head/roguetown/helmet/heavy/guard/paalloy
	name = "ancient savoyard"
	desc = "A savoyard crafted of ancient materials. Aeon's grasp has been lifted from its form."
	icon_state = "ancientsavoyard"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/head/roguetown/helmet/heavy/sheriff
	name = "barred helmet"
	desc = "A helmet which offers good protection to the face at the expense of vision."
	icon_state = "gatehelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/heavy/knight
	name = "knight's helmet"
	desc = "A noble knight's helm in the current style popular with nobility. Add a feather to show the colors of your family or allegiance."
	icon_state = "knight"
	item_state = "knight"
	adjustable = CAN_CADJUST
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	block2add = FOV_BEHIND
	max_integrity = 300
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/heavy/knight/black
	color = CLOTHING_GREY

/obj/item/clothing/head/roguetown/helmet/heavy/knight/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), (HIDEEARS|HIDEHAIR), null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Standard helmet

/obj/item/clothing/head/roguetown/helmet/heavy/knight/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/feather) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Plume") as anything in colorlist
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/knight/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/knight/skettle
	name = "slitted kettle helm"
	desc = "A reinforced Eisenhut that's been extended downwards to cover the face, fully protecting the wearer but limiting his field of view. Pairs well with a bevor."
	icon_state = "skettle"
	item_state = "skettle"
	adjustable = CANT_CADJUST

/obj/item/clothing/head/roguetown/helmet/heavy/knight/skettle/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/feather) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Plume") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()
	if(istype(W, /obj/item/natural/cloth) && !altdetail_tag)
		var/choicealt = input(user, "Choose a color.", "Orle") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		altdetail_color = colorlist[choicealt]
		altdetail_tag = "_detailalt"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/knight/armet
	name = "armet"
	desc = "Holy lamb, sacrificial hero, blessed idiot - Psydon endures. Will you endure alongside Him, as a knight of humenity, or crumble before temptation?"
	icon_state = "armet"

/obj/item/clothing/head/roguetown/helmet/heavy/knight/armet/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), (HIDEEARS|HIDEHAIR), null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Standard helmet

/obj/item/clothing/head/roguetown/helmet/heavy/knight/armet/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/feather) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Plume") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()
	if(istype(W, /obj/item/natural/cloth) && !altdetail_tag)
		var/choicealt = input(user, "Choose a color.", "Orle") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		altdetail_color = colorlist[choicealt]
		altdetail_tag = "_detailalt"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()


/obj/item/clothing/head/roguetown/helmet/heavy/knight/armet/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)
	if(get_altdetail_tag())
		var/mutable_appearance/pic2 = mutable_appearance(icon(icon, "[icon_state][altdetail_tag]"))
		pic2.appearance_flags = RESET_COLOR
		if(get_altdetail_color())
			pic2.color = get_altdetail_color()
		add_overlay(pic2)



/obj/item/clothing/head/roguetown/helmet/heavy/bucket/gold
	name = "golden helmet"
	icon_state = "topfhelm_gold"
	item_state = "topfhelm_gold"
	desc = "A full-head covering helm with the engravings of Ravox. Bravery. Justice. Ever Unyielding."

/obj/item/clothing/head/roguetown/helmet/heavy/bucket/ravox/attackby(obj/item/W, mob/living/user, params)
	return

/obj/item/clothing/head/roguetown/helmet/heavy/bucket
	name = "bucket helmet"
	desc = "A helmet which covers the whole of the head. Offers excellent protection."
	icon_state = "topfhelm"
	item_state = "topfhelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/heavy/bucket/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Orle") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/bucket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/heavy/xylixhelm
	name = "xylixian helmet"
	desc = "I dance, I sing! I'll be your fool!"
	icon_state = "xylixhelmet"
	item_state = "xylixhelmet"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/heavy/xylixhelm/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_JINGLE_BELLS, 2)

/obj/item/clothing/head/roguetown/helmet/heavy/astratahelm
	name = "astrata helmet"
	desc = "Headwear commonly worn by Templars in service to Astrata. The firstborn child's light will forever shine on within its crest."
	icon_state = "astratahelm"
	item_state = "astratahelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/heavy/psydonbarbute
	name = "psydonian barbute"
	desc = "A ceremonial barbute, masterfully forged to represent Psydon's divine authority. The Order of Saint Malum's artisans have chiseled this pronged visage into more statues than you could possibly imagine."
	icon_state = "psydonbarbute"
	item_state = "psydonbarbute"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT

/obj/item/clothing/head/roguetown/helmet/heavy/psydonbarbute/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -5,"sy" = -3,"nx" = 0,"ny" = 0,"wx" = 0,"wy" = -3,"ex" = 2,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 8)
			if("onbelt")
				return list("shrink" = 0.32,"sx" = -3,"sy" = -8,"nx" = 6,"ny" = -8,"wx" = -1,"wy" = -8,"ex" = 3,"ey" = -8,"nturn" = 180,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 1,"sflip" = 0,"wflip" = 0,"eflip" = 8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/clothing/head/roguetown/helmet/heavy/psydonhelm
	name = "psydonian armet"
	desc = "An ornate helmet, whose visor has been bound shut with blacksteel chains. The Order of Saint Eora often decorates these armets with flowers - not only as a lucky charm gifted to them by fair maidens and family, but also as a vibrant reminder that 'happiness has to be fought for.'"
	icon_state = "psydonarmet"
	item_state = "psydonarmet"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	adjustable = CAN_CADJUST

/obj/item/clothing/head/roguetown/helmet/heavy/psydonhelm/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -5,"sy" = -3,"nx" = 0,"ny" = 0,"wx" = 0,"wy" = -3,"ex" = 2,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 8)
			if("onbelt")
				return list("shrink" = 0.32,"sx" = -3,"sy" = -8,"nx" = 6,"ny" = -8,"wx" = -1,"wy" = -8,"ex" = 3,"ey" = -8,"nturn" = 180,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 1,"sflip" = 0,"wflip" = 0,"eflip" = 8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/clothing/head/roguetown/helmet/heavy/psydonhelm/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), (HIDEEARS|HIDEHAIR), null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Standard helmet

/obj/item/clothing/head/roguetown/helmet/heavy/psydonhelm/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Orle") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()
	if(istype(W, /obj/item/natural/feather) && !altdetail_tag)
		var/choicealt = input(user, "Choose a color.", "Plume") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		altdetail_color = colorlist[choicealt]
		altdetail_tag = "_detailalt"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/psydonhelm/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)
	if(get_altdetail_tag())
		var/mutable_appearance/pic2 = mutable_appearance(icon(icon, "[icon_state][altdetail_tag]"))
		pic2.appearance_flags = RESET_COLOR
		if(get_altdetail_color())
			pic2.color = get_altdetail_color()
		add_overlay(pic2)

/obj/item/clothing/head/roguetown/helmet/heavy/nochelm
	name = "noc helmet"
	desc = "Headwear commonly worn by Templars in service to Noc. Without the night there can be no day; without Noc there can be no light in the dark hours."
	icon_state = "nochelm"
	item_state = "nochelm"
	emote_environment = 3
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEEARS|HIDEHAIR
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/heavy/necrahelm
	name = "necra helmet"
	desc = "Headwear commonly worn by Templars in service to Necra. Let its skeletal features remind you of the only thing which is guaranteed in life: You will die."
	icon_state = "necrahelm"
	item_state = "necrahelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/heavy/dendorhelm
	name = "dendor helmet"
	desc = "Headwear commonly worn by Templars in service to Dendor. Its protrusions almost resemble branches. Take root in the earth, and you will never be moved."
	icon_state = "dendorhelm"
	item_state = "dendorhelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/heavy/abyssorgreathelm
	name = "abyssorite helmet"
	desc = "A helmet commonly worn by Templars in service to Abyssor. It evokes imagery of the sea with a menacing crustacean visage."
	icon_state = "abyssorgreathelm"
	item_state = "abyssorgreathelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/heavy/ravoxhelm
	name = "justice eagle"
	desc = "Forged in reverence to Ravox, this helm bears the stylized visage of an eagle, symbol of unyielding judgment and divine vigilance. Its hollow eyes see not just foes, but the truth behind every deed."
	icon_state = "ravoxhelmet"
	item_state = "ravoxhelmet"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/heavy/ravoxhelm/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/feather) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Plume") as anything in colorlist
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()


/obj/item/clothing/head/roguetown/helmet/bascinet
	name = "bascinet"
	desc = "A steel bascinet helmet. Though it lacks a visor, it still protects the head and ears."
	icon_state = "bascinet_novisor"
	item_state = "bascinet_novisor"
	emote_environment = 3
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEEARS|HIDEHAIR
	block2add = FOV_BEHIND
	max_integrity = 300
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/bascinet/pigface
	name = "pigface bascinet"
	desc = "A steel bascinet helmet with a pigface visor that protects the entire head and face. Add a feather to show the colors of your family or allegiance."
	icon_state = "hounskull"
	item_state = "hounskull"
	adjustable = CAN_CADJUST
	emote_environment = 3
	body_parts_covered = FULL_HEAD
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/bascinet/pigface/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), (HIDEEARS|HIDEHAIR), null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Standard helmet

/obj/item/clothing/head/roguetown/helmet/bascinet/pigface/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/feather) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Plume") as anything in colorlist
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/bascinet/pigface/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull
	name = "hounskull bascinet"
	desc = "A bascinet with a conical visor, favored by those with snouts and whiskers. Nestle a feather onto the rim to display your allegiance."
	icon_state = "bascinet"


/obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), (HIDEEARS|HIDEHAIR), null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Standard helmet


/obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/feather) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Plume") as anything in colorlist
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()
	if(istype(W, /obj/item/natural/cloth) && !altdetail_tag)
		var/choicealt = input(user, "Choose a color.", "Orle") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		altdetail_color = colorlist[choicealt]
		altdetail_tag = "_detailalt"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()


/obj/item/clothing/head/roguetown/helmet/bascinet/pigface/hounskull/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)
	if(get_altdetail_tag())
		var/mutable_appearance/pic2 = mutable_appearance(icon(icon, "[icon_state][altdetail_tag]"))
		pic2.appearance_flags = RESET_COLOR
		if(get_altdetail_color())
			pic2.color = get_altdetail_color()
		add_overlay(pic2)

/obj/item/clothing/head/roguetown/helmet/bascinet/etruscan
	name = "\improper Etruscan bascinet"
	desc = "A steel bascinet helmet with a straight visor, or \"klappvisier\", which can greatly reduce visibility. Though it was first developed in Etrusca, it is also widely used in Grenzelhoft."
	icon_state = "klappvisier"
	item_state = "klappvisier"
	adjustable = CAN_CADJUST
	emote_environment = 3
	body_parts_covered = FULL_HEAD
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/bascinet/etruscan/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Orle") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/bascinet/etruscan/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/bascinet/etruscan/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), (HIDEEARS|HIDEHAIR), null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Standard helmet

/obj/item/clothing/head/roguetown/helmet/heavy/frogmouth
	name = "froggemund helmet"
	desc = "A tall and imposing frogmouth-style helm popular in the highest plateaus of the Azure Peak. It covers not only the entire head and face, but the neck as well. Add a cloth to show the colors of your family or allegiance."
	icon_state = "frogmouth"
	item_state = "frogmouth"
	emote_environment = 3
	body_parts_covered = FULL_HEAD|NECK
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_RIGHT|FOV_LEFT
	max_integrity = 450
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/heavy/frogmouth/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/choice = input(user, "Choose a color.", "Orle") as anything in colorlist
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		user.transferItemToLoc(W, src, FALSE, FALSE)
		detail_color = colorlist[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/frogmouth/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/helmet/bascinet
	name = "bascinet"
	desc = "A steel bascinet helmet. Though it lacks a visor for the face, it still protects the head and ears."
	icon_state = "bascinet_novisor"
	item_state = "bascinet_novisor"
	emote_environment = 3
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEHAIR
	block2add = null
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/leather
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	name = "leather helmet"
	desc = "A helmet made of leather."
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	icon_state = "leatherhelm"
	armor = ARMOR_HEAD_HELMET_BAD
	sellprice = 10
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	anvilrepair = null
	smeltresult = null
	sewrepair = TRUE
	blocksound = SOFTHIT
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	name = "volf helmet"
	desc = "A leather helmet fashioned from a volf's head."
	body_parts_covered = HEAD|HAIR|EARS
	icon_state = "volfhead"
	item_state = "volfhead"
	armor = ARMOR_HEAD_HELMET_BAD
	max_integrity = 100
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	anvilrepair = null
	sewrepair = TRUE
	blocksound = SOFTHIT

/obj/item/clothing/head/roguetown/helmet/leather/saiga
	name = "saiga skull"
	desc = "The skull of a fearsome saiga. Looks like it could withstand some damage."
	icon_state = "saigahead"
	item_state = "saigahead"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	bloody_icon = 'icons/effects/blood64.dmi'
	armor = ARMOR_HEAD_HELMET_BAD
	max_integrity = 120
	flags_inv = HIDEEARS|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES
	experimental_inhand = FALSE
	experimental_onhip = FALSE

/obj/item/clothing/head/roguetown/wizhat
	name = "wizard hat"
	desc = "Used to distinguish dangerous wizards from senile old men."
	icon_state = "wizardhat"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	dynamic_hair_suffix = "+generic"
	worn_x_dimension = 64
	worn_y_dimension = 64
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/wizhat/red
	icon_state = "wizardhatred"

/obj/item/clothing/head/roguetown/wizhat/yellow
	icon_state = "wizardhatyellow"

/obj/item/clothing/head/roguetown/wizhat/green
	icon_state = "wizardhatgreen"

/obj/item/clothing/head/roguetown/wizhat/black
	icon_state = "wizardhatblack"

/obj/item/clothing/head/roguetown/wizhat/gen
	icon_state = "wizardhatgen"

/obj/item/clothing/head/roguetown/wizhat/gen/wise
	name = "wise hat"
	sellprice = 100
	desc = "Only the wisest of nimrods wear this."

/obj/item/clothing/head/roguetown/wizhat/gen/wise/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/wise = user
	if(slot == SLOT_HEAD)
		wise.change_stat("intelligence", 2, "wisehat")
		to_chat(wise, span_green("I gain wisdom."))

/obj/item/clothing/head/roguetown/wizhat/gen/wise/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/wise = user
	if(wise.get_item_by_slot(SLOT_HEAD) == src)
		wise.change_stat("intelligence", -2, "wisehat")
		to_chat(wise, span_red("I lose wisdom."))

/obj/item/clothing/head/roguetown/shawl
	name = "shawl"
	desc = "Keeps the hair in check, and looks proper."
	icon_state = "shawl"

/obj/item/clothing/head/roguetown/articap
	name = "artificer's cap"
	desc = "A sporting cap with a small gear adornment. Popular fashion amongst engineers."
	icon_state = "articap"

/obj/item/clothing/head/roguetown/brimmed
	desc = "A simple brimmed hat that provides some relief from the sun."
	icon_state = "brimmed"

//............... Feldshers Hood ............... //
/obj/item/clothing/head/roguetown/roguehood/feld
	name = "feldsher's hood"
	desc = "My cure is most effective."
	icon_state = "feldhood"
	item_state = "feldhood"
	body_parts_covered = HEAD|EARS|NOSE
	color = null

//............... Physicians Hood ............... //
/obj/item/clothing/head/roguetown/roguehood/phys
	name = "physicker's hood"
	desc = "My cure is mostly effective."
	icon_state = "surghood"
	item_state = "surghood"
	body_parts_covered = HEAD|EARS|NOSE
	color = null

//............... Eora Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/sallet/eoran
	name = "eora helmet"
	desc = "A simple yet protective helmet forged in the style typical of Eoran worshippers. Upon it lays several laurels of flowers and other colorful ornaments followed by symbols noting the accomplishments and punishments of the owner's chapter."
	icon_state = "eorahelmsallet"
	item_state = "eorahelmsallet"

//................ Briar Thorns ............... //	- Dendor Briar
/obj/item/clothing/head/roguetown/padded/briarthorns
	name = "briar thorns"
	desc = "The pain of wearing it might distract you from the whispers of a mad God overpowering your sanity..."
	icon_state = "briarthorns"

/obj/item/clothing/head/roguetown/padded/briarthorns/pickup(mob/living/user)
	. = ..()
	to_chat(user, span_warning ("The thorns prick me."))
	user.adjustBruteLoss(4)

// azure addition - random wizard hats

/obj/item/clothing/head/roguetown/wizhat/random/Initialize()
	icon_state = pick("wizardhatred", "wizardhatyellow", "wizardhatgreen", "wizardhat")
	..()

/obj/item/clothing/head/roguetown/witchhat
	name = "witch hat"
	desc = ""
	icon_state = "witch"
	item_state = "witch"
	icon = 'icons/roguetown/clothing/head.dmi'
	sewrepair = TRUE

/obj/item/clothing/head/roguetown/archercap
	name = "archer's cap"
	desc = "For the merry men."
	icon_state = "archercap"

/obj/item/clothing/head/roguetown/physician
	name = "doctor's hat"
	desc = "My cure is most effective."
	icon_state = "physhat"

// Grenzel unique drip head. Pretend it is a secrete (A type of hat with a hidden helmet underneath). Same stats as kettle
/obj/item/clothing/head/roguetown/grenzelhofthat
	name = "grenzelhoft plume hat"
	desc = "Whether it's monsters or fair maidens, a true Grenzelhoftian slays both. This hat contains a hidden metallic cap underneath to protect the head from blows."
	icon_state = "grenzelhat"
	item_state = "grenzelhat"
	icon = 'icons/roguetown/clothing/head.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	slot_flags = ITEM_SLOT_HEAD
	detail_tag = "_detail"
	altdetail_tag = "_detailalt"
	dynamic_hair_suffix = ""
	max_integrity = 150
	body_parts_covered = HEAD|HAIR|EARS
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = ARMOR_SPELLSINGER // spellsinger hat stats
	sewrepair = TRUE
	var/picked = FALSE
	color = "#262927"
	detail_color = "#FFFFFF"
	altdetail_color = "#9c2525"

/obj/item/clothing/head/roguetown/grenzelhofthat/attack_right(mob/user)
	..()
	if(!picked)
		var/choice = input(user, "Choose a color.", "Grenzelhoft colors") as anything in colorlist
		var/playerchoice = colorlist[choice]
		picked = TRUE
		detail_color = playerchoice
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/grenzelhofthat/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

	if(get_altdetail_tag())
		var/mutable_appearance/pic2 = mutable_appearance(icon(icon, "[icon_state][altdetail_tag]"))
		pic2.appearance_flags = RESET_COLOR
		if(get_altdetail_color())
			pic2.color = get_altdetail_color()
		add_overlay(pic2)

//Eora content from Stonekeep

/obj/item/clothing/head/roguetown/eoramask
	name = "eoran mask"
	desc = "A silver mask in the likeness of a rabbit. Usually worn by the faithful of Eora during their rituals, but it's not like anyone's going to stop you. Right?"
	color = null
	icon_state = "eoramask"
	item_state = "eoramask"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDEHAIR
	dynamic_hair_suffix = ""
	resistance_flags = FIRE_PROOF // Made of metal

/obj/item/clothing/head/roguetown/eoramask/equipped(mob/living/carbon/human/user, slot) //Copying Eora bud pacifism
	. = ..()
	if(slot == SLOT_HEAD)
		ADD_TRAIT(user, TRAIT_PACIFISM, "eoramask_[REF(src)]")

/obj/item/clothing/head/roguetown/eoramask/dropped(mob/living/carbon/human/user)
	..()
	REMOVE_TRAIT(user, TRAIT_PACIFISM, "eoramask_[REF(src)]")

/obj/item/clothing/head/roguetown/eoramask/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.head)
			to_chat(user, "<span class='warning'>I need some time to remove the mask peacefully.</span>")
			if(do_after(user, 50))
				return ..()
			return
	return ..()

/obj/item/clothing/head/roguetown/helmet/tricorn
	slot_flags = ITEM_SLOT_HEAD
	name = "tricorn"
	desc = ""
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	icon_state = "tricorn"
	armor = ARMOR_HEAD_CLOTHING
	max_integrity = 100
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST)
	anvilrepair = null
	smeltresult = null
	sewrepair = TRUE
	blocksound = SOFTHIT

/obj/item/clothing/head/roguetown/helmet/tricorn/skull
	icon_state = "tricorn_skull"
	desc = "It has a skull sewn onto it. A clear sign of piracy"

/obj/item/clothing/head/roguetown/helmet/tricorn/lucky
	name = "lucky tricorn"
	desc = "A weathered tricorn that has seen many skirmishes. You'd feel lucky with this on your head."
	armor = ARMOR_HEAD_HELMET_BAD

/obj/item/clothing/head/roguetown/helmet/bandana
	slot_flags = ITEM_SLOT_HEAD
	name = "bandana"
	desc = ""
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	icon_state = "bandana"
	armor = ARMOR_HEAD_CLOTHING
	prevent_crits = list(BCLASS_TWIST)
	anvilrepair = null
	smeltresult = null
	sewrepair = TRUE
	blocksound = SOFTHIT

//----------------- BLACKSTEEL ---------------------

/obj/item/clothing/head/roguetown/helmet/blacksteel/modern/armet
	name = "blacksteel armet"
	desc = "An armet forged of durable blacksteel, utilizing a modern design."
	body_parts_covered = FULL_HEAD
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bplatehelm"
	item_state = "bplatehelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = ARMOR_PLATE_BSTEEL
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_SMASH, BCLASS_TWIST, BCLASS_PICK)
	block2add = FOV_BEHIND
	max_integrity = 425
	smeltresult = /obj/item/ingot/blacksteel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/helmet/blacksteel/bucket
	name = "blacksteel bucket helm"
	desc = "A bucket helmet forged of durable blacksteel. None shall pass.."
	body_parts_covered = FULL_HEAD
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bkhelm"
	item_state = "bkhelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = ARMOR_PLATE_BSTEEL
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_SMASH, BCLASS_TWIST, BCLASS_PICK)
	block2add = FOV_BEHIND
	max_integrity = 425
	smeltresult = /obj/item/ingot/blacksteel
	smelt_bar_num = 2

/obj/item/clothing/head/roguetown/roguehood/psydon
	name = "psydonian hood"
	desc = "A hood worn by Psydon's disciples, oft-worn in conjunction with its matching tabard. Made with spell-laced fabric to provide some protection."
	icon_state = "psydonhood"
	item_state = "psydonhood"
	color = null
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	max_integrity = 100
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = ARMOR_HEAD_PSYDON
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100

/obj/item/clothing/head/roguetown/roguehood/hierophant
	name = "hierophant's pashmina"
	desc = "A thick hood that covers one's entire head, should they desire, or merely acts as a scarf otherwise. Made with spell-laced fabric to provide some protection against daemons and mortals alike."
	max_integrity = 100
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = ARMOR_HEAD_PSYDON
	icon_state = "deserthood"
	item_state = "deserthood"
	naledicolor = TRUE

/obj/item/clothing/head/roguetown/roguehood/pontifex
	name = "pontifex's pashmina"
	desc = "A slim hood with thin, yet dense fabric. Stretchy and malleable, allowing for full flexibility and mobility. Made with spell-laced fabric to provide some protection against daemons and mortals alike."
	max_integrity = 100
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = ARMOR_HEAD_PSYDON
	icon_state = "monkhood"
	item_state = "monkhood"
	naledicolor = TRUE

/obj/item/clothing/head/roguetown/bucklehat //lifeweb sprite
	name = "folded hat"
	desc = "A plain leather hat with decorative buckle. Made popular by the ne'er-do-wells of Etrusca."
	icon_state = "bucklehat"
	sewrepair = TRUE
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/head/roguetown/duelhat //lifeweb sprite
	name = "duelist's hat"
	desc = "A feathered leather hat, to show them all your superiority."
	icon_state = "duelhat"
	sewrepair = TRUE
	color = COLOR_ALMOST_BLACK	
	detail_tag = "_detail"
	detail_color = COLOR_SILVER
	salvage_result = /obj/item/natural/hide/cured


/obj/item/clothing/head/roguetown/helmet/heavy/volfplate
	name = "volf-face helm"
	desc = "A steel bascinet helmet with a volfish visor protecting the head, ears, eyes, nose and mouth."
	icon_state = "volfplate"
	item_state = "volfplate"
	adjustable = CAN_CADJUST
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/head/roguetown/helmet/heavy/volfplate/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), (HIDEEARS|HIDEHAIR), null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Standard helmet

/obj/item/clothing/head/roguetown/helmet/leather/advanced
	name = "hardened leather helmet"
	desc = "Sturdy, durable, flexible. A comfortable and reliable hood made of hardened leather."
	icon_state = "leatherhelm"
	max_integrity = 250
	sellprice = 15
	body_parts_covered = HEAD|EARS|HAIR|NOSE
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = ARMOR_HEAD_LEATHER
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	anvilrepair = null
	smeltresult = null
	sewrepair = TRUE
	blocksound = SOFTHIT
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/head/roguetown/helmet/heavy/elven_helm
	name = "woad elven helm"
	desc = "An assembly of woven trunk, kept alive by ancient song, now twisted and warped for battle and scorn."
	body_parts_covered = FULL_HEAD | NECK
	armor = list("blunt" = 100, "slash" = 20, "stab" = 110, "piercing" = 40, "fire" = 0, "acid" = 0)//Resistant to blunt & stab, but very weak to slash.
	prevent_crits = list(BCLASS_BLUNT, BCLASS_SMASH, BCLASS_TWIST, BCLASS_PICK)
	icon = 'icons/roguetown/clothing/special/race_armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/race_armor.dmi'
	icon_state = "welfhead"
	item_state = "welfhead"
	block2add = FOV_BEHIND
	bloody_icon = 'icons/effects/blood64.dmi'
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	smeltresult = /obj/item/rogueore/coal
	anvilrepair = /datum/skill/craft/carpentry
	max_integrity = 300
	blocksound = SOFTHIT
	experimental_inhand = FALSE
	experimental_onhip = FALSE


/obj/item/clothing/head/roguetown/helmet/elvenbarbute
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	name = "elven barbute"
	desc = "It fits snugly on one's elven head, with special slots for their pointier ears."
	body_parts_covered = FULL_HEAD
	body_parts_covered = HEAD|HAIR|NOSE
	flags_inv = HIDEEARS|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	icon_state = "elven_barbute_full"
	item_state = "elven_barbute_full"
	armor = ARMOR_HEAD_HELMET
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	clothing_flags = 0
	block2add = FOV_BEHIND

/obj/item/clothing/head/roguetown/helmet/elvenbarbute/winged
	name = "winged elven barbute"
	desc = "A winged version of the elven barbute. They have always been known for their vanity."
	icon_state = "elven_barbute_winged"
	item_state = "elven_barbute_winged"

/obj/item/clothing/head/roguetown/helmet/bascinet/antler
	name = "wardens's helmet"
	desc = "A strange helmet adorned with antlers worn by the warden of the forest."
	icon = 'icons/roguetown/clothing/special/warden.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/warden64.dmi'
	bloody_icon = 'icons/effects/blood64.dmi'
	icon_state = "wardenhelm"
	adjustable = CAN_CADJUST
	worn_x_dimension = 64
	worn_y_dimension = 64
	body_parts_covered = FULL_HEAD
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2
	experimental_inhand = FALSE
	experimental_onhip = FALSE

/obj/item/clothing/head/roguetown/helmet/bascinet/antler/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS|HAIR), (HIDEEARS|HIDEHAIR), null, 'sound/items/visor.ogg', null, UPD_HEAD)	//Standard helmet

//kazengite update
/obj/item/clothing/head/roguetown/mentorhat
	name = "worn bamboo hat"
	desc = "A reinforced bamboo hat."
	icon_state = "easthat"
	item_state = "easthat"
	armor = list("blunt" = 70, "slash" = 80, "stab" = 65, "piercing" = 40, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	max_integrity = 150
	blocksound = SOFTHIT
	sewrepair = TRUE
	flags_inv = HIDEEARS
	body_parts_covered = HEAD|HAIR|EARS|NOSE|EYES
