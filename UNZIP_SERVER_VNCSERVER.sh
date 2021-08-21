#!/bin/bash
#by pudh

############################### Menjawab pertanyaan: How to supply sudo with password from script? (https://stackoverflow.com/questions/24892382/how-to-supply-sudo-with-password-from-script)
echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
###################################### Add user Ubuntu dan menghilangkan password root
adduser --disabled-password --gecos "" ubuntu
echo 'ubuntu:Duri8490' | sudo chpasswd
############################## Install Server
apt update && apt upgrade -y && apt install tightvncserver -y && apt install ubuntu-desktop -y  && apt install gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal autocutsel xfwm4 gnome-flashback -y && apt install feh -y
apt-get install -y unzip
apt-get install zip -y
apt-get install -y ifstat
###################################### Chmod dan Chown
chown -R ubuntu vncsetup.sh && chmod +x vncsetup.sh
chown -R ubuntu vnc_unzip_server.txt && chmod +x vnc_unzip_server.txt
chown -R ubuntu vnc.sh  && chmod +x vnc.sh 
chown -R ubuntu mount.sh  && chmod +x mount.sh 
chown -R ubuntu dest_dir_list.txt  && chmod +x dest_dir_list.txt 
chown -R ubuntu source_dir_list.txt  && chmod +x source_dir_list.txt 
chown -R ubuntu zip_extract_forever.sh && chmod +x zip_extract_forever.sh
chown -R ubuntu rclone.conf && chmod +x rclone.conf
chown -R ubuntu start_vnc.sh && chmod +x start_vnc.sh
cp -r /root/unzip_server/ /home/ubuntu/
chown -R ubuntu /home/ubuntu/unzip_server
chown -R ubuntu /var/
####################################################################################################
cd /
mkdir gdrive1
mkdir gdrive2
mkdir gdrive3
mkdir gdrive4
mkdir gdrive5
mkdir gdrive6
mkdir gdrive7
mkdir gdrive8
mkdir gdrive9
mkdir gdrive10
mkdir gdrive11
mkdir gdrive12
mkdir gdrive13
mkdir gdrive14
mkdir gdrive15
mkdir gdrive16
mkdir gdrive17
mkdir gdrive18
mkdir gdrive19
mkdir gdrive20
mkdir gdrive21
mkdir gdrive22
mkdir gdrive23
mkdir gdrive24
mkdir gdrive25
mkdir gdrive26
mkdir gdrive27
mkdir gdrive28
mkdir gdrive29
mkdir gdrive30
mkdir gdrive31
mkdir gdrive32
mkdir gdrive33
mkdir gdrive34
mkdir gdrive35
mkdir gdrive36
mkdir gdrive37
mkdir gdrive38
mkdir gdrive39
mkdir gdrive40
mkdir gdrive41
mkdir gdrive42
mkdir gdrive43
mkdir gdrive44
mkdir gdrive45
mkdir gdrive46
mkdir gdrive47
mkdir gdrive48
mkdir gdrive49
mkdir gdrive50
sudo -u root chown -R ubuntu /gdrive1
sudo -u root chown -R ubuntu /gdrive2
sudo -u root chown -R ubuntu /gdrive3
sudo -u root chown -R ubuntu /gdrive4
sudo -u root chown -R ubuntu /gdrive5
sudo -u root chown -R ubuntu /gdrive6
sudo -u root chown -R ubuntu /gdrive7
sudo -u root chown -R ubuntu /gdrive8
sudo -u root chown -R ubuntu /gdrive9
sudo -u root chown -R ubuntu /gdrive10
sudo -u root chown -R ubuntu /gdrive11
sudo -u root chown -R ubuntu /gdrive12
sudo -u root chown -R ubuntu /gdrive13
sudo -u root chown -R ubuntu /gdrive14
sudo -u root chown -R ubuntu /gdrive15
sudo -u root chown -R ubuntu /gdrive16
sudo -u root chown -R ubuntu /gdrive17
sudo -u root chown -R ubuntu /gdrive18
sudo -u root chown -R ubuntu /gdrive19
sudo -u root chown -R ubuntu /gdrive20
sudo -u root chown -R ubuntu /gdrive21
sudo -u root chown -R ubuntu /gdrive22
sudo -u root chown -R ubuntu /gdrive23
sudo -u root chown -R ubuntu /gdrive24
sudo -u root chown -R ubuntu /gdrive25
sudo -u root chown -R ubuntu /gdrive26
sudo -u root chown -R ubuntu /gdrive27
sudo -u root chown -R ubuntu /gdrive28
sudo -u root chown -R ubuntu /gdrive29
sudo -u root chown -R ubuntu /gdrive30
sudo -u root chown -R ubuntu /gdrive31
sudo -u root chown -R ubuntu /gdrive32
sudo -u root chown -R ubuntu /gdrive33
sudo -u root chown -R ubuntu /gdrive34
sudo -u root chown -R ubuntu /gdrive35
sudo -u root chown -R ubuntu /gdrive36
sudo -u root chown -R ubuntu /gdrive37
sudo -u root chown -R ubuntu /gdrive38
sudo -u root chown -R ubuntu /gdrive39
sudo -u root chown -R ubuntu /gdrive40
sudo -u root chown -R ubuntu /gdrive41
sudo -u root chown -R ubuntu /gdrive42
sudo -u root chown -R ubuntu /gdrive43
sudo -u root chown -R ubuntu /gdrive44
sudo -u root chown -R ubuntu /gdrive45
sudo -u root chown -R ubuntu /gdrive46
sudo -u root chown -R ubuntu /gdrive47
sudo -u root chown -R ubuntu /gdrive48
sudo -u root chown -R ubuntu /gdrive49
sudo -u root chown -R ubuntu /gdrive50
############################### Add VNC PASSWORD, AGAR TIDAK SURUH MASUKIN PASS WAKTU INSTALL VNCSERVER
myuser="ubuntu"
mypasswd="Aa666666"

mkdir /home/$myuser/.vnc
echo $mypasswd | vncpasswd -f > /home/$myuser/.vnc/passwd
chown -R $myuser:$myuser /home/$myuser/.vnc
chmod 0600 /home/$myuser/.vnc/passwd
######################################################################################################
cd /root/unzip_server/
sudo -u ubuntu ./vncsetup.sh &
