# Docker Engine

docker ps 1> /dev/null 2>/dev/null

if [ $? -ne 0 ]; then
	echo "[ status ] Installing Docker Engine"
	sudo
	add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" 2> /dev/null 1> /dev/null
	apt-get update -y 2> /dev/null 1> /dev/null
	apt-get install -y docker-ce 2> /dev/null 1> /dev/null
fi

apache2 -v 2>/dev/null 1>/dev/null

if [ $? -eq 0 ]; then
	#Install NGINX
	apt-get purge apache2 -y 
	apt-get purge apache2* -y 
	apt autoremove -y
fi

nginx -v 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	echo "[ status ] Installing NGINX"
	apt-get update 
	apt-get install -y nginx
	ufw app list
	ufw allow 'Nginx HTTP'
	ufw status
	systemctl restart nginx
	systemctl status nginx 
fi

curl -h 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	echo "[ status ] Installing CURL"
	apt-get install curl
fi

certbot -h 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	#Install Certbot
	snap install core; sudo snap refresh core
	snap install --classic certbot
	ln -s /snap/bin/certbot /usr/bin/certbot
fi
