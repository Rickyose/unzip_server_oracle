#!/bin/sh

if [ ! -f /home/ubuntu/unzip_server/Raptoreum/tune_set_done.txt ]; then
sudo apt-get install build-essential automake libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev zlib1g-dev libnuma-dev git
git clone https://github.com/WyvernTKC/cpuminer-gr-avx2
cd /home/ubuntu/unzip_server/Raptoreum/cpuminer-gr-avx2/
./build.sh
else
echo sudah intall raptoreum
sleep 5
fi

sudo sysctl -w vm.nr_hugepages=1280
sudo bash /home/ubuntu/unzip_server/Raptoreum/randomx_boost.sh


if [ ! -f /home/ubuntu/unzip_server/Raptoreum/tune_set_done.txt ]; then
  sudo /home/ubuntu/unzip_server/Raptoreum/cpuminer-gr-avx2/cpuminer -t 6 --tune-full -a gr -o stratum+tcp://r-pool.net:3008 -u RU9x5mebSSmeuaZ2HjEACQAMJX3Ajs6HzF
  touch /home/ubuntu/unzip_server/Raptoreum/tune_set_done.txt
else
  sudo /home/ubuntu/unzip_server/Raptoreum/cpuminer-gr-avx2/cpuminer -t 6 -a gr -o stratum+tcp://r-pool.net:3008 -u RU9x5mebSSmeuaZ2HjEACQAMJX3Ajs6HzF
fi
