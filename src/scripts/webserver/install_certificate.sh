##
## Script to install letsencrypt https certificate
##
##	- This script autorenew letsencrypt certificate as well
##

certbot_autorenew(){
	crontab -l > cron.txt
	#Your command
	echo "0 1 * * * /usr/bin/certbot renew & > /dev/null" >> cron.txt
	crontab cron.txt
	rm cron.txt
}

certbot --nginx
certbot renew --dry-run
certbot_autorenew
