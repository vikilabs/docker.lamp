#!/bin/bash

# This docker container run the following commands on startup/bootup

#Your commands

#ENV APACHE_RUN_USER www-data
#ENV APACHE_RUN_GROUP www-data
#ENV APACHE_LOG_DIR /var/log/apache2
#ENV APACHE_LOCK_DIR /var/lock/apache2
#ENV APACHE_PID_FILE /var/run/apache2.pid

chown www-data:www-data /app_root/app   2>/dev/null 1>/dev/null
chown www-data:www-data /app_root/app/* 2>/dev/null 1>/dev/null
chmod 755 /app_root/app		2>/dev/null 1>/dev/null
chmod 755 /app_root/app/* 	2>/dev/null 1>/dev/null

/etc/init.d/mysql stop

#if [ !-f /db_initialized ];then
#    usermod -d /var/lib/mysql/ mysql
#    cp -arf /var/lib/mysql_bkup/* /var/lib/mysql/
#    usermod -d /var/lib/mysql/ mysql
#    touch /db_initialized
#fi

/etc/init.d/mysql start

cp /app_root/configs/avideo.conf /etc/apache2/sites-enabled/avideo.conf
/etc/init.d/apache2 restart
/bin/bash


