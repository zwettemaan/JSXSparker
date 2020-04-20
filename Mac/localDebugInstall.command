#
# Setup the script to run from the application without making a copy
# of the script
#

if [ "$JSXP_COMMANDS_DIR" == "" -o ! -d "$JSXP_COMMANDS_DIR" ]; then
    export JSXP_COMMANDS_DIR=`dirname "$0"`/
fi

pushd "$JSXP_COMMANDS_DIR" > /dev/null

export JSXP_COMMANDS_DIR=`pwd`/

. setTarget.command

if [ -d "$TARGET_APP_SCRIPT_DIR" ]; then

    # For Illustrator we don't use a link; instead we use a one-line stub script

    if [ "$TARGET_APP" == "Illustrator" ]; then

        echo ""
        echo "Installing Illustrator stub script ${TARGET_APP_SCRIPT_DIR}${DESPACED_TARGET_NAME}.jsx" 
        echo ""

        echo "//@include \"${PROJECT_ROOT_DIR}run.jsx\"" > "${TARGET_APP_SCRIPT_DIR}${DESPACED_TARGET_NAME}.jsx"

    else 

        echo ""
        echo "Removing $TARGET_SCRIPT_ROOT_DIR" 
        echo ""

        rm -rf "$TARGET_SCRIPT_ROOT_DIR"

        echo ""
        echo "Re-creating $TARGET_SCRIPT_ROOT_DIR" 
        echo ""

        mkdir "$TARGET_SCRIPT_ROOT_DIR"

        echo ""
        echo "Creating temporary symbolic links to the script and its library folders in directory $TARGET_SCRIPT_ROOT_DIR"
        echo ""

        ln -s "${PROJECT_ROOT_DIR}run.jsx" "${TARGET_SCRIPT_ROOT_DIR}run.jsx"
        ln -s "${PROJECT_ROOT_DIR}jsx" "${TARGET_SCRIPT_ROOT_DIR}jsx"
        ln -s "${PROJECT_ROOT_DIR}shared_js_jsx" "${TARGET_SCRIPT_ROOT_DIR}shared_js_jsx"
        
    fi

fi

popd > /dev/null
