# Docker Engine

docker ps 1> /dev/null 2>/dev/null

if [ $? -ne 0 ]; then
	echo "[ status ] Installing Docker Engine"
	sudo
	add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" 2> /dev/null 1> /dev/null
	apt-get update -y 2> /dev/null 1> /dev/null
	apt-get install -y docker-ce 2> /dev/null 1> /dev/null
fi

#Install NGINX
apt-get purge apache2 -y 
apt autoremove -y
apt-get update 
apt-get install -y nginx
ufw app list
ufw allow 'Nginx HTTP'
ufw status
systemctl restart nginx
systemctl status nginx 
apt-get install curl

#Install Certbot
snap install core; sudo snap refresh core
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot

