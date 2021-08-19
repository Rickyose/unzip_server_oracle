#!/bin/bash
#by pudh


############################### Install rclone dan import config
curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && unzip rclone-current-linux-amd64.zip && cd rclone-*-linux-amd64 &&  cp rclone /usr/bin/ &&  chown root:root /usr/bin/rclone &&  chmod 755 /usr/bin/rclone &&  mkdir -p /usr/local/share/man/man1 &&  cp rclone.1 /usr/local/share/man/man1/ &&  mandb
mv -f rclone.conf /home/ubuntu/.config/rclone/
############################### Mkdir untuk gdrive zip source dan destination
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
cd /
cd gdrive1 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive2 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive3 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive4 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive5 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive6 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive7 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive8 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive9 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive10 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive11 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive12 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive13 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive14 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive15 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive16 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive17 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive18 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive19 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive20 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive31 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive32 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive33 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive34 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive35 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive36 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive37 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive38 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive39 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive40 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive41 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive42 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive43 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive44 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive45 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive46 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive47 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive48 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive49 && mkdir cha && mkdir temp
cd &&  cd /
cd gdrive50 && mkdir cha && mkdir temp
cd &&  cd /
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
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive1: /gdrive1 && chmod 777 gdrive1 && chown -R ubuntu /gdrive1 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive2: /gdrive2 && chmod 777 gdrive2 && chown -R ubuntu /gdrive2 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive3: /gdrive3 && chmod 777 gdrive3 && chown -R ubuntu /gdrive3 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive4: /gdrive4 && chmod 777 gdrive4 && chown -R ubuntu /gdrive4 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive5: /gdrive5 && chmod 777 gdrive5 && chown -R ubuntu /gdrive5 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive6: /gdrive6 && chmod 777 gdrive6 && chown -R ubuntu /gdrive6 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive7: /gdrive7 && chmod 777 gdrive7 && chown -R ubuntu /gdrive7 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive8: /gdrive8 && chmod 777 gdrive8 && chown -R ubuntu /gdrive8 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive9: /gdrive9 && chmod 777 gdrive9 && chown -R ubuntu /gdrive9 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive10: /gdrive10 && chmod 777 gdrive10 && chown -R ubuntu /gdrive10 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive11: /gdrive11 && chmod 777 gdrive11 && chown -R ubuntu /gdrive11 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive12: /gdrive12 && chmod 777 gdrive12 && chown -R ubuntu /gdrive12 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive13: /gdrive13 && chmod 777 gdrive13 && chown -R ubuntu /gdrive13 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive14: /gdrive14 && chmod 777 gdrive14 && chown -R ubuntu /gdrive14 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive15: /gdrive15 && chmod 777 gdrive15 && chown -R ubuntu /gdrive15 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive16: /gdrive16 && chmod 777 gdrive16 && chown -R ubuntu /gdrive16 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive17: /gdrive17 && chmod 777 gdrive17 && chown -R ubuntu /gdrive17 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive18: /gdrive18 && chmod 777 gdrive18 && chown -R ubuntu /gdrive18 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive19: /gdrive19 && chmod 777 gdrive19 && chown -R ubuntu /gdrive19 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive20: /gdrive20 && chmod 777 gdrive20 && chown -R ubuntu /gdrive20 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive31: /gdrive31 && chmod 777 gdrive31 && chown -R ubuntu /gdrive31 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive32: /gdrive32 && chmod 777 gdrive32 && chown -R ubuntu /gdrive32 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive33: /gdrive33 && chmod 777 gdrive33 && chown -R ubuntu /gdrive33 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive34: /gdrive34 && chmod 777 gdrive34 && chown -R ubuntu /gdrive34 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive35: /gdrive35 && chmod 777 gdrive35 && chown -R ubuntu /gdrive35 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive36: /gdrive36 && chmod 777 gdrive36 && chown -R ubuntu /gdrive36 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive37: /gdrive37 && chmod 777 gdrive37 && chown -R ubuntu /gdrive37 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive38: /gdrive38 && chmod 777 gdrive38 && chown -R ubuntu /gdrive38 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive39: /gdrive39 && chmod 777 gdrive39 && chown -R ubuntu /gdrive39 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive40: /gdrive40 && chmod 777 gdrive40 && chown -R ubuntu /gdrive40 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive41: /gdrive41 && chmod 777 gdrive41 && chown -R ubuntu /gdrive41 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive42: /gdrive42 && chmod 777 gdrive42 && chown -R ubuntu /gdrive42 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive43: /gdrive43 && chmod 777 gdrive43 && chown -R ubuntu /gdrive43 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive44: /gdrive44 && chmod 777 gdrive44 && chown -R ubuntu /gdrive44 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive45: /gdrive45 && chmod 777 gdrive45 && chown -R ubuntu /gdrive45 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive46: /gdrive46 && chmod 777 gdrive46 && chown -R ubuntu /gdrive46 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive47: /gdrive47 && chmod 777 gdrive47 && chown -R ubuntu /gdrive47 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive48: /gdrive48 && chmod 777 gdrive48 && chown -R ubuntu /gdrive48 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive49: /gdrive49 && chmod 777 gdrive49 && chown -R ubuntu /gdrive49 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive50: /gdrive50 && chmod 777 gdrive50 && chown -R ubuntu /gdrive50 & sleep 5
############################### Menjawab pertanyaan: How to supply sudo with password from script? (https://stackoverflow.com/questions/24892382/how-to-supply-sudo-with-password-from-script)
echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
###################################### Add user Ubuntu dan menghilangkan password root
adduser --disabled-password --gecos "" ubuntu
passwd -d root
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

