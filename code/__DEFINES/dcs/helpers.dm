/// A wrapper for _AddElement that allows us to pretend we're using normal named arguments
#define AddElement(arguments...) _AddElement(list(##arguments))
/// A wrapper for _RemoveElement that allows us to pretend we're using normal named arguments
#define RemoveElement(arguments...) _RemoveElement(list(##arguments))

/// A wrapper for _AddComponent that allows us to pretend we're using normal named arguments
#define AddComponent(arguments...) _AddComponent(list(##arguments))

/// A wrapper for _AddComonent that passes in a source.
/// Necessary if dupe_mode is set to COMPONENT_DUPE_SOURCES.
#define AddComponentFrom(source, arguments...) _AddComponent(list(##arguments), source)

/// A wrapper for _LoadComponent that allows us to pretend we're using normal named arguments
#define LoadComponent(arguments...) _LoadComponent(list(##arguments))
