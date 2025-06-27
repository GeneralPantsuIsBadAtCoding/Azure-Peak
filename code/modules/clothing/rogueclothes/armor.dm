
//armor parent obj
/obj/item/clothing/suit/roguetown/armor
	slot_flags = ITEM_SLOT_ARMOR
	body_parts_covered = CHEST
	body_parts_inherent = CHEST
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	equip_sound = 'sound/blank.ogg'
	drop_sound = 'sound/blank.ogg'
	pickup_sound =  'sound/blank.ogg'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	sleevetype = "shirt"
	edelay_type = 0
	equip_delay_self = 2.5 SECONDS
	unequip_delay_self = 2.5 SECONDS
	bloody_icon_state = "bodyblood"
	boobed = TRUE
	resistance_flags = FIRE_PROOF
	blocksound = PLATEHIT
	sellprice = 1
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	experimental_onhip = TRUE
	experimental_inhand = FALSE
	nodismemsleeves = TRUE
	flags_inv = HIDEBOOB|HIDECROTCH
	grid_width = 64
	grid_height = 96

//LIGHT ARMOR//

/obj/item/clothing/suit/roguetown/armor/armordress
	slot_flags = ITEM_SLOT_ARMOR
	name = "padded dress"
	desc = "This dress has been padded with leather for extra protection. Bolts and arrows punch right through it."
	body_parts_covered = COVERAGE_FULL
	icon_state = "armordress"
	armor = ARMOR_LEATHER
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT)
	blocksound = SOFTHIT
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	armor_class = ARMOR_CLASS_LIGHT
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/suit/roguetown/armor/armordress/alt
	icon_state = "armordressalt"

//................ Winter Dress ............... //
/obj/item/clothing/suit/roguetown/armor/armordress/winterdress
	name = "winter dress"
	icon = 'icons/roguetown/clothing/shirts_royalty.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts_royalty.dmi'
	desc = "A thick, padded, and comfortable dress popular amongst nobility during winter."
	body_parts_covered = COVERAGE_FULL
	icon_state = "winterdress"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_shirts_royalty.dmi'
	boobed = TRUE
	detail_tag = "_detail"
	detail_color = CLOTHING_BLACK
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT

/obj/item/clothing/suit/roguetown/armor/armordress/winterdress/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/armordress/winterdress/monarch //For the duchess nobody else
	desc = "A thick, padded, and comfortable dress to maintain both temperature and safety when leaving the keep."
	armor = ARMOR_PADDED_GOOD

/obj/item/clothing/suit/roguetown/armor/armordress/winterdress/monarch/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/suit/roguetown/armor/armordress/winterdress/monarch/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/armor/armordress/winterdress/monarch/Destroy()
	GLOB.lordcolor -= src
	return ..()

//otavan brute skin
/obj/item/clothing/suit/roguetown/armor/skin_armor/monk_skin/Initialize(mapload)
	. = ..()
	name = "monk's skin"
	resistance_flags = FIRE_PROOF
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)
	clothing_flags = ITEM_SLOT_ARMOR
	icon_state = null

/obj/item/clothing/suit/roguetown/armor/skin_armor/monk_skin/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)


//gambeson family

/obj/item/clothing/suit/roguetown/armor/gambeson
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "gambeson"
	desc = "A large shirt meant to be worn below armor."
	icon_state = "gambeson"
	body_parts_covered = COVERAGE_FULL
	armor = ARMOR_PADDED
	prevent_crits = list(BCLASS_CUT,BCLASS_BLUNT)
	blocksound = SOFTUNDERHIT
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/gambeson/light
	name = "light gambeson"
	desc = "A thin barely-padded gambeson, typically worn by the peasantry as cheap yet fashionable armor for the whole body. May stop an arrow."
	armor = ARMOR_PADDED_BAD
	prevent_crits = null // It won't help, like, at all.
	sellprice = 10

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	name = "padded gambeson"
	desc = "A gambeson with additional padding layers, hardened to make it more durable. It still does not compare to leather or metal, but it will probably stop a crossbow bolt, so it's typically worn to complement proper armor."
	icon_state = "gambesonp"
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_CHOP)
	armor = ARMOR_PADDED_GOOD
	sellprice = 25
	color = "#976E6B"
	var/shiftable = TRUE
	var/shifted = FALSE

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/attack_right(mob/user)
	if(!shiftable)
		return
	if(shifted)
		if(alert("Would you like to wear your gambeson normally? -Restores greyscaling, new style.",, "Yes", "No") != "No")
			icon_state = "gambesonp"
			color = "#976E6B"
			update_icon()
			shifted = FALSE
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_shirt()
					H.update_inv_armor()
			return
	else
		if(alert("Would you like to wear your gambeson traditionally? -Removes Greyscaling, old style.",, "Yes", "No") != "No")
			icon_state = "gambesonpold"
			color = null
			update_icon()
			shifted = TRUE
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_shirt()
					H.update_inv_armor()
			return


/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/otavan
	name = "fencer gambeson"
	desc = "A large shirt with heavy padding meant to be used below armor. Will probably stop an arrow, unlikely to stop a bolt."
	icon_state = "fancygamb"
	allowed_race = NON_DWARVEN_RACE_TYPES
	color = "#FFFFFF"
	shiftable = FALSE
	sellprice = 30

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/freifechter
	name = "padded fencing shirt"
	desc = "A strong quilted shirt that places little weight on the arms, it's worn underneath a strong leather vest. It lasts a bit less than a regular padded gambeson and won't cover your legs."
	max_integrity = 200		//Back to default. I think it's right if it doesn't stop you from getting legshotted.
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	detail_tag = "_detail"
	altdetail_tag = "_detailalt"
	color = "#FFFFFF"
	detail_color = "#3b2b29"
	altdetail_color = "#c29057"
	icon_state = "fencingshirt"

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/freifechter/update_icon()
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

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/chargah
	name = "steppesman chargah robe"
	desc = "A light yet thick robe padded with fine silks and cloth, acting as a mix of traditional gambeson and imported silks of the east. Popular among Aavnr steppesmen."
	icon_state = "chargah"
	color = "#864a4a"
	boobed = TRUE
	shiftable = FALSE

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/grenzelhoft
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "grenzelhoftian hip-shirt"
	desc = "Padded shirt for extra comfort and protection, adorned in vibrant colors."
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	icon_state = "grenzelshirt"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	boobed = TRUE
	detail_tag = "_detail"
	detail_color = CLOTHING_WHITE
	max_integrity = 250 // Slightly stronger than base, a reward for unique drip
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	color = "#1d1d22"
	detail_color = "#FFFFFF"
	sellprice = 40
	var/picked = FALSE
	shiftable = FALSE

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/grenzelhoft/attack_right(mob/user)
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
			H.update_inv_shirt()

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/grenzelhoft/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/raneshen
	name = "padded desert coat"
	desc = "A slim-fitting sherwani, a Ranesheni-styled coat meant to endure in the desert's climate. This one is heavily padded, meant for a warrior to wear."
	icon_state = "sherwani"
	color = "#eec39a"
	shiftable = FALSE

/obj/item/clothing/suit/roguetown/armor/gambeson/councillor
	color = "#646464"

/obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket
	name = "winter jacket"
	desc = "The most elegant of furs and vivid of royal dyes combined together into a most classy jacket."
	icon_state = "winterjacket"
	detail_tag = "_detail"
	color = CLOTHING_WHITE
	detail_color = CLOTHING_BLACK

/obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket
	name = "artificer jacket"
	icon_state = "artijacket"
	desc = "A thick leather jacket adorned with fur and cog decals. The height of Heartfelt fashion."

/obj/item/clothing/suit/roguetown/armor/cuirass/iron/shadowplate
	name = "scourge breastplate"
	desc = "More form over function, this armor is fit for demonstration of might rather than open combat. The aged gilding slowly tarnishes away."
	icon_state = "shadowplate"
	item_state = "shadowplate"

//................ Corset.................... //
/obj/item/clothing/suit/roguetown/armor/corset
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "corset"
	desc = "A leather binding to constrict one's figure... and lungs."
	icon_state = "corset"
	armor_class = ARMOR_CLASS_LIGHT
	body_parts_covered = CHEST

/obj/item/clothing/suit/roguetown/armor/gambeson/lord
	name = "arming jacket"
	icon_state = "dgamb"
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	allowed_sex = list(MALE, FEMALE)

/obj/item/clothing/suit/roguetown/armor/gambeson/shadowrobe
	name = "stalker robe"
	desc = "A thick robe in royal purple, befitting the hand, while remaining easy for them to slip about in.."
	allowed_race = NON_DWARVEN_RACE_TYPES
	icon_state = "shadowrobe"

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/hierophant
	name = "hierophant's shawl"
	icon_state = "desertrobe"
	item_state = "desertrobe"
	desc = "A thick robe intervowen with spell-laced fabrics. Thick and protective while remaining light and breezy; the perfect gear for protecting one from the threats of the sun, the desert and the daemons, yet still allowing one to cast spells aptly."
	naledicolor = TRUE
	shiftable = FALSE

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/pontifex
	name = "pontifex's kaftan"
	icon_state = "monkleather"
	item_state = "monkleather"
	desc = "Tight boiled leathers that stretch and fit to one's frame perfectly."
	shiftable = FALSE

//leather family

/obj/item/clothing/suit/roguetown/armor/leather
	name = "leather armor"
	desc = "Flexible cowhide armor. Lightweight, better than nothing."
	icon_state = "roguearmor"
	body_parts_covered = COVERAGE_TORSO
	armor = ARMOR_LEATHER
	prevent_crits = list(BCLASS_CUT,BCLASS_BLUNT)
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	nodismemsleeves = TRUE
	max_integrity = 150
	sellprice = 20
	armor_class = ARMOR_CLASS_LIGHT
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/suit/roguetown/armor/leather/cuirass
	name = "leather cuirass"
	desc = "A cuirass made of leather."
	icon_state = "leather"
	max_integrity = 200

/obj/item/clothing/suit/roguetown/armor/leather/hide
	name = "hide armor"
	desc = "A light armor of wildbeast hide. Far more durable than leather."
	icon_state = "hidearmor"
	max_integrity = 250
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/leather/hide/warden
	name = "forestry armor"
	desc = "A light armor worn by the Wardens of Azuria. Far more durable than leather."
	icon = 'icons/roguetown/clothing/special/warden.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/warden.dmi'
	icon_state = "foresthide"

/obj/item/clothing/suit/roguetown/armor/leather/studded
	name = "studded leather armor"
	desc = "Studded leather is the most durable of all hides and leathers and about as light."
	icon_state = "studleather"
	item_state = "studleather"
	blocksound = SOFTHIT
	armor = ARMOR_LEATHER_STUDDED
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT, BCLASS_CHOP, BCLASS_SMASH)
	nodismemsleeves = TRUE
	body_parts_covered = COVERAGE_TORSO
	max_integrity = 300
	smeltresult = /obj/item/ingot/iron
	sellprice = 25
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/leather/heavy
	name = "hardened leather armor"
	desc = "A heavy steerhide jerkin with enough body to stand on its own. It forms a stiff, protective mantle \
	for its wearer, shielding from blows and weather alike."
	icon_state = "roguearmor_belt"
	item_state = "roguearmor_belt"
	armor = ARMOR_LEATHER_GOOD
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT, BCLASS_CHOP, BCLASS_SMASH)
	max_integrity = 300
	sellprice = 20

/obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	name = "hardened leather coat"
	desc = "A heavy steerhide jerkin that reaches past the hips and better protects the vitals."
	icon_state = "roguearmor_coat"
	item_state = "roguearmor_coat"
	body_parts_covered = COVERAGE_ALL_BUT_ARMS
	armor = ARMOR_LEATHER_GOOD
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT, BCLASS_CHOP, BCLASS_SMASH)
	max_integrity = 300
	sellprice = 25

/obj/item/clothing/suit/roguetown/armor/leather/heavy/raneshen
	name = "megarmach scale coat"
	desc = "A set of lightweight armor fashioned from the scales of the Ranesheni \'megarmach\', an armored reptilian creacher that ambushes prey by the riverside, and drags them deep into Abyssor's domain."
	icon_state = "pangolin"
	item_state = "pangolin"

/obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/steppe
	name = "fur-woven hatanga coat"
	desc = "A finely woven hatagna coat, replacing much of its scaled armor with fine furs and reinforced padding for lighter rides."
	icon_state = "hatangafur"
	item_state = "hatangafur"

/obj/item/clothing/suit/roguetown/armor/leather/heavy/jacket
	name = "hardened leather jacket"
	desc = "A heavy leather jacket that covers the arms and protects the vitals."
	icon_state = "leatherjacketo"
	item_state = "leatherjacketo"
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	armor = ARMOR_LEATHER_GOOD
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT, BCLASS_CHOP, BCLASS_SMASH)
	max_integrity = 300
	sellprice = 25

/obj/item/clothing/suit/roguetown/armor/leather/trophyfur
	name = "treated trophy fur robes"
	desc = "A heavy set of hardened robes, lined with fur. The leather is composed of several creatures that were notably difficult to fell by arrow. A proof or rangership among many."
	icon_state = "hatanga"
	item_state = "hatanga"
	armor = list("blunt" = 90, "slash" = 30, "stab" = 40, "piercing" = 60, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_STAB, BCLASS_BLUNT, BCLASS_SMASH, BCLASS_PICK, BCLASS_TWIST)
	max_integrity = 300
	sellprice = 100

/obj/item/clothing/suit/roguetown/armor/leather/bikini
	name = "leather corslet"
	desc = "Flexible cowhide armor. Lightweight, better than nothing. Trimmed to protect the heart and hips."
	body_parts_covered = CHEST|GROIN
	icon_state = "leatherkini"
	item_state = "leatherkini"
	allowed_sex = list(FEMALE, MALE)
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/studded/bikini
	name = "studded leather corslet"
	desc = "Studded leather is the most durable of all hides and leathers and about as light. Trimmed to protect the heart and hips."
	body_parts_covered = CHEST|GROIN
	icon_state = "studleatherkini"
	item_state = "studleatherkini"
	allowed_sex = list(FEMALE)
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/hide/bikini
	name = "hide corslet"
	desc = "A light armor of wildbeast hide. Far more durable than leather. Trimmed to protect the heart and hips."
	body_parts_covered = CHEST|GROIN
	icon_state = "hidearmorkini"
	item_state = "hidearmorkini"
	allowed_sex = list(FEMALE)
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/leather/vest
	name = "leather vest"
	desc = "A leather vest. Not very protective, but fashionable."
	icon_state = "vest"
	item_state = "vest"
	color = "#514339"
	armor = ARMOR_CLOTHING
	prevent_crits = list(BCLASS_CUT)
	blocksound = SOFTHIT
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	blade_dulling = DULLING_BASHCHOP
	body_parts_covered = COVERAGE_TORSO
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	sleevetype = null
	sleeved = null
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
	name = "sea jacket"
	desc = "A sailor's garb."
	icon_state = "sailorvest"
	color = null
	slot_flags = ITEM_SLOT_ARMOR
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	sleevetype = "shirt"
	sewrepair = TRUE

/obj/item/clothing/suit/roguetown/armor/leather/vest/white
	color = CLOTHING_WHITE

/obj/item/clothing/suit/roguetown/armor/leather/vest/sailor/nightman
	name = "silk jacket"
	desc = "A soft and comfortable jacket."
	icon_state = "nightman"
	sleeved = 'icons/roguetown/clothing/onmob/armor.dmi'
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES


/obj/item/clothing/suit/roguetown/armor/leather/vest/hand
	name = "hand's vest"
	desc = "A soft vest of finest fabric."
	icon_state = "handcoat"
	color = null
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/suit/roguetown/armor/longcoat
	name = "longcoat"
	desc = "A padded longcoat meant to keep you warm in the frigid winters"
	icon_state = "longcoat"
	color = CLOTHING_BLACK
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_CLOAK
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	allowed_sex = list(MALE, FEMALE)

/obj/item/clothing/suit/roguetown/armor/longcoat/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/roguetown/cloak)

/obj/item/clothing/suit/roguetown/armor/leather/vest/black
	color = "#3c3a38"

/obj/item/clothing/suit/roguetown/armor/workervest
	name = "striped tunic"
	desc = "This cheap tunic is often used by sturdy laborous men and women."
	icon_state = "workervest"
	armor = null
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	body_parts_covered = COVERAGE_VEST
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	sleevetype = null
	sleeved = null
	nodismemsleeves = TRUE
	boobed = TRUE

/obj/item/clothing/suit/roguetown/armor/workervest/Initialize()
	color = pick("#94b4b6", "#ba8f9e", "#bd978c", "#92bd8c", "#c7c981")
	..()

/obj/item/clothing/suit/roguetown/armor/silkcoat
	name = "silk coat"
	desc = "A padded dressing made from the finest silks."
	icon_state = "bliaut"
	color = null
	armor = ARMOR_SPELLSINGER
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_TWIST)
	blocksound = SOFTHIT
	slot_flags = ITEM_SLOT_ARMOR
	blade_dulling = DULLING_BASHCHOP
	body_parts_covered = COVERAGE_ALL_BUT_ARMS
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	sleevetype = "shirt"
	max_integrity = 100
	sellprice = 50
	armor_class = ARMOR_CLASS_LIGHT
	allowed_sex = list(MALE, FEMALE)
	allowed_race = CLOTHED_RACES_TYPES

/obj/item/clothing/suit/roguetown/armor/silkcoat/Initialize()
	. = ..()
	color = pick(CLOTHING_PURPLE, null,CLOTHING_GREEN, CLOTHING_RED)

/obj/item/clothing/suit/roguetown/shirt/robe/spellcasterrobe
	slot_flags = ITEM_SLOT_ARMOR
	name = "spellsinger robes"
	desc = "A set of reinforced, leather-padded robes worn by spellblades."
	body_parts_covered = COVERAGE_FULL
	armor = ARMOR_SPELLSINGER
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT, BCLASS_CHOP, BCLASS_SMASH)
	armor_class = ARMOR_CLASS_LIGHT
	icon_state = "spellcasterrobe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = null
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

//MEDIUM ARMOR//

/obj/item/clothing/suit/roguetown/armor/chainmail
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "haubergeon"
	desc = "A steel maille shirt. Arrows and small daggers go right through the gaps in this."
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	icon_state = "haubergeon"
	armor = ARMOR_MAILLE
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	blocksound = CHAINHIT
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/chainmail/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle)

/obj/item/clothing/suit/roguetown/armor/chainmail/aalloy
	name = "decrepit chainmail"
	desc = "Decrepit old chainmail. Aeon's grasp is upon it."
	icon_state = "ancientchain"
	smeltresult = /obj/item/ingot/aalloy
	max_integrity = 50

/obj/item/clothing/suit/roguetown/armor/chainmail/paalloy
	name = "ancient chainmail"
	desc = "Chainmail formed of ancient alloys. Aeon's grasp has been lifted from it."
	icon_state = "ancientchain"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/suit/roguetown/armor/chainmail/iron
	icon_state = "ichainmail"
	name = "chainmaille"
	desc = "A chain vest made of heavy iron rings. Better than nothing."
	body_parts_covered = COVERAGE_TORSO
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "hauberk"
	desc = "A longer steel maille that protects the legs, still doesn't protect against arrows though."
	body_parts_covered = COVERAGE_FULL
	icon_state = "hauberk"
	item_state = "hauberk"
	armor = ARMOR_MAILLE
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/aalloy
	name = "decrepit hauberk"
	desc = "A hauberk worn out by time. Aeon's grasp is upon it."
	icon_state = "ancienthauberk"
	max_integrity = 50
	smeltresult = /obj/item/ingot/aalloy

/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/paalloy
	name = "ancient hauberk"
	desc = "A hauberk formed out of ancient alloys. Aeon's grasp is upon it."
	icon_state = "ancienthauberk"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/ornate
	slot_flags = ITEM_SLOT_ARMOR
	armor_class = ARMOR_CLASS_HEAVY
	armor = ARMOR_CUIRASS
	name = "psydonite hauberk"
	desc = "An ornate steel cuirass with tassets, worn atop thick chainmaille. While it falters against arrows and bolts, \
			these interlinked layers are superb at warding off the blows of inhumen claws and axes."
	icon_state = "ornatehauberk"
	item_state = "ornatehauberk"
	max_integrity = 350




/obj/item/clothing/suit/roguetown/armor/chainmail/bikini
	name = "chainmail corslet"	// corslet, from the old French 'cors' or bodice, with the diminutive 'let', used to describe lightweight military armor since 1500. Chosen here to replace 'bikini', an extreme anachronism.
	desc = "For the daring, affording maille's protection with light weight."
	icon_state = "chainkini"
	item_state = "chainkini"
	allowed_sex = list(FEMALE)
	allowed_race = CLOTHED_RACES_TYPES
	body_parts_covered = CHEST|GROIN
	armor_class = ARMOR_CLASS_LIGHT //placed in the medium category to keep it with its parent obj

/obj/item/clothing/suit/roguetown/armor/plate/bikini
	name = "half-plate corslet"
	desc = "A high breastplate and hip armor allowing flexibility and great protection, save for the stomach."
	body_parts_covered = CHEST|GROIN
	icon_state = "halfplatekini"
	item_state = "halfplatekini"
	armor = ARMOR_CUIRASS // Identical to steel cuirass, but covering the groin instead of the vitals.
	max_integrity = 300	// Identical to steel cuirasss. Same steel price.
	allowed_sex = list(FEMALE)
	armor_class = ARMOR_CLASS_MEDIUM
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/plate/half
	slot_flags = ITEM_SLOT_ARMOR
	name = "steel cuirass"
	desc = "A basic cuirass of steel. Lightweight and durable. A crossbow bolt will probably go right through this, but not an arrow."
	body_parts_covered = COVERAGE_VEST
	icon_state = "cuirass"
	item_state = "cuirass"
	armor = ARMOR_CUIRASS
	allowed_race = CLOTHED_RACES_TYPES
	nodismemsleeves = TRUE
	blocking_behavior = null
	max_integrity = 300
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_MEDIUM
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/plate/half/fencer
	name = "fencer's cuirass"
	desc = "An expertly smithed form-fitting steel cuirass that is much lighter and agile, but breaks with much more ease. It's thinner, but backed with silk and leather."
	armor = ARMOR_LIGHTCUIRASS
	armor_class = ARMOR_CLASS_LIGHT
	max_integrity = 170
	smelt_bar_num = 1
	icon_state = "fencercuirass"
	item_state = "fencercuirass"

/obj/item/clothing/suit/roguetown/armor/plate/half/aalloy
	name = "decrepit cuirass"
	desc = "A withered cuirass. Aeon's grasp is upon its form."
	icon_state = "ancientcuirass"
	smeltresult = /obj/item/ingot/aalloy
	max_integrity = 150

/obj/item/clothing/suit/roguetown/armor/plate/half/paalloy
	name = "ancient cuirass"
	desc = "A cuirass of ancient alloys. Aeon's grasp lifted from its form."
	icon_state = "ancientcuirass"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/suit/roguetown/armor/plate/half/fluted
	name = "fluted cuirass"
	icon_state = "flutedcuirass"
	desc = "A sturdy steel cuirass with tassets. Supposedly protective, though maybe not against crossbow bolts."

	body_parts_covered = COVERAGE_ALL_BUT_ARMS
	max_integrity = 350

/obj/item/clothing/suit/roguetown/armor/plate/half/fluted/ornate
	name = "psydonite cuirass"
	icon_state = "ornatecuirass"
	desc = "An ornate steel cuirass with tassets, favored by both the Holy Otavan Inquisition and the Order of the Silver Psycross. \
			Made to endure."
	
	max_integrity = 300

/obj/item/clothing/suit/roguetown/armor/plate/half/iron
	name = "iron breastplate"
	desc = "A basic cuirass of iron, protective and moderately durable."
	icon_state = "ibreastplate"
	max_integrity = 200
	smeltresult = /obj/item/ingot/iron
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/plate/half/copper
	name = "heart protector"
	desc = "Very simple and crude protection for the chest. Ancient fighters once used similar gear, with better quality..."
	icon_state = "copperchest"
	max_integrity = 150
	armor = list("blunt" = 75, "slash" = 75, "stab" = 75, "piercing" = 40, "fire" = 0, "acid" = 0)	//idk what this armor is but I ain't making a define for it
	smeltresult = /obj/item/ingot/copper
	body_parts_covered = CHEST
	armor_class = ARMOR_CLASS_LIGHT
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/plate/half/elven
	name = "elven guardian cuirass"
	desc = "A cuirass made of steel with a thin decorative gold plating. Lightweight and durable."
	color = COLOR_ASSEMBLY_GOLD

/obj/item/clothing/suit/roguetown/armor/plate/scale
	slot_flags = ITEM_SLOT_ARMOR
	name = "scalemail"
	desc = "Metal scales interwoven intricately to form flexible protection!"
	body_parts_covered = COVERAGE_ALL_BUT_ARMS
	allowed_sex = list(MALE, FEMALE)
	icon_state = "lamellar"
	max_integrity = 200
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 4 SECONDS
	armor_class = ARMOR_CLASS_MEDIUM
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/plate/scale/steppe
	name = "steel steppesman hatanga"
	desc = "A set of steel-scaled hatanga armor hailing from the southern steppes."
	icon_state = "hudesutu"
	max_integrity = 250		//Grenzel gets 100+ integrity, I don't see why not give a +50 here.


//HEAVY ARMOR//

/obj/item/clothing/suit/roguetown/armor/plate
	slot_flags = ITEM_SLOT_ARMOR
	name = "steel half-plate"
	desc = "\'Adventurer-fit\' plate armor with pauldrons. The poor fitting leaves many small gaps for daggers and bolts to pierce something vital, so a gambeson is recommended."
	body_parts_covered = COVERAGE_TORSO
	icon_state = "halfplate"
	item_state = "halfplate"
	armor = ARMOR_PLATE
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	nodismemsleeves = TRUE
	max_integrity = 500
	allowed_sex = list(MALE, FEMALE)
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 4 SECONDS
	unequip_delay_self = 4 SECONDS
	armor_class = ARMOR_CLASS_HEAVY
	smelt_bar_num = 3

/obj/item/clothing/suit/roguetown/armor/plate/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_STEP)

/obj/item/clothing/suit/roguetown/armor/plate/aalloy
	name = "decrepit half-plate"
	desc = "Worn out and decrepit halfplate. Aeon's grasp is upon it."
	icon_state = "ancientplate"
	item_state = "ancientplate"
	max_integrity = 150
	smeltresult = /obj/item/ingot/aalloy


/obj/item/clothing/suit/roguetown/armor/plate/paalloy
	name = "ancient half-plate"
	desc = "Plate formed out of ancient alloys. Aeon's grasp has been lifted from it."
	icon_state = "ancientplate"
	item_state = "ancientplate"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/clothing/suit/roguetown/armor/plate/fluted
	name = "fluted half-plate"
	desc = "A sturdily made fluted half-plate armour-set, complete with pauldrons and shoulder-guards. \
	Supposedly made to deflect blows."
	icon_state = "flutedhalfplate"

	equip_delay_self = 6 SECONDS
	unequip_delay_self = 6 SECONDS

	max_integrity = 600
	body_parts_covered = COVERAGE_SHIRT

/obj/item/clothing/suit/roguetown/armor/plate/fluted/graggar
	name = "vicious half-plate"
	desc = "A fluted half-plate armour-set which stirs with the same violence driving our world. This inner motive makes it far less restrictive."
	armor_class = ARMOR_CLASS_MEDIUM
	max_integrity = 500 // We are probably one of the best medium armor sets. At higher integ than most(heavy armor levels, pretty much. But worse resistances, we get the bonus over the other sets of being medium and being unequippable.)
	icon_state = "graggarplate"
	armor = ARMOR_CUIRASS

/obj/item/clothing/suit/roguetown/armor/plate/fluted/graggar/pickup(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_HORDE))
		to_chat(user, "<font color='red'>UNWORTHY HANDS TOUCHING THIS ARMOR, CEASE OR BE RENDED ASUNDER!</font>")
		user.adjust_fire_stacks(5)
		user.IgniteMob()
		user.Stun(40)
	..()

/obj/item/clothing/suit/roguetown/armor/plate/fluted/ornate
	name = "psydonite half-plate"
	desc = "A sturdily made fluted half-plate armour-set, complete with pauldrons and shoulder-guards. \
			Favored by both the Holy Otavan Inquisition and the Order of the Silver Psycross. It smells of the madness of an enduring God."
	icon_state = "ornatehalfplate"

	max_integrity = 400

	/// Whether the user has the Heavy Armour Trait prior to donning.
	var/traited = FALSE

/obj/item/clothing/suit/roguetown/armor/plate/fluted/ornate/equipped(mob/living/user, slot)
	..()
	if(slot != SLOT_ARMOR)
		return
	if (!HAS_TRAIT(user, TRAIT_MEDIUMARMOR))
		return
	ADD_TRAIT(user, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	to_chat(user, span_notice("Endure til' inevitability."))

/obj/item/clothing/suit/roguetown/armor/plate/fluted/ornate/dropped(mob/living/user)
	..()
	if (traited)
		return
	REMOVE_TRAIT(user, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	to_chat(user, span_notice("Trust in thyself."))

/obj/item/clothing/suit/roguetown/armor/plate/full
	name = "plate armor"
	desc = "Full plate. Slow to don and doff without the aid of a good squire."
	icon_state = "plate"
	body_parts_covered = COVERAGE_FULL
	equip_delay_self = 12 SECONDS
	unequip_delay_self = 12 SECONDS
	equip_delay_other = 3 SECONDS
	strip_delay = 6 SECONDS
	smelt_bar_num = 4

/obj/item/clothing/suit/roguetown/armor/plate/full/fluted
	name = "fluted plate"
	desc = "A sturdily made fluted full-plate. Supposedly made to deflect blows from blades and arrows."
	icon_state = "flutedplate"

	equip_delay_self = 14 SECONDS
	unequip_delay_self = 14 SECONDS

	max_integrity = 600

/obj/item/clothing/suit/roguetown/armor/plate/full/fluted/ornate
	name = "psydonite plate"
	desc = "A sturdily made fluted full-plate. Heavy-duty, and made to deflect blows from blades and arrows. \
			Favored by both the Holy Otavan Inquisition and the Order of the Silver Psycross. It smells of the madness of an enduring God."
	icon_state = "ornateplate"

	max_integrity = 500

	/// Whether the user has the Heavy Armour Trait prior to donning.
	var/traited = FALSE

/obj/item/clothing/suit/roguetown/armor/plate/full/fluted/ornate/equipped(mob/living/user, slot)
	..()
	if(slot != SLOT_ARMOR)
		return
	user.change_stat("endurance", 1)
	user.change_stat("constitution", 1)
	to_chat(user, span_notice("Endure til' inevitability."))
	if (!HAS_TRAIT(user, TRAIT_MEDIUMARMOR))
		return
	if (HAS_TRAIT(user, TRAIT_HEAVYARMOR))
		traited = TRUE
		return
	ADD_TRAIT(user, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

/obj/item/clothing/suit/roguetown/armor/plate/full/fluted/ornate/dropped(mob/living/user)
	..()
	user.change_stat("endurance", -1)
	user.change_stat("constitution", -1)
	to_chat(user, span_notice("Trust in thyself."))
	if (!traited)
		REMOVE_TRAIT(user, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

/obj/item/clothing/suit/roguetown/armor/plate/full/matthios
	name = "gilded fullplate"
	desc = "Often, you have heard that told,"
	icon_state = "matthiosarmor"
	max_integrity = 700	


/obj/item/clothing/suit/roguetown/armor/plate/full/matthios/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/suit/roguetown/armor/plate/full/matthios/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/suit/roguetown/armor/plate/full/zizo
	name = "darksteel fullplate"
	desc = "Full plate. Called forth from the edge of what should be known. In Her name."
	icon_state = "zizoplate"
	max_integrity = 700
	peel_threshold = 5	//-Any- weapon will require 5 peel hits to peel coverage off of this armor.

/obj/item/clothing/suit/roguetown/armor/plate/full/zizo/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/suit/roguetown/armor/plate/full/zizo/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)


/obj/item/clothing/suit/roguetown/armor/plate/full/bikini
	name = "full-plate corslet"
	desc = "Breastplate, pauldrons, couters, cuisses... did you forget something?"
	icon_state = "platekini"
	allowed_sex = list(FEMALE)
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	equip_delay_self = 8 SECONDS
	unequip_delay_self = 8 SECONDS
	equip_delay_other = 3 SECONDS
	strip_delay = 6 SECONDS
	smelt_bar_num = 3

/obj/item/clothing/suit/roguetown/armor/heartfelt/lord
	slot_flags = ITEM_SLOT_ARMOR
	name = "coat of armor"
	desc = "A lordly coat of armor."
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS
	icon_state = "heartfelt"
	item_state = "heartfelt"
	armor = ARMOR_PLATE
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	allowed_sex = list(MALE, FEMALE)
	nodismemsleeves = TRUE
	blocking_behavior = null
	max_integrity = 400
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_HEAVY
	smelt_bar_num = 4

/obj/item/clothing/suit/roguetown/armor/heartfelt/hand
	slot_flags = ITEM_SLOT_ARMOR
	name = "coat of armor"
	desc = "A lordly coat of armor."
	body_parts_covered = COVERAGE_FULL
	icon_state = "heartfelt_hand"
	item_state = "heartfelt_hand"
	armor = ARMOR_PLATE
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	allowed_sex = list(MALE, FEMALE)
	nodismemsleeves = TRUE
	blocking_behavior = null
	max_integrity = 400
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_HEAVY
	smelt_bar_num = 4

/obj/item/clothing/suit/roguetown/armor/plate/otavan
	name = "otavan half-plate"
	desc = "Half-plate armor with pauldrons. Recommended to layer with the otavan gambeson."
	armor = ARMOR_PLATE
	body_parts_covered = COVERAGE_TORSO
	icon_state = "corsethalfplate"
	item_state = "corsethalfplate"
	adjustable = CAN_CADJUST
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/suit/roguetown/armor/plate/otavan/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/foley/dropsound/cloth_drop.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "fancyhalfplate"
			body_parts_covered = CHEST|GROIN|VITALS
			flags_cover = null
			emote_environment = 0
			update_icon()
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_armor()
			block2add = null
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			emote_environment = 3
			update_icon()
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_armor()

/obj/item/clothing/suit/roguetown/armor/brigandine
	slot_flags = ITEM_SLOT_ARMOR
	name = "brigandine"
	desc = "Composite armour made according to an Etruscan tradition. It's a high-quality arched plate cuirass sewn with dyed leather and fitted with a wide skirt at the bottom to cover the groin."
	icon_state = "brigandine"
	blocksound = SOFTHIT
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	armor = ARMOR_PLATE
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	allowed_sex = list(MALE, FEMALE)
	nodismemsleeves = TRUE
	max_integrity = 350
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 4 SECONDS
	armor_class = ARMOR_CLASS_HEAVY
	sleeved_detail = FALSE
	boobed_detail = FALSE

/obj/item/clothing/suit/roguetown/armor/brigandine/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_COAT_STEP)

/obj/item/clothing/suit/roguetown/armor/brigandine/attack_right(mob/user)
	if(detail_tag)
		return
	var/the_time = world.time
	var/pickedcolor = input(user, "Select a color.","Brigandine Color") as null|anything in CLOTHING_COLOR_NAMES
	if(!pickedcolor)
		return
	if(world.time > (the_time + 30 SECONDS))
		return
	detail_tag = "_det"
	detail_color = clothing_color2hex(pickedcolor)
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_armor()

/obj/item/clothing/suit/roguetown/armor/brigandine/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/brigandine/sheriff/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/armor/brigandine/sheriff/lordcolor(primary,secondary)
	detail_tag = "_det"
	detail_color = primary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_armor()

/obj/item/clothing/suit/roguetown/armor/brigandine/sheriff/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/suit/roguetown/armor/brigandine/coatplates
	name = "coat of plates"
	desc = "A leather coat with plates attached to increase protection while retaining mobility. The leather below might stop a dagger."
	icon_state = "coat_of_plates"
	blocksound = PLATEHIT
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/brigandine/sheriff/coat
	name = "coat of the commander"
	desc = "A thick boiled leather surcoat with enough plates concealed within the folds to offer superior protection. It weighs a ton and takes a great man to wear."
	icon_state = "leathercoat"
	item_state = "leathercoat"
	var/picked = FALSE
	sleeved_detail = TRUE
	boobed_detail = TRUE

/obj/item/clothing/suit/roguetown/armor/brigandine/sheriff/coat/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/pickedvalue = input(user, "Select a color", "KINGSLAYER'S GARB") as null|anything in list("Khaki", "Black")
	if(!pickedvalue)
		return
	if(world.time > (the_time + 30 SECONDS))
		return
	if(pickedvalue == "Khaki")
		picked = TRUE
	else if(pickedvalue == "Black")
		picked = TRUE
		icon_state = "bleathercoat"
		item_state = "bleathercoat"
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_armor()


/obj/item/clothing/suit/roguetown/armor/brigandine/light
	slot_flags = ITEM_SLOT_ARMOR
	name = "lightweight brigandine"
	desc = "A light riveted coat with plates concealed inside an exterior fabric. Susceptible to daggers being shoved into your ribs."
	icon_state = "light_brigandine"
	blocksound = SOFTHIT
	body_parts_covered = COVERAGE_SHIRT
	armor = ARMOR_CUIRASS
	max_integrity = 250
	smeltresult = /obj/item/ingot/iron
	equip_delay_self = 40
	armor_class = ARMOR_CLASS_MEDIUM
	w_class = WEIGHT_CLASS_BULKY

/obj/item/clothing/suit/roguetown/armor/brigandine/light/attack_right(mob/user)
	if(detail_tag)
		return
	var/the_time = world.time
	var/pickedcolor = input(user, "Select a color.","Brigandine Color") as null|anything in CLOTHING_COLOR_NAMES
	if(!pickedcolor)
		return
	if(world.time > (the_time + 30 SECONDS))
		return
	detail_tag = "_detail"
	detail_color = clothing_color2hex(pickedcolor)
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_armor()

/obj/item/clothing/suit/roguetown/armor/brigandine/light/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat
	slot_flags = ITEM_SLOT_ARMOR
	name = "inquisitorial duster"
	desc = "Metal plates reinforce this heavy coat; only the finest for the inquisition."
	body_parts_covered = COVERAGE_FULL
	allowed_sex = list(MALE, FEMALE)
	icon_state = "inqcoat"
	item_state = "inqcoat"
	sleevetype = "shirt"
	max_integrity = 200
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 4 SECONDS
	armor_class = ARMOR_CLASS_MEDIUM
	smelt_bar_num = 2
	blocksound = SOFTHIT

/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/ComponentInitialize()	//No movement rustle component.
	return

 //--------------- BLACKSTEEL ---------------------

/obj/item/clothing/suit/roguetown/armor/plate/modern/blacksteel_full_plate
	name = "blacksteel plate armor"
	desc = "A suit of Full Plate smithed from durable blacksteel. Using a modern design, the piercing and blunt protection still remain unmatched among its heavy-plated peers."
	body_parts_covered = COVERAGE_FULL
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bplate"
	item_state = "bplate"
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	armor = ARMOR_PLATE_BSTEEL
	allowed_race = CLOTHED_RACES_TYPES
	blocking_behavior = null
	max_integrity = 400
	smeltresult = /obj/item/ingot/blacksteel
	equip_delay_self = 12 SECONDS
	unequip_delay_self = 12 SECONDS
	equip_delay_other = 3 SECONDS
	strip_delay = 6 SECONDS
	smelt_bar_num = 4 

/obj/item/clothing/suit/roguetown/armor/plate/blacksteel_full_plate
	name = "ancient blacksteel plate armor"
	desc = "A suit of Full Plate smithed from durable blacksteel. With an internally layered gambeson, the piercing and blunt protection is unmatched among its heavy-plated peers."
	body_parts_covered = COVERAGE_FULL
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bkarmor"
	item_state = "bkarmor"
	armor = ARMOR_PLATE_BSTEEL
	allowed_race = CLOTHED_RACES_TYPES
	blocking_behavior = null
	max_integrity = 400
	smeltresult = /obj/item/ingot/blacksteel
	equip_delay_self = 12 SECONDS
	unequip_delay_self = 12 SECONDS
	equip_delay_other = 3 SECONDS
	strip_delay = 6 SECONDS
	smelt_bar_num = 4

/obj/item/clothing/suit/roguetown/armor/plate/blacksteel_half_plate
	name = "blacksteel cuirass"
	desc = "A basic cuirass forged from blacksteel. It's somewhat more durable than regular steel."
	body_parts_covered = COVERAGE_TORSO
	icon_state = "grenzelcuirass"
	item_state = "grenzelcuirass"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	allowed_race = CLOTHED_RACES_TYPES
	blocking_behavior = null
	max_integrity = 400
	smeltresult = /obj/item/ingot/blacksteel
	armor_class = ARMOR_CLASS_MEDIUM
	smelt_bar_num = 2

/obj/item/clothing/suit/roguetown/armor/plate/elven_plate
	name = "woad elven plate"
	desc = "Woven by song and tool of the oldest elven druids. It still creaks and weeps with forlorn reminiscence of a bygone era. It looks like only Elves can fit in it."
	allowed_race = list(/datum/species/elf/wood, /datum/species/human/halfelf, /datum/species/elf/dark, /datum/species/elf)
	armor = list("blunt" = 100, "slash" = 20, "stab" = 130, "piercing" = 40, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST, BCLASS_PICK, BCLASS_SMASH)
	body_parts_covered = COVERAGE_FULL
	icon = 'icons/roguetown/clothing/special/race_armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/race_armor.dmi'
	icon_state = "welfchest"
	item_state = "welfchest"
	max_integrity = 500
	anvilrepair = /datum/skill/craft/carpentry
	smeltresult = /obj/item/rogueore/coal
	smelt_bar_num = 4
	blocksound = SOFTHIT
	armor_class = ARMOR_CLASS_MEDIUM

/obj/item/clothing/suit/roguetown/armor/plate/elven_plate/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_WOOD_ARMOR)

//the following changes are apart of a kazengite content update, and uses armor values from ratwood
//i can move the armor protection values into roguetown.dm if it's requested but i really dont think that's necessary for a bunch of custom values

//explanations for armor values & whatever will be sticked at the end of each piece, and they'll be removed if the PR gets merged

/obj/item/clothing/suit/roguetown/armor/basiceast
	name = "simple dobo robe"
	desc = "A dirty dobo robe with white lapels. Can be upgraded through the use of a tailor."
	icon_state = "eastsuit3"
	item_state = "eastsuit3"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	body_parts_covered = COVERAGE_FULL
	armor = list("blunt" = 35, "slash" = 75, "stab" = 40, "piercing" = 20, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT, BCLASS_CHOP)
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	sewrepair = TRUE
	nodismemsleeves = TRUE
	max_integrity = 175 //can be increased if it turns out that having full coverage with such a low integ. isnt worth it
	sellprice = 20
	armor_class = ARMOR_CLASS_LIGHT
	allowed_race = NON_DWARVEN_RACE_TYPES
	flags_inv = HIDEBOOB|HIDECROTCH

//less integrity than a leather cuirass, incredibly weak to blunt damage - great against slash - standard leather value against stab
//the intent for these armors is to create specific weaknesses/strengths for people to play with

/obj/item/clothing/suit/roguetown/armor/basiceast/crafteast
	name = "decorated dobo robe"
	desc = "A dobo robe with a red tassel. Leather inlays are sewn in."
	icon_state = "eastsuit2"
	item_state = "eastsuit2"
	armor = list("blunt" = 50, "slash" = 90, "stab" = 60, "piercing" = 30, "fire" = 0, "acid" = 0)
	max_integrity = 200

//craftable variation of eastsuit, essentially requiring the presence of a tailor with relevant materials
//still weak against blunt

/obj/item/clothing/suit/roguetown/armor/basiceast/mentorsuit
	name = "old dobo robe"
	desc = "The scars on your body were once stories of strength and bravado."
	icon_state = "eastsuit1"
	item_state = "eastsuit1"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	armor = list("blunt" = 50, "slash" = 90, "stab" = 60, "piercing" = 30, "fire" = 0, "acid" = 0)
	max_integrity = 200

/obj/item/clothing/suit/roguetown/armor/basiceast/captainrobe
	name = "foreign robes"
	desc = "Flower-styled robes, said to have been infused with magical protection. The Merchant Guild says that this is from the southern Kazengite region."
	icon_state = "eastsuit4"
	item_state = "eastsuit4"
	armor = list("blunt" = 50, "slash" = 90, "stab" = 60, "piercing" = 30, "fire" = 0, "acid" = 0)
	max_integrity = 300
	sellprice = 25

// this robe spawns on a role that offers no leg protection nor further upgrades to the loadout, in exchange for better roundstart gear
