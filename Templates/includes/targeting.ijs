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

$if "$$TARGET_APP_SELECTED$$" == "Photoshop"
/*
@@@BUILDINFO@@@ $$TARGET_DIRNAME$$/$$DESPACED_TARGET_NAME$$.$$TARGET_FILENAME_EXTENSION$$ $$PROJECT_VERSION$$
*/

/* 
Special properties for a JavaScript to enable it to behave like an automation plug-in, 
the variable name must be exactly as the following example and the variables must be 
defined in the top 10000 characters of the file, 
   
// BEGIN__HARVEST_EXCEPTION_ZSTRING

<javascriptresource>
    <name>$$TARGET_NAME$$</name>
    <menu>$$PHOTOSHOP_MENU$$</menu>
    <enableinfo>true</enableinfo>
    <eventid>$$PHOTOSHOP_SCRIPT_GUID$$</eventid>
</javascriptresource>

// END__HARVEST_EXCEPTION_ZSTRING

   The item tagged "name" specifies the localized name or ZString that will be displayed in the menu
   The item tagged "menu" specifies the menu in which the command will appear: generate, automate, scripts, or filter
   The item tagged "enableinfo" specifies the conditions under which the command will be enabled. Too complex to describe here; see plugin sdk. Should usually just be "true", and your command should report a user-comprehensible error when it can't handle things. The problem with disabling the command when it's unsuitable is that there's no hint to the user as to why a command is disabled.
   The item tagged "about" specifies the localized text or ZString to be displayed in the about box for the plugin. Optional.
   The item tagged "eventid" needs to be a guaranteed unique string for your plugin. Usually generated with a UUID generator like uuidgen on MacOS
   
   You also need to set the value of the pluginName variable below to match the name of your plugin as the Generator process knows it.
   
   Do not change the values "name", or "generateAssets" in the code below.

*/

$endif

$endif