#!/bin/bash

set -e

docker_script="./bundle/installdocker.sh"
freeipa_script="./bundle/installfreeipa.sh"

echo "Installation Started"
sleep 2

# Check if Docker is already installed
if command -v docker &> /dev/null; then
    echo "Docker is already installed. Skipping Docker installation."
else
    echo "Installing Docker..."
    sudo sh "$docker_script"
    echo "Docker installation complete."
fi

# Proceed with FreeIPA installation
echo "Installing FreeIPA..."
sudo sh "$freeipa_script"
echo "FreeIPA installation complete."

echo "Installation complete"
sleep 2

