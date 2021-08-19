#!/bin/bash
#by pudh

############################### Menjawab pertanyaan: How to supply sudo with password from script? (https://stackoverflow.com/questions/24892382/how-to-supply-sudo-with-password-from-script)
echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
###################################### Add user Ubuntu dan menghilangkan password root
adduser --disabled-password --gecos "" ubuntu
passwd -d root
apt-get update -y && apt-get install -y unzip
apt-get install zip -y
###################################### Chmod dan Chown
chown -R ubuntu vncsetup.sh && chmod +x vncsetup.sh
chown -R ubuntu vnc_unzip_server.txt && chmod +x vnc_unzip_server.txt
chown -R ubuntu vnc.sh  && chmod +x vnc.sh 
chown -R ubuntu mount.sh  && chmod +x mount.sh 
chown -R ubuntu dest_dir_list.txt  && chmod +x dest_dir_list.txt 
chown -R ubuntu source_dir_list.txt  && chmod +x source_dir_list.txt 
chown -R ubuntu zip_extract_forever.sh && chmod +x zip_extract_forever.sh
chown -R ubuntu rclone.conf && chmod +x rclone.conf 
####################################################################################################



############################### Add VNC PASSWORD, AGAR TIDAK SURUH MASUKIN PASS WAKTU INSTALL VNCSERVER
myuser="ubuntu"
mypasswd="Aa666666"

mkdir /home/$myuser/.vnc
echo $mypasswd | vncpasswd -f > /home/$myuser/.vnc/passwd
chown -R $myuser:$myuser /home/$myuser/.vnc
chmod 0600 /home/$myuser/.vnc/passwd
######################################################################################################
############################## Install Server
apt update && apt upgrade -y && apt install tightvncserver && apt install ubuntu-desktop && apt install gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal autocutsel xfwm4 gnome-flashback && apt install feh && sudo -u ubuntu ./vncsetup.sh

