/datum/asset/group/goonchat
	children = list(
		/datum/asset/simple/purify,
		/datum/asset/simple/jquery,
		/datum/asset/simple/goonchat,
		/datum/asset/simple/namespaced/fontawesome,
		/datum/asset/simple/roguefonts
	)

/datum/asset/simple/purify
	keep_local_name = TRUE
	assets = list(
		"purify.min.js"            = 'goon/browserassets/js/purify.min.js',
	)

/datum/asset/simple/jquery
	keep_local_name = TRUE
	assets = list(
		"jquery.min.js"            = 'goon/browserassets/js/jquery.min.js',
	)

/datum/asset/simple/goonchat
	keep_local_name = TRUE
	assets = list(
		"json2.min.js"             = 'goon/browserassets/js/json2.min.js',
		"browserOutput.js"         = 'goon/browserassets/js/browserOutput.js',
		"browserOutput.css"	       = 'goon/browserassets/css/browserOutput.css',
		"browserOutput_white.css"  = 'goon/browserassets/css/browserOutput.css',
	)
