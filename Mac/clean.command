#
# Remove locally created or derived data and attempt to 
# bring the project back to a 'clean slate'.
#

if [ "$JSXP_COMMANDS_DIR" == "" -o ! -d "$JSXP_COMMANDS_DIR" ]; then
    export JSXP_COMMANDS_DIR=`dirname "$0"`/
fi

pushd "$JSXP_COMMANDS_DIR" > /dev/null

export JSXP_COMMANDS_DIR=`pwd`/

. setTarget.command

if [ "$TARGET_APP" == "Illustrator" ]; then

    # For Illustrator we don't use a link; instead we use a one-line stub script
    
    if [ -e "${TARGET_APP_SCRIPT_DIR}${DESPACED_TARGET_NAME}.jsx" ]; then

        echo ""
        echo "Removing Illustrator stub script ${TARGET_APP_SCRIPT_DIR}${DESPACED_TARGET_NAME}.jsx" 
        echo ""

        rm -f "${TARGET_APP_SCRIPT_DIR}${DESPACED_TARGET_NAME}.jsx"
    fi

else

    if [ -d "$TARGET_SCRIPT_ROOT_DIR" ]; then

        echo ""
        echo "Removing directory $TARGET_SCRIPT_ROOT_DIR"
        echo ""

        rm -rf "$TARGET_SCRIPT_ROOT_DIR"
    fi

fi

if [ "$BUILD_DIR" != "" -a -d "$BUILD_DIR" ]; then

    echo ""
    echo "Removing directory $BUILD_DIR"
    echo ""

    rm -rf "$BUILD_DIR"
fi

if [ "$NESTED" == "" ]; then
    echo ""
    echo "You can now close this Terminal window"
    echo ""
fi

popd > /dev/null
