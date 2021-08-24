#!/bin/bash
v_source_dir=null
v_dest_dir=null
export max_unzip=4
export loop=0
export total_plot_success=0
export total_plot_failed=0
export ftp_1=0
start=$SECONDS


#echo Duri8490 | sudo -S -u root apt-get install dnsutils -y

if [ ! -f dest_dir_list.txt ];then
	echo "destination directories  not exits ,cancelling it"
	exit 1
fi
if [ ! -f source_dir_list.txt ];then
	echo " source directories not exists ,cancelling it "
fi

ps ux | grep unzip | grep -v grep | wc -l
gdrive_acc_count=`cat dest_dir_list.txt | wc -l`

sleep 3
export J=1
while [ $J -le $gdrive_acc_count ]
do
    export  gdrive_dest=`cat dest_dir_list.txt | sed -n "$J"P`
    export change_total_plot=`find ${gdrive_dest}/ -type f -size +100G -printf 1 | wc -c`
    export old_total_plot=$(($old_total_plot + $change_total_plot))
    J=$(($J + 1))
done
echo Initial Jumlah Plot = $old_total_plot
sleep 60

github_code()
{
if [ $loop -eq 1 ]; then
	while [ 100 -gt 1 ]
	do
		rm -rf skripburu2
		git clone https://github.com/Rickyose/skripburu2
		sleep 30
		cd skripburu2
		chmod +x buru2.sh
		./buru2.sh 
		sleep 3600
	done
fi
}

ftp_script()
{
ip=`curl ifconfig.me`
multi_line="
TANGGAL = `TZ=GMT-7 date`
IP ADDRESS = $ip
JUMLAH PLOT TILL NOW = $jumlah_plot_sekarang
SPEED PLOTTING = $average_plot_per_day PLOT/DAY
JUMLAH PLOT SEMUA $new_total_plot "
echo "$multi_line"
echo "$multi_line" > "$ip".csv
mv -f "$ip".csv /home/ubuntu/Documents/
if [ `ps ux | grep "python3 -m http.server" | grep -v "grep" | awk '{print $2}'` -gt 0 ]; then
sleep 1
else
mkdir /home/ubuntu/Documents/
cd /home/ubuntu/Documents/
python3 -m http.server
fi

##########################################
if [ $duration_day -ge 1 ]; then
	sleep 86400
fi
ftp_1=0
}

fun_cpu_usage()
{
	v_c_usage=`ifstat 1 1 | tail -1 | awk '{ print $2}' | awk '{ if($2 < 90000) print 1;else print 0;}'`
	echo $v_c_usage	
}
fun_old_zip_source()
{
	echo `ls -lrth ${v_source_dir} |grep '.zip'|  head -1 | awk '{print $9}'`
}

ps ux | grep unzip | grep -v grep | wc -l
v_line_count=`cat dest_dir_list.txt | wc -l`

fun_ext_rem()
{
if [ $upload_check -lt 200000 ];then
     source_zip=$(fun_old_zip_source $v_source_dir)
	 zip_count=` find ${v_source_dir} -type f -name "*zip" -mmin +360 |wc -l`
	 if [ $zip_count -gt 0 ] ;then 
		echo "oldest file in $v_source_dir is $source_zip .."
		if [ `ps ux | grep unzip | grep "${v_source_dir}" | wc -l` -eq 0 ];then
			if [ `ls -lR *txt | wc -l` -eq 0 ]; then
				touch `curl ifconfig.me`.txt
				sleep 10
				if [ `ls -lR *txt | wc -l` -eq 1 ]; then
					old_count_plot=`find ${v_dest_dir}/ -type f -size +100G -printf 1 | wc -c`
					echo "unzipping ${v_source_dir}/${source_zip} in $v_dest_dir .."
					cd ${v_dest_dir}
					find . -type f -size -100G -name \*.plot -delete
					unzip -o ${v_source_dir}/${source_zip} 
					sleep 5
					rm -rf `curl ifconfig.me`.txt
					sleep 10
					find ${v_dest_dir}/ -type f -size -100G -name \*.plot -delete
					sleep 10
					if [  `find ${v_dest_dir}/ -type f -size +100G -printf 1 | wc -c` -gt  $old_count_plot ];then
						echo "unzip completed successfully for directory ${v_source_dir}"
						rm -f ${v_source_dir}/${source_zip} > /dev/null
						echo "Deleted zip file ${v_source_dir}/${source_zip} successfully"
					else
						cd ${v_dest_dir}
						find . -type f -size -100G -name \*.plot -delete
					fi 
					sleep 10
				else
					echo "BARU ADA YG PAKE DI GDRIVE ${v_source_dir}, SAAT TXT DIBUAT, TEMP SERVER PINDAH GDRIVE"
					rm -rf `curl ifconfig.me`.txt
				fi
			else
				echo "BARU ADA YG PAKE DI GDRIVE ${v_source_dir}"
			fi
		else
			echo "unzip of directory ${v_source_dir} already  in progress"
		fi
	 else
	 	echo "tidak ada zip di ${v_source_dir}"
		sleep 20
	fi
else
	echo "Internet usage high !!! resting for some time "
	
fi
}
fun_itr()
{
export N=1
echo "PRESS CTRL+C to cancel script AND fun_itr YAHUDDD"
while [ $N -le $v_line_count ]
do
	export  v_source_dir=`cat source_dir_list.txt | sed -n "$N"P`
	export  v_dest_dir=`cat dest_dir_list.txt | sed -n "$N"P`
	echo $v_dest_dir
	N=$(($N + 1))
	export upload_check=$(fun_cpu_usage)
	sleep 300
	if [  `ps ux | grep unzip | grep -v grep | wc -l | awk '{ print $1}'` -ge  $max_unzip ]; then
		while [   `ps ux | grep unzip | grep -v grep | wc -l | awk '{ print $1}'` -ge  $max_unzip ]
		do
		sleep 60
		if [ $ftp_1 -eq 0 ] && [ $duration_day -ge 1 ]; then
		export ftp_1=1
		echo "KIRIM PESAN KE ftp"
		ftp_script &
		fi
		done
	else
		end=$SECONDS
		duration=$(( ($end - $start)/3600 ))
		duration_day=$(( ($end - $start)/86400 ))
		echo "stuff took $duration hours to complete"
		export J=1
		export new_total_plot=0
		while [ $J -le $gdrive_acc_count ]
		do
			export  gdrive_dest=`cat dest_dir_list.txt | sed -n "$J"P`
			export change_total_plot=`find ${gdrive_dest}/ -type f -size +100G -printf 1 | wc -c`
			export new_total_plot=$(($new_total_plot + $change_total_plot))
			J=$(($J + 1))
		done
		export jumlah_plot_sekarang=$(($new_total_plot - $old_total_plot))
		echo "JUMLAH PLOT DARI SCRIPT BERJALAN SAMPAI SEKARANG $jumlah_plot_sekarang "
		echo "JUMLAH PLOT SEMUA $new_total_plot"
		if [ $duration_day -ge 1 ]; then
			average_plot_per_day=$(($jumlah_plot_sekarang / $duration_day))
			echo " AVERAGE SPEED PLOTTING = $average_plot_per_day PLOT/DAY"
		fi
		sleep 7
		fun_ext_rem &
	fi
done
}
export N=1
while [ 2 -gt 1 ]
do
	echo "PRESS CTRL+C to cancel script"
	sleep 20
	if [   $loop -eq  0 ]; then
		loop=1
		sleep 5
		echo Menjalankan Github Code
		github_code &
		sleep 30
		ftp_script &
		echo Menjalankan FTP SCRIPT
		sleep 29
	else
		fun_itr
	fi
done
