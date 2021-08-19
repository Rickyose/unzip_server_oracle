#!/bin/bash
#by pudh


cp vnc_unzip_server.txt /home/ubuntu/.vnc/xstartup
sudo -u root mv -f vnc.sh /home/ubuntu/
chmod +x /home/ubuntu/vnc.sh
/home/ubuntu/vnc.sh start :1
