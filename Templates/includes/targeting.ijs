$if "$$TARGET_APP_SELECTED$$" != "Any"
$if "$$TARGET_APP$$" != "Dreamweaver"
$if "$$TARGET_CC_VERSION_SELECTED$$" == "Any"
//@target $$TARGET_APP_SPECIFIER$$
$else
//@target $$TARGET_APP_FULL_SPECIFIER$$
$endif
$endif

$if "$$USE_PERSISTENT_ENGINE$$" == "ON"
$if "$$TARGET_APP_SELECTED$$" == "InDesign"
//@targetengine $$SHORTCODE$$_Engine
$elif "$$TARGET_APP_SELECTED$$" == "InCopy"
//@targetengine $$SHORTCODE$$_Engine
$endif
$endif

$if "$$TARGET_APP_SELECTED$$" == "Photoshop"
/*
@@@BUILDINFO@@@ $$TARGET_DIRNAME$$/$$DESPACED_TARGET_NAME$$.$$TARGET_FILENAME_EXTENSION$$ $$PROJECT_VERSION$$
*/
  
// BEGIN__HARVEST_EXCEPTION_ZSTRING

<javascriptresource>
    <name>$$TARGET_NAME$$</name>
    <menu>$$PHOTOSHOP_MENU$$</menu>
    <enableinfo>true</enableinfo>
    <eventid>$$PHOTOSHOP_SCRIPT_GUID$$</eventid>
</javascriptresource>

// END__HARVEST_EXCEPTION_ZSTRING

*/

$endif

$endif