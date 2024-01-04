#!/bin/bash

sudo aa-complain /etc/apparmor.d/* 
sudo service apparmor reload

sleep 5


sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove
sudo apt update

sudo hostnamectl set-hostname ipa.hwdomain.lan

docker_ip=$(sudo ifconfig docker0 | awk '/inet / {print $2}')

if ! grep -qF "$docker_ip" /etc/hosts; then
    # Append the entry to /etc/hosts
    echo "$docker_ip" | sudo tee -a /etc/hosts > /dev/null
fi


sudo timedatectl set-timezone Asia/Tbilisi

sudo unlink /etc/localtime
sudo ln -s /usr/share/timezone/Asia/Tbilisi /etc/localtime

sudo apt install git

sudo git clone https://github.com/freeipa/freeipa-container.git



sudo chown root:docker /var/run/docker.sock

echo '{"userns-remap": "default"}' | sudo tee /etc/docker/daemon.json > /dev/null

sudo systemctl restart docker

sleep 10

sudo bash -c 'cd freeipa-container && sudo docker build -t freeipa-almalinux9 -f Dockerfile.almalinux-9 .'

sudo mkdir -p /var/lib/freeipa-data

sudo lsof -i :53

# Stop the existing container if it's running
sudo docker stop freeipa-server-almalinux9

# Remove the existing container
sudo docker rm freeipa-server-almalinux9


sudo docker run --name freeipa-server-almalinux9 -ti \
    -h ipa.hwdomain.lan --read-only --sysctl net.ipv6.conf.all.disable_ipv6=0 \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    -v /var/lib/freeipa-data:/data:Z freeipa-almalinux9
    
    
    
sudo docker stop freeipa-server-almalinux9
sudo docker rm freeipa-server-almalinux9

sleep 2  
    

gnome-terminal --title="FreeIPA Container" -- sudo docker run --name freeipa-server-almalinux9 -ti \
-h ipa.crocodomain.lan -p 54:54/udp -p 54:54 -p 80:80 -p 443:443 -p 389:389 -p 636:636 -p 88:88 -p 464:464 -p 88:88/udp -p 464:464/udp -p 123:123/udp \
--read-only --sysctl net.ipv6.conf.all.disable_ipv6=0 freeipa-almalinux9


zenity --warning --text="Press ok after you see that free ipa server is configured"
    
sudo docker stop freeipa-server-almalinux9
sudo docker start freeipa-server-almalinux9  


echo "In few seconds the installation will start. just copy and paste. there are 3 steps with it corresponding kaywords"

sleep 5

nohup zenity --info --text="first input: HWDOMAIN.LAN \n\nsecond input: ipa.hwdomain.lan \n\nthird input: ipa.hwdomain.lan" > /dev/null 2>&1 &

sudo apt install krb5-user

sudo kinit admin

sudo apt install wmctrl

def_browser = xdg-settings get default-web-browser

xdg-open  https://ipa.hwdomain.lan/ && wmctrl -a "$def_browser"

docker exec -it freeipa-server-almalinux9 /bin/bash

ipa config-mod --defaultshell=/bin/bash

ipa user-add ubuntu --first=Ubuntu --last=Linux --password


ipa group-add --desc='Development Team' development
ipa group-find developmen
ipa group-add-member --user=ubuntu development

    
sudo aa-enforce /etc/apparmor.d/*
sudo service apparmor restart

