/// Trait given to a mob that is currently thinking (giving off the "thinking" icon), used in an IC context
#define TRAIT_THINKING_IN_CHARACTER "currently_thinking_IC"

/// This trait comes from when a mob is currently typing.
#define CURRENTLY_TYPING_TRAIT "currently_typing"

// Used to direct channels to speak into.
#define SAY_CHANNEL "Say"
#define RADIO_CHANNEL "Radio"
#define ME_CHANNEL "Me"
#define OOC_CHANNEL "OOC"
#define ADMIN_CHANNEL "Admin"
#define LOOC_CHANNEL "LOOC"
#define WHIS_CHANNEL "Whis"
#define SUBTLE_CHANNEL "Subtle"

#define MAX_MESSAGE_CHUNKS 1023


/**
 * stuff like `copytext(input, length(input))` will trim the last character of the input,
 * because DM does it so it copies until the char BEFORE the `end` arg, so we need to bump `end` by 1 in these cases.
 */
#define PREVENT_CHARACTER_TRIM_LOSS(integer) (integer + 1)


#define MAX_TGUI_INPUT (MAX_MESSAGE_CHUNKS * 1024)
