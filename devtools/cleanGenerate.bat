@ECHO OFF
REM
REM Undo the generation step. This will remove all your hard work.
REM Do not run this unless you're absolutely sure
REM

SET JSXP_DEV_TOOLS_DIR=%~dp0

PUSHD %JSXP_DEV_TOOLS_DIR%..
SET PROJECT_ROOT_DIR=%cd%\
POPD

SET JSXP_COMMANDS_DIR=%PROJECT_ROOT_DIR%Windows\

REM
REM Don't even try if the project has not been generated
REM
IF NOT EXIST "%PROJECT_ROOT_DIR%BuildSettings%" (
        ECHO.
        ECHO This project has not been configured yet - nothing to remove.
        ECHO Aborting.
        ECHO.
        EXIT /B
)

PUSHD "%PROJECT_ROOT_DIR%"

ECHO.
ECHO WARNING WARNING WARNING
ECHO.
ECHO This will irrevokably delete all generated files.
ECHO.
ECHO Type 'YES' at the prompt only if you're really sure
ECHO you want to do this.
ECHO.

SET /P REPLY=Delete generated files [YES/NO]?: 

if "%reply%" == "YES" (
    
    CALL Windows\clean.bat

    ECHO.
    ECHO Removing generated files
    ECHO.

    DEL run.jsx
    DEL "ReadMe for %SCRIPT_NAME%.md"
    RD /s /q BuildSettings >NUL 2>&1  
    RD /s /q jsx >NUL 2>&1
    RD /s /q shared_js_jsx >NUL 2>&1
    RD /s /q .vscode >NUL 2>&1
    RD /s /q VSCode >NUL 2>&1
    
)

POPD