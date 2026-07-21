#!/bin/bash


sudo apt -y install dmidecode # install dmidecode, needed to determine BIOS year

# Set a variable to check for the BIOS year
BIOSYEAR=$(sudo dmidecode -t bios | grep "Release Date" | grep -oE '[0-9]{4}') # grab the bios year for fwupd


# If the BIOS is 2015 or later try to refresh and update the BIOS
if [ "$BIOSYEAR" -lt 2015 ]; then # older than 2015
    echo "The BIOS is older than 2015 (Year: $BIOSYEAR)"
else
    echo "The BIOS is from 2015 or newer (Year: $BIOSYEAR) so trying to do any firmware updates"
    fwupdmgr refresh
    fwupdmgr get-updates
    fwupdmgr update
fi
