#
# Undo the generation step. This will remove all your hard work.
# Do not run this unless you're absolutely sure
#

export JSXP_DEV_TOOLS_DIR=`dirname "$0"`

pushd "$JSXP_DEV_TOOLS_DIR" > /dev/null

export JSXP_DEV_TOOLS_DIR=`pwd`/

export PROJECT_ROOT_DIR=`dirname "$JSXP_DEV_TOOLS_DIR"`/

export JSXP_COMMANDS_DIR="${PROJECT_ROOT_DIR}Mac/"

#
# Don't even try if the project has not been generated
#
if [ ! -d "${PROJECT_ROOT_DIR}BuildSettings" ]; then

    echo ""
    echo "This project has not been configured yet - nothing to remove."
    echo "Aborting."
    echo ""
    exit

else

    echo ""
    echo "***  WARNING WARNING WARNING  ***"
    echo ""
    echo "This will irrevokably delete all generated files."
    echo ""
    echo "Type 'YES' at the prompt only if you're really sure"
    echo "you want to do this."

    read reply

    if [ "$reply" == "YES" ]; then

        cd "$PROJECT_ROOT_DIR"

        export NESTED="1"
        Mac/clean.command
        export NESTED=""

        . Mac/setTarget.command

        echo ""
        echo "Removing generated files"
        echo ""
        
        rm -f "$DESPACED_TARGET_NAME.$TARGET_FILENAME_EXTENSION"
        rm -f "$DESPACED_TARGET_NAME.htm"
        rm -f "ReadMe for $DESPACED_TARGET_NAME.md"
        rm -rf ${DESPACED_TARGET_NAME}_helpers
        rm -rf BuildSettings
        rm -rf .vscode
        rm -rf VSCode

        echo ""
        echo "This project has been reset to an unconfigured, blank state."
        echo ""
        
    fi

fi

echo ""
echo "You can now close this Terminal window"
echo ""

popd > /dev/null