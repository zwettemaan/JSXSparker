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

ECHO Removing directory "%BUILD_DIR%"

RD /S /Q "%BUILD_DIR%" >NUL 2>&1

ECHO Re-creating directory "%BUILD_DIR%"

MKDIR "%BUILD_DIR%"

SET BUILD_SCRIPT_ROOT_DIR=%BUILD_DIR%%TARGET_DIRNAME%\

ECHO Creating directory "%BUILD_SCRIPT_ROOT_DIR%"

MKDIR "%BUILD_SCRIPT_ROOT_DIR%"

ECHO Copying script files and readme file to "%BUILD_SCRIPT_ROOT_DIR%"

COPY run.jsx "%BUILD_SCRIPT_ROOT_DIR%" >NUL 2>&1
COPY "%PROJECT_ROOT_DIR%ReadMe for %TARGET_NAME%.md" "%BUILD_SCRIPT_ROOT_DIR%" >NUL 2>&1

XCOPY /S/Q helpers "%BUILD_SCRIPT_ROOT_DIR%helpers\" >NUL 2>&1

POPD

SET /P REPLY=Press [Enter] to finalize 
