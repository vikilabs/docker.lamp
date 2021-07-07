#!/bin/bash

install_packages()
{
	apt-get update 	-y 1>/dev/null 2>/dev/null
	apt-get install -y apt-utils
	apt-get install -y iputils-ping
	apt-get install -y openssh-server
	apt-get install -y apt-transport-https 
	apt-get install -y lsb-release 
	apt-get install -y logrotate git 
	apt-get install -y curl 
	apt-get install -y vim 
	apt-get install -y net-tools 
	apt-get install -y iputils-ping 

	apt-get install -y  apache2
	#apt-get install  -y nginx

	apt-get install  -y software-properties-common
	apt-get install  -y expect
	apt-get update   -y
	apt-get install  -y libaio1 libaio-dev 
	apt-get update   -y

	ln -fs /usr/share/zoneinfo/UTC /etc/localtime
	apt-get update   -y
	DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

	#MySQL Server - S
	debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
	debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
	apt-get install   -y  mysql-server
	#MySQL Server - E


	#PHP - S
	#LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
	add-apt-repository 	-y ppa:ondrej/php
	apt-get update 		-y
	apt-get install 	-y  php7.4 php7.4-common php7.4-cli php7.4-json php7.4-mbstring php7.4-curl php7.4-mysql php7.4-bcmath php7.4-xml php7.4-gd php7.4-zip 
	#PHP - E


	# Clean package list to save space
	#rm -rf /var/lib/apt/lists/* 

	# Clean package cache to save space
	#apt-get clean
}

install_packages

