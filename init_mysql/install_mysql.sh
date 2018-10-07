#!/bin/bash

#echo "=> Creating database playSMS in MySQL"
#/mnt/create_db.sh smsdb

/usr/bin/mysqld_safe >/dev/null 2>&1 &

echo "=> Importing database smsdb in MySQL"
mysql -uroot -ppassw0rd smsdb < /mnt/mysql.sql

mysqladmin -uroot -ppassw0rd shutdown

#echo "=> Creating MySQL admin user"
#/mnt/create_mysql_admin_user.sh

exit 0
