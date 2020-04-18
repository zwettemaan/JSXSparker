#
# De-quarantine the configuration app
#

if [ "$JSXP_COMMANDS_DIR" == "" -o ! -d "$JSXP_COMMANDS_DIR" ]; then
	export JSXP_COMMANDS_DIR=`dirname "$0"`/
fi

pushd "$JSXP_COMMANDS_DIR" > /dev/null

export JSXP_COMMANDS_DIR=`pwd`/

xattr -dr com.apple.quarantine JSXSparkerConfig.app
xattr -dr com.apple.quarantine *.command

cd ../devtools

xattr -dr com.apple.quarantine *.command

echo ""
echo '*.command scripts and JSXSparkerConfig.app are now de-quarantined.'
echo ""

popd > /dev/null
