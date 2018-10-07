#!/bin/bash
wvdialconf
gammu -f /var/log/gammulog identify
#datetime=$(date +"%d-%m-%Y %H:%M:%S")
#touch /var/log/check_gammu.log
#UP=$(pgrep gammu-smsd | wc -l)
#UP=$(ps aux | grep gammu-smsd | grep -v grep | wc -l)
#if [ "$UP" -ne 1 ]
#then
#	echo "$datetime - gammu-smsd is down." >> /var/log/check_gammu.log
#	/etc/init.d/gammu-smsd start
#else
#        echo "$datetime - gammu-smsd is well." >> /var/log/check_gammu.log
#fi
#echo "Hi, my name is BosSMS on $datetime" | gammu sendsms TEXT 0903789334
