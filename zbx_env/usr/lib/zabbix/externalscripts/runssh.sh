#!/bin/sh

### Install Openssh-client ###
dpkg -s openssh-cleint 2>/dev/null >/dev/null || apt-get -y update
dpkg -s openssh-client 2>/dev/null >/dev/null || apt-get -y install openssh-client
#############################
### apt-get -y update 
### apt-get install -y openssh-client
### To test with gammu-smsd-inject ###
[ ! -f /mnt/id_rsa ] && cp /var/lib/zabbix/ssh_keys/id_rsa /mnt/
[ -f /mnt/id_rsa ] && chmod 600 /mnt/id_rsa
[ -f /mnt/id_rsa ] && chown zabbix /mnt/id_rsa
grep "#includedir" -q /etc/sudoers && sed -i 's/\#includedir/includedir/g' /etc/sudoers
[ ! -f /etc/sudoers.d/zabbix ] && echo "zabbix  ALL = NOPASSWD : ALL" >> /etc/sudoers.d/zabbix

exit 0
