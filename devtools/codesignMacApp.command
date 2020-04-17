export JSXP_DEV_TOOLS_DIR=`dirname "$0"`

pushd "$JSXP_DEV_TOOLS_DIR" > /dev/null

export JSXP_DEV_TOOLS_DIR=`pwd`

export PROJECT_ROOT_DIR=`dirname "$JSXP_DEV_TOOLS_DIR"`/

export sourceDir="${PROJECT_ROOT_DIR}ToolSources/JSXSparkerConfig/"
export entitlementsPlist="${sourceDir}JSXSparkerConfig.entitlements.plist"

export codeSignID=`head -n 1 macCodeSignID.txt`

cd "$PROJECT_ROOT_DIR/Mac"
find . -name ".DS_Store" | while read a; do rm "$a"; done
find . -name "__MACOSX" | while read a; do rm -rf "$a"; done
xattr -cr "JSXSparkerConfig.app"
codesign --timestamp --entitlements "$entitlementsPlist" -vvv --verbose --deep --force --sign "$codeSignID" "JSXSparkerConfig.app"
  
popd > /dev/null