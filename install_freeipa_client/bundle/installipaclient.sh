#!/bin/bash

echo "Starting Instalation"
sleep 2

sudo apt update -y
sudo apt upgrade -y

random_string=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 10)

hostnamectl set-hostname $random_string.hwdomain.lan
sudo apt install freeipa-client

nohup zenity --info --text="add server realm CROCODOMAIN.LAN\n\nadd server domain ipa.crocodomain.lan  " > /dev/null 2>&1 &

sudo ipa-client-install --hostname=`hostname -f` \
--mkhomedir \
--server=ipa.hwdomain.lan \
--domain hwdomain.lan \
--realm HWDOMAIN.LAN

echo "Instalation Complate"
sleep 2

