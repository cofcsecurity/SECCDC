#!/bin/bash

homeDir="/home"
secs=10 # seconds before suspension

if [ -z = $1 ]; then
    echo "Usage: $0 account" >&2
    exit 1

elif [ "$(id -un)" != "root" ]; then 
    echo "Error: script must be run as root"
    exit 1

fi

echo "Please change the password to $1 to something new"
passwd $1

if who | grep "$1" > /dev/null; then
    
    for tty in $(who | grep $1 | awk '{print $2}'); do 
        cat << "EOF" > /dev/$tty

********************************************************************************
URGENT NOTICE FROM THE ADMIN:

This account has been suspended in $secs seconds. Please contact the System 
Administrator or your Supervisor if there are any questions.

********************************************************************************

EOF

    done

    echo "(Warned $1, now sleeping for $secs)"

    jobs=$(ps -u $1 | cut -d\  -f1)
    
    kill -s HUP $jobs
    sleep 1
    kill -s KILL $jobs > /dev/null 2>1 

    echo "$1 was logged in. Just logged them out"

fi 

chmod 000 $homeDir/$1

echo "Account $1 has been suspended"

exit 0