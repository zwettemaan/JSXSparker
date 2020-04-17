﻿//
// This file mirrors the API of js/utils.js
//

$$SHORTCODE$$.checkMac = function checkMac() {
    
    $if "$$ENABLE_LOG_ENTRY_EXIT$$" == "ON"
    $$SHORTCODE$$.logEntry(arguments);
    $endif

    var retVal = $.os.substr(0,3) == "Mac";

    $if "$$ENABLE_LOG_ENTRY_EXIT$$" == "ON"
    $$SHORTCODE$$.logExit(arguments);
    $endif

    return retVal;
};

$$SHORTCODE$$.logMessage = function(reportingFunctionArguments, message) {

    var savedInLogger = $$SHORTCODE$$.inLogger;

    do {
        try {

            if ($$SHORTCODE$$.inLogger) {
                break;
            }
            
            $$SHORTCODE$$.inLogger = true;
            
            var prefix = "";

            if (! message) {

                  message = reportingFunctionArguments;
                  reportingFunctionArguments = undefined;

            }
            else if (reportingFunctionArguments) {

                if ("string" == typeof reportingFunctionArguments) {

                    prefix += reportingFunctionArguments + ": ";
                    
                }
                else {

                    var reportingFunctionName;
                    try {
                        reportingFunctionName = reportingFunctionArguments.callee.toString().match(/function ([^\(]+)/)[1];
                    }
                    catch (err) {
                        reportingFunctionName = "[anonymous function]";
                    }
                    prefix += reportingFunctionName + ": ";

                }
            }
            
            var estkLogLine = prefix + message;
                    
            if ($$SHORTCODE$$.S.LOG_TO_ESTK_CONSOLE) {
                $.writeln(estkLogLine); 
            }

        }
        catch (err) {
        }
    }
    while (false);

    $$SHORTCODE$$.inLogger = savedInLogger;
}
