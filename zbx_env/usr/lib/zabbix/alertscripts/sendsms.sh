#!/bin/sh

HOME=/etc
PATH=/bin:/sbin:/usr/bin:/usr/sbin
MOBILE_NUMBER=`echo "$1" | sed s#\s##`
# Send it
### echo "$2"  |  ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 22122 -i /mnt/id_rsa root@192.168.1.101 "/usr/bin/sudo /usr/bin/gammu-smsd-inject TEXT '${MOBILE_NUMBER}'"
echo "$2"  |  ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 22122 -i /mnt/id_rsa root@192.168.1.101 "/usr/bin/sudo /usr/bin/gammu-smsd-inject TEXT 0903789334"
######################################
#echo "$2"  | /usr/bin/sudo /usr/bin/gammu --sendsms TEXT "${MOBILE_NUMBER}"
#echo "$2"  | ssh -p 22122 -i /var/lib/zabbix/ssh_keys/id_rsa root@192.168.1.101 "/usr/bin/sudo /usr/bin/gammu --sendsms TEXT '${MOBILE_NUMBER}'"
### This is Test with gammu ###
#echo "from sshkey"  | ssh -p 22122 -i /var/lib/zabbix/ssh_keys/id_rsa root@192.168.1.101 "/usr/bin/sudo /usr/bin/gammu --sendsms TEXT 0903789334"
####################
exit 0
