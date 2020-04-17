$if "$$TARGET_APP_SELECTED$$" != "Any"
$if "$$TARGET_CC_VERSION_SELECTED$$" == "Any"
//@target $$TARGET_APP$$
$else
//@target $$TARGET_APP_SPECIFIER$$
$endif
$if "$$TARGET_APP_SELECTED$$" == "InDesign" and "$$USE_PERSISTENT_ENGINE$$" == "ON"
//@targetengine $$SHORTCODE$$_Engine
$endif
$endif
