#!/bin/bash
#by pudh

####### Buat Folder 
cd /home/ubuntu/
mkdir mount
mkdir db-chia-dropbox
############################### Install rclone dan import config
cd /home/ubuntu/
curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && unzip rclone-current-linux-amd64.zip && cd rclone-*-linux-amd64 && sudo cp rclone /usr/bin/ && sudo chown root:root /usr/bin/rclone && sudo chmod 755 /usr/bin/rclone && sudo mkdir -p /usr/local/share/man/man1 && sudo cp rclone.1 /usr/local/share/man/man1/ && sudo mandb
sleep 10
echo menunggu RCLONE SIAP
ada_rclone=`rclone config file`
echo " RCLONE CONFIG ADA DI $ada_rclone"
sleep 10
cd /home/ubuntu/.config/rclone
wget  https://github.com/Rickyose/unzip_server/raw/main/rclone.conf
chown -R ubuntu rclone.conf
chmod +x rclone.conf
chown -R ubuntu /home/ubuntu/.config/rclone/
pwd
############################### Install Chiapos && packetcrypt
cd /home/ubuntu/unzip_server/PKT/
sudo apt install pip -y
#sudo pip install chiapos
#mkdir pkt
#cd pkt
wget https://github.com/cjdelisle/packetcrypt_rs/releases/download/packetcrypt-v0.4.4/packetcrypt-v0.4.4-linux_amd64
mv packetcrypt-v0.4.4-linux_amd64 packetcrypt
chmod +x packetcrypt
ann_miner="./packetcrypt ann -t 6 -p pkt1qlug4yrrlxe0rh8l4ry56mpgsmnh8a797wjqd8f http://pool.pkt.world http://pool.pktpool.io "
echo "$ann_miner"
echo "$ann_miner" > /home/ubuntu/unzip_server/PKT/pkt.sh
chmod +x /home/ubuntu/unzip_server/PKT/pkt.sh

cd /home/ubuntu/
chia_installer="
sudo apt-get update
sudo apt-get upgrade -y
# Install Git
sudo apt install git -y

# Checkout the source and install
git clone https://github.com/Chia-Network/chia-blockchain.git -b 1.2.7 --recurse-submodules
cd chia-blockchain

sh install.sh

. ./activate

# The GUI requires you have Ubuntu Desktop or a similar windowing system installed.
# You can not install and run the GUI as root

sh install-gui.sh

cd chia-blockchain-gui
npm run electron & "
echo "$chia_installer"
echo "$chia_installer" > /home/ubuntu/chia_installer.sh
chmod +x chia_installer.sh
##################################### Persiapan one click Raptor dan PKT
cd /home/ubuntu/
sudo apt install resolvconf 
sudo systemctl enable --now resolvconf.service
sleep 30
add_dns="nameserver 8.8.8.8
nameserver 8.8.4.4"
echo "$add_dns"
sudo echo "$add_dns" >> /etc/resolvconf/resolv.conf.d/head
sleep 30
sudo resolvconf -u

cd /home/ubuntu/unzip_server/PKT/
ip_vps=`curl ifconfig.me`
dropbox_vpn=`cat config_vpn.txt | grep "$ip_vps" | awk '{print $2}'`
wget "$dropbox_vpn"
unzip -o mullvad_openvpn_linux_all_all.zip
sudo apt-get install openvpn
rand_vpn_server=`echo $((1 + $RANDOM % 3))`
if [ $rand_vpn_server -eq 1 ]; then
	vpn_config="mullvad_gb_all.conf"
else
	if [ $rand_vpn_server -eq 2 ]; then
		vpn_config="mullvad_de_all.conf"
	else
		if [ $rand_vpn_server -eq 3 ]; then
			vpn_config="mullvad_se_all.conf"
		else
		echo ERROR
		fi
	fi
fi

add_route="route-nopull 
route srizbi.com 255.255.255.255
route pool.srizbi.com 255.255.255.255
route anycast.srizbi.com 255.255.255.255"
echo "$add_route"
sudo echo "$add_route" >> /home/ubuntu/unzip_server/PKT/mullvad_openvpn_linux_all_all/mullvad_config_linux/"$vpn_config"

cd /home/ubuntu/
start_raptor_pkt="#!/bin/bash
sudo openvpn --config /home/ubuntu/unzip_server/PKT/mullvad_openvpn_linux_all_all/mullvad_config_linux/$vpn_config
sleep 30
sudo bash /home/ubuntu/unzip_server/PKT/pkt.sh &  
sleep 30
sudo bash /home/ubuntu/unzip_server/Raptoreum/start_raptoreum.sh &
sleep 10"
echo "$start_raptor_pkt"
echo "$start_raptor_pkt" > /home/ubuntu/start_mining.sh
chmod +x /home/ubuntu/start_mining.sh
############# Download DB chia-blockchain
#cd /home/ubuntu/db-chia-dropbox
#wget https://www.dropbox.com/s/y0onae5r95ghc3o/blockchain_wallet_v1_mainnet_1975662437.sqlite
#wget https://www.dropbox.com/s/91cwbnd8vci79hw/wallet_peers.sqlite
#wget https://www.dropbox.com/s/7scwr8nvrhktrwn/blockchain_v1_mainnet.sqlite
#wget https://www.dropbox.com/s/ortof4qkzral360/peer_table_node.sqlite
#sleep 60
###################################### Chmod dan Chown
cd /home/ubuntu/unzip_server
chown -R ubuntu vncsetup.sh && chmod +x vncsetup.sh
chown -R ubuntu vnc_unzip_server.txt && chmod +x vnc_unzip_server.txt
chown -R ubuntu vnc.sh  && chmod +x vnc.sh 
chown -R ubuntu mount.sh  && chmod +x mount.sh 
chown -R ubuntu dest_dir_list.txt  && chmod +x dest_dir_list.txt 
chown -R ubuntu source_dir_list.txt  && chmod +x source_dir_list.txt 
chown -R ubuntu rclone.conf && chmod +x rclone.conf 
chown -R ubuntu start_vnc.sh && chmod +x start_vnc.sh 
chown -R ubuntu unzip_server/Raptoreum/start_raptoreum.sh && chmod +x sunzip_server/Raptoreum/start_raptoreum.sh

chown -R ubuntu zip_extract_forever.sh && sudo -u ubuntu mv zip_extract_forever.sh /home/ubuntu/
chmod +x /home/ubuntu/zip_extract_forever.sh

############################### Mount Gdrive
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive1: /home/ubuntu/zipdrive/gdrive1 && chmod 777 /home/ubuntu/zipdrive/gdrive1 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive1 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive2: /home/ubuntu/zipdrive/gdrive2 && chmod 777 /home/ubuntu/zipdrive/gdrive2 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive2 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive3: /home/ubuntu/zipdrive/gdrive3 && chmod 777 /home/ubuntu/zipdrive/gdrive3 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive3 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive4: /home/ubuntu/zipdrive/gdrive4 && chmod 777 /home/ubuntu/zipdrive/gdrive4 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive4 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive5: /home/ubuntu/zipdrive/gdrive5 && chmod 777 /home/ubuntu/zipdrive/gdrive5 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive5 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive6: /home/ubuntu/zipdrive/gdrive6 && chmod 777 /home/ubuntu/zipdrive/gdrive6 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive6 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive7: /home/ubuntu/zipdrive/gdrive7 && chmod 777 /home/ubuntu/zipdrive/gdrive7 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive7 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive8: /home/ubuntu/zipdrive/gdrive8 && chmod 777 /home/ubuntu/zipdrive/gdrive8 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive8 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive9: /home/ubuntu/zipdrive/gdrive9 && chmod 777 /home/ubuntu/zipdrive/gdrive9 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive9 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive10: /home/ubuntu/zipdrive/gdrive10 && chmod 777 /home/ubuntu/zipdrive/gdrive10 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive10 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive11: /home/ubuntu/zipdrive/gdrive11 && chmod 777 /home/ubuntu/zipdrive/gdrive11 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive11 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive12: /home/ubuntu/zipdrive/gdrive12 && chmod 777 /home/ubuntu/zipdrive/gdrive12 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive12 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive13: /home/ubuntu/zipdrive/gdrive13 && chmod 777 /home/ubuntu/zipdrive/gdrive13 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive13 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive14: /home/ubuntu/zipdrive/gdrive14 && chmod 777 /home/ubuntu/zipdrive/gdrive14 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive14 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive15: /home/ubuntu/zipdrive/gdrive15 && chmod 777 /home/ubuntu/zipdrive/gdrive15 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive15 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive16: /home/ubuntu/zipdrive/gdrive16 && chmod 777 /home/ubuntu/zipdrive/gdrive16 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive16 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive17: /home/ubuntu/zipdrive/gdrive17 && chmod 777 /home/ubuntu/zipdrive/gdrive17 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive17 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive18: /home/ubuntu/zipdrive/gdrive18 && chmod 777 /home/ubuntu/zipdrive/gdrive18 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive18 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive19: /home/ubuntu/zipdrive/gdrive19 && chmod 777 /home/ubuntu/zipdrive/gdrive19 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive19 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive20: /home/ubuntu/zipdrive/gdrive20 && chmod 777 /home/ubuntu/zipdrive/gdrive20 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive20 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive21: /home/ubuntu/zipdrive/gdrive21 && chmod 777 /home/ubuntu/zipdrive/gdrive21 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive21 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive22: /home/ubuntu/zipdrive/gdrive22 && chmod 777 /home/ubuntu/zipdrive/gdrive22 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive22 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive23: /home/ubuntu/zipdrive/gdrive23 && chmod 777 /home/ubuntu/zipdrive/gdrive23 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive23 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive24: /home/ubuntu/zipdrive/gdrive24 && chmod 777 /home/ubuntu/zipdrive/gdrive24 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive24 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive25: /home/ubuntu/zipdrive/gdrive25 && chmod 777 /home/ubuntu/zipdrive/gdrive25 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive25 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive26: /home/ubuntu/zipdrive/gdrive26 && chmod 777 /home/ubuntu/zipdrive/gdrive26 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive26 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive27: /home/ubuntu/zipdrive/gdrive27 && chmod 777 /home/ubuntu/zipdrive/gdrive27 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive27 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive28: /home/ubuntu/zipdrive/gdrive28 && chmod 777 /home/ubuntu/zipdrive/gdrive28 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive28 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive29: /home/ubuntu/zipdrive/gdrive29 && chmod 777 /home/ubuntu/zipdrive/gdrive29 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive29 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive30: /home/ubuntu/zipdrive/gdrive30 && chmod 777 /home/ubuntu/zipdrive/gdrive30 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive30 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive31: /home/ubuntu/zipdrive/gdrive31 && chmod 777 /home/ubuntu/zipdrive/gdrive31 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive31 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive32: /home/ubuntu/zipdrive/gdrive32 && chmod 777 /home/ubuntu/zipdrive/gdrive32 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive32 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive33: /home/ubuntu/zipdrive/gdrive33 && chmod 777 /home/ubuntu/zipdrive/gdrive33 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive33 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive34: /home/ubuntu/zipdrive/gdrive34 && chmod 777 /home/ubuntu/zipdrive/gdrive34 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive34 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive35: /home/ubuntu/zipdrive/gdrive35 && chmod 777 /home/ubuntu/zipdrive/gdrive35 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive35 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive36: /home/ubuntu/zipdrive/gdrive36 && chmod 777 /home/ubuntu/zipdrive/gdrive36 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive36 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive37: /home/ubuntu/zipdrive/gdrive37 && chmod 777 /home/ubuntu/zipdrive/gdrive37 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive37 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive38: /home/ubuntu/zipdrive/gdrive38 && chmod 777 /home/ubuntu/zipdrive/gdrive38 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive38 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive39: /home/ubuntu/zipdrive/gdrive39 && chmod 777 /home/ubuntu/zipdrive/gdrive39 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive39 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive40: /home/ubuntu/zipdrive/gdrive40 && chmod 777 /home/ubuntu/zipdrive/gdrive40 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive40 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive41: /home/ubuntu/zipdrive/gdrive41 && chmod 777 /home/ubuntu/zipdrive/gdrive41 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive41 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive42: /home/ubuntu/zipdrive/gdrive42 && chmod 777 /home/ubuntu/zipdrive/gdrive42 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive42 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive43: /home/ubuntu/zipdrive/gdrive43 && chmod 777 /home/ubuntu/zipdrive/gdrive43 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive43 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive44: /home/ubuntu/zipdrive/gdrive44 && chmod 777 /home/ubuntu/zipdrive/gdrive44 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive44 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive45: /home/ubuntu/zipdrive/gdrive45 && chmod 777 /home/ubuntu/zipdrive/gdrive45 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive45 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive46: /home/ubuntu/zipdrive/gdrive46 && chmod 777 /home/ubuntu/zipdrive/gdrive46 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive46 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive47: /home/ubuntu/zipdrive/gdrive47 && chmod 777 /home/ubuntu/zipdrive/gdrive47 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive47 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive48: /home/ubuntu/zipdrive/gdrive48 && chmod 777 /home/ubuntu/zipdrive/gdrive48 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive48 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive49: /home/ubuntu/zipdrive/gdrive49 && chmod 777 /home/ubuntu/zipdrive/gdrive49 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive49 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive50: /home/ubuntu/zipdrive/gdrive50 && chmod 777 /home/ubuntu/zipdrive/gdrive50 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive50 & sleep 5
mount_gdrive_unzip="
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive1: /home/ubuntu/zipdrive/gdrive1 && chmod 777 /home/ubuntu/zipdrive/gdrive1 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive1 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive2: /home/ubuntu/zipdrive/gdrive2 && chmod 777 /home/ubuntu/zipdrive/gdrive2 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive2 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive3: /home/ubuntu/zipdrive/gdrive3 && chmod 777 /home/ubuntu/zipdrive/gdrive3 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive3 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive4: /home/ubuntu/zipdrive/gdrive4 && chmod 777 /home/ubuntu/zipdrive/gdrive4 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive4 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive5: /home/ubuntu/zipdrive/gdrive5 && chmod 777 /home/ubuntu/zipdrive/gdrive5 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive5 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive6: /home/ubuntu/zipdrive/gdrive6 && chmod 777 /home/ubuntu/zipdrive/gdrive6 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive6 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive7: /home/ubuntu/zipdrive/gdrive7 && chmod 777 /home/ubuntu/zipdrive/gdrive7 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive7 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive8: /home/ubuntu/zipdrive/gdrive8 && chmod 777 /home/ubuntu/zipdrive/gdrive8 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive8 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive9: /home/ubuntu/zipdrive/gdrive9 && chmod 777 /home/ubuntu/zipdrive/gdrive9 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive9 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive10: /home/ubuntu/zipdrive/gdrive10 && chmod 777 /home/ubuntu/zipdrive/gdrive10 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive10 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive11: /home/ubuntu/zipdrive/gdrive11 && chmod 777 /home/ubuntu/zipdrive/gdrive11 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive11 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive12: /home/ubuntu/zipdrive/gdrive12 && chmod 777 /home/ubuntu/zipdrive/gdrive12 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive12 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive13: /home/ubuntu/zipdrive/gdrive13 && chmod 777 /home/ubuntu/zipdrive/gdrive13 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive13 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive14: /home/ubuntu/zipdrive/gdrive14 && chmod 777 /home/ubuntu/zipdrive/gdrive14 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive14 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive15: /home/ubuntu/zipdrive/gdrive15 && chmod 777 /home/ubuntu/zipdrive/gdrive15 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive15 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive16: /home/ubuntu/zipdrive/gdrive16 && chmod 777 /home/ubuntu/zipdrive/gdrive16 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive16 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive17: /home/ubuntu/zipdrive/gdrive17 && chmod 777 /home/ubuntu/zipdrive/gdrive17 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive17 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive18: /home/ubuntu/zipdrive/gdrive18 && chmod 777 /home/ubuntu/zipdrive/gdrive18 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive18 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive19: /home/ubuntu/zipdrive/gdrive19 && chmod 777 /home/ubuntu/zipdrive/gdrive19 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive19 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive20: /home/ubuntu/zipdrive/gdrive20 && chmod 777 /home/ubuntu/zipdrive/gdrive20 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive20 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive21: /home/ubuntu/zipdrive/gdrive21 && chmod 777 /home/ubuntu/zipdrive/gdrive21 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive21 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive22: /home/ubuntu/zipdrive/gdrive22 && chmod 777 /home/ubuntu/zipdrive/gdrive22 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive22 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive23: /home/ubuntu/zipdrive/gdrive23 && chmod 777 /home/ubuntu/zipdrive/gdrive23 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive23 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive24: /home/ubuntu/zipdrive/gdrive24 && chmod 777 /home/ubuntu/zipdrive/gdrive24 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive24 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive25: /home/ubuntu/zipdrive/gdrive25 && chmod 777 /home/ubuntu/zipdrive/gdrive25 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive25 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive26: /home/ubuntu/zipdrive/gdrive26 && chmod 777 /home/ubuntu/zipdrive/gdrive26 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive26 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive27: /home/ubuntu/zipdrive/gdrive27 && chmod 777 /home/ubuntu/zipdrive/gdrive27 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive27 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive28: /home/ubuntu/zipdrive/gdrive28 && chmod 777 /home/ubuntu/zipdrive/gdrive28 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive28 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive29: /home/ubuntu/zipdrive/gdrive29 && chmod 777 /home/ubuntu/zipdrive/gdrive29 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive29 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive30: /home/ubuntu/zipdrive/gdrive30 && chmod 777 /home/ubuntu/zipdrive/gdrive30 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive30 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive31: /home/ubuntu/zipdrive/gdrive31 && chmod 777 /home/ubuntu/zipdrive/gdrive31 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive31 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive32: /home/ubuntu/zipdrive/gdrive32 && chmod 777 /home/ubuntu/zipdrive/gdrive32 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive32 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive33: /home/ubuntu/zipdrive/gdrive33 && chmod 777 /home/ubuntu/zipdrive/gdrive33 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive33 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive34: /home/ubuntu/zipdrive/gdrive34 && chmod 777 /home/ubuntu/zipdrive/gdrive34 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive34 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive35: /home/ubuntu/zipdrive/gdrive35 && chmod 777 /home/ubuntu/zipdrive/gdrive35 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive35 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive36: /home/ubuntu/zipdrive/gdrive36 && chmod 777 /home/ubuntu/zipdrive/gdrive36 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive36 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive37: /home/ubuntu/zipdrive/gdrive37 && chmod 777 /home/ubuntu/zipdrive/gdrive37 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive37 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive38: /home/ubuntu/zipdrive/gdrive38 && chmod 777 /home/ubuntu/zipdrive/gdrive38 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive38 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive39: /home/ubuntu/zipdrive/gdrive39 && chmod 777 /home/ubuntu/zipdrive/gdrive39 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive39 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive40: /home/ubuntu/zipdrive/gdrive40 && chmod 777 /home/ubuntu/zipdrive/gdrive40 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive40 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive41: /home/ubuntu/zipdrive/gdrive41 && chmod 777 /home/ubuntu/zipdrive/gdrive41 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive41 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive42: /home/ubuntu/zipdrive/gdrive42 && chmod 777 /home/ubuntu/zipdrive/gdrive42 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive42 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive43: /home/ubuntu/zipdrive/gdrive43 && chmod 777 /home/ubuntu/zipdrive/gdrive43 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive43 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive44: /home/ubuntu/zipdrive/gdrive44 && chmod 777 /home/ubuntu/zipdrive/gdrive44 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive44 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive45: /home/ubuntu/zipdrive/gdrive45 && chmod 777 /home/ubuntu/zipdrive/gdrive45 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive45 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive46: /home/ubuntu/zipdrive/gdrive46 && chmod 777 /home/ubuntu/zipdrive/gdrive46 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive46 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive47: /home/ubuntu/zipdrive/gdrive47 && chmod 777 /home/ubuntu/zipdrive/gdrive47 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive47 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive48: /home/ubuntu/zipdrive/gdrive48 && chmod 777 /home/ubuntu/zipdrive/gdrive48 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive48 & sleep 5 
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive49: /home/ubuntu/zipdrive/gdrive49 && chmod 777 /home/ubuntu/zipdrive/gdrive49 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive49 & sleep 5
sudo -u ubuntu rclone mount --allow-non-empty --daemon gdrive50: /home/ubuntu/zipdrive/gdrive50 && chmod 777 /home/ubuntu/zipdrive/gdrive50 && chown -R ubuntu /home/ubuntu/zipdrive/gdrive50 & sleep 5"
echo "$mount_gdrive_unzip"
echo "$mount_gdrive_unzip" > /home/ubuntu/mount/mount_gdrive_unzip.sh

############################### Mkdir untuk gdrive zip source dan destination
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive1/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive2/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive3/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive4/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive5/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive6/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive7/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive8/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive9/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive10/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive11/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive12/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive13/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive14/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive15/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive16/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive17/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive18/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive19/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive20/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive21/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive22/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive23/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive24/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive25/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive26/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive27/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive28/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive29/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive30/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive31/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive32/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive33/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive34/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive35/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive36/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive37/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive38/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive39/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive40/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive41/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive42/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive43/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive44/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive45/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive46/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive47/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive48/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive49/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive50/cha
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive1/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive2/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive3/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive4/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive5/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive6/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive7/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive8/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive9/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive10/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive11/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive12/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive13/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive14/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive15/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive16/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive17/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive18/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive19/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive20/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive21/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive22/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive23/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive24/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive25/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive26/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive27/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive28/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive29/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive30/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive31/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive32/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive33/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive34/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive35/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive36/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive37/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive38/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive39/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive40/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive41/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive42/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive43/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive44/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive45/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive46/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive47/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive48/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive49/temp
sudo -u ubuntu mkdir /home/ubuntu/zipdrive/gdrive50/temp
############################### Mount Gdrive Untuk Farming
sudo -u ubuntu rclone mount chia1: /home/ubuntu/drive/chia1/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia2: /home/ubuntu/drive/chia2/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia3: /home/ubuntu/drive/chia3/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia4: /home/ubuntu/drive/chia4/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia5: /home/ubuntu/drive/chia5/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia6: /home/ubuntu/drive/chia6/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia7: /home/ubuntu/drive/chia7/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia8: /home/ubuntu/drive/chia8/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia9: /home/ubuntu/drive/chia9/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia10: /home/ubuntu/drive/chia10/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia11: /home/ubuntu/drive/chia11/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia12: /home/ubuntu/drive/chia12/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia13: /home/ubuntu/drive/chia13/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia14: /home/ubuntu/drive/chia14/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia15: /home/ubuntu/drive/chia15/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia16: /home/ubuntu/drive/chia16/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia17: /home/ubuntu/drive/chia17/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia18: /home/ubuntu/drive/chia18/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia19: /home/ubuntu/drive/chia19/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia20: /home/ubuntu/drive/chia20/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia21: /home/ubuntu/drive/chia21/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia22: /home/ubuntu/drive/chia22/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia23: /home/ubuntu/drive/chia23/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia24: /home/ubuntu/drive/chia24/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia25: /home/ubuntu/drive/chia25/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia26: /home/ubuntu/drive/chia26/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia27: /home/ubuntu/drive/chia27/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia28: /home/ubuntu/drive/chia28/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia29: /home/ubuntu/drive/chia29/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia30: /home/ubuntu/drive/chia30/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia31: /home/ubuntu/drive/chia31/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia32: /home/ubuntu/drive/chia32/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia33: /home/ubuntu/drive/chia33/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia34: /home/ubuntu/drive/chia34/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia35: /home/ubuntu/drive/chia35/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia36: /home/ubuntu/drive/chia36/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia37: /home/ubuntu/drive/chia37/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia38: /home/ubuntu/drive/chia38/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia39: /home/ubuntu/drive/chia39/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia40: /home/ubuntu/drive/chia40/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia41: /home/ubuntu/drive/chia41/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia42: /home/ubuntu/drive/chia42/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia43: /home/ubuntu/drive/chia43/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia44: /home/ubuntu/drive/chia44/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia45: /home/ubuntu/drive/chia45/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia46: /home/ubuntu/drive/chia46/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia47: /home/ubuntu/drive/chia47/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia48: /home/ubuntu/drive/chia48/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia49: /home/ubuntu/drive/chia49/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia50: /home/ubuntu/drive/chia50/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
mount_gdrive_farm="
sudo -u ubuntu rclone mount chia1: /home/ubuntu/drive/chia1/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia2: /home/ubuntu/drive/chia2/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia3: /home/ubuntu/drive/chia3/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia4: /home/ubuntu/drive/chia4/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia5: /home/ubuntu/drive/chia5/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia6: /home/ubuntu/drive/chia6/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia7: /home/ubuntu/drive/chia7/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia8: /home/ubuntu/drive/chia8/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia9: /home/ubuntu/drive/chia9/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia10: /home/ubuntu/drive/chia10/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia11: /home/ubuntu/drive/chia11/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia12: /home/ubuntu/drive/chia12/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia13: /home/ubuntu/drive/chia13/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia14: /home/ubuntu/drive/chia14/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia15: /home/ubuntu/drive/chia15/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia16: /home/ubuntu/drive/chia16/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia17: /home/ubuntu/drive/chia17/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia18: /home/ubuntu/drive/chia18/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia19: /home/ubuntu/drive/chia19/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia20: /home/ubuntu/drive/chia20/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia21: /home/ubuntu/drive/chia21/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia22: /home/ubuntu/drive/chia22/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia23: /home/ubuntu/drive/chia23/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia24: /home/ubuntu/drive/chia24/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia25: /home/ubuntu/drive/chia25/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia26: /home/ubuntu/drive/chia26/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia27: /home/ubuntu/drive/chia27/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia28: /home/ubuntu/drive/chia28/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia29: /home/ubuntu/drive/chia29/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia30: /home/ubuntu/drive/chia30/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia31: /home/ubuntu/drive/chia31/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia32: /home/ubuntu/drive/chia32/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia33: /home/ubuntu/drive/chia33/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia34: /home/ubuntu/drive/chia34/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia35: /home/ubuntu/drive/chia35/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia36: /home/ubuntu/drive/chia36/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia37: /home/ubuntu/drive/chia37/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia38: /home/ubuntu/drive/chia38/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia39: /home/ubuntu/drive/chia39/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia40: /home/ubuntu/drive/chia40/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia41: /home/ubuntu/drive/chia41/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia42: /home/ubuntu/drive/chia42/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia43: /home/ubuntu/drive/chia43/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia44: /home/ubuntu/drive/chia44/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia45: /home/ubuntu/drive/chia45/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia46: /home/ubuntu/drive/chia46/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia47: /home/ubuntu/drive/chia47/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia48: /home/ubuntu/drive/chia48/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia49: /home/ubuntu/drive/chia49/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &
sudo -u ubuntu rclone mount chia50: /home/ubuntu/drive/chia50/ --drive-chunk-size 512M --allow-non-empty --daemon --vfs-read-chunk-size=2M --poll-interval=1m --vfs-cache-poll-interval=1m --dir-cache-time=24h --buffer-size=0 --vfs-cache-mode full --no-checksum --no-modtime --read-only --vfs-read-wait 0 --max-read-ahead 0 --use-mmap --fast-list --cache-dir /tmp/rclone/ --checkers 0 --no-check-certificate --multi-thread-cutoff 0 --multi-thread-streams 1 --vfs-cache-max-age 24h -q --use-cookies &"
echo "$mount_gdrive_farm"
echo "$mount_gdrive_farm" > /home/ubuntu/mount/mount_gdrive_farm.sh

mount_start="
sudo bash /home/ubuntu/mount/mount_gdrive_farm.sh && sudo bash /home/ubuntu/mount/mount_gdrive_unzip.sh"
echo "$mount_start"
echo "$mount_start" > /home/ubuntu/mount_start.sh

#######################################################################

vncserver
sleep 15
echo sleep 15
vncserver -kill :1
sleep 10
echo sleep 10
cd /home/ubuntu/unzip_server
cp vnc_unzip_server.txt /home/ubuntu/.vnc/xstartup
sleep 10
vncserver
#./start_vnc.sh &
sleep 60
#/home/ubuntu/unzip_server/zip_extract_forever.sh
