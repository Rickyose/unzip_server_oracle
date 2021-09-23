#!/bin/sh

sudo sysctl -w vm.nr_hugepages=2560
sudo bash /home/ubuntu/unzip_server/Raptoreum/enable_1gb_pages.sh
sudo bash /home/ubuntu/unzip_server/Raptoreum/randomx_boost.sh



if [ ! -f /home/ubuntu/tune_set_done.txt ]; then
  sudo /home/ubuntu/unzip_server/Raptoreum/cpuminer-gr-avx2/cpuminer -t 11 --tune-full -a gr -o stratum+tcp://r-pool.net:3008 -u RU9x5mebSSmeuaZ2HjEACQAMJX3Ajs6HzF
  touch /home/ubuntu/tune_set_done.txt
else
  sudo /home/ubuntu/unzip_server/Raptoreum/cpuminer-gr-avx2/cpuminer -t 11 -a gr -o stratum+tcp://r-pool.net:3008 -u RU9x5mebSSmeuaZ2HjEACQAMJX3Ajs6HzF
fi
