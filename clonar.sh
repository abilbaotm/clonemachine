#!/bin/bash
### BEGIN INIT INFO
# Provides:          clonemachine1
# Required-Start:    $syslog
# Required-Stop:     $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Clone machine
# Description:
#
### END INIT INFO

#Start LED
echo "24" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio24/direction

#LED ON
echo "1" > /sys/class/gpio/gpio24/value

while :
do
	#Check memori plugged
	if grep '/dev/sda' /etc/mtab > /dev/null 2>&1; then
		echo "mounted"
		#delay of a second
		sleep 1
		#un mount detected device
		umount /dev/sda*
		#LED OFF
		echo "0" > /sys/class/gpio/gpio24/value
		#Clone image
		dd if=/home/erle/images/PXFmini_ErleBrain2_03_03_2016.img of=/dev/sda bs=8M conv=sync,notrunc,noerror
	else
    		echo "not mounted"
	fi
	#delay
	sleep 1
	#LED blink
	echo "0" > /sys/class/gpio/gpio24/value
	sleep 0.01
	echo "1" > /sys/class/gpio/gpio24/value
done
