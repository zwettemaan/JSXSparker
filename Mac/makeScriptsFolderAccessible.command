#
# Illustrator's scripts folder is a 'system administered' folder
# This script tests for that, and makes it accessible if not
#

export myGroup=`id -g -n`
export fileGroup=`stat -f "%Sg" "$1"`
export filePermissions=`stat -f %A "$1"`

if [ "$myGroup" != "staff" ]; then
    echo "You need to have a user account with administrative permissions"
    echo "Nothing was changed. Aborting"
    exit
fi

export needPassword="YES"
sudo --reset-timestamp

if [ "$fileGroup" != "staff" ]; then
    if [ "$needPassword" == "YES" ]; then
        echo 'Enter your user password for this Mac:'
        export needPassword="NO"
    fi
    sudo chgrp -R staff "$1"
fi

if [ "$filePermissions" == "755" ]; then
    if [ "$needPassword" == "YES" ]; then
        echo 'Enter your user password for this Mac:'
        export needPassword="NO"
    fi
    sudo chmod -R 775 "$1"
elif [ "$filePermissions" != "775" ]; then
    echo "File permissions are not 755 as expected. Nothing was changed. You'll need"
    echo "to check and change them to 775 manually"
fi
