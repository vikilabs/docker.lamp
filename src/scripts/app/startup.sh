#!/bin/bash

# This docker container run the following commands on startup/bootup

#Your commands

#ENV APACHE_RUN_USER www-data
#ENV APACHE_RUN_GROUP www-data
#ENV APACHE_LOG_DIR /var/log/apache2
#ENV APACHE_LOCK_DIR /var/lock/apache2
#ENV APACHE_PID_FILE /var/run/apache2.pid

WEB_ROOT="/app_root/app"

chown www-data:www-data $WEB_ROOT    	2>/dev/null 1>/dev/null
chown www-data:www-data ${WEB_ROOT}/*  	2>/dev/null 1>/dev/null
chmod 755 $WEB_ROOT			2>/dev/null 1>/dev/null
chmod 755 ${WEB_ROOT}/* 		2>/dev/null 1>/dev/null

/etc/init.d/mysql stop

#if [ !-f /db_initialized ];then
#    usermod -d /var/lib/mysql/ mysql
#    cp -arf /var/lib/mysql_bkup/* /var/lib/mysql/
#    usermod -d /var/lib/mysql/ mysql
#    touch /db_initialized
#fi

/etc/init.d/mysql start

apache_setup(){
	rm /etc/apache2/sites-available/000-default.conf 2> /dev/null 1> /dev/null
	rm /etc/apache2/sites-available/000-default.conf 2> /dev/null 1> /dev/null
	rm /etc/apache2/sites-available/default-ssl.conf 2> /dev/null 1> /dev/null
	
	cp /app_root/configs/docker_apache.conf /etc/apache2/sites-enabled/default.conf
	a2enmod rewrite
	/etc/init.d/apache2 restart
}

nginx_setup(){
	cp /app_root/configs/docker_nginx.conf /etc/nginx/conf.d/default.conf
	/etc/init.d/nginx stop
  	/etc/init.d/nginx start	
}

#nginx_setup
apache_setup

/bin/bash


