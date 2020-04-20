#
# Remove all the JSXSparker templates and generation software
# so the project becomes stand-alone
#

export JSXP_DEV_TOOLS_DIR=`dirname "$0"`/

pushd "$JSXP_DEV_TOOLS_DIR" > /dev/null

export JSXP_DEV_TOOLS_DIR=`pwd`/

export PROJECT_ROOT_DIR=`dirname "$JSXP_DEV_TOOLS_DIR"`/

cd "$PROJECT_ROOT_DIR"

#
# Don't even try if the project has not been generated
#
if [ ! -d "./BuildSettings" ]; then

    echo ""
    echo "This is an unconfigured JSXSparker project."
    echo "Make sure to read the documentation and then run SparkerConfig as instructed."
    echo "Aborting."
    echo ""

else

    echo ""
    echo "This project will now stand on its own, and become independent of JSXSparker"
    echo "This operation will delete all templates files and JSXSparker configuration"
    echo "software, and detach the project from the JSXSparker git repo."
    echo ""
    echo "Type 'YES' at the prompt only if you're sure you want to do this."

    read reply

    if [ "$reply" == "YES" ]; then

        rm -rf .git  
        rm -f .gitignore
        rm -f ReadMe.md
        rm -rf $devtoolsDir
        rm -rf Templates
        rm -f Mac/initialSetupConfigApp.command
        rm -rf Mac/SparkerConfig.app
        rm -rf "Mac/ Do not forget to de-quarantine!.txt"
        rm -f Windows/SparkerConfig.exe
        rm -rf Windows/SparkerConfig\ Libs
        rm -rf "Windows/ Run CMD.exe then use command line.txt"

    fi

fi

popd > /dev/null