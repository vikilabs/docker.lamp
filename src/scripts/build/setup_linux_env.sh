setup_env(){
a2enmod rewrite headers expires ssl http2 
#service apache2 restart
/etc/init.d/apache2 stop
rm /etc/apache2/sites-enabled/000-default.conf
#rm -rf /var/lib/mysql
#/etc/init.d/mysql stop
#mv /var/lib/mysql /var/lib/mysql_bkup
}

setup_env
