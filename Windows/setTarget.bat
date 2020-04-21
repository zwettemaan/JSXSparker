@ECHO OFF
REM
REM Set up a bunch of environment variables
REM

IF "%JSXP_COMMANDS_DIR%" == "" (
    SET JSXP_COMMANDS_DIR=%~dp0
)

PUSHD "%JSXP_COMMANDS_DIR%.."
SET PROJECT_ROOT_DIR=%cd%\
POPD

SET BUILD_SETTINGS_DIR=%PROJECT_ROOT_DIR%BuildSettings\
SET BUILD_DIR=%PROJECT_ROOT_DIR%build\

IF NOT EXIST "%BUILD_SETTINGS_DIR%configSettings.bat" (
    ECHO.
    ECHO Run the SparkerConfig first - this project has not been configured.
    ECHO.
    EXIT /B
) 

CALL "%BUILD_SETTINGS_DIR%configSettings.bat"
CALL "%BUILD_SETTINGS_DIR%buildSettings.bat"

SET TARGET_SCRIPT_ROOT_DIR=
IF "%TARGET_APP_SCRIPT_DIR%" == "" (
    ECHO Error: empty TARGET_APP_SCRIPT_DIR.
) ELSE IF "%TARGET_DIRNAME%" == "" (
    ECHO Error: empty TARGET_DIRNAME.
) ELSE (
    SET TARGET_SCRIPT_ROOT_DIR=%TARGET_APP_SCRIPT_DIR%%TARGET_DIRNAME%\
)

