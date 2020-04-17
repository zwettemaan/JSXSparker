@ECHO OFF

SETLOCAL EnableDelayedExpansion

REM
REM Setup the panel so we can run it in a live debug session 
REM

IF "%JSXP_COMMANDS_DIR%" == "" (
    SET JSXP_COMMANDS_DIR=%~dp0
)

PUSHD "%JSXP_COMMANDS_DIR%.."
SET PROJECT_ROOT_DIR=%cd%\
POPD

CALL setTarget.bat

PUSHD "%PROJECT_ROOT_DIR%"

IF EXIST "%TARGET_APP_SCRIPT_DIR%" (

    REM For Illustrator we don't use a link; instead we use a one-line stub script

    IF "%TARGET_APP%" == "Illustrator" (

        ECHO Starting an administrator shell to create an Illustrator stub script "%TARGET_APP_SCRIPT_DIR%%DESPACED_SCRIPT_NAME%.jsx"

        ECHO @ECHO OFF                                                                             > %TEMP%\sudocmd.bat
        ECHO ECHO Installing Illustrator stub script                                               >> %TEMP%\sudocmd.bat

        REM Get rid of trailing \ in TARGET_APP_SCRIPT_DIR by changing then using current directory

        ECHO CD %TARGET_APP_SCRIPT_DIR%                                                            >> %TEMP%\sudocmd.bat
        ECHO ICACLS . /GRANT BUILTIN\Users:F ^>NUL 2^>^&1                                          >> %TEMP%\sudocmd.bat 

        REM Need to escape backslashes in path

        Powershell -Command "echo (\"ECHO //@include \"\"%PROJECT_ROOT_DIR%run.jsx\"\" ^> \"\"%TARGET_APP_SCRIPT_DIR%%DESPACED_SCRIPT_NAME%.jsx\"\"\").Replace(\"\\\",\"\\\\\")" >> %TEMP%\sudocmd.bat 2> NUL

        ECHO ICACLS "%TARGET_APP_SCRIPT_DIR%%DESPACED_SCRIPT_NAME%.jsx" /GRANT BUILTIN\Users:F ^>NUL 2^>^&1 >> %TEMP%\sudocmd.bat
        ECHO ECHO Illustrator stub script installed as:                                            >> %TEMP%\sudocmd.bat
        ECHO ECHO     "%TARGET_APP_SCRIPT_DIR%%DESPACED_SCRIPT_NAME%.jsx"                                   >> %TEMP%\sudocmd.bat

        REM Launch administrative shell

        Powershell -Command "Start-Process cmd \"/k %TEMP%\sudocmd.bat\" -Verb RunAs"

    ) ELSE (

        ECHO Removing directory "%TARGET_SCRIPT_ROOT_DIR%"

        RD /s /q "%TARGET_SCRIPT_ROOT_DIR%" >NUL 2>&1

        ECHO Recreating directory "%TARGET_SCRIPT_ROOT_DIR%"

        MKDIR "%TARGET_SCRIPT_ROOT_DIR%"

        ECHO Creating temporary symbolic links to the script and its library folders directory "%TARGET_SCRIPT_ROOT_DIR%"

        MKLINK /H "%TARGET_SCRIPT_ROOT_DIR%run.jsx" "%PROJECT_ROOT_DIR%run.jsx"
        MKLINK /J "%TARGET_SCRIPT_ROOT_DIR%jsx" "%PROJECT_ROOT_DIR%jsx"
        MKLINK /J "%TARGET_SCRIPT_ROOT_DIR%shared_js_jsx" "%PROJECT_ROOT_DIR%shared_js_jsx"
    )

)

POPD
