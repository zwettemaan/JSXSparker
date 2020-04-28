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

    IF "%TARGET_APP%" == "Bridge" (
        CD "%PROJECT_ROOT_DIR%"
        ECHO.
        ECHO Double-click the run.jsx script in the Bridge wiundow
        ECHO.
        "%TARGET_APP_SCRIPT_DIR%Bridge.exe" "%cd%"
    ) ELSE IF "%TARGET_APP%" == "Illustrator" (

        REM For Illustrator we don't use a link; instead we use a one-line stub script

        ECHO.
        ECHO Starting an administrator shell to create an Illustrator stub script "%TARGET_APP_SCRIPT_DIR%%DESPACED_TARGET_NAME%.jsx"
        ECHO.

        ECHO @ECHO OFF > %TEMP%\sudocmd.bat
        ECHO ECHO. >> %TEMP%\sudocmd.bat
        ECHO ECHO Installing Illustrator stub script by way of a separate administrative shell >> %TEMP%\sudocmd.bat
        ECHO ECHO. >> %TEMP%\sudocmd.bat

        REM Get rid of trailing \ in TARGET_APP_SCRIPT_DIR by changing then using current directory

        ECHO CD %TARGET_APP_SCRIPT_DIR% >> %TEMP%\sudocmd.bat
        ECHO ICACLS . /GRANT BUILTIN\Users:F ^>NUL 2^>^&1 >> %TEMP%\sudocmd.bat 

        REM Need to escape backslashes in path

        Powershell -Command "echo (\"ECHO //@include \"\"%PROJECT_ROOT_DIR%run.jsx\"\" ^> \"\"%TARGET_APP_SCRIPT_DIR%%DESPACED_TARGET_NAME%.jsx\"\"\").Replace(\"\\\",\"\\\\\")" >> %TEMP%\sudocmd.bat 2> NUL

        ECHO ICACLS "%TARGET_APP_SCRIPT_DIR%%DESPACED_TARGET_NAME%.jsx" /GRANT BUILTIN\Users:F ^>NUL 2^>^&1 >> %TEMP%\sudocmd.bat
        ECHO ECHO. >> %TEMP%\sudocmd.bat
        ECHO ECHO Illustrator stub script installed as: >> %TEMP%\sudocmd.bat
        ECHO ECHO     "%TARGET_APP_SCRIPT_DIR%%DESPACED_TARGET_NAME%.jsx" >> %TEMP%\sudocmd.bat
        ECHO ECHO. >> %TEMP%\sudocmd.bat
        ECHO ECHO You can close this administrative shell window now >> %TEMP%\sudocmd.bat
        ECHO ECHO. >> %TEMP%\sudocmd.bat
        ECHO ECHO Debug install done. >> %TEMP%\sudocmd.bat
        ECHO ECHO. >> %TEMP%\sudocmd.bat

        REM Launch administrative shell

        Powershell -Command "Start-Process cmd \"/k %TEMP%\sudocmd.bat\" -Verb RunAs"

    ) ELSE (

        ECHO.
        ECHO Removing directory "%TARGET_SCRIPT_ROOT_DIR%"
        ECHO.

        RD /s /q "%TARGET_SCRIPT_ROOT_DIR%" >NUL 2>&1

        ECHO.
        ECHO Recreating directory "%TARGET_SCRIPT_ROOT_DIR%"
        ECHO.

        MKDIR "%TARGET_SCRIPT_ROOT_DIR%"

        ECHO.
        ECHO Creating temporary symbolic links to the script and its 'helpers' directory inside directory "%TARGET_SCRIPT_ROOT_DIR%"
        ECHO.

        MKLINK /H "%TARGET_SCRIPT_ROOT_DIR%run.jsx" "%PROJECT_ROOT_DIR%run.jsx"
        MKLINK /J "%TARGET_SCRIPT_ROOT_DIR%helpers" "%PROJECT_ROOT_DIR%helpers"

        ECHO.
        ECHO Debug install done.
        ECHO.
    )

)

POPD

ECHO.
SET /P REPLY=Press [Enter] to finalize 
