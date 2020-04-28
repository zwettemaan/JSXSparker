$if "$$TARGET_APP_SELECTED$$" != "Any"
$if "$$TARGET_CC_VERSION_SELECTED$$" == "Any"
//@target $$TARGET_APP$$
$else
//@target $$TARGET_APP_SPECIFIER$$
$endif
$if "$$USE_PERSISTENT_ENGINE$$" == "ON"
$if "$$TARGET_APP_SELECTED$$" == "InDesign"
//@targetengine $$SHORTCODE$$_Engine
$elif "$$TARGET_APP_SELECTED$$" == "InCopy"
//@targetengine $$SHORTCODE$$_Engine
$endif
$endif
$endif
