#
# Create a distributable copy in the builds folder
#

if [ "$JSXP_COMMANDS_DIR" == "" -o ! -d "$JSXP_COMMANDS_DIR" ]; then
	export JSXP_COMMANDS_DIR=`dirname "$0"`/
fi

pushd "$JSXP_COMMANDS_DIR" > /dev/null

export JSXP_COMMANDS_DIR=`pwd`/

. setTarget.command

echo ""
echo Removing directory "$BUILD_DIR"
echo ""

rm -rf "$BUILD_DIR"

echo ""
echo Re-creating directory "$BUILD_DIR"
echo ""

mkdir "$BUILD_DIR"

echo ""
echo Creating directory "$BUILD_SCRIPT_ROOT_DIR"
echo ""

mkdir "$BUILD_SCRIPT_ROOT_DIR"

echo ""
echo Copying script files and readme file
echo ""

cp "${PROJECT_ROOT_DIR}run.jsx" "$BUILD_SCRIPT_ROOT_DIR"
cp "${PROJECT_ROOT_DIR}ReadMe for ${TARGET_NAME}.md" "$BUILD_SCRIPT_ROOT_DIR"
cp -R "${PROJECT_ROOT_DIR}jsx" "${BUILD_SCRIPT_ROOT_DIR}jsx"
cp -R "${PROJECT_ROOT_DIR}shared_js_jsx" "${BUILD_SCRIPT_ROOT_DIR}shared_js_jsx"

popd > /dev/null
