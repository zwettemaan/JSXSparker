@ECHO OFF
REM
REM Create a distributable copy in the builds folder
REM

IF "%JSXP_COMMANDS_DIR%" == "" (
    SET JSXP_COMMANDS_DIR=%~dp0
)

PUSHD "%JSXP_COMMANDS_DIR%.."
SET PROJECT_ROOT_DIR=%cd%\
POPD

CALL "%JSXP_COMMANDS_DIR%setTarget.bat"

PUSHD "%PROJECT_ROOT_DIR%"

ECHO.
ECHO Removing directory "%BUILD_DIR%"
ECHO.

RD /S /Q "%BUILD_DIR%" >NUL 2>&1

ECHO.
ECHO Re-creating directory "%BUILD_DIR%"
ECHO.

MKDIR "%BUILD_DIR%"

SET BUILD_SCRIPT_ROOT_DIR=%BUILD_DIR%%TARGET_DIRNAME%\

ECHO.
ECHO Creating directory "%BUILD_SCRIPT_ROOT_DIR%"
ECHO.

MKDIR "%BUILD_SCRIPT_ROOT_DIR%"

ECHO.
ECHO Copying script files and readme file to "%BUILD_SCRIPT_ROOT_DIR%"
ECHO.

COPY run.jsx "%BUILD_SCRIPT_ROOT_DIR%" >NUL 2>&1
COPY "%PROJECT_ROOT_DIR%ReadMe for %TARGET_NAME%.md" "%BUILD_SCRIPT_ROOT_DIR%" >NUL 2>&1

XCOPY /S/Q helpers "%BUILD_SCRIPT_ROOT_DIR%helpers\" >NUL 2>&1

Powershell -Command "Compress-Archive -Path '%BUILD_DIR%%TARGET_DIRNAME%' -DestinationPath '%BUILD_DIR%%TARGET_DIRNAME%.zip'"
RD /S /Q "%BUILD_DIR%%TARGET_DIRNAME%" >NUL 2>&1

POPD

ECHO.
SET /P REPLY=Press [Enter] to finalize 
