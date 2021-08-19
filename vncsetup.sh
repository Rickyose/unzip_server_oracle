#!/bin/bash
#by pudh

vncserver
sleep 15
echo sleep 15
vncserver -kill :1
sleep 10
echo sleep 10
vnc_unzip_server.txt -O /home/ubuntu/.vnc/xstartup
mv -f vnc.sh /home/ubuntu/
cd /home/ubuntu/
chmod +x vnc.sh
./vnc.sh start :1
./zip_extract_forever.sh
