#!/usr/bin/bash

if ["$(id - u)" -ne 0]; then
    echo "inventory.sh run fail"
    exit 1
fi


echo -n "OS: " 
cat /etc/os-release | grep "NAME" | grep -o "\"[a-zA-Z]*\"" | grep -o "[a-zA-Z]*"

echo -n "Version " 
cat /etc/os-release | grep "VERSION=" | grep -o "\".*\"" | grep -o "[^\"]*"

echo -n "Hostname: "
hostname
