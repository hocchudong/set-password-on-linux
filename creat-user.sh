#!/bin/bash
# Script to add a user to Linux system
if [ $(id -u) -eq 0 ]; then
        read -p "Enter username : " username
        egrep "^$username" /etc/passwd >/dev/null
        if [ $? -eq 0 ]; then
                echo "$username exists!"
                exit 1
        else
                pa=`openssl rand -hex 10`
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $pa)
                useradd -m -p $pass $username
                [ $? -eq 0 ] && echo "User has been added to system!" && echo "mat khau: $pa" || echo "Failed to add a user!"
        fi
else
        echo "Only root may add a user to the system"
        exit 2
fi
