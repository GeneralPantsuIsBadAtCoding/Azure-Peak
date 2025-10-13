/datum/patron/godless
	name = "Science"
	rusgodnames = list(
	"Наука", "Науки", "Науке", "Науку", "Наукой", "Науке" // Чумба, ты че ебанутый молиться науке?
	)
	domain = "Ontological Reality"
	desc = "No gods or kings, only man! Gods exist but you give them the finger."
	worshippers = "Madmen, beasts and some dwarves"
	associated_faith = /datum/faith/godless
	preference_accessible = FALSE
	undead_hater = FALSE
	confess_lines = list(
		"Боги не нужны!",
		"МНЕ НЕ НУЖНЫ БОГИ!",
		"Я ЛИШЬ СЕБЕ БОГ!",
		"НЕТ БОГОВ - НЕТ ХОЗЯЕВ!",
	)

/datum/patron/godless/can_pray(mob/living/follower)
	. = ..()
	to_chat(follower, span_danger("Zarlz Zarwin and psyvolution cannot hear my prayer!"))
	return FALSE	//heathen

/datum/patron/godless/on_lesser_heal(
    mob/living/user,
    mob/living/target,
    message_out,
    message_self,
    conditional_buff,
    situational_bonus
)
	*message_out = span_info("Without any particular cause or reason, [target] is healed!")
	*message_self = span_notice("My wounds close without cause.")
