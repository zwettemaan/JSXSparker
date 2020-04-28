@ECHO OFF
REM
REM Remove locally created, compiled or derived data and attempt to 
REM bring the project back to a 'clean slate'.
REM

IF "%JSXP_COMMANDS_DIR%" == "" (
    SET JSXP_COMMANDS_DIR=%~dp0
)

PUSHD "%JSXP_COMMANDS_DIR%.."
SET PROJECT_ROOT_DIR=%cd%\
POPD

CALL "%JSXP_COMMANDS_DIR%setTarget.bat"

PUSHD "%PROJECT_ROOT_DIR%"

IF NOT "%TARGET_SCRIPT_ROOT_DIR%" == "" (   

    IF "%TARGET_APP%" == "Illustrator" (

        REM For Illustrator we don't use a link; instead we use a one-line stub script

        IF EXIST "%TARGET_APP_SCRIPT_DIR%%DESPACED_TARGET_NAME%.jsx" (

            ECHO.
            ECHO Removing Illustrator stub script "%TARGET_APP_SCRIPT_DIR%%DESPACED_TARGET_NAME%.jsx" 
            ECHO.

            DEL "%TARGET_APP_SCRIPT_DIR%%DESPACED_TARGET_NAME%.jsx"
        )
        
    ) ELSE (

        IF EXIST "%TARGET_SCRIPT_ROOT_DIR%" (

            ECHO.
            ECHO Removing directory "%TARGET_SCRIPT_ROOT_DIR%"
            ECHO.

            RD /s /q "%TARGET_SCRIPT_ROOT_DIR%" >NUL 2>&1
        )
    )
    
)

IF NOT "%BUILD_DIR%" == "" (    
    
    IF EXIST "%BUILD_DIR%" (
        
        ECHO.
        ECHO Removing directory "%BUILD_DIR%"
        ECHO.

        RD /s /q "%BUILD_DIR%" >NUL 2>&1
    )
)

POPD

IF NOT "%1" == "NESTED" (
    
    ECHO.
    ECHO Project is now clean
    ECHO.

    SET /P REPLY=Press [Enter] to finalize 
)
