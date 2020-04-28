var dreamweaver;
var app;

var $$SHORTCODE$$;
if (! $$SHORTCODE$$) {
    $$SHORTCODE$$ = {};
}

$$SHORTCODE$$.LOG_CRITICAL_ERRORS = false;

$$SHORTCODE$$.relativeFilePathsToLoad = [
    "helpers/json2.jsx",
    "helpers/globals.jsx",
    "helpers/tweakableSettings.jsx",
    "helpers/utils.jsx",
    "helpers/pathUtils.jsx",
    "helpers/init.jsx"
];

$$SHORTCODE$$.errorBeforeLoggingAvailable = function(error) {

    if ($$SHORTCODE$$.logError) {
        $$SHORTCODE$$.logError(error);
    }
    else if ($$SHORTCODE$$.LOG_CRITICAL_ERRORS) {

        try {

            var f = File(Folder.desktop + "/criticalErrors.log");
            f.open("a");
            f.writeln(error);
            f.close();

        }
        catch (err) {

            try {
                console.log(error);
            }
            catch (err) {   
            }

        }
    }
}

if (dreamweaver) {

    $$SHORTCODE$$.loadScript = function(extensionDir, scriptPath) {
        try {
            var fullPath = extensionDir + scriptPath;
            var script = DWfile.read(fullPath);
            eval(script);
        }
        catch (err) {           
            $$SHORTCODE$$.errorBeforeLoggingAvailable("hostscript.jsx loadScript throws " + err + " for " + fullPath);  
        }
    }

}
else {

    $$SHORTCODE$$.loadScript = function(extensionDir, scriptPath) {
        try {
            var fullPath = extensionDir + scriptPath;
            var file = File(fullPath);
            file.open("r");
            var script = file.read();
            file.close();
            eval(script);
        }
        catch (err) {           
            $$SHORTCODE$$.errorBeforeLoggingAvailable("hostscript.jsx loadScript throws " + err + " for " + fullPath);  
        }
    }

}

$$SHORTCODE$$.initScript = function initScript(extensionDir) {

    for (var idx = 0; idx < $$SHORTCODE$$.relativeFilePathsToLoad.length; idx++) {
        var filePath = $$SHORTCODE$$.relativeFilePathsToLoad[idx];
        $$SHORTCODE$$.loadScript(extensionDir, filePath);
    }

}

