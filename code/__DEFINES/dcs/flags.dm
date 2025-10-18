/// /datum/element flags
#define ELEMENT_DETACH		(1 << 0)
/**
 * Only elements created with the same arguments given after `id_arg_index` share an element instance
 * The arguments are the same when the text and number values are the same and all other values have the same ref
 */
#define ELEMENT_BESPOKE		(1 << 1)
// Causes all detach arguments to be passed to detach instead of only being used to identify the element
/// When this is used your Detach proc should have the same signature as your Attach proc
#define ELEMENT_COMPLEX_DETACH (1 << 2)
