#
# Extract meta-info from BuildSettings folder and define a bunch of
# environment variables based on the retrieved info.
#

if [ "$JSXP_COMMANDS_DIR" == "" -o ! -d "$JSXP_COMMANDS_DIR" ]; then
        export JSXP_COMMANDS_DIR=`dirname "$0"`/
fi

pushd "$JSXP_COMMANDS_DIR" > /dev/null

export JSXP_COMMANDS_DIR=`pwd`/

export PROJECT_ROOT_DIR=`dirname "$JSXP_COMMANDS_DIR"`/

export USER_HOME_DIR=~/

#
# Don't even try if the project has not been generated
#
if [ ! -e "${PROJECT_ROOT_DIR}BuildSettings/configSettings.command" ]; then

    echo ""
    echo "Run the SparkerConfig first - this project has not been configured."
    echo ""
    exit

fi

export EXTENSION_DIR="${USER_HOME_DIR}Library/Application Support/Adobe/CEP/extensions/"
export SCRIPT_RUNNER_NAME="Rorohiko Script Runner"
export TEMP_SCRIPT_RUNNER_NAME="${SCRIPT_RUNNER_NAME}_JSXSparker_DEBUG"
export DOCUMENTS_DIR="${USER_HOME_DIR}Documents/"
export ADOBE_SCRIPTS_DIR="${DOCUMENTS_DIR}Adobe Scripts"

export BUILD_SETTINGS_DIR="${PROJECT_ROOT_DIR}BuildSettings/"
export BUILD_DIR="${PROJECT_ROOT_DIR}build/"

. "$BUILD_SETTINGS_DIR/configSettings.command"
. "$BUILD_SETTINGS_DIR/buildSettings.command"

if [ "$TARGET_APP" == "Illustrator" ]; then
    "${JSXP_COMMANDS_DIR}makeScriptsFolderAccessible.command" "$TARGET_APP_SCRIPT_DIR"
fi

if [ "$TARGET_APP" == "Photoshop" ]; then
    "${JSXP_COMMANDS_DIR}makeScriptsFolderAccessible.command" "$TARGET_APP_SCRIPT_DIR"
fi

if [ "$TARGET_APP" == "Dreamweaver" ]; then
    "${JSXP_COMMANDS_DIR}makeScriptsFolderAccessible.command" "$TARGET_APP_SCRIPT_DIR"
fi

if [ "$TARGET_APP_SCRIPT_DIR" != "" -a "$TARGET_DIRNAME" != "" ]; then

    export TARGET_SCRIPT_ROOT_DIR="${TARGET_APP_SCRIPT_DIR}${TARGET_DIRNAME}/"

fi

popd > /dev/null
