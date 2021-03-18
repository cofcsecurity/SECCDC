#!/usr/bin/env bash

pwfile="/etc/passwd"
shadowfile="/etc/shadow"
groupfile="/etc/group"
homedir="/home"

if [ "$(id -un)" != "root" ]; then

    echo "You must be root to run this script!"
    exit 1

fi 

echo "Add new user account to $(hostname)"
echo "login: "; read login

uid="$(awk -F: '{if (big < $3 && $3 < 5000) big = $3} END {print big + 1 }' $pwfile)"

home=$homedir/$login
gid=$uid

echo "Full name: "; read name
echo "Shell: " ; read shell

echo "Setting up account $login for $name"

echo ${login}:x:${uid}:${gid}:${name}:${home}:$shell >> $pwfile
echo ${login}:x:*:11647:0:99999:7::: >> $shadowfile
echo ${login}:x:${gid}::$login >> $groupfile

mkdir $home 
cp -R /etc/skel/.bashrc $home
chmod 775 $home
chown -R ${login}:${login} $home

exec passwd $login