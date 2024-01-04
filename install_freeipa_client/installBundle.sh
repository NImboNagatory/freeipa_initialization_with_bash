#!/bin/bash

ipaclient_script="./bundle/installipaclient.sh"

# Check if IPA client is not installed
if ! command -v ipa &> /dev/null; then
    # If not installed, execute the installation script
    sudo sh "$ipaclient_script"
    echo "IPA client installed successfully."
fi

