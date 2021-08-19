#!/bin/bash
#by pudh

###################################### Chmod dan Chown
cd /home/ubuntu/unzip_server
chown -R ubuntu vncsetup.sh && chmod +x vncsetup.sh
chown -R ubuntu vnc_unzip_server.txt && chmod +x vnc_unzip_server.txt
chown -R ubuntu vnc.sh  && chmod +x vnc.sh 
chown -R ubuntu mount.sh  && chmod +x mount.sh 
chown -R ubuntu dest_dir_list.txt  && chmod +x dest_dir_list.txt 
chown -R ubuntu source_dir_list.txt  && chmod +x source_dir_list.txt 
chown -R ubuntu zip_extract_forever.sh && chmod +x zip_extract_forever.sh
chown -R ubuntu rclone.conf && chmod +x rclone.conf 
############################### Install rclone dan import config
cd /home/ubuntu/
curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && unzip rclone-current-linux-amd64.zip && cd rclone-*-linux-amd64 &&  cp rclone /usr/bin/ &&  chown root:root /usr/bin/rclone &&  chmod 755 /usr/bin/rclone &&  mkdir -p /usr/local/share/man/man1 &&  cp rclone.1 /usr/local/share/man/man1/ &&  mandb
mv -f rclone.conf /home/ubuntu/.config/rclone/
############################### Mount Gdrive
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
#######################################################################

vncserver
sleep 15
echo sleep 15
vncserver -kill :1
sleep 10
echo sleep 10
cp vnc_unzip_server.txt /home/ubuntu/.vnc/xstartup
mv -f vnc.sh /home/ubuntu/
cd /home/ubuntu/
chmod +x vnc.sh
./vnc.sh start :1
./zip_extract_forever.sh
