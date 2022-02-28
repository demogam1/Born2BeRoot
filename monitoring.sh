#!/bin/bash
#information sur l'architecture du system


echo "#Architecture : $(uname -a)"
echo "#CPU physical : $(nproc)" 
echo "#vCPU : $(cat /proc/cpuinfo | grep processor | wc -l)"
echo "#Memory Usage : $(free -m | awk 'FNR == 2 {printf("%d/%dMB (%.2f%%)\n"),$3,$2,$3/$2*100}')"
echo "#Disk Usage : $(df -h | awk 'FNR == 4 {printf("%.1f/%.1fGb (%.2f%%)\n"),$3,$2,$3/$2*100}')"
echo "#CPU load: $(mpstat | awk 'FNR == 3 {printf("%.1f%%"), $4}')"
echo "#Last boot: $(who -b | awk '{print $3, $4}')"
lvm=$(lsblk | grep 'lvm' | wc -l)
if [ "$lvm" -gt 0 ]
then
	echo "#LVM use: yes"
else
	echo "#LVM use: no"
fi
echo "#Connexions TCP :           "
echo "#User log: $(w | awk 'FNR == 1{print$5}')"
echo "#Network: $(/sbin/ifconfig | grep inet| awk 'FNR == 1{print$2}') $(/sbin/ifconfig | grep ether| awk 'FNR== 1{printf("(%s)", $2)}')"
echo "#Sudo : $(grep -i command /var/log/sudo/sudo.log | wc -l) cmd"
exit 0
