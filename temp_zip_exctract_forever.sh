#!/bin/bash
v_source_dir=null
v_dest_dir=null
export max_unzip=4
export initiate_start=0
export total_plot_success=0
export total_plot_failed=0
export ftp_1=0
export ips=`curl ifconfig.me`
export ftp_on=0
echo " ips = $ips"
start=$SECONDS


if [ ! -f dest_dir_list.txt ]; then
	echo "destination directories  not exits ,cancelling it"
	exit 1
fi
if [ ! -f source_dir_list.txt ]; then
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
if [ $initiate_start -eq 1 ]; then
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
		cd /home/ubuntu/Documents/
		rm -rf "$ip".json
		while [ `ls | grep "$ip".json | wc -l` -gt 0 ]
		do
			sleep 5
			rm -rf "$ip".json
		done
		echo "$multi_line"
		echo "$multi_line" > /home/ubuntu/Documents/"$ip".json
		if [ `ps ux | grep "python3 -m http.server" | grep -v "grep" | awk '{print $2}'` -gt 0 ]; then
			sleep 1
			else
			python3 -m http.server
		fi
		sleep 3600
		ftp_on=0
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
v_line_count=`cat dest_dir_list.txt | wc -l`

fun_ext_rem()
{
if [ $upload_check -lt 200000 ]; then
     source_zip="$fun_old_zip_source"
	 no2_oldest_source_zip=`ls -lrth ${v_source_dir} | grep '.zip' |  head -2 | awk '{print $9}' | awk 'FNR == 2 {print}'`
	 zip_count=` find ${v_source_dir} -type f -name "*zip" -mmin +360 |wc -l`
	if [ "$source_zip" = "$no2_oldest_source_zip" ]; then
		 sleep 1
	else
		 if [ $zip_count -gt 0 ] ; then 
			echo "oldest file in $v_source_dir is $source_zip .."
			if [ `ps ux | grep unzip | grep "${v_source_dir}" | wc -l` -eq 0 ] && [ `ls ${v_dest_dir}/ | grep .penanda.source.unzip | wc -l` -eq 1 ]; then
				rm -rf ${v_dest_dir}/${ips}.${N}.txt
				rm -rf ${v_source_dir}/${no2_oldest_source_zip}.${N}.penanda.source.unzip
				rm -rf /home/ubuntu/${ips}.${N}.txt
				rm -rf /home/ubuntu/${no2_oldest_source_zip}.${N}.penanda.source.unzip
				sleep 3
				cd ${v_source_dir}
				if [ `ls ${v_dest_dir}/ | grep .txt | wc -l` -eq 0 ] && [ `ls ${v_source_dir}/ | grep ${no2_oldest_source_zip}.penanda.source.unzip | wc -l` -eq 0  ]; then
					head -c 1000000 </dev/urandom > /home/ubuntu/${ips}.${N}.txt && mv -f /home/ubuntu/${ips}.${N}.txt ${v_dest_dir}/
					head -c 1000000 </dev/urandom > /home/ubuntu/${no2_oldest_source_zip}.${N}.penanda.source.unzip && mv -f /home/ubuntu/${no2_oldest_source_zip}.${N}.penanda.source.unzip ${v_source_dir}/
					sleep 10
					if [ `wc -c ${v_dest_dir}/${ips}.${N}.txt | awk '{print $1}'` -gt 0 ] && [ `wc -c ${v_source_dir}/${no2_oldest_source_zip}.${N}.penanda.source.unzip | awk '{print $1}'` -gt 0 ]; then
						if [ `ls ${v_dest_dir}/ | grep .txt | wc -l` -eq 1 ] && [ `ls ${v_source_dir}/ | grep .unzip | wc -l` -eq 1  ]; then #ini if TRUE maka hanya ada proses .sh ini yg berjalan pada gdrive yg dimaksud
							old_count_plot=`find ${v_dest_dir}/ -type f -size +100G -printf 1 | wc -c`
							echo "unzipping ${v_source_dir}/${source_zip} in $v_dest_dir .."
							cd ${v_dest_dir}
							find . -type f -size -100G -name \*.plot -delete
							unzip -o ${v_source_dir}/${source_zip} 
							sleep 5
							rm -rf ${v_dest_dir}/${ips}.${N}.txt
							rm -rf ${v_source_dir}/${no2_oldest_source_zip}.${N}.penanda.source.unzip
							sleep 10
							find ${v_dest_dir}/ -type f -size -100G -name \*.plot -delete
							sleep 10
							if [  `find ${v_dest_dir}/ -type f -size +100G -printf 1 | wc -c` -gt  $old_count_plot ]; then
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
							rm -rf ${v_dest_dir}/${ips}.${N}.txt
							rm -rf ${v_source_dir}/${no2_oldest_source_zip}.${N}.penanda.source.unzip
						fi
					else
						rm -rf ${v_dest_dir}/${ips}.${N}.txt
						rm -rf ${v_source_dir}/${no2_oldest_source_zip}.${N}.penanda.source.unzip
						rm -rf /home/ubuntu/${ips}.${N}.txt
						rm -rf /home/ubuntu/${no2_oldest_source_zip}.${N}.penanda.source.unzip
						sleep 3
						echo "KUOTA UPLOAD SUDAH HABIS DI DRIVE DESTINATION/SOURCE"
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
	sleep 30
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
		else
			average_plot_per_day=0
		fi
		sleep 3	
		if [ $ftp_on -eq 0 ]; then
			ftp_on=1
			echo Menjalankan FTP SCRIPT
			sleep 30
			fun_ext_rem &
			sleep 3
			ftp_script &
		else
			fun_ext_rem &
			sleep 3
		fi
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
		ftp_script &
		echo Menjalankan FTP SCRIPT
		sleep 30
	else
		fun_itr
		sleep 33
	fi
done
