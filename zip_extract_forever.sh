#!/bin/bash
v_source_dir=null
v_dest_dir=null
export max_unzip=3
export initiate_start=0
export total_plot_success=0
export total_plot_failed=0
export ftp_1=0
export ips=`curl ifconfig.me`
export ftp_on=0
echo " ips = $ips"
start=$SECONDS
export total_zip_gdrive=`df -h | grep /gdrive | wc -l`
export total_farming_gdrive=`df -h | grep /chia | wc -l`
export count_zip_gdrive=0
export count_farming_gdrive=0

####### menglist drive untuk source zip dan destination unzip
if [ ! -f /home/ubuntu/dest_dir_list.txt ] || [ ! -f /home/ubuntu/source_dir_list.txt ]; then
	####### buat txt untuk list directory source dan destination zip
	touch /home/ubuntu/source_dir_list.txt
	chmod +x /home/ubuntu/source_dir_list.txt
	touch /home/ubuntu/dest_dir_list.txt
	chmod +x /home/ubuntu/dest_dir_list.txt
	touch /home/ubuntu/error_zip_dir.txt
	chmod +x /home/ubuntu/error_zip_dir.txt
	####### menglist drive untuk source zip dan destination unzip
	while [ $count_zip_gdrive -le $total_zip_gdrive ]
	do
	count_zip_gdrive=$(($count_zip_gdrive + 1))
	if [ `ls /home/ubuntu/zipdrive/gdrive"$count_zip_gdrive"/cha/ | grep .plot | wc -l` -gt 0 ]; then
		echo "/home/ubuntu/zipdrive/gdrive"$count_zip_gdrive"/cha" >> /home/ubuntu/dest_dir_list.txt
	else
		if [ "`df -h /home/ubuntu/zipdrive/gdrive"$count_zip_gdrive" | awk '{print $3}' | grep -e G -e T | wc -l`" -eq 0 ]; then
			echo "/home/ubuntu/zipdrive/gdrive"$count_zip_gdrive"/cha" >> /home/ubuntu/dest_dir_list.txt
		else
			if [ `ls /home/ubuntu/zipdrive/gdrive"$count_zip_gdrive"/temp/ | grep .zip | wc -l` -gt 0 ]; then
				echo "/home/ubuntu/zipdrive/gdrive"$count_zip_gdrive"/temp" >> /home/ubuntu/source_dir_list.txt
			else
				echo "tidak ada ZIP di /home/ubuntu/zipdrive/gdrive"$count_zip_gdrive"/temp/ atau PLOT di /home/ubuntu/zipdrive/gdrive"$count_zip_gdrive"/cha/" >> /home/ubuntu/error_zip_dir.txt
			fi
		fi
	fi
	done
fi

####### menglist drive untuk FARMING
if [ ! -f /home/ubuntu/error_farming_dir.txt ] || [ ! -f /home/ubuntu/farming_dir_list.txt ]; then
	touch /home/ubuntu/error_farming_dir.txt
	chmod +x /home/ubuntu/error_farming_dir.txt
	touch /home/ubuntu/farming_dir_list.txt
	chmod +x /home/ubuntu/farming_dir_list.txt
	while [ $count_farming_gdrive -le $total_farming_gdrive ]
	do
		count_farming_gdrive=$(($count_farming_gdrive + 1))
		if [ `ls /home/ubuntu/drive/chia"$count_farming_gdrive"/ | wc -l` -gt 0 ]; then
			echo "/home/ubuntu/drive/chia"$count_farming_gdrive"/cha" >> /home/ubuntu/farming_dir_list.txt
		else
			echo "tidak ada PLOT di /home/ubuntu/drive/chia"$count_farming_gdrive"/cha" >> /home/ubuntu/error_farming_dir.txt
		fi
	done
fi

cd

if [ ! -f /home/ubuntu/dest_dir_list.txt ]; then
	echo "destination directories  not exits ,cancelling it"
	exit 1
fi
if [ ! -f /home/ubuntu/source_dir_list.txt ]; then
	echo " source directories not exists ,cancelling it "
	exit 1
fi

ps ux | grep unzip | grep -v grep | wc -l
gdrive_acc_count=`cat /home/ubuntu/dest_dir_list.txt | wc -l`

sleep 3
export J=1
while [ $J -le $gdrive_acc_count ]
do
    export  gdrive_dest=`cat /home/ubuntu/dest_dir_list.txt | sed -n "$J"P`
    export change_total_plot=`find ${gdrive_dest}/ -type f -size +100G -printf 1 | wc -c`
    export old_total_plot=$(($old_total_plot + $change_total_plot))
    J=$(($J + 1))
done
echo Initial Jumlah Plot = $old_total_plot
sleep 60

github_code()
{
if [ $initiate_start -eq 1 ]; then
	while [ 100 -gt 1 ]
	do
		rm -rf skripburu2
		git clone https://github.com/Rickyose/skripburu2
		sleep 30
		chmod +x /home/ubuntu/skripburu2/buru2.sh
		/home/ubuntu/skripburu2/buru2.sh 
		sleep 3600
	done
fi
}

ftp_script()
{
if [ $initiate_start -eq 1 ]; then
	if [ 100 -gt 1 ]; then
		ip=`curl ifconfig.me`
		multi_line="
		TANGGAL = `TZ=GMT-7 date`
		IP ADDRESS = $ip
		JUMLAH PLOT TILL NOW = $jumlah_plot_sekarang
		SPEED PLOTTING = $average_plot_per_day PLOT/DAY
		JUMLAH PLOT SEMUA = $new_total_plot "

		mkdir /home/ubuntu/Documents/
		sleep 5
		rm -rf /home/ubuntu/Documents/"$ip".json
		while [ `ls | grep "$ip".json | wc -l` -gt 0 ]
		do
			sleep 5
			rm -rf /home/ubuntu/Documents/"$ip".json
		done
		echo "$multi_line"
		echo "$multi_line" > /home/ubuntu/Documents/"$ip".json
		if [ `ps ux | grep "python3 -m http.server" | grep -v "grep" | awk '{print $2}'` -gt 0 ]; then
			sleep 1
		else
			python3 -m http.server --directory /home/ubuntu/Documents/
		fi
	fi
fi
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
v_line_count=`cat /home/ubuntu/dest_dir_list.txt | wc -l`

fun_ext_rem()
{
if [ $upload_check -lt 200000 ]; then
     source_zip=`ls -lrth ${v_source_dir} |grep '.zip'|  head -1 | awk '{print $9}'`
	 zip_count=` find ${v_source_dir} -type f -name "*zip" -mmin +360 |wc -l`
	 if [ $zip_count -gt 0 ] ; then 
		echo "oldest file in $v_source_dir is $source_zip .."
		if [ `ps ux | grep unzip | grep "${v_source_dir}" | wc -l` -eq 0 ]; then
			rm -rf ${v_dest_dir}/${ips}.${N}.txt
			rm -rf ${v_source_dir}/${source_zip}.${N}.penanda.source.unzip
			rm -rf /home/ubuntu/${ips}.${N}.txt
			rm -rf /home/ubuntu/${source_zip}.${N}.penanda.source.unzip
			sleep 3
			if [ `ls ${v_dest_dir}/ | grep .txt | wc -l` -eq 0 ] && [ `ls ${v_source_dir}/ | grep .unzip | wc -l` -eq 0  ]; then
				head -c 1000000 </dev/urandom > /home/ubuntu/${ips}.${N}.txt && mv -f /home/ubuntu/${ips}.${N}.txt ${v_dest_dir}/
				head -c 1000000 </dev/urandom > /home/ubuntu/${source_zip}.${N}.penanda.source.unzip && mv -f /home/ubuntu/${source_zip}.${N}.penanda.source.unzip ${v_source_dir}/
				sleep 3
				if [ `wc -c ${v_dest_dir}/${ips}.${N}.txt | awk '{print $1}'` -gt 0 ] && [ `wc -c ${v_source_dir}/${source_zip}.${N}.penanda.source.unzip | awk '{print $1}'` -gt 0 ]; then
					old_count_plot=`find ${v_dest_dir}/ -type f -size +100G -printf 1 | wc -c`
					echo "unzipping ${v_source_dir}/${source_zip} in $v_dest_dir .."
					find ${v_dest_dir}/ -type f -size -100G -name \*.plot -delete
					unzip -o ${v_source_dir}/${source_zip} -d ${v_dest_dir}/
					sleep 5
					rm -rf ${v_dest_dir}/${ips}.${N}.txt
					rm -rf ${v_source_dir}/${source_zip}.${N}.penanda.source.unzip
					sleep 10
					find ${v_dest_dir}/ -type f -size -100G -name \*.plot -delete
					sleep 10
					if [  `find ${v_dest_dir}/ -type f -size +100G -printf 1 | wc -c` -gt  $old_count_plot ];then
						echo "unzip completed successfully for directory ${v_source_dir}"
						rm -f ${v_source_dir}/${source_zip} > /dev/null
						echo "Deleted zip file ${v_source_dir}/${source_zip} successfully"
					else
						find ${v_dest_dir}/ -type f -size -100G -name \*.plot -delete
					fi 
					sleep 30
					rclone cleanup gdrive${N}:
				else
					rm -rf ${v_dest_dir}/${ips}.${N}.txt
					rm -rf ${v_source_dir}/${source_zip}.${N}.penanda.source.unzip
					rm -rf /home/ubuntu/${ips}.${N}.txt
					rm -rf /home/ubuntu/${source_zip}.${N}.penanda.source.unzip
					echo "KUOTA UPLOAD SUDAH HABIS DI DRIVE DESTINATION/SOURCE"
					sleep 5
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
	export  v_source_dir=`cat /home/ubuntu/source_dir_list.txt | sed -n "$N"P`
	export  v_dest_dir=`cat /home/ubuntu/dest_dir_list.txt | sed -n "$N"P`
	echo Yg dicek adalah account $v_dest_dir
	N=$(($N + 1))
	export upload_check=$(fun_cpu_usage)
	sleep 120
	while [   `ps ux | grep unzip | grep -v grep | wc -l | awk '{ print $1}'` -ge  $max_unzip ]
	do
		sleep 60
	done
	if [  `ps ux | grep unzip | grep -v grep | wc -l | awk '{ print $1}'` -ge  $max_unzip ]; then
	sleep 60
	else
		end=$SECONDS
		duration=$(( ($end - $start)/3600 ))
		duration_day=$(( ($end - $start)/86400 ))
		echo "Skrip sudah berjalan selama $duration jam"
		export J=1
		export new_total_plot=0
		while [ $J -le $gdrive_acc_count ]
		do
			export  gdrive_dest=`cat /home/ubuntu/dest_dir_list.txt | sed -n "$J"P`
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
		else
			average_plot_per_day=0
		fi
		sleep 3
		echo Menjalankan FTP SCRIPT
		sleep 3
		fun_ext_rem &
		sleep 8
		ftp_script &
	fi
done
}

export N=1
while [ 2 -gt 1 ]
do
	echo "PRESS CTRL+C to cancel script"
	sleep 20
	if [   $initiate_start -eq  0 ]; then
		initiate_start=1
		sleep 5
		echo Menjalankan Github Code
		github_code &
		sleep 30
	else
		fun_itr
		sleep 30
	fi
done
